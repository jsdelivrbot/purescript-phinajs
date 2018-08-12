-- phina.main & phina.game.GameApp

module Phina.Main
  ( StartScene(..)
  , SetupMainScene
  , GameScenes(..)
  , newGame
  , runGame
  , class LabeledScene
  , sceneHandle
  , SceneEntry
  , sceneEntry
  ) where

import Prelude

import Data.Array (head)
import Data.Maybe (Maybe(..), maybe')
import Data.Traversable (traverse)
import Effect (Effect)
import Effect.Uncurried (EffectFn1, EffectFn2, runEffectFn1, runEffectFn2)
import Type.Prelude (class IsSymbol, Proxy(..), SProxy(..), reflectSymbol)
import Unsafe.Coerce (unsafeCoerce)

import Phina.Asset.AssetLoader (Assets)
import Phina.Display.DisplayScene (class IsScene, DisplayScene, SceneHandle, SetupScene, className, exit)
import Phina.Game.CountScene (CountScene, CountSetting, countScene)
import Phina.Game.GameApp (GameAppReady, GameParams)
import Phina.Game.LoadingScene (LoadingScene, loadingScene)
import Phina.Game.PauseScene (PauseScene, pauseScene)
import Phina.Game.ResultScene (ResultScene, resultScene)
import Phina.Game.SplashScene (SplashScene, splashScene)
import Phina.Game.TitleScene (TitleScene, titleScene)
import Phina.Types.Row (class SubRow)
import Phina.Unsafe (unsafeNew, unsafeSetProp, unsafeSetProps)

--

data StartScene = Splash | Title | Main | Result

type SetupMainScene = SetupScene DisplayScene () (score ∷ String)

data GameScenes = SceneList (Array SceneEntry)
                | SceneListDefault StartScene SetupMainScene

newGame
   ∷ ∀ a
   . SubRow a GameParams
  ⇒ Record a
  → GameScenes
  → Effect GameAppReady
newGame params scenes = do
  transList ← entryScenes scenes
  config ← makeConfig params transList {}
  unsafeNew "game" "GameApp" config
  where
    makeConfig p transList  = unsafeSetProps p
                          >=> setScenes transList
                          >=> setStartL transList
    setScenes tl config = maybe'  (\_ → pure config)
                                  (\t → unsafeSetProp "scenes" t config)
                                  tl.list
    setStartL tl config = maybe'  (\_ → pure config)
                                  (\l → unsafeSetProp "startLabel" l config)
                                  tl.startLabel

runGame ∷ GameAppReady → Effect Unit
runGame = runEffectFn1 _runGame

foreign import _runGame ∷ EffectFn1 GameAppReady Unit

--

class (IsScene s, IsSymbol l)
  ⇐ LabeledScene h l s (a ∷ # Type) (r ∷ # Type) | h → l s a r
  where
    sceneHandle ∷ Proxy h → SceneHandle s a r

instance labeledSceneSplashScene
  ∷ LabeledScene SplashScene "splash" SplashScene () ()
  where
    sceneHandle _ = splashScene

instance labeledSceneTitleScene
  ∷ LabeledScene TitleScene "title" TitleScene () ()
  where
    sceneHandle _ = titleScene

instance labeledSceneResultScene
  ∷ LabeledScene ResultScene "result" ResultScene (score ∷ String) ()
  where
    sceneHandle _ = resultScene

instance labeledSceneLoadingScene
  ∷ LabeledScene LoadingScene "loading" LoadingScene (assets ∷ Assets) ()
  where
    sceneHandle _ = loadingScene

instance labeledSceneCountScene
  ∷ LabeledScene CountScene "count" CountScene (count ∷ CountSetting) ()
  where
    sceneHandle _ = countScene

instance labeledScenePauseScene
  ∷ LabeledScene PauseScene "pause" PauseScene () ()
  where
    sceneHandle _ = pauseScene

--

foreign import data SceneEntry ∷ Type

sceneEntry
   ∷ ∀ h l s a nh nl ns na nr
   . LabeledScene h l s a na
  ⇒ LabeledScene nh nl ns na nr
  ⇒ Proxy h
  → Proxy nh
  → SceneEntry
sceneEntry _ _ = unsafeCoerce
  { baseClass: className $ Proxy ∷ Proxy s
  , label: reflectSymbol $ SProxy ∷ SProxy l
  , nextLabel: reflectSymbol $ SProxy ∷ SProxy nl
  , setup: unsafeCoerce (sceneHandle $ Proxy ∷ Proxy h) ∷ SetupScene s a na
  }

foreign import data SceneTrans ∷ Type

type SceneTransList =
  { list ∷ Maybe (Array SceneTrans)
  , startLabel ∷ Maybe String
  }

entryScenes ∷ GameScenes → Effect SceneTransList
entryScenes (SceneList list) = entrySceneList list
entryScenes (SceneListDefault s setup) = entrySceneListDefault s setup

entrySceneList ∷ Array SceneEntry → Effect SceneTransList
entrySceneList list = do
  t ← traverse (runEffectFn2 entryScene exit) list
  pure {list: Just t, startLabel: getLabel <$> head t}
  where
    getLabel scene = (unsafeCoerce scene ∷ {label ∷ String}).label

entrySceneListDefault ∷ StartScene → SetupMainScene → Effect SceneTransList
entrySceneListDefault startScene setup = do
  runEffectFn2 entryMainScene exit setup
  pure {list: Nothing, startLabel: Just $ startLabel startScene}
  where
    startLabel Splash = "splash"
    startLabel Title = "title"
    startLabel Main = "main"
    startLabel Result = "result"

foreign import entryScene ∷ ∀ e. EffectFn2 e SceneEntry SceneTrans
foreign import entryMainScene ∷ ∀ e s. EffectFn2 e s Unit
