#!/reg/g/pcds/package/epics/3.14/ioc/common/thermocube/R1.0.5/bin/linux-x86_64/chiller

< envPaths
epicsEnvSet("IOCNAME", "ioc-det-chiller1" )
epicsEnvSet("ENGINEER", "Daniel Damiani (ddamiani)" )
epicsEnvSet("LOCATION", "IOC:DET:CHL" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "IOC:DET:CHL")
epicsEnvSet("FLOWDB_CUBIC",   "db/cubicEX30AR-V.db")
epicsEnvSet("FLOWDB_PROTEUS", "db/proteusFlowMeter.db")
epicsEnvSet("FLOWDB_PROTEUSLOW", "db/proteusLowFlowMeter.db")
epicsEnvSet("IOCTOP", "/reg/g/pcds/package/epics/3.14/ioc/common/thermocube/R1.0.5")
epicsEnvSet("TOP", "/reg/g/pcds/package/epics/3.14/ioc/det/thermocube/R1.0.1/build")
## Add the path to the protocol files
epicsEnvSet("STREAM_PROTOCOL_PATH", "$(IOCTOP)/protocol")

cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/chiller.dbd")
chiller_registerRecordDeviceDriver(pdbbase)
#------------------------------------------------------------------------------
# Asyn support

## Asyn record support
dbLoadRecords("$(ASYN)/db/asynRecord.db","P=DET:CHL:01,R=:asyn,PORT=bus0,ADDR=0,OMAX=0,IMAX=0")
drvAsynIPPortConfigure ("bus0","digi-det-portable1:2001",0,0,0)

# Asyn tracing settings
asynSetTraceMask("bus0", 0, 0x1) # logging for normal operation

# Load record instances
dbLoadRecords( "db/iocSoft.db",             "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db",  "IOC=$(IOC_PV)" )

# Load detetctor chiller control
dbLoadRecords("db/chiller.db", "PRE=DET:CHL:01,bus=0")

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

