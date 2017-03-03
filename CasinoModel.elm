module CasinoModel exposing (..)

type Theme =
    Light
  | Dark

type alias CasinoModel =
  {
    score : Int
  , targetScore : Int  
  , theme : Theme
  , debugText : String
  }
