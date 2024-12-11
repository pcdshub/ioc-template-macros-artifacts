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

pushd $$IOCTOP/lockermanScreens
echo 
pydm -m "BASE=$$BASE_PV,TPR_BASE=$$TPR_BASE,TRIG_1=$$TRIG_1,TRIG_2=$$TRIG_2,TRIG_3=$$TRIG_3,TRIG_4=$$TRIG_4,TPR_TRIG_1=$$TPR_TRIG_1,TPR_TRIG_2=$$TPR_TRIG_2,TPR_TRIG_3=$$TPR_TRIG_3,TPR_TRIG_4=$$TPR_TRIG_4,ATCA_BASE=$$ATCA_BASE" LockerManagerTop.ui &
