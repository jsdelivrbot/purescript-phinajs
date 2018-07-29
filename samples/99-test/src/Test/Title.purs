module Test.Title
  ( Scene
  , sceneProxy
  ) where

import Prelude

import Phina (class LabeledScene, SetupScene, TitleScene, animate, call, sec, toSceneHandle', wait)
import Type.Prelude (Proxy(..))


foreign import data Scene ∷ Type

sceneProxy = Proxy ∷ Proxy Scene

instance labeledSceneScene ∷ LabeledScene Scene "title" TitleScene () ()
  where
    sceneHandle _ = toSceneHandle' setupScene


setupScene ∷ SetupScene TitleScene () ()
setupScene _ exit = animate $ (wait $ sec 10) *> (call $ exit {})
