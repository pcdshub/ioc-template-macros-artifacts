#! /bin/bash

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
        source /reg/g/pcds/pyps/config/common_dirs.sh
else
        source /afs/slac/g/pcds/config/common_dirs.sh
fi

export EPICS_HOST_ARCH="rhel7-x86_64" # fix for env var overwritten by pcds_conda
export IOC_PV=IOC:UED:EPIX2M:01:IL

# Setup pydm environment
source /cds/group/pcds/pyps/conda/pcds_conda
pushd /reg/g/pcds/epics/ioc/common/interlock/R1.0.0

#
pydm --hide-nav-bar -m "IOC=IOC:UED:EPIX2M:01:IL","R0=UED:EPIX2M:01:INTERLOCK:01","R1=UED:EPIX2M:01:INTERLOCK:02","R2=UED:EPIX2M:01:INTERLOCK:03","R3=UED:EPIX2M:01:INTERLOCK:04","R4=UED:EPIX2M:01:INTERLOCK:05","R5=UED:EPIX2M:01:INTERLOCK:06","R6=UED:EPIX2M:01:INTERLOCK:07","R7=UED:EPIX2M:01:INTERLOCK:08","R8=UED:EPIX2M:01:INTERLOCK:09","R9=UED:EPIX2M:01:INTERLOCK:10","R10=UED:EPIX2M:01:INTERLOCK:11","R11=UED:EPIX2M:01:INTERLOCK:12","R12=UED:EPIX2M:01:INTERLOCK:13","R13=UED:EPIX2M:01:INTERLOCK:14","R14=UED:EPIX2M:01:INTERLOCK:15","R15=UED:EPIX2M:01:INTERLOCK:16","R16=UED:EPIX2M:01:INTERLOCK:17","R17=UED:EPIX2M:01:INTERLOCK:18","R18=UED:EPIX2M:01:INTERLOCK:19","R19=UED:EPIX2M:01:INTERLOCK:20","R20=UED:EPIX2M:01:INTERLOCK:21","R21=UED:EPIX2M:01:INTERLOCK:22","R22=UED:EPIX2M:01:INTERLOCK:23","R23=UED:EPIX2M:01:INTERLOCK:24","R24=UED:EPIX2M:01:INTERLOCK:25", interlockScreens/interlock.py &

