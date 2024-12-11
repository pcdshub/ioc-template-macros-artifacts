#! /bin/bash

# set up environment
source $SETUP_SITE_TOP/epicsenv-cur.sh
source /cds/group/pcds/pyps/conda/py36env.sh

# Build the command to pass to Typhos
SCREEN_OPTS='--layout grid --display-type embed --size 1250,1800'

/cds/group/pcds/pyps/conda/py39/envs/pcds-5.8.4/bin/typhos $SCREEN_OPTS \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'LAS:OPCPA:MCS2:01:m1', 'name': 'LAS:OPCPA:MCS2:01:m1'}]" \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'LAS:OPCPA:MCS2:01:m2', 'name': 'LAS:OPCPA:MCS2:01:m2'}]" \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'LAS:OPCPA:MCS2:01:m3', 'name': 'LAS:OPCPA:MCS2:01:m3'}]" \
&
