module Client where

import Prelude hiding (div)
import Data.Foldable (foldMap)
import Effect (Effect)
import Effect.Aff (Aff, launchAff, attempt)
import Effect.Class (liftEffect)
import JQuery (body, setHtml)
import API
import Text.Smolder.Renderer.String (render)
import Type.Trout.Client (asClients)
import Type.Trout.ContentType.HTML (encodeHTML)
import Effect.Class.Console (log)

main :: Effect Unit
main = do
  log "Running client!"
  b <- body
  void
    $ launchAff do
        ts <- clients.tasks."GET"
        singleTask <- (clients.task 1)."GET"
        liftEffect $ log $ "I got this single task: " <> show singleTask
        liftEffect <<< log <<< show $ ts
        liftEffect (setHtml (foldMap (render <<< encodeHTML) ts) b)


clients
  :: {
       tasks :: { "GET" :: Aff (Array Task) }
     , task :: TaskId -> { "GET" :: Aff Task }
     }
clients = asClients api
