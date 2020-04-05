module Delvident.Server.Handlers where

import Prelude

import Control.Monad.Except.Trans (ExceptT, withExceptT)
import Nodetrout (HTTPError, error500)
import Effect (Effect)
import Effect.Aff (Aff)

import Delvident.Server.Persistence as P
import Delvident.Types (Entry, EntryId, NewEntry)


type AppM a
  = ExceptT HTTPError Aff a

mkHandlers
  :: P.Pool -> Effect
       { entries ::
         { list :: { "GET" :: AppM (Array Entry) }
         , create :: NewEntry -> { "POST" :: AppM Unit }
         , update :: EntryId -> NewEntry -> { "PUT" :: AppM Unit }
         , delete :: EntryId -> { "DELETE" :: AppM Unit }
         }
       }
mkHandlers pool = do
  pure
    { entries:
      { list: { "GET": execute P.fetchAllEntries }
      , create: \newEntry -> { "POST": execute (P.createEntry newEntry)}
      , update: \id -> (\newEntry -> { "PUT": execute (P.updateEntry id newEntry)})
      , delete: \id -> { "DELETE": execute (P.deleteEntry id) }
      }
    }
    where
      execute :: forall a. (P.Connection -> P.PersistM a) -> AppM a
      execute action = withExceptT (const error500) $ P.withConnection pool \conn -> action conn
