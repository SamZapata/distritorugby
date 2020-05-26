var scrollFunction, topFunction;

scrollFunction = function() {
  if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
    document.getElementById('scrollUp').style.display = 'block';
  } else {
    document.getElementById('scrollUp').style.display = 'none';
  }
};

topFunction = function() {
  document.body.scrollTop = 0;
  document.documentElement.scrollTop = 0;
};

window.onscroll = function() {
  scrollFunction();
};
