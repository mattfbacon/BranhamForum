module Index exposing (..)

import Browser

import Css exposing (..)

import Html.Styled exposing (main_, button, text, toUnstyled, Html, Attribute, styled)
import Html.Styled.Events exposing (onClick)
import Html.Styled.Attributes exposing (css)

colors : { primary: Color, primaryHover: Color, secondary: Color }
colors =
  { primary = (hex "9b4dca") -- Milligram purple
  , primaryHover = (hex "606c76") -- Milligram grey
  , secondary = (hex "9dd392") -- light faded green
  }

type alias StyledHtml msg = List (Attribute msg) -> List (Html msg) -> Html msg

main : Program () Int Msg
main = Browser.sandbox { init = 0, update = update, view = view >> toUnstyled }

type Msg = Increment | Half

update : Msg -> Int -> Int
update msg model =
  case msg of
    Increment ->
      model + 1
    Half ->
      model // 2

view : Int -> Html Msg
view model =
  main_ [] [
    button [
      onClick Half
    ] [ text "÷" ]
  , text (String.fromInt model)
  , button [
      onClick Increment
    ] [ text "+" ]
  ]
