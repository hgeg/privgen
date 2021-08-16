module Main where

import Server
import Data.Proxy
import Network.Wai
import Network.Wai.Handler.Warp
--import Network.Wai.Handler.WarpTLS
import Servant

api :: Proxy API
api = Proxy

main :: IO ()
main = do
    putStrLn "running server"
    run 8080 $ serve api server
