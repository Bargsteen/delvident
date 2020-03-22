module Main where

import Prelude
import Concur.React.Run (runWidgetInDom)
import Effect (Effect)
import Effect.Aff (launchAff_)
import Effect.Class (liftEffect)
import Delvident.App (defaultPageWidget)

main :: Effect Unit
main =
  launchAff_ do
    liftEffect $ runWidgetInDom "root" $ defaultPageWidget []
