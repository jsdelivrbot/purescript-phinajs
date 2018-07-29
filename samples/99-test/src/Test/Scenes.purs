module Test.Scenes
  ( sceneList
  ) where

import Phina (SceneEntry, SplashScene, sceneEntry)
import Type.Prelude (Proxy(..))

import Test.Title as T
import Test.Display.Label as S01
import Test.Display.SimpleShape as S02
import Test.Display.Sprite as S03
import Test.Display.Update as S04
import Test.Display.Tweener1 as S05
import Test.Display.Tweener2 as S06
import Test.Display.DisplayElement as S07
import Test.Display.FrameAnimation as S08
import Test.Input.Touch as S09
import Test.Input.Keyboard as S10
import Test.Collision.Object2D as S11
import Test.Scene.Management as S12
import Test.Scene.Management2 as S13
import Test.Util.Grid as S14
import Test.Util.Grid2 as S15
import Test.Benchmark.Sprite as S16


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
  , sceneEntry S09.sceneProxy S10.sceneProxy
  , sceneEntry S10.sceneProxy S11.sceneProxy
  , sceneEntry S11.sceneProxy S12.sceneProxy
  , sceneEntry S12.sceneProxy S13.sceneProxy
  , sceneEntry S13.sceneProxy S14.sceneProxy
  , sceneEntry S14.sceneProxy S15.sceneProxy
  , sceneEntry S15.sceneProxy S16.sceneProxy
  , sceneEntry S16.sceneProxy T.sceneProxy
  ]
