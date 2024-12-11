#! /bin/bash

# Setup the common directory env variables
if [ -e /reg/g/pcds/pyps/config/common_dirs.sh ]; then
	source /reg/g/pcds/pyps/config/common_dirs.sh
else
	source /afs/slac/g/pcds/config/common_dirs.sh
fi

export IOC_PV=$$IOC_PV

TOP="$(dirname "$(realpath "$0")")/../../../../screens"

# Setup edm environment
source pcds_conda

$$LOOP(QPC)

pydm -m "BASE=$$BASE,
$$LOOP(QPC_SLOT)
        CH$$CHANNEL=$$CH_BASE,
$$ENDLOOP(QPC_SLOT)
" $TOP/qpc_main.ui &
$$ENDLOOP(QPC)
