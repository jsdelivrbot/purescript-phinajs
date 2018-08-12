-- phina.game.SplashScene

module Phina.Game.SplashScene
  ( SplashScene
  , splashScene
  ) where

import Prelude

import Phina.Accessory.Tweener (class Tweenable)
import Phina.App.Element (class Container, class IsElement)
import Phina.App.Interactive (class Interactive)
import Phina.Display.DisplayScene (class IsScene, SceneHandle, SceneProps)
import Phina.Game.Scene (class IsGameScene, toSceneHandle')
import Phina.Types.Property (class HasProperty)
import Phina.Util.EventDispatcher (class EventDispatcher)
import Phina.Util.Grid (class HasGrid)

--

foreign import data SplashScene ∷ Type

instance hasPropertySplashScene
   ∷ HasProperty SceneProps r
  ⇒ HasProperty SplashScene r

instance edSplashScene ∷ EventDispatcher SplashScene
instance isElementSplashScene ∷ IsElement SplashScene
instance containerSplashScene ∷ Container SplashScene
instance hasGridSplashScene ∷ HasGrid SplashScene
instance interactiveSplashScene ∷ Interactive SplashScene
instance tweenableSplashScene ∷ Tweenable SplashScene

instance isSceneSplashScene ∷ IsScene SplashScene where
  className _ = "SplashScene"

instance isGameSceneSplashScene ∷ IsGameScene SplashScene () ()

splashScene ∷ SceneHandle SplashScene () ()
splashScene = toSceneHandle' \_ _ → pure
