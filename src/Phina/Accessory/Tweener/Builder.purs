
module Phina.Accessory.Tweener.Builder
  ( animateB
  , addTweenB
  ) where

import Prelude

import Phina.Accessory.Tweener (class Tweenable, Tween, Tweener, animate, addTween)
import Phina.Types.Builder (Builder)
import Phina.Types.Monad.Builder (eval, update)

animateB ∷ ∀ a. Tweenable a ⇒ Tween a → Builder a Unit
animateB = update <<< animate

addTweenB ∷ ∀ a. Tweenable a ⇒ Tween a → Builder a (Tweener a)
addTweenB = eval <<< addTween
