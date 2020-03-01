module GlossaryData where

type Entry
  = { term :: String, definition :: String }

type EntryWithId
  = { id :: String, entry :: Entry }
