
module Phina.Accessory.Draggable.Builder
  ( onDragStartB
  , onDragB
  , enableDragB
  , onDragEndB
  , onBackEndB
  ) where

import Prelude

import Effect (Effect)

import Phina.Accessory.Draggable (class Draggable, enableDrag, onBackEnd, onDrag, onDragEnd, onDragStart)
import Phina.Types.Builder (Builder)
import Phina.Types.Duration (Duration)
import Phina.Types.Monad.Builder (update)
import Phina.Util.Tween (Easing)

--

onDragStartB ∷ ∀ a b. Draggable a ⇒ (a → Effect b) → Builder a Unit
onDragStartB = update <<< onDragStart

enableDragB ∷ ∀ a. Draggable a ⇒ Builder a Unit
enableDragB = update enableDrag

onDragB ∷ ∀ a b. Draggable a ⇒ (a → Effect b) → Builder a Unit
onDragB = update <<< onDrag

onDragEndB
   ∷ ∀ a b
   . Draggable a
  ⇒ ((Duration → Easing → a → Effect a) → a → Effect b)
  → Builder a Unit
onDragEndB = update <<< onDragEnd

onBackEndB ∷ ∀ a b. Draggable a ⇒ (a → Effect b) → Builder a Unit
onBackEndB = update <<< onBackEnd
