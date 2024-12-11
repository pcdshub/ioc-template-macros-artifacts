#!/bin/bash

source /cds/group/pcds/pyps/conda/pcds_conda

export LOCATION=B950-233-WALL-S-R02
export BASE=QRIX:PDU:ICT:01
export SCREEN_PATH=/reg/g/pcds/epics/ioc/common/ict/R1.0.7/ictScreens/ict-screen.ui

echo "Launching ict-screen.ui"
pydm --hide-nav-bar                         \
  -m "NAME=${LOCATION},BASE=${BASE}"        \
  ${SCREEN_PATH} &                          \

