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

export TPR_PV=RIX:CCD:TPR:01
export TPE_PV=QRIX:STA:CCD:01:TPE
export TPR_TR=01
export TPR_CH=${TPR_TR}
export TPR_SE=${TPR_CH}
export IOC_PV=QRIX:STA:IOC:01
export CAM=QRIX:STA:CCD:01
export HUTCH=rix

export IF=ETH0

export SYNCTS="/reg/g/pcds/epics/ioc/common/archonCam/R1.1.0/children/build/iocBoot/ioc-qrix-archon1/syncts-ioc-qrix-archon1.cmd"

EDM_TOP=archonCamScreens/archonTprCamTop.edl
SCREENS_TOP=${EPICS_SITE_TOP}-dev/screens/edm/${HUTCH}/current

#pushd ${SCREENS_TOP}
# Now launching edm from new screenLinks directory under each IOCTOP release
# so each ioc can have it's own custom set of screens that matches which
# set of module depedencies that ioc was built with. 
pushd /reg/g/pcds/epics/ioc/common/archonCam/R1.1.0/screenLinks
edm -x -eolc    \
    -m "IOC=${IOC_PV}"      \
    -m "TPR=${TPR_PV}"      \
    -m "TPR_PV=${TPR_PV}"   \
    -m "TPE_PV=${TPE_PV}"   \
    -m "TPR_TR=${TPR_TR}"   \
    -m "TPR_CH=${TPR_CH}"   \
    -m "TPR_SE=${TPR_SE}"   \
    -m "CAM=${CAM}"         \
    -m "P=${CAM},R=:"       \
    -m "EDM_TOP=${EDM_TOP}" \
    -m "HUTCH=${HUTCH}"     \
    -m "IF=${IF}"           \
    -m "SYNCTS=${SYNCTS}"   \
    ${EDM_TOP} &

