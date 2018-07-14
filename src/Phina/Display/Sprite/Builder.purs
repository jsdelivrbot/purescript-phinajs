
module Phina.Display.Sprite.Builder
  ( setFrameIndexB
  , getFrameIndexB
  , setAnimationB
  , playAnimationB
  ) where

import Prelude

import Phina.Asset.SpriteSheet (SpriteSheetAsset)
import Phina.Display.Sprite (Sprite, getFrameIndex, playAnimation, setAnimation, setFrameIndex)
import Phina.Types.Builder (Builder)
import Phina.Types.Monad.Builder (eval, update)

--

setFrameIndexB ∷ Int → Builder Sprite Unit
setFrameIndexB = update <<< setFrameIndex

getFrameIndexB ∷ Builder Sprite Int
getFrameIndexB = eval getFrameIndex

setAnimationB ∷ SpriteSheetAsset → Builder Sprite Unit
setAnimationB = update <<< setAnimation

playAnimationB ∷ String → Boolean → Builder Sprite Unit
playAnimationB name = update <<< playAnimation name
