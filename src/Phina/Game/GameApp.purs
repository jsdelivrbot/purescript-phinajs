-- phina.game.GameApp

module Phina.Game.GameApp
  ( class IsGameApp
  , GameAppReady
  , GameApp
  , GameParams
  , enableStats
  ) where

import Effect (Effect)
import Effect.Uncurried (EffectFn1, runEffectFn1)
import Prim.Row (class Union)

import Phina.Asset.AssetLoader (Assets)
import Phina.Input.Keyboard (class HasKeyboard)
import Phina.Types.Color (Color)
import Phina.Types.Duration (Duration)
import Phina.Types.Property (class HasProperty, Prop)
import Phina.Util.EventDispatcher (class EventDispatcher)
import Phina.Util.Grid (class HasGrid)

--

class IsGameApp a

foreign import data GameAppReady ∷ Type

instance hasPropertyGameAppReady ∷ HasProperty GameAppReady
  ( awake ∷ Prop Boolean "r" "w"
  , frame ∷ Prop Int "r" "-"
  , fps ∷ Prop Number "r" "w"
  -- phina.display.CanvasApp
  , backgroundColor ∷ Prop Color "r" "w"
  -- phina.app.BaseApp
  , deltaTime ∷ Prop Duration "r" "-"
  , elapsedTime ∷ Prop Duration "r" "-"
  )

instance isGameAppGameAppReady ∷ IsGameApp GameAppReady

--

foreign import data GameApp ∷ Type

instance hasPropertyGameApp ∷
  ( HasProperty GameAppReady rr
  , Union rr
    ( -- phina.app.BaseApp
      currentTime ∷ Prop Duration "r" "-"
    , startTime ∷ Prop Duration "r" "-"
    ) r
  ) ⇒ HasProperty GameApp r

instance isGameAppGameApp ∷ IsGameApp GameApp
instance edGameApp ∷ EventDispatcher GameApp
instance hasKBGameApp ∷ HasKeyboard GameApp
instance hasGridGameApp ∷ HasGrid GameApp

type GameParams =
  ( -- phina.display.DomApp
    query ∷ String
  , domElement ∷ String
  , fps ∷ Number
  -- phina.display.CanvasApp
  , width ∷ Number
  , height ∷ Number
  --   Pixelated is not supported by some browsers
  , backgroundColor ∷ Color
  , columns ∷ Int
  , append ∷ Boolean
  , fit ∷ Boolean
  -- phina.Game.GameApp
  -- , startLabel ∷ String
  , debug ∷ Boolean
  , autoPause ∷ Boolean
  -- phina.asset.AssetLoader
  , assets ∷ Assets
  -- phina.game.TitleScene
  , title ∷ String
  , fontColor ∷ Color
  , exitType ∷ String
  -- phina.game.ResultScene
  , message ∷ String
  , url ∷ String
  , hashtags ∷ String
  )

enableStats ∷ ∀ a. IsGameApp a ⇒ a → Effect a
enableStats = runEffectFn1 _enableStats

foreign import _enableStats ∷ ∀ a. EffectFn1 a a
