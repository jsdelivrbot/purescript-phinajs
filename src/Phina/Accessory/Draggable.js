//-----------------------------------------------------------------------------
// Phina.Accessory.Draggable

exports._enableDrag = function(element) {
  element.draggable.enable();
  return element;
};

exports._onDragEnd = function(back, func, element) {
  element.on('dragend', function() {
    func(back)(this)();
  });

  return element;
};

exports._onBackEnd = function(func, element) {
  element.draggable.on('backend', function() {
    return func(element)();
  });

  return element;
};

exports._back = function(duration, easing, element) {
  element.draggable.back(duration, easing);
  return element;
};
