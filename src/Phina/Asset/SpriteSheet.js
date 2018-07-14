//-----------------------------------------------------------------------------
// Phina.Asset.SpriteSheet

exports.toAnimations = function(l) {
  return l.reduce(function(a, e) {
    a[e.key] = e.value;
    return a;
  }, {});
};
