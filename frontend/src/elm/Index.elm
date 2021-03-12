module Index exposing (..)

import Browser exposing (application, UrlRequest(..), Document)
import Browser.Navigation exposing (Key, pushUrl)
import Url exposing (Url)

import Html exposing (main_, text, h1)

import String exposing (startsWith)

import Components.Nav exposing (viewNav, pageToTitle)
import Types exposing (User(..), Page(..))

urlToPage : Url -> Page
urlToPage url =
  let urlChecker = startsWith ( url.path )
  in if urlChecker "/"
    then Home
    else if urlChecker "/about"
      then About
      else UnknownPage (Url.toString url)

type alias AppState =
  { url: Url, navKey: Key, user: User }

appInit : () -> Url -> Key -> (AppState, Cmd Msg)
appInit _ url key =
  (AppState url key Guest, pushUrl key "/")

appSubscriptions : AppState -> Sub msg
appSubscriptions _ = Sub.none

main : Program () AppState Msg
main = application
  { init = appInit
  , update = appUpdate
  , view = appView
  , subscriptions = appSubscriptions
  , onUrlRequest = ClickedLink
  , onUrlChange = UrlChanged
  }

type Msg =
  NoUpdate
  | ClickedLink UrlRequest
  | UrlChanged Url

appUpdate : Msg -> AppState -> (AppState, Cmd Msg)
appUpdate msg model = case msg of
  NoUpdate -> (model, Cmd.none)
  ClickedLink urlRequest -> case urlRequest of
    Internal url -> (model, pushUrl model.navKey (Url.toString url))
    External href -> (model, Browser.Navigation.load href)
  UrlChanged url -> ({ model | url = url }, Cmd.none)


appView : AppState -> Document Msg
appView model =
  let
    page = urlToPage model.url
    body = [ h1 [] [ pageToTitle page |> text ] ]
  in Document (pageToTitle page) [ viewNav page, main_ [] body ]
