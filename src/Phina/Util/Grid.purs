-- | phina.util.Grid

module Phina.Util.Grid
  ( class HasGrid
  , setGridX
  , setGridY
  , getSpanX
  , getSpanY
  , getSpanPos
  , getUnitX
  , getUnitY
  , getCenterX
  , getCenterY
  , getCenterPos
  , getGridX
  , getGridY
  , Grid
  , newGrid
  , getSpan
  , getUnit
  , getCenter
  , toProps
  ) where

import Prelude

import Data.Function.Uncurried (Fn2, Fn4, Fn1, runFn1, runFn2, runFn4)
import Effect (Effect)
import Effect.Uncurried (EffectFn2, EffectFn3, EffectFn5, runEffectFn2, runEffectFn3, runEffectFn5)
import Unsafe.Coerce (unsafeCoerce)

import Phina.Types.Position (Position)

--
class HasGrid a

--
setGridX
   ∷ ∀ a
   . HasGrid a
  ⇒ Int
  → Boolean
  → Number
  → a
  → Effect a
setGridX = runEffectFn5 _setGrid "gridX"

setGridY
   ∷ ∀ a
   . HasGrid a
  ⇒ Int
  → Boolean
  → Number
  → a
  → Effect a
setGridY = runEffectFn5 _setGrid "gridY"

getSpanX ∷ ∀ a. HasGrid a ⇒ Int → a → Effect Number
getSpanX = runEffectFn3 _getSpan "gridX"

getSpanY ∷ ∀ a. HasGrid a ⇒ Int → a → Effect Number
getSpanY = runEffectFn3 _getSpan "gridY"

getSpanPos ∷ ∀ a. HasGrid a ⇒ Int → Int → a → Effect Position
getSpanPos x y t = {x: _, y: _} <$> getSpanX x t <*> getSpanY y t

getUnitX ∷ ∀ a. HasGrid a ⇒ a → Effect Number
getUnitX = runEffectFn2 _getUnit "gridX"

getUnitY ∷ ∀ a. HasGrid a ⇒ a → Effect Number
getUnitY = runEffectFn2 _getUnit "gridY"

getCenterX ∷ ∀ a. HasGrid a ⇒ a → Effect Number
getCenterX = runEffectFn2 _getCenter "gridX"

getCenterY ∷ ∀ a. HasGrid a ⇒ a → Effect Number
getCenterY = runEffectFn2 _getCenter "gridY"

getCenterPos ∷ ∀ a. HasGrid a ⇒ a → Effect Position
getCenterPos t = {x: _, y: _} <$> getCenterX t <*> getCenterY t

getGridX ∷ ∀ a. HasGrid a ⇒ a → Effect Grid
getGridX = runEffectFn2 _getGrid "gridX"

getGridY ∷ ∀ a. HasGrid a ⇒ a → Effect Grid
getGridY = runEffectFn2 _getGrid "gridY"

--

foreign import _setGrid ∷ ∀ a. EffectFn5 String Int Boolean Number a a
foreign import _getSpan ∷ ∀ a. EffectFn3 String Int a Number
foreign import _getUnit ∷ ∀ a. EffectFn2 String a Number
foreign import _getCenter ∷ ∀ a. EffectFn2 String a Number
foreign import _getGrid ∷ ∀ a. EffectFn2 String a Grid

--

type GridProps =
  { width ∷ Number
  , columns ∷ Int
  , loop ∷ Boolean
  , offset ∷ Number
  , widthUnit ∷ Number
  }

foreign import data Grid ∷ Type

newGrid ∷ Number → Int → Boolean → Number → Grid
newGrid = runFn4 _newGrid

getSpan ∷ Int → Grid → Number
getSpan = runFn2 _span

getUnit ∷ Grid → Number
getUnit = runFn1 _unit

getCenter ∷ Grid → Number
getCenter = runFn1 _center

toProps ∷ Grid → GridProps
toProps = unsafeCoerce

foreign import _newGrid ∷ Fn4 Number Int Boolean Number Grid
foreign import _span ∷ Fn2 Int Grid Number
foreign import _unit ∷ Fn1 Grid Number
foreign import _center ∷ Fn1 Grid Number
