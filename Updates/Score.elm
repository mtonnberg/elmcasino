module Updates.Score exposing (update, Msg(..))
import Http
import CasinoModel exposing (..)
import String

type Msg =
      Add Int
    | Subtract Int
    | Half
    | Double
    | ResetScore

update : Msg -> CasinoModel -> (CasinoModel, Cmd Msg)
update msg model =
    case msg of
        Add a -> ({model | score = (model.score + a)}, Cmd.none)
        Subtract a -> ({model | score = (model.score - a)}, Cmd.none)
        Half -> ({model | score = (round ((toFloat model.score)/2))}, Cmd.none)
        Double -> doubleScore(model)
        ResetScore -> ({model | score = 0}, Cmd.none)




doubleScore model = 
    if model.theme == Dark then
        ({model | score = ((model.score*2)-1)}, Cmd.none)
    else ({model | score = (model.score*2)}, Cmd.none)