-- phina.game.LoadingScene

module Phina.Game.LoadingScene
  ( LoadingScene
  , loadingScene
  ) where

import Prelude

import Phina.Accessory.Tweener (class Tweenable)
import Phina.App.Element (class Container, class IsElement)
import Phina.App.Interactive (class Interactive)
import Phina.Asset.AssetLoader (Assets)
import Phina.Display.DisplayScene (class IsScene, SceneHandle, SceneProps)
import Phina.Game.Scene (class IsGameScene, toSceneHandle')
import Phina.Types.Property (class HasProperty)
import Phina.Util.EventDispatcher (class EventDispatcher)
import Phina.Util.Grid (class HasGrid)

--

foreign import data LoadingScene ∷ Type

instance hasPropertyLoadingScene
   ∷ HasProperty SceneProps r
  ⇒ HasProperty LoadingScene r

instance edLoadingScene ∷ EventDispatcher LoadingScene
instance isElementLoadingScene ∷ IsElement LoadingScene
instance containerLoadingScene ∷ Container LoadingScene
instance hasGridLoadingScene ∷ HasGrid LoadingScene
instance interactiveLoadingScene ∷ Interactive LoadingScene
instance tweenableLoadingScene ∷ Tweenable LoadingScene

instance isSceneLoadingScene ∷ IsScene LoadingScene where
  className _ = "LoadingScene"

instance isGameSceneLoadingScene ∷ IsGameScene LoadingScene (assets ∷ Assets) ()

loadingScene ∷ SceneHandle LoadingScene (assets ∷ Assets) ()
loadingScene = toSceneHandle' \_ _ → pure
