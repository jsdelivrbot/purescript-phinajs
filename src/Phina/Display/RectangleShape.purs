-- phina.display.RectangleShape

module Phina.Display.RectangleShape
  ( RectangleShape
  , newRectangleShape
  , newRectangleShape'
  ) where

import Effect (Effect)
import Prim.Row (class Union)

import Phina.Accessory.Draggable (class Draggable)
import Phina.Accessory.Flickable (class Flickable)
import Phina.Accessory.Tweener (class Tweenable)
import Phina.App.Element (class Container, class IsElement)
import Phina.App.Interactive (class Interactive)
import Phina.Display.DisplayElement (class IsDisplayElement)
import Phina.Display.Shape (class IsShape, ShapeProps, newShape, newShape')
import Phina.Types.Property (class HasProperty, class Writable, Params, Prop)
import Phina.Util.EventDispatcher (class EventDispatcher)

--
foreign import data RectangleShape ∷ Type

instance hasPropertyRectangleShape ∷
  ( HasProperty ShapeProps rs
  , Union rs
    ( cornerRadius ∷ Prop Number "r" "w"
    ) r
  )
  ⇒  HasProperty RectangleShape r

instance isShapeRectangleShape ∷ IsShape RectangleShape where
  shape  _ = "RectangleShape"

instance edRectangleShape ∷ EventDispatcher RectangleShape
instance isElementRectangleShape ∷ IsElement RectangleShape
instance containerRectangleShape ∷ Container RectangleShape
instance isDeRectangleShape ∷ IsDisplayElement RectangleShape
instance interactiveRectangleShape ∷ Interactive RectangleShape
instance draggableRectangleShape ∷ Draggable RectangleShape
instance flickableRectangleShape ∷ Flickable RectangleShape
instance tweenableRectangleShape ∷ Tweenable RectangleShape

--
newRectangleShape
   ∷ ∀ r
   . Writable RectangleShape r
  ⇒ r
  → Effect RectangleShape
newRectangleShape = newShape

newRectangleShape' ∷ Params RectangleShape → Effect RectangleShape
newRectangleShape' = newShape'
