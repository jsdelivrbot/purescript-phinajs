-- | Keyboard

module Test.Input.Keyboard
  ( Scene
  , sceneProxy
  ) where

import Prelude

import Data.Array (find, foldM)
import Data.Maybe (maybe)
import Effect (Effect)
import Effect.Class (liftEffect)
import Phina (class Container, class Event, class LabeledScene, Builder, DisplayScene, GameApp, Key(Key), Label, SetupScene, addChild, addChildB', addTweenB, animateB, build, by, call, color, easeOutCubic, flare, getKey, getKeyDown, getKeyUp, make, newLabel, onB', onPointStartB, play, remove, sec, setPropsB, setUpdateType, setUpdater, stop, toParams, toSceneHandle, update, updateDelta, wait, (.>))
import Type.Prelude (Proxy(..))


foreign import data Scene ∷ Type

sceneProxy = Proxy ∷ Proxy Scene

instance labeledSceneScene ∷ LabeledScene Scene "Keyboard" DisplayScene () ()
  where
    sceneHandle _ = toSceneHandle setupScene


setupScene ∷ SetupScene DisplayScene () ()
setupScene _ exit = build do
  setPropsB {backgroundColor: color "#611"}
  addKeys
  onPointStartB (\_ → exit {})

  tweener ← addTweenB $ (wait $ sec 10) *> (call $ exit {})
  _ ← liftEffect $ play tweener
  onB' Hold (\_ → stop tweener *> play tweener)


addKeys ∷ Builder DisplayScene Unit
addKeys = update \scene → do
  _ ← foldM (procRow scene) 0.0 keys
  pure scene
  where
    procRow scene ky row = do
      _ ← foldM (addKey scene ky) 0.0 row
      pure (ky + 1.0)


addKey ∷ DisplayScene → Number → Number → String → Effect Number
addKey scene ky kx key
    = ( newLabel  { x: x
                    , y: y
                    , fill: color "white"
                    , stroke: color "black"
                    , strokeWidth: 1.0
                    , text: key
                    }
          >>= setUpdater (keyUpdater scene $ getKeyName key)
          >>= flip addChild scene
      )
      *> pure (kx + 1.0)
  where
    offset = 128.0
    keySize = 64.0
    offset2 = 200.0
    keySize2 = 128.0
    x = if ky < 4.0 then offset + kx * keySize + ky * keySize / 2.0
                    else offset2 + kx * keySize2
    y = offset + ky * keySize


keyUpdater ∷ DisplayScene → String → GameApp → Label → Effect Label
keyUpdater scene keyName app label = do
  when isDown $ void $ ({fill: color "yellow"} .> label) *> addMessage "Key Down" label
  when isUp $ void $ ({fill: color "white"} .> label) *> addMessage "Key Up" label
  when isPress $ void $ flare Hold unit scene
  pure label
  where
    keyName' = Key keyName
    isPress = getKey keyName' app
    isDown = getKeyDown keyName' app
    isUp = getKeyUp keyName' app


addMessage ∷ ∀ a. Container a ⇒ String → a → Effect a
addMessage message = build do
  addChildB' $ make label $ animateB tween
  where
    label = newLabel { x: 0.0, y: 0.0, text: message, fontSize: 24.0, fill: color "white"}
    tween = do
      setUpdateType updateDelta
      by (toParams {y: -120.0, alpha: -1.0}) (sec 1) easeOutCubic
      call remove


data Hold = Hold
instance eventHold ∷ Event Hold Unit where
  event _ = "hold"


getKeyName ∷ String → String
getKeyName key =
  maybe key (\k → k.keyName) (find (\k → k.key == key) keyNames)


keys ∷ Array (Array String)
keys =
  [ [ "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "-"]
  , [ "Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"]
  , [ "A", "S", "D", "F", "G", "H", "J", "K", "L"]
  , [ "Z", "X", "C", "V", "B", "N", "M", ",", ".", "/"]
  , [ "ESC", "SHIFT", "CTRL", "SPACE", "ENTER"]
  ]


keyNames ∷ Array {key ∷ String, keyName ∷ String}
keyNames =
  [ k "-" "dash"
  , k "," "comma"
  , k "." "period"
  , k "ESC" "escape"
  , k "SHIFT" "shift"
  , k "CTRL" "ctrl"
  , k "SPACE" "space"
  , k "ENTER" "enter"
  ]
  where
    k = {key: _, keyName: _}
