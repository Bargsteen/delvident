module Persistence (init, createEntry, fetchAllEntriesWithIds) where

import Prelude
import Effect (Effect)
import Effect.Aff (Aff)
import Control.Promise (Promise, toAffE)
import GlossaryData (Entry, EntryWithId)

foreign import init :: String -> Effect Unit

foreign import createEntry :: String -> Entry -> Effect Unit

foreign import _fetchAllEntriesWithIds :: String -> Effect (Promise (Array EntryWithId))

fetchAllEntriesWithIds :: String -> Aff (Array EntryWithId)
fetchAllEntriesWithIds collectionName = toAffE $ _fetchAllEntriesWithIds collectionName
