-- Read more about this program in the official Elm guide:
-- https://guide.elm-lang.org/architecture/effects/random.html
import CasinoModel exposing (..)
import Messages exposing (..)
import View exposing (..)
import Html exposing (..)
import Update exposing (update)
import Subscriptions exposing (subscriptions)

main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


initialModel = CasinoModel 0 7 Light "debug ⇩"


init : (CasinoModel, Cmd Msg)
init = (initialModel, Cmd.none)