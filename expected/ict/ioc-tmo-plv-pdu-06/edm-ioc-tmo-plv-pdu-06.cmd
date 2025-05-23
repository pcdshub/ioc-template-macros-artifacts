#!/bin/bash

source /cds/group/pcds/pyps/conda/pcds_conda

export LOCATION=B950-100H1-R03-ICT-5
export BASE=PDU:TMO:ICT:06
export SCREEN_PATH=/reg/g/pcds/epics/ioc/common/ict/R1.0.7/ictScreens/ict-screen.ui

echo "Launching ict-screen.ui"
pydm --hide-nav-bar                         \
  -m "NAME=${LOCATION},BASE=${BASE}"        \
  ${SCREEN_PATH} &                          \

