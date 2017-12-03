module Main exposing (..)
import Html exposing (..)
import Kakoune exposing ( draw, DrawParams, keydown )
import Keyboard
import Char
import View exposing ( view )
import Msg exposing ( Msg(..) )
import Model exposing ( Model, model )
import Debug exposing ( log )

-- component import example
import Components.Hello exposing ( hello )


-- APP
main : Program Never Model Msg
main = Html.program {
    init = ( model, Cmd.none ),
    view = view,
    update = update,
    subscriptions = subscriptions
  }

mapKey : Keyboard.KeyCode -> String
mapKey code =
  let
    c = (log "pressed" code)
  in
    "iWorld<esc>"



update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Draw params -> (
      { model | atoms = params },
      Cmd.none
    )
    KeyPress code -> ( model, keydown ( mapKey code) )

subscriptions : a -> Sub Msg
subscriptions init = Sub.batch [
    draw Draw,
    Keyboard.downs KeyPress
  ]
