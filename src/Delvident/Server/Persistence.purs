module Delvident.Server.Persistence (withConnection, Connection, Pool, Error, PersistM, newPool,
                              insertEntry, fetchAllEntries, updateEntry, deleteEntry) where

import Prelude

import Control.Monad.Except.Trans (ExceptT, runExceptT)
import Data.Maybe (Maybe(..))
import Database.PostgreSQL.PG as PG
import Delvident.Types (Entry, NewEntry, EntryId, toPNewEntry, toEntry)
import Effect (Effect)
import Effect.Aff (Aff)

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
insertEntryQuery :: String
insertEntryQuery = "INSERT INTO entries (term, definition) VALUES ($1, $2)"

fetchAllEntriesQuery :: String
fetchAllEntriesQuery = "SELECT id, term, definition FROM entries"

updateEntryQuery :: String
updateEntryQuery = "UPDATE entries SET term = $2, definition = $3 WHERE id = $1"

deleteEntryQuery :: String
deleteEntryQuery = "DELETE FROM entries WHERE id = $1"

{------------------------------------------------------------------------------}
{-                                  Actions                                   -}
{------------------------------------------------------------------------------}
insertEntry :: NewEntry -> PG.Connection -> PersistM Unit
insertEntry newEntry conn = PG.execute conn (PG.Query insertEntryQuery) $ toPNewEntry newEntry

fetchAllEntries :: PG.Connection -> PersistM (Array Entry)
fetchAllEntries conn = map toEntry <$> PG.query conn (PG.Query fetchAllEntriesQuery) PG.Row0

updateEntry :: EntryId -> NewEntry -> PG.Connection -> PersistM Unit
updateEntry id updatedEntry conn = PG.execute conn (PG.Query updateEntryQuery) $ [PG.toSQLValue id] <> (PG.toSQLRow $ toPNewEntry updatedEntry)

deleteEntry :: EntryId -> PG.Connection -> PersistM Unit
deleteEntry entryId conn = PG.execute conn (PG.Query deleteEntryQuery) [PG.toSQLValue entryId]
