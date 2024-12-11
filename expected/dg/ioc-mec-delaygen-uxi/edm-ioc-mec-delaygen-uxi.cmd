#!/bin/bash
# EPICS startup script for edm (shell application)
#
# Setup edm environment
source /reg/g/pcds/setup/epicsenv-3.15.5-2.0.sh

cd /reg/g/pcds/epics/ioc/common/dg/R3.0.0
# Launch edm screen
edm -x -m "DG=MEC:DDG:UXI,IOC=MEC:IOC:DDG:UXI" -eolc delaygenscreens/srsDG645.edl &