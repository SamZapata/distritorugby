// Distrito Rugby - Diamond Roulette
// Author: Johnny Zapata - @jsamzapata
// Updated: Septiembre 2026

(function() {
  'use strict';

  var CONFIG = {
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
  var ALLOWED_LINKS = ['/stories', '/game/tournaments', '/game/clubs', '/game/players'];

  function safeLink(path, fallback) {
    if (ALLOWED_LINKS.indexOf(path) !== -1) return path;
    return fallback || '/';
  }

  var isRouletteActive = false;
  var selectedCategory = null;
  var rouletteInterval = null;
  var autoResetTimeout = null;
  var transitionTimeout = null;

  // Cache de elementos DOM (se recalcan en init por si Turbo recarga el DOM)
  var cachedContainer = null;
  var cachedQuadrants = null;
  var cachedMenuDRBar = null;
  var isHomePage = false;

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
    var diamond = document.querySelector('.diamond');

    if (!diamond) return;

    // Clic en el rombo → ruleta (excepto si es el texto, que abre modal auth)
    if (!diamond._hasHandler) {
      diamond._hasHandler = true;
      diamond.addEventListener('click', function(e) {
        // Si el clic fue sobre el texto, dejar que Bootstrap abra el modal
        var t = e.target && e.target.closest ? e.target.closest('.diamond-text') : null;
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
        var linkEl = (e.target && e.target.closest) ? e.target.closest('a') : null;
        if (linkEl) {
          return;
        }
        // Si no fue un link, mostrar modal informativa
        e.preventDefault();
        var category = q.dataset.category;
        showQuadrantModal(category);
      });
    });
  }

  // === MODAL INFORMATIVA DEL CUADRANTE ===
  function showQuadrantModal(category) {
    var data = CONFIG.modalData[category];
    if (!data) return;

    var modal = document.getElementById('quadrantModal');
    if (!modal) return;

    // Actualizar contenido (solo texto + href con allowlist)
    var iconEl = modal.querySelector('.quadrant-modal-icon');
    var titleEl = modal.querySelector('.quadrant-modal-title');
    var textEl = modal.querySelector('.quadrant-modal-text');
    var linkEl = modal.querySelector('.quadrant-modal-link');
    if (!iconEl || !titleEl || !textEl || !linkEl) return;
    iconEl.className = 'fas ' + data.icon + ' quadrant-modal-icon';
    titleEl.textContent = data.title;
    textEl.textContent = data.text;
    linkEl.setAttribute('href', safeLink(data.link, '/'));
    linkEl.textContent = data.linkText;

    // Abrir modal con Bootstrap 5 (con guarda si el CDN falla)
    if (typeof bootstrap === 'undefined' || !bootstrap.Modal) return;
    var bsModal = new bootstrap.Modal(modal);
    bsModal.show();
  }

  // === RULETA ===
  function rouletteStep() {
    rouletteStep._step = rouletteStep._step || 0;
    rouletteStep._catIdx = rouletteStep._catIdx || 0;

    if (!cachedQuadrants || !cachedQuadrants.length) {
      clearInterval(rouletteInterval);
      return;
    }
    // Quitar brillo de todos
    cachedQuadrants.forEach(function(q) {
      q.classList.remove('glowing');
    });

    // Poner brillo en el cuadrante actual (índice acotado)
    var idx = rouletteStep._catIdx % cachedQuadrants.length;
    if (cachedQuadrants[idx]) cachedQuadrants[idx].classList.add('glowing');

    // Avanzar al siguiente
    rouletteStep._catIdx = (rouletteStep._catIdx + 1) % CONFIG.categories.length;
    rouletteStep._step++;

    if (rouletteStep._step >= CONFIG.rouletteSteps) {
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
      var openModals = document.querySelectorAll('.modal.show');
      openModals.forEach(function(m) {
        var bsModal = bootstrap.Modal.getInstance(m);
        if (bsModal) bsModal.hide();
      });
    }

    // Resetear estado de cuadrantes
    resetRoulette();

    isRouletteActive = true;
    cachedContainer.classList.add('roulette-active');

    var randomIndex = Math.floor(Math.random() * CONFIG.categories.length);
    selectedCategory = CONFIG.categories[randomIndex];

    rouletteStep._step = 0;
    rouletteStep._catIdx = 0;

    rouletteInterval = setInterval(rouletteStep, CONFIG.stepInterval);
  }

  function finishRoulette() {
    if (cachedContainer) cachedContainer.classList.remove('roulette-active');

    var selectedEl = null;
    var dimmedEls = [];

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
    var content = quadrant.querySelector('.quadrant-content');
    if (!content) return;

    var data = CONFIG.modalData[category];
    if (!data) return;
    while (content.firstChild) content.removeChild(content.firstChild);
    content.appendChild(buildHighlightCard(data));
    content.style.animation = 'fade-in-content 0.5s ease forwards';
  }

  // Construye el highlight con DOM API (sin innerHTML) + href con allowlist
  function buildHighlightCard(data) {
    var card = document.createElement('div');
    card.className = 'highlight-card';

    var icon = document.createElement('i');
    icon.className = 'fas ' + data.icon + ' highlight-icon';
    card.appendChild(icon);

    var title = document.createElement('h3');
    title.className = 'highlight-title';
    title.textContent = data.title;
    card.appendChild(title);

    var desc = document.createElement('p');
    desc.className = 'highlight-description';
    desc.textContent = data.text;
    card.appendChild(desc);

    var link = document.createElement('a');
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

      var content = q.querySelector('.quadrant-content');
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

    var heroHeight = cachedContainer ? cachedContainer.offsetHeight : window.innerHeight;
    var barHeight = cachedMenuDRBar.offsetHeight || 40;
    var threshold = heroHeight - barHeight;

    function onScroll() {
      var y = window.pageYOffset || document.documentElement.scrollTop;
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
