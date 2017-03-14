module CasinoFuzzTestHelper exposing (appFuzzTest)

import Test exposing (..)
import CasinoGenerator exposing (..)
import Expect exposing (..)
import Fuzz exposing (..)
import Messages as CasinoMessages exposing (..)
import Update exposing (..)
import CasinoModel exposing (..)

updateWithMessageAndCheckExpectation: (CasinoMessages.Msg -> CasinoModel -> ( CasinoModel, Cmd CasinoMessages.Msg )) -> (CasinoModel -> Expect.Expectation) -> CasinoMessages.Msg -> Maybe CasinoModel -> Maybe CasinoModel
updateWithMessageAndCheckExpectation update expect msg maybeModel =
    case maybeModel of
        Nothing -> Nothing
        Just model ->
            let (newModel, cmd) = Update.update msg model
            in
            case Expect.getFailure (expect newModel) of
                Nothing -> Just newModel
                Just failure -> Nothing


calcModelAndCheckExpectation: (CasinoMessages.Msg -> CasinoModel -> ( CasinoModel, Cmd CasinoMessages.Msg )) -> CasinoModel -> (CasinoModel -> Expect.Expectation) -> List CasinoMessages.Msg -> Expect.Expectation
calcModelAndCheckExpectation update startModel expect msgs = 
    let
        maybeResultingModel = List.foldl (updateWithMessageAndCheckExpectation update expect) (Just startModel) msgs
    in
    case maybeResultingModel of
        Just model -> Expect.pass
        Nothing -> Expect.fail "expectation failed"


appFuzzTest initModel name expectation = 
    fuzz (Fuzz.list aCasinoMessage) name <| (calcModelAndCheckExpectation Update.update initModel expectation)    
