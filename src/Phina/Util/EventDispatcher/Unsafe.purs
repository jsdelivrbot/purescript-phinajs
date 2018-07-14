
module Phina.Util.EventDispatcher.Unsafe
  (  unsafeOn
  ) where

import Effect (Effect)
import Effect.Uncurried (EffectFn3, runEffectFn3)

import Phina.Util.EventDispatcher.Class (class EventDispatcher)

unsafeOn
   ∷ ∀ a b c
   . EventDispatcher b
  ⇒ String
  → (a → b → Effect c)
  → b
  → Effect b
unsafeOn = runEffectFn3 _on

foreign import _on ∷ ∀ a f. EffectFn3 String f a a
