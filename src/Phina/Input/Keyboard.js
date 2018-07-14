//-----------------------------------------------------------------------------
// Phina.Input.Keyboard

/* global phina */

exports.getKey = function() {
  return function(key) {
    return function(a) {
      return a.keyboard.getKey(key.value0);
    };
  };
};

exports.getKeyDown = function() {
  return function(key) {
    return function(a) {
      return a.keyboard.getKeyDown(key.value0);
    };
  };
};

exports.getKeyUp = function() {
  return function(key) {
    return function(a) {
      return a.keyboard.getKeyUp(key.value0);
    };
  };
};

exports.getKeyCode = function(key) {
  var code = phina.input.Keyboard.KEY_CODE[key];

  return code != null ? code : 0;
};
