-- phina.display.StarShape

module Phina.Display.StarShape
  ( StarShape
  , newStarShape
  , newStarShape'
  ) where

import Effect (Effect)
import Prim.Row (class Union)

import Phina.Accessory.Draggable (class Draggable)
import Phina.Accessory.Flickable (class Flickable)
import Phina.Accessory.Tweener (class Tweenable)
import Phina.App.Element (class Container, class IsElement)
import Phina.App.Interactive (class Interactive)
import Phina.Display.DisplayElement (class IsDisplayElement)
import Phina.Display.Shape (class IsShape, ShapeProps, Sides, newShape, newShape')
import Phina.Types.Property (class HasProperty, class Writable, Params, Prop)
import Phina.Util.EventDispatcher (class EventDispatcher)

--
foreign import data StarShape ∷ Type

instance hasPropertyStarShape ∷
  ( HasProperty ShapeProps rs
  , HasProperty Sides ri
  , Union rs ri ra
  , Union ra
    ( sideIndent ∷ Prop Number "r" "w" )
    r
  )
  ⇒ HasProperty StarShape r

instance isShapeStarShape ∷ IsShape StarShape where
  shape _ = "StarShape"

instance edStarShape ∷ EventDispatcher StarShape
instance isElementStarShape ∷ IsElement StarShape
instance containerStarShape ∷ Container StarShape
instance isDeStarShape ∷ IsDisplayElement StarShape
instance interactiveStarShape ∷ Interactive StarShape
instance draggableStarShape ∷ Draggable StarShape
instance flickableStarShape ∷ Flickable StarShape
instance tweenableStarShape ∷ Tweenable StarShape

--
newStarShape ∷ ∀ r. Writable StarShape r ⇒ r → Effect StarShape
newStarShape = newShape

newStarShape' ∷ Params StarShape → Effect StarShape
newStarShape' = newShape'
