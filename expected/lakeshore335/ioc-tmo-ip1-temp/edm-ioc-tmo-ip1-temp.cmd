#! /bin/bash

# Setup edm environment
source /reg/g/pcds/setup/epicsenv-cur.sh

cd /reg/g/pcds/epics/ioc/common/lakeshore335/R2.0.0/lakeshore335Screens

edm -x -m "IOC=IOC:TMO:IP1:TCT:01,DEV=TMO:IP1:TCT:01" -eolc lakeshore335.edl &

