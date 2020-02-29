module Main where

import Prelude
import Concur.React.DOM as D
import Concur.React.Run (runWidgetInDom)
import Effect (Effect)



main :: Effect Unit
main = runWidgetInDom "root" $ D.text "Hello delvident"

