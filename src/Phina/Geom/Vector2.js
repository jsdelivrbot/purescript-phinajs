//-----------------------------------------------------------------------------
// Phina.Geom.Vector2
//
//  Avoid using Vector2 constructor for performance

/* global phina */

var vector2 = phina.geom.Vector2;
var random = phina.util.Random.randfloat.bind(phina.util.Random);
var toRadians = function(d) {return d * Math.PI / 180;};

exports.mulVector2 = function(v) {
  return function(n) {
    return {x: v.x * n, y: v.y * n};
  };
};

exports.divVector2 = function(v) {
  return function(n) {
    return {x: v.x / n, y: v.y / n};
  };
};

exports.newVector2fromAngle = function(angle) {
  return function(len) {
    return vector2(0, 0).fromDegree(angle, len);
  };
};

exports._randomAllVector2 = function(minAngle, maxAngle, minLen, maxLen) {
  return vector2(0, 0).fromDegree(random(minAngle, maxAngle), random(minLen, maxLen));
};

exports.cross = function(a) {
  return function(b) {
    return vector2.cross(a, b);
  };
};

exports.dot = function(a) {
  return function(b) {
    return vector2.dot(a, b);
  };
};

exports.reflect = function(norm) {
  return function(v) {
    var len = vector2.dot(v, norm);

    return {x: v.x - norm.x * 2 * len, y: v.y - norm.y * 2 * len};
  };
};

exports.reflectHorizontal = function(v) {
  return {x: v.x, y: -v.y};
};

exports.reflectVertical = function(v) {
  return {x: -v.x, y: v.y};
};

exports.rotate = function(angle) {
  return function(v) {
    return vector2(v.x, v.y).rotate(toRadians(angle));
  };
};

exports.zero = vector2.ZERO;
exports.left = vector2.LEFT;
exports.right = vector2.RIGHT;
exports.up = vector2.Up;
exports.down = vector2.DOWN;
