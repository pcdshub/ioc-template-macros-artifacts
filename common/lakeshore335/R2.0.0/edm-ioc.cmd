#! /bin/bash

# Setup edm environment
source /reg/g/pcds/setup/epicsenv-cur.sh

cd $$IOCTOP/lakeshore335Screens

$$LOOP(LAKESHORE)
edm -x -m "IOC=$$IOC_PV,DEV=$$NAME" -eolc lakeshore335.edl &
$$ENDLOOP(LAKESHORE)

