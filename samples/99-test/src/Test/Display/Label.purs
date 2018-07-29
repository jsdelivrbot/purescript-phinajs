-- | Labels

module Test.Display.Label
  ( Scene
  , sceneProxy
  ) where

import Prelude

import Data.Foldable (traverse_)
import Phina (class LabeledScene, Builder, DisplayScene, SetupScene, addChildB', animateB, build, call, color, deg, newLabel, onPointStartB, sec, setPropsB, toSceneHandle, wait)
import Type.Prelude (Proxy(..))


foreign import data Scene ∷ Type

sceneProxy = Proxy ∷ Proxy Scene

instance labeledSceneScene ∷ LabeledScene Scene "Label" DisplayScene () ()
  where
    sceneHandle _ = toSceneHandle setupScene


setupScene ∷ SetupScene DisplayScene () ()
setupScene _ exit = build do
  setPropsB {backgroundColor: color "#ba7"}
  addLabels
  onPointStartB (\_ → exit {})
  animateB $ (wait $ sec 10) *> (call $ exit {})


addLabels ∷ Builder DisplayScene Unit
addLabels = traverse_ addChildB' labels
  where
    labels =
      [ newLabel  { text: "Hello World"
                  , x: 150.0
                  , y: 150.0
                  , fill: color "white"
                  , fontFamily: "serif"
                  }
      , newLabel  { text: "こんにちは、世界"
                  , x: 530.0
                  , y: 250.0
                  , fill: color "red"
                  , fontSize: 80.0
                  , rotation: deg 45
                  }
      , newLabel  { text: "Bonjour le monde"
                  , x: 700.0
                  , y: 500.0
                  , fill: color "#32f"
                  , fontSize: 150.0
                  , fontWeight: "bold"
                  , rotation: deg (-30)
                  , scaleX: 0.2
                  , scaleY: 1.5
                  }
      , newLabel  { text: "你好，世界"
                  , x: 350.0
                  , y: 300.0
                  , fill: color "#ed3"
                  , fontSize: 120.0
                  , fontFamily: "cursive"
                  , rotation: deg 150
                  , alpha: 0.8
                  }
      , newLabel  { text: "مرحبا بالعالم"
                  , x: 830.0
                  , y: 180.0
                  , fill: color "#6ea"
                  , fontSize: 64.0
                  , rotation: deg (-90)
                  }
      , newLabel  { text: "ஹலோ உலகம்"
                  , x: 450.0
                  , y: 580.0
                  , fill: color "#f5c"
                  , fontSize: 48.0
                  , rotation: deg 5
                  }
      ]
