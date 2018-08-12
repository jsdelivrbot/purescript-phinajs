-- phina.game.ResultScene

module Phina.Game.ResultScene
  ( ResultScene
  , resultScene
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

foreign import data ResultScene ∷ Type

instance hasPropertyResultScene
   ∷ HasProperty SceneProps r
  ⇒ HasProperty ResultScene r

instance edResultScene ∷ EventDispatcher ResultScene
instance isElementResultScene ∷ IsElement ResultScene
instance containerResultScene ∷ Container ResultScene
instance hasGridResultScene ∷ HasGrid ResultScene
instance interactiveResultScene ∷ Interactive ResultScene
instance tweenableResultScene ∷ Tweenable ResultScene

instance isSceneResultScene ∷ IsScene ResultScene where
  className _ = "ResultScene"

instance isGameSceneResultScene ∷
  SubRow a
      ( score ∷ String
      , message ∷ String
      , fontColor ∷ Color
      , url ∷ String
      , hashtags ∷ String
      , exitType ∷ String
      ) ⇒ IsGameScene ResultScene a ()

resultScene
   ∷ ∀ a
   . SubRow a
      ( score ∷ String
      , message ∷ String
      , fontColor ∷ Color
      , url ∷ String
      , hashtags ∷ String
      , exitType ∷ String
      )
  ⇒ SceneHandle ResultScene a ()
resultScene = toSceneHandle' \_ _ → pure
