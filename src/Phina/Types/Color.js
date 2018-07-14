//-----------------------------------------------------------------------------
// Phina.Core.Color

exports.nullColor = null;

exports.nullableColor = function(n, f, c) {
  return c != null ? f(c) : n;
};
