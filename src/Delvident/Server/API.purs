module Delvident.Server.API where

import Prelude (Unit)

import Type.Proxy (Proxy(..))
import Type.Trout (type (:/), type (:<|>), type (:=), type (:>), ReqBody, Capture)
import Type.Trout.ContentType.JSON (JSON)
import Type.Trout.Method (Get, Post, Put, Delete)
import Delvident.Types

type API
  = "entries" := "api" :/ "entries" :/ (
             "list"   := Get (Array Entry) JSON
        :<|> "create" := ReqBody NewEntry JSON :> Post Unit JSON
        :<|> "update" := Capture "id" EntryId :> ReqBody NewEntry JSON :> Put Unit JSON
        :<|> "delete" := Capture "id" EntryId :> Delete Unit JSON
     )

api :: Proxy API
api = Proxy
