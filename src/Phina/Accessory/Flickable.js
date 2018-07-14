//-----------------------------------------------------------------------------
// Phina.Accessory.Flickable

exports._setFlick = function(friction, horizontal, vertical, element) {
  var flickable = element.flickable;

  flickable.enable();
  flickable.friction = friction;
  flickable.horizontal = horizontal;
  flickable.vertical = vertical;

  return element;
};

exports._onFlickStart = function(func, element) {
  element.flickable.on('flickstart', function() {
    func(element)();
  });

  return element;
};

exports._onFlickCancel = function(func, element) {
  element.flickable.on('flickcancel', function() {
    func(element)();
  });

  return element;
};
