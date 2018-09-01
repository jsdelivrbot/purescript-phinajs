-- phina.display.Sprite

module Phina.Display.Sprite
  ( Sprite
  , newSprite
  , newSprite'
  , newSpriteWithShape
  , setFrameIndex
  , getFrameIndex
  , setAnimation
  , playAnimation
  ) where

import Prelude

import Effect (Effect)
import Effect.Uncurried (EffectFn1, EffectFn2, EffectFn3, runEffectFn1, runEffectFn2, runEffectFn3)
import Prim.Row (class Union)
import Type.Prelude (SProxy(..))

import Phina.Accessory.Draggable (class Draggable)
import Phina.Accessory.Flickable (class Flickable)
import Phina.Accessory.Tweener (class Tweenable)
import Phina.App.Element (class Container, class IsElement)
import Phina.App.Interactive (class Interactive)
import Phina.Asset.AssetLoader (ImageAsset)
import Phina.Asset.SpriteSheet (SpriteSheetAsset)
import Phina.Display.DisplayElement (class IsDisplayElement, DisplayElementProps)
import Phina.Display.Shape (class IsShape)
import Phina.Types.Property (class HasProperty, class Writable, Params, Prop, getProp, setProp)
import Phina.Unsafe (unsafeNew, unsafeSetProps)
import Phina.Util.EventDispatcher (class EventDispatcher)

--
foreign import data Sprite ∷ Type

instance hasPropertySprite ∷
  ( HasProperty DisplayElementProps rd
  , Union rd
    ( frameIndex ∷ Prop Int "r" "w"
    ) r
  )
  ⇒ HasProperty Sprite r

instance edSprite ∷ EventDispatcher Sprite
instance isElementSprite ∷ IsElement Sprite
instance containerSprite ∷ Container Sprite
instance isDeSprite ∷ IsDisplayElement Sprite
instance interactiveSprite ∷ Interactive Sprite
instance draggableSprite ∷ Draggable Sprite
instance flickableSprite ∷ Flickable Sprite
instance tweenableSprite ∷ Tweenable Sprite

--
newSprite ∷ ∀ r. Writable Sprite r ⇒ ImageAsset → r → Effect Sprite
newSprite = unsafeNewSprite

newSprite' ∷ ImageAsset → Params Sprite → Effect Sprite
newSprite' = unsafeNewSprite

newSpriteWithShape ∷ ∀ a. IsShape a ⇒ a → Effect Sprite
newSpriteWithShape = runEffectFn1 _newSpriteWithShape

setFrameIndex ∷ Int → Sprite → Effect Sprite
setFrameIndex = setProp (SProxy ∷ SProxy "frameIndex")

getFrameIndex ∷ Sprite → Effect Int
getFrameIndex = getProp (SProxy ∷ SProxy "frameIndex")

setAnimation ∷ SpriteSheetAsset → Sprite → Effect Sprite
setAnimation = runEffectFn2 _setAnimation

playAnimation ∷ String → Boolean → Sprite → Effect Sprite
playAnimation = runEffectFn3 _playAnimation

--

unsafeNewSprite ∷ ∀ a. ImageAsset → a → Effect Sprite
unsafeNewSprite image params = do
  sprite ← unsafeNew "display" "Sprite" image
  unsafeSetProps params sprite

foreign import _newSpriteWithShape ∷ ∀ a. EffectFn1 a Sprite

foreign import _setAnimation ∷ EffectFn2 SpriteSheetAsset Sprite Sprite

foreign import _playAnimation ∷ EffectFn3 String Boolean Sprite Sprite
