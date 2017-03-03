module Messages exposing (..)
import Updates.Score as Score
import Updates.Theme as Theme

type Msg
  = Score Score.Msg
  | Theme Theme.Msg
