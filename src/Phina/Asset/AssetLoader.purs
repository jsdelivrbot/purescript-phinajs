-- | phina.asset.AssetLoader

module Phina.Asset.AssetLoader
  ( ImageAsset(..)
  , SoundAsset(..)
  , ScriptAsset(..)
  , FontAsset(..)
  , JsonAsset(..)
  , XmlAsset(..)
  , TextAsset(..)
  , Assets
  , AssetsRow
  , makeAssets
  ) where


import Phina.Asset.SpriteSheet (SpriteSheetAsset)
import Phina.Types.Row (class SubRow)

newtype ImageAsset = ImageAsset String
newtype SoundAsset = SoundAsset String
newtype ScriptAsset = ScriptAsset String
newtype FontAsset = FontAsset String
newtype JsonAsset = JsonAsset String
newtype XmlAsset = XmlAsset String
newtype TextAsset = TextAsset String

foreign import data Assets ∷ Type

type AssetsRow =
  ( image ∷ Array ImageAsset
  , sound ∷ Array SoundAsset
  , spritesheet ∷ Array SpriteSheetAsset
  , script ∷ Array ScriptAsset
  , font ∷ Array FontAsset
  , json ∷ Array JsonAsset
  , xml ∷ Array XmlAsset
  , text ∷ Array TextAsset
  )

foreign import makeAssets ∷ ∀ r. SubRow r AssetsRow ⇒ Record r → Assets
