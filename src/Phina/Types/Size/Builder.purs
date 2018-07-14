
module Phina.Types.Size.Builder
  ( getSizeB
  , setSizeB
  ) where

import Prelude

import Phina.Types.Builder (Builder)
import Phina.Types.Monad.Builder (eval, update)
import Phina.Types.Property (class Readable, class Writable)
import Phina.Types.Size (Size, getSize, setSize)

--

getSizeB ∷ ∀ a. Readable a Size ⇒ Builder a Size
getSizeB = eval getSize

setSizeB ∷ ∀ a. Writable a Size ⇒ Size → Builder a Unit
setSizeB = update <<< setSize
