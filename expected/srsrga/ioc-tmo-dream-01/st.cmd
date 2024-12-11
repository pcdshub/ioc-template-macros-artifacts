#!/reg/g/pcds/epics/ioc/common/srsrga/R1.0.0/bin/rhel7-x86_64/gsd

epicsEnvSet( "IOCNAME",	  "ioc-tmo-dream-01" )
epicsEnvSet( "ENGINEER",  "Basil Aljamal (baljamal)" )
epicsEnvSet( "LOCATION",  "TMO:DREAM" )
epicsEnvSet( "IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet( "IOC_PV",	  "IOC:TMO:DREAM:RGA:01" )
epicsEnvSet( "IOCTOP",	  "/reg/g/pcds/epics/ioc/common/srsrga/R1.0.0" )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IOCTOP)/app/srcProtocol" )
< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/common/srsrga/R1.0.0/children/build")
cd("$(IOCTOP)")

# Run common startup commands for linux soft IOC's
# < /reg/d/iocCommon/All/pre_linux.cmd

## Register all support components
dbLoadDatabase( "dbd/gsd.dbd" )
gsd_registerRecordDeviceDriver(pdbbase)


## Set up IOC/hardware links -- LAN connection
##############################################################
epicsEnvSet( "BASE", "TMO:DREAM:RGA:01")
drvAsynIPPortConfigure( "bus0", "tmo-dream-rga-01:818", 0, 0, 0 )
asynSetTraceMask( "bus0", -1, 0x09 )
asynSetTraceIOMask( "bus0", -1, 0x2 )

## Load record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)")
dbLoadRecords( "db/save_restoreStatus.db", "P=$(IOC_PV):")
dbLoadRecords( "db/srsrga.template", "BASE=TMO:DREAM:RGA:01, DEV=bus0, M_MAX=300")

## Setup autosave
# set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
# set_requestfile_path( "$(TOP)/autosave" )
## Also look in the iocData autosave folder for auto generated req files
# set_requestfile_path( "$(IOC_DATA)/$(IOC)/autosave" )
# save_restoreSet_status_prefix( "$(IOC_PV):" )
# save_restoreSet_IncompleteSetsOk( 1 )
# save_restoreSet_DatedBackupFiles( 1 )

# set_pass0_restoreFile( "autoSettings.sav" )
# set_pass0_restoreFile( "ioc-tmo-dream-01.sav" )

# Initialize the IOC and start processing records
iocInit()

# Create autosave files from info directives
# makeAutosaveFileFromDbInfo( "$(IOC_DATA)/$(IOC)/autosave/autoSettings.req", "autosaveFields" )

# Start autosave backups
# create_monitor_set( "autoSettings.req", 5, "" )
# create_monitor_set( "ioc-tmo-dream-01.req", 5, "" )

# All IOCs should dump some common info after initial startup.
# < /reg/d/iocCommon/All/post_linux.cmd

dbpf $(BASE):Clear.PROC 1
dbpf $(BASE):Init.PROC 1
dbpf $(BASE):getID.PROC 1
dbpf $(BASE):GetDegasTime.PROC 1
dbpf $(BASE):GetElectronEnergy.PROC 1
dbpf $(BASE):GetEmissionCurrent.PROC 1
dbpf $(BASE):GetIonEnergy.PROC 1
dbpf $(BASE):GetFocusPlateVoltage.PROC 1
dbpf $(BASE):GetNoiseFloorLevel.PROC 1
dbpf $(BASE):GetInitialMass.PROC 1
dbpf $(BASE):GetFinalMass.PROC 1
dbpf $(BASE):GetAnalogNpoints.PROC 1
dbpf $(BASE):GetHistogramNpoints.PROC 1
dbpf $(BASE):GetStepsPerMass.PROC 1
dbpf $(BASE):GetPressureSensitivity.PROC 1
