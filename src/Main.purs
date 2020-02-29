module Main where

import Prelude
import Concur.React.Run (runWidgetInDom)
import Effect (Effect)
import Glossary as Glossary

main :: Effect Unit
main = runWidgetInDom "root" $ Glossary.samplePageWidget
