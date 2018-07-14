
module Phina.Game.GameApp.Builder
  ( enableStatsB
  ) where

import Prelude

import Phina.Game.GameApp (class IsGameApp, enableStats)
import Phina.Types.Builder (Builder)
import Phina.Types.Monad.Builder (update)

enableStatsB ∷ ∀ a. IsGameApp a ⇒  Builder a Unit
enableStatsB = update enableStats
