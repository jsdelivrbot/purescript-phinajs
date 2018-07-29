-- | Grid

module Test.Util.Grid
  ( Scene
  , sceneProxy
  ) where

import Prelude

import Data.Array ((..))
import Data.Foldable (for_)
import Data.Int (hexadecimal, toStringAs)
import Phina (class LabeledScene, Builder, DisplayScene, SetupScene, addChildB', animateB, build, call, color, getSpanPos, getUnitX, getUnitY, newRectangleShape, onPointStartB, peek, sec, setPropsB, toSceneHandle, wait)
import Type.Prelude (Proxy(..))


foreign import data Scene ∷ Type

sceneProxy = Proxy ∷ Proxy Scene

instance labeledSceneScene ∷ LabeledScene Scene "Grid" DisplayScene () ()
  where
    sceneHandle _ = toSceneHandle setupScene


setupScene ∷ SetupScene DisplayScene () ()
setupScene _ exit = build do
  setPropsB {backgroundColor: color "#366"}
  addShapes
  onPointStartB (\_ → exit {})
  animateB $ (wait $ sec 10) *> (call $ exit {})


addShapes ∷ Builder DisplayScene Unit
addShapes = do
  scene ← peek
  for_ (1..15) \x →
    for_ (1..15) \y →
      addChildB' $ newShape scene x y
  where
    newShape scene x y = do
      pos ← getSpanPos x y scene
      uw ← getUnitX scene
      uh ← getUnitY scene
      newRectangleShape { x: pos.x
                        , y: pos.y
                        , width: uw - 8.0
                        , height: uh - 8.0
                        , strokeWidth: 1.0
                        , cornerRadius: 12.0
                        , fill: col
                        }
      where
        hx = toStringAs hexadecimal x
        hy = toStringAs hexadecimal y
        col = color $ "#d" <> hx <> hy
