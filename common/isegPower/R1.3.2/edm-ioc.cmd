#! /bin/bash

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
	source /reg/g/pcds/pyps/config/common_dirs.sh
else
	source /afs/slac/g/pcds/config/common_dirs.sh
fi

export IOC_PV=$$IOC_PV
export HUTCH=$$HUTCH

# Setup edm environment
source $SETUP_SITE_TOP/epicsenv-cur.sh
pushd $$RELEASE

# Launch edm
$$IF(TOP_SCREEN)
edm -x -eolc	\
	-m "DEV=$$MPOD_PV"	\
	-m "IOC=$$IOC_PV"	\
	-m "TITLE=$$IOCNAME"	\
	-m "HUTCH=$$HUTCH"	\
$$LOOP(HVCARD)
	-m "MOD$$INDEX=$$MOD_PRE"	\
$$ENDLOOP(HVCARD)
	$$(TOP_SCREEN)  &

$$ELSE(TOP_SCREEN)

edm -x -eolc	\
	-m "DEV=$$MPOD_PV"	\
	-m "IOC=$$IOC_PV"	\
	-m "TITLE=$$IOCNAME"	\
	-m "HUTCH=$$HUTCH"	\
$$LOOP(HVCARD)
	-m "MOD$$INDEX=$$MOD_PRE"	\
$$ENDLOOP(HVCARD)
	isegPowerScreens/mpod4SlotCrate.edl  &

$$ENDIF(TOP_SCREEN)

$$IF(LAUNCH_ALL)
$$LOOP(HVCARD)

edm -x -eolc	\
	-m "IOC=$$IOC_PV"	\
	-m "HUTCH=$$HUTCH"	\
	-m "DEV=$$MPOD_PV"	\
	-m "TITLE=$$IOCNAME M$$INDEX"	\
	-m "MOD=$$MOD_PRE:M$$INDEX"	\
	-m "TYPE=$$TYPE"	\
	isegPowerScreens/apalis$$(N_CHAN)ChModule.edl  &

$$ENDLOOP(HVCARD)
$$ENDIF(LAUNCH_ALL)
