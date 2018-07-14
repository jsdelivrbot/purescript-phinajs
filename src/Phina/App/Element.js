//-----------------------------------------------------------------------------
// Phina.App.Element

exports._remove = function(element) {
  return element.remove();
};

exports._setUpdater = function(updater, element) {
  element.update = function(ap) {
    updater(ap)(this)();
  };
  return element;
};

exports._addChild = function(child, parent) {
  parent.addChild(child);
  return parent;
};
