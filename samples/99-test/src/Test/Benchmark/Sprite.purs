-- Benchmark

module Test.Benchmark.Sprite
  ( Scene
  , sceneProxy
  ) where

import Prelude

import Effect (Effect, forE)
import Effect.Ref (Ref, new, read, write)
import Phina (class LabeledScene, DisplayElement, DisplayScene, Label, SetupScene, addChild, addChildTo, addTween, call, color, getSize, newDisplayElement, newLabel, onPointStart, play, sec, setLoop, setProps, setText, stop, toSceneHandle, wait)
import Test.Benchmark.Sprite.MyFace (newMyFace)
import Type.Prelude (Proxy(..))


foreign import data Scene ∷ Type

sceneProxy = Proxy ∷ Proxy Scene

instance labeledSceneScene ∷ LabeledScene Scene "Benchmark" DisplayScene () ()
  where
    sceneHandle _ = toSceneHandle setupScene

type Bench = {faceCountRef ∷ Ref Int, countLabel ∷ Label, stage ∷ DisplayElement}


setupScene ∷ SetupScene DisplayScene () ()
setupScene _ exit scene = do
  _ ← setProps {backgroundColor: color "#333"} scene

  faceCountRef ← new 0

  layerStage ← addLayer scene
  layerHud ← addLayer scene

  countLabel ← newLabel  { text: show 0
                          , fill: color "white"
                          , align: "right"
                          , x: 930.0
                          , y: 30.0
                          }
  _ ← addChild countLabel layerHud

  let bench = {faceCountRef, countLabel, stage: layerStage}

  addMyFaces bench 1

  tweener ← scene # addTween do
    setLoop true
    wait $ sec 10
    call $ step bench exit

  _ ← play tweener

  scene # onPointStart \_ s → do
    _ ← stop tweener
    _ ← play tweener
    step bench exit s


step
   ∷ Bench
  → ({} → DisplayScene → Effect DisplayScene)
  → DisplayScene
  → Effect DisplayScene
step bench exit scene = do
  num ← read bench.faceCountRef
  if num >= 4096
    then exit {} scene
    else addMyFaces bench num $> scene


addMyFaces ∷ Bench → Int → Effect Unit
addMyFaces bench num = do
  faceCount ← read bench.faceCountRef
  _ ← write (faceCount + num) bench.faceCountRef
  _ ← setText (show $ faceCount + num) bench.countLabel
  forE 0 num \_ → void $ addMyFace bench.stage


addMyFace ∷ DisplayElement → Effect DisplayElement
addMyFace stage = do
  size ← getSize stage
  let pos = {x: size.width / 2.0, y: size.height / 2.0}
  face ← newMyFace size pos
  addChild face stage


addLayer ∷ DisplayScene → Effect DisplayElement
addLayer s = do
  size ← getSize s
  element ← newDisplayElement  { width: size.width
                                , height: size.height
                                , originX: 0.0
                                , originY: 0.0}
  addChildTo s element
