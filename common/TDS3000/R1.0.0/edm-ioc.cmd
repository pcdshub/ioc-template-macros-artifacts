#!/bin/bash
# EPICS startup script for edm (shell application)
#
# Setup edm environment
source /reg/g/pcds/setup/epicsenv-3.15.5-2.0.sh

cd $$IOCTOP
# Launch edm screen
$$LOOP(SCOPE)
edm -x -m "scope=$$NAME:,IOC=$$IOC_PV" -eolc TDS3000Screens/tds3000_c.edl &
$$ENDLOOP(SCOPE)

