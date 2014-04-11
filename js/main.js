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
      this.loader1 = this.loader.getElementById('js-pie-loader1');
      this.loader2 = this.loader.getElementById('js-pie-loader2');
      this.loaderToggle = this.loader.getElementById('js-pie-loader-toggle');
      this.firstColor = this.getComutedStyle(this.loader1).stroke;
      this.secondColor = this.getComutedStyle(this.loader2).stroke;
      this.toggle = false;
      this.el = this.loader2;
      this.delay = 3000;
      this.animate = this.bind(this.animate, this);
      return this.animate();
    };

    Main.prototype.launch = function() {
      var it;
      it = this;
      return this.mainTween = new TWEEN.Tween({
        p: 0
      }).to({
        p: 1
      }, 2 * this.o.duration || 2 * this.delay).onUpdate(function() {
        if (this.p === 1) {
          return it.tweens();
        }
      }).onStart(function() {
        return it.tweens();
      }).repeat(99999999999).start();
    };

    Main.prototype.tweens = function() {
      var it;
      it = this;
      this.tween2 = new TWEEN.Tween({
        offset: -24,
        p: 0
      }).to({
        offset: 0,
        p: 1
      }, this.o.duration || this.delay).onUpdate(function() {
        return it.el.style['stroke-dashoffset'] = this.offset * Math.PI;
      });
      return this.tween = new TWEEN.Tween({
        offset: 0,
        p: 0
      }).to({
        offset: 24,
        p: 1
      }, this.o.duration || this.delay).onUpdate(function() {
        return it.el.style['stroke-dashoffset'] = this.offset * Math.PI;
      }).chain(this.tween2).start();
    };

    Main.prototype.stop = function() {
      return this.tween.stop();
    };

    Main.prototype.destroy = function() {
      TWEEN.remove(this.tween);
      return window.pieLoader = null;
    };

    Main.prototype.play = function() {
      return this.tween.play();
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

  window.pieLoader = Main;

  new window.pieLoader;

}).call(this);
