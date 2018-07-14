-- | phina.asset.SpriteSheet

module Phina.Asset.SpriteSheet
  ( SpriteSheetAsset
  , spriteSheetSrc
  , spriteSheet
  , Animation
  , animation
  ) where

--

import Data.Maybe (Maybe)
import Data.Nullable (toNullable)
import Unsafe.Coerce (unsafeCoerce)

--

foreign import data SpriteSheetAsset ∷ Type

spriteSheetSrc ∷ String → SpriteSheetAsset
spriteSheetSrc = unsafeCoerce

spriteSheet
   ∷ String
  → { frame ∷ { width ∷ Int, height ∷ Int, cols ∷ Int, rows ∷ Int }
     , animations ∷ Array Animation
     }
  → SpriteSheetAsset
spriteSheet k v = unsafeCoerce
  { key: k
  , value: { frame: v.frame, animations: toAnimations v.animations }
  }

foreign import data Animation ∷ Type

animation
   ∷ String
  → { frames ∷ Array Int
     , next ∷ Maybe String
     , frequency ∷ Int
     }
  → Animation
animation k v = unsafeCoerce
  { key: k
  , value: { frames: v.frames, next: toNullable v.next, frequency: v.frequency}
  }

foreign import data Animations ∷ Type

foreign import toAnimations ∷ Array Animation → Animations