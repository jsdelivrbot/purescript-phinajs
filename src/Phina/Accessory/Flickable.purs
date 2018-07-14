-- | phina.accessory.Flickable

module Phina.Accessory.Flickable
  ( class Flickable
  , FlickDirection(..)
  , setFlick
  , onFlickStart
  , onFlickCancel
  ) where

import Effect (Effect)
import Effect.Uncurried (EffectFn2, EffectFn4, runEffectFn2, runEffectFn4)

data FlickDirection = Free | Horizontal | Vertical

horizontal ∷ FlickDirection → Boolean
horizontal Free = true
horizontal Horizontal = true
horizontal Vertical = false

vertical ∷ FlickDirection → Boolean
vertical Free = true
vertical Horizontal = false
vertical Vertical = true

class Flickable a

--
setFlick
   ∷ ∀ a
   . Flickable a
  ⇒ Number
  → FlickDirection
  → a
  → Effect a
setFlick f d = runEffectFn4 _setFlick f (horizontal d) (vertical d)

onFlickStart
   ∷ ∀ a b
   . Flickable a
  ⇒ (a → Effect b)
  → a
  → Effect a
onFlickStart = runEffectFn2 _onFlickStart

onFlickCancel
   ∷ ∀ a b
   . Flickable a
  ⇒ (a → Effect b)
  → a
  → Effect a
onFlickCancel = runEffectFn2 _onFlickCancel

--
foreign import _setFlick
  ∷ ∀ a
  . EffectFn4 Number Boolean Boolean a a

foreign import _onFlickStart
  ∷ ∀ a b
  . EffectFn2 (a → Effect b) a a

foreign import _onFlickCancel
  ∷ ∀ a b
  . EffectFn2 (a → Effect b) a a
