-- | Collision of Object2D

module Test.Collision.Object2D
  ( Scene
  , sceneProxy
  ) where

import Prelude

import Data.Array (uncons)
import Data.Maybe (Maybe(..))
import Data.Traversable (sequence, traverse_)
import Effect (Effect)
import Effect.Class (liftEffect)
import Phina (class LabeledScene, class Writable, Builder, CircleShape, DisplayElement, DisplayScene, GameApp, Label, SetupScene, addChildB, addChildB', addTweenB, animate, boundingCircle, build, call, color, deg, easeInOutCubic, easeLinear, enableDragB, getPosition, getPropB, getSize, getSizeB, hitTest, hitTestElement, make, moveTo, msec, newCircleShape, newHeartShape, newLabel, newPolygonShape, newRectangleShape, newStarShape, newTriangleShape, nullColor, onDragEndB, onDragStartB, onPointStartB, pause, peek, play, scaleTo, sec, setInteractiveB, setLoop, setProp, setPropB, setUpdaterB, stop, toDisplayElement, toSceneHandle, wait)
import Type.Prelude (Proxy(..), SProxy(..))


foreign import data Scene ∷ Type

sceneProxy = Proxy ∷ Proxy Scene

instance labeledScene
  ∷ LabeledScene Scene "Collision Object2D" DisplayScene () ()
  where
    sceneHandle _ = toSceneHandle setupScene


setupScene ∷ SetupScene DisplayScene () ()
setupScene _ exit = build do
  setPropB (SProxy ∷ SProxy "backgroundColor") $ color "#69b"

  shapes ← liftEffect newShapes
  liftEffect $ traverse_ setupShape shapes
  traverse_ addChildB shapes

  scene ← peek
  point ← liftEffect $ newPointShape scene
  addChildB point

  setUpdaterB $ updater shapes point

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


updater
   ∷ Array DisplayElement
  → CircleShape
  → GameApp
  → DisplayScene
  → Effect DisplayScene
updater shapes point app scene = do
  traverse_ (setAlpha 0.5) shapes
  collisionShapes 0.8 shapes
  collisionPoint 1.0 shapes point
  pure scene


collisionShapes ∷ Number → Array DisplayElement → Effect Unit
collisionShapes alpha shapes = do
  case uncons shapes of
    Just {head: x, tail: xs}
            → collisionEach alpha x xs *> collisionShapes alpha xs
    Nothing → pure unit


collisionEach ∷ Number → DisplayElement → Array DisplayElement → Effect Unit
collisionEach alpha x = traverse_ (\y → collisionShape x y)
  where
    collisionShape a b = do
      whenM (hitTestElement a b) do
        void $ setAlpha alpha a
        void $ setAlpha alpha b


collisionPoint ∷ Number → Array DisplayElement → CircleShape → Effect Unit
collisionPoint alpha shapes point = do
  pos ← getPosition point
  traverse_ (hit pos) shapes
  where
    hit pos s = whenM (hitTest pos s) $ void $ setAlpha alpha s


newPointShape ∷ DisplayScene → Effect CircleShape
newPointShape scene = do
  size ← getSize scene
  shape ← newCircleShape params
  shape # animate do
    setLoop true
    moveTo size.width size.height (sec 10) easeLinear
    moveTo 0.0 0.0 (sec 10) easeLinear
  where
    params =  { x: 0.0
              , y: 0.0
              , radius: 2.0
              , fill: color "#ffc"
              , shadow: color "ffc"
              , shadowBlur: 4.0
              }


setAlpha ∷ Number → DisplayElement → Effect DisplayElement
setAlpha = setProp (SProxy ∷ SProxy "alpha")


setupShape ∷ DisplayElement → Effect DisplayElement
setupShape = build do
  let frameColor = color "#333"
      frameWidth = 1.0
  size ← getSizeB
  rotation ← getPropB (SProxy ∷ SProxy "rotation")
  addChildB' $ newRectangleShape
                { width: size.width
                , height: size.height
                , rotation: -rotation
                , fill: nullColor
                , stroke: frameColor
                , strokeWidth: frameWidth
                }
  bounding ← getPropB (SProxy ∷ SProxy "boundingType")
  when (bounding == boundingCircle) do
    radius ← getPropB (SProxy ∷ SProxy "radius")
    addChildB' $ newCircleShape
                  { radius: radius
                  , fill: nullColor
                  , stroke: frameColor
                  , strokeWidth: frameWidth
                  }
  enableDragB
  tweener ← addTweenB tween
  onDragStartB $ \_ → play tweener
  onDragEndB $ \_ _→ pause tweener
  where
    tween = do
      setLoop true
      scaleTo 1.1 (msec 250) easeInOutCubic
      scaleTo 1.0 (msec 250) easeInOutCubic


newShapes ∷ Effect (Array DisplayElement)
newShapes = sequence
  [ toDisplayElement
      <$> newRectangleShape
            { x: 120.0
            , y: 80.0
            , width: 150.0
            , height: 60.0
            }
  , toDisplayElement
      <$> newRectangleShape
            { x: 200.0
            , y: 180.0
            , width: 100.0
            , height: 50.0
            , stroke: nullColor
            , fill: color "#f60"
            , rotation: deg 120
            }
  , toDisplayElement
      <$> newCircleShape
            { x: 500.0
            , y: 220.0
            , radius: 70.0
            , stroke: color "yellow"
            , fill: color "#669"
            }
  , toDisplayElement
      <$> newTriangleShape
            { x: 420.0
            , y: 450.0
            , width: 100.0
            , height: 500.0
            , stroke: color "red"
            , strokeWidth: 2.0
            , fill: color "#6e6"
            , rotation: deg (-10)
            , shadow: color "black"
            , shadowBlur: 12.0
            }
  , toDisplayElement
      <$> newStarShape
            { x: 780.0
            , y: 450.0
            , radius: 90.0
            }
  , toDisplayElement
      <$> newStarShape
            { x: 420.0
            , y: 250.0
            , radius: 70.0
            , sides: 9.0
            , sideIndent: 0.2
            , stroke: nullColor
            , fill: color "#f96"
            }
  , toDisplayElement
      <$> newHeartShape
            { x: 580.0
            , y: 530.0
            }
  , toDisplayElement
      <$> newHeartShape
            { x: 800.0
            , y: 80.0
            , radius: 70.0
            , cornerAngle: deg 60
            , stroke: color "#f36"
            , strokeWidth: 1.0
            , fill: color "#f69"
            , shadow: color "#300"
            , shadowBlur: 8.0
            }
  , toDisplayElement
      <$> newPolygonShape
            { x: 50.0
            , y: 530.0
            }
  , toDisplayElement
      <$> newPolygonShape
            { x: 220.0
            , y: 450.0
            , radius: 60.0
            , sides: 12.0
            , fill: color "green"
            }
  ]
