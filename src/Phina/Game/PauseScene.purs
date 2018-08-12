-- phina.game.PauseScene

module Phina.Game.PauseScene
  ( PauseScene
  , pauseScene
  ) where

import Prelude

import Phina.Accessory.Tweener (class Tweenable)
import Phina.App.Element (class Container, class IsElement)
import Phina.App.Interactive (class Interactive)
import Phina.Display.DisplayScene (class IsScene, SceneHandle, SceneProps)
import Phina.Game.Scene (class IsGameScene, toSceneHandle')
import Phina.Types.Color (Color)
import Phina.Types.Property (class HasProperty)
import Phina.Types.Row (class SubRow)
import Phina.Util.EventDispatcher (class EventDispatcher)
import Phina.Util.Grid (class HasGrid)

--

foreign import data PauseScene ∷ Type

instance hasPropertyPauseScene
   ∷ HasProperty SceneProps r
  ⇒ HasProperty PauseScene r

instance edPauseScene ∷ EventDispatcher PauseScene
instance isElementPauseScene ∷ IsElement PauseScene
instance containerPauseScene ∷ Container PauseScene
instance hasGridPauseScene ∷ HasGrid PauseScene
instance interactivePauseScene ∷ Interactive PauseScene
instance tweenablePauseScene ∷ Tweenable PauseScene

instance isScenePauseScene ∷ IsScene PauseScene where
  className _ = "PauseScene"

instance isGameScenePauseScene ∷
  SubRow a
      ( fontColor ∷ Color
      , exitType ∷ String
      ) ⇒ IsGameScene PauseScene a ()

pauseScene
   ∷ ∀ a
   . SubRow a
      ( fontColor ∷ Color
      , exitType ∷ String
      )
  ⇒ SceneHandle PauseScene a ()
pauseScene = toSceneHandle' \_ _ → pure
