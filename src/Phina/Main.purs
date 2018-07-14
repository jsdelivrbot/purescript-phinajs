-- phina.main & phina.game.GameApp

module Phina.Main
  ( GameScenes(..)
  , newGame
  , runGame
  , class LabeledScene
  , sceneHandle
  , SceneEntry
  , sceneEntry
  ) where

import Prelude

import Data.Array (head)
import Data.Maybe (Maybe(..))
import Data.Traversable (traverse)
import Effect (Effect)
import Effect.Uncurried (EffectFn1, EffectFn2, runEffectFn1, runEffectFn2)
import Type.Prelude (class IsSymbol, Proxy(..), SProxy(..), reflectSymbol)
import Unsafe.Coerce (unsafeCoerce)

import Phina.Asset.AssetLoader (Assets)
import Phina.Display.DisplayScene (class IsScene, DisplayScene, SceneHandle, SetupScene, className, exit)
import Phina.Game.GameApp (GameAppReady, GameParams)
import Phina.Game.Scene (CountScene, CountSetting, LoadingScene, PauseScene, ResultScene, SplashScene, TitleScene, countScene, loadingScene, pauseScene, resultScene, splashScene, titleScene)
import Phina.Types.Row (class SubRow)
import Phina.Unsafe (unsafeNew, unsafeSetProp, unsafeSetProps)

--

data GameScenes = SceneList (Array SceneEntry)
                | MainScene (SetupScene DisplayScene () (score ∷ Int))

newGame
   ∷ ∀ a
   . SubRow a GameParams
  ⇒ Record a
  → GameScenes
  → Effect GameAppReady
newGame a s = do
  config ← unsafeSetProps a {}
  t ← entryScenes s
  config' ← case head t of
    Just f →
      let startLabel = (unsafeCoerce f ∷ {label ∷ String}).label
      in  unsafeSetProp "startLabel" startLabel config
      >>= unsafeSetProp "scenes" t
    Nothing → pure config
  unsafeNew "game" "GameApp" config'

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
  ∷ LabeledScene ResultScene "result" ResultScene (score ∷ Int) ()
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

entryScenes ∷ GameScenes → Effect (Array SceneTrans)
entryScenes (SceneList l) = traverse (runEffectFn2 entryScene exit) l
entryScenes (MainScene s) = const [] <$> runEffectFn2 entryMainScene exit s

foreign import entryScene ∷ ∀ e. EffectFn2 e SceneEntry SceneTrans
foreign import entryMainScene ∷ ∀ e s. EffectFn2 e s Unit
