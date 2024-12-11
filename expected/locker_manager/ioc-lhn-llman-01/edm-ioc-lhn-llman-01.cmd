#! /bin/bash

# Setup the common directory env variables
if [ -e      /reg/g/pcds/pyps/config/common_dirs.sh ]; then
	source   /reg/g/pcds/pyps/config/common_dirs.sh
elif [ -e    /afs/slac/g/pcds/pyps/config/common_dirs.sh ]; then
	source   /afs/slac/g/pcds/pyps/config/common_dirs.sh
fi

# Setup edm environment
if [ -f    ${SETUP_SITE_TOP}/epicsenv-cur.sh ]; then
	source ${SETUP_SITE_TOP}/epicsenv-cur.sh
fi

source /cds/group/pcds/pyps/conda/py36env.sh

pushd /cds/group/pcds/epics/ioc/common/locker_manager/R0.14.1/lockermanScreens
echo 
pydm -m "BASE=LAS:LHN:LLG2:01,TPR_BASE=LAS:LHN:TPR:01,TRIG_1=CBD,TRIG_2=AMP,TRIG_3=PP,TRIG_4=TIC,TPR_TRIG_1=01,TPR_TRIG_2=03,TPR_TRIG_3=05,TPR_TRIG_4=09,ATCA_BASE=LAS:LHN:3:M:ATOP:ACORE:SM" LockerManagerTop.ui &
