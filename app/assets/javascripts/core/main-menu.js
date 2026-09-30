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

  // Compatibilidad: DOMContentLoaded (carga inicial) + turbo:load (navegación Turbo)
  document.addEventListener('DOMContentLoaded', init);
  document.addEventListener('turbo:load', init);

  // === ROMBO ===
  function initDiamond() {
    var diamond = document.querySelector('.diamond');

    if (!diamond) return;

    // Clic en el rombo → ruleta (excepto si es el texto, que abre modal auth)
    if (!diamond._hasHandler) {
      diamond._hasHandler = true;
      diamond.addEventListener('click', function(e) {
        // Si el clic fue sobre el texto, dejar que Bootstrap abra el modal
        if (e.target.closest('.diamond-text')) {
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
        var linkEl = e.target.closest('a');
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

    // Actualizar contenido
    modal.querySelector('.quadrant-modal-icon').className = 'fas ' + data.icon + ' quadrant-modal-icon';
    modal.querySelector('.quadrant-modal-title').textContent = data.title;
    modal.querySelector('.quadrant-modal-text').textContent = data.text;
    modal.querySelector('.quadrant-modal-link').href = data.link;
    modal.querySelector('.quadrant-modal-link').textContent = data.linkText;

    // Abrir modal con Bootstrap 5
    var bsModal = new bootstrap.Modal(modal);
    bsModal.show();
  }

  // === RULETA ===
  function rouletteStep() {
    rouletteStep._step = rouletteStep._step || 0;
    rouletteStep._catIdx = rouletteStep._catIdx || 0;

    // Quitar brillo de todos
    cachedQuadrants.forEach(function(q) {
      q.classList.remove('glowing');
    });

    // Poner brillo en el cuadrante actual
    cachedQuadrants[rouletteStep._catIdx].classList.add('glowing');

    // Avanzar al siguiente
    rouletteStep._catIdx = (rouletteStep._catIdx + 1) % CONFIG.categories.length;
    rouletteStep._step++;

    if (rouletteStep._step >= CONFIG.rouletteSteps) {
      clearInterval(rouletteInterval);
      finishRoulette();
    }
  }

  function startRoulette() {
    // Cancelar timeouts pendientes
    if (autoResetTimeout) {
      clearTimeout(autoResetTimeout);
      autoResetTimeout = null;
    }
    if (transitionTimeout) {
      clearTimeout(transitionTimeout);
      transitionTimeout = null;
    }

    // Cerrar modales abiertos
    var openModals = document.querySelectorAll('.modal.show');
    openModals.forEach(function(m) {
      var bsModal = bootstrap.Modal.getInstance(m);
      if (bsModal) bsModal.hide();
    });

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
    cachedContainer.classList.remove('roulette-active');

    var selectedEl = null;
    var dimmedEls = [];

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
    content.innerHTML = getHighlightHTML(data);
    content.style.animation = 'fade-in-content 0.5s ease forwards';
  }

  function getHighlightHTML(data) {
    return '<div class="highlight-card">' +
      '<i class="fas ' + data.icon + ' highlight-icon"></i>' +
      '<h3 class="highlight-title">' + data.title + '</h3>' +
      '<p class="highlight-description">' + data.text + '</p>' +
      '<a href="' + data.link + '" class="highlight-link">' + data.linkText + '</a>' +
      '</div>';
  }

  function resetRoulette() {
    cachedQuadrants.forEach(function(q) {
      q.classList.remove('selected', 'selected-normal', 'dimmed', 'glowing');

      // Resetear estilos inline que las clases dejaron
      q.style.removeProperty('filter');
      q.style.removeProperty('opacity');
      q.style.removeProperty('z-index');

      var content = q.querySelector('.quadrant-content');
      if (content) {
        content.innerHTML = '';
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

    window.addEventListener('resize', function() {
      heroHeight = cachedContainer ? cachedContainer.offsetHeight : window.innerHeight;
      barHeight = cachedMenuDRBar.offsetHeight || 40;
      threshold = heroHeight - barHeight;
    }, { passive: true });
  }

})();
