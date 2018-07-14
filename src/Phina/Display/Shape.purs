-- phina.display.plainElement & phina.display.Shape

module Phina.Display.Shape
  ( class IsShape
  , shape
  , ShapeProps
  , Sides
  , newShape
  , newShape'
  ) where

import Prelude

import Effect (Effect)
import Prim.Row (class Union)
import Type.Prelude (Proxy(..))

import Phina.Display.DisplayElement (class IsDisplayElement, DisplayElementProps)
import Phina.Types.Color (Color)
import Phina.Types.Property (class HasProperty, class Writable, Params, Prop)
import Phina.Unsafe (unsafeNew, unsafeSetProps)

--

data ShapeProps
instance hasPropertyShape ∷
  ( HasProperty DisplayElementProps rd
  , Union rd
    (  -- Phina.Display.Is
      backgroundColor ∷ Prop Color "r" "w"
    , padding ∷ Prop Number "r" "w"
    , fill ∷ Prop Color "r" "w"
    , stroke ∷ Prop Color "r" "w"
    , strokeWidth ∷ Prop Number "r" "w"
    , shadow ∷ Prop Color "r" "w"
    , shadowBlur ∷ Prop Number "r" "w"
    ) r
  )
  ⇒ HasProperty ShapeProps r

data Sides
instance hasPropertyHasSides ∷ HasProperty Sides
  ( sides ∷ Prop Number "r" "w"
  )

class IsDisplayElement a ⇐ IsShape a where
  shape ∷ Proxy a → String

newShape ∷ ∀ a r. IsShape a ⇒ Writable a r ⇒ r → Effect a
newShape = unsafeNewShape

newShape' ∷ ∀ a. IsShape a ⇒ Params a → Effect a
newShape' = unsafeNewShape

unsafeNewShape ∷ ∀ a b. IsShape a ⇒ b → Effect a
unsafeNewShape params = do
  shape ← unsafeNew "display" (shape (Proxy ∷ Proxy a)) {}
  unsafeSetProps params shape
