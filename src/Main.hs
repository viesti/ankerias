{-# LANGUAGE OverloadedStrings #-}
module Main where

import           Control.Applicative
import           Control.Monad.Trans
import           Snap.Core
import           Snap.Util.FileServe
import           Snap.Http.Server
import           Telldus
import           Data.Bits((.|.))

data SwitchState = On | Off

main :: IO ()
main = 
  tdInit >>
  quickHttpServe site >>
  putStrLn "Cleaning up telldus-core" >>
  tdClose

site :: Snap ()
site =
  ifTop (serveFile "html/index.html") <|>
  route [ ("switch/:state", switchHandler),
          ("js", serveDirectory "js"),
          ("themes", serveDirectory "themes")] <|>
  redirect' "/" 302

switchHandler :: Snap ()
switchHandler = do
  state <- getParam "state"
  case state of Just "on" -> switch On
                Just "off" -> switch Off
                Just "state" -> getState
                _ -> writeBS "error"

switch :: MonadSnap m => SwitchState -> m ()
switch state = do
  retVal <- liftIO $ case state of On -> tdTurnOn 1
                                   Off -> tdTurnOff 1
  case retVal of 0 -> writeBS "OK"
                 _ -> writeBS "FAIL"

getState :: MonadSnap m => m ()
getState = do
  retVal <- liftIO $ tdLastSentCommand 1 (tellstick_turnon .|. tellstick_turnoff)
  let result = case retVal of 1 -> "ON"
                              2 -> "OFF"
                              _ -> "UNKNOWN"
  writeBS result
