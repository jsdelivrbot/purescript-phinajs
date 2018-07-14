
module Phina.Util.Grid.Builder
  ( setGridXB
  , setGridYB
  , getSpanXB
  , getSpanYB
  , getSpanPosB
  , getUnitXB
  , getUnitYB
  , getCenterXB
  , getCenterYB
  , getCenterPosB
  , getGridXB
  , getGridYB
  ) where

import Prelude

import Phina.Types.Builder (Builder)
import Phina.Types.Monad.Builder (eval, update)
import Phina.Types.Position (Position)
import Phina.Util.Grid (class HasGrid, Grid, getCenterPos, getCenterX, getCenterY, getGridY, getSpanPos, getSpanX, getSpanY, getUnitX, getUnitY, setGridX, setGridY)

--

setGridXB
   ∷ ∀ a
   . HasGrid a
  ⇒ Int
  → Boolean
  → Number
  → Builder a Unit
setGridXB columns isLoop offset = update $ setGridX columns isLoop offset

setGridYB
   ∷ ∀ a
   . HasGrid a
  ⇒ Int
  → Boolean
  → Number
  → Builder a Unit
setGridYB columns isLoop offset = update $ setGridY columns isLoop offset

getSpanXB ∷ ∀ a. HasGrid a ⇒ Int → Builder a Number
getSpanXB = eval <<< getSpanX

getSpanYB ∷ ∀ a. HasGrid a ⇒ Int → Builder a Number
getSpanYB = eval <<< getSpanY

getSpanPosB ∷ ∀ a. HasGrid a ⇒ Int → Int → Builder a Position
getSpanPosB x y = eval $ getSpanPos x y

getUnitXB ∷ ∀ a. HasGrid a ⇒ Builder a Number
getUnitXB = eval getUnitX

getUnitYB ∷ ∀ a. HasGrid a ⇒ Builder a Number
getUnitYB = eval getUnitY

getCenterXB ∷ ∀ a. HasGrid a ⇒ Builder a Number
getCenterXB = eval getCenterX

getCenterYB ∷ ∀ a. HasGrid a ⇒ Builder a Number
getCenterYB = eval getCenterY

getCenterPosB ∷ ∀ a. HasGrid a ⇒ Builder a Position
getCenterPosB = eval getCenterPos

getGridXB ∷ ∀ a. HasGrid a ⇒ Builder a Grid
getGridXB = eval getGridY

getGridYB ∷ ∀ a. HasGrid a ⇒ Builder a Grid
getGridYB = eval getGridY
