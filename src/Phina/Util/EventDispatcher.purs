-- phina.util.EventDispatcher

module Phina.Util.EventDispatcher
  ( module Phina.Util.EventDispatcher.Class
  , flare
  , on
  , on'
  ) where

import Effect (Effect)
import Effect.Uncurried (EffectFn3, runEffectFn3)

import Phina.Util.EventDispatcher.Class (class Event, class EventDispatcher, event)
import Phina.Util.EventDispatcher.Unsafe (unsafeOn)

--

flare ∷ ∀ e p t. Event e p ⇒ EventDispatcher t ⇒ e → p → t → Effect t
flare e p = runEffectFn3 _flare (event e) {value: p}

on
   ∷ ∀ e p r t
   . Event e p
  ⇒ EventDispatcher t
  ⇒ e
  → (p → t → Effect r)
  → t
  → Effect t
on e h = unsafeOn (event e) \p → h p.value

on'
   ∷ ∀ e p r t
   . Event e p
  ⇒ EventDispatcher t
  ⇒ e
  → (t → Effect r)
  → t
  → Effect t
on' e h = unsafeOn (event e) \_ → h

foreign import _flare ∷ ∀ a b. EffectFn3 String a b b
