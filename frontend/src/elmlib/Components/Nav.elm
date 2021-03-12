module Components.Nav exposing (viewNav, pageToTitle)

import Html exposing (Html, nav, a, b, text)
import Html.Attributes exposing (href)

import Types exposing (Page(..))

pages : List Page
pages = [ Home, About ]

pageToTitle : Page -> String
pageToTitle page = case page of
  Home -> "Home"
  About -> "About"
  UnknownPage name -> name

pageToPath : Page -> Maybe String
pageToPath page = case page of
  Home -> Just "/"
  About -> Just "/about"
  UnknownPage _ -> Nothing

navLink : Page -> Page -> Html msg
navLink current page =
  if current == page
    then b [] [ text (pageToTitle page) ]
  else a [ href <| Maybe.withDefault "" <| pageToPath page ] [ text (pageToTitle page) ]

viewNav : Page -> Html msg
viewNav page =
  nav [] (List.map (navLink page) pages)
