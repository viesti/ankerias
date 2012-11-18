{-# LANGUAGE ForeignFunctionInterface #-}
module Main where

import Foreign.C -- get the C types
import Foreign.Ptr (Ptr,nullPtr)

foreign import ccall "tdInit" c_tdInit :: Ptr a -> IO ()
tdInit :: IO ()
tdInit = c_tdInit nullPtr

foreign import ccall "tdClose" c_tdClose :: Ptr a -> IO ()
tdClose = c_tdClose nullPtr

foreign import ccall "tdGetNumberOfDevices" c_tdGetNumberOfDevices :: Ptr a -> IO CInt
tdGetNumberOfDevices = c_tdGetNumberOfDevices nullPtr

foreign import ccall "tdGetDeviceId" c_tdGetDeviceId :: CInt -> CInt
tdGetDeviceId = c_tdGetDeviceId

foreign import ccall "tdReleaseString" c_tdReleaseString :: CString -> IO ()
tdReleaseString = c_tdReleaseString

foreign import ccall "tdGetName" c_tdGetName :: CInt -> CString
tdGetName = c_tdGetName

foreign import ccall "tdMethods" c_tdMethods :: CInt -> CInt -> CInt
tdMethods = c_tdMethods

foreign import ccall "tdTurnOn" c_tdTurnOn :: CInt -> CInt
tdTurnOn = c_tdTurnOn

foreign import ccall "tdTurnOff" c_tdTurnOff :: CInt -> CInt
tdTurnOff = c_tdTurnOff

foreign import ccall "tdLastSentCommand" c_tdLastSentCommand :: CInt -> CInt -> CInt
tdLastSentCommand = c_tdLastSentCommand