module CasinoFuzzTestHelper exposing (appFuzzTest)

import Test exposing (..)
import Either exposing (..)
import CasinoGenerator exposing (..)
import Expect exposing (..)
import Fuzz exposing (..)
import Messages as CasinoMessages exposing (..)
import Update exposing (..)
import CasinoModel exposing (..)

updateWithMessageAndCheckExpectation
    : (CasinoMessages.Msg -> CasinoModel -> ( CasinoModel, Cmd CasinoMessages.Msg ))
    -> (CasinoModel -> Expectation)
    -> Msg
    -> Either ( CasinoModel, { given : String, message : String } ) CasinoModel
    -> Either ( CasinoModel, { given : String, message : String } ) CasinoModel

updateWithMessageAndCheckExpectation update expect msg eitherResult =
    case eitherResult of
        Left failed -> Left failed
        Right model ->
            let (newModel, cmd) = Update.update msg model
            in
            case Expect.getFailure (expect newModel) of
                Nothing -> Right newModel
                Just failure -> Left (newModel, failure)


calcModelAndCheckExpectation
    : (CasinoMessages.Msg -> CasinoModel -> ( CasinoModel, Cmd CasinoMessages.Msg ))
    -> CasinoModel
    -> (CasinoModel -> Expect.Expectation)
    -> List CasinoMessages.Msg
    -> Expect.Expectation

calcModelAndCheckExpectation update startModel expect msgs = 
    let
        maybeResultingModel = List.foldl (updateWithMessageAndCheckExpectation update expect) (Right startModel) msgs
    in
    case maybeResultingModel of
        Right model -> Expect.pass
        Left (finalModel, failure) -> Expect.fail (failure.message ++ "\nfinalmodel: " ++ (toString finalModel) ++ "\n\n" )


appFuzzTest initModel name expectation =
    let
      test =  calcModelAndCheckExpectation Update.update initModel expectation
    in
    fuzz (Fuzz.list aCasinoMessage) name test
