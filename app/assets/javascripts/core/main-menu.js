// colors by each area of the menu player
// var colorAi   = '#e98195'
// var colorAii  = '#cf0029'
// var colorAiii = '#7b000b'
// var colorAiv  = '#49000e'
var areas = ['i', 'ii', 'iii', 'iv']

// var colors = [] // en este array se irán almacenando la rotación de colores
rotateColorArea = function() {
  // get colors
  var colors = []
  $('.area').each(function(i) {
    for (var c = 0; c < areas.length; c++) {
      colors.push($(`.a-${areas[c]}`).css('background-color'));
    }
  });
  // change color
  $('.area').each(function(i) {
    if (i == 0) {
      var colorSelect = colors[colors.length-1]
      $(`.a-${areas[i]}`).css('background-color', colorSelect)
    }
    else {
      var colorSelect = colors[i-1]
      $(`.a-${areas[i]}`).css('background-color', colorSelect)
    }
  });
}

diamondFunction = function() {
  var t = 300;
  for (var i = 1; i < 9; i++) {
    setTimeout(rotateColorArea, t*i);
  }
};
