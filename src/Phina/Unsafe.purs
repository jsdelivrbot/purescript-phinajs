
module Phina.Unsafe
  ( unsafeGetProp
  , unsafeSetProp
  , unsafeSetProps
  , unsafeNew
  ) where

import Data.Function.Uncurried (Fn2, runFn2)
import Effect (Effect)
import Effect.Uncurried (EffectFn2, EffectFn3, runEffectFn2, runEffectFn3)

--

unsafeGetProp ∷ ∀ a b. String → a → b
unsafeGetProp = runFn2 _unsafeGetProp

unsafeSetProp ∷ ∀ a b c. String → a → b → Effect c
unsafeSetProp = runEffectFn3 _unsafeSetProp

unsafeSetProps ∷ ∀ a b c. a → b → Effect c
unsafeSetProps = runEffectFn2 _unsafeSetProps

unsafeNew ∷ ∀ a b. String → String → a → Effect b
unsafeNew = runEffectFn3 _unsafeNew

--

foreign import _unsafeGetProp ∷ ∀ a b. Fn2 String a b
foreign import _unsafeSetProp ∷ ∀ a b c. EffectFn3 String a b c
foreign import _unsafeSetProps ∷ ∀ a b c. EffectFn2 a b c
foreign import _unsafeNew ∷ ∀ a b. EffectFn3 String String a b
