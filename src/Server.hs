{-# LANGUAGE OverloadedStrings, DataKinds, TypeOperators #-}
module Server where
    
import           Control.Monad.IO.Class as IO

import           Servant
import           Servant.HTML.Blaze
import           PolicyMaker

type API = "privacy" :> Capture "name" String :> Get '[HTML] Page
      :<|> "static"  :> Raw
      

server :: Server API
server = pageHandler
    :<|> serveDirectoryWebApp "static"

pageHandler :: String -> Handler Page
pageHandler name = do 
    result <- IO.liftIO $ findGame name 
    case result of
        Nothing -> return . generate404 $ name
        Just game -> return . generatePolicy $ game