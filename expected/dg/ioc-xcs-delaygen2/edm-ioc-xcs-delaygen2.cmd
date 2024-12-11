#!/bin/bash
# EPICS startup script for edm (shell application)
#
# Setup edm environment
source /reg/g/pcds/setup/epicsenv-3.15.5-2.0.sh

cd /reg/g/pcds/package/epics/3.14/ioc/common/dg/R3.0.0
# Launch edm screen
edm -x -m "DG=XCS:MOB:DDG:02,IOC=IOC:XCS:DELAYGEN:02" -eolc delaygenscreens/srsDG645.edl &
