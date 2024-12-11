#! /bin/bash

# Setup edm environment
source /reg/g/pcds/setup/epicsenv-3.14.12.sh

cd $$IOCTOP

$$LOOP(AGILENT)
edm -x -m "IOC=$$TRANSLATE(IOCNAME,"a-z_-","A-Z::"),DEV=$$PV" -eolc AgilentE3632AScreens/AgilentE3632A.edl &
$$ENDLOOP(AGILENT)







