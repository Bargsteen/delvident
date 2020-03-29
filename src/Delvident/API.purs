module Delvident.API where

import Type.Proxy (Proxy(..))
import Type.Trout (type (:/), type (:<|>), type (:=), type (:>), Capture, Resource)
import Type.Trout.ContentType.JSON (JSON)
import Type.Trout.Method (Get, Post, Put, Delete)
import Delvident.Types

type API
  = "entries" := "api" :/ "entries" :/ (
             "list"   := Get (Array Entry) JSON
        :<|> "item"   := Capture "id" EntryId :> Get Entry JSON
        {-:<|> "create" := ReqBody NewEntry JSON :> Post Entry JSON
        :<|> "update" := Capture "id" EntryId :> ReqBody NewEntry JSON :> Put Entry JSON
        :<|> "delete" := Capture "id" EntryId :> Delete Unit JSON -}
     )

api :: Proxy API
api = Proxy
