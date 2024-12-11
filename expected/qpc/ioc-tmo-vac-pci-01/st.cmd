#!/reg/g/pcds/epics/ioc/common/qpc/R1.0.0/bin/rhel7-x86_64/gsd

epicsEnvSet( "IOCNAME",	  "ioc-tmo-vac-pci-01" )
epicsEnvSet( "ENGINEER",  "Basil Aljamal (baljamal)" )
epicsEnvSet( "LOCATION",  "B950-233-R03-PCI-02" )
epicsEnvSet( "IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet( "IOC_PV",	  "IOC:TMO:VAC:PIP:01" )
epicsEnvSet( "IOCTOP",	  "/reg/g/pcds/epics/ioc/common/qpc/R1.0.0" )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IOCTOP)/app/srcProtocol" )
< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/common/qpc/R1.0.0/children/build")
cd("$(IOCTOP)")

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

## Register all support components
dbLoadDatabase( "dbd/gsd.dbd" )
gsd_registerRecordDeviceDriver(pdbbase)


## Set up IOC/hardware links -- LAN connection
##############################################################
drvAsynIPPortConfigure( "bus0", "pci-tmo-vac-01:23", 0, 0, 0 )
asynSetTraceMask( "bus0", 0, 0x09 )
asynSetTraceIOMask( "bus0", 0, 0x2 )
asynSetTraceFile("bus0",0,"$(IOC_DATA)/$(IOC)/iocInfo/comm.log")

## Load record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)")
dbLoadRecords( "db/save_restoreStatus.db", "P=$(IOC_PV):")
dbLoadRecords( "db/qpc_controller.db", "BASE=TMO:VAC:PIP:01, DEV=bus0" )
dbLoadRecords( "db/qpc_channel.db", "CH_BASE=,DEV=bus0,BASE=TMO:VAC:PIP:01,CHANNEL=1,TTLCHAN=5" )
dbLoadRecords( "db/qpc_channel.db", "CH_BASE=,DEV=bus0,BASE=TMO:VAC:PIP:01,CHANNEL=2,TTLCHAN=6" )
dbLoadRecords( "db/qpc_channel.db", "CH_BASE=,DEV=bus0,BASE=TMO:VAC:PIP:01,CHANNEL=3,TTLCHAN=7" )
dbLoadRecords( "db/qpc_channel.db", "CH_BASE=,DEV=bus0,BASE=TMO:VAC:PIP:01,CHANNEL=4,TTLCHAN=8" )
# Asyn Debug
dbLoadRecords( "db/asynRecord.db","P=TMO:VAC:PIP:01,R=,PORT=bus0,ADDR=0,OMAX=0,IMAX=0")

## Setup autosave
set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(TOP)/autosave" )
# Also look in the iocData autosave folder for auto generated req files
set_requestfile_path( "$(IOC_DATA)/$(IOC)/autosave" )
save_restoreSet_status_prefix( "$(IOC_PV):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

set_pass0_restoreFile( "autoSettings.sav" )
set_pass0_restoreFile( "ioc-tmo-vac-pci-01.sav" )

# Initialize the IOC and start processing records
iocInit()

# Create autosave files from info directives
makeAutosaveFileFromDbInfo( "$(IOC_DATA)/$(IOC)/autosave/autoSettings.req", "autosaveFields" )

# Start autosave backups
create_monitor_set( "autoSettings.req", 5, "" )
create_monitor_set( "ioc-tmo-vac-pci-01.req", 5, "" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
