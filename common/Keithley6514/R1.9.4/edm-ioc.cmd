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

export IOC_PV=$$IOC_PV
export HUTCH=$$IF(HUTCH,$$HUTCH,tst)

pushd `readlink -f $$IOCTOP/screenLinks`

$$LOOP(ETM)
edm -x -eolc \
	-m "IOC=$$IOC_PV,EM=$$NAME" -eolc	\
	Keithley6514Screens/Keithley6514.edl &
$$ENDLOOP(ETM)
