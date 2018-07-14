
module Phina.Display.DisplayScene.Builder
  ( popupB'
  , onEnterB
  , onExitB
  , onPauseB
  , onResumeB
  , onFocusB
  , onBlurB
  , onKeyDownB
  , onKeyUpB
  , onKeyPressB
  ) where

import Prelude

import Effect (Effect)

import Phina.Display.DisplayScene (class IsScene, SceneHandle, onBlur, onEnter, onExit, onFocus, onKeyDown, onKeyPress, onKeyUp, onPause, onResume, popup')
import Phina.Game.GameApp (GameApp)
import Phina.Input.Keyboard (Key)
import Phina.Types.Builder (Builder)
import Phina.Types.Monad.Builder (update)

--

popupB'
   ∷ ∀ p a r s
   . IsScene p
  ⇒ IsScene s
  ⇒ SceneHandle p a r
  → Record a
  → Builder s Unit
popupB' h = update <<< popup' h

onEnterB
   ∷ ∀ s a
   . IsScene s
  ⇒ ({app ∷ GameApp} → s → Effect a)
  → Builder s Unit
onEnterB = update <<< onEnter

onExitB
   ∷ ∀ s a
   . IsScene s
  ⇒ ({app ∷ GameApp} → s → Effect a)
  → Builder s Unit
onExitB = update <<< onExit

onPauseB
   ∷ ∀ s a
   . IsScene s
  ⇒ ({app ∷ GameApp} → s → Effect a)
  → Builder s Unit
onPauseB = update <<< onPause

onResumeB
   ∷ ∀ s a
   . IsScene s
  ⇒ ({app ∷ GameApp} → s → Effect a)
  → Builder s Unit
onResumeB = update <<< onResume

onFocusB ∷ ∀ s a. IsScene s ⇒ (s → Effect a) → Builder s Unit
onFocusB = update <<< onFocus

onBlurB ∷ ∀ s a. IsScene s ⇒ (s → Effect a) → Builder s Unit
onBlurB = update <<< onBlur

onKeyDownB ∷ ∀ s a. IsScene s ⇒ (Key → s → Effect a) → Builder s Unit
onKeyDownB = update <<< onKeyDown

onKeyUpB ∷ ∀ s a. IsScene s ⇒ (Key → s → Effect a) → Builder s Unit
onKeyUpB = update <<< onKeyUp

onKeyPressB ∷ ∀ s a. IsScene s ⇒ (Key → s → Effect a) → Builder s Unit
onKeyPressB = update <<< onKeyPress
