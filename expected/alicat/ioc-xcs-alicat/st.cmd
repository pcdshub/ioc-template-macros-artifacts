#!/reg/g/pcds/package/epics/3.14/ioc/common/alicat/R1.1.0/bin/linux-x86_64/alicat

< envPaths
epicsEnvSet("IOCNAME", "ioc-xcs-alicat" )
epicsEnvSet("ENGINEER", "Daniel Damiani (ddamiani)" )
epicsEnvSet("LOCATION", "IOC:XCS:USR:MFL" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "IOC:XCS:USR:MFL")
epicsEnvSet("IOCTOP", "/reg/g/pcds/package/epics/3.14/ioc/common/alicat/R1.1.0")
epicsEnvSet("TOP", "/reg/g/pcds/package/epics/3.14/ioc/xcs/alicat/R1.1.0/build")
## Add the path to the protocol files
epicsEnvSet("STREAM_PROTOCOL_PATH", "$(IOCTOP)/protocol")

cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/alicat.dbd")
alicat_registerRecordDeviceDriver(pdbbase)
#------------------------------------------------------------------------------
# Asyn support

## Asyn record support
dbLoadRecords("$(ASYN)/db/asynRecord.db","P=XCS:USR:MFL:01,R=:asyn,PORT=bus0,ADDR=0,OMAX=0,IMAX=0")
drvAsynIPPortConfigure ("bus0","digi-xcs-19:2005",0,0,0)

# Asyn tracing settings
asynSetTraceMask("bus0", 0, 0x1) # logging for normal operation

# Load record instances
dbLoadRecords( "db/iocSoft.db",             "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db",  "IOC=$(IOC_PV)" )

# Load alicat control
dbLoadRecords("db/alicat.db",       "MFL=XCS:USR:MFL:01,bus=bus0,dev=A")
dbLoadRecords("db/interlock.db",    "MFL=XCS:USR:MFL:01,PDU=XCS:R40:PWR:28:Outlet:3")

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

