#!/bin/bash

if [ "$1" = "-h" ]; then
    echo "Usage:"
    echo "    $0"
    echo "        -- Show the expert GUI for all hutches"
    echo "    $0 \$HUTCH"
    echo "        -- Show the GUI for the specified hutch"
    echo "    $0 \$HUTCH \$PASSWORD "
    echo "        -- Show the expert GUI for the specified hutch"
    echo "    $0 \$HUTCH AOL $N"
    echo "        -- Show the auto overlap GUI for the specified hutch/route number."
    exit 0
fi

export PCDS_CONDA_VER=5.5.1
source /cds/group/pcds/pyps/conda/pcds_conda
export PYTHONPATH=/reg/g/pcds/epics/ioc/common/pfts_manager/R1.0.11/pftsmanScreens

cd /reg/g/pcds/epics/ioc/common/pfts_manager/R1.0.11/pftsmanScreens

if [ "$1" = "MOTOR" ]; then
    edm -x -eolc -m "IOC=IOC:LAS:PFTS:SIM,M1="`caget -tS LAS:PFTS:SIM:FLS$2:STAGE`",TITLE=LAS:PFTS:SIM FLS$2 Scan Stage" motor.edl &
    exit 0
fi

if [ "$#" -eq 0 ]; then
    pydm --hide-nav-bar --hide-menu-bar --hide-status-bar -m "BASE=LAS:PFTS:SIM" "pftsman.py" >/dev/null &
fi
if [ "$#" -eq 1 ]; then
    pydm --hide-nav-bar --hide-menu-bar --hide-status-bar -m "BASE=LAS:PFTS:SIM,HUTCH=$1" "pftsman_hutch.py" >/dev/null &
fi
if [ "$#" -eq 2 ]; then
    pydm --hide-nav-bar --hide-menu-bar --hide-status-bar -m "BASE=LAS:PFTS:SIM,HUTCH=$1,PASSWORD=$2" "pftsman_hutch.py" >/dev/null &
fi
if [ "$#" -eq 3 ]; then
    pydm --hide-nav-bar --hide-menu-bar --hide-status-bar -m "BASE=LAS:PFTS:SIM,HUTCH=$1,R=$3,MOTOR=`caget -t LAS:PFTS:SIM:$1:R$3:STAGE`" "pftsman_aol.py" >/dev/null &
fi
if [ "$#" -gt 3 ]; then
    echo "Usage: $0 [ HUTCH [ PASSWORD ]]"
fi

