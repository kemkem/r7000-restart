# Netgear R7000 remote restart

There is no options in the "genie" GUI to program router restart, unlike TP-Link.

This script goal is to force the router to restart using the GUI foms.

Then you may set a cron task to remotely restart your routeur from another computer (A PI for example).

## Principles

This scripts uses 4 steps to complete the restart :

* Retrieve the XSRF token from GUI root page
* Get the root page. This is a requirement to "connect" to the router
* Retrieve a dynamic id from the "advanced options" page
* Post a form with the correct option (buttonSelect=2) to request the routeur reboot

All those steps require basic auth with base 64 encoding.

## Config

Edit the script and update the following values :

* AUTH : Set your routeur admin:password credentials, using base 64 encoding (use https://wtools.io/base64-encode-decode-online if necessary)
* R7000_IP : Set your routeur IP, usually 192.168.1.1 or 192.168.0.1
* LOG : Set a log path

The LOG is quite basic and outputs entire pages for debug purposes.

It could be easily removed or modified to suit your needs.
