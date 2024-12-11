#!/reg/g/pcds/package/epics/3.14/ioc/common/thermocube/R1.0.0/bin/linux-x86_64/chiller

< envPaths
epicsEnvSet("IOCNAME", "ioc-xpp-detchiller" )
epicsEnvSet("ENGINEER", "Daniel Damiani (ddamiani)" )
epicsEnvSet("LOCATION", "XPP:MOB:CHL:IOC" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "XPP:MOB:CHL:IOC")
epicsEnvSet("FLOWDB_CUBIC",   "db/cubicEX30AR-V.db")
epicsEnvSet("FLOWDB_PROTEUS", "db/proteusFlowMeter.db")
epicsEnvSet("IOCTOP", "/reg/g/pcds/package/epics/3.14/ioc/common/thermocube/R1.0.0")
epicsEnvSet("TOP", "/reg/g/pcds/package/epics/3.14/ioc/xpp/thermocube/R1.0.0/build")
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
dbLoadRecords("$(ASYN)/db/asynRecord.db","P=XPP:MOB:CHL,R=:asyn,PORT=bus0,ADDR=0,OMAX=0,IMAX=0")
drvAsynIPPortConfigure ("bus0","digi-xpp-14:2016",0,0,0)
asynSetTraceFile( "bus0", 0, "$(IOC_DATA)$(IOCNAME)/iocInfo/asyn0.log" )

#/* traceMask definitions*/
#define ASYN_TRACE_ERROR     0x0001
#define ASYN_TRACEIO_DEVICE  0x0002
#define ASYN_TRACEIO_FILTER  0x0004
#define ASYN_TRACEIO_DRIVER  0x0008
#define ASYN_TRACE_FLOW      0x0010
asynSetTraceMask( "bus0", 0, 0x1f) # log everything

#/* traceIO mask definitions*/
#define ASYN_TRACEIO_NODATA 0x0000
#define ASYN_TRACEIO_ASCII  0x0001
#define ASYN_TRACEIO_ESCAPE 0x0002
#define ASYN_TRACEIO_HEX    0x0004
asynSetTraceIOMask( "bus0", 0, 0x6)

# Load record instances
dbLoadRecords( "db/iocSoft.db",             "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db",  "IOC=$(IOC_PV)" )

# Load detetctor chiller control
dbLoadRecords("db/chiller.db", "PRE=XPP:MOB:CHL,bus=0")

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

# Tone down the asyn logging for normal operation
asynSetTraceMask("bus0", 0, 0x1)

