module Updates.Score exposing (update, Msg(..))
import CasinoModel exposing (..)

type Msg =
      Add Int
    | Subtract Int
    | Half
    | Double
    | ResetScore

update : Msg -> CasinoModel -> (CasinoModel, Cmd Msg)
update msg model =
    case msg of
        Add a -> {model | score = (model.score + a)} ! []
        Subtract a -> {model | score = (model.score - a)} ! []
        Half -> {model | score = (round ((toFloat model.score)/2))} ! []
        Double -> doubleScore(model)
        ResetScore -> {model | score = 0} ! []



doubleScore model = 
    if model.theme == Dark then
        {model | score = ((model.score*2)-1)} ! []
    else {model | score = (model.score*2)} ! []