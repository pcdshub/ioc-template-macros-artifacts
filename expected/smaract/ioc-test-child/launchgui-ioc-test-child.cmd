#! /bin/bash

# set up environment
source $SETUP_SITE_TOP/epicsenv-cur.sh
source /cds/group/pcds/pyps/conda/py36env.sh

# Build the command to pass to Typhos
SCREEN_OPTS='--layout grid --display-type embed --size 1250,1800'

/cds/group/pcds/pyps/conda/py39/envs/pcds-5.8.4/bin/typhos $SCREEN_OPTS \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'LAS:TST:MCS2:02:m1', 'name': 'TEST:TEST_STAGE_A'}]" \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'LAS:TST:MCS2:02:m2', 'name': 'TEST:TEST_STAGE_B'}]" \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'LAS:TST:MCS2:02:m4', 'name': 'TEST:TEST_STAGE_C'}]" \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'LAS:TST:MCS2:02:m5', 'name': 'TEST:TEST_STAGE_D'}]" \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'LAS:TST:MCS2:02:m7', 'name': 'TEST:TEST_STAGE_E'}]" \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'LAS:TST:MCS2:02:m8', 'name': 'TEST:TEST_STAGE_F'}]" \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'LAS:TEST:MCS2:02:m10', 'name': 'TEST:TEST_STAGE_G'}]" \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'LAS:TEST:MCS2:02:m12', 'name': 'TEST:TEST_STAGE_H'}]" \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'LAS:TEST:MCS2:02:m13', 'name': 'TEST:TEST_STAGE_I'}]" \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'LAS:TEST:MCS2:02:m14', 'name': 'TEST:TEST_STAGE_J'}]" \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'LAS:TEST:MCS2:02:m16', 'name': 'TEST:TEST_STAGE_K'}]" \
&
