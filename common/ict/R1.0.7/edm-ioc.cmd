#!/bin/bash

source /cds/group/pcds/pyps/conda/pcds_conda

export LOCATION=$$LOCATION
$$LOOP(PDU)
export BASE=$$NAME
$$ENDLOOP(PDU)
export SCREEN_PATH=$$IOCTOP/ictScreens/ict-screen.ui

echo "Launching ict-screen.ui"
pydm --hide-nav-bar                         \
  -m "NAME=${LOCATION},BASE=${BASE}"        \
  ${SCREEN_PATH} &                          \

