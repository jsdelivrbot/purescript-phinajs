
module Phina.Display.Label.Builder
  ( setTextB
  , getTextB
  ) where

import Prelude

import Phina.Display.Label (Label, getText, setText)
import Phina.Types.Builder (Builder)
import Phina.Types.Monad.Builder (eval, update)

--

setTextB ∷ String → Builder Label Unit
setTextB = update <<< setText

getTextB ∷ Builder Label String
getTextB = eval getText
