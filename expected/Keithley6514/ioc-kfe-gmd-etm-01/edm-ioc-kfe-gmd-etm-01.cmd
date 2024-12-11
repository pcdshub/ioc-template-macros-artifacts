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

export IOC_PV=EM1K0:GMD:IOC:ETM:01
export HUTCH=kfe

pushd `readlink -f /cds/group/pcds/epics/ioc/common/Keithley6514/R1.9.4/screenLinks`

edm -x -eolc \
	-m "IOC=EM1K0:GMD:IOC:ETM:01,EM=EM1K0:GMD:ETM:01" -eolc	\
	Keithley6514Screens/Keithley6514.edl &
