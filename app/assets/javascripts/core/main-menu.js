// Distrito Rugby - Diamond Roulette
// Author: Johnny Zapata - @jsamzapata
// Updated: Septiembre 2026

(function() {
  'use strict';

  const CONFIG = {
    rouletteDuration: 900,
    rouletteSteps: 2,
    stepInterval: 200,
    categories: ['stories', 'tournaments', 'clubs', 'players'],
    modalData: {
      stories: {
        title: 'Historias',
        icon: 'fa-book-open',
        text: 'Descubre las historias que hacen grande al rugby. Historias de superación, pasión y comunidad que inspiren a una nueva generación de rugbiers.',
        link: '/stories',
        linkText: 'Ver Historias'
      },
      tournaments: {
        title: 'Torneos',
        icon: 'fa-trophy',
        text: 'Encuentra los próximos torneos y competencias. Sigue el desarrollo de los campeonatos y no te pierdas ningún partido.',
        link: '/game/tournaments',
        linkText: 'Ver Torneos'
      },
      clubs: {
        title: 'Clubes',
        icon: 'fa-users',
        text: 'Explora los clubes de rugby de tu región. Conoce sus categorías, horarios y únete a la comunidad rugbier de la región.',
        link: '/game/clubs',
        linkText: 'Ver Clubes'
      },
      players: {
        title: 'Jugadores',
        icon: 'fa-running',
        text: 'Consulta los perfiles de jugadores destacados. Historial de clubes, posiciones y estadísticas de los mejores rugbiers.',
        link: '/game/players',
        linkText: 'Ver Jugadores'
      }
    }
  };

  // Rutas internas permitidas para highlights/modales (allowlist anti open-redirect/XSS)
  const ALLOWED_LINKS = ['/stories', '/game/tournaments', '/game/clubs', '/game/players'];

  function safeLink(path, fallback) {
    if (ALLOWED_LINKS.indexOf(path) !== -1) return path;
    return fallback || '/';
  }

  let isRouletteActive = false;
  let selectedCategory = null;
  let rouletteInterval = null;
  let autoResetTimeout = null;
  let transitionTimeout = null;
  let rouletteStepCount = 0;
  let rouletteCatIdx = 0;

  // Cache de elementos DOM (se recalcan en init por si Turbo recarga el DOM)
  let cachedContainer = null;
  let cachedQuadrants = null;
  let cachedMenuDRBar = null;
  let isHomePage = false;

  function cacheDOMElements() {
    cachedContainer = document.querySelector('.diamond-container');
    cachedQuadrants = document.querySelectorAll('.quadrant');
    cachedMenuDRBar = document.getElementById('barDR');
    isHomePage = !!cachedContainer;
  }

  function init() {
    cacheDOMElements();
    initDiamond();
    initQuadrants();
    initMenuBar();
  }

  function teardown() {
    if (rouletteInterval) {
      clearInterval(rouletteInterval);
      rouletteInterval = null;
    }
    if (autoResetTimeout) {
      clearTimeout(autoResetTimeout);
      autoResetTimeout = null;
    }
    if (transitionTimeout) {
      clearTimeout(transitionTimeout);
      transitionTimeout = null;
    }
    isRouletteActive = false;
    if (window._drScrollHandler) {
      window.removeEventListener('scroll', window._drScrollHandler);
      window._drScrollHandler = null;
    }
    if (window._drResizeHandler) {
      window.removeEventListener('resize', window._drResizeHandler);
      window._drResizeHandler = null;
    }
  }

  // Turbo puede no estar cargado (no hay turbo_include_tags); por eso se
  // escucha DOMContentLoaded para la carga inicial y turbo:load para
  // navegación. init() es idempotente. teardown evita timers/listeners
  // colgados al navegar fuera del home.
  document.addEventListener('DOMContentLoaded', init);
  document.addEventListener('turbo:load', init);
  document.addEventListener('turbo:before-cache', teardown);
  document.addEventListener('turbo:before-visit', teardown);
  window.addEventListener('pagehide', teardown);

  // === ROMBO ===
  function initDiamond() {
    const diamond = document.querySelector('.diamond');

    if (!diamond) return;

    // Clic en el rombo → ruleta (excepto si es el texto, que abre modal auth)
    if (!diamond._hasHandler) {
      diamond._hasHandler = true;
      diamond.addEventListener('click', function(e) {
        // Si el clic fue sobre el texto, dejar que Bootstrap abra el modal
        const t = e.target && e.target.closest ? e.target.closest('.diamond-text') : null;
        if (t) {
          return;
        }
        e.preventDefault();
        if (!isRouletteActive) {
          startRoulette();
        }
      });
    }
  }

  // === CUADRANTES ===
  function initQuadrants() {
    cachedQuadrants.forEach(function(q) {
      if (q._hasHandler) return;
      q._hasHandler = true;

      // Clic en el cuadrante
      q.addEventListener('click', function(e) {
        // Si el clic fue sobre un link (<a> o .quadrant-label), dejar que navegue
        const linkEl = (e.target && e.target.closest) ? e.target.closest('a') : null;
        if (linkEl) {
          return;
        }
        // Si no fue un link, mostrar modal informativa
        e.preventDefault();
        const category = q.dataset.category;
        showQuadrantModal(category);
      });
    });
  }

  // === MODAL INFORMATIVA DEL CUADRANTE ===
  function showQuadrantModal(category) {
    const data = CONFIG.modalData[category];
    if (!data) return;

    const modal = document.getElementById('quadrantModal');
    if (!modal) return;

    // Actualizar contenido (solo texto + href con allowlist)
    const iconEl = modal.querySelector('.quadrant-modal-icon');
    const titleEl = modal.querySelector('.quadrant-modal-title');
    const textEl = modal.querySelector('.quadrant-modal-text');
    const linkEl = modal.querySelector('.quadrant-modal-link');
    if (!iconEl || !titleEl || !textEl || !linkEl) return;
    iconEl.className = 'fas ' + data.icon + ' quadrant-modal-icon';
    titleEl.textContent = data.title;
    textEl.textContent = data.text;
    linkEl.setAttribute('href', safeLink(data.link, '/'));
    linkEl.textContent = data.linkText;

    // Abrir modal con Bootstrap 5 (con guarda si el CDN falla)
    if (typeof bootstrap === 'undefined' || !bootstrap.Modal) return;
    const bsModal = new bootstrap.Modal(modal);
    bsModal.show();
  }

  // === RULETA ===
  function rouletteStep() {
    if (!cachedQuadrants || !cachedQuadrants.length) {
      clearInterval(rouletteInterval);
      return;
    }
    // Quitar brillo de todos
    cachedQuadrants.forEach(function(q) {
      q.classList.remove('glowing');
    });

    // Poner brillo en el cuadrante actual (índice acotado)
    const idx = rouletteCatIdx % cachedQuadrants.length;
    if (cachedQuadrants[idx]) cachedQuadrants[idx].classList.add('glowing');

    // Avanzar al siguiente
    rouletteCatIdx = (rouletteCatIdx + 1) % CONFIG.categories.length;
    rouletteStepCount++;

    if (rouletteStepCount >= CONFIG.rouletteSteps) {
      clearInterval(rouletteInterval);
      finishRoulette();
    }
  }

  function startRoulette() {
    if (!cachedContainer || !cachedQuadrants || !cachedQuadrants.length) return;
    if (isRouletteActive) return;
    // Cancelar timeouts pendientes
    if (autoResetTimeout) {
      clearTimeout(autoResetTimeout);
      autoResetTimeout = null;
    }
    if (transitionTimeout) {
      clearTimeout(transitionTimeout);
      transitionTimeout = null;
    }

    // Cerrar modales abiertos (con guarda si el CDN falla)
    if (typeof bootstrap !== 'undefined' && bootstrap.Modal) {
      const openModals = document.querySelectorAll('.modal.show');
      openModals.forEach(function(m) {
        const bsModal = bootstrap.Modal.getInstance(m);
        if (bsModal) bsModal.hide();
      });
    }

    // Resetear estado de cuadrantes
    resetRoulette();

    isRouletteActive = true;
    cachedContainer.classList.add('roulette-active');

    const randomIndex = Math.floor(Math.random() * CONFIG.categories.length);
    selectedCategory = CONFIG.categories[randomIndex];

    rouletteStepCount = 0;
    rouletteCatIdx = 0;

    rouletteInterval = setInterval(rouletteStep, CONFIG.stepInterval);
  }

  function finishRoulette() {
    if (cachedContainer) cachedContainer.classList.remove('roulette-active');

    let selectedEl = null;
    const dimmedEls = [];

    if (!cachedQuadrants || !cachedQuadrants.forEach) return;
    cachedQuadrants.forEach(function(q) {
      q.classList.remove('glowing');

      if (q.dataset.category === selectedCategory) {
        q.classList.add('selected');
        showHighlight(q, selectedCategory);
        selectedEl = q;
      } else {
        q.classList.add('dimmed');
        dimmedEls.push(q);
      }
    });

    // Después de 1.5s: brillo normal en todos, contenido visible en seleccionado
    transitionTimeout = setTimeout(function() {
      if (selectedEl) {
        selectedEl.classList.remove('selected');
        selectedEl.classList.add('selected-normal');
        // Limpiar estilos inline de brillo
        selectedEl.style.removeProperty('filter');
        selectedEl.style.removeProperty('z-index');
      }
      dimmedEls.forEach(function(q) {
        q.classList.remove('dimmed');
        q.style.removeProperty('filter');
        q.style.removeProperty('opacity');
      });
      transitionTimeout = null;
    }, 460);

    isRouletteActive = false;

    // Auto-reset después de 5 segundos
    autoResetTimeout = setTimeout(function() {
      resetRoulette();
      autoResetTimeout = null;
    }, 4000);
  }

  function showHighlight(quadrant, category) {
    const content = quadrant.querySelector('.quadrant-content');
    if (!content) return;

    const data = CONFIG.modalData[category];
    if (!data) return;
    while (content.firstChild) content.removeChild(content.firstChild);
    content.appendChild(buildHighlightCard(data));
    content.style.animation = 'fade-in-content 0.5s ease forwards';
  }

  // Construye el highlight con DOM API (sin HTML inyectado) + href con allowlist
  function buildHighlightCard(data) {
    const card = document.createElement('div');
    card.className = 'highlight-card';

    const icon = document.createElement('i');
    icon.className = 'fas ' + data.icon + ' highlight-icon';
    card.appendChild(icon);

    const title = document.createElement('h3');
    title.className = 'highlight-title';
    title.textContent = data.title;
    card.appendChild(title);

    const desc = document.createElement('p');
    desc.className = 'highlight-description';
    desc.textContent = data.text;
    card.appendChild(desc);

    const link = document.createElement('a');
    link.setAttribute('href', safeLink(data.link, '/'));
    link.className = 'highlight-link';
    link.textContent = data.linkText;
    card.appendChild(link);

    return card;
  }

  function resetRoulette() {
    if (!cachedQuadrants || !cachedQuadrants.forEach) {
      selectedCategory = null;
      return;
    }
    cachedQuadrants.forEach(function(q) {
      q.classList.remove('selected', 'selected-normal', 'dimmed', 'glowing');

      // Resetear estilos inline que las clases dejaron
      q.style.removeProperty('filter');
      q.style.removeProperty('opacity');
      q.style.removeProperty('z-index');

      const content = q.querySelector('.quadrant-content');
      if (content) {
        while (content.firstChild) content.removeChild(content.firstChild);
        content.style.opacity = '';
        content.style.removeProperty('animation');
      }
    });

    selectedCategory = null;
  }

  // === MENU BAR ===
  function initMenuBar() {
    if (!cachedMenuDRBar) return;

    let heroHeight = cachedContainer ? cachedContainer.offsetHeight : window.innerHeight;
    let barHeight = cachedMenuDRBar.offsetHeight || 40;
    let threshold = heroHeight - barHeight;

    function onScroll() {
      const y = window.pageYOffset || document.documentElement.scrollTop;
      if (isHomePage) {
        if (y > threshold) {
          cachedMenuDRBar.classList.remove('is-hidden');
          cachedMenuDRBar.classList.add('is-visible');
        } else {
          cachedMenuDRBar.classList.remove('is-visible');
          cachedMenuDRBar.classList.add('is-hidden');
        }
      } else {
        cachedMenuDRBar.classList.remove('is-hidden');
        cachedMenuDRBar.classList.add('is-visible');
      }
    }

    if (window._drScrollHandler) {
      window.removeEventListener('scroll', window._drScrollHandler);
    }
    window._drScrollHandler = onScroll;
    window.addEventListener('scroll', onScroll, { passive: true });

    onScroll();

    function onResize() {
      heroHeight = cachedContainer ? cachedContainer.offsetHeight : window.innerHeight;
      barHeight = cachedMenuDRBar.offsetHeight || 40;
      threshold = heroHeight - barHeight;
    }

    if (window._drResizeHandler) {
      window.removeEventListener('resize', window._drResizeHandler);
    }
    window._drResizeHandler = onResize;
    window.addEventListener('resize', onResize, { passive: true });
  }

})();
