module Delvident.AJAX where
 {-
import Prelude
import Affjax as AX
import Affjax.ResponseFormat as ResponseFormat
import Data.Either (Either(..))
import Data.HTTP.Method (Method(..))
import Effect.Class.Console (log)
import Effect.Aff (Aff)

serverUrl :: String
serverUrl = "http://localhost:8080"

fetchAllEntries :: Aff Unit
fetchAllEntries = do
  result <- AX.request (AX.defaultRequest { url = serverUrl <> "/entries", method = Left GET, responseFormat = ResponseFormat.json })
  case result of
    Left err -> log $ "GET /entries response failed to decode: " <> AX.printError err
    Right json -> log $ "GET /entries reponse: " <> "Entries received!"
-}