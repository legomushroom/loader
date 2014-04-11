(function() {
  var Main;

  Main = (function() {
    function Main(o) {
      this.o = o != null ? o : {};
      this.vars();
      this.launch();
    }

    Main.prototype.vars = function() {
      this.loader = document.getElementById('js-pie-loader');
      this.loader1 = document.getElementById('js-pie-loader1');
      this.loader2 = document.getElementById('js-pie-loader2');
      this.loaderToggle = document.getElementById('js-pie-loader-toggle');
      this.toggleStyle = this.loaderToggle.style;
      this.firstColor = this.getComutedStyle(this.loader1).stroke;
      this.secondColor = this.getComutedStyle(this.loader2).stroke;
      this.toggle = false;
      this.el = this.loader2;
      this.animate = this.bind(this.animate, this);
      return this.animate();
    };

    Main.prototype.launch = function() {
      var it;
      it = this;
      return this.tween = new TWEEN.Tween({
        offset: 0,
        p: 0
      }).to({
        offset: 24,
        p: 1
      }, this.o.duration || 2000).onUpdate(function() {
        var color;
        it.el.style['stroke-dashoffset'] = this.offset * Math.PI;
        if (this.p === 1) {
          it.toggle = !it.toggle;
          it.el = it.toggle ? it.loader1 : it.loader2;
          color = !it.toggle ? it.firstColor : it.secondColor;
          return setTimeout(function() {
            return it.toggleStyle.stroke = color;
          }, 1);
        }
      }).repeat(9999999999).start();
    };

    Main.prototype.stop = function() {
      return console.log('implement me');
    };

    Main.prototype.destroy = function() {
      return console.log('implement me');
    };

    Main.prototype.play = function() {
      return console.log('implement me');
    };

    Main.prototype.getComutedStyle = function(el) {
      if (window.getComputedStyle) {
        return getComputedStyle(el);
      } else {
        return el.currentStyle;
      }
    };

    Main.prototype.animate = function() {
      requestAnimationFrame(this.animate);
      return TWEEN.update();
    };

    Main.prototype.bind = function(func, context) {
      var bindArgs, wrapper;
      wrapper = function() {
        var args, unshiftArgs;
        args = Array.prototype.slice.call(arguments);
        unshiftArgs = bindArgs.concat(args);
        return func.apply(context, unshiftArgs);
      };
      bindArgs = Array.prototype.slice.call(arguments, 2);
      return wrapper;
    };

    return Main;

  })();

  new Main;

}).call(this);
