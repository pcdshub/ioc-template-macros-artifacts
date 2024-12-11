#!/bin/bash
# EPICS startup script for edm (shell application)
#
# Setup edm environment
source /reg/g/pcds/setup/epicsenv-3.15.5-2.0.sh

cd /reg/g/pcds/epics/ioc/common/dg/R2.0.3
# Launch edm screen
edm -x -m "DG=XPP:LBL:DDG:01,IOC=XPP:IOC:LBL:DDG:01" -eolc delaygenscreens/srsDG645.edl &
