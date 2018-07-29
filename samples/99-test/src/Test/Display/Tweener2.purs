-- | Tweener

module Test.Display.Tweener2
  ( Scene
  , sceneProxy
  ) where

import Prelude

import Effect.Class (liftEffect)
import Phina (class LabeledScene, class Writable, Builder, DisplayScene, SetupScene, Sprite, Tween, addChildB', addTweenB, animateB, build, by, call, color, deg, easeDefault, easeInCubic, easeInExpo, easeInOutCubic, easeInOutQuad, easeLinear, easeOutBounce, easeOutElastic, easeSwing, fade, fadeIn, fadeOut, from, make, moveBy, moveTo, newSprite, onPointStartB, play, rotateBy, rotateTo, scaleBy, scaleTo, sec, set, setLoop, setPropsB, setUpdateType, to, toParams, toSceneHandle, updateDelta, wait)
import Test.Assets (myFaceImg)
import Type.Prelude (Proxy(..))


foreign import data Scene ∷ Type

sceneProxy = Proxy ∷ Proxy Scene

instance labeledSceneScene ∷ LabeledScene Scene "Tweener2" DisplayScene () ()
  where
    sceneHandle _ = toSceneHandle setupScene


setupScene ∷ SetupScene DisplayScene () ()
setupScene _ exit = build do
  setPropsB {backgroundColor: color "#cbc"}
  addSprite {x: 80.0, y: 80.0} (by (toParams {height: 200.0}) (sec 2) easeInCubic)
  addSprite {x: 850.0, y: 550.0} (set (toParams {scaleX: 1.0}) *> from (toParams {scaleX: 3.0}) (sec 2) easeInCubic)
  addSprite {x: 120.0, y: 200.0} (moveTo 500.0 300.0 (sec 8) easeOutElastic)
  addSprite {x: 100.0, y: 600.0} (moveBy 100.0 (-100.0) (sec 2) easeOutBounce)
  addSprite {x: 200.0, y: 300.0} (rotateTo (deg 540) (sec 8) easeInExpo)
  addSprite {x: 600.0, y: 150.0} (rotateBy (deg 360) (sec 2) easeInOutCubic)
  addSprite {x: 850.0, y: 100.0} (scaleTo 0.01 (sec 8) easeSwing)
  addSprite {x: 480.0, y: 580.0, alpha: 0.2} (scaleBy 1.0 (sec 2) easeLinear)
  addSprite {x: 150.0, y: 480.0} (wait (sec 5) *> fade 0.2 (sec 3) easeDefault)
  addSprite {x: 250.0, y: 120.0} (fadeOut (sec 8) easeDefault)
  addSprite {x: 800.0, y: 320.0, alpha: 0.0} (fadeIn (sec 8) easeDefault)
  addChildB' $ make (newSprite myFaceImg {}) do
    tweener1 ← addTweenB do
      setLoop true
      to (toParams {alpha: 0.0}) (sec 1) easeInOutQuad
      to (toParams {alpha: 1.0}) (sec 1) easeInOutQuad
    tweener2 ← addTweenB do
      setLoop true
      rotateBy (deg 360) (sec 3) easeLinear
    tweener3 ← addTweenB do
      set $ toParams {x: -80.0, y: 700.0}
      moveTo 1000.0 (-100.0) (sec 10) easeLinear -- EaseInOutCirc
    _ ← liftEffect $ play tweener1
    _ ← liftEffect $ play tweener2
    _ ← liftEffect $ play tweener3
    pure unit
  onPointStartB (\_ → exit {})
  animateB $ (wait $ sec 10) *> (call $ exit {})


addSprite
   ∷ ∀ r
   . Writable Sprite r
  ⇒ r
  → Tween Sprite
  → Builder DisplayScene Unit
addSprite props tween = do
  addChildB'
    $ make (newSprite myFaceImg props)
      $ animateB (setUpdateType updateDelta *> setLoop true *> tween)
