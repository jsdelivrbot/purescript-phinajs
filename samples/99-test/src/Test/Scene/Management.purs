-- | Scene management

module Test.Scene.Management
  ( Scene
  , sceneProxy
  ) where

import Prelude

import Effect (Effect)
import Effect.Class (liftEffect)
import Effect.Console (log)
import Phina (class Event, class IsScene, class LabeledScene, class Tweenable, class Writable, Builder, DisplayScene, Key(Key), PauseScene, SceneHandle, SetupScene, StarShape, addChildB', animateB, build, call, color, deg, easeDefault, flare, getCenterXB, getSpanYB, make, newLabel, newStarShape, onB, onBlurB, onEnterB, onExitB, onFocusB, onKeyDownB, onPauseB, onPointStartB, onResumeB, popup', rotateBy, sec, setLoop, setPropsB, toSceneHandle, toSceneHandle', wait)
import Type.Prelude (Proxy(..))


foreign import data Scene ∷ Type

sceneProxy = Proxy ∷ Proxy Scene

instance labeledSceneScene
  ∷ LabeledScene Scene "Scene Management" DisplayScene () ()
  where
    sceneHandle _ = toSceneHandle setupScene


setupScene ∷ SetupScene DisplayScene () ()
setupScene _ exit = build do
  setPropsB {backgroundColor: color "#393"}
  addStarShape {x: 200.0, y: 200.0, radius: 120.0}
  addStarShape {x: 800.0, y: 500.0, radius: 400.0, sides: 7.0, fill: color "red", alpha: 0.2}
  x ← getCenterXB
  y ← getSpanYB 12
  addChildB' $ newLabel { x: x
                        , y: y
                        , text: "Press Space Key"
                        , fill: color "white"
                        }
  onKeyDownB $ \key s → when (key == Key "space")
                                $ void $ popupScene {a: "space key"} s
  onPointStartB $ \_ s → log "scene1: point" *> exit {} s
  addEvent "scene1" exit
    where
      popupScene = popup' sampleOverlayScene


addStarShape ∷ ∀ r. Writable StarShape r ⇒ r → Builder DisplayScene Unit
addStarShape props =
  addChildB' $ make (newStarShape props) $ animateB tween
  where
    tween = setLoop true *> rotateBy (deg 60) (sec 1) easeDefault


sampleOverlayScene ∷ SceneHandle DisplayScene (a ∷ String) ()
sampleOverlayScene = toSceneHandle $ \params exit → build do
  liftEffect $ log params.a
  x ← getCenterXB
  y ← getSpanYB 6
  addChildB' $ newLabel { x: x
                        , y: y
                        , text: "Overlay"
                        , fill: color "white"
                        }
  onKeyDownB \key s → when (key == Key "space")
                            $ void $ popupScene {} s
  onPointStartB (\_ s → log "overlay: point" *> exit {} s)
  addEvent "overlay" exit
    where
      popupScene = popup' samplePauseScene


samplePauseScene ∷ SceneHandle PauseScene () ()
samplePauseScene = toSceneHandle' $ \_ exit → build $ addEvent "pause" exit


data TimeOut = TimeOut
instance eventTimeOut ∷ Event TimeOut String where
  event _ = "timeout"


addEvent
   ∷ ∀ s
   . IsScene s
  ⇒ Tweenable s
  ⇒ String
  → ({} → s → Effect s)
  → Builder s Unit
addEvent sceneName exit = do
  onB TimeOut (\e s → log (sceneName <> ": " <> e) *> exit {} s)
  onEnterB (\_ s → log $ sceneName <> ": enter")
  onExitB (\_ s → log $ sceneName <> ": exit")
  onPauseB (\_ s → log $ sceneName <> ": pause")
  onResumeB (\_ s → log $ sceneName <> ": resume")
  onFocusB (\s → log $ sceneName <> ": focus")
  onBlurB (\s → log $ sceneName <> ": blur")
  animateB $ (wait $ sec 10) *> (call $ flare TimeOut "timeout")
