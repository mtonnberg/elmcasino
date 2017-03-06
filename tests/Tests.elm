module Tests exposing (..)

import Test exposing (..)
import Expect
import Fuzz exposing (..)
import Messages as CasinoMessages exposing (..)
import Updates.Score as Score
import Updates.Theme exposing (..)
import CasinoModel exposing (..)
import String
import Random.Pcg as Random
import Random as Ran
import Shrink

scoreMessageGenerator = 
    Random.int 0 6 |> Random.andThen (\i ->
    case i of
        0 -> Random.map Score.Add (Random.choices [ Random.constant 2, Random.constant 4, Random.constant 8])
        1 -> Random.map Score.Subtract (Random.choices [ Random.constant 6])
        _ -> Random.constant Score.Double
    )

    --       Add Int
    -- | Subtract Int
    -- | Half
    -- | Double
    -- | ResetScore

themeMessageGenerator = 
    Random.bool |> Random.andThen (\b ->
    if b then
        Random.constant (SetTheme CasinoModel.Dark)
    else
        Random.constant (SetTheme CasinoModel.Light)
        -- Random.map (CasinoModel.Light (Random.int 0 12)
    )

casinoMessageGenerator : Random.Generator CasinoMessages.Msg
casinoMessageGenerator = 
    Random.bool |> Random.andThen (\b ->
    if b then
        Random.map CasinoMessages.Score scoreMessageGenerator
    else
        Random.map CasinoMessages.Theme themeMessageGenerator
    )


casinoMessageShrinker : Shrink.Shrinker CasinoMessages.Msg
casinoMessageShrinker message = Shrink.noShrink message

aCasinoMessage : Fuzzer CasinoMessages.Msg
aCasinoMessage =
    let
      generator = casinoMessageGenerator
      shrinker = casinoMessageShrinker
    in
    Fuzz.custom generator shrinker

all = describe "all tests" 
    [ fuzz aCasinoMessage "only dark themes are incorrectly valid" dummyTest
    ]

dummyTest message =
    case message of
    Theme (SetTheme t) -> Expect.equal t CasinoModel.Dark
    _ -> Expect.equal 1 1
