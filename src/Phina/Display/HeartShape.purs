-- phina.display.HeartShape

module Phina.Display.HeartShape
  ( HeartShape
  , newHeartShape
  , newHeartShape'
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
import Phina.Types.Angle (Angle)
import Phina.Types.Property (class HasProperty, class Writable, Params, Prop)
import Phina.Util.EventDispatcher (class EventDispatcher)

--
foreign import data HeartShape ∷ Type

instance hasPropertyHeartShape ∷
  ( HasProperty ShapeProps rs
  , Union rs
    ( cornerAngle ∷ Prop Angle "r" "w"
    ) r
  )
  ⇒ HasProperty HeartShape r

instance isShapeHeartShape ∷ IsShape HeartShape where
  shape _ = "HeartShape"

instance edHeartShape ∷ EventDispatcher HeartShape
instance isElementHeartShape ∷ IsElement HeartShape
instance containerHeartShape ∷ Container HeartShape
instance isDeHeartShape ∷ IsDisplayElement HeartShape
instance interactiveHeartShape ∷ Interactive HeartShape
instance draggableHeartShape ∷ Draggable HeartShape
instance flickableHeartShape ∷ Flickable HeartShape
instance tweenableHeartShape ∷ Tweenable HeartShape

--
newHeartShape ∷ ∀ r. Writable HeartShape r ⇒ r → Effect HeartShape
newHeartShape = newShape

newHeartShape' ∷ Params HeartShape → Effect HeartShape
newHeartShape' = newShape'
