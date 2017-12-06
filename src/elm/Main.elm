module Main exposing (..)
import Html exposing (..)
import Kakoune exposing ( drawBuffer, drawStatus, DrawParams, keydown )
import Keyboard
import View exposing ( view )
import Msg exposing ( Msg(..) )
import Model exposing ( Model, model )
import Keys exposing ( mapKey )
import Debug exposing ( log )


-- APP
main : Program Never Model Msg
main = Html.program {
    init = ( model, Cmd.none ),
    view = view,
    update = update,
    subscriptions = subscriptions
  }

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    DrawStatus params -> (
      { model | status = params },
      Cmd.none
    )
    DrawBuffer params -> (
      { model | buffer = params },
      Cmd.none
    )
    KeyPress code -> ( model, keydown <| log (toString code) ( mapKey code ) )

subscriptions : a -> Sub Msg
subscriptions init = Sub.batch [
    drawBuffer DrawBuffer,
    drawStatus DrawStatus,
    Keyboard.downs KeyPress
  ]
