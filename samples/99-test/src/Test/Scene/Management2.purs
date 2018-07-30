-- | Scene management 2

module Test.Scene.Management2
  ( Scene
  , sceneProxy
  ) where

import Prelude

import Effect (Effect)
import Phina (class LabeledScene, class Writable, Builder, DisplayScene, RectangleShape, SceneHandle, SetupScene, addChildB', animateB, build, call, color, getCenterPosB, getCenterXB, getCenterYB, getSpanXB, getSpanYB, launchAsyncB', make, newLabel, newRectangleShape, onPointEndB, onPointStartB, peek, popup, sec, setInteractiveB, setPropsB, toSceneHandle, update, wait)
import Type.Prelude (Proxy(..))


foreign import data Scene ∷ Type

sceneProxy = Proxy ∷ Proxy Scene

instance labeledSceneScene
  ∷ LabeledScene Scene "Scene Management 2" DisplayScene () ()
  where
    sceneHandle _ = toSceneHandle setupScene


setupScene ∷ SetupScene DisplayScene () ()
setupScene _ exit = build do
  setPropsB {backgroundColor: color "grey"}
  launchAsyncB' do
    _ ← scenes
    update $ exit {}
  where
    scenes = do
      ret ← popup sampleMenuScene {}
      ret2 ← if ret.ret > 1
        then popup sampleMenuScene2 {arg: ret.ret}
        else pure {ret: "none"}
      let result = (show ret.ret) <> " → " <> ret2.ret
      popup sampleResultScene {ret: result}


sampleMenuScene ∷ SceneHandle DisplayScene () (ret ∷ Int)
sampleMenuScene = toSceneHandle $ \_ exit → build do
  setPropsB {backgroundColor: color "#963"}
  animateB $ (wait $ sec 10) *> (call $ exit {ret: 0})
  y ← getCenterYB
  x1 ← getSpanXB 4
  x2 ← getSpanXB 8
  x3 ← getSpanXB 12
  addMenuButton 1 {x: x1, y, fill: color "red"} exit
  addMenuButton 2 {x: x2, y, fill: color "green"} exit
  addMenuButton 3 {x: x3, y, fill: color "blue"} exit


sampleMenuScene2 ∷ SceneHandle DisplayScene (arg ∷ Int) (ret ∷ String)
sampleMenuScene2 = toSceneHandle $ \param exit → build do
  let pre s = show param.arg <> ":" <> s
  setPropsB {backgroundColor: color "#693"}
  animateB $ (wait $ sec 10) *> (call $ exit {ret: pre "Grey"})
  x ← getCenterXB
  y1 ← getSpanYB 4
  y2 ← getSpanYB 8
  y3 ← getSpanYB 12
  addMenuButton (pre "Green") {x, y: y1, width: 150.0, fill: color "green"} exit
  addMenuButton (pre "Blue") {x, y: y2, width: 150.0, fill: color "blue"} exit
  addMenuButton (pre "Red") {x, y: y3, width: 150.0, fill: color "red"} exit


addMenuButton
   ∷ ∀ r ret
   . Writable RectangleShape r
  ⇒ Show ret
  ⇒ ret
  → r
  → ({ret ∷ ret} → DisplayScene → Effect DisplayScene)
  → Builder DisplayScene Unit
addMenuButton ret p exit = do
  scene ← peek
  addChildB' $
    make (newRectangleShape p) do
      addChildB' $ newLabel {text: show ret, fontSize: 24.0, fill: color "white"}
      setInteractiveB true
      onPointEndB \_ _ → exit {ret: ret} scene


sampleResultScene ∷ SceneHandle DisplayScene (ret ∷ String) ()
sampleResultScene = toSceneHandle $ \param exit → build do
  setPropsB {backgroundColor: color "#369"}
  center ← getCenterPosB
  addChildB' $ newLabel
    { x: center.x
    , y: center.y
    , text: param.ret
    , fontSize: 48.0
    , fill: color "white"
    , stroke: color "yellow"
    , strokeWidth: 4.0
    }
  onPointStartB (\_ → exit {})
  animateB $ (wait $ sec 10) *> (call $ exit {})
