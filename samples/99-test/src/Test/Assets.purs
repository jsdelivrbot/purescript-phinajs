module Test.Assets
  ( myFaceImg
  , swordmanImg
  , swordmanSS
  , swordmanSS2
  , assets
  ) where

import Prelude

import Data.Maybe (Maybe(..))
import Phina (Assets, ImageAsset(..), SpriteSheetAsset, animation, makeAssets, spriteSheet, spriteSheetSrc)

img ∷ String → String
img = ("assets/img/" <> _)

ss ∷ String → String
ss = ("assets/spritesheet/" <> _)

--

myFaceImg ∷ ImageAsset
myFaceImg = ImageAsset $ img "myface.png"

swordmanImg ∷ ImageAsset
swordmanImg = ImageAsset $ img "swordman.png"

swordmanSS ∷ SpriteSheetAsset
swordmanSS = spriteSheetSrc $ ss "swordman_ss.json"

--

assets ∷ Assets
assets = makeAssets
  { image:
      [ myFaceImg
      , swordmanImg
      ]
  , spritesheet:
      [ swordmanSS
      , swordmanSS2
      ]
  }

swordmanSS2 ∷ SpriteSheetAsset
swordmanSS2 = spriteSheet "swordmanSS2"
  { frame:
      { width: 128
      , height: 128
      , cols: 5
      , rows: 1
      }
  , animations:
      [ animation "attackHead"
          { frames: [1, 2, 0]
          , next: Nothing
          , frequency: 10
          }
      , animation "attackBody"
          { frames: [3, 4, 0]
          , next: Just "attackHead"
          , frequency: 10
          }
      ]
  }

