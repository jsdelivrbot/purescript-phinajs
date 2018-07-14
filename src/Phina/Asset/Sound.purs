-- | phina.asset.Sound

module Phina.Asset.Sound
  ( Sound
  , Volume
  , setVolume
  , getVolume
  , setLoopSound
  , getLoopSound
  ) where

import Prelude

import Effect (Effect)
import Effect.Uncurried (EffectFn1, runEffectFn1)
import Type.Prelude (SProxy(..))

import Phina.Types.Playable (class Playable)
import Phina.Types.Property (class HasProperty, Prop, getProp, setProp)

--

foreign import data Sound ∷ Type

instance hasPropertySound ∷ HasProperty Sound
  ( volume ∷ Prop Number "r" "w"
  , loop ∷ Prop Boolean "r" "w"
  )

instance playableSound ∷ Playable Sound where
  play = runEffectFn1 _play
  stop = runEffectFn1 _stop
  pause = runEffectFn1 _pause
  resume = runEffectFn1 _resume

type Volume = Number

setVolume ∷ Volume → Sound → Effect Sound
setVolume = setProp $ SProxy ∷ SProxy "volume"

getVolume ∷ Sound → Effect Volume
getVolume = getProp $ SProxy ∷ SProxy "volume"

setLoopSound ∷ Boolean → Sound → Effect Sound
setLoopSound = setProp $ SProxy ∷ SProxy "loop"

getLoopSound ∷ Sound → Effect Boolean
getLoopSound = getProp $ SProxy ∷ SProxy "loop"

--

foreign import _play ∷ EffectFn1 Sound Sound
foreign import _stop ∷ EffectFn1 Sound Sound
foreign import _pause ∷ EffectFn1 Sound Sound
foreign import _resume ∷ EffectFn1 Sound Sound
