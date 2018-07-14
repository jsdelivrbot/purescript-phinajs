
module Phina.Types.Numerical
  ( class Numerical
  , number
  ) where

import Prelude

import Data.Int (toNumber)

class Numerical n where
  number ∷ n → Number

instance numericalInt ∷ Numerical Int where
  number = toNumber

instance numericalNumber ∷ Numerical Number where
  number = identity
