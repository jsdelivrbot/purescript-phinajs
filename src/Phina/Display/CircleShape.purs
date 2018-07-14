-- phina.display.CircleShape

module Phina.Display.CircleShape
  ( CircleShape
  , newCircleShape
  , newCircleShape'
  ) where

import Effect (Effect)

import Phina.Accessory.Draggable (class Draggable)
import Phina.Accessory.Flickable (class Flickable)
import Phina.Accessory.Tweener (class Tweenable)
import Phina.App.Element (class Container, class IsElement)
import Phina.App.Interactive (class Interactive)
import Phina.Display.DisplayElement (class IsDisplayElement)
import Phina.Display.Shape (class IsShape, ShapeProps, newShape, newShape')
import Phina.Types.Property (class HasProperty, class Writable, Params)
import Phina.Util.EventDispatcher (class EventDispatcher)

--
foreign import data CircleShape ∷ Type

instance hasPropertyCircleShape
   ∷ HasProperty ShapeProps r
  ⇒ HasProperty CircleShape r

instance isShapeCircleShape ∷ IsShape CircleShape where
  shape _ = "CircleShape"

instance edCircleShape ∷ EventDispatcher CircleShape
instance isElementCircleShape ∷ IsElement CircleShape
instance containerCircleShape ∷ Container CircleShape
instance isDeCircleShape ∷ IsDisplayElement CircleShape
instance interactiveCircleShape ∷ Interactive CircleShape
instance draggableCircleShape ∷ Draggable CircleShape
instance flickableCircleShape ∷ Flickable CircleShape
instance tweenableCircleShape ∷ Tweenable CircleShape

--
newCircleShape ∷ ∀ r. Writable CircleShape r ⇒ r → Effect CircleShape
newCircleShape = newShape

newCircleShape' ∷ Params CircleShape → Effect CircleShape
newCircleShape' = newShape'
