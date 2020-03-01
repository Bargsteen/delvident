module Main where

import Prelude
import Concur.React.Run (runWidgetInDom)
import Effect (Effect)
import Effect.Aff (launchAff_)
import Glossary as Glossary
import Persistence as Persistence
import Effect.Class (liftEffect)

main :: Effect Unit
main =
  launchAff_ do
    liftEffect $ Persistence.init "TODO: Read from config.json"
    fetchedEntriesWithIds <- Persistence.fetchAllEntriesWithIds "glossary"
    let
      fetchedEntries = map (\ewi -> ewi.entry) fetchedEntriesWithIds
    liftEffect $ runWidgetInDom "root" $ Glossary.defaultPageWidget fetchedEntries
