#! /bin/bash

# the IOC will set this to a non-zero value when running the script
FROMIOC="${1:-0}"

# setup conda env to get caproto
source /cds/group/pcds/pyps/conda/pcds_conda

# check if the script is being run from the IOC
if [ "${FROMIOC}" -ne 0 ]; then
    # use special timeout running from IOC
    TMO=30
    # use the loopback when running from within the IOC
    export EPICS_CA_AUTO_ADDR_LIST="NO"
    export EPICS_CA_ADDR_LIST="127.255.255.255"
    # these are set to an empty string sometimes which breaks caproto...
    unset EPICS_CAS_SERVER_PORT
    unset EPICS_CAS_BEACON_PORT
else
    # use the default timeout when not run by IOC
    TMO=10
fi

export CAM=QRIX:STA:CCD:01
export TPR_PV=RIX:CCD:TPR:01
export TPR_TR=01
export TPR_CH=${TPR_TR}
python "/reg/g/pcds/epics/ioc/common/archonCam/R1.1.0/archonScripts/archonsyncts.py" "${CAM}" -t "${TPR_PV}" "${TPR_CH}" --timeout "${TMO}"
