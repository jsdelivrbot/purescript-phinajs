-- phina.game.XxxScene

module Phina.Game.Scene
  ( class IsGameScene
  , toSceneHandle'
  ) where

import Unsafe.Coerce (unsafeCoerce)

import Phina.Display.DisplayScene (class IsScene, SceneHandle, SetupScene)

--

class IsScene s ⇐ IsGameScene s (a ∷ # Type) (r ∷ # Type) | s → a r

toSceneHandle'
   ∷ ∀ s a r
   . IsGameScene s a r
  ⇒ SetupScene s a r
  → SceneHandle s a r
toSceneHandle' = unsafeCoerce
