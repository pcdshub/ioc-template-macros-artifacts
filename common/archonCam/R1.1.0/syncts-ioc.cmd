#! /bin/bash

# the IOC will set this to a non-zero value when running the script
FROMIOC="${1:-0}"

# setup conda env to get caproto
source /cds/group/pcds/pyps/conda/pcds_conda

# check if the script is being run from the IOC
if [ "${FROMIOC}" -ne 0 ]; then
    # use special timeout running from IOC
    TMO=$$CALC{$$IF(SYNC_TMO,$$SYNC_TMO,10)*3}
    # use the loopback when running from within the IOC
    export EPICS_CA_AUTO_ADDR_LIST="NO"
    export EPICS_CA_ADDR_LIST="127.255.255.255"
    # these are set to an empty string sometimes which breaks caproto...
    unset EPICS_CAS_SERVER_PORT
    unset EPICS_CAS_BEACON_PORT
else
    # use the default timeout when not run by IOC
    TMO=$$IF(SYNC_TMO,$$SYNC_TMO,10)
fi

export CAM=$$CAM_PV
$$IF(APP,archonTpr)
export TPR_PV=$$IF(TPR_PV,$$TPR_PV,$$CAM_PV:NoTpr)
export TPR_TR=$$IF(TPR_TR,$$TPR_TR,0)
export TPR_CH=$$IF(TPR_CH,$$TPR_CH,${TPR_TR})
python "$$IOCTOP/archonScripts/archonsyncts.py" "${CAM}" -t "${TPR_PV}" "${TPR_CH}" --timeout "${TMO}"
$$ELSE(APP)
export EVR_PV=$$IF(EVR_PV,$$EVR_PV,$$CAM_PV:NoEvr)
export TRIG_CH=$$IF(EVR_TRIG,$$EVR_TRIG,0)
python "$$IOCTOP/archonScripts/archonsyncts.py" "${CAM}" --timeout "${TMO}"
$$ENDIF(APP)
