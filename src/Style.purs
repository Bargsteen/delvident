module Style where

import Concur.React.Props as P

-- Entry
entry :: forall a. P.ReactProps a
entry = toClasses ""

entryTerm :: forall a. P.ReactProps a
entryTerm = toClasses ""

entryDefinition :: forall a. P.ReactProps a
entryDefinition = toClasses ""

-- EntryList
entryList :: forall a. P.ReactProps a
entryList = toClasses ""

-- New Entry
newEntry :: forall a. P.ReactProps a
newEntry = toClasses ""

newEntryTerm :: forall a. P.ReactProps a
newEntryTerm = toClasses ""

newEntryDefinition :: forall a. P.ReactProps a
newEntryDefinition = toClasses ""

newEntrySubmit :: forall a. P.ReactProps a
newEntrySubmit = toClasses ""

-- Glossary
glossary :: forall a. P.ReactProps a
glossary = toClasses ""

-- Page
page :: forall a. P.ReactProps a
page = toClasses ""

-- Util
toClasses :: forall a. String -> P.ReactProps a
toClasses = P.className
