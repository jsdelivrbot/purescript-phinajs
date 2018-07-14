//-----------------------------------------------------------------------------
// Phina.Display.DisplayElement

exports._hitTest = function(pos, element) {
  return element.hitTest(pos.x, pos.y);
};

exports._hitTestElement = function(element1, element2) {
  return element1.hitTestElement(element2);
};
