-- phina.util.Tween

module Phina.Util.Tween
  ( Easing
  , easeDefault
  , easeInBack
  , easeInBounce
  , easeInCirc
  , easeInCubic
  , easeInElastic
  , easeInExpo
  , easeInOutBack
  , easeInOutBounce
  , easeInOutCirc
  , easeInOutCubic
  , easeInOutElastic
  , easeInOutExpo
  , easeInOutQuad
  , easeInOutQuart
  , easeInOutQuint
  , easeInOutSine
  , easeInQuad
  , easeInQuart
  , easeInQuint
  , easeInSine
  , easeLinear
  , easeOutBack
  , easeOutBounce
  , easeOutCirc
  , easeOutCubic
  , easeOutElastic
  , easeOutExpo
  , easeOutInBack
  , easeOutInBounce
  , easeOutInCirc
  , easeOutInCubic
  , easeOutInElastic
  , easeOutInExpo
  , easeOutInQuart
  , easeOutInQuint
  , easeOutInSine
  , easeOutQuad
  , easeOutQuart
  , easeOutQuint
  , easeOutSine
  , easeSwing
  ) where

import Unsafe.Coerce (unsafeCoerce)

foreign import data Easing ∷ Type

easeDefault ∷ Easing
easeDefault = unsafeCoerce "default"

easeLinear ∷ Easing
easeLinear = unsafeCoerce "linear"

easeSwing ∷ Easing
easeSwing = unsafeCoerce "swing"

easeInQuad ∷ Easing
easeInQuad = unsafeCoerce "easeInQuad"

easeOutQuad ∷ Easing
easeOutQuad = unsafeCoerce "easeOutQuad"

easeInOutQuad ∷ Easing
easeInOutQuad = unsafeCoerce "easeInOutQuad"

easeInCubic ∷ Easing
easeInCubic = unsafeCoerce "easeInCubic"

easeOutCubic ∷ Easing
easeOutCubic = unsafeCoerce "easeOutCubic"

easeInOutCubic ∷ Easing
easeInOutCubic = unsafeCoerce "easeInOutCubic"

easeOutInCubic ∷ Easing
easeOutInCubic = unsafeCoerce "easeOutInCubic"

easeInQuart ∷ Easing
easeInQuart = unsafeCoerce "easeInQuart"

easeOutQuart ∷ Easing
easeOutQuart = unsafeCoerce "easeOutQuart"

easeInOutQuart ∷ Easing
easeInOutQuart = unsafeCoerce "easeInOutQuart"

easeOutInQuart ∷ Easing
easeOutInQuart = unsafeCoerce "easeOutInQuart"

easeInQuint ∷ Easing
easeInQuint = unsafeCoerce "easeInQuint"

easeOutQuint ∷ Easing
easeOutQuint = unsafeCoerce "easeOutQuint"

easeInOutQuint ∷ Easing
easeInOutQuint = unsafeCoerce "easeInOutQuint"

easeOutInQuint ∷ Easing
easeOutInQuint = unsafeCoerce "easeOutInQuint"

easeInSine ∷ Easing
easeInSine = unsafeCoerce "easeInSine"

easeOutSine ∷ Easing
easeOutSine = unsafeCoerce "easeOutSine"

easeInOutSine ∷ Easing
easeInOutSine = unsafeCoerce "easeInOutSine"

easeOutInSine ∷ Easing
easeOutInSine = unsafeCoerce "easeOutInSine"

easeInExpo ∷ Easing
easeInExpo = unsafeCoerce "easeInExpo"

easeOutExpo ∷ Easing
easeOutExpo = unsafeCoerce "easeOutExpo"

easeInOutExpo ∷ Easing
easeInOutExpo = unsafeCoerce "easeInOutExpo"

easeOutInExpo ∷ Easing
easeOutInExpo = unsafeCoerce "easeOutInExpo"

easeInCirc ∷ Easing
easeInCirc = unsafeCoerce "easeInCirc"

easeOutCirc ∷ Easing
easeOutCirc = unsafeCoerce "easeOutCirc"

easeInOutCirc ∷ Easing
easeInOutCirc = unsafeCoerce "easeInOutCirc"

easeOutInCirc ∷ Easing
easeOutInCirc = unsafeCoerce "easeOutInCirc"

easeInElastic ∷ Easing
easeInElastic = unsafeCoerce "easeInElastic"

easeOutElastic ∷ Easing
easeOutElastic = unsafeCoerce "easeOutElastic"

easeInOutElastic ∷ Easing
easeInOutElastic = unsafeCoerce "easeInOutElastic"

easeOutInElastic ∷ Easing
easeOutInElastic = unsafeCoerce "easeOutInElastic"

easeInBack ∷ Easing
easeInBack = unsafeCoerce "easeInBack"

easeOutBack ∷ Easing
easeOutBack = unsafeCoerce "easeOutBack"

easeInOutBack ∷ Easing
easeInOutBack = unsafeCoerce "easeInOutBack"

easeOutInBack ∷ Easing
easeOutInBack = unsafeCoerce "easeOutInBack"

easeInBounce ∷ Easing
easeInBounce = unsafeCoerce "easeInBounce"

easeOutBounce ∷ Easing
easeOutBounce = unsafeCoerce "easeOutBounce"

easeInOutBounce ∷ Easing
easeInOutBounce = unsafeCoerce "easeInOutBounce"

easeOutInBounce ∷ Easing
easeOutInBounce = unsafeCoerce "easeOutInBounce"
