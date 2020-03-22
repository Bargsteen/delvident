{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ sources = [ "src/**/*.purs", "test/**/*.purs" ]
, name = "delvident"
, dependencies =
  [ "aff"
  , "aff-promise"
  , "affjax"
  , "argonaut"
  , "argonaut-generic"
  , "concur-core"
  , "concur-react"
  , "console"
  , "effect"
  , "foreign"
  , "foreign-generic"
  ]
, packages = ./packages.dhall
}
