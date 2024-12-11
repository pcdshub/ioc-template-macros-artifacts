#! /bin/bash

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
	source /reg/g/pcds/pyps/config/common_dirs.sh
else
	source /afs/slac/g/pcds/config/common_dirs.sh
fi

export IOC_PV=IOC:TMO:VAC:PIP:01

TOP="$(dirname "$(realpath "$0")")/../../../../screens"

# Setup edm environment
source pcds_conda


pydm -m "BASE=TMO:VAC:PIP:01,
        CH1=,
        CH2=,
        CH3=,
        CH4=,
" $TOP/qpc_main.ui &
