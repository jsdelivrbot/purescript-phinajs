-- | Support interactive

module Phina.App.Interactive
  ( InteractiveProps
  , class Interactive
  , PointEvent
  , onPointOver
  , onPointOut
  , onPointStart
  , onPointEnd
  , onPointStay
  , onPointMove
  , setInteractive
  , getInteractive
  ) where

import Effect (Effect)
import Type.Prelude (SProxy(..))

import Phina.Game.GameApp (GameApp)
import Phina.Geom.Vector2 (Vector2)
import Phina.Types.Property (class HasProperty, class ReadableProp, class WritableProp, Prop, getProp, setProp)
import Phina.Util.EventDispatcher (class EventDispatcher)
import Phina.Util.EventDispatcher.Unsafe (unsafeOn)

data InteractiveProps
instance hasPropertyInteractive ∷ HasProperty InteractiveProps
  ( interactive ∷ Prop Boolean "r" "w"
  )

class EventDispatcher a ⇐ Interactive a

type PointEvent =
  { pointer ∷  -- phina.input.Touch or Mouse
      { position ∷ Vector2
      , startPosition ∷ Vector2
      , deltaPosition ∷ Vector2
      , prevPosition ∷ Vector2
      , flickVelocity ∷ Vector2
      , x ∷ Number
      , y ∷ Number
      , dx ∷ Number
      , dy ∷ Number
      , fx ∷ Number
      , fy ∷ Number
      }
  , interactive ∷   -- phina.app.Interactive
      { app ∷ GameApp
      }
  }

onPointOver
   ∷ ∀ a b
   . Interactive a
  ⇒ (PointEvent → a → Effect b)
  → a
  → Effect a
onPointOver = unsafeOn "pointover"

onPointOut
   ∷ ∀ a b
   . Interactive a
  ⇒ (PointEvent → a → Effect b)
  → a
  → Effect a
onPointOut = unsafeOn "pointout"

onPointStart
   ∷ ∀ a b
   . Interactive a
  ⇒ (PointEvent → a → Effect b)
  → a
  → Effect a
onPointStart = unsafeOn "pointstart"

onPointEnd
   ∷ ∀ a b
   . Interactive a
  ⇒ (PointEvent → a → Effect b)
  → a
  → Effect a
onPointEnd = unsafeOn "pointend"

onPointStay
   ∷ ∀ a b
   . Interactive a
  ⇒ (PointEvent → a → Effect b)
  → a
  → Effect a
onPointStay = unsafeOn "pointstay"

onPointMove
   ∷ ∀ a b
   . Interactive a
  ⇒ (PointEvent → a → Effect b)
  → a
  → Effect a
onPointMove = unsafeOn "pointmove"

setInteractive
   ∷ ∀ a
   . Interactive a
  ⇒ WritableProp a "interactive" Boolean
  ⇒ Boolean
  → a
  → Effect a
setInteractive = setProp (SProxy ∷ SProxy "interactive")

getInteractive
   ∷ ∀ a
   . Interactive a
  ⇒ ReadableProp a "interactive" Boolean
  ⇒ a
  → Effect Boolean
getInteractive = getProp (SProxy ∷ SProxy "interactive")
