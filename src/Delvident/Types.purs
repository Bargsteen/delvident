module Delvident.Types where

type EntryId
  = Int

type Entry
  = { id :: EntryId | NewEntry }

type NewEntry
  = { term :: String, definition :: String }
