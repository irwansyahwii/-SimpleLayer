// Generated by CoffeeScript 1.9.2
(function() {
  var Application, DOMElement, FamousWindow, Layer, LayerId, Logger, famous,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  famous = require("famous");

  FamousWindow = require("./FamousWindow");

  Application = require("./Application");

  LayerId = require("./LayerId");

  Logger = require('./Logger');

  DOMElement = famous.domRenderables.DOMElement;

  Layer = (function() {
    function Layer(options) {
      this.applyPosition = bind(this.applyPosition, this);
      this.applyBorderRadius = bind(this.applyBorderRadius, this);
      var borderRadius;
      Logger.log("Layer constructor called...");
      this._id = LayerId.generateNewId();
      this._name = "";
      this._x = options.x || 0;
      this._y = options.y || 0;
      this._width = options.width || 0;
      this._height = options.height || 0;
      this._window = options.window;
      if (this._window == null) {
        this._window = Application.getRootWindow();
      }
      this._tagName = "div";
      this._xAxisSizeMode = "absolute";
      this._yAxisSizeMode = "absolute";
      this._zAxisSizeMode = "absolute";
      this._scale = options.scale || 1;
      this._backgroundColor = options.backgroundColor || '#FFFFFF';
      this._layerNode = this._window.createNode();
      this._layerElement = new DOMElement(this._layerNode, {
        tagName: this._tagName,
        properties: {
          backgroundColor: this._backgroundColor
        }
      });
      this._borderRadius = 0;
      borderRadius = options.borderRadius || 0;
      if (borderRadius > 0) {
        this.applyBorderRadius(borderRadius);
      }
      Application.init();
      this._layerNode.setScale(this._scale, this._scale);
      this.applyPosition();
      this._layerNode.setSizeMode(this._xAxisSizeMode, this._yAxisSizeMode, this._zAxisSizeMode);
      this._layerNode.setAbsoluteSize(this._width, this._height);
    }

    Layer.prototype.applyBorderRadius = function(newVal) {
      this._layerElement.setProperty('border-radius', this._borderRadius + "px");
      return this._layerElement.setProperty('border', "2px solid " + this._backgroundColor);
    };

    Layer.property('borderRadius', {
      get: function() {
        return this._borderRadius;
      },
      set: function(newVal) {
        if (this._borderRadius !== newVal) {
          this._borderRadius = newVal;
          return this.applyBorderRadius(newVal);
        }
      }
    });

    Layer.property('id', {
      get: function() {
        return this._id;
      }
    });

    Layer.property('name', {
      get: function() {
        return this._name;
      },
      set: function(newVal) {
        return this._name = newVal;
      }
    });

    Layer.prototype.applyPosition = function() {
      return this._layerNode.setPosition(this._x, this._y);
    };

    Layer.property('x', {
      get: function() {
        return this._x;
      },
      set: function(newVal) {
        if (this._x !== newVal) {
          this._x = newVal;
          return this.applyPosition();
        }
      }
    });

    Layer.property('y', {
      get: function() {
        return this._y;
      },
      set: function(newVal) {
        if (this._y !== newVal) {
          this._y = newVal;
          return this.applyPosition();
        }
      }
    });

    return Layer;

  })();

  module.exports = Layer;

}).call(this);
