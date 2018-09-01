-- | Sprites with Shapes

module Test.Display.SpriteWithShape
  ( Scene
  , sceneProxy
  ) where

import Prelude

import Data.Array ((..))
import Data.Foldable (for_)
import Effect.Class (liftEffect)
import Phina (class LabeledScene, Builder, DisplayScene, SetupScene, addChildB', animateB, build, call, color, deg, easeDefault, getCenterPosB, getSizeB, make, newSpriteWithShape, newStarShape, onPointStartB, randomVector2, rotateBy, sec, setLoop, setPositionB, setPropsB, toSceneHandle, wait)
import Type.Prelude (Proxy(..))

foreign import data Scene ∷ Type

sceneProxy = Proxy ∷ Proxy Scene

instance labeledSceneScene ∷ LabeledScene Scene "Sprite with Shape" DisplayScene () ()
  where
    sceneHandle _ = toSceneHandle setupScene


setupScene ∷ SetupScene DisplayScene () ()
setupScene _ exit = build do
  setPropsB {backgroundColor: color "#335"}
  addSprites
  onPointStartB (\_ → exit {})
  animateB $ (wait $ sec 10) *> (call $ exit {})


addSprites ∷ Builder DisplayScene Unit
addSprites = do
  size ← getSizeB
  pos ← getCenterPosB
  let dist = (min size.width size.height) / 2.0
  shape ← liftEffect $ newStarShape {radius: 8.0}
  for_ (1..1024) \_ →
    addChildB' $ make (newSpriteWithShape shape) do
    -- addChildB' $ make (newStarShape {radius: 8.0}) do
      rpos ← liftEffect $ randomVector2 0.0 dist
      setPositionB $ pos + rpos
      animateB do
        setLoop true
        rotateBy (deg 360) (sec 1) easeDefault
