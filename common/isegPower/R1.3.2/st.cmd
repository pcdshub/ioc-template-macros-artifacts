#!$$IOCTOP/bin/$$IF(TARGET_ARCH,$$TARGET_ARCH,linux-arm-apalis)/isegPower

# Run common startup commands for linux soft IOC's
< $(IOC_COMMON)/All/pre_linux.cmd

< envPaths
epicsEnvSet( "IOCNAME",      "$$IOCNAME" )
epicsEnvSet( "ENGINEER",     "$$ENGINEER" )
epicsEnvSet( "LOCATION",     "$$LOCATION" )
epicsEnvSet( "IOCSH_PS1",    "$(IOCNAME)> " )
epicsEnvSet( "IOC_PV",       "$$IOC_PV" )
epicsEnvSet( "MPOD_PV",      "$$MPOD_PV" )
epicsEnvSet( "IOCTOP",       "$$IOCTOP" )
epicsEnvSet( "BUILD_TOP",    "$$TOP" )

# Set device env variables
epicsEnvSet( "P", "$(MPOD_PV)" )
epicsEnvSet( "R", ":" )
#epicsEnvSet( "SCAN", $ $IF(SCAN,$ $SCAN,.5 second) )

cd( "$(IOCTOP)" )

# Set Max array size
epicsEnvSet( "EPICS_CA_MAX_ARRAY_BYTES", "$$IF(MAX_ARRAY,$$MAX_ARRAY,20000000)" )

# Register all support components
dbLoadDatabase( "dbd/isegPower.dbd", 0, 0 )
isegPower_registerRecordDeviceDriver( pdbbase )

## Connect isegHalServer interface
isegHalConnect( "can0", "can0" )

# Bump up scanOnce queue size for evr invariant timing
scanOnceSetQueueSize( $$IF(SCAN_ONCE_QUEUE_SIZE,$$SCAN_ONCE_QUEUE_SIZE,4000) )

# Load soft ioc related record instances
dbLoadRecords( "db/iocSoft.db",				"IOC=$(IOC_PV)" )
dbLoadRecords( "db/iocRelease.db",			"IOC=$(IOC_PV)" )

# Load HVCARD instances
$$LOOP(HVCARD)
epicsEnvSet( "MODNUM", "$$INDEX" )

$$IF(N_CHAN,24)
$$LOOP(24)
dbLoadRecords( "db/iseg_epics.db", "DEV=$(MPOD_PV),P=$$MOD_PRE,R=$(R),CAN_LINE=0,DEVICE_ID=1000,MODULE_ID=$(MODNUM),CHANNEL_ID=$$INDEX,TYPE=$$TYPE" )
$$ENDLOOP(24)
$$ENDIF(N_CHAN)

$$IF(N_CHAN,16)
$$LOOP(16)
dbLoadRecords( "db/iseg_epics.db", "DEV=$(MPOD_PV),P=$$MOD_PRE,R=$(R),CAN_LINE=0,DEVICE_ID=1000,MODULE_ID=$(MODNUM),CHANNEL_ID=$$INDEX,TYPE=$$TYPE" )
$$ENDLOOP(16)
$$ENDIF(N_CHAN)

$$IF(N_CHAN,12)
$$LOOP(12)
dbLoadRecords( "db/iseg_epics.db", "DEV=$(MPOD_PV),P=$$MOD_PRE,R=$(R),CAN_LINE=0,DEVICE_ID=1000,MODULE_ID=$(MODNUM),CHANNEL_ID=$$INDEX,TYPE=$$TYPE" )
$$ENDLOOP(12)
$$ENDIF(N_CHAN)

$$IF(N_CHAN,8)
$$LOOP(8)
dbLoadRecords( "db/iseg_epics.db", "DEV=$(MPOD_PV),P=$$MOD_PRE,R=$(R),CAN_LINE=0,DEVICE_ID=1000,MODULE_ID=$(MODNUM),CHANNEL_ID=$$INDEX,TYPE=$$TYPE" )
$$ENDLOOP(8)
$$ENDIF(N_CHAN)

$$IF(N_CHAN,4)
$$LOOP(4)
dbLoadRecords( "db/iseg_epics.db", "DEV=$(MPOD_PV),P=$$MOD_PRE,R=$(R),CAN_LINE=0,DEVICE_ID=1000,MODULE_ID=$(MODNUM),CHANNEL_ID=$$INDEX,TYPE=$$TYPE" )
$$ENDLOOP(4)
$$ENDIF(N_CHAN)

$$ENDLOOP(HVCARD)

epicsEnvSet( "DEV_INFO", "DEV=$(MPOD_PV),IOC=$(IOC_PV),IOCNAME=$(IOCNAME)" )
epicsEnvSet( "DEV_INFO", "$(DEV_INFO),COM_TYPE=CANBUS,COM_PORT=$$HOST" )
$$IF(WEB_URL)
epicsEnvSet( "DEV_INFO", "$(DEV_INFO),WEB_URL=$$WEB_URL" )
$$ENDIF(WEB_URL)
$$IF(CAPTAR)
epicsEnvSet( "DEV_INFO", "$(DEV_INFO),CAPTAR=$$CAPTAR" )
$$ENDIF(CAPTAR)
dbLoadRecords( "db/devIocInfo.db",			"$(DEV_INFO)" )

# Setup autosave
dbLoadRecords( "db/save_restoreStatus.db",	"P=$(IOC_PV):" )
set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(BUILD_TOP)/autosave" )
# Also look in the iocData autosave folder for auto generated req files
set_requestfile_path( "$(IOC_DATA)/$(IOC)/autosave" )
save_restoreSet_status_prefix( "$(IOC_PV):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )
set_pass0_restoreFile( "autoSettings.sav" )
set_pass0_restoreFile( "$(IOC).sav" )
set_pass1_restoreFile( "autoSettings.sav" )
set_pass1_restoreFile( "$(IOC).sav" )

#
# Initialize the IOC and start processing records
#
iocInit()

# Make sure backplane power is on
dbpf $(MPOD_PV)$(R)Crate:PowerOn On

# Create autosave files from info directives
makeAutosaveFileFromDbInfo( "$(IOC_DATA)/$(IOC)/autosave/autoSettings.req", "autosaveFields" )

# Start autosave backups
create_monitor_set( "autoSettings.req", 5,  "" )
create_monitor_set( "$(IOCNAME).req",   5,  "" )

devIsegHalSetOpt( "can0", "Interval",  "0.1" )
devIsegHalSetOpt( "can0", "debug",     "0" )

# All IOCs should dump some common info after initial startup.
< $(IOC_COMMON)/All/post_linux.cmd

#dbl > /mnt/user/data/config/iseg_epics.pv
devIsegHalSetOpt( "can0", "LogLevel",  "1" )

