//-----------------------------------------------------------------------------
// Phina.Display.Sprite

/* global phina */

exports._newSpriteWithShape = function(shape) {
  shape.flare('enterframe');
  return phina.display.Sprite(shape.canvas);
};

exports._setAnimation = function(ss, sprite) {
  if (sprite.__frameAnimation) {
    sprite.__frameAnimation.remove();
  }

  if (typeof ss !== 'string') {
    ss = ss.key;
  }

  sprite.__frameAnimation = phina.accessory.FrameAnimation(ss).attachTo(sprite);

  return sprite;
};

exports._playAnimation = function(name, keep, sprite) {
  if (sprite.__frameAnimation) {
    sprite.__frameAnimation.gotoAndPlay(name, keep);
  }

  return sprite;
};
