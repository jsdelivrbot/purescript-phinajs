module Test.Scenes
  ( sceneList
  ) where

import Phina (SceneEntry, SplashScene, sceneEntry)
import Type.Prelude (Proxy(..))

import Test.Title as T
import Test.Display.Label as S01
import Test.Display.SimpleShape as S02
import Test.Display.Sprite as S03
import Test.Display.SpriteWithShape as S04
import Test.Display.Update as S05
import Test.Display.Tweener1 as S06
import Test.Display.Tweener2 as S07
import Test.Display.DisplayElement as S08
import Test.Display.FrameAnimation as S09
import Test.UI.Button as S20
import Test.Input.Touch as S30
import Test.Input.Keyboard as S31
import Test.Collision.Object2D as S40
import Test.Scene.Management as S50
import Test.Scene.Management2 as S51
import Test.Util.Grid as S60
import Test.Util.Grid2 as S61
import Test.Benchmark.Sprite as S99


sceneList ∷ Array SceneEntry
sceneList =
  [ sceneEntry (Proxy ∷ Proxy SplashScene) T.sceneProxy
  , sceneEntry T.sceneProxy S01.sceneProxy
  , sceneEntry S01.sceneProxy S02.sceneProxy
  , sceneEntry S02.sceneProxy S03.sceneProxy
  , sceneEntry S03.sceneProxy S04.sceneProxy
  , sceneEntry S04.sceneProxy S05.sceneProxy
  , sceneEntry S05.sceneProxy S06.sceneProxy
  , sceneEntry S06.sceneProxy S07.sceneProxy
  , sceneEntry S07.sceneProxy S08.sceneProxy
  , sceneEntry S08.sceneProxy S09.sceneProxy
  , sceneEntry S09.sceneProxy S20.sceneProxy
  , sceneEntry S20.sceneProxy S30.sceneProxy
  , sceneEntry S30.sceneProxy S31.sceneProxy
  , sceneEntry S31.sceneProxy S40.sceneProxy
  , sceneEntry S40.sceneProxy S50.sceneProxy
  , sceneEntry S50.sceneProxy S51.sceneProxy
  , sceneEntry S51.sceneProxy S60.sceneProxy
  , sceneEntry S60.sceneProxy S61.sceneProxy
  , sceneEntry S61.sceneProxy S99.sceneProxy
  , sceneEntry S99.sceneProxy T.sceneProxy
  ]
