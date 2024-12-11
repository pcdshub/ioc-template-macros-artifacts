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

export IOC_PV=IOC:DSO4000:TST:01
export BASE=DSO4000:TST:01

EDM_TOP=screens/main4.edl

# Now launching edm from new screenLinks directory under each IOCTOP release
# so each ioc can have it's own custom set of screens that matches which
# set of module depedencies that ioc was built with. 
#pushd /cds/group/pcds/epics/ioc/common/dso4000/R1.0.1/screenLinks
pushd /cds/group/pcds/epics/ioc/common/dso4000/R1.0.1
edm -x -eolc	\
	-m "IOC=${IOC_PV}"		\
	-m "BASE=${BASE}"		\
	${EDM_TOP} &

