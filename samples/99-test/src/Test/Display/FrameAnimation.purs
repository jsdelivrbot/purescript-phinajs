-- | FrameAnimation

module Test.Display.FrameAnimation
  ( Scene
  , sceneProxy
  ) where

import Prelude

import Effect (Effect)
import Effect.Class (liftEffect)
import Phina (class LabeledScene, class Writable, Builder, DisplayScene, Label, Position, SetupScene, Sprite, SpriteSheetAsset, Vector2, addChildB', addTweenB, build, call, color, getCenterYB, getPosition, getSpanXB, make, msec, newLabel, newSprite, onPointEndB, onPointStartB, peek, play, playAnimation, sec, set, setAnimationB, setFrameIndexB, setInteractiveB, setPosition', setPropsB, setSizeB, stop, toParams, toSceneHandle, wait)
import Test.Assets (swordmanImg, swordmanSS, swordmanSS2)
import Type.Prelude (Proxy(..))


foreign import data Scene ∷ Type

sceneProxy = Proxy ∷ Proxy Scene

instance labeledSceneScene
  ∷ LabeledScene Scene "FrameAnimation" DisplayScene () ()
  where
    sceneHandle _ = toSceneHandle setupScene


setupScene ∷ SetupScene DisplayScene () ()
setupScene _ exit = build do
  setPropsB {backgroundColor: color "#960"}
  x1 ← getSpanXB 5
  x2 ← getSpanXB 8
  x3 ← getSpanXB 11
  y ← getCenterYB
  addChildB' $ newSwordmanTween >>= setPosition' x1 y
  addChildB' $ newSwordmanFA swordmanSS >>= setPosition' x2 y
  addChildB' $ newSwordmanFA swordmanSS2 >>= setPosition' x3 y
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


newSwordmanTween ∷ Effect Sprite
newSwordmanTween = make newSwordman do
  attackHead ← addTweenB do
    set $ toParams {frameIndex: 1}
    wait $ msec 167
    set $ toParams {frameIndex: 2}
    wait $ msec 167
    set $ toParams {frameIndex: 0}
  attackBody ← addTweenB do
    set $ toParams {frameIndex: 3}
    wait $ msec 167
    set $ toParams {frameIndex: 4}
    wait $ msec 167
    set $ toParams {frameIndex: 0}
  onPointEndB \p s → do
    pos ← relPos p.pointer.position s
    play $ if pos.y < 0.0 then attackHead else attackBody


newSwordmanFA ∷ SpriteSheetAsset → Effect Sprite
newSwordmanFA ss = make newSwordman do
  setPropsB {scaleX: -1.0, scaleY: 1.0}
  setAnimationB ss
  onPointEndB \p s → do
    pos ← relPos p.pointer.position s
    if pos.y < 0.0 then playAnimation "attackHead" false s
                   else playAnimation "attackBody" false s

newSwordman ∷ Effect Sprite
newSwordman = make (newSprite swordmanImg {}) do
  setSizeB {width: 128.0, height: 128.0}
  setFrameIndexB 0
  setInteractiveB true


relPos ∷ Vector2 → Sprite → Effect Position
relPos pos sprite = (pos - _) <$> getPosition sprite


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
