#!/reg/g/pcds/epics/ioc/common/dg/R3.0.0/bin/rhel7-x86_64/delaygenApp


< envPaths

epicsEnvSet( "ENGINEER" , "Michael Browne" )
epicsEnvSet( "IOCSH_PS1", "ioc-mec-delaygen1>" )
epicsEnvSet( "IOCENAME",  "IOC:MEC:DELAYGEN1" )
epicsEnvSet( "IOCPVROOT", "MEC:LAS:IOC:DDG")
epicsEnvSet( "LOCATION",  "MEC:M64A:42")
epicsEnvSet( "IP",        "delaygen-mec-01"       )
epicsEnvSet( "DG",        "MEC:LAS:DDG:01"     )
epicsEnvSet( "IOC_TOP",   "/reg/g/pcds/epics/ioc/common/dg/R3.0.0"   )
epicsEnvSet( "TOP",       "/reg/g/pcds/epics/ioc/mec/dg/R3.0.0/build"      )

cd( "$(IOC_TOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/delaygenApp.dbd")
delaygenApp_registerRecordDeviceDriver(pdbbase)

#------------------------------------------------------------------------------
# Asyn support

## Asyn record support
dbLoadRecords( "db/asynRecord.db","P=$(DG),R=,PORT=$(IP),ADDR=0,OMAX=0,IMAX=0")

# Initialize IP Asyn support, configure logging before enabling autoconnect
drvAsynIPPortConfigure("$(IP)","$(IP):5024",0,1,0)
asynSetTraceFile( "$(IP)", 0, "$(IOC_DATA)/$(IOC)/iocInfo/asyn.log" )

#define ASYN_TRACE_ERROR     0x0001
#define ASYN_TRACEIO_DEVICE  0x0002
#define ASYN_TRACEIO_FILTER  0x0004
#define ASYN_TRACEIO_DRIVER  0x0008
#define ASYN_TRACE_FLOW      0x0010
asynSetTraceMask( "$(IP)", 0, 0xff) # log everything

asynAutoConnect("$(IP)", 0, 1)
epicsThreadSleep(0.01) # give autoconnect time, or other asyn commands fail.

# Initialize input/output EOS
asynOctetSetOutputEos("$(IP)",0,"\n")
asynOctetSetInputEos("$(IP)",0,"\r\n")

# Disable error messages from asyn, don't fill up log files if drvAsynDG645 fails.
asynSetTraceMask("$(IP)", 0, 0x0)

# Turn autoconnect off now that we've connected or failed. The DG645 related code will
# crash if the DG645 is disconnected from the network while autoConnect is enabled.
# However, it will re-establish the connection with no problems if autoConnect is off.
asynAutoConnect("$(IP)", 0, 0)

### Stanford Research Systems (SRS) DG645
## drvAsynDG645(myport,ioport,ioaddr)
#       myport  - Interface asyn port name (i.e. "DG0")
#       ioport  - Comm asyn port name (i.e. "L2")
#       ioaddr  - Comm asyn port addr
#
drvAsynDG645("$(DG)","$(IP)",-1);
asynSetTraceMask("$(IP)", 0, 0x5)

# Load record instances
dbLoadRecords( "db/drvDG645.db",            "DG=$(DG),PORT=$(DG)")
dbLoadRecords( "db/iocSoft.db",			"IOC=$(IOCENAME)" )
dbLoadRecords( "db/save_restoreStatus.db",	"P=$(IOCPVROOT)" )

# Setup autosave
set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(IOC_TOP)/autosave" )
save_restoreSet_status_prefix( "$(IOCPVROOT):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )
set_pass0_restoreFile( "autosave_delaygen.sav" )
set_pass1_restoreFile( "autosave_delaygen.sav" )

# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set( "autosave_delaygen.req", 5, "IOC=$(IOCPVROOT),DG=$(DG)" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
