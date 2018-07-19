-- Hello World

module Main01 where

import Prelude

import Effect (Effect)
import Phina as P

main :: Effect Unit
main = do
  let scenes = P.SceneListDefault P.Main setuptScene
  game ← P.newGame {title: "Hello World"} scenes
  P.runGame game

setuptScene ∷ P.SetupScene P.DisplayScene () (score ∷ String)
setuptScene _ exit scene = do
  pos ← P.getCenterPos scene
  label ← P.newLabel {x: pos.x, y: pos.y, text: "Hello World!"}
  P.addChild label scene
