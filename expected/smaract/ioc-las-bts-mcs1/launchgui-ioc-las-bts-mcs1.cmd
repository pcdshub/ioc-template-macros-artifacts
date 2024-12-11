#! /bin/bash

# set up environment
source $SETUP_SITE_TOP/epicsenv-cur.sh
source /cds/group/pcds/pyps/conda/py36env.sh

# Build the command to pass to Typhos
SCREEN_OPTS='--layout grid --display-type embed --size 1250,1800'

/cds/group/pcds/pyps/conda/py39/envs/pcds-5.8.4/bin/typhos $SCREEN_OPTS \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'LAS:BTS:MCS2:01:m1', 'name': 'LAS:BTS:MCS2:01:m1'}]" \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'LAS:BTS:MCS2:01:m2', 'name': 'LAS:BTS:MCS2:01:m2'}]" \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'LAS:BTS:MCS2:01:m3', 'name': 'LAS:BTS:MCS2:01:m3'}]" \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'LAS:BTS:MCS2:01:m4', 'name': 'LAS:BTS:MCS2:01:m4'}]" \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'LAS:BTS:MCS2:01:m5', 'name': 'LAS:BTS:MCS2:01:m5'}]" \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'LAS:BTS:MCS2:01:m6', 'name': 'LAS:BTS:MCS2:01:m6'}]" \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'LAS:BTS:MCS2:01:m7', 'name': 'LAS:BTS:MCS2:01:m7'}]" \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'LAS:BTS:MCS2:01:m8', 'name': 'LAS:BTS:MCS2:01:m8'}]" \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'LAS:BTS:MCS2:01:m9', 'name': 'LAS:BTS:MCS2:01:m9'}]" \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'LAS:BTS:MCS2:01:m10', 'name': 'LAS:BTS:MCS2:01:m10'}]" \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'LAS:BTS:MCS2:01:m11', 'name': 'LAS:BTS:MCS2:01:m11'}]" \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'LAS:BTS:MCS2:01:m12', 'name': 'LAS:BTS:MCS2:01:m12'}]" \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'LAS:BTS:MCS2:01:m13', 'name': 'LAS:BTS:MCS2:01:m13'}]" \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'LAS:BTS:MCS2:01:m14', 'name': 'LAS:BTS:MCS2:01:m14'}]" \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'LAS:BTS:MCS2:01:m15', 'name': 'LAS:BTS:MCS2:01:m15'}]" \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'LAS:BTS:MCS2:01:m16', 'name': 'LAS:BTS:MCS2:01:m16'}]" \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'LAS:BTS:MCS2:01:m17', 'name': 'LAS:BTS:MCS2:01:m17'}]" \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'LAS:BTS:MCS2:01:m18', 'name': 'LAS:BTS:MCS2:01:m18'}]" \
&
