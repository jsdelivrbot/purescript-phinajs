//-----------------------------------------------------------------------------
// Phina.Accessory.Tweenable

/* global phina */

exports._setUpdateType = function(type, tweener) {
  tweener.setUpdateType(type);
  return tweener;
};

exports._setLoop = function(flag, tweener) {
  tweener.setLoop(flag);
  return tweener;
};

exports._to = function(params, duration, easing, tweener) {
  tweener.to(params, duration, easing);
  return tweener;
};

exports._by = function(params, duration, easing, tweener) {
  tweener.by(params, duration, easing);
  return tweener;
};

exports._from = function(params, duration, easing, tweener) {
  tweener.from(params, duration, easing);
  return tweener;
};

exports._wait = function(time, tweener) {
  tweener.wait(time);
  return tweener;
};

exports._call = function(func, tweener) {
  tweener.call(function() {
    return func(tweener.target)();
  });

  return tweener;
};

exports._set = function(params, tweener) {
  tweener.set(params);
  return tweener;
};

exports._moveTo = function(x, y, duration, easing, tweener) {
  tweener.moveTo(x, y, duration, easing);
  return tweener;
};

exports._moveBy = function(x, y, duration, easing, tweener) {
  tweener.moveBy(x, y, duration, easing);
  return tweener;
};

exports._rotateTo = function(angle, duration, easing, tweener) {
  tweener.rotateTo(angle, duration, easing);
  return tweener;
};

exports._rotateBy = function(angle, duration, easing, tweener) {
  tweener.rotateBy(angle, duration, easing);
  return tweener;
};

exports._scaleTo = function(scale, duration, easing, tweener) {
  tweener.scaleTo(scale, duration, easing);
  return tweener;
};

exports._scaleBy = function(scale, duration, easing, tweener) {
  tweener.scaleBy(scale, duration, easing);
  return tweener;
};

exports._fade = function(alpha, duration, easing, tweener) {
  tweener.fade(alpha, duration, easing);
  return tweener;
};

exports._fadeOut = function(duration, easing, tweener) {
  tweener.fadeOut(duration, easing);
  return tweener;
};

exports._fadeIn = function(duration, easing, tweener) {
  tweener.fadeIn(duration, easing);
  return tweener;
};

exports._getTweener = function(element) {
  return element.tweener.clear();
};

exports._newTweener = function(element) {
  return phina.accessory.Tweener().attachTo(element).pause();
};

exports._clearTween = function(tweener) {
  tweener.clear();
  return tweener;
};

exports._play = function(tweener) {
  return tweener.rewind().play();
};

exports._stop = function(tweener) {
  return tweener.stop();
};

exports._pause = function(tweener) {
  return tweener.pause();
};

exports._resume = function(tweener) {
  return tweener.play();
};
