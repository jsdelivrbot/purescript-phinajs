-- | Touch

module Test.Input.Touch
  ( Scene
  , sceneProxy
  ) where

import Prelude

import Data.Int (round)
import Effect (Effect)
import Effect.Class (liftEffect)
import Phina (class Container, class LabeledScene, class Writable, Builder, CircleShape, DisplayScene, FlickDirection(Free, Horizontal, Vertical), Label, Position, RectangleShape, SetupScene, TriangleShape, Tween, addChildB', addTweenB, animateB, build, by, call, color, easeOutCubic, easeOutElastic, enableDragB, getPosition, make, msec, newCircleShape, newLabel, newRectangleShape, newTriangleShape, onBackEndB, onDragB, onDragEndB, onDragStartB, onFlickCancelB, onFlickStartB, onPointEndB, onPointMoveB, onPointOutB, onPointOverB, onPointStartB, peek, play, remove, sec, setFlickB, setInteractiveB, setPropsB, setUpdateType, stop, toParams, toSceneHandle, updateDelta, wait)
import Type.Prelude (Proxy(..))


foreign import data Scene ∷ Type

sceneProxy = Proxy ∷ Proxy Scene

instance labeledSceneScene ∷ LabeledScene Scene "Touch" DisplayScene () ()
  where
    sceneHandle _ = toSceneHandle setupScene

setupScene ∷ SetupScene DisplayScene () ()
setupScene _ exit = build do
  setPropsB {backgroundColor: color "#662"}
  addTouchableShape {x: 480.0, y: 320.0}
  addDraggableShape {x: 200.0, y: 200.0} false
  addDraggableShape {x: 700.0, y: 400.0, fill: color "cyan"} true
  addFlickableShape {x: 800.0, y: 100.0} Vertical
  addFlickableShape {x: 100.0, y: 550.0, fill: color "#c66"} Horizontal
  addFlickableShape {x: 600.0, y: 150.0, fill: color "#66c"} Free
  addChildB' $ newLabel { x: 480.0
                        , y: 220.0
                        , text: "Point, Drag, Flick it!"
                        , fill: color "white"
                        }
  addNextLabel  { x: 850.0
                , y: 600.0
                , text: "Go to next"
                , fontSize: 24.0
                , fill: color "white"
                }
                exit

  tweener ← addTweenB $ (wait $ sec 10) *> (call $ exit {})
  _ ← liftEffect $ play tweener
  onPointStartB (\_ _ → stop tweener *> play tweener)


addTouchableShape
   ∷ ∀ r
   . Writable CircleShape r
  ⇒ r
  → Builder DisplayScene Unit
addTouchableShape props = do
  addChildB'
    $ make (newCircleShape props) do
              setInteractiveB true
              onPointOverB (handler "pointover")
              onPointOutB (handler "pointout")
              onPointStartB (handler "pointstart")
              onPointEndB (handler "pointend")
              -- onPointStayB (handler "pointstay") -- too frequently
              onPointMoveB (handler "pointmove")
  where
    handler event e o = do
      addMessage text {x: 0.0, y: 0.0} o
        where
          x = round e.pointer.x
          y = round e.pointer.y
          text = event <> " : " <> (show x) <> ", " <> (show y)


addDraggableShape
   ∷ ∀ r
   . Writable RectangleShape r
  ⇒ r
  → Boolean
  → Builder DisplayScene Unit
addDraggableShape props back = do
  scene ← peek
  let handler event o = do
        pos ← getPosition o
        addMessage event pos scene
  let endHandler event b o = do
        pos ← getPosition o
        _ ← addMessage event pos scene
        when (back && pos.x < 320.0) $ void $ b (msec 200) easeOutElastic o
  addChildB'
    $ make (newRectangleShape props) do
              enableDragB
              onDragStartB $ handler "dragstart"
              onDragB $ handler "drag"
              onDragEndB $ endHandler "dragend"
              onBackEndB $ handler "backend"


addFlickableShape
   ∷ ∀ r
   . Writable TriangleShape r
  ⇒ r
  → FlickDirection
  → Builder DisplayScene Unit
addFlickableShape props dir = do
  scene ← peek
  let handler event o = do
        pos ← getPosition o
        addMessage event pos scene
  addChildB'
    $ make (newTriangleShape props) do
              setFlickB 0.8 dir
              onFlickStartB (handler "flickstart")
              onFlickCancelB (handler "flickcancel")


addMessage ∷ ∀ a. Container a ⇒ String → Position → a → Effect a
addMessage message pos = build do
  addChildB' $ make label $ animateB tween
  where
    label = newLabel  { x: pos.x
                      , y: pos.y
                      , text: message
                      , fontSize: 24.0
                      , fill: color "white"
                      }
    tween ∷ Tween Label
    tween = do
      setUpdateType updateDelta
      by (toParams {y: -120.0, alpha: -1.0}) (sec 1) easeOutCubic
      call remove


addNextLabel
   ∷ ∀ r
   . Writable Label r
  ⇒ r
  → ({} → DisplayScene → Effect DisplayScene)
  → Builder DisplayScene Unit
addNextLabel props exit = do
  scene ← peek
  addChildB'
    $ make (newLabel props) do
              setInteractiveB true
              onPointStartB \_ _ → exit {} scene
