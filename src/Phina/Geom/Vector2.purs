-- phina.geom.Vector2

module Phina.Geom.Vector2
  ( Vector2
  , mulVector2
  , (~*)
  , flipMulVector2
  , (*~)
  , divVector2
  , (~/)
  , flipDivVector2
  , (/~)
  , newVector2
  , newVector2fromAngle
  , randomAllVector2
  , randomVector2
  , cross
  , dot
  , reflect
  , reflectHorizontal
  , reflectVertical
  , rotate
  , zero
  , left
  , right
  , up
  , down
  ) where

import Prelude

import Effect (Effect)
import Effect.Uncurried (EffectFn4, runEffectFn4)

import Phina.Types.Angle (Angle, deg)
import Phina.Types.Position (Position)

--
type Vector2 = Position

foreign import mulVector2 ∷ Vector2 → Number → Vector2

infixl 7 mulVector2 as ~*

flipMulVector2 ∷ Number → Vector2 → Vector2
flipMulVector2 = flip mulVector2

infixl 7 flipMulVector2 as *~

foreign import divVector2 ∷ Vector2 → Number → Vector2

infixl 7 divVector2 as ~/

flipDivVector2 ∷ Number → Vector2 → Vector2
flipDivVector2 = flip divVector2

infixl 7 flipDivVector2 as /~

--

newVector2 ∷ Number → Number → Vector2
newVector2 = {x: _, y: _}

foreign import newVector2fromAngle ∷ Angle → Number → Vector2

randomAllVector2 ∷ Angle → Angle → Number → Number → Effect Vector2
randomAllVector2 = runEffectFn4 _randomAllVector2

foreign import _randomAllVector2 ∷ EffectFn4 Angle Angle Number Number Vector2

randomVector2 ∷ Number → Number → Effect Vector2
randomVector2 minLen maxLen = randomAllVector2 (deg 0) (deg 360) minLen maxLen

--

foreign import cross ∷ Vector2 → Vector2 → Number
foreign import dot ∷ Vector2 → Vector2 → Number
foreign import reflect ∷ Vector2 → Vector2 → Vector2
foreign import reflectHorizontal ∷ Vector2 → Vector2
foreign import reflectVertical ∷ Vector2 → Vector2
foreign import rotate ∷ Angle → Vector2 → Vector2

foreign import zero ∷ Vector2
foreign import left ∷ Vector2
foreign import right ∷ Vector2
foreign import up ∷ Vector2
foreign import down ∷ Vector2
