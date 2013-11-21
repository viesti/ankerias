# Ankerias #

A web server for controlling an electric socket.

## Background ##

I bought one of Nexa's wirelessly controlled wall sockets
(http://www.nexa.se/LGDR-3500-Extra-.htm) and a Telldus Tellstick Duo
(http://www.telldus.se/products/tellstick_duo) and decided to make the
wall socket controllable via a web interface. Used Haskell Snap
framework (http://snapframework.com/) for the web server part. Telldus
offers a C library (telldus-core,
http://developer.telldus.se/doxygen/) for communicating with the
Tellstick. Somewhat surprisingly Haskell has a neat FFI that made
using telldus-core quite easy actually.
