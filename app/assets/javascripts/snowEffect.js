
/*

Let it snow, let it snow, let it snow!
Author: Robert Smith, rsmithlal@gmail.com

Adapted from: https://engageinteractive.co.uk/blog/5-modern-snow-effects

*/



var LetItSnow = (function() {
  (function() {
    var requestAnimationFrame = window.requestAnimationFrame || window.mozRequestAnimationFrame || window.webkitRequestAnimationFrame || window.msRequestAnimationFrame ||
    function(callback) {
      window.setTimeout(callback, 1000 / 60);
    };
    window.requestAnimationFrame = requestAnimationFrame;
  })();

  var flakes = [],
      canvas = null,
      ctx = null,
      flakeCount = 400,
      mX = -100,
      mY = -100,
      timer = null,
      snowing = false,
      stopSnowing = false,
      $snowflake = null;

  function snow() {
    if (stopSnowing) return;

    ctx.clearRect(0, 0, canvas.width, canvas.height);

    for (var i = 0; i < flakeCount; i++) {
      if (stopSnowing) break;
      var flake = flakes[i],
          x = mX,
          y = mY,
          minDist = 150,
          x2 = flake.x,
          y2 = flake.y;

      var dist = Math.sqrt((x2 - x) * (x2 - x) + (y2 - y) * (y2 - y)),
          dx = x2 - x,
          dy = y2 - y;

      if (dist < minDist) {
        var force = minDist / (dist * dist),
            xcomp = (x - x2) / dist,
            ycomp = (y - y2) / dist,
            deltaV = force / 2;

        flake.velX -= deltaV * xcomp;
        flake.velY -= deltaV * ycomp;
      } else {
        flake.velX *= 0.98;
        if (flake.velY <= flake.speed) {
            flake.velY = flake.speed;
        }
        flake.velX += Math.cos(flake.step += 0.05) * flake.stepSize;
      }

      ctx.fillStyle = "rgba(255,255,255," + flake.opacity + ")";
      flake.y += flake.velY;
      flake.x += flake.velX;
          
      if (flake.y >= canvas.height || flake.y <= 0) {
        reset(flake);
      }


      if (flake.x >= canvas.width || flake.x <= 0) {
        reset(flake);
      }

      ctx.beginPath();
      ctx.arc(flake.x, flake.y, flake.size, 0, Math.PI * 2);
      ctx.fill();
    }

    if (stopSnowing) return;

    timer = requestAnimationFrame(snow);
  }

  function reset(flake) {
    flake.x = Math.floor(Math.random() * canvas.width);
    flake.y = 0;
    flake.size = (Math.random() * 3) + 2;
    flake.speed = (Math.random() * 1) + 0.5;
    flake.velY = flake.speed;
    flake.velX = 0;
    flake.opacity = (Math.random() * 0.5) + 0.3;
  }

  function prep() {
    $snowflake = $('#snow-toggle');
    $snowflake.tooltip({
      placement: 'bottom',
      // container: 'body',
    });

    $snowflake.click(toggleSnowfall);

    canvas = document.getElementById("snow-canvas");
    ctx = canvas.getContext("2d");

    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;

    canvas.addEventListener("mousemove", function(e) {
      mX = e.clientX;
      mY = e.clientY;
    });

    window.addEventListener("resize", function(){
      canvas.width = window.innerWidth;
      canvas.height = window.innerHeight;
    });
    
    var snowfallCookie = Cookies.get('letItSnow');
    var snowfallEnabled = snowfallCookie == 'true' || snowfallCookie == void 0;

    if (snowfallEnabled) start();
  }

  function toggleSnowfall() {
    if (snowing) {
      stop();
    }
    else {
      start();
    }
  }

  function start() {
    snowing = true;
    stopSnowing = false;
    Cookies.set('letItSnow', true);

    startSpinner();

    for (var i = 0; i < flakeCount; i++) {
      var x = Math.floor(Math.random() * canvas.width),
          y = Math.floor(Math.random() * canvas.height),
          size = (Math.random() * 3) + 2,
          speed = (Math.random() * 1) + 0.5,
          opacity = (Math.random() * 0.5) + 0.3;

      flakes.push({
        speed: speed,
        velY: speed,
        velX: 0,
        x: x,
        y: y,
        size: size,
        stepSize: (Math.random()) / 30,
        step: 0,
        opacity: opacity
      });
    }

    snow();
  }

  function stop() {
    snowing = false;
    stopSnowing = true;
    Cookies.set('letItSnow', false);
    clearTimeout(timer);
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    stopSpinner();
  }

  function startSpinner() {
    $snowflake.addClass('fa-spin');
  }

  function stopSpinner() {
    $snowflake.removeClass('fa-spin');
  }

  return {
    prep: prep,
    start: start,
    stop: stop
  };
})();

$(document).ready(LetItSnow.prep);
