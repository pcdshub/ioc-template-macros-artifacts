#!/bin/bash

source /cds/group/pcds/pyps/conda/pcds_conda

export LOCATION=B950-100H1-R01-E16
export BASE=LAS:LM1K4:PDU:ICT:01
export SCREEN_PATH=/cds/group/pcds/epics/ioc/common/ict/R1.0.7/ictScreens/ict-screen.ui

echo "Launching ict-screen.ui"
pydm --hide-nav-bar                         \
  -m "NAME=${LOCATION},BASE=${BASE}"        \
  ${SCREEN_PATH} &                          \

