#! /bin/bash

# set up environment
source $SETUP_SITE_TOP/epicsenv-cur.sh
source /cds/group/pcds/pyps/conda/py36env.sh

# Build the command to pass to Typhos
SCREEN_OPTS='--layout grid --display-type embed --size 1250,1800'

/cds/group/pcds/pyps/conda/py39/envs/pcds-5.8.4/bin/typhos $SCREEN_OPTS \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'LMXPP:MCS2:01:m1', 'name': 'LMXPP:INJ_MP1_MR1_TIP1'}]" \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'LMXPP:MCS2:01:m2', 'name': 'LMXPP:INJ_MP1_MR1_TILT1'}]" \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'LMXPP:MCS2:01:m3', 'name': 'LMXPP:INJ_MP1_ZOO1_LS2'}]" \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'LMXPP:MCS2:01:m4', 'name': 'LMXPP:INJ_MP1_ZOO1_LS3'}]" \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'LMXPP:MCS2:01:m5', 'name': 'LMXPP:INJ_MP1_MR3_TIP1'}]" \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'LMXPP:MCS2:01:m6', 'name': 'LMXPP:INJ_MP1_MR3_TILT1'}]" \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'LMXPP:MCS2:01:m7', 'name': 'LMXPP:INJ_MP1_MR4_TIP1'}]" \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'LMXPP:MCS2:01:m8', 'name': 'LMXPP:INJ_MP1_MR4_TILT1'}]" \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'LMXPP:MCS2:01:m9', 'name': 'LMXPP:NOT_USED'}]" \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'LMXPP:MCS2:01:m10', 'name': 'LMXPP:USER_0'}]" \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'LMXPP:MCS2:01:m11', 'name': 'LMXPP:USER_1'}]" \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'LMXPP:MCS2:01:m12', 'name': 'LMXPP:USER_2'}]" \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'LMXPP:MCS2:01:m13', 'name': 'LMXPP:USER_3'}]" \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'LMXPP:MCS2:01:m14', 'name': 'LMXPP:USER_4'}]" \
"pcdsdevices.epics_motor.SmarAct[{'prefix': 'LMXPP:MCS2:01:m15', 'name': 'LMXPP:USER_5'}]" \
&
