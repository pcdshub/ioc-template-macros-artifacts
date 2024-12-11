#!/reg/g/pcds/epics/ioc/common/jungfrau4m/R2.0.0/bin/rhel7-x86_64/jungfrau4m

< envPaths
epicsEnvSet("IOCNAME", "ioc-tst-jf4m-pwr" )
epicsEnvSet("ENGINEER", "Daniel Damiani (ddamiani)" )
epicsEnvSet("LOCATION", "unknown" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "IOC:TST:JF4M:PWR")
epicsEnvSet("IOCTOP", "/reg/g/pcds/epics/ioc/common/jungfrau4m/R2.0.0")
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/common/jungfrau4m/R2.0.0/children/build")
epicsEnvSet(streamDebug, 0)
## Add the path to the protocol files
epicsEnvSet("STREAM_PROTOCOL_PATH", "$(IOCTOP)/protocol")

cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/jungfrau4m.dbd")
jungfrau4m_registerRecordDeviceDriver(pdbbase)

# Configure each device
drvAsynIPPortConfigure( "TST:JF4M:PWR", "daq-det-standalone:32415 TCP", 0, 0, 0 )
#define ASYN_TRACE_ERROR     0x0001
#define ASYN_TRACEIO_DEVICE  0x0002
#define ASYN_TRACEIO_FILTER  0x0004
#define ASYN_TRACEIO_DRIVER  0x0008
#define ASYN_TRACE_FLOW      0x0010
#asynSetTraceMask( "TST:JF4M:PWR", 0, 0x19) # log everything
#define ASYN_TRACEIO_ASCII  0x0001
#define ASYN_TRACEIO_ESCAPE 0x0002
#define ASYN_TRACEIO_HEX    0x0004
#asynSetTraceIOMask( "TST:JF4M:PWR", 0, 2)  # Escape the strings.

# Load record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "P=$(IOC_PV):" )
dbLoadRecords( "db/jfpower.db", "BASE=TST:JF4M,JFPWR=TST:JF4M:PWR,JFCTRL=TST:JF4M:CTRL,PORT=TST:JF4M:PWR" )
dbLoadRecords( "db/aggregate.db", "NAME=TST:JF4M:BME280:ALL:INTERLOCK")
dbLoadRecords( "db/aggregate.db", "NAME=TST:JF4M:PWR:INTERLOCK,INPK=TST:JF4M:PWR:BLOCKED,INPL=TST:JF4M:BME280:ALL:INTERLOCK CPP NMS")

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
