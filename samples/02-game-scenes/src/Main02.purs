-- Game Scenes

module Main02 where

import Prelude

import Effect (Effect)
import Phina (countDown, countList)
import Phina as P

main :: Effect Unit
main = do
  game ← P.newGame gameParams $ gameScenes
  P.runGame game


gameParams =
  { title: "Game Scenes"
  , backgroundColor: P.color "#ec6"
  }


gameScenes ∷ P.GameScenes
gameScenes = P.SceneListDefault P.Main $ \_ _ → P.launchAsync'
  $ P.foreverAsync do

    _ ← P.popup P.countScene { count: countList ["Defaults"]
                              , fontSize: 48.0
                              }
    _ ← P.popup P.splashScene {}
    _ ← P.popup P.titleScene {}
    _ ← P.popup P.countScene {}
    _ ← P.popup P.pauseScene {}
    _ ← P.popup P.resultScene {}

    _ ← P.popup P.countScene   { count: countList ["Customized"]
                                , fontSize: 48.0
                                }
    _ ← P.popup P.splashScene {}
    _ ← P.popup P.titleScene   { title: "Title has changed"
                                , fontColor: P.color "#060"
                                }
    _ ← P.popup P.countScene   { count: countDown 5
                                , fontColor: P.color "blue"
                                , fontSize: 128.0
                                }
    _ ← P.popup P.pauseScene   { fontColor: P.color "red"
                                }
    _ ← P.popup P.resultScene  { score: "777"
                                , message: "bg: {backgroundColor}  size:{width} x {height}"
                                , fontColor: P.color "black"
                                , url: "https://github.com/hansel-no-kioku"
                                , hashtags: "a,b,c"
                                }

    pure unit
