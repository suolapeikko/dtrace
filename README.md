# Sample Dtrace scripts for macOS

Due to System Integrity Protection (SIP) in macOS, you must enable DTrace by booting into recovery mode (cmd+r), starting terminal, and either disabling SIP altogether by running `csrutil disable` or alternatively using experimental option `csrutil enable --without dtrace` (after you have first disabled SIP).

# Scripts

## pidlogger
Snoop what is written in specific bash process */
You can use `echo $$` for shell pid to find your bash window pid
Script usage: `sudo ./pidlogger.d -p <pid>`
  
## tcpnoop
Monitor TCP SEND and RECEIVE commands
Script usage: `sudo ./tcpsnoop.d`

## tracetrivial
Simple example of tracing c-code (trivial.c)
Usage: `sudo dtrace -s ./tracetrivial.d -p <pid>`

## openings
Trace file open calls per process exec
Script usage: `sudo ./openings.d`
