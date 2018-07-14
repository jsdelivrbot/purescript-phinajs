
module Phina.Types.Monad.Builder
  ( class MonadBuilder
  , update
  , eval
  , build
  , make
  , peek
  ) where

import Prelude

import Control.Monad.State (class MonadState, get)
import Effect (Effect)

--

class (MonadState a b, Monad m) ⇐ MonadBuilder a b m | b → m a where
  update ∷ (a → Effect a) → b Unit
  eval ∷ ∀ c. (a → Effect c) → b c
  build ∷ ∀ c. b c → a → m a
  make ∷ ∀ c. Effect a → b c → Effect a

peek ∷ ∀ a b m. MonadBuilder a b m ⇒ b a
peek = get
