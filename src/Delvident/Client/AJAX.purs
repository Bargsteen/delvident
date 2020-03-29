module Delvident.Client.AJAX (fetchEntryList, fetchEntry) where

import Effect.Aff (Aff)
import Type.Trout.Client (asClients)

import Delvident.Types (Entry, EntryId)
import Delvident.Server.API as API

type AppM a = Aff a

client
  :: { entries ::
        { list :: { "GET" :: AppM (Array Entry) }
        , item :: EntryId -> { "GET" :: AppM Entry }
       {- , create :: NewEntry -> { "POST" :: Aff Entry }
        , update :: EntryId -> NewEntry -> { "UPDATE" :: Aff Entry }
        , delete :: EntryId -> { "DELETE" :: Aff Unit }-}
        }
     }
client = asClients API.api


fetchEntryList :: AppM (Array Entry)
fetchEntryList = client.entries.list."GET"

fetchEntry :: EntryId -> AppM Entry
fetchEntry id = (client.entries.item id)."GET"
