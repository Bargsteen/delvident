{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ sources = [ "src/**/*.purs", "test/**/*.purs" ]
, name = "delvident"
, dependencies =
  [ "aff"
  , "aff-promise"
  , "concur-core"
  , "concur-react"
  , "console"
  , "effect"
  , "foreign"
  ]
, packages = ./packages.dhall
}
