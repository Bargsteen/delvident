module Delvident.Client.AJAX (fetchEntryList, createEntry, updateEntry, deleteEntry) where

import Prelude

import Effect.Aff (Aff)
import Type.Trout.Client (asClients)

import Delvident.Types (Entry, EntryId, NewEntry)
import Delvident.Server.API as API

type AppM a = Aff a

client
  :: { entries ::
        { list :: { "GET" :: AppM (Array Entry) }
        , create :: NewEntry -> { "POST" :: AppM Unit }
        , update :: EntryId -> NewEntry -> { "PUT" :: AppM Unit }
        , delete :: EntryId -> { "DELETE" :: AppM Unit }
        }
     }
client = asClients API.api


fetchEntryList :: AppM (Array Entry)
fetchEntryList = client.entries.list."GET"

createEntry :: NewEntry -> AppM Unit
createEntry newEntry = (client.entries.create newEntry)."POST"

updateEntry :: EntryId -> NewEntry -> AppM Unit
updateEntry id newEntry = (client.entries.update id newEntry)."PUT"

deleteEntry :: EntryId -> AppM Unit
deleteEntry id = (client.entries.delete id)."DELETE"
