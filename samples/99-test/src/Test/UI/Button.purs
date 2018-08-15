-- | Button

module Test.UI.Button
  ( Scene
  , sceneProxy
  ) where

import Prelude

import Effect (Effect)
import Effect.Class (liftEffect)
import Phina (class Container, class LabeledScene, class Writable, Builder, Button, DisplayScene, Label, Position, SetupScene, Tween, addChildB', addTweenB, animateB, build, by, call, color, easeOutCubic, make, newButton, newLabel, onPointStartB, onPushB, peek, play, remove, sec, setInteractiveB, setPropsB, setUpdateType, stop, toParams, toSceneHandle, updateDelta, wait)
import Type.Prelude (Proxy(..))


foreign import data Scene ∷ Type

sceneProxy = Proxy ∷ Proxy Scene

instance labeledSceneScene ∷ LabeledScene Scene "Button" DisplayScene () ()
  where
    sceneHandle _ = toSceneHandle setupScene

setupScene ∷ SetupScene DisplayScene () ()
setupScene _ exit = build do
  setPropsB {backgroundColor: color "#669"}

  addButton { x: 480.0
            , y: 320.0
            }

  addButton { x: 200.0
            , y: 320.0
            , width: 80.0
            , height: 80.0
            , cornerRadius: 40.0
            , text: "✡"
            , fontSize: 72.0
            , fontColor: color "#ff7"
            , fill: color "#ccc"
            , shadow: color "black"
            , shadowBlur: 8.0
            }

  addButton { x: 760.0
            , y: 320.0
            , cornerRadius: 0.0
            , text: "This is a button."
            , fontSize: 18.0
            , fontWeight: "bold"
            , fontFamily: "cursive"
            , fill: color "#f77"
            , stroke: color "red"
            , strokeWidth: 8.0
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


addButton ∷ ∀ r. Writable Button r ⇒ r → Builder DisplayScene Unit
addButton props = do
  addChildB' $ make (newButton props) $ onPushB handler

  where
    handler button = do
      addMessage "push" {x: 0.0, y: 0.0} button


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
