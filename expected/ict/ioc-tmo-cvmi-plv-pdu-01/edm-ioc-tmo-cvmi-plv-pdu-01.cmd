#!/bin/bash

source /cds/group/pcds/pyps/conda/pcds_conda

export LOCATION=B940-100H1-PR03-ICT-01
export BASE=PDU:TMO:CVMI:ICT:01
export SCREEN_PATH=/reg/g/pcds/epics/ioc/common/ict/R1.0.7/ictScreens/ict-screen.ui

echo "Launching ict-screen.ui"
pydm --hide-nav-bar                         \
  -m "NAME=${LOCATION},BASE=${BASE}"        \
  ${SCREEN_PATH} &                          \

