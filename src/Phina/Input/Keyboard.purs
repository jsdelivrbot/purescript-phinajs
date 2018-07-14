-- | phina.input.Keyboard

module Phina.Input.Keyboard
  ( class HasKeyboard
  , Key(..)
  , getKey
  , getKeyDown
  , getKeyUp
  ) where

import Prelude

import Data.Function (on)

class HasKeyboard a

data Key = Key String | KeyCode Int

instance eqKey ∷ Eq Key where
  eq (Key a) (Key b) = (eq `on` getKeyCode) a b
  eq (Key a) (KeyCode b) = getKeyCode a == b
  eq (KeyCode a) (Key b) = a == getKeyCode b
  eq (KeyCode a) (KeyCode b) = a == b

foreign import getKey ∷ ∀ a. HasKeyboard a ⇒ Key → a → Boolean

foreign import getKeyDown ∷ ∀ a. HasKeyboard a ⇒ Key → a → Boolean

foreign import getKeyUp ∷ ∀ a. HasKeyboard a ⇒ Key → a → Boolean

foreign import getKeyCode ∷ String → Int
