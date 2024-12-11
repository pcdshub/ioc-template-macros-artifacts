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

export IOC_PV=AMO:SDL:IOC:40:pi
export BASE=AMO:SDL:MZM:01

pushd /reg/g/pcds/epics/ioc/common/piMotion/R1.2.4/piMotionScreens
echo 'No screen yet!'
export IOC_PV=AMO:SDL:IOC:40:pi
export BASE=AMO:SDL:MZM:02

pushd /reg/g/pcds/epics/ioc/common/piMotion/R1.2.4/piMotionScreens
echo 'No screen yet!'
export IOC_PV=AMO:SDL:IOC:40:pi
export BASE=AMO:SDL:MZM:03

pushd /reg/g/pcds/epics/ioc/common/piMotion/R1.2.4/piMotionScreens
echo 'No screen yet!'
