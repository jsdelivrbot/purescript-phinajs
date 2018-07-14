
module Phina.App.Element.Builder
  ( onEnterframeB
  , removeB
  , setUpdaterB
  , addChildB
  , addChildB'
  ) where

import Prelude

import Effect (Effect)
import Effect.Class (liftEffect)

import Phina.App.Element (class Container, class IsElement, addChild, onEnterframe, remove, setUpdater)
import Phina.Game.GameApp (GameApp)
import Phina.Types.Builder (Builder)
import Phina.Types.Monad.Builder (update)

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

addChildB ∷ ∀ a b. IsElement a ⇒ Container b ⇒ a → Builder b Unit
addChildB = update <<< addChild

addChildB' ∷ ∀ a b. IsElement a ⇒ Container b ⇒ Effect a → Builder b Unit
addChildB' m = liftEffect m >>= addChildB
