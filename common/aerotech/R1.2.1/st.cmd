#!$$IOCTOP/bin/$$IF(ARCH,$$ARCH,rhel7-x86_64)/aerotech
epicsEnvSet("IOCNAME",    "$$IOCNAME" )
epicsEnvSet("ENGINEER",   "$$ENGINEER")
epicsEnvSet("LOCATION",   "$$LOCATION")
epicsEnvSet("IOCSH_PS1",  "$(IOCNAME)> ")
epicsEnvSet("IOC_PV",     "$$IOC_PV")
epicsEnvSet("IOCTOP",     "$$IOCTOP")
epicsEnvSet("STREAM_PROTOCOL_PATH", "$(IOCTOP)/protocol")
< envPaths
epicsEnvSet("TOP", "$$TOP")
cd("$(IOCTOP)")

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/aerotech.dbd")
aerotech_registerRecordDeviceDriver(pdbbase)

$$LOOP(ENSEMBLE)
#
# Sigh.  Motor number != Ensemble axis number.  If all axes are used,
# they are the same... but let's add the ability to dynamically leave
# gaps by defining Am=n in the config file.
#
epicsEnvSet("E$$(INDEX)_AXIS0", $$IF(A0,$$A0,0))
epicsEnvSet("E$$(INDEX)_AXIS1", $$IF(A1,$$A1,1))
epicsEnvSet("E$$(INDEX)_AXIS2", $$IF(A2,$$A2,2))
epicsEnvSet("E$$(INDEX)_AXIS3", $$IF(A3,$$A3,3))
epicsEnvSet("E$$(INDEX)_AXIS4", $$IF(A4,$$A4,4))
epicsEnvSet("E$$(INDEX)_AXIS5", $$IF(A5,$$A5,5))
epicsEnvSet("E$$(INDEX)_AXIS6", $$IF(A6,$$A6,6))
epicsEnvSet("E$$(INDEX)_AXIS7", $$IF(A7,$$A7,7))
epicsEnvSet("E$$(INDEX)_AXIS8", $$IF(A8,$$A8,8))
epicsEnvSet("E$$(INDEX)_AXIS9", $$IF(A9,$$A9,9))
$$ENDLOOP(ENSEMBLE)

$$LOOP(ENSEMBLE)
drvAsynIPPortConfigure("TCP$$INDEX", "$$IP:8000 TCP", 0, 0, 0 )
#asynSetTraceMask(  "TCP$$INDEX",	0,		9)
#asynSetTraceIOMask("TCP$$INDEX",	0,		2)
$$ENDLOOP(ENSEMBLE)

EnsembleAsynSetup(1)

$$LOOP(ENSEMBLE)
asynOctetSetInputEos("TCP$$INDEX",0,"\n")
asynOctetSetOutputEos("TCP$$INDEX",0,"\n")

#     (1) Controller number being configured
#     (2) ASYN port name
#     (3) ASYN address (GPIB only)
#     (4) Number of axes this controller supports
#     (5) Time to poll (msec) when an axis is in motion
#     (6) Time to poll (msec) when an axis is idle. 0 for no polling
EnsembleAsynConfig($$INDEX, "TCP$$INDEX", 0, $$COUNT, 100, 1000)

#   (1) Asyn port
#   (2) Driver name
#   (3) Controller index
#   (4) Max. number of axes
drvAsynMotorConfigure("AeroE$$INDEX","motorEnsemble",$$INDEX,$$COUNT)
$$ENDLOOP(ENSEMBLE)


# Load record instances
dbLoadRecords("db/iocSoft.db", "IOC=$(IOC_PV)")
#dbLoadRecords("db/save_restoreStatus.db", "IOC=$(IOC_PV)")
dbLoadRecords("db/save_restoreStatus.db", "P=$(IOC_PV):")
$$LOOP(ENSEMBLE)
$$LOOP(COUNT)
dbLoadRecords("db/AeroAsyn.db", "BASE=$$BASE,N=$$INDEX,A=$(E$$(INDEX1)_AXIS$$INDEX),PORT=AeroE$$INDEX1,TCP=TCP$$INDEX1")
$$ENDLOOP(COUNT)
dbLoadRecords("db/asynRecord.db", "P=$$BASE,R=:ASYN,PORT=TCP$$INDEX,ADDR=0,OMAX=0,IMAX=0")
dbLoadRecords("db/aerotech_global.db", "BASE=$$BASE,PORT=TCP$$INDEX,AXIS=$$IF(DPORT,$$DPORT,0)")
$$ENDLOOP(ENSEMBLE)
$$LOOP(MOTORALIAS)
$$IF(ENSEMBLEBASE)
dbLoadRecords("db/aerotech_alias.db", "OLD=$$ENSEMBLEBASE:m$$M,NEW=$$IF(ABASE,$$ABASE,$$ENSEMBLEBASE):$$ALIAS")
$$ELSE(ENSEMBLEBASE)
$$LOOP(ENSEMBLE)
dbLoadRecords("db/aerotech_alias.db", "OLD=$$BASE:m$$M,NEW=$$IF(ABASE,$$ABASE,$$BASE):$$ALIAS")
$$ENDLOOP(ENSEMBLE)
$$ENDIF(ENSEMBLEBASE)
$$ENDLOOP(MOTORALIAS)

$$LOOP(ESTOP)
dbLoadRecords("db/estop.db", "SENSOR=$$SENSOR,VALUE=$$VALUE,COND=$$IF(COND,$$COND,A=B),MOTOR=$$MOTOR")
$$ENDLOOP(ESTOP)

# Analog Track
$$LOOP(ENSEMBLE)
$$LOOP(COUNT)
dbLoadRecords("db/aerotech_analog_track.db", "BASE=$$BASE,AXIS=$$INDEX1,PORT=TCP$$INDEX")
$$ENDLOOP(COUNT)
$$ENDLOOP(ENSEMBLE)
# ##################


# Trajectory stuff?!?

# Setup autosave
set_savefile_path("$(IOC_DATA)/$(IOC)/autosave")
set_requestfile_path("$(TOP)/autosave")
save_restoreSet_status_prefix("$(IOC_PV):")
save_restoreSet_IncompleteSetsOk(1)
save_restoreSet_DatedBackupFiles(1)

# Just restore the settings
set_pass0_restoreFile("$$IOCNAME.sav")
set_pass1_restoreFile("$$IOCNAME.sav")

# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set("$$IOCNAME.req", 5, "")

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
