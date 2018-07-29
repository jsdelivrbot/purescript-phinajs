module Test.Benchmark.Sprite.MyFace
  ( newMyFace
  ) where

import Prelude

import Data.Symbol (SProxy(..))
import Effect (Effect)
import Effect.Ref (Ref, new, read, write)
import Phina (class Writable, Duration, GameApp, Size, Sprite, Vector2, getPosition, getProp, newSprite, randomVector2, reflectHorizontal, reflectVertical, setPosition, setUpdater, toSec, (*~))
import Test.Assets (myFaceImg)


newMyFace ∷ ∀ r. Writable Sprite r ⇒ Size → r → Effect Sprite
newMyFace areaSize props = do
  initialVelocity ← randomVector2 0.0 500.0
  velocity ← new initialVelocity
  face ← newSprite myFaceImg props
  setUpdater (updateMyFace areaSize velocity) face


updateMyFace ∷ Size → Ref Vector2 → GameApp → Sprite → Effect Unit
updateMyFace areaSize ref gameApp face = do
  deltaTime ← getProp (SProxy ∷ SProxy "deltaTime") gameApp
  position ← getPosition face
  velocity ← read ref
  let newPosition = getNewPosition deltaTime velocity position
  let newVelocity = getNewVelocity areaSize newPosition velocity
  _ ← setPosition newPosition face
  write newVelocity ref


getNewPosition ∷ Duration → Vector2 → Vector2 → Vector2
getNewPosition deltaTime velocity position =
  position + (toSec deltaTime) *~ velocity


getNewVelocity ∷ Size → Vector2 → Vector2 → Vector2
getNewVelocity size position velocity =
  let
    isOut p limit v = (v < 0.0 && p < 0.0) || (v > 0.0 && p > limit)
  in case unit of
    _ | isOut position.x size.width velocity.x  → reflectVertical velocity
      | isOut position.y size.height velocity.y → reflectHorizontal velocity
      | otherwise                               → velocity
