-- | # Phina.Types.Property

module Phina.Types.Property
  ( class ReadableAttr
  , class WritableAttr
  , class HasProperty
  , class ReadableProp
  , class WritableProp
  , class ReadableRL
  , class WritableRL
  , class Readable
  , class Writable
  , Prop
  , getProp
  , getProps
  , setProp
  , setProps
  , (.>)
  , modifyProp
  , Params
  , toParams
  , setParams
  , (:>)
  ) where

import Prelude (pure, (<<<))

import Effect (Effect)
import Effect.Uncurried (EffectFn3, runEffectFn3)
import Prim.Row (class Cons) as R
import Type.Prelude (class IsSymbol, class RowToList, SProxy, reflectSymbol)
import Type.Row (class ListToRow, Cons, Nil, kind RowList)
import Unsafe.Coerce (unsafeCoerce)

import Phina.Types.Row (class SubRow)
import Phina.Unsafe (unsafeSetProps, unsafeGetProp, unsafeSetProp)

--

class ReadableAttr (s ∷ Symbol)
instance readableAttrDash ∷ ReadableAttr "-"
instance readableAttrRead ∷ ReadableAttr "r"

class WritableAttr (s ∷ Symbol)
instance writableAttrDash ∷ WritableAttr "-"
instance writableAttrWrite ∷ WritableAttr "w"

data Prop ty (ra ∷ Symbol) (wa ∷ Symbol)

class HasProperty a (r ∷ # Type) | a → r

class ReadableProp a (s ∷ Symbol) ty
instance readableProp ∷
  ( HasProperty a r
  , WritableAttr wa
  , R.Cons s (Prop ty "r" wa) () rp
  , SubRow rp r
  ) ⇒ ReadableProp a s ty

class WritableProp a (s ∷ Symbol) ty
instance writableProp ∷
  ( HasProperty a r
  , ReadableAttr ra
  , R.Cons s (Prop ty ra "w") () rp
  , SubRow rp r
  ) ⇒ WritableProp a s ty

class (RowToList r rl, ListToRow rl r)
  ⇐ ReadableRL a (rl ∷ RowList) r | a rl → r
instance readableRLNil ∷ ReadableRL a Nil ()
instance readableRLCons ∷
  ( RowToList r (Cons s ty tail)
  , R.Cons s ty rt r
  , ListToRow tail rt
  , ReadableProp a s ty
  , ReadableRL a tail rt
  ) ⇒ ReadableRL a (Cons s ty tail) r

class (RowToList r rl, ListToRow rl r)
  ⇐ WritableRL a (rl ∷ RowList) (r ∷ # Type) | a rl → r
instance writableRLNil ∷ WritableRL a Nil ()
instance writableRLCons ∷
  ( RowToList r (Cons s ty tail)
  , R.Cons s ty rt r
  , ListToRow tail rt
  , WritableProp a s ty
  , WritableRL a tail rt
  ) ⇒ WritableRL a (Cons s ty tail) r

class Readable a r
instance readableRecord ∷
  ( RowToList r rl
  , ListToRow rl r
  , ReadableRL a rl r
  ) ⇒ Readable a (Record r)

class Writable a r
instance writableRecord ∷
  ( RowToList r rl
  , ListToRow rl r
  , WritableRL a rl r
  ) ⇒ Writable a (Record r)

getProp
   ∷ ∀ a s ty
   . IsSymbol s
  ⇒ ReadableProp a s ty
  ⇒ SProxy s
  → a
  → Effect ty
getProp s = pure <<< unsafeGetProp (reflectSymbol s)

getProps ∷ ∀ a r. Readable a r ⇒ a → Effect r
getProps = pure <<< unsafeCoerce

setProp
   ∷ ∀ a s ty
   . IsSymbol s
  ⇒ WritableProp a s ty
  ⇒ SProxy s
  → ty
  → a
  → Effect a
setProp s = unsafeSetProp (reflectSymbol s)

-- | ### example
-- | ```purescript`
-- | setProps {x: 1, y: 2} a
-- | ````
setProps ∷ ∀ a r. Writable a r ⇒ r → a → Effect a
setProps = unsafeSetProps

infixr 4  setProps as .>

modifyProp
   ∷ ∀ a s ty
   . IsSymbol s
  ⇒ ReadableProp a s ty
  ⇒ WritableProp a s ty
  ⇒ SProxy s
  → (ty → ty)
  → a
  → Effect a
modifyProp = runEffectFn3 _modifyProp <<< reflectSymbol

--

data Params a

toParams ∷ ∀ a r. Writable a r ⇒ r → Params a
toParams = unsafeCoerce

setParams ∷ ∀ a. Params a → a → Effect a
setParams = unsafeSetProps

infixr 4  setParams as :>

--

foreign import _modifyProp ∷ ∀ a f. EffectFn3 String f a a
