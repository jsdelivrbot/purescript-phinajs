-- | phina.asset.AssetManager

module Phina.Asset.AssetManager
  ( getSound
  ) where

import Prelude

import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toMaybe)
import Effect (Effect)
import Effect.Uncurried (EffectFn1, runEffectFn1)

import Phina.Asset.AssetLoader (SoundAsset)
import Phina.Asset.Sound (Sound)

getSound ∷ SoundAsset → Effect (Maybe Sound)
getSound s = toMaybe <$> runEffectFn1 _getSound s

foreign import _getSound ∷ EffectFn1 SoundAsset (Nullable Sound)
