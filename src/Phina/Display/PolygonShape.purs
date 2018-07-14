-- phina.display.PolygonShape

module Phina.Display.PolygonShape
  ( PolygonShape
  , newPolygonShape
  , newPolygonShape'
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
import Phina.Types.Property (class HasProperty, class Writable, Params)
import Phina.Util.EventDispatcher (class EventDispatcher)

--
foreign import data PolygonShape ∷ Type

instance hasPropertyPolygonShape ∷
  ( HasProperty ShapeProps rs
  , HasProperty Sides ri
  , Union rs ri r
  )
  ⇒ HasProperty PolygonShape r

instance isShapePolygonShape ∷ IsShape PolygonShape where
  shape _ = "PolygonShape"

instance edPolygonShape ∷ EventDispatcher PolygonShape
instance isElementPolygonShape ∷ IsElement PolygonShape
instance containerPolygonShape ∷ Container PolygonShape
instance isDePolygonShape ∷ IsDisplayElement PolygonShape
instance interactivePolygonShape ∷ Interactive PolygonShape
instance draggablePolygonShape ∷ Draggable PolygonShape
instance flickablePolygonShape ∷ Flickable PolygonShape
instance tweenablePolygonShape ∷ Tweenable PolygonShape

newPolygonShape ∷ ∀ r. Writable PolygonShape r ⇒ r → Effect PolygonShape
newPolygonShape = newShape

newPolygonShape' ∷ Params PolygonShape → Effect PolygonShape
newPolygonShape' = newShape'
