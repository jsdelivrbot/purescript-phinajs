
module Phina.Types.Builder
  ( Builder
  ) where

import Prelude

import Control.Monad.State (class MonadState, StateT(..), execStateT, lift)
import Data.Newtype (class Newtype, unwrap, wrap)
import Data.Tuple (Tuple(..))
import Effect (Effect)
import Effect.Class (class MonadEffect)

import Phina.Types.Monad.Builder (class MonadBuilder, build)

--

newtype Builder a b = Builder (StateT a Effect b)

derive instance newtypeBuilder ∷ Newtype (Builder a b) _
derive newtype instance functorBuilder ∷ Functor (Builder a)
derive newtype instance applyBuilder ∷ Apply (Builder a)
derive newtype instance applicativeBuilder ∷ Applicative (Builder a)
derive newtype instance bindBuilder ∷ Bind (Builder a)
derive newtype instance monadBuilder ∷ Monad (Builder a)
derive newtype instance monadStateBuilder ∷ MonadState a (Builder a)

instance monadBuilderBuilder ∷ MonadBuilder a (Builder a) Effect where
  update f = wrap $ StateT $ \a → f a <#> Tuple unit
  eval f = wrap $ StateT $ \a → f a <#> \b → Tuple b a
  build = execStateT <<< unwrap
  make a b = a >>= build b

instance monadEffectBuilder ∷ MonadEffect (Builder a) where
  liftEffect = wrap <<< lift
