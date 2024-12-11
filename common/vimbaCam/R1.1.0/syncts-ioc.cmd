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

$$IF(APP,vimbaTpr)
export TPR_PV=$$IF(TPR_PV,$$TPR_PV,$$CAM_PV:NoTpr)
export TPE_PV=$$IF(TPE_PV,$$TPE_PV,$$TPR_PV)
export TPR_TR=$$IF(TPR_TR,$$TPR_TR,0)
export TPR_CH=$$IF(TPR_CH,$$TPR_CH,${TPR_TR})
export TPR_SE=$$IF(TPR_SE,$$TPR_SE,${TPR_CH})
$$ELSE(APP)
export EVR_PV=$$IF(EVR_PV,$$EVR_PV,$$CAM_PV:NoEvr)
export TRIG_CH=$$IF(EVR_TRIG,$$EVR_TRIG,0)
$$ENDIF(APP)

export IF=$$IF(NET_IF,$$NET_IF,ETH0)

export IOC_PV=$$IOC_PV
export CAM=$$CAM_PV
export HUTCH=$$IF(HUTCH,$$HUTCH,tst)

# Check the current sync policy and status. We only try to sync if
# its set to "INTERNAL" mode and in the "Unlocked" state.
TS_POLICY="$(caget -t "${CAM}:TSS:TsPolicy")"
TS_STATUS="$(caget -t "${CAM}:TSS:SyncStatus")"
if [ "${TS_POLICY}" = "INTERNAL" -a "${TS_STATUS}" = "Unlocked" ]; then
    echo "Attempting to sync internal timestamps for ${CAM}"
$$IF(APP,vimbaTpr)
    # Save the values we will overwrite to restore them later.
    LCLS_MODE="$(caget -t "${TPR_PV}:MODE")"
    OLD_RATE_MODE="$(caget -t "${TPR_PV}:CH${TPR_CH}_RATEMODE")"
    OLD_FIXED_RATE="$(caget -t "${TPR_PV}:CH${TPR_CH}_FIXEDRATE")"
    OLD_EVCODE="$(caget -t "${TPR_PV}:CH${TPR_CH}_EVCODE")"
    if [ "${LCLS_MODE}" = "SC" ]; then
        # Set the trigger rate to fixed rate 1Hz
        echo "Setting ${TPR_PV}:CH${TPR_CH} to Fixed - 1Hz"
        caput "${TPR_PV}:CH${TPR_CH}_RATEMODE" Fixed
        caput "${TPR_PV}:CH${TPR_CH}_FIXEDRATE" "1Hz"
    else
        # Set the trigger to event code 45
        echo "Setting ${TPR_PV}:CH${TPR_CH}_EVCODE to 45"
        caput "${TPR_PV}:CH${TPR_CH}_EVCODE" "45"
    fi
$$ELSE(APP)
    # Save the old event code to restore later.
    OLD_EVT_CODE="$(caget -t "${CAM}:TSS:EventCode_RBV")"
    echo "Setting ${CAM}:CamEventCode to 45"
    caput "${CAM}:CamEventCode" "45"
$$ENDIF(APP)
    sleep 2
    # Initiate the sync.
    caput "${CAM}:TSS:IntReq" 1
    sleep 2
    # Check if the sync worked
    TS_STATUS="$(caget -t "${CAM}:TSS:SyncStatus")"
    if [ "${TS_STATUS}" = "Locked" ]; then
        echo "Successfully synced ${CAM}"
    else
        echo "Failed to sync ${CAM} - check that there is a trigger/timing"       
    fi
$$IF(APP,vimbaTpr)
    # Restore the values we overwrote before.
    if [ "${LCLS_MODE}" = "SC" ]; then
        echo "Restoring ${TPR_PV}:CH${TPR_CH} to old settings"
        caput "${TPR_PV}:CH${TPR_CH}_RATEMODE" "${OLD_RATE_MODE}"
        caput "${TPR_PV}:CH${TPR_CH}_FIXEDRATE" "${OLD_FIXED_RATE}"
    else
        echo "Restoring ${TPR_PV}:CH${TPR_CH}_EVCODE to ${OLD_EVCODE}"
        caput "${TPR_PV}:CH${TPR_CH}_EVCODE" "${OLD_EVCODE}"
    fi
$$ELSE(APP)
    # Restore the event code we overwrote before.
    echo "Restoring ${CAM}:CamEventCode to ${OLD_EVT_CODE}"
    caput "${CAM}:CamEventCode" "${OLD_EVT_CODE}"
$$ENDIF(APP)
else
    echo "Nothing to do..."
fi
