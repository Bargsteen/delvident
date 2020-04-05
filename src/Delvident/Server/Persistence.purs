module Delvident.Server.Persistence (withConnection, Connection, Pool, Error, PersistM, newPool,
                              createEntry, fetchAllEntries, updateEntry, deleteEntry) where

import Prelude

import Control.Monad.Except.Trans (ExceptT, runExceptT)
import Data.Maybe (Maybe(..))
import Database.PostgreSQL.PG as PG
import Effect (Effect)
import Effect.Aff (Aff)

import Delvident.Types (EntryId, NewEntry, Entry, toEntry, toPNewEntry)

type Connection
  = PG.Connection

type Pool
  = PG.Pool

type Error
  = PG.PGError

type PersistM a
  = ExceptT Error Aff a

withConnection :: forall a. Pool -> (Connection -> PersistM a) -> PersistM a
withConnection = PG.withConnection runExceptT

newPool :: String -> String -> Effect Pool
newPool dbName username = PG.newPool $ ((PG.defaultPoolConfiguration dbName) { user = Just username })


{------------------------------------------------------------------------------}
{-                                  Queries                                   -}
{------------------------------------------------------------------------------}
createEntryQuery :: String
createEntryQuery = "INSERT INTO entries (term, definition) VALUES ($1, $2)"

fetchEntryQuery :: String
fetchEntryQuery = "SELECT id, term, definition FROM entries where id = $1"

fetchAllEntriesQuery :: String
fetchAllEntriesQuery = "SELECT id, term, definition FROM entries"

updateEntryQuery :: String
updateEntryQuery = "UPDATE entries SET term = $2, definition = $3 WHERE id = $1"

deleteEntryQuery :: String
deleteEntryQuery = "DELETE FROM entries WHERE id = $1"

{------------------------------------------------------------------------------}
{-                                  Actions                                   -}
{------------------------------------------------------------------------------}
createEntry :: NewEntry -> PG.Connection -> PersistM Unit
createEntry newEntry conn = PG.execute conn (PG.Query createEntryQuery) $ toPNewEntry newEntry

fetchAllEntries :: PG.Connection -> PersistM (Array Entry)
fetchAllEntries conn = map toEntry <$> PG.query conn (PG.Query fetchAllEntriesQuery) PG.Row0

updateEntry :: EntryId -> NewEntry -> PG.Connection -> PersistM Unit
updateEntry id updatedEntry conn = PG.execute conn (PG.Query updateEntryQuery) $ [PG.toSQLValue id] <> (PG.toSQLRow $ toPNewEntry updatedEntry)

deleteEntry :: EntryId -> PG.Connection -> PersistM Unit
deleteEntry entryId conn = PG.execute conn (PG.Query deleteEntryQuery) [PG.toSQLValue entryId]
