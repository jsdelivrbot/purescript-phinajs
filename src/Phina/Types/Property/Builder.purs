
module Phina.Types.Property.Builder
  ( getPropB
  , getPropsB
  , setPropB
  , setPropsB
  , modifyPropB
  , setParamsB
  ) where

import Prelude

import Type.Prelude (class IsSymbol, SProxy)

import Phina.Types.Builder (Builder)
import Phina.Types.Monad.Builder (eval, update)
import Phina.Types.Property (class Readable, class ReadableProp, class Writable, class WritableProp, Params, getProp, getProps, modifyProp, setParams, setProp, setProps)

--

getPropB
   ∷ ∀ a s ty
   . IsSymbol s
  ⇒ ReadableProp a s ty
  ⇒ SProxy s
  → Builder a ty
getPropB = eval <<< getProp

getPropsB ∷ ∀ a r. Readable a r ⇒ Builder a r
getPropsB = eval getProps

setPropB
   ∷ ∀ a s ty
   . IsSymbol s
  ⇒ WritableProp a s ty
  ⇒ SProxy s
  → ty
  → Builder a Unit
setPropB s = update <<< setProp s

setPropsB ∷ ∀ a r. Writable a r ⇒ r → Builder a Unit
setPropsB = update <<< setProps

modifyPropB
   ∷ ∀ a s ty
   . IsSymbol s
  ⇒ ReadableProp a s ty
  ⇒ WritableProp a s ty
  ⇒ SProxy s
  → (ty → ty)
  → Builder a Unit
modifyPropB s = update <<< modifyProp s

setParamsB ∷ ∀ a. Params a → Builder a Unit
setParamsB = update <<< setParams
