
module Phina.App.Element.Builder
  ( onEnterframeB
  , removeB
  , setUpdaterB
  , wakeUpB
  , sleepB
  , addChildB
  , addChildB'
  , addChildToB
  , onAddedB
  , onRemovedB
  ) where

import Prelude

import Effect (Effect)
import Effect.Class (liftEffect)

import Phina.App.Element (class Container, class IsElement, addChild, addChildTo, onAdded, onEnterframe, onRemoved, remove, setUpdater, sleep, wakeUp)
import Phina.Game.GameApp (GameApp)
import Phina.Types.Builder (Builder)
import Phina.Types.Monad.Builder (update)
import Phina.Types.Property (class WritableProp)

onEnterframeB
   ∷ ∀ a b
   . IsElement a
  ⇒ ({app ∷ GameApp} → a → Effect b)
  → Builder a Unit
onEnterframeB = update <<< onEnterframe

removeB ∷ ∀ a. IsElement a ⇒ Builder a Unit
removeB = update remove

setUpdaterB
   ∷ ∀ a b
   . IsElement a
  ⇒ (GameApp → a → Effect b)
  → Builder a Unit
setUpdaterB = update <<< setUpdater

wakeUpB ∷ ∀ a. WritableProp a "awake" Boolean ⇒ Builder a Unit
wakeUpB = update $ wakeUp

sleepB ∷ ∀ a. WritableProp a "awake" Boolean ⇒ Builder a Unit
sleepB = update $ sleep

addChildB ∷ ∀ a b. IsElement a ⇒ Container b ⇒ a → Builder b Unit
addChildB = update <<< addChild

addChildB' ∷ ∀ a b. IsElement a ⇒ Container b ⇒ Effect a → Builder b Unit
addChildB' m = liftEffect m >>= addChildB

addChildToB ∷ ∀ a b. IsElement a ⇒ Container b ⇒ b → Builder a Unit
addChildToB = update <<< addChildTo

onAddedB ∷ ∀ a b. IsElement a ⇒ (a → Effect b) → Builder a Unit
onAddedB = update <<< onAdded

onRemovedB ∷ ∀ a b. IsElement a ⇒ (a → Effect b) → Builder a Unit
onRemovedB = update <<< onRemoved
