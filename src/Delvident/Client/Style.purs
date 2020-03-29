module Delvident.Client.Styles where

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
newEntry = toClasses "flex flex-column"

textEntryStyle :: forall a. P.ReactProps a
textEntryStyle = toClasses "input-reset pa2 ba br1 mv2"

newEntryTerm :: forall a. P.ReactProps a
newEntryTerm = textEntryStyle

newEntryDefinition :: forall a. P.ReactProps a
newEntryDefinition = textEntryStyle

newEntrySubmit :: forall a. P.ReactProps a
newEntrySubmit = toClasses "pv2 ph3 br2 bg-dark-blue white hover-bg-navy hover-near-white center"

-- Glossary
glossary :: forall a. P.ReactProps a
glossary = toClasses ""

-- Page
title :: forall a. P.ReactProps a
title = toClasses "pl3 f-title f-subheadline-l lh-title bl bw3 bw4-l"

page :: forall a. P.ReactProps a
page = toClasses "center ph4-ns ph3 mw8 mv3 avenir"

-- Util
toClasses :: forall a. String -> P.ReactProps a
toClasses = P.className
