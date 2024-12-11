#! /bin/bash

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
	source /reg/g/pcds/pyps/config/common_dirs.sh
else
	source /afs/slac/g/pcds/config/common_dirs.sh
fi

export IOC_PV=IOC:TST:VAC:PIP:01

TOP="$(dirname "$(realpath "$0")")/../../../../screens"

# Setup edm environment
source pcds_conda


pydm -m "BASE=TST:VAC:PIP:01,
        CH1=MR1K4:SOMS:PIP:01,
        CH2=ST1K4:TEST:PIP:01,
        CH3=ST2K4:BCS:PIP:01,
        CH4=ST3K4:PPS:PIP:01,
" $TOP/qpc_main.ui &
