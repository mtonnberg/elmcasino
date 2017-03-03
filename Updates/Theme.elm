module Updates.Theme exposing (update, Msg(..))
import CasinoModel exposing (..)

type Msg =
       SetTheme Theme

update : Msg -> CasinoModel -> (CasinoModel, Cmd Msg)
update msg model =
    case msg of
        SetTheme theme -> {model | theme = theme} ! []