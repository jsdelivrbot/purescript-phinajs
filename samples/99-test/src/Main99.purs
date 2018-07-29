-- Tests

module Main99 where

import Prelude

import Effect (Effect)
import Phina (GameScenes(..), enableStats, newGame, runGame)
import Test.GameConfig (gameConfig)
import Test.Scenes (sceneList)

main :: Effect Unit
main = do
  game ← newGame gameConfig $ SceneList sceneList
  _ ← enableStats game
  runGame game
