module Types exposing (User(..), Page(..))

type User =
  Guest
  | LoggedIn String String

type Page = Home | About | UnknownPage String
