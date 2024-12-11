#!/bin/sh

source /cds/sw/ds/ana/conda2/manage/bin/psconda.sh
conda activate ps-4.5.5

# Python Package directories
export AXIPCIE_DIR=/reg/g/pcds/epics/ioc/common/pgp_switch/R1.0.0/firmware/submodules/axi-pcie-core/python
export SURF_DIR=/reg/g/pcds/epics/ioc/common/pgp_switch/R1.0.0/firmware/submodules/surf/python
export DS_DIR=/reg/g/pcds/epics/ioc/common/pgp_switch/R1.0.0/firmware/submodules/daq-stream-cache/python

# Setup python path
export PYTHONPATH=${SURF_DIR}:${AXIPCIE_DIR}:${DS_DIR}:${PYTHONPATH}
export PYROGUE_AS_REQPATH=/reg/g/pcds/epics/ioc/common/pgp_switch/R1.0.0/children/build/autosave
export PYROGUE_AS_SAVPATH=/reg/d/iocData/ioc-las-pgpswitch-01/autosave
export PYROGUE_AS_INTERVAL=5
export PYROGUE_AS_SEQCNT=3
export PYROGUE_AS_SEQINT=60

cd /reg/g/pcds/epics/ioc/common/pgp_switch/R1.0.0
python scripts/LockerAppTesting.py --numLane 8 --numVc 2 --swRx False --swTx False --pvBase LAS:PSW:01 --name ioc-las-pgpswitch-01
