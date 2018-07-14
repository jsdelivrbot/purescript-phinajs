-- | angle

module Phina.Types.Angle
  ( Angle
  , deg
  , rad
  , toDegrees
  , toRadians
  , normalize
  ) where

import Prelude

import Data.Function (on)
import Data.Newtype (class Newtype)
import Math (floor, pi)

import Phina.Types.Numerical (class Numerical, number)

newtype Angle = Angle Number

derive instance newtypeAngle ∷ Newtype Angle _
derive newtype instance semiringAngle ∷ Semiring Angle
derive newtype instance ringAngle ∷ Ring Angle
derive newtype instance showAngle ∷ Show Angle
instance eqAngle ∷ Eq Angle where
  eq (Angle a) (Angle b) = (eq `on` normalize') a b

deg ∷ ∀ n. Numerical n ⇒ n → Angle
deg = Angle <<< number

rad ∷ Number → Angle
rad r = Angle $ r * 180.0 / pi

toDegrees ∷ Angle → Number
toDegrees (Angle d) = d

toRadians ∷ Angle → Number
toRadians (Angle d) = d * pi / 180.0

normalize ∷ Angle → Angle
normalize (Angle d) = Angle $ normalize' d

normalize' ∷ Number → Number
normalize' d = d - (floor d / 360.0) * 360.0
