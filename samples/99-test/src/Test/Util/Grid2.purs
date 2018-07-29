-- | Grid

module Test.Util.Grid2
  ( Scene
  , sceneProxy
  ) where

import Prelude

import Data.Array ((..))
import Data.Foldable (for_)
import Data.Int (hexadecimal, toStringAs)
import Effect (Effect)
import Phina (class LabeledScene, Builder, Color, DisplayScene, Position, RectangleShape, SetupScene, Size, addChildB', animateB, build, call, color, getCenter, getCenterPosB, getSizeB, getSpan, getUnit, make, newGrid, newRectangleShape, onPointStartB, sec, setPositionB, setPropsB, setSizeB, toSceneHandle, wait)
import Type.Prelude (Proxy(..))


foreign import data Scene ∷ Type

sceneProxy = Proxy ∷ Proxy Scene

instance labeledSceneScene ∷ LabeledScene Scene "Grid2" DisplayScene () ()
  where
    sceneHandle _ = toSceneHandle setupScene


setupScene ∷ SetupScene DisplayScene () ()
setupScene _ exit = build do
  setPropsB {backgroundColor: color "#377"}
  size ← getSizeB
  pos ← getCenterPosB
  addChildB' $ newGridRectangle pos size 8.0 $ color "#0cc"
  onPointStartB (\_ → exit {})
  animateB $ (wait $ sec 10) *> (call $ exit {})


newGridRectangle
   ∷ Position
  → Size
  → Number
  → Color
  → Effect RectangleShape
newGridRectangle pos size margin col = do
  let
    rectSize = size - {width: margin, height: margin}
    params =  { stroke: color "black"
              , strokeWidth: 2.0
              , cornerRadius: 8.0
              , fill: col
              }
  make (newRectangleShape params) do
    setPositionB pos
    setSizeB rectSize
    addGridRectangles rectSize margin


addGridRectangles ∷ Size → Number → Builder RectangleShape Unit
addGridRectangles size margin = do
  let
    split = 4
    colUnit = 16 / split
    gridX = newGrid size.width split false 0.0
    gridY = newGrid size.height split false 0.0
    w = getUnit gridX
    h = getUnit gridY
  when (w > margin * 2.0 && h > margin * 2.0) $
    for_ (0..(split - 1)) \x →
      for_ (0..(split - 1)) \y →
        let
          rectPos = {x: getSpan x gridX, y: getSpan y gridY}
                  - {x: getCenter gridX, y: getCenter gridY}
                  + {x: w / 2.0, y: h / 2.0}
          rectSize = {width: w, height: h}
          r = toStringAs hexadecimal (x * colUnit)
          g = toStringAs hexadecimal (16 - (y + 1) * colUnit)
          col' = color $ "#" <> r <> g <> "c"
        in
          addChildB' $ newGridRectangle rectPos rectSize margin col'
