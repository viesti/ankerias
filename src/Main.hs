{-# LANGUAGE OverloadedStrings #-}
module Main where

import           Control.Applicative
import           Control.Monad.Trans
import           Snap.Core
import           Snap.Util.FileServe
import           Snap.Http.Server
import           System.Process
import qualified Data.ByteString.Char8 as C
import           Text.Regex.TDFA

main :: IO ()
main = quickHttpServe site

site :: Snap ()
site =
  ifTop (serveFile "html/index.html") <|>
  route [ ("switch/:state", switchHandler) ] <|>
  redirect' "/" 302

switchHandler :: Snap ()
switchHandler = do
  state <- getParam "state"
  case state of Just "on" -> switch On
                Just "off" -> switch Off
                Just "state" -> getState
                _ -> writeBS "error"

data SwitchState = On | Off

switch :: MonadSnap m => SwitchState -> m ()
switch On = switchAndWrite "--on"
switch Off = switchAndWrite "--off"

switchAndWrite :: MonadSnap m => String -> m ()
switchAndWrite s = do
  (_, out, _) <- liftIO (readProcessWithExitCode "tdtool" [s, "1"] "")
  writeBS (C.pack out)

getState :: MonadSnap m => m ()
getState = do
  (_, out, _) <- liftIO (readProcessWithExitCode "tdtool" ["--list"] "")
  let pat = "1[ ]*bataatti[ ]*(.*)" :: String
  case out =~ pat :: [[String]] of [[_,"OFF"]] -> writeBS "off"
                                   [[_,"ON"]]  -> writeBS "on"
                                   _           -> writeBS "error"
