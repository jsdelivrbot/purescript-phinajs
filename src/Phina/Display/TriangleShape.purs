-- phina.display.TriangleShape

module Phina.Display.TriangleShape
  ( TriangleShape
  , newTriangleShape
  , newTriangleShape'
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
foreign import data TriangleShape ∷ Type

instance hasPropertyTriangleShape
   ∷ HasProperty ShapeProps r
  ⇒ HasProperty TriangleShape r

instance isShapeTriangleShape ∷ IsShape TriangleShape where
  shape _ = "TriangleShape"

instance edTriangleShape ∷ EventDispatcher TriangleShape
instance isElementTriangleShape ∷ IsElement TriangleShape
instance containerTriangleShape ∷ Container TriangleShape
instance isDeTriangleShape ∷ IsDisplayElement TriangleShape
instance interactiveTriangleShape ∷ Interactive TriangleShape
instance draggableTriangleShape ∷ Draggable TriangleShape
instance flickableTriangleShape ∷ Flickable TriangleShape
instance tweenableTriangleShape ∷ Tweenable TriangleShape

--
newTriangleShape ∷ ∀ r. Writable TriangleShape r ⇒ r → Effect TriangleShape
newTriangleShape = newShape

newTriangleShape' ∷ Params TriangleShape → Effect TriangleShape
newTriangleShape' = newShape'
