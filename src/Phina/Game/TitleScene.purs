-- phina.game.TitleScene

module Phina.Game.TitleScene
  ( TitleScene
  , titleScene
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

foreign import data TitleScene ∷ Type

instance hasPropertyTitleScene
   ∷ HasProperty SceneProps r
  ⇒ HasProperty TitleScene r

instance edTitleScene ∷ EventDispatcher TitleScene
instance isElementTitleScene ∷ IsElement TitleScene
instance containerTitleScene ∷ Container TitleScene
instance hasGridTitleScene ∷ HasGrid TitleScene
instance interactiveTitleScene ∷ Interactive TitleScene
instance tweenableTitleScene ∷ Tweenable TitleScene

instance isSceneTitleScene ∷ IsScene TitleScene where
  className _ = "TitleScene"

instance isGameSceneTitleScene ∷
  SubRow a
      ( title ∷ String
      , fontColor ∷ Color
      , exitType ∷ String
      ) ⇒ IsGameScene TitleScene a ()

titleScene
   ∷ ∀ a
   . SubRow a
      ( title ∷ String
      , fontColor ∷ Color
      , exitType ∷ String
      )
  ⇒ SceneHandle TitleScene a ()
titleScene = toSceneHandle' \_ _ → pure
