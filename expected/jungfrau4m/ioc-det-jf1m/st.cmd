#!/reg/g/pcds/epics/ioc/common/jungfrau4m/R2.0.0/bin/rhel7-x86_64/jungfrau4m

< envPaths
epicsEnvSet("IOCNAME", "ioc-det-jf1m" )
epicsEnvSet("ENGINEER", "Daniel Damiani (ddamiani)" )
epicsEnvSet("LOCATION", "unknown" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "IOC:DET:JF1M")
epicsEnvSet("IOCTOP", "/reg/g/pcds/epics/ioc/common/jungfrau4m/R2.0.0")
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/common/jungfrau4m/R2.0.0/children/build")
epicsEnvSet(streamDebug, 0)
epicsEnvSet("SLSDETDB_JF512k",  "db/jungfrau512k.db")
epicsEnvSet("SLSDETDB_JF1M",    "db/jungfrau1M.db")
epicsEnvSet("SLSDETDB_JF4M",    "db/jungfrau4M.db")
## Add the path to the protocol files
epicsEnvSet("STREAM_PROTOCOL_PATH", "$(IOCTOP)/protocol")

cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/jungfrau4m.dbd")
jungfrau4m_registerRecordDeviceDriver(pdbbase)

# Configure each device
SlsDetConfigure( "DET:JF1M:CTRL", "det-jungfrau-89+det-jungfrau-91+", "32", "2.0" )
#define ASYN_TRACE_ERROR     0x0001
#define ASYN_TRACEIO_DEVICE  0x0002
#define ASYN_TRACEIO_FILTER  0x0004
#define ASYN_TRACEIO_DRIVER  0x0008
#define ASYN_TRACE_FLOW      0x0010
#define ASYN_TRACE_WARNING   0x0020
#asynSetTraceMask( "DET:JF1M:CTRL", 0, 0x3B) # log everything
#asynSetTraceMask( "DET:JF1M:CTRL", 1, 0x3B) # log everything
#define ASYN_TRACEIO_ASCII  0x0001
#define ASYN_TRACEIO_ESCAPE 0x0002
#define ASYN_TRACEIO_HEX    0x0004
#asynSetTraceIOMask( "DET:JF1M:CTRL", 0, 2)  # Escape the strings.
#asynSetTraceIOMask( "DET:JF1M:CTRL", 1, 2)  # Escape the strings.


# Load record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "P=$(IOC_PV):" )
dbLoadRecords( "$(SLSDETDB_JF1M)", "BASE=DET:JF1M,SLSDET=DET:JF1M:CTRL,PORT=DET:JF1M:CTRL,TIMEOUT=2.0" )

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
