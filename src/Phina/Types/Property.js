//-----------------------------------------------------------------------------
// Phina.Core.Property

exports._modifyProp = function(label, func, instance) {
  instance[label] = func(instance[label]);
  return instance;
};
