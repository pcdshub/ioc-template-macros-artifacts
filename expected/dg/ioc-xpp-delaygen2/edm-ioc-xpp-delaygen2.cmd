#!/bin/bash
# EPICS startup script for edm (shell application)
#
# Setup edm environment
source /reg/g/pcds/setup/epicsenv-3.15.5-2.0.sh

cd /reg/g/pcds/package/epics/3.14/ioc/common/dg/R2.0.3
# Launch edm screen
edm -x -m "DG=XPP:DDG:02,IOC=XPP:IOC:DDG:02" -eolc delaygenscreens/srsDG645.edl &
