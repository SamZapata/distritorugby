window.DistritoRugby = {};
window.DistritoRugby.init = function() {
  // Punto de extensión para módulos futuros; sin console.log en producción.
};

document.addEventListener('turbo:load', function() {
  window.DistritoRugby.init();
});
