-- Phina.Types.Position

module Phina.Types.Position
  ( Position
  , setPosition
  , setPosition'
  , getPosition
  ) where

import Prelude

import Effect (Effect)
import Effect.Uncurried (EffectFn2, runEffectFn2)
import Unsafe.Coerce (unsafeCoerce)

import Phina.Types.Property (class Readable, class Writable)

--

type Position = {x ∷ Number, y ∷ Number}

setPosition ∷ ∀ a. Writable a Position ⇒ Position → a → Effect a
setPosition = runEffectFn2 _setPosition

setPosition' ∷ ∀ a. Writable a Position ⇒ Number → Number → a → Effect a
setPosition' x y = runEffectFn2 _setPosition {x: x, y: y}

getPosition ∷ ∀ a. Readable a Position ⇒ a → Effect Position
getPosition = pure <<< unsafeCoerce

--

foreign import _setPosition ∷ ∀ a. EffectFn2 Position a a
