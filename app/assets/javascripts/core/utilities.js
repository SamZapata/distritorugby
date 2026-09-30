// Distrito Rugby - scroll utilities (Phase 1, adapted from legacy)
// Uses addEventListener so it coexists with main-menu.js scroll handler.
var scrollFunction, topFunction;

scrollFunction = function() {
  var btn = document.getElementById('scrollUp');
  if (!btn) return;
  if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
    btn.style.display = 'block';
  } else {
    btn.style.display = 'none';
  }
};

topFunction = function() {
  document.body.scrollTop = 0;
  document.documentElement.scrollTop = 0;
};

document.addEventListener('scroll', scrollFunction, { passive: true });
document.addEventListener('turbo:load', scrollFunction);
