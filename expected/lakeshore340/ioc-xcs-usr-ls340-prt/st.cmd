#!/reg/g/pcds/package/epics/3.14/ioc/common/lakeshore340/R4.0.1/bin/linux-x86_64/lakeshore340

< envPaths
epicsEnvSet("IOCNAME", "ioc-xcs-usr-ls340-prt" )
epicsEnvSet("ENGINEER", "Daniel Damiani (ddamiani)" )
epicsEnvSet("LOCATION", "XCS:IOC:TCT:PRT" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "XCS:IOC:TCT:PRT")
epicsEnvSet("IOCTOP", "/reg/g/pcds/package/epics/3.14/ioc/common/lakeshore340/R4.0.1")
epicsEnvSet("TOP", "/reg/g/pcds/package/epics/3.14/ioc/xcs/lakeshore340/R1.0.2/build")
epicsEnvSet(streamDebug, 0)
## Add the path to the protocol files
epicsEnvSet("STREAM_PROTOCOL_PATH", "$(IOCTOP)/protocol")

cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/lakeshore340.dbd")
lakeshore340_registerRecordDeviceDriver(pdbbase)

#------------------------------------------------------------------------------
# Asyn support

## Asyn record support
dbLoadRecords("$(ASYN)/db/asynRecord.db","P=XCS:USR:TCT:PRT,R=:asyn,PORT=bus0,ADDR=0,OMAX=0,IMAX=0")
drvAsynIPPortConfigure ("bus0","digi-xcs-portable1:2003",0,0,0)

## Set up IOC/hardware links -- LAN connection
# Lake shore 340 temperature controller
##############################################################
asynSetTraceMask("bus0", 0, 0x1) # logging for normal operation

# Load record instances
dbLoadRecords( "db/iocSoft.db",             "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db",  "IOC=$(IOC_PV)" )
dbLoadRecords( "db/lakeshore340.db",        "NAME=XCS:USR:TCT:PRT, bus=0, TEMPSCAN=10" )
dbLoadRecords( "db/LakeshoreKtoC.db",       "NAME=XCS:USR:TCT:PRT" )

# Setup autosave
set_savefile_path( "$(IOC_DATA)/$(IOCNAME)/autosave" )
set_requestfile_path( "$(TOP)/autosave" )
save_restoreSet_status_prefix( "$(IOC_PV):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )
set_pass0_restoreFile( "$(IOCNAME).sav" )
set_pass1_restoreFile( "$(IOCNAME).sav" )

# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set( "$(IOCNAME).req", 5, "IOC=$(IOC_PV)" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
