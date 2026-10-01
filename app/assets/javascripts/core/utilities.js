// Distrito Rugby - scroll utilities
// Sin onclick inline (CSP-ready): el footer usa data-scroll-top.
function scrollFunction() {
  const btn = document.getElementById('scrollUp');
  if (!btn) return;
  if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
    btn.style.display = 'block';
  } else {
    btn.style.display = 'none';
  }
}

function topFunction() {
  document.body.scrollTop = 0;
  document.documentElement.scrollTop = 0;
}

function bindScrollTop() {
  const btn = document.getElementById('scrollUp');
  if (btn && !btn._drBound) {
    btn._drBound = true;
    btn.addEventListener('click', topFunction);
  }
}

document.addEventListener('scroll', scrollFunction, { passive: true });
document.addEventListener('DOMContentLoaded', function() {
  scrollFunction();
  bindScrollTop();
});
document.addEventListener('turbo:load', function() {
  scrollFunction();
  bindScrollTop();
});
