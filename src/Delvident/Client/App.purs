module Delvident.Client.App where

import Prelude

import Concur.Core (Widget)
import Concur.React (HTML)
import Concur.React.DOM as D
import Concur.React.Props as P
import Concur.React.Run (runWidgetInDom)
import Data.Array (sortWith)
import Effect (Effect)
import Effect.Aff.Class (liftAff)

import Delvident.Client.Styles as S
import Delvident.Client.AJAX as AX
import Delvident.Types (NewEntry, Entry)

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

newEntryWidget :: NewEntry -> Widget HTML Unit
newEntryWidget entry = do
  res <-
    D.div [ S.newEntry ]
      [ D.h2' [ D.text $ "Add New Definition" ]
      , Term <$> D.input [ P._type "text", P.value entry.term, S.newEntryTerm, P.placeholder "Term", P.unsafeTargetValue <$> P.onChange ]
      , Definition <$> D.input [ P._type "text", P.value entry.definition, S.newEntryDefinition, P.placeholder "Definition", P.unsafeTargetValue <$> P.onChange ]
      , Submit <$ D.button [ P.onClick, S.newEntrySubmit ] [ D.text "Submit" ]
      ]
  case res of
    Term t -> newEntryWidget (entry { term = t })
    Definition d -> newEntryWidget (entry { definition = d })
    Submit -> do
      liftAff $ AX.createEntry entry

entryListWidget :: forall a. Array Entry -> Widget HTML a
entryListWidget entries = D.div [ S.entryList ] $ map entryWidget entries

glossaryWidget :: forall a. Array Entry -> Widget HTML a
glossaryWidget entries = do
  D.div [ S.glossary ]
      [ entryListWidget sortedEntries
      , newEntryWidget mempty
      ]
  updatedEntries <- liftAff $ AX.fetchEntryList
  glossaryWidget $ updatedEntries
  where
  sortedEntries = sortWith (_.term) entries

titleWidget :: forall a. String -> Widget HTML a
titleWidget title = D.h1 [ S.title ] [ D.text title ]

pageWidget :: forall a. Array (Widget HTML a) -> Widget HTML a
pageWidget children = D.div [ S.page ] children

defaultPageWidget :: forall a. Array Entry -> Widget HTML a
defaultPageWidget entries = do
  pageWidget
    [ titleWidget "delvident"
    , glossaryWidget entries
    ]

run :: Array Entry -> Effect Unit
run entries = runWidgetInDom "app" (defaultPageWidget entries)
