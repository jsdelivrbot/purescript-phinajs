
module Phina.Util.EventDispatcher.Builder
  ( flareB
  , onB
  , onB'
  ) where

import Prelude

import Effect (Effect)

import Phina.Types.Builder (Builder)
import Phina.Types.Monad.Builder (update)
import Phina.Util.EventDispatcher (class Event, class EventDispatcher, flare, on, on')

flareB
   ∷ ∀ e p t
   . Event e p
  ⇒ EventDispatcher t
  ⇒ e
  → p
  → Builder t Unit
flareB e p = update $ flare e p

onB
   ∷ ∀ e p r t
   . Event e p
  ⇒ EventDispatcher t
  ⇒ e
  → (p → t → Effect r)
  → Builder t Unit
onB e h = update $ on e h

onB'
   ∷ ∀ e p r t
   . Event e p
  ⇒ EventDispatcher t
  ⇒ e
  → (t → Effect r)
  → Builder t Unit
onB' e h = update $ on' e h
