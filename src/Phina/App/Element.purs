-- phina.app.Element

module Phina.App.Element
  ( ElementProps
  , class IsElement
  , onEnterframe
  , remove
  , setUpdater
  , class Container
  , addChild
  ) where

import Effect (Effect)
import Effect.Uncurried (EffectFn1, EffectFn2, runEffectFn1, runEffectFn2)

import Phina.Game.GameApp (GameApp)
import Phina.Types.Property (class HasProperty, Prop)
import Phina.Util.EventDispatcher (class EventDispatcher)
import Phina.Util.EventDispatcher.Unsafe (unsafeOn)

data ElementProps
instance hasPropertyElement ∷ HasProperty ElementProps
  ( awake ∷ Prop Boolean "r" "w"
  )

class EventDispatcher a ⇐ IsElement a

onEnterframe
   ∷ ∀ a b
   . IsElement a
  ⇒ ({app ∷ GameApp} → a → Effect b)
  → a
  → Effect a
onEnterframe = unsafeOn "enterframe"

remove ∷ ∀ a. IsElement a ⇒ a → Effect a
remove = runEffectFn1 _remove

setUpdater ∷ ∀ a b. IsElement a ⇒ (GameApp → a → Effect b) → a → Effect a
setUpdater = runEffectFn2 _setUpdater

foreign import _remove ∷ ∀ a. EffectFn1 a a

foreign import _setUpdater ∷ ∀ a b. EffectFn2 (GameApp → a → Effect b) a  a

--
class Container a

addChild ∷ ∀ a b. IsElement a ⇒ Container b ⇒ a → b → Effect b
addChild = runEffectFn2 _addChild

foreign import _addChild ∷ ∀ a b. EffectFn2 a b b
