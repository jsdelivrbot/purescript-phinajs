//-----------------------------------------------------------------------------
// Phina.Asset.AssetManager

/* global phina */

exports._getSound = function(name) {
  return phina.asset.AssetManager.get('sound', name);
};
