-- | Sprites

module Test.Display.Sprite
  ( Scene
  , sceneProxy
  ) where

import Prelude

import Data.Foldable (traverse_)
import Phina (class LabeledScene, Builder, DisplayScene, SetupScene, addChildB', animateB, build, call, color, deg, newSprite', onPointStartB, sec, setPropsB, toParams, toSceneHandle, wait)
import Test.Assets (myFaceImg)
import Type.Prelude (Proxy(..))

foreign import data Scene ∷ Type

sceneProxy = Proxy ∷ Proxy Scene

instance labeledSceneScene ∷ LabeledScene Scene "Sprite" DisplayScene () ()
  where
    sceneHandle _ = toSceneHandle setupScene


setupScene ∷ SetupScene DisplayScene () ()
setupScene _ exit = build do
  setPropsB {backgroundColor: color "#9b6"}
  addSprites
  onPointStartB (\_ → exit {})
  animateB $ (wait $ sec 10) *> (call $ exit {})


addSprites ∷ Builder DisplayScene Unit
addSprites = traverse_ (addChildB' <<< newSprite' myFaceImg) params
  where
    params =
      [ toParams {x: 480.0, y: 320.0}
      , toParams {x: 750.0, y: 500.0, rotation: deg 90}
      , toParams {x: 200.0, y: 200.0, width: 200.0, height: 50.0, rotation: deg 30}
      , toParams {x: 700.0, y: 200.0, rotation: deg (-120)}
      , toParams {x: 800.0, y: 150.0, scaleX: 3.0, scaleY: 3.0, alpha: 0.5}
      , toParams {x: 360.0, y: 480.0, scaleX: 3.0, scaleY: 8.0, rotation: deg (-180), alpha: 0.2}
      ]
