module CasinoGenerator exposing (..)

import Fuzz exposing (..)
import Messages as CasinoMessages exposing (..)
import Updates.Score as Score
import Updates.Theme exposing (..)
import CasinoModel exposing (..)
import Random.Pcg as Random
import Shrink

scoreMessageGenerator = 
    Random.frequency [
          (21, Random.map Score.Add (Random.choices [ Random.constant 2, Random.constant 4, Random.constant 8]))
        , (7, Random.map Score.Subtract (Random.choices [ Random.constant 6]))
        , (2, Random.constant Score.ResetScore)
        , (7, Random.constant Score.Double)
    ]

themeMessageGenerator = 
    Random.bool |> Random.andThen (\b ->
    if b then
        Random.constant (SetTheme CasinoModel.Dark)
    else
        Random.constant (SetTheme CasinoModel.Light)
    )

casinoMessageGenerator : Random.Generator CasinoMessages.Msg
casinoMessageGenerator =
    Random.frequency [
      (4, Random.map CasinoMessages.Score scoreMessageGenerator)
    , (1,  Random.map CasinoMessages.Theme themeMessageGenerator)
    ]

casinoMessageShrinker : Shrink.Shrinker CasinoMessages.Msg
casinoMessageShrinker message = Shrink.noShrink message

aCasinoMessage : Fuzzer CasinoMessages.Msg
aCasinoMessage =
    let
      generator = casinoMessageGenerator
      shrinker = casinoMessageShrinker
    in
    Fuzz.custom generator shrinker
