#!/reg/g/pcds/epics/ioc/common/vacuum/R1.0.7/bin/rhel7-x86_64/vacuum

< envPaths

epicsEnvSet( "ENGINEER" , "Michael Browne (mcbrowne)" )
epicsEnvSet( "IOCSH_PS1", "ioc-tst-test>" )
epicsEnvSet( "IOCPVROOT", "IOC:TST:VAC"   )
epicsEnvSet( "LOCATION",  "Unknown")
epicsEnvSet( "IOC_TOP",   "/reg/g/pcds/epics/ioc/common/vacuum/R1.0.7"   )
epicsEnvSet( "TOP",       "/reg/g/pcds/epics/ioc/common/vacuum/R1.0.7/children/build"      )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IOC_TOP)/protocol" )
epicsEnvSet( "MKS937A_CHANNEL_1", "CC")
epicsEnvSet( "MKS937A_CHANNEL_2", "A1")
epicsEnvSet( "MKS937A_CHANNEL_3", "A2")
epicsEnvSet( "MKS937A_CHANNEL_4", "B1")
epicsEnvSet( "MKS937A_CHANNEL_5", "B2")
epicsEnvSet( "MKS937B_cc_setA_ch1", 1)
epicsEnvSet( "MKS937B_cc_setB_ch1", 2)
epicsEnvSet( "MKS937B_cc_setC_ch1", 3)
epicsEnvSet( "MKS937B_cc_setD_ch1", 4)
epicsEnvSet( "MKS937B_cc_setA_ch3", 5)
epicsEnvSet( "MKS937B_cc_setB_ch3", 6)
epicsEnvSet( "MKS937B_cc_setC_ch3", 7)
epicsEnvSet( "MKS937B_cc_setD_ch3", 8)
epicsEnvSet( "MKS937B_cc_setA_ch5", 9)
epicsEnvSet( "MKS937B_cc_setB_ch5", 10)
epicsEnvSet( "MKS937B_cc_setC_ch5", 11)
epicsEnvSet( "MKS937B_cc_setD_ch5", 12)
epicsEnvSet( "MKS937B_pr_setA_ch1", 1)
epicsEnvSet( "MKS937B_pr_setB_ch1", 2)
epicsEnvSet( "MKS937B_pr_setA_ch2", 3)
epicsEnvSet( "MKS937B_pr_setB_ch2", 4)
epicsEnvSet( "MKS937B_pr_setA_ch3", 5)
epicsEnvSet( "MKS937B_pr_setB_ch3", 6)
epicsEnvSet( "MKS937B_pr_setA_ch4", 7)
epicsEnvSet( "MKS937B_pr_setB_ch4", 8)
epicsEnvSet( "MKS937B_pr_setA_ch5", 9)
epicsEnvSet( "MKS937B_pr_setB_ch5", 10)
epicsEnvSet( "MKS937B_pr_setA_ch6", 11)
epicsEnvSet( "MKS937B_pr_setB_ch6", 12)

cd( "$(IOC_TOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/vacuum.dbd")
vacuum_registerRecordDeviceDriver(pdbbase)

#------------------------------------------------------------------------------
# Asyn support

# Set this to enable LOTS of stream module diagnostics
#var streamDebug 1

# For asynSetTraceMask
#define ASYN_TRACE_ERROR     0x0001
#define ASYN_TRACEIO_DEVICE  0x0002
#define ASYN_TRACEIO_FILTER  0x0004
#define ASYN_TRACEIO_DRIVER  0x0008
#define ASYN_TRACE_FLOW      0x0010

# For asynSetTraceIOMask
#define ASYN_TRACEIO_ASCII   0x0001
#define ASYN_TRACEIO_ESCAPE  0x0002
#define ASYN_TRACEIO_HEX     0x0004



drvAsynIPPortConfigure("B940:R20:QPC:01", "172.21.132.145:23 TCP", 0, 0, 0 )
#asynSetTraceMask( "B940:R20:QPC:01", 0, 0x19) # log everything
#asynSetTraceIOMask( "B940:R20:QPC:01", 0, 1)  # Escape the strings.
dbLoadRecords( "db/asynRecord.db","P=B940:R20:QPC:01,R=,PORT=B940:R20:QPC:01,ADDR=0,OMAX=0,IMAX=0")




#------------------------------------------------------------------------------
# Load record instances



dbLoadRecords( "db/qpc.db", "BASE=B940:R20:QPC:01,PORT=B940:R20:QPC:01" )
dbLoadRecords( "db/qpc_ch.db", "BASE=TMO:PBT:PIP:09,PORT=B940:R20:QPC:01,CONTROLLER=B940:R20:QPC:01,CHANNEL=1,TTLCHAN=5" )
dbLoadRecords( "db/qpc_ch.db", "BASE=TMO:PBT:PIP:06,PORT=B940:R20:QPC:01,CONTROLLER=B940:R20:QPC:01,CHANNEL=2,TTLCHAN=6" )
dbLoadRecords( "db/qpc_ch.db", "BASE=TMO:PBT:PIP:07,PORT=B940:R20:QPC:01,CONTROLLER=B940:R20:QPC:01,CHANNEL=3,TTLCHAN=7" )




dbLoadRecords( "db/iocSoft.db",			"IOC=$(IOCPVROOT)" )
dbLoadRecords( "db/save_restoreStatus.db",	"P=$(IOCPVROOT):" )

#------------------------------------------------------------------------------
# Setup autosave

set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(TOP)/autosave" )
# Also look in the iocData autosave folder for auto generated req files
set_requestfile_path( "$(IOC_DATA)/$(IOC)/autosave" )
save_restoreSet_status_prefix( "$(IOCPVROOT):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

# Just restore the settings
set_pass0_restoreFile( "autoSettings.sav" )
set_pass0_restoreFile( "$(IOC).sav" )
set_pass1_restoreFile( "autoSettings.sav" )
set_pass1_restoreFile( "$(IOC).sav" )

# Initialize the IOC and start processing records
iocInit()

# Create autosave files from info directives
makeAutosaveFileFromDbInfo( "$(IOC_DATA)/$(IOC)/autosave/autoSettings.req", "autosaveFields" )

# Start autosave backups
create_monitor_set( "autoSettings.req", 5, "" )
create_monitor_set( "$(IOC).req", 5, "" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
