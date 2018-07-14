//-----------------------------------------------------------------------------
// Phina.Util.EventDispatcher.Unsafe

exports._on = function(event, f, instance) {
  return instance.on(event, function(params) {
    return f(params)(this)();
  });
};
