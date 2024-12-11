#!/bin/bash
# EPICS startup script for edm (shell application)
#
# Setup edm environment
source /reg/g/pcds/setup/epicsenv-3.15.5-2.0.sh

cd /reg/g/pcds/package/epics/3.14/ioc/common/TDS3000/R1.0.0
# Launch edm screen
edm -x -m "scope=MFX:LAS:OSC:01:,IOC=MFX:IOC:TDS3000:01" -eolc TDS3000Screens/tds3000_c.edl &

