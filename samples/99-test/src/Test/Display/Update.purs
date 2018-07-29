-- | update

module Test.Display.Update
  ( Scene
  , sceneProxy
  ) where

import Prelude

import Effect (Effect)
import Effect.Ref (Ref, new, read, write)
import Phina (class LabeledScene, class Writable, Angle, Builder, DisplayScene, HeartShape, SetupScene, StarShape, Vector2, addChildB', animateB, build, call, color, deg, getPosition, getProp, make, modifyProp, newHeartShape, newStarShape, onPointStartB, right, rotate, sec, setPosition, setProp, setPropsB, setUpdater, setUpdaterB, toSceneHandle, wait, (*~))
import Type.Prelude (Proxy(..), SProxy(..))


foreign import data Scene ∷ Type

sceneProxy = Proxy ∷ Proxy Scene

instance labeledSceneScene ∷ LabeledScene Scene "Update" DisplayScene () ()
  where
    sceneHandle _ = toSceneHandle setupScene


setupScene ∷ SetupScene DisplayScene () ()
setupScene _ exit = build do
  setPropsB {backgroundColor: color "#999"}
  addStarShape {x: 480.0, y: 80.0} (deg 1.0)
  addStarShape {x: 800.0, y: 480.0, radius: 80.0, sides: 11.0, fill: color "red"} (deg (-5.0))
  addStarShape {x: 50.0, y: 50.0, radius: 600.0, alpha: 0.2} (deg 0.1)
  addHeartShape {x: 320.0, y: 120.0} 5.0 (deg 2.0)
  addHeartShape {x: 100.0, y: 350.0} 0.5 (deg 5.0)
  addHeartShape {x: 800.0, y: 100.0, radius: 100.0, fill: color "white"} 50.0 (deg 2.0)
  onPointStartB (\_ → exit {})
  animateB $ (wait $ sec 10) *> (call $ exit {})


addStarShape
   ∷ ∀ r
   . Writable StarShape r
  ⇒ r
  → Angle
  → Builder DisplayScene Unit
addStarShape props yaw =
  addChildB' $ make (newStarShape props) $ setUpdaterB updater
  where
    updater _ = modifyProp (SProxy ∷ SProxy "rotation") (_ + yaw)


addHeartShape
   ∷ ∀ r
   . Writable HeartShape r
  ⇒ r
  → Number
  → Angle
  → Builder DisplayScene Unit
addHeartShape props v0 yaw = addChildB' do
  shape <- newHeartShape props
  ref ← new $ v0 *~ right
  setUpdater (addHeartUpdater yaw ref) shape


addHeartUpdater
   ∷ ∀ a
   . Angle
  → Ref Vector2
  → a
  → HeartShape
  → Effect HeartShape
addHeartUpdater yaw ref _ s = do
  pos ← getPosition s
  rot ← getProp rotation s
  velocity ← read ref
  let vel = rotate yaw velocity
  _ ← write vel ref
  _ ← setPosition (pos + velocity) s
  setProp rotation (rot - yaw) s
  where
    rotation = SProxy ∷ SProxy "rotation"
