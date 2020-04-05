module Delvident.Server.Handlers where

import Prelude

import Control.Monad.Except.Trans (ExceptT, withExceptT)
import Nodetrout (HTTPError, error500)
import Effect (Effect)
import Effect.Aff (Aff)

import Delvident.Server.Persistence as P
import Delvident.Types (Entry, EntryId)


type AppM a
  = ExceptT HTTPError Aff a

mkHandlers
  :: P.Pool -> Effect
       { entries ::
         { list :: { "GET" :: AppM (Array Entry) }
         , item :: EntryId -> { "GET" :: AppM Entry }
         }
       }
mkHandlers pool = do
  pure
    { entries:
      { list: { "GET": execute P.fetchAllEntries }
      , item: const { "GET": pure e1}
      }
    }
    where
      execute action = withExceptT (const error500) $ P.withConnection pool \conn -> action conn
      e1 = {id: 300, term: "testT", definition: "defT"}
