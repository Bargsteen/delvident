{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ sources = [ "src/**/*.purs", "test/**/*.purs" ]
, name = "delvident"
, dependencies = [ "effect", "console", "concur-core", "concur-react" ]
, packages = ./packages.dhall
}
