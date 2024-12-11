#! /bin/bash

# set up environment
source $SETUP_SITE_TOP/epicsenv-cur.sh
source /cds/group/pcds/pyps/conda/py36env.sh

# Build the command to pass to Typhos
SCREEN_OPTS='--layout grid --display-type embed --size 1250,1800'

/cds/group/pcds/pyps/conda/py39/envs/pcds-5.8.4/bin/typhos $SCREEN_OPTS \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'XPP:MCS2:01:m1', 'name': 'XPP:LIB:MCS:01'}]" \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'XPP:MCS2:01:m2', 'name': 'XPP:LIB:MCS:02'}]" \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'XPP:MCS2:01:m3', 'name': 'XPP:LIB:MCS:03'}]" \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'XPP:MCS2:01:m4', 'name': 'XPP:LIB:MCS:04'}]" \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'XPP:MCS2:01:m5', 'name': 'XPP:LIB:MCS:05'}]" \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'XPP:MCS2:01:m6', 'name': 'XPP:LIB:MCS:06'}]" \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'XPP:MCS2:01:m7', 'name': 'XPP:LIB:MCS:07'}]" \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'XPP:MCS2:01:m8', 'name': 'XPP:LIB:MCS:08'}]" \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'XPP:MCS2:01:m9', 'name': 'XPP:LIB:MCS:09'}]" \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'XPP:MCS2:01:m10', 'name': 'XPP:LIB:MCS:10'}]" \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'XPP:MCS2:01:m11', 'name': 'XPP:LIB:MCS:11'}]" \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'XPP:MCS2:01:m12', 'name': 'XPP:LIB:MCS:12'}]" \
&
