
module Phina.Accessory.Flickable.Builder
  ( setFlickB
  , onFlickStartB
  , onFlickCancelB
  ) where

import Prelude

import Effect (Effect)

import Phina.Accessory.Flickable (class Flickable, FlickDirection, onFlickCancel, onFlickStart, setFlick)
import Phina.Types.Builder (Builder)
import Phina.Types.Monad.Builder (update)

setFlickB
   ∷ ∀ a
   . Flickable a
  ⇒ Number
  → FlickDirection
  → Builder a Unit
setFlickB f d = update $ setFlick f d

onFlickStartB
   ∷ ∀ a b
   . Flickable a
  ⇒ (a → Effect b)
  → Builder a Unit
onFlickStartB = update <<< onFlickStart

onFlickCancelB
   ∷ ∀ a b
   . Flickable a
  ⇒ (a → Effect b)
  → Builder a Unit
onFlickCancelB = update <<< onFlickCancel
