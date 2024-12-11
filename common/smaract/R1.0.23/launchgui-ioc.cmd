#! /bin/bash

# set up environment
source $SETUP_SITE_TOP/epicsenv-cur.sh
source /cds/group/pcds/pyps/conda/py36env.sh

# Build the command to pass to Typhos
SCREEN_OPTS='--layout grid --display-type embed --size 1250,1800'

/cds/group/pcds/pyps/conda/py39/envs/pcds-5.8.4/bin/typhos $SCREEN_OPTS \
$$LOOP(SMARACT)
$$IF(ALL)
$$LOOP(COUNT)
"pcdsdevices.epics_motor.SmarAct[{'prefix': '$$BASE:m$$CALC{INDEX+1}', 'name': '$$BASE:m$$CALC{INDEX+1}'}]" \
$$ENDLOOP(COUNT)
$$ENDIF(ALL)
$$LOOP(ALIAS)
"pcdsdevices.epics_motor.SmarAct[{'prefix': '$$RECORD', 'name': '$$ALIAS'}]" \
$$ENDLOOP(ALIAS)
$$ENDLOOP(SMARACT)
&
