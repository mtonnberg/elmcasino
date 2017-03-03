module Update exposing(..)

import CasinoModel exposing (..)
import Messages exposing (..)
import Updates.Score as Score
import Updates.Theme as Theme

update : Msg -> CasinoModel -> (CasinoModel, Cmd Msg)
update msg model =
  case msg of
    Score scoreMsg -> 
      let (m, cmd) = Score.update scoreMsg model
      in
      (m, Cmd.map Score cmd)
    Theme themeMsg ->
      let (m, cmd) = Theme.update themeMsg model
      in
      (m, Cmd.map Theme cmd)

