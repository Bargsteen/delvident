module Glossary where

import Prelude
import Concur.Core (Widget)
import Concur.React (HTML)
import Concur.React.DOM as D
import Concur.React.Props as P
import Data.Array (cons, sortWith)
import Style as S

type Entry
  = { term :: String, definition :: String }

entryWidget :: forall a. Entry -> Widget HTML a
entryWidget entry =
  D.div [ S.entry ]
    [ D.h3 [ S.entryTerm ] [ D.text entry.term ]
    , D.p
        [ S.entryDefinition ]
        [ D.text entry.definition ]
    ]

data NewEntryAction
  = Term String
  | Definition String
  | Submit

newEntryWidget :: Entry -> Widget HTML Entry
newEntryWidget entry = do
  res <-
    D.div [ S.newEntry ]
      [ D.h2' [ D.text "Add New Definition" ]
      , Term <$> D.input [ P._type "text", P.value entry.term, S.newEntryTerm, P.placeholder "Term", P.unsafeTargetValue <$> P.onChange ]
      , Definition <$> D.input [ P._type "text", P.value entry.definition, S.newEntryDefinition, P.placeholder "Definition", P.unsafeTargetValue <$> P.onChange ]
      , Submit <$ D.button [ P.onClick, S.newEntrySubmit ] [ D.text "Submit" ]
      ]
  case res of
    Term t -> newEntryWidget (entry { term = t })
    Definition d -> newEntryWidget (entry { definition = d })
    Submit -> pure entry

entryListWidget :: forall a. Array Entry -> Widget HTML a
entryListWidget entries = D.div [ S.entryList ] $ map entryWidget entries

glossaryWidget :: forall a. Array Entry -> Widget HTML a
glossaryWidget entries = do
  newEntry <-
    D.div [ S.glossary ]
      [ entryListWidget sortedEntries
      , newEntryWidget mempty
      ]
  glossaryWidget $ newEntry `cons` sortedEntries
  where
  sortedEntries = sortWith (_.term) entries

titleWidget :: forall a. String -> Widget HTML a
titleWidget title = D.h1 [ S.title ] [ D.text title ]

pageWidget :: forall a. Array (Widget HTML a) -> Widget HTML a
pageWidget children = D.div [ S.page ] children

-- Sample
samplePageWidget :: forall a. Widget HTML a
samplePageWidget =
  pageWidget
    [ titleWidget "delvident"
    , glossaryWidget sampleEntryList
    ]

sampleEntryList :: Array Entry
sampleEntryList =
  [ { term: "Kasper", definition: "The Creator" }
  , { term: "PureScript", definition: "An awesome language that borrows a lot from Haskell, but compiles directly to readable Javascript. Very cool indeed." }
  , { term: "Concur", definition: "The future of UI development frameworks. So easy to get started with!" }
  , { term: "Lorem Ipsum", definition: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum." }
  ]
