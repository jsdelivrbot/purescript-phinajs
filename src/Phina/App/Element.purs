-- phina.app.Element

module Phina.App.Element
  ( ElementProps
  , class IsElement
  , onEnterframe
  , remove
  , setUpdater
  , wakeUp
  , sleep
  , class Container
  , addChild
  , addChildTo
  , onAdded
  , onRemoved
  ) where

import Data.Symbol (SProxy(..))
import Effect (Effect)
import Effect.Uncurried (EffectFn1, EffectFn2, runEffectFn1, runEffectFn2)

import Phina.Game.GameApp (GameApp)
import Phina.Types.Property (class HasProperty, class WritableProp, Prop, setProp)
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

wakeUp ∷ ∀ a. WritableProp a "awake" Boolean ⇒ a → Effect a
wakeUp = setProp (SProxy ∷ SProxy "awake") true

sleep ∷ ∀ a. WritableProp a "awake" Boolean ⇒ a → Effect a
sleep = setProp (SProxy ∷ SProxy "awake") false

foreign import _remove ∷ ∀ a. EffectFn1 a a

foreign import _setUpdater ∷ ∀ a b. EffectFn2 (GameApp → a → Effect b) a  a

--
class Container a

addChild ∷ ∀ a b. IsElement a ⇒ Container b ⇒ a → b → Effect b
addChild = runEffectFn2 _addChild

addChildTo ∷ ∀ a b. IsElement a ⇒ Container b ⇒ b → a → Effect a
addChildTo = runEffectFn2 _addChildTo

onAdded ∷ ∀ a b. IsElement a ⇒ (a → Effect b) → a → Effect a
onAdded f = unsafeOn "added" \_ → f

onRemoved ∷ ∀ a b. IsElement a ⇒ (a → Effect b) → a → Effect a
onRemoved f = unsafeOn "removed" \_ → f

foreign import _addChild ∷ ∀ a b. EffectFn2 a b b

foreign import _addChildTo ∷ ∀ a b. EffectFn2 b a a
