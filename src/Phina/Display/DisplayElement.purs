-- phina.app.Object2D & phina.display.DisplayElement

module Phina.Display.DisplayElement
  ( BoundingType
  , boundingRect
  , boundingCircle
  , boundingNone
  , DisplayElementProps
  , class IsDisplayElement
  , hitTest
  , hitTestElement
  , DisplayElement
  , newDisplayElement
  , newDisplayElement'
  , toDisplayElement
  ) where

import Prelude

import Data.Function (on)
import Effect (Effect)
import Effect.Uncurried (EffectFn2, runEffectFn2)
import Prim.Row (class Union)
import Unsafe.Coerce (unsafeCoerce)

import Phina.Accessory.Draggable (class Draggable)
import Phina.Accessory.Flickable (class Flickable)
import Phina.Accessory.Tweener (class Tweenable)
import Phina.App.Element (class Container, class IsElement, ElementProps)
import Phina.App.Interactive (class Interactive, InteractiveProps)
import Phina.Types.Angle (Angle)
import Phina.Types.Position (Position)
import Phina.Types.Property (class HasProperty, class Writable, Params, Prop)
import Phina.Types.Size (SizeProps)
import Phina.Unsafe (unsafeNew, unsafeSetProps)
import Phina.Util.EventDispatcher (class EventDispatcher)

--

foreign import data BoundingType ∷ Type

boundingRect ∷ BoundingType
boundingRect = unsafeCoerce "rect"

boundingCircle ∷ BoundingType
boundingCircle = unsafeCoerce "circle"

boundingNone ∷ BoundingType
boundingNone = unsafeCoerce "none"

instance eqBoundingType ∷ Eq BoundingType where
  eq = eq `on` unsafeCoerce ∷ BoundingType → String

--

data DisplayElementProps
instance hasPropertyDisplayElementProps ∷
  ( HasProperty SizeProps rs
  , HasProperty ElementProps re
  , HasProperty InteractiveProps ri
  , Union rs re r1
  , Union r1 ri r2
  , Union r2
    ( -- property from phina.app.Object2D
      x ∷ Prop Number "r" "w"
    , y ∷ Prop Number "r" "w"
    , scaleX ∷ Prop Number "r" "w"
    , scaleY ∷ Prop Number "r" "w"
    , originX ∷ Prop Number "r" "w"
    , originY ∷ Prop Number "r" "w"
    , top ∷ Prop Number "r" "w"
    , right ∷ Prop Number "r" "w"
    , bottom ∷ Prop Number "r" "w"
    , left ∷ Prop Number "r" "w"
    , centerX ∷ Prop Number "r" "-"
    , centerY ∷ Prop Number "r" "-"
    , radius ∷ Prop Number "r" "w"
    , boundingType ∷ Prop BoundingType "r" "w"
    , rotation ∷ Prop Angle "r" "w"
      -- property from phina.display.DisplayElement
    , visible ∷ Prop Boolean "r" "w"
    , alpha ∷ Prop Number "r" "w"
    ) r
  )
  ⇒ HasProperty DisplayElementProps r

class (IsElement a, Interactive a) ⇐ IsDisplayElement a

--

hitTest ∷ ∀ a. IsDisplayElement a ⇒ Position → a → Effect Boolean
hitTest = runEffectFn2 _hitTest

hitTestElement
   ∷ ∀ a b
   . IsDisplayElement a
  ⇒ IsDisplayElement b
  ⇒ a
  → b
  → Effect Boolean
hitTestElement = runEffectFn2 _hitTestElement

foreign import _hitTest ∷ ∀ a. EffectFn2 Position a Boolean

foreign import _hitTestElement ∷ ∀ a b. EffectFn2 a b Boolean

--

foreign import data DisplayElement ∷ Type

instance hasPropertyDisplayElement ∷
  ( HasProperty DisplayElementProps r
  ) ⇒ HasProperty DisplayElement r

instance edDisplayElement ∷ EventDispatcher DisplayElement
instance isElementDisplayElement ∷ IsElement DisplayElement
instance containerDisplayElement ∷ Container DisplayElement
instance interactiveDisplayElement ∷ Interactive DisplayElement
instance isDeDisplayElement ∷ IsDisplayElement DisplayElement
instance draggableDisplayElement ∷ Draggable DisplayElement
instance flickableDisplayElement ∷ Flickable DisplayElement
instance tweenableDisplayElement ∷ Tweenable DisplayElement

newDisplayElement
   ∷ ∀ r
   . Writable DisplayElement r
  ⇒ r
  → Effect DisplayElement
newDisplayElement = unsafeNewDisplayElement

newDisplayElement' ∷ Params DisplayElement → Effect DisplayElement
newDisplayElement' = unsafeNewDisplayElement

toDisplayElement ∷ ∀ a. IsDisplayElement a ⇒ a → DisplayElement
toDisplayElement = unsafeCoerce

unsafeNewDisplayElement ∷ ∀ a. a → Effect DisplayElement
unsafeNewDisplayElement params = do
  element ← unsafeNew "display" "DisplayElement" {}
  unsafeSetProps params element
