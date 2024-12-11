#!/reg/g/pcds/epics/ioc/common/isegPower/R1.3.2/bin/linux-arm-apalis/isegPower

# Run common startup commands for linux soft IOC's
< $(IOC_COMMON)/All/pre_linux.cmd

< envPaths
epicsEnvSet( "IOCNAME",      "ioc-crix-mpod-01" )
epicsEnvSet( "ENGINEER",     "Aalayah Spencer (spencera)" )
epicsEnvSet( "LOCATION",     "B950-100H2" )
epicsEnvSet( "IOCSH_PS1",    "$(IOCNAME)> " )
epicsEnvSet( "IOC_PV",       "CRIX:MPOD:01:IOC" )
epicsEnvSet( "MPOD_PV",      "CRIX:MPOD:01" )
epicsEnvSet( "IOCTOP",       "/reg/g/pcds/epics/ioc/common/isegPower/R1.3.2" )
epicsEnvSet( "BUILD_TOP",    "/reg/g/pcds/epics/ioc/rix/isegPower/R1.3.1/build" )

# Set device env variables
epicsEnvSet( "P", "$(MPOD_PV)" )
epicsEnvSet( "R", ":" )
#epicsEnvSet( "SCAN", $ $IF(SCAN,$ $SCAN,.5 second) )

cd( "$(IOCTOP)" )

# Set Max array size
epicsEnvSet( "EPICS_CA_MAX_ARRAY_BYTES", "20000000" )

# Register all support components
dbLoadDatabase( "dbd/isegPower.dbd", 0, 0 )
isegPower_registerRecordDeviceDriver( pdbbase )

## Connect isegHalServer interface
isegHalConnect( "can0", "can0" )

# Bump up scanOnce queue size for evr invariant timing
scanOnceSetQueueSize( 4000 )

# Load soft ioc related record instances
dbLoadRecords( "db/iocSoft.db",				"IOC=$(IOC_PV)" )
dbLoadRecords( "db/iocRelease.db",			"IOC=$(IOC_PV)" )

# Load HVCARD instances
epicsEnvSet( "MODNUM", "0" )




dbLoadRecords( "db/iseg_epics.db", "DEV=$(MPOD_PV),P=CRIX:MPOD:01,R=$(R),CAN_LINE=0,DEVICE_ID=1000,MODULE_ID=$(MODNUM),CHANNEL_ID=0,TYPE=EHS_84_05n" )
dbLoadRecords( "db/iseg_epics.db", "DEV=$(MPOD_PV),P=CRIX:MPOD:01,R=$(R),CAN_LINE=0,DEVICE_ID=1000,MODULE_ID=$(MODNUM),CHANNEL_ID=1,TYPE=EHS_84_05n" )
dbLoadRecords( "db/iseg_epics.db", "DEV=$(MPOD_PV),P=CRIX:MPOD:01,R=$(R),CAN_LINE=0,DEVICE_ID=1000,MODULE_ID=$(MODNUM),CHANNEL_ID=2,TYPE=EHS_84_05n" )
dbLoadRecords( "db/iseg_epics.db", "DEV=$(MPOD_PV),P=CRIX:MPOD:01,R=$(R),CAN_LINE=0,DEVICE_ID=1000,MODULE_ID=$(MODNUM),CHANNEL_ID=3,TYPE=EHS_84_05n" )
dbLoadRecords( "db/iseg_epics.db", "DEV=$(MPOD_PV),P=CRIX:MPOD:01,R=$(R),CAN_LINE=0,DEVICE_ID=1000,MODULE_ID=$(MODNUM),CHANNEL_ID=4,TYPE=EHS_84_05n" )
dbLoadRecords( "db/iseg_epics.db", "DEV=$(MPOD_PV),P=CRIX:MPOD:01,R=$(R),CAN_LINE=0,DEVICE_ID=1000,MODULE_ID=$(MODNUM),CHANNEL_ID=5,TYPE=EHS_84_05n" )
dbLoadRecords( "db/iseg_epics.db", "DEV=$(MPOD_PV),P=CRIX:MPOD:01,R=$(R),CAN_LINE=0,DEVICE_ID=1000,MODULE_ID=$(MODNUM),CHANNEL_ID=6,TYPE=EHS_84_05n" )
dbLoadRecords( "db/iseg_epics.db", "DEV=$(MPOD_PV),P=CRIX:MPOD:01,R=$(R),CAN_LINE=0,DEVICE_ID=1000,MODULE_ID=$(MODNUM),CHANNEL_ID=7,TYPE=EHS_84_05n" )


epicsEnvSet( "MODNUM", "1" )




dbLoadRecords( "db/iseg_epics.db", "DEV=$(MPOD_PV),P=CRIX:MPOD:01,R=$(R),CAN_LINE=0,DEVICE_ID=1000,MODULE_ID=$(MODNUM),CHANNEL_ID=0,TYPE=EHS_84_60n" )
dbLoadRecords( "db/iseg_epics.db", "DEV=$(MPOD_PV),P=CRIX:MPOD:01,R=$(R),CAN_LINE=0,DEVICE_ID=1000,MODULE_ID=$(MODNUM),CHANNEL_ID=1,TYPE=EHS_84_60n" )
dbLoadRecords( "db/iseg_epics.db", "DEV=$(MPOD_PV),P=CRIX:MPOD:01,R=$(R),CAN_LINE=0,DEVICE_ID=1000,MODULE_ID=$(MODNUM),CHANNEL_ID=2,TYPE=EHS_84_60n" )
dbLoadRecords( "db/iseg_epics.db", "DEV=$(MPOD_PV),P=CRIX:MPOD:01,R=$(R),CAN_LINE=0,DEVICE_ID=1000,MODULE_ID=$(MODNUM),CHANNEL_ID=3,TYPE=EHS_84_60n" )
dbLoadRecords( "db/iseg_epics.db", "DEV=$(MPOD_PV),P=CRIX:MPOD:01,R=$(R),CAN_LINE=0,DEVICE_ID=1000,MODULE_ID=$(MODNUM),CHANNEL_ID=4,TYPE=EHS_84_60n" )
dbLoadRecords( "db/iseg_epics.db", "DEV=$(MPOD_PV),P=CRIX:MPOD:01,R=$(R),CAN_LINE=0,DEVICE_ID=1000,MODULE_ID=$(MODNUM),CHANNEL_ID=5,TYPE=EHS_84_60n" )
dbLoadRecords( "db/iseg_epics.db", "DEV=$(MPOD_PV),P=CRIX:MPOD:01,R=$(R),CAN_LINE=0,DEVICE_ID=1000,MODULE_ID=$(MODNUM),CHANNEL_ID=6,TYPE=EHS_84_60n" )
dbLoadRecords( "db/iseg_epics.db", "DEV=$(MPOD_PV),P=CRIX:MPOD:01,R=$(R),CAN_LINE=0,DEVICE_ID=1000,MODULE_ID=$(MODNUM),CHANNEL_ID=7,TYPE=EHS_84_60n" )


epicsEnvSet( "MODNUM", "2" )




dbLoadRecords( "db/iseg_epics.db", "DEV=$(MPOD_PV),P=CRIX:MPOD:01,R=$(R),CAN_LINE=0,DEVICE_ID=1000,MODULE_ID=$(MODNUM),CHANNEL_ID=0,TYPE=EHS_84_05p" )
dbLoadRecords( "db/iseg_epics.db", "DEV=$(MPOD_PV),P=CRIX:MPOD:01,R=$(R),CAN_LINE=0,DEVICE_ID=1000,MODULE_ID=$(MODNUM),CHANNEL_ID=1,TYPE=EHS_84_05p" )
dbLoadRecords( "db/iseg_epics.db", "DEV=$(MPOD_PV),P=CRIX:MPOD:01,R=$(R),CAN_LINE=0,DEVICE_ID=1000,MODULE_ID=$(MODNUM),CHANNEL_ID=2,TYPE=EHS_84_05p" )
dbLoadRecords( "db/iseg_epics.db", "DEV=$(MPOD_PV),P=CRIX:MPOD:01,R=$(R),CAN_LINE=0,DEVICE_ID=1000,MODULE_ID=$(MODNUM),CHANNEL_ID=3,TYPE=EHS_84_05p" )
dbLoadRecords( "db/iseg_epics.db", "DEV=$(MPOD_PV),P=CRIX:MPOD:01,R=$(R),CAN_LINE=0,DEVICE_ID=1000,MODULE_ID=$(MODNUM),CHANNEL_ID=4,TYPE=EHS_84_05p" )
dbLoadRecords( "db/iseg_epics.db", "DEV=$(MPOD_PV),P=CRIX:MPOD:01,R=$(R),CAN_LINE=0,DEVICE_ID=1000,MODULE_ID=$(MODNUM),CHANNEL_ID=5,TYPE=EHS_84_05p" )
dbLoadRecords( "db/iseg_epics.db", "DEV=$(MPOD_PV),P=CRIX:MPOD:01,R=$(R),CAN_LINE=0,DEVICE_ID=1000,MODULE_ID=$(MODNUM),CHANNEL_ID=6,TYPE=EHS_84_05p" )
dbLoadRecords( "db/iseg_epics.db", "DEV=$(MPOD_PV),P=CRIX:MPOD:01,R=$(R),CAN_LINE=0,DEVICE_ID=1000,MODULE_ID=$(MODNUM),CHANNEL_ID=7,TYPE=EHS_84_05p" )


epicsEnvSet( "MODNUM", "3" )




dbLoadRecords( "db/iseg_epics.db", "DEV=$(MPOD_PV),P=CRIX:MPOD:01,R=$(R),CAN_LINE=0,DEVICE_ID=1000,MODULE_ID=$(MODNUM),CHANNEL_ID=0,TYPE=EHS_84_60p" )
dbLoadRecords( "db/iseg_epics.db", "DEV=$(MPOD_PV),P=CRIX:MPOD:01,R=$(R),CAN_LINE=0,DEVICE_ID=1000,MODULE_ID=$(MODNUM),CHANNEL_ID=1,TYPE=EHS_84_60p" )
dbLoadRecords( "db/iseg_epics.db", "DEV=$(MPOD_PV),P=CRIX:MPOD:01,R=$(R),CAN_LINE=0,DEVICE_ID=1000,MODULE_ID=$(MODNUM),CHANNEL_ID=2,TYPE=EHS_84_60p" )
dbLoadRecords( "db/iseg_epics.db", "DEV=$(MPOD_PV),P=CRIX:MPOD:01,R=$(R),CAN_LINE=0,DEVICE_ID=1000,MODULE_ID=$(MODNUM),CHANNEL_ID=3,TYPE=EHS_84_60p" )
dbLoadRecords( "db/iseg_epics.db", "DEV=$(MPOD_PV),P=CRIX:MPOD:01,R=$(R),CAN_LINE=0,DEVICE_ID=1000,MODULE_ID=$(MODNUM),CHANNEL_ID=4,TYPE=EHS_84_60p" )
dbLoadRecords( "db/iseg_epics.db", "DEV=$(MPOD_PV),P=CRIX:MPOD:01,R=$(R),CAN_LINE=0,DEVICE_ID=1000,MODULE_ID=$(MODNUM),CHANNEL_ID=5,TYPE=EHS_84_60p" )
dbLoadRecords( "db/iseg_epics.db", "DEV=$(MPOD_PV),P=CRIX:MPOD:01,R=$(R),CAN_LINE=0,DEVICE_ID=1000,MODULE_ID=$(MODNUM),CHANNEL_ID=6,TYPE=EHS_84_60p" )
dbLoadRecords( "db/iseg_epics.db", "DEV=$(MPOD_PV),P=CRIX:MPOD:01,R=$(R),CAN_LINE=0,DEVICE_ID=1000,MODULE_ID=$(MODNUM),CHANNEL_ID=7,TYPE=EHS_84_60p" )


epicsEnvSet( "MODNUM", "4" )




dbLoadRecords( "db/iseg_epics.db", "DEV=$(MPOD_PV),P=CRIX:MPOD:01,R=$(R),CAN_LINE=0,DEVICE_ID=1000,MODULE_ID=$(MODNUM),CHANNEL_ID=0,TYPE=EHS_84_20n" )
dbLoadRecords( "db/iseg_epics.db", "DEV=$(MPOD_PV),P=CRIX:MPOD:01,R=$(R),CAN_LINE=0,DEVICE_ID=1000,MODULE_ID=$(MODNUM),CHANNEL_ID=1,TYPE=EHS_84_20n" )
dbLoadRecords( "db/iseg_epics.db", "DEV=$(MPOD_PV),P=CRIX:MPOD:01,R=$(R),CAN_LINE=0,DEVICE_ID=1000,MODULE_ID=$(MODNUM),CHANNEL_ID=2,TYPE=EHS_84_20n" )
dbLoadRecords( "db/iseg_epics.db", "DEV=$(MPOD_PV),P=CRIX:MPOD:01,R=$(R),CAN_LINE=0,DEVICE_ID=1000,MODULE_ID=$(MODNUM),CHANNEL_ID=3,TYPE=EHS_84_20n" )
dbLoadRecords( "db/iseg_epics.db", "DEV=$(MPOD_PV),P=CRIX:MPOD:01,R=$(R),CAN_LINE=0,DEVICE_ID=1000,MODULE_ID=$(MODNUM),CHANNEL_ID=4,TYPE=EHS_84_20n" )
dbLoadRecords( "db/iseg_epics.db", "DEV=$(MPOD_PV),P=CRIX:MPOD:01,R=$(R),CAN_LINE=0,DEVICE_ID=1000,MODULE_ID=$(MODNUM),CHANNEL_ID=5,TYPE=EHS_84_20n" )
dbLoadRecords( "db/iseg_epics.db", "DEV=$(MPOD_PV),P=CRIX:MPOD:01,R=$(R),CAN_LINE=0,DEVICE_ID=1000,MODULE_ID=$(MODNUM),CHANNEL_ID=6,TYPE=EHS_84_20n" )
dbLoadRecords( "db/iseg_epics.db", "DEV=$(MPOD_PV),P=CRIX:MPOD:01,R=$(R),CAN_LINE=0,DEVICE_ID=1000,MODULE_ID=$(MODNUM),CHANNEL_ID=7,TYPE=EHS_84_20n" )


epicsEnvSet( "MODNUM", "5" )




dbLoadRecords( "db/iseg_epics.db", "DEV=$(MPOD_PV),P=CRIX:MPOD:01,R=$(R),CAN_LINE=0,DEVICE_ID=1000,MODULE_ID=$(MODNUM),CHANNEL_ID=0,TYPE=EHS_84_20p" )
dbLoadRecords( "db/iseg_epics.db", "DEV=$(MPOD_PV),P=CRIX:MPOD:01,R=$(R),CAN_LINE=0,DEVICE_ID=1000,MODULE_ID=$(MODNUM),CHANNEL_ID=1,TYPE=EHS_84_20p" )
dbLoadRecords( "db/iseg_epics.db", "DEV=$(MPOD_PV),P=CRIX:MPOD:01,R=$(R),CAN_LINE=0,DEVICE_ID=1000,MODULE_ID=$(MODNUM),CHANNEL_ID=2,TYPE=EHS_84_20p" )
dbLoadRecords( "db/iseg_epics.db", "DEV=$(MPOD_PV),P=CRIX:MPOD:01,R=$(R),CAN_LINE=0,DEVICE_ID=1000,MODULE_ID=$(MODNUM),CHANNEL_ID=3,TYPE=EHS_84_20p" )
dbLoadRecords( "db/iseg_epics.db", "DEV=$(MPOD_PV),P=CRIX:MPOD:01,R=$(R),CAN_LINE=0,DEVICE_ID=1000,MODULE_ID=$(MODNUM),CHANNEL_ID=4,TYPE=EHS_84_20p" )
dbLoadRecords( "db/iseg_epics.db", "DEV=$(MPOD_PV),P=CRIX:MPOD:01,R=$(R),CAN_LINE=0,DEVICE_ID=1000,MODULE_ID=$(MODNUM),CHANNEL_ID=5,TYPE=EHS_84_20p" )
dbLoadRecords( "db/iseg_epics.db", "DEV=$(MPOD_PV),P=CRIX:MPOD:01,R=$(R),CAN_LINE=0,DEVICE_ID=1000,MODULE_ID=$(MODNUM),CHANNEL_ID=6,TYPE=EHS_84_20p" )
dbLoadRecords( "db/iseg_epics.db", "DEV=$(MPOD_PV),P=CRIX:MPOD:01,R=$(R),CAN_LINE=0,DEVICE_ID=1000,MODULE_ID=$(MODNUM),CHANNEL_ID=7,TYPE=EHS_84_20p" )



epicsEnvSet( "DEV_INFO", "DEV=$(MPOD_PV),IOC=$(IOC_PV),IOCNAME=$(IOCNAME)" )
epicsEnvSet( "DEV_INFO", "$(DEV_INFO),COM_TYPE=CANBUS,COM_PORT=" )
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
