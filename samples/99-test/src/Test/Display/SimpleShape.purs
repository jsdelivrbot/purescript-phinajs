-- | Shapes

module Test.Display.SimpleShape
  ( Scene
  , sceneProxy
  ) where

import Prelude

import Phina (class LabeledScene, Builder, DisplayScene, SetupScene, addChildB', animateB, build, call, color, deg, newCircleShape, newHeartShape, newPolygonShape, newRectangleShape, newStarShape, newTriangleShape, nullColor, onPointStartB, sec, setPropsB, toSceneHandle, wait)
import Type.Prelude (Proxy(..))


foreign import data Scene ∷ Type

sceneProxy = Proxy ∷ Proxy Scene

instance labeledSceneScene
  ∷ LabeledScene Scene "Simple Shape" DisplayScene () ()
  where
    sceneHandle _ = toSceneHandle setupScene


setupScene ∷ SetupScene DisplayScene () ()
setupScene _ exit = build do
  setPropsB {backgroundColor: color "#69b"}
  addShapes
  onPointStartB (\_ → exit {})
  animateB $ (wait $ sec 10) *> (call $ exit {})


addShapes ∷ Builder DisplayScene Unit
addShapes = do
  addChildB'
    $ newRectangleShape
        { x: 120.0
        , y: 80.0
        , width: 200.0
        , height: 100.0
        }
  addChildB'
    $ newRectangleShape
        { x: 200.0
        , y: 180.0
        , width: 150.0
        , height: 100.0
        , stroke: nullColor
        , fill: color "#f60"
        , rotation: deg 120
        }
  addChildB'
    $ newCircleShape
        { x: 500.0
        , y: 220.0
        , radius: 400.0
        , stroke: color "yellow"
        , fill: color "grey"
        , alpha: 0.5
        }
  addChildB'
    $ newTriangleShape
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
  addChildB'
    $ newStarShape
        { x: 780.0
        , y: 450.0
        , radius: 170.0
        }
  addChildB'
    $ newStarShape
        { x: 420.0
        , y: 250.0
        , radius: 100.0
        , sides: 17.0
        , sideIndent: 0.1
        , stroke: nullColor
        , fill: color "#f96"
        }
  addChildB'
    $ newHeartShape
        { x: 580.0
        , y: 530.0
        }
  addChildB'
    $ newHeartShape
        { x: 800.0
        , y: 80.0
        , radius: 100.0
        , cornerAngle: deg 60
        , stroke: color "#f36"
        , strokeWidth: 1.0
        , fill: color "#f69"
        , shadow: color "#300"
        , shadowBlur: 8.0
        }
  addChildB'
    $ newPolygonShape
        { x: 50.0
        , y: 530.0
        }
  addChildB'
    $ newPolygonShape
        { x: 220.0
        , y: 450.0
        , radius: 120.0
        , sides: 12.0
        , fill: color "green"
        , alpha: 0.3
        }
