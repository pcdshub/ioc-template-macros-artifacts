#! /bin/bash

# Setup edm environment
source /reg/g/pcds/setup/epicsenv-cur.sh

cd /cds/group/pcds/epics/ioc/common/lakeshore335/R2.0.0/lakeshore335Screens

edm -x -m "IOC=IOC:XCS:TCT:LS335,DEV=XCS:USR:TCT:03" -eolc lakeshore335.edl &

