module Subscriptions exposing(..)

import CasinoModel exposing (..)
import Messages exposing (..)
import Time exposing (Time, second)

subscriptions : CasinoModel -> Sub Msg
subscriptions model =
  Sub.none
  -- Time.every second (Sites Sites.GetAll)