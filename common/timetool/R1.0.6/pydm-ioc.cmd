#!/bin/bash

usage()
{
cat << EOF
Usage:
    ./$(basename "$0") <EVENTBUILD-PV>
EOF
}

if [[ ($1 == "--help") || ($1 == "-h") ]]; then
    usage
    exit 0
fi

source pcds_conda

pushd $$RELEASE
export SCRIPT="event_builder.py"

echo "Launching ${SCRIPT}.py with EventBuilder PV $1."
pydm --hide-nav-bar -m "EBUILD_PV=$1" screens/$SCRIPT
