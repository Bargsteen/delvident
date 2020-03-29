module Server where

import Prelude
import Control.Monad.Except.Trans (ExceptT, throwError)
import Data.Array (snoc)
import Data.Either (Either(..))
import Data.Foldable (find)
import Data.Maybe (Maybe(..))
import Data.String.CodePoints (take) as String
import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Class (liftEffect)
import Effect.Console (log)
import Effect.Exception (message)
import Node.Encoding (Encoding(UTF8))
import Node.FS.Async (readFile)
import Node.HTTP (Request, Response, createServer, listen, requestURL, responseAsStream, setStatusCode)
import Node.Path (concat) as Path
import Node.Stream (end, write, writeString) as Stream
import Nodetrout (HTTPError, error404, serve')

import Delvident.Types
import Delvident.API

type AppM a
  = ExceptT HTTPError Aff a

mkHandlers
  :: Effect
       { entries ::
         { list :: { "GET" :: AppM (Array Entry) }
         , item :: EntryId -> { "GET" :: AppM Entry }
         }
       }
mkHandlers = do
  pure
    { entries:
      { list: { "GET": pure entries }
      , item: const { "GET": pure e1}
      }
    }
    where
      e1 = {id: 1, term: "t1", definition: "d1"}
      entries = [e1, {id: 2, term: "t2", definition: "d2"}]


serveStatic :: Request -> Response -> Effect Unit
serveStatic req res =
  let
    rs = responseAsStream res
    url = case requestURL req of
            "/" -> "/index.html"
            somethingElse -> somethingElse
  in
    readFile (Path.concat ["public", url]) $
      case _ of
        Left error -> do
          setStatusCode res 500
          _ <- Stream.writeString rs UTF8 (message error) $ pure unit
          Stream.end rs $ pure unit
        Right b -> do
          setStatusCode res 200
          _ <- Stream.write rs b $ pure unit
          Stream.end rs $ pure unit

main :: Effect Unit
main = do
  let port = 3000
  handlers <- mkHandlers
  server <- createServer \req ->
              if String.take 4 (requestURL req) == "/api"
                then serve' api handlers (const $ pure unit) req
                else serveStatic req
  listen server { hostname: "0.0.0.0", port, backlog: Nothing } $ log ("Listening on port " <> show port <> "...")
