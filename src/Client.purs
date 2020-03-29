module Client where

import Prelude

import Effect (Effect)
import Effect.Aff (launchAff)
import Effect.Class (liftEffect)

import Delvident.Client.AJAX as AX
import Delvident.Client.App as App

main :: Effect Unit
main = void <<< launchAff $ do
      entries <- AX.fetchEntryList
      liftEffect $ App.run entries
