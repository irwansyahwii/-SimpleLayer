// Generated by CoffeeScript 1.9.2
(function() {
  var Events, Utils, _;

  _ = require("./Underscore")._;

  Utils = require("./Utils");

  Events = {};

  Events.TouchStart = "touchstart";

  Events.TouchEnd = "touchend";

  Events.TouchMove = "touchmove";

  Events.MouseUp = "mouseup";

  Events.MouseDown = "mousedown";

  Events.MouseOver = "mouseover";

  Events.MouseOut = "mouseout";

  Events.MouseMove = "mousemove";

  Events.MouseWheel = "mousewheel";

  if (!Utils.isTouch()) {
    Events.TouchStart = Events.MouseDown;
    Events.TouchEnd = Events.MouseUp;
    Events.TouchMove = Events.MouseMove;
  }

  Events.Click = Events.TouchEnd;

  Events.AnimationStart = "start";

  Events.AnimationStop = "stop";

  Events.AnimationEnd = "end";

  Events.AnimationDidStart = "start";

  Events.AnimationDidStop = "stop";

  Events.AnimationDidEnd = "end";

  Events.Scroll = "scroll";

  Events.ImageLoaded = "load";

  Events.ImageLoadError = "error";

  Events.touchEvent = function(event) {
    var ref, ref1, touchEvent;
    touchEvent = (ref = event.touches) != null ? ref[0] : void 0;
    if (touchEvent == null) {
      touchEvent = (ref1 = event.changedTouches) != null ? ref1[0] : void 0;
    }
    if (touchEvent == null) {
      touchEvent = event;
    }
    return touchEvent;
  };

  Events.wrap = function(element) {
    return Framer.CurrentContext.eventManager.wrap(element);
  };

  exports.Events = Events;

}).call(this);
