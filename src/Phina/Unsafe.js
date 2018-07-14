//-----------------------------------------------------------------------------
// Phina.Unsafe

/* global phina */

exports._unsafeGetProp = function(label, instance) {
  return instance[label];
};

exports._unsafeSetProp = function(label, value, instance) {
  instance[label] = value;
  return instance;
};

exports._unsafeSetProps = function(src, dest) {
  var own = Object.prototype.hasOwnProperty;

  for (var key in src) {
    if (own.call(src, key)) {
      dest[key] = src[key];
    }
  }

  return dest;
};

exports._unsafeNew = function(module, klass, params) {
  return phina[module][klass](params);
};
