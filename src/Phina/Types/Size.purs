-- Phina.Types.Size

module Phina.Types.Size
  ( Size
  , SizeProps
  , getSize
  , setSize
  ) where

import Effect (Effect)
import Effect.Uncurried (EffectFn2, runEffectFn2)

import Phina.Types.Property (class HasProperty, class Readable, class Writable, Prop, getProps)

--

type Size = {width ∷ Number, height ∷ Number}

data SizeProps
instance hasPropertySize ∷ HasProperty SizeProps
  ( width ∷ Prop Number "r" "w"
  , height ∷ Prop Number "r" "w"
  )

getSize ∷ ∀ a. Readable a Size ⇒ a → Effect Size
getSize = getProps

setSize ∷ ∀ a. Writable a Size ⇒ Size → a → Effect a
setSize = runEffectFn2 _setSize

foreign import _setSize ∷ ∀ a. EffectFn2 Size a a
