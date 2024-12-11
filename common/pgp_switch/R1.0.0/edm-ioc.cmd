#!/bin/bash

export PCDS_CONDA_VER=5.1.1
source /cds/group/pcds/pyps/conda/pcds_conda

cd $$IOCTOP/pgpswScreens

$$LOOP(SWITCH)
pydm --hide-nav-bar --hide-menu-bar --hide-status-bar -m "BASE=$$BASE" "pgpswitch.ui" >/dev/null 2>/dev/null &
$$ENDLOOP(SWITCH)

