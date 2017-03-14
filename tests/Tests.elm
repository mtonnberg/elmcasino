module Tests exposing (..)

import Test exposing (..)
import CasinoFuzzTestHelper exposing (..)
import Expect exposing (..)
import CasinoModel exposing (..)

  
initModel = CasinoModel 0 7 CasinoModel.Light ""

all = describe "all tests" 
    [ appFuzzTest
        initModel
        "The application should not get into an invalid state"
        (\model -> Expect.notEqual model.score model.targetScore)
    ]


