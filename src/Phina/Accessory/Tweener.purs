-- phina.accessory.Tweener

module Phina.Accessory.Tweener
  ( class Tweenable
  , Tweener
  , Tween
  , UpdateType
  , updateNormal
  , updateDelta
  , updateFps
  , setUpdateType
  , setLoop
  , to
  , by
  , from
  , wait
  , call
  , set
  , moveTo
  , moveBy
  , rotateTo
  , rotateBy
  , scaleTo
  , scaleBy
  , fade
  , fadeOut
  , fadeIn
  , animate
  , addTween
  , clearTween
  ) where

import Prelude

import Effect (Effect)
import Effect.Uncurried (EffectFn1, EffectFn2, EffectFn3, EffectFn4, EffectFn5, runEffectFn1, runEffectFn2, runEffectFn3, runEffectFn4, runEffectFn5)
import Unsafe.Coerce (unsafeCoerce)

import Phina.Accessory.Tweener (class Tweenable)
import Phina.App.Element (class IsElement)
import Phina.Types.Angle (Angle)
import Phina.Types.Builder (Builder)
import Phina.Types.Duration (Duration)
import Phina.Types.Monad.Builder (build, update)
import Phina.Types.Playable (class Playable)
import Phina.Types.Property (Params)
import Phina.Util.Tween (Easing)

-- Define type

class IsElement a ⇐ Tweenable a

foreign import data UpdateType ∷ Type

updateNormal ∷ UpdateType
updateNormal = unsafeCoerce "normal"

updateDelta ∷ UpdateType
updateDelta = unsafeCoerce "delta"

updateFps ∷ UpdateType
updateFps = unsafeCoerce "fps"

foreign import data Tweener ∷ Type → Type

type Tween a = Builder (Tweener a) Unit

--

setUpdateType ∷ ∀ a. UpdateType → Tween a
setUpdateType = update <<< (runEffectFn2 _setUpdateType)

setLoop ∷ ∀ a. Boolean → Tween a
setLoop = update <<< (runEffectFn2 _setLoop)

to ∷ ∀ a. Params a → Duration → Easing → Tween a
to params duration easing = update $ runEffectFn4 _to params duration easing

by ∷ ∀ a. Params a → Duration → Easing → Tween a
by params duration easing = update $ runEffectFn4 _by params duration easing

from ∷ ∀ a. Params a → Duration → Easing →  Tween a
from params duration easing = update $ runEffectFn4 _from params duration easing

wait ∷ ∀ a. Duration → Tween a
wait = update <<< (runEffectFn2 _wait)

call ∷ ∀ a. (a → Effect a) → Tween a
call = update <<< (runEffectFn2 _call)

set ∷ ∀ a. Params a → Tween a
set = update <<< (runEffectFn2 _set)

moveTo ∷ ∀ a. Number → Number → Duration → Easing → Tween a
moveTo x y duration easing = update $ runEffectFn5 _moveTo x y duration easing

moveBy ∷ ∀ a. Number → Number → Duration → Easing → Tween a
moveBy x y duration easing = update $ runEffectFn5 _moveBy x y duration easing

rotateTo ∷ ∀ a. Angle → Duration → Easing → Tween a
rotateTo angle duration easing = update $ runEffectFn4 _rotateTo angle duration easing

rotateBy ∷ ∀ a. Angle → Duration → Easing → Tween a
rotateBy angle duration easing = update $ runEffectFn4 _rotateBy angle duration easing

scaleTo ∷ ∀ a. Number → Duration → Easing → Tween a
scaleTo scale duration easing = update $ runEffectFn4 _scaleTo scale duration easing

scaleBy ∷ ∀ a. Number → Duration → Easing → Tween a
scaleBy scale duration easing = update $ runEffectFn4 _scaleBy scale duration easing

fade ∷ ∀ a. Number → Duration → Easing → Tween a
fade alpha duration easing = update $ runEffectFn4 _fade alpha duration easing

fadeOut ∷ ∀ a. Duration → Easing → Tween a
fadeOut duration easing = update $ runEffectFn3 _fadeOut duration easing

fadeIn ∷ ∀ a. Duration → Easing → Tween a
fadeIn duration easing = update $ runEffectFn3 _fadeIn duration easing

animate ∷ ∀ a. Tweenable a ⇒ Tween a → a → Effect a
animate tween element = (getTweener element >>= build tween) $> element

addTween ∷ ∀ a. Tweenable a ⇒ Tween a → a → Effect (Tweener a)
addTween tween element = newTweener element >>= build tween

-- tweener

getTweener ∷ ∀ a. Tweenable a ⇒ a → Effect (Tweener a)
getTweener = runEffectFn1 _getTweener

newTweener ∷ ∀ a. Tweenable a ⇒ a → Effect (Tweener a)
newTweener = runEffectFn1 _newTweener

clearTween ∷ ∀ a. Tweener a → Effect (Tweener a)
clearTween = runEffectFn1 _clearTween

instance playableTweener ∷ Playable (Tweener a) where
  play = runEffectFn1 _play
  stop = runEffectFn1 _stop
  pause = runEffectFn1 _pause
  resume = runEffectFn1 _resume

-- foreign

foreign import _setUpdateType ∷ ∀ a. EffectFn2 UpdateType a a
foreign import _setLoop ∷ ∀ a. EffectFn2 Boolean a a
foreign import _to ∷ ∀ a b. EffectFn4 (Params b) Duration Easing a a
foreign import _by ∷ ∀ a b. EffectFn4 (Params b) Duration Easing a a
foreign import _from ∷ ∀ a b. EffectFn4 (Params b) Duration Easing a a
foreign import _wait ∷ ∀ a. EffectFn2 Duration a a
foreign import _call ∷ ∀ a b. EffectFn2 (b → Effect b) a a
foreign import _set ∷ ∀ a b. EffectFn2 (Params b) a a
foreign import _moveTo ∷ ∀ a. EffectFn5 Number Number Duration Easing a a
foreign import _moveBy ∷ ∀ a. EffectFn5 Number Number Duration Easing a a
foreign import _rotateTo ∷ ∀ a. EffectFn4 Angle Duration Easing a a
foreign import _rotateBy ∷ ∀ a. EffectFn4 Angle Duration Easing a a
foreign import _scaleTo ∷ ∀ a. EffectFn4 Number Duration Easing a a
foreign import _scaleBy ∷ ∀ a. EffectFn4 Number Duration Easing a a
foreign import _fade ∷ ∀ a. EffectFn4 Number Duration Easing a a
foreign import _fadeOut ∷ ∀ a. EffectFn3 Duration Easing a a
foreign import _fadeIn ∷ ∀ a. EffectFn3 Duration Easing a a

foreign import _getTweener ∷ ∀ a. EffectFn1 a (Tweener a)
foreign import _newTweener ∷ ∀ a. EffectFn1 a (Tweener a)
foreign import _clearTween ∷ ∀ a. EffectFn1 (Tweener a) (Tweener a)
foreign import _play ∷ ∀ a. EffectFn1 (Tweener a) (Tweener a)
foreign import _stop ∷ ∀ a. EffectFn1 (Tweener a) (Tweener a)
foreign import _pause ∷ ∀ a. EffectFn1 (Tweener a) (Tweener a)
foreign import _resume ∷ ∀ a. EffectFn1 (Tweener a) (Tweener a)
