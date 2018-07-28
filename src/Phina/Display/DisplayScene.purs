-- phina.app.Scene & phina.display.DisplayScene

module Phina.Display.DisplayScene
  ( class IsScene
  , className
  , SetupScene
  , SceneHandle
  , toSceneHandle
  , SceneProps
  , exit
  , popup
  , popup'
  , onEnter
  , onExit
  , onPause
  , onResume
  , onFocus
  , onBlur
  , onKeyDown
  , onKeyUp
  , onKeyPress
  , DisplayScene
  ) where

import Prelude

import Data.Function.Uncurried (Fn3, runFn3)
import Effect (Effect)
import Effect.Uncurried (EffectFn2, runEffectFn2)
import Prim.Row (class Union)
import Type.Prelude (Proxy(..))
import Unsafe.Coerce (unsafeCoerce)

import Phina.Accessory.Tweener (class Tweenable)
import Phina.App.Element (class Container, class IsElement, ElementProps)
import Phina.App.Interactive (class Interactive, InteractiveProps)
import Phina.Game.GameApp (GameApp)
import Phina.Input.Keyboard (Key(..))
import Phina.Types.Async (Async, launchAsync', makeAsync')
import Phina.Types.Color (Color)
import Phina.Types.Property (class HasProperty, Prop)
import Phina.Types.Size (SizeProps)
import Phina.Util.EventDispatcher (class EventDispatcher)
import Phina.Util.EventDispatcher.Unsafe (unsafeOn)
import Phina.Util.Grid (class HasGrid)

--

class
  ( EventDispatcher s
  , IsElement s
  , Container s
  , HasGrid s
  , Interactive s
  ) ⇐ IsScene s where
  className ∷ Proxy s → String

type SetupScene s a r = Record a → (Record r → s → Effect s) → s → Effect s

foreign import data SceneHandle ∷ Type → (# Type) → (# Type) → Type

toSceneHandle ∷ ∀ a r. SetupScene DisplayScene a r → SceneHandle DisplayScene a r
toSceneHandle = unsafeCoerce

--
data SceneProps

instance hasPropertySceneProps ∷
  ( HasProperty SizeProps rs
  , HasProperty ElementProps re
  , HasProperty InteractiveProps ri
  , Union rs re r1
  , Union r1 ri r2
  , Union r2
    ( backgroundColor ∷ Prop Color "r" "w"
    , width ∷ Prop Number "r" "-"
    , height ∷ Prop Number "r" "-"
    ) r
  )
  ⇒ HasProperty SceneProps r

--

foreign import exit ∷ ∀ r s. Record r → s → Effect s

popup
   ∷ ∀ p a r s
   . IsScene p
  ⇒ IsScene s
  ⇒ SceneHandle p a r
  → Record a
  → Async s (Record r)
popup h = makeAsync' <<< runFn3 _popup
      { baseClass: className $ Proxy ∷ Proxy p
      , setup: unsafeCoerce h ∷ SetupScene p a r
      }

popup'
   ∷ ∀ p a r s
   . IsScene p
  ⇒ IsScene s
  ⇒ SceneHandle p a r
  → Record a
  → s
  → Effect s
popup' h = launchAsync' <<< popup h

foreign import _popup
  ∷ ∀ f a s r
  . Fn3 {baseClass ∷ String, setup ∷ f} a s ((r → Effect Unit) → Effect Unit)

--

onEnter
   ∷ ∀ s a
   . IsScene s
  ⇒ ({app ∷ GameApp} → s → Effect a)
  → s
  → Effect s
onEnter = unsafeOn "enter"

onExit
   ∷ ∀ s a
   . IsScene s
  ⇒ ({app ∷ GameApp} → s → Effect a)
  → s
  → Effect s
onExit = unsafeOn "exit"

onPause
   ∷ ∀ s a
   . IsScene s
  ⇒ ({app ∷ GameApp} → s → Effect a)
  → s
  → Effect s
onPause = unsafeOn "pause"

onResume
   ∷ ∀ s a
   . IsScene s
  ⇒ ({app ∷ GameApp} → s → Effect a)
  → s
  → Effect s
onResume = unsafeOn "resume"

onFocus
   ∷ ∀ s a
   . IsScene s
  ⇒ (s → Effect a)
  → s
  → Effect s
onFocus f = unsafeOn "focus" (\_ → f)

onBlur
   ∷ ∀ s a
   . IsScene s
  ⇒ (s → Effect a)
  → s
  → Effect s
onBlur f = unsafeOn "blur" (\_ → f)

onKeyDown
   ∷ ∀ s a
   . IsScene s
  ⇒ (Key → s → Effect a)
  → s
  → Effect s
onKeyDown f = runEffectFn2 _onKeyDown (\kc → f $ KeyCode kc)

onKeyUp
   ∷ ∀ s a
   . IsScene s
  ⇒ (Key → s → Effect a)
  → s
  → Effect s
onKeyUp f = runEffectFn2 _onKeyUp (\kc → f $ KeyCode kc)

onKeyPress
   ∷ ∀ s a
   . IsScene s
  ⇒ (Key → s → Effect a)
  → s
  → Effect s
onKeyPress f = runEffectFn2 _onKeyPress (\kc → f $ KeyCode kc)

foreign import _onKeyDown ∷ ∀ s a. EffectFn2 (Int → s → Effect a) s s

foreign import _onKeyUp ∷ ∀ s a. EffectFn2 (Int → s → Effect a) s s

foreign import _onKeyPress ∷ ∀ s a. EffectFn2 (Int → s → Effect a) s s

--
foreign import data DisplayScene ∷ Type

instance hasPropertyDisplayScene
   ∷ HasProperty SceneProps r
  ⇒ HasProperty DisplayScene r

instance edDisplayScene ∷ EventDispatcher DisplayScene
instance isElementDisplayScene ∷ IsElement DisplayScene
instance containerDisplayScene ∷ Container DisplayScene
instance hasGridDisplayScene ∷ HasGrid DisplayScene
instance interactiveDisplayScene ∷ Interactive DisplayScene
instance tweenableDisplayScene ∷ Tweenable DisplayScene

instance isSceneDisplayScene ∷ IsScene DisplayScene where
  className _ = "DisplayScene"
