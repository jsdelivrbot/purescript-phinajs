-- phina.display.Label

module Phina.Display.Label
  ( Label
  , newLabel
  , newLabel'
  , setText
  , getText
  ) where

import Effect (Effect)
import Prim.Row (class Union)
import Type.Prelude (SProxy(..))

import Phina.Accessory.Draggable (class Draggable)
import Phina.Accessory.Flickable (class Flickable)
import Phina.Accessory.Tweener (class Tweenable)
import Phina.App.Element (class Container, class IsElement)
import Phina.App.Interactive (class Interactive)
import Phina.Display.DisplayElement (class IsDisplayElement)
import Phina.Display.Shape (class IsShape, ShapeProps, newShape, newShape')
import Phina.Types.Property (class HasProperty, class Writable, Params, Prop, getProp, setProp)
import Phina.Util.EventDispatcher (class EventDispatcher)

--
foreign import data Label ∷ Type

instance hasPropertyLabel ∷
  ( HasProperty ShapeProps rs
  , Union rs
    ( text ∷ Prop String "r" "w"
    , fontSize ∷ Prop Number "r" "w"
    , fontWeight ∷ Prop String "r" "w"
    , fontFamily ∷ Prop String "r" "w"
    , font ∷ Prop String "r" "-"
    , align ∷ Prop String "r" "w"
    , baseline ∷ Prop String "r" "w"
    , lineHeight ∷ Prop Number "r" "w"
    ) r
  )
  ⇒ HasProperty Label r

instance isShapeLabel ∷ IsShape Label where
  shape _ = "Label"

instance edLabel ∷ EventDispatcher Label
instance isElementLabel ∷ IsElement Label
instance containerLabel ∷ Container Label
instance isDeLabel ∷ IsDisplayElement Label
instance interactiveLabel ∷ Interactive Label
instance draggableLabel ∷ Draggable Label
instance flickableLabel ∷ Flickable Label
instance tweenableLabel ∷ Tweenable Label

--
newLabel ∷ ∀ r. Writable Label r ⇒ r → Effect Label
newLabel = newShape

newLabel' ∷ Params Label → Effect Label
newLabel' = newShape'

setText ∷ String → Label → Effect Label
setText = setProp (SProxy ∷ SProxy "text")

getText ∷ Label → Effect String
getText = getProp (SProxy ∷ SProxy "text")
