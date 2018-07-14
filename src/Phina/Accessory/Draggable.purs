-- | phina.accessory.Draggable

module Phina.Accessory.Draggable
  ( class Draggable
  , enableDrag
  , onDragStart
  , onDrag
  , onDragEnd
  , onBackEnd
  ) where

import Effect (Effect)
import Effect.Uncurried (EffectFn1, EffectFn2, EffectFn3, runEffectFn1, runEffectFn2, runEffectFn3)

import Phina.Types.Duration (Duration)
import Phina.Util.EventDispatcher (class EventDispatcher)
import Phina.Util.EventDispatcher.Unsafe (unsafeOn)
import Phina.Util.Tween (Easing)

class EventDispatcher a ⇐ Draggable a

--

enableDrag ∷ ∀ a. Draggable a ⇒ a → Effect a
enableDrag = runEffectFn1 _enableDrag

onDragStart
   ∷ ∀ a b
   . Draggable a
  ⇒ (a → Effect b)
  → a
  → Effect a
onDragStart f = unsafeOn "dragstart" (\_ → f)

onDrag
   ∷ ∀ a b
   . Draggable a
  ⇒ (a → Effect b)
  → a
  → Effect a
onDrag f = unsafeOn "drag" (\_ → f)

onDragEnd
   ∷ ∀ a b
   . Draggable a
  ⇒ ((Duration → Easing → a → Effect a) → a → Effect b)
  → a
  → Effect a
onDragEnd = runEffectFn3 _onDragEnd back

onBackEnd
   ∷ ∀ a b
   . Draggable a
  ⇒ (a → Effect b)
  → a
  → Effect a
onBackEnd = runEffectFn2 _onBackEnd

--

back ∷ ∀ a. Duration → Easing → a → Effect a
back = runEffectFn3 _back

foreign import _enableDrag ∷ ∀ a. EffectFn1 a a

foreign import _onDragEnd
  ∷ ∀ a b
  . EffectFn3 (Duration → Easing → a → Effect a)
              ((Duration → Easing → a → Effect a) → a → Effect b) a a

foreign import _onBackEnd ∷ ∀ a b. EffectFn2 (a → Effect b) a a

foreign import _back ∷ ∀ a. EffectFn3 Duration Easing a a
