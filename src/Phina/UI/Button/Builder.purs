
module Phina.UI.Button.Builder
  ( onPushB
  ) where

import Prelude

import Effect (Effect)

import Phina.Types.Builder (Builder)
import Phina.Types.Monad.Builder (update)
import Phina.UI.Button (Button, onPush)

--

onPushB
   ∷ ∀ a
   . (Button → Effect a)
  → Builder Button Unit
onPushB = update <<< onPush
