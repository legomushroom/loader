(function() {
  var Main;

  Main = (function() {
    function Main(o) {
      this.o = o != null ? o : {};
      this.vars();
      this.launch();
    }

    Main.prototype.vars = function() {
      var i, part;
      this.loader = document.querySelector('#js-pie-loader');
      this.loader1 = this.loader.querySelector('#js-pie-loader1');
      this.loader2 = this.loader.querySelector('#js-pie-loader2');
      this.loaderToggle = this.loader.querySelector('#js-pie-loader-toggle');
      this.loaderText = this.loader.querySelector('#js-pie-loader-text');
      this.firstColor = this.getComutedStyle(this.loader1).stroke;
      this.secondColor = this.getComutedStyle(this.loader2).stroke;
      this.color1 = [];
      this.color1 = (function() {
        var _i, _len, _ref, _results;
        _ref = this.firstColor.split(',');
        _results = [];
        for (i = _i = 0, _len = _ref.length; _i < _len; i = ++_i) {
          part = _ref[i];
          if (i === 0) {
            part = part.replace('rgb(', '');
          }
          _results.push(parseInt(part, 10));
        }
        return _results;
      }).call(this);
      this.color2 = (function() {
        var _i, _len, _ref, _results;
        _ref = this.secondColor.split(',');
        _results = [];
        for (i = _i = 0, _len = _ref.length; _i < _len; i = ++_i) {
          part = _ref[i];
          if (i === 0) {
            part = part.replace('rgb(', '');
          }
          _results.push(parseInt(part, 10));
        }
        return _results;
      }).call(this);
      this.toggle = false;
      this.el = this.loader2;
      this.delay = 4000;
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
        p: 0,
        r: this.color1[0],
        g: this.color1[1],
        b: this.color1[2]
      }).to({
        offset: 0,
        r: this.color2[0],
        g: this.color2[1],
        b: this.color2[2],
        p: 1
      }, this.o.duration || this.delay).onUpdate(function() {
        it.el.style['stroke-dashoffset'] = this.offset * Math.PI;
        return it.loaderText.style['color'] = "rgb(" + (parseInt(this.r, 10)) + "," + (parseInt(this.g, 10)) + "," + (parseInt(this.b, 10)) + ")";
      });
      return this.tween = new TWEEN.Tween({
        offset: 0,
        p: 0,
        r: this.color2[0],
        g: this.color2[1],
        b: this.color2[2]
      }).to({
        offset: 24,
        p: 1,
        r: this.color1[0],
        g: this.color1[1],
        b: this.color1[2]
      }, this.o.duration || this.delay).onUpdate(function() {
        it.el.style['stroke-dashoffset'] = this.offset * Math.PI;
        return it.loaderText.style['color'] = "rgb(" + (parseInt(this.r, 10)) + "," + (parseInt(this.g, 10)) + "," + (parseInt(this.b, 10)) + ")";
      }).chain(this.tween2).start();
    };

    Main.prototype.destroy = function() {
      TWEEN.remove(this.tween, this.tween2, this.mainTween);
      return window.pieLoader = null;
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

  window.r = new window.pieLoader;

}).call(this);
