
module Phina.Types.Duration
 ( Duration
 , hour
 , minute
 , sec
 , msec
 , toHour
 , toMinute
 , toSec
 , toMSec
 ) where

import Prelude

import Data.Newtype (class Newtype)

import Phina.Types.Numerical (class Numerical, number)

--

newtype Duration = Duration Number

derive instance newtypeDuration ∷ Newtype Duration _
derive newtype instance semiringDuration ∷ Semiring Duration
derive newtype instance ringDuration ∷ Ring Duration
derive newtype instance eqDuration ∷ Eq Duration
derive newtype instance ordDuration ∷ Ord Duration
derive newtype instance showDuration ∷ Show Duration

--

hour ∷ ∀ n. Numerical n ⇒ n → Duration
hour = Duration <<< (_ * 60.0 * 60.0 * 1000.0) <<< number

minute ∷ ∀ n. Numerical n ⇒ n → Duration
minute = Duration <<< (_ * 60.0 * 1000.0) <<< number

sec ∷ ∀ n. Numerical n ⇒ n → Duration
sec = Duration <<< (_ * 1000.0) <<< number

msec ∷ ∀ n. Numerical n ⇒ n → Duration
msec = Duration <<< number

toHour ∷ Duration → Number
toHour (Duration n) = n / (60.0 * 60.0 * 1000.0)

toMinute ∷ Duration → Number
toMinute (Duration n) = n / (60.0 * 1000.0)

toSec ∷ Duration → Number
toSec (Duration n) = n / 1000.0

toMSec ∷ Duration → Number
toMSec (Duration n) = n
