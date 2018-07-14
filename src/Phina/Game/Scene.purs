-- phina.game.XxxScene

module Phina.Game.Scene
  ( class IsGameScene
  , toSceneHandle'
  , SplashScene
  , splashScene
  , TitleScene
  , titleScene
  , ResultScene
  , resultScene
  , LoadingScene
  , loadingScene
  , CountSetting
  , countDefault
  , countDown
  , countList
  , CountScene
  , countScene
  , PauseScene
  , pauseScene
  ) where

import Prelude

import Unsafe.Coerce (unsafeCoerce)

import Phina.App.Element (class Container, class IsElement)
import Phina.App.Interactive (class Interactive)
import Phina.Asset.AssetLoader (Assets)
import Phina.Display.DisplayScene (class IsScene, SceneHandle, SceneProps, SetupScene)
import Phina.Types.Property (class HasProperty)
import Phina.Util.EventDispatcher (class EventDispatcher)
import Phina.Util.Grid (class HasGrid)

--

class IsScene s ⇐ IsGameScene s (a ∷ # Type) (r ∷ # Type) | s → a r

toSceneHandle'
   ∷ ∀ s a r
   . IsGameScene s a r
  ⇒ SetupScene s a r
  → SceneHandle s a r
toSceneHandle' = unsafeCoerce

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

instance isSceneSplashScene ∷ IsScene SplashScene where
  className _ = "SplashScene"

instance isGameSceneSplashScene ∷ IsGameScene SplashScene () ()

splashScene ∷ SceneHandle SplashScene () ()
splashScene = toSceneHandle' setupDefault

--

foreign import data TitleScene ∷ Type

instance hasPropertyTitleScene
   ∷ HasProperty SceneProps r
  ⇒ HasProperty TitleScene r

instance edTitleScene ∷ EventDispatcher TitleScene
instance isElementTitleScene ∷ IsElement TitleScene
instance containerTitleScene ∷ Container TitleScene
instance hasGridTitleScene ∷ HasGrid TitleScene
instance interactiveTitleScene ∷ Interactive TitleScene

instance isSceneTitleScene ∷ IsScene TitleScene where
  className _ = "TitleScene"

instance isGameSceneTitleScene ∷ IsGameScene TitleScene () ()

titleScene ∷ SceneHandle TitleScene () ()
titleScene = toSceneHandle'  setupDefault

--

foreign import data ResultScene ∷ Type

instance hasPropertyResultScene
   ∷ HasProperty SceneProps r
  ⇒ HasProperty ResultScene r

instance edResultScene ∷ EventDispatcher ResultScene
instance isElementResultScene ∷ IsElement ResultScene
instance containerResultScene ∷ Container ResultScene
instance hasGridResultScene ∷ HasGrid ResultScene
instance interactiveResultScene ∷ Interactive ResultScene

instance isSceneResultScene ∷ IsScene ResultScene where
  className _ = "ResultScene"

instance isGameSceneResultScene ∷ IsGameScene ResultScene (score ∷ String) ()

resultScene ∷ SceneHandle ResultScene (score ∷ String) ()
resultScene = toSceneHandle' setupDefault

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

instance isSceneLoadingScene ∷ IsScene LoadingScene where
  className _ = "LoadingScene"

instance isGameSceneLoadingScene ∷ IsGameScene LoadingScene (assets ∷ Assets) ()

loadingScene ∷ SceneHandle LoadingScene (assets ∷ Assets) ()
loadingScene = toSceneHandle' setupDefault

--

foreign import data CountScene ∷ Type

instance hasPropertyCountScene
   ∷ HasProperty SceneProps r
  ⇒ HasProperty CountScene r

instance edCountScene ∷ EventDispatcher CountScene
instance isElementCountScene ∷ IsElement CountScene
instance containerCountScene ∷ Container CountScene
instance hasGridCountScene ∷ HasGrid CountScene
instance interactiveCountScene ∷ Interactive CountScene

instance isSceneCountScene ∷ IsScene CountScene where
  className _ = "CountScene"

foreign import data CountSetting ∷ Type

foreign import countDefault ∷ CountSetting

countDown ∷ Int → CountSetting
countDown = unsafeCoerce

countList ∷ Array String → CountSetting
countList = unsafeCoerce

instance isGameSceneCountScene ∷ IsGameScene CountScene (count ∷ CountSetting) ()

countScene ∷ SceneHandle CountScene (count ∷ CountSetting) ()
countScene = toSceneHandle' setupDefault

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

instance isScenePauseScene ∷ IsScene PauseScene where
  className _ = "PauseScene"

instance isGameScenePauseScene ∷ IsGameScene PauseScene () ()

pauseScene ∷ SceneHandle PauseScene () ()
pauseScene = toSceneHandle' setupDefault

--

setupDefault ∷ ∀ s a r. IsGameScene s a r ⇒ SetupScene s a r
setupDefault _ _ = pure
