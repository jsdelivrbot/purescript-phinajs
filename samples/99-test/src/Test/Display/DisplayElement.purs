-- | DisplayElement

module Test.Display.DisplayElement
  ( Scene
  , sceneProxy
  ) where

import Prelude

import Data.Foldable (traverse_)
import Data.Traversable (sequence)
import Effect (Effect)
import Effect.Class (liftEffect)
import Phina (class LabeledScene, DisplayElement, DisplayScene, SetupScene, addChildB, addChildB', animateB, build, call, color, deg, easeInOutElastic, make, newCircleShape, newDisplayElement, newHeartShape, newPolygonShape, newRectangleShape, newStarShape, newTriangleShape, onPointStartB, rotateTo, sec, setLoop, setPositionB, setPropsB, toDisplayElement, toSceneHandle, wait)
import Type.Prelude (Proxy(..))


foreign import data Scene ∷ Type

sceneProxy = Proxy ∷ Proxy Scene

instance labeledSceneScene
  ∷ LabeledScene Scene "DisplayElement" DisplayScene () ()
  where
    sceneHandle _ = toSceneHandle setupScene


setupScene ∷ SetupScene DisplayScene () ()
setupScene _ exit = build do
  setPropsB {backgroundColor: color "#773"}
  elements ← liftEffect newElements
  traverse_ addChildB elements
  onPointStartB (\_ → exit {})
  animateB $ (wait $ sec 10) *> (call $ exit {})


newElements ∷ Effect (Array DisplayElement)
newElements = sequence
  [ toDisplayElement
      <$> newRectangleShape
            { x: 250.0
            , y: 120.0
            }
  , toDisplayElement
      <$> newCircleShape
            { x: 480.0
            , y: 500.0
            , radius: 120.0
            }
  , newGroup
  , toDisplayElement
      <$> newPolygonShape
            { x: 200.0
            , y: 390.0
            , radius: 90.0
            , strokeWidth: 10.0
            }
  ]


newGroup ∷ Effect DisplayElement
newGroup = make (newDisplayElement {}) do
  setPositionB {x: 720.0, y: 300.0}
  addChildB' $ newTriangleShape
                { x: 70.0
                , y: 80.0
                , radius: 90.0
                }
  addChildB' $ newStarShape
                { x: -40.0
                , y: -80.0
                , radius: 120.0
                }
  addChildB' $ newHeartShape
                { x: -20.0
                , y: 20.0
                , radius: 80.0
                }
  animateB do
    setLoop true
    rotateTo (deg 360) (sec 2) easeInOutElastic
    rotateTo (deg 0) (sec 2) easeInOutElastic
