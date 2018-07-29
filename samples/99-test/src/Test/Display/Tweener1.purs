-- | Tweener to

module Test.Display.Tweener1
  ( Scene
  , sceneProxy
  ) where

import Prelude

import Data.Traversable (traverse_)
import Data.Tuple (Tuple(..), fst, snd)
import Phina (class LabeledScene, class Writable, Builder, DisplayScene, Easing, Params, PolygonShape, SetupScene, addChildB', animateB, build, call, color, easeInBounce, easeInCubic, easeInOutBack, easeInOutBounce, easeInOutCubic, easeInOutQuad, easeInQuad, easeLinear, easeOutBack, easeOutBounce, easeOutCubic, easeOutInBack, easeOutInBounce, easeOutQuad, easeSwing, getSizeB, make, newPolygonShape, onPointStartB, sec, setPropsB, setUpdateType, to, toParams, toSceneHandle, updateDelta, wait)
import Type.Prelude (Proxy(..))


foreign import data Scene ∷ Type

sceneProxy = Proxy ∷ Proxy Scene

instance labeledSceneScene ∷ LabeledScene Scene "Tweener1" DisplayScene () ()
  where
    sceneHandle _ = toSceneHandle setupScene


setupScene ∷ SetupScene DisplayScene () ()
setupScene _ exit = build do
  setPropsB {backgroundColor: color "#ccb"}
  traverse_ (\a → addMovingShape {y: fst a} $ snd a)
  	[ Tuple 40.0 easeLinear
  	, Tuple 80.0 easeSwing
  	, Tuple 120.0 easeInQuad
  	, Tuple 160.0 easeOutQuad
  	, Tuple 200.0 easeInOutQuad
  	, Tuple 240.0 easeInCubic
  	, Tuple 280.0 easeOutCubic
  	, Tuple 320.0 easeInOutCubic
  -- :
  	, Tuple 360.0 easeOutBack
  	, Tuple 400.0 easeInOutBack
  	, Tuple 440.0 easeOutInBack
  	, Tuple 480.0 easeInBounce
  	, Tuple 520.0 easeOutBounce
  	, Tuple 560.0 easeInOutBounce
  	, Tuple 600.0 easeOutInBounce
    ]
  onPointStartB (\_ → exit {})
  animateB $ (wait $ sec 10) *> (call $ exit {})


addMovingShape
   ∷ ∀ r
   . Writable PolygonShape r
  ⇒ r
  → Easing
  → Builder DisplayScene Unit
addMovingShape props easing = do
  size ← getSizeB
  addChildB' $ make (newPolygonShape {x: startX, radius: 16.0, sides: 8.0}) do
                  setPropsB props
                  animateB (tween size)
  where
    startX = 100.0
    tween sz = do
      setUpdateType updateDelta
      wait (sec 1)
      to (toParams {x: sz.width - startX} ∷ Params PolygonShape) (sec 8) easing
