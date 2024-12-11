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

export EVR_PV=MRCO:CAM:04:NoEvr
export TRIG_CH=0

export IF=ENP1S0F0

export IOC_PV=MRCO:CAM:04:IOC
export CAM=MRCO:CAM:04
export HUTCH=TMO

# Check the current sync policy and status. We only try to sync if
# its set to "INTERNAL" mode and in the "Unlocked" state.
TS_POLICY="$(caget -t "${CAM}:TSS:TsPolicy")"
TS_STATUS="$(caget -t "${CAM}:TSS:SyncStatus")"
if [ "${TS_POLICY}" = "INTERNAL" -a "${TS_STATUS}" = "Unlocked" ]; then
    echo "Attempting to sync internal timestamps for ${CAM}"
    # Save the old event code to restore later.
    OLD_EVT_CODE="$(caget -t "${CAM}:TSS:EventCode_RBV")"
    echo "Setting ${CAM}:CamEventCode to 45"
    caput "${CAM}:CamEventCode" "45"
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
    # Restore the event code we overwrote before.
    echo "Restoring ${CAM}:CamEventCode to ${OLD_EVT_CODE}"
    caput "${CAM}:CamEventCode" "${OLD_EVT_CODE}"
else
    echo "Nothing to do..."
fi
