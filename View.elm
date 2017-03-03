module View exposing (view)

import CasinoModel exposing (..)
import Messages exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Updates.Score as Score exposing (..)
import Updates.Theme as Theme exposing (..)

renderDebugToggle model = span [
          class "debugToggle"
          --, onClick Debug.ToggleDebug
        ]
        [text model.debugText]

renderDebugger model = div [class "debug-window", style [("display", "none")]] []

renderHeader = header [] [h1 [] [ text "Casino"]]

renderInstructions targetScore = section 
  [class "score-board"]
  [text ("Get exactly " ++ (toString targetScore) ++ " points to win!")]

renderCurrentScore score = div [class "current-score"] [text (toString score)]
renderAdd2Button = button [onClick (Messages.Score (Score.Add 2))] [text "Add 2"]
renderAdd4Button = button [onClick (Messages.Score (Score.Add 4))] [text "Add 4"]
renderAdd8Button = button [onClick (Messages.Score (Score.Add 8))] [text "Add 8"]
renderSubtract6Button = button [class "subtract-btn", onClick (Messages.Score (Score.Subtract 6))] [text "Subtract 6"]
renderDoubleButton = button [class "double-btn", onClick (Messages.Score Score.Double)] [text "Double"]
renderUseDarkThemeButton = button [onClick (Messages.Theme (Theme.SetTheme Dark))] [text "Use dark theme"]
renderUseLightThemeButton = button [onClick (Messages.Theme (Theme.SetTheme Light))] [text "Use light theme"]
renderResetButton = button [onClick (Messages.Score (Score.ResetScore))] [text "Reset"]

view : CasinoModel -> Html Messages.Msg
view model =
  let color = if model.theme == Light then "#CCC" else "#888"
  in
  div [class "background", style [("background-color", color)]] [
    div [id "container"]
      [ 
        div [] 
        [
          renderDebugToggle model
        , renderDebugger model
        , renderHeader
        , renderInstructions model.targetScore
        , renderCurrentScore model.score
        , renderAdd2Button
        , renderAdd4Button
        , renderAdd8Button
        , renderSubtract6Button
        , renderDoubleButton
        , br [] []
        , renderUseDarkThemeButton
        , renderUseLightThemeButton
        , renderResetButton
        ]
      ]
  ]

  --   button, onClick add', num: 2 })}>Add 2
  --   button, onClick add', num: 4 })}>Add 4
  --   button, onClick add', num: 8 })}>Add 8
  --   button [class "subtract-btn", onClick subtract', num: 6 })}>Subtract 6
  --   button [class "double-btn", onClick double' })}>Double
  --   <br />
  --   button [class "theme-btn", onClick setDarkTheme' })}>Use dark theme
  --   button [class "theme-btn", onClick setLightTheme' })}>Use light theme
  --   button [class "reset-btn", onClick reset' })}>reset
  -- </div>