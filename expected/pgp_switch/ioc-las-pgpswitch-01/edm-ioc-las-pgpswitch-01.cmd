#!/bin/bash

export PCDS_CONDA_VER=5.1.1
source /cds/group/pcds/pyps/conda/pcds_conda

cd /reg/g/pcds/epics/ioc/common/pgp_switch/R1.0.0/pgpswScreens

pydm --hide-nav-bar --hide-menu-bar --hide-status-bar -m "BASE=LAS:PSW:01" "pgpswitch.ui" >/dev/null 2>/dev/null &

