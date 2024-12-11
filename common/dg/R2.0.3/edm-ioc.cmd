#!/bin/bash
# EPICS startup script for edm (shell application)
#
# Setup edm environment
source /reg/g/pcds/setup/epicsenv-3.15.5-2.0.sh

cd $$IOCTOP
# Launch edm screen
edm -x -m "DG=$$NAME,IOC=$$IOCPVROOT" -eolc delaygenscreens/srsDG645.edl &
