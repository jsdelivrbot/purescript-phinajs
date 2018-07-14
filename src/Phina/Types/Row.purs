-- | Row

module Phina.Types.Row
  ( class SubRow
  ) where

import Prim.Row (class Union)

class SubRow (r ∷ # Type) (s ∷ # Type)
instance subRowInstance ∷ Union r t s ⇒ SubRow r s
