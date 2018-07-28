
module Phina.App.Interactive.Builder
  ( onPointOverB
  , onPointOutB
  , onPointStartB
  , onPointEndB
  , onPointStayB
  , onPointMoveB
  , setInteractiveB
  , getInteractiveB
  ) where

import Prelude

import Effect (Effect)

import Phina.App.Interactive (class Interactive, PointEvent, getInteractive, onPointEnd, onPointMove, onPointOut, onPointOver, onPointStart, onPointStay, setInteractive)
import Phina.Types.Builder (Builder)
import Phina.Types.Monad.Builder (eval, update)
import Phina.Types.Property (class ReadableProp, class WritableProp)

type OnPoint
   = ∀ a b
   . Interactive a
  ⇒ (PointEvent → a → Effect b)
  → Builder a Unit

onPointOverB ∷ OnPoint
onPointOverB = update <<< onPointOver

onPointOutB ∷ OnPoint
onPointOutB = update <<< onPointOut

onPointStartB ∷ OnPoint
onPointStartB = update <<< onPointStart

onPointEndB ∷ OnPoint
onPointEndB = update <<< onPointEnd

onPointStayB ∷ OnPoint
onPointStayB = update <<< onPointStay

onPointMoveB ∷ OnPoint
onPointMoveB = update <<< onPointMove

setInteractiveB
   ∷ ∀ a
   . Interactive a
  ⇒ WritableProp a "interactive" Boolean
  ⇒ Boolean
  → Builder a Unit
setInteractiveB = update <<< setInteractive

getInteractiveB
   ∷ ∀ a
   . Interactive a
  ⇒ ReadableProp a "interactive" Boolean
  ⇒ Builder a Boolean
getInteractiveB = eval getInteractive
