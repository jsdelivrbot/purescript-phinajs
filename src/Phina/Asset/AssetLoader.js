//-----------------------------------------------------------------------------
// Phina.Asset.AssetLoader

exports.makeAssets = function() {
  return function(params) {
    var allAssets = {};

    var own = Object.prototype.hasOwnProperty;
    for (var type in params) {
      if (own.call(params, type)) {
        allAssets[type] =
          params[type].reduce(function(assets, asset) {
            if (typeof asset === 'string') {
              assets[asset] = asset;
            } else {
              assets[asset.key] = asset.value;
            }
            return assets;
          }, {});
      }
    }

    return allAssets;
  };
};
