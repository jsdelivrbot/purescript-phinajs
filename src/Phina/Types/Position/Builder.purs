
module Phina.Types.Position.Builder
  ( setPositionB
  , setPositionB'
  , getPositionB
  ) where

import Prelude

import Phina.Types.Builder (Builder)
import Phina.Types.Monad.Builder (eval, update)
import Phina.Types.Position (Position, getPosition, setPosition, setPosition')
import Phina.Types.Property (class Readable, class Writable)

--

setPositionB ∷ ∀ a. Writable a Position ⇒ Position → Builder a Unit
setPositionB = update <<< setPosition

setPositionB' ∷ ∀ a. Writable a Position ⇒ Number → Number → Builder a Unit
setPositionB' x y = update $ setPosition' x y

getPositionB ∷ ∀ a. Readable a Position ⇒ Builder a Position
getPositionB = eval getPosition
