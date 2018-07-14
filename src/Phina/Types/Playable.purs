
module Phina.Types.Playable
  ( class Playable
  , play
  , stop
  , pause
  , resume
  ) where

import Effect (Effect)

class Playable a where
  play ∷ a → Effect a
  stop ∷ a → Effect a
  pause ∷ a → Effect a
  resume ∷ a → Effect a
