-- | Color string for phina.js

module Phina.Types.Color
  ( Color
  , nullColor
  , color
  , colorToString
  ) where

import Prelude

import Data.Function.Uncurried (Fn3, runFn3)
import Data.Maybe (Maybe(..), maybe)
import Unsafe.Coerce (unsafeCoerce)

-- | Color
foreign import data Color ∷ Type

foreign import nullColor ∷ Color

color ∷ String → Color
color = unsafeCoerce

colorToString ∷ Color → Maybe String
colorToString c = runFn3 nullableColor Nothing Just c

instance showColor ∷ Show Color where
  show = maybe "null" show <<< colorToString

-- | Nullable witch allows false
foreign import nullableColor ∷ ∀ a. Fn3 a (String → a) Color a
