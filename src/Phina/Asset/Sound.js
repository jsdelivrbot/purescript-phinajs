//-----------------------------------------------------------------------------
// Phina.Asset.Sound

exports._play = function(sound) {
  return sound.stop().play();
};

exports._stop = function(sound) {
  return sound.stop();
};

exports._pause = function(sound) {
  sound.source != null && sound.pause();
  return sound;
};

exports._resume = function(sound) {
  sound.source != null && sound.resume();
  return sound;
};
