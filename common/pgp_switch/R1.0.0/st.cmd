#!/bin/sh

source /cds/sw/ds/ana/conda2/manage/bin/psconda.sh
conda activate ps-4.5.5

# Python Package directories
export AXIPCIE_DIR=$$IOCTOP/firmware/submodules/axi-pcie-core/python
export SURF_DIR=$$IOCTOP/firmware/submodules/surf/python
export DS_DIR=$$IOCTOP/firmware/submodules/daq-stream-cache/python

# Setup python path
export PYTHONPATH=${SURF_DIR}:${AXIPCIE_DIR}:${DS_DIR}:${PYTHONPATH}
export PYROGUE_AS_REQPATH=$$TOP/autosave
export PYROGUE_AS_SAVPATH=/reg/d/iocData/$$IOCNAME/autosave
export PYROGUE_AS_INTERVAL=5
export PYROGUE_AS_SEQCNT=3
export PYROGUE_AS_SEQINT=60

cd $$IOCTOP
$$LOOP(SWITCH)
python scripts/LockerAppTesting.py --numLane $$IF(NUMLANE,$$NUMLANE,8) --numVc $$IF(NUMVC,$$NUMVC,2) --swRx False --swTx False --pvBase $$BASE --name $$IOCNAME
$$ENDLOOP(SWITCH)
