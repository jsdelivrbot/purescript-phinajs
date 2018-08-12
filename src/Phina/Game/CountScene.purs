-- phina.game.CountScene

module Phina.Game.CountScene
  ( CountSetting
  , countDown
  , countList
  , CountScene
  , countScene
  ) where

import Prelude

import Unsafe.Coerce (unsafeCoerce)

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

foreign import data CountScene ∷ Type

instance hasPropertyCountScene
   ∷ HasProperty SceneProps r
  ⇒ HasProperty CountScene r

instance edCountScene ∷ EventDispatcher CountScene
instance isElementCountScene ∷ IsElement CountScene
instance containerCountScene ∷ Container CountScene
instance hasGridCountScene ∷ HasGrid CountScene
instance interactiveCountScene ∷ Interactive CountScene
instance tweenableCountScene ∷ Tweenable CountScene

instance isSceneCountScene ∷ IsScene CountScene where
  className _ = "CountScene"

foreign import data CountSetting ∷ Type

countDown ∷ Int → CountSetting
countDown = unsafeCoerce

countList ∷ Array String → CountSetting
countList = unsafeCoerce

instance isGameSceneCountScene ∷
  SubRow a
      ( count ∷ CountSetting
      , fontColor ∷ Color
      , fontSize ∷ Number
      , exitType ∷ String
      ) ⇒ IsGameScene CountScene a ()

countScene
   ∷ ∀ a
   . SubRow a
      ( count ∷ CountSetting
      , fontColor ∷ Color
      , fontSize ∷ Number
      , exitType ∷ String
      )
  ⇒ SceneHandle CountScene a ()
countScene = toSceneHandle' \_ _ → pure
