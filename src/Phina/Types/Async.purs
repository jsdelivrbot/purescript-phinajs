
module Phina.Types.Async
  ( Async
  , makeAsync
  , makeAsync'
  , launchAsync
  , launchAsync'
  , launchAsyncB'
  , runAsync
  , runAsync'
  , runAsyncB'
  , liftBuilder
  , foreverAsync
  ) where

import Prelude

import Control.Alt (class Alt)
import Control.Lazy (class Lazy)
import Control.Monad.Error.Class (class MonadError, class MonadThrow)
import Control.Monad.Rec.Class (class MonadRec, forever)
import Control.Monad.State (class MonadState, StateT(..), evalStateT, execStateT, lift, mapStateT)
import Control.Plus (class Plus)
import Data.Either (Either(..))
import Data.Newtype (class Newtype, unwrap, wrap)
import Data.Tuple (Tuple(..))
import Effect (Effect)
import Effect.Aff (Aff, Canceler, Fiber, launchAff, launchAff_, makeAff, nonCanceler, runAff, runAff_)
import Effect.Class (class MonadEffect, liftEffect)
import Effect.Exception (Error, catchException)

import Phina.Types.Builder (Builder)
import Phina.Types.Monad.Builder (class MonadBuilder, build, eval, update)

--

newtype Async a b = Async (StateT a Aff b)

derive instance newtypeAsync ∷ Newtype (Async a b) _
derive newtype instance functorAsync ∷ Functor (Async a)
derive newtype instance applyAsync ∷ Apply (Async a)
derive newtype instance applicativeAsync ∷ Applicative (Async a)
derive newtype instance bindAsync ∷ Bind (Async a)
derive newtype instance monadAsync ∷ Monad (Async a)
derive newtype instance monadStateAsync ∷ MonadState a (Async a)
derive newtype instance altAsync ∷ Alt (Async a)
derive newtype instance plusAsync ∷ Plus (Async a)
derive newtype instance monadRecAsync ∷ MonadRec (Async a)
derive newtype instance monadThrowAsync ∷ MonadThrow Error (Async a)
derive newtype instance monadErrorAsync ∷ MonadError Error (Async a)
derive newtype instance lazyAsync ∷ Lazy (Async a b)

instance monadBuilderAsync ∷ MonadBuilder a (Async a) Aff where
  update = liftBuilder <<< update
  eval = liftBuilder <<< eval
  build = execStateT <<< unwrap
  make a b = liftEffect a >>= launchAsync' b

instance monadEffectAsync ∷ MonadEffect (Async a) where
  liftEffect = wrap <<< lift <<< liftEffect

--

makeAsync
   ∷ ∀ a b
   . (a → (Either Error b → Effect Unit) → Effect Canceler)
  → Async a b
makeAsync f = wrap $ StateT \a → makeAff
                                    \cb → f a
                                            \r → cb $ (\b → Tuple b a) <$> r

makeAsync' ∷ ∀ a b. (a → (b → Effect Unit) → Effect Unit) → Async a b
makeAsync' f = makeAsync \a cb → do
  catchException (cb <<< Left) (f a $ cb <<< Right)
  pure nonCanceler

launchAsync ∷ ∀ a b. Async a b → a → Effect (Fiber b)
launchAsync b a = launchAff $ evalStateT (unwrap b) a

launchAsync' ∷ ∀ a b. Async a b → a → Effect a
launchAsync' b a = const a <$> (launchAff_ $ evalStateT (unwrap b) a)

launchAsyncB' ∷ ∀ a b. Async a b → Builder a Unit
launchAsyncB' = update <<< launchAsync'

runAsync
   ∷ ∀ a b
   . (Either Error b → Effect Unit)
  → Async a b
  → a
  → Effect (Fiber Unit)
runAsync f b a = runAff f $ evalStateT (unwrap b) a

runAsync'
   ∷ ∀ a b
   . (Either Error b → Effect Unit)
  → Async a b
  → a
  → Effect a
runAsync' f b a = const a <$> (runAff_ f $ evalStateT (unwrap b) a)

runAsyncB'
   ∷ ∀ a b
   . (Either Error b → Effect Unit)
  → Async a b
  → Builder a Unit
runAsyncB' f = update <<< runAsync' f

liftBuilder ∷ ∀ a. Builder a ~> Async a
liftBuilder = wrap <<< mapStateT liftEffect <<< unwrap

foreverAsync ∷ ∀ a b. Async a b → Async a Unit
foreverAsync as = Async $ StateT \a → Tuple unit a <$ (forever $ build as a)
