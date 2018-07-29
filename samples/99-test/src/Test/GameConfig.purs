module Test.GameConfig
  ( gameConfig
  ) where

import Phina (Assets)
import Test.Assets (assets)

gameConfig ∷
  { title ∷ String
  , width ∷ Number
  , height ∷ Number
  , fps ∷ Number
  , debug ∷  Boolean
  , assets ∷ Assets
  }
gameConfig =
  { title: "Tests"
  , width: 960.0
  , height: 640.0
  , fps: 60.0
  , debug: true
  , assets: assets
  }
