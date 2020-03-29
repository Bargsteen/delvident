module Client where

import Prelude

import Effect (Effect)
import Effect.Aff (Aff, launchAff)
import Effect.Class (liftEffect)
import Effect.Class.Console (log)
import Type.Trout.Client (asClients)

import Delvident.API
import Delvident.Types

main :: Effect Unit
main = do
  log "Running client!"
  void
    $ launchAff do
        entries <- clients.entries.list."GET"
        liftEffect <<< log <<< show $ entries


clients
  :: { entries ::
        { list :: { "GET" :: Aff (Array Entry) }
        , item :: EntryId -> { "GET" :: Aff Entry }
       {- , create :: NewEntry -> { "POST" :: Aff Entry }
        , update :: EntryId -> NewEntry -> { "UPDATE" :: Aff Entry }
        , delete :: EntryId -> { "DELETE" :: Aff Unit }-}
        }
     }
clients = asClients api
