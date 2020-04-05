module Delvident.Types where

import Prelude

import Data.Array as Array
import Data.Either (Either(..))
import Database.PostgreSQL (class FromSQLRow, class ToSQLRow, fromSQLValue, toSQLValue)
import Data.Newtype as NT

type EntryId
  = Int

type Entry
  = { id :: EntryId, term :: String, definition :: String }

type NewEntry
  = { term :: String, definition :: String }


{------------------------------------------------------------------------------}
{-                                  SQL                                       -}
{------------------------------------------------------------------------------}

-- The newtypes are required for the typeclasses to be implemented
newtype PEntry = PEntry Entry
newtype PNewEntry = PNewEntry NewEntry


derive instance newtypePEntry :: NT.Newtype PEntry _
derive instance newtypePNewEntry :: NT.Newtype PNewEntry _


instance pEntryToSQLRow :: ToSQLRow PEntry where
  toSQLRow (PEntry {id, term, definition}) = map toSQLValue [show id, term, definition]


instance pNewEntryToSQLRow :: ToSQLRow PNewEntry where
  toSQLRow (PNewEntry {term, definition}) = map toSQLValue [term, definition]


instance pEntryFromSQLRow :: FromSQLRow PEntry where
  fromSQLRow [id, term, definition] = PEntry <$> ({id: _, term: _, definition: _}
                                                 <$> fromSQLValue id <*> fromSQLValue term <*> fromSQLValue definition)
  fromSQLRow xs = Left $ "Row has " <> show n <> " fields, expecting 3."
    where n = Array.length xs


toPNewEntry :: NewEntry -> PNewEntry
toPNewEntry = NT.wrap

toPEntry :: Entry -> PEntry
toPEntry = NT.wrap

toEntry :: PEntry -> Entry
toEntry = NT.unwrap
