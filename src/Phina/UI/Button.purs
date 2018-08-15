-- phina.ui.Button

module Phina.UI.Button
  ( Button
  , newButton
  , newButton'
  , onPush
  ) where

import Prelude

import Effect (Effect)
import Phina.Accessory.Draggable (class Draggable)
import Phina.Accessory.Flickable (class Flickable)
import Phina.Accessory.Tweener (class Tweenable)
import Phina.App.Element (class Container, class IsElement)
import Phina.App.Interactive (class Interactive)
import Phina.Display.DisplayElement (class IsDisplayElement)
import Phina.Display.Shape (ShapeProps)
import Phina.Types.Color (Color)
import Phina.Types.Property (class HasProperty, class Writable, Params, Prop)
import Phina.Unsafe (unsafeNew, unsafeSetProps)
import Phina.Util.EventDispatcher (class EventDispatcher)
import Phina.Util.EventDispatcher.Unsafe (unsafeOn)
import Prim.Row (class Union)

--

foreign import data Button ∷ Type

instance hasPropertyButton ∷
  ( HasProperty ShapeProps rs
  , Union rs
    ( cornerRadius ∷ Prop Number "r" "w"
    , text ∷ Prop String "r" "w"
    , fontColor ∷ Prop Color "r" "w"
    , fontSize ∷ Prop Number "r" "w"
    , fontWeight ∷ Prop String "r" "w"
    , fontFamily ∷ Prop String "r" "w"
    ) r
  )
  ⇒  HasProperty Button r

instance edButton ∷ EventDispatcher Button
instance isElementButton ∷ IsElement Button
instance containerButton ∷ Container Button
instance isDeButton ∷ IsDisplayElement Button
instance interactiveButton ∷ Interactive Button
instance draggableButton ∷ Draggable Button
instance flickableButton ∷ Flickable Button
instance tweenableButton ∷ Tweenable Button

--
newButton
   ∷ ∀ r
   . Writable Button r
  ⇒ r
  → Effect Button
newButton = unsafeNewButton

newButton' ∷ Params Button → Effect Button
newButton' = unsafeNewButton

onPush ∷ ∀ a. (Button → Effect a) → Button → Effect Button
onPush f = unsafeOn "push" \_ → f

unsafeNewButton ∷ ∀ a. a → Effect Button
unsafeNewButton params = do
  button ← unsafeNew "ui" "Button" {}
  unsafeSetProps params button
