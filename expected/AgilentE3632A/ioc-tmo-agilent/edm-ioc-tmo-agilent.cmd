#! /bin/bash

# Setup edm environment
source /reg/g/pcds/setup/epicsenv-3.14.12.sh

cd /reg/g/pcds/epics/ioc/common/AgilentE3632A/R1.0.3

edm -x -m "IOC=IOC:TMO:AGILENT,DEV=TMO:PWR:01" -eolc AgilentE3632AScreens/AgilentE3632A.edl &







