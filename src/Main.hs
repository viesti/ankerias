{-# LANGUAGE OverloadedStrings #-}
module Main where

import           Control.Applicative
import           Control.Monad.Trans
import           Snap.Core
import           Snap.Util.FileServe
import           Snap.Http.Server
import           System.Process
import qualified Data.ByteString.Char8 as C

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
                _ -> writeBS "error"

data SwitchState = On | Off

switch :: MonadSnap m => SwitchState -> m ()
switch On = switchAndPrint "--on"
switch Off = switchAndPrint "--off"

switchAndPrint :: MonadSnap m => String -> m ()
switchAndPrint s = do
  out <- liftIO (readProcess "tdtool" [s, "1"] "")
  writeBS (C.pack out)