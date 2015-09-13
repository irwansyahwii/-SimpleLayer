// Generated by CoffeeScript 1.9.2
(function() {
  var Animator, Utils,
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  Utils = require("../Utils");

  Animator = require("../Animator").Animator;

  exports.LinearAnimator = (function(superClass) {
    extend(LinearAnimator, superClass);

    function LinearAnimator() {
      return LinearAnimator.__super__.constructor.apply(this, arguments);
    }

    LinearAnimator.prototype.setup = function(options) {
      this.options = _.defaults(options, {
        time: 1,
        precision: 1 / 1000
      });
      return this._time = 0;
    };

    LinearAnimator.prototype.next = function(delta) {
      this._time += delta;
      if (this.finished()) {
        return 1;
      }
      return this._time / this.options.time;
    };

    LinearAnimator.prototype.finished = function() {
      return this._time >= this.options.time - this.options.precision;
    };

    return LinearAnimator;

  })(Animator);

}).call(this);
