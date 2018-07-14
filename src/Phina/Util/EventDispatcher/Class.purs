
module Phina.Util.EventDispatcher.Class
  ( class Event
  , event
  , class EventDispatcher
  ) where

class Event e p | e → p where
  event ∷ e → String

class EventDispatcher a
