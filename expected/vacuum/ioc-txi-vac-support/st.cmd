#!/reg/g/pcds/epics/ioc/common/vacuum/R1.0.5/bin/rhel7-x86_64/vacuum

< envPaths

epicsEnvSet( "ENGINEER" , "Josue Zamudio (jozamudi)" )
epicsEnvSet( "IOCSH_PS1", "ioc-txi-vac-support>" )
epicsEnvSet( "IOCPVROOT", "IOC:TXI:VAC:SUPPORT"   )
epicsEnvSet( "LOCATION",  "TXI")
epicsEnvSet( "IOC_TOP",   "/reg/g/pcds/epics/ioc/common/vacuum/R1.0.5"   )
epicsEnvSet( "TOP",       "/reg/g/pcds/epics/ioc/txi/vacuum/R2.0.0/build"      )
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


drvAsynIPPortConfigure("B940:009:R17:GCT:01", "ser-txi-01:4001 TCP", 0, 0, 0 )
#asynSetTraceMask( "B940:009:R17:GCT:01", 0, 0x19) # log everything
#asynSetTraceIOMask( "B940:009:R17:GCT:01", 0, 2)  # Escape the strings.
dbLoadRecords( "db/asynRecord.db","P=B940:009:R17:GCT:01,R=,PORT=B940:009:R17:GCT:01,ADDR=0,OMAX=0,IMAX=0")
drvAsynIPPortConfigure("B940:009:R17:GCT:02", "ser-txi-01:4002 TCP", 0, 0, 0 )
#asynSetTraceMask( "B940:009:R17:GCT:02", 0, 0x19) # log everything
#asynSetTraceIOMask( "B940:009:R17:GCT:02", 0, 2)  # Escape the strings.
dbLoadRecords( "db/asynRecord.db","P=B940:009:R17:GCT:02,R=,PORT=B940:009:R17:GCT:02,ADDR=0,OMAX=0,IMAX=0")

drvAsynIPPortConfigure("B940:009:R17:PCI:01", "172.21.136.32 TCP", 0, 0, 0 )
#asynSetTraceMask( "B940:009:R17:PCI:01", 0, 0x19) # log everything
#asynSetTraceIOMask( "B940:009:R17:PCI:01", 0, 2)  # Escape the strings.
dbLoadRecords( "db/asynRecord.db","P=B940:009:R17:PCI:01,R=,PORT=B940:009:R17:PCI:01,ADDR=0,OMAX=0,IMAX=0")
drvAsynIPPortConfigure("B940:009:R17:PCI:02", ""172.21.136.33"" TCP", 0, 0, 0 )
#asynSetTraceMask( "B940:009:R17:PCI:02", 0, 0x19) # log everything
#asynSetTraceIOMask( "B940:009:R17:PCI:02", 0, 2)  # Escape the strings.
dbLoadRecords( "db/asynRecord.db","P=B940:009:R17:PCI:02,R=,PORT=B940:009:R17:PCI:02,ADDR=0,OMAX=0,IMAX=0")
drvAsynIPPortConfigure("B940:009:R17:PCI:03", "172.21.136.34 TCP", 0, 0, 0 )
#asynSetTraceMask( "B940:009:R17:PCI:03", 0, 0x19) # log everything
#asynSetTraceIOMask( "B940:009:R17:PCI:03", 0, 2)  # Escape the strings.
dbLoadRecords( "db/asynRecord.db","P=B940:009:R17:PCI:03,R=,PORT=B940:009:R17:PCI:03,ADDR=0,OMAX=0,IMAX=0")
drvAsynIPPortConfigure("B940:009:R17:PCI:04", "172.21.136.35 TCP", 0, 0, 0 )
#asynSetTraceMask( "B940:009:R17:PCI:04", 0, 0x19) # log everything
#asynSetTraceIOMask( "B940:009:R17:PCI:04", 0, 2)  # Escape the strings.
dbLoadRecords( "db/asynRecord.db","P=B940:009:R17:PCI:04,R=,PORT=B940:009:R17:PCI:04,ADDR=0,OMAX=0,IMAX=0")




#------------------------------------------------------------------------------
# Load record instances


dbLoadRecords( "db/vac_mks937b_serial.template", "controller=B940:009:R17:GCT:01,port=B940:009:R17:GCT:01,channel=GCT,addr=253,medEvt=2,slowEvt=3" )
dbLoadRecords( "db/vac_mks937b_serial.template", "controller=B940:009:R17:GCT:02,port=B940:009:R17:GCT:02,channel=GCT,addr=253,medEvt=2,slowEvt=3" )
dbLoadRecords( "db/vac_mks937b_serial_cc.template", "device=TV4K3:GFS:01,port=B940:009:R17:GCT:01,channel=1,addr=253,fastEvt=1,medEvt=2,slowEvt=3,setpointA=$(MKS937B_cc_setA_ch1),setpointB=$(MKS937B_cc_setB_ch1),setpointC=$(MKS937B_cc_setC_ch1),setpointD=$(MKS937B_cc_setD_ch1)" )
dbLoadRecords( "db/vac_mks937b_serial_cc.template", "device=TV4L1:GFS:01,port=B940:009:R17:GCT:02,channel=1,addr=253,fastEvt=1,medEvt=2,slowEvt=3,setpointA=$(MKS937B_cc_setA_ch1),setpointB=$(MKS937B_cc_setB_ch1),setpointC=$(MKS937B_cc_setC_ch1),setpointD=$(MKS937B_cc_setD_ch1)" )

dbLoadRecords( "db/qpc.db", "BASE=B940:009:R17:PCI:01,PORT=B940:009:R17:PCI:01" )
dbLoadRecords( "db/qpc.db", "BASE=B940:009:R17:PCI:02,PORT=B940:009:R17:PCI:02" )
dbLoadRecords( "db/qpc.db", "BASE=B940:009:R17:PCI:03,PORT=B940:009:R17:PCI:03" )
dbLoadRecords( "db/qpc.db", "BASE=B940:009:R17:PCI:04,PORT=B940:009:R17:PCI:04" )
dbLoadRecords( "db/qpc_ch.db", "BASE=TV1K3:PIP:01,PORT=B940:009:R17:PCI:01,CONTROLLER=B940:009:R17:PCI:01,CHANNEL=1,TTLCHAN=5" )
dbLoadRecords( "db/qpc_ch.db", "BASE=ST1K3:PIP:01,PORT=B940:009:R17:PCI:01,CONTROLLER=B940:009:R17:PCI:01,CHANNEL=2,TTLCHAN=6" )
dbLoadRecords( "db/qpc_ch.db", "BASE=PC1K3:PIP:01,PORT=B940:009:R17:PCI:01,CONTROLLER=B940:009:R17:PCI:01,CHANNEL=3,TTLCHAN=7" )
dbLoadRecords( "db/qpc_ch.db", "BASE=PC1K3:PIP:02,PORT=B940:009:R17:PCI:01,CONTROLLER=B940:009:R17:PCI:01,CHANNEL=4,TTLCHAN=8" )
dbLoadRecords( "db/qpc_ch.db", "BASE=TV2k3:PIP:01,PORT=B940:009:R17:PCI:02,CONTROLLER=B940:009:R17:PCI:02,CHANNEL=1,TTLCHAN=5" )
dbLoadRecords( "db/qpc_ch.db", "BASE=TV3K3:PIP:01,PORT=B940:009:R17:PCI:02,CONTROLLER=B940:009:R17:PCI:02,CHANNEL=2,TTLCHAN=6" )
dbLoadRecords( "db/qpc_ch.db", "BASE=TV4k3:PIP:01,PORT=B940:009:R17:PCI:02,CONTROLLER=B940:009:R17:PCI:02,CHANNEL=3,TTLCHAN=7" )
dbLoadRecords( "db/qpc_ch.db", "BASE=ST1L1:PIP:01,PORT=B940:009:R17:PCI:03,CONTROLLER=B940:009:R17:PCI:03,CHANNEL=1,TTLCHAN=5" )
dbLoadRecords( "db/qpc_ch.db", "BASE=PC2L1:PIP:01,PORT=B940:009:R17:PCI:03,CONTROLLER=B940:009:R17:PCI:03,CHANNEL=2,TTLCHAN=6" )
dbLoadRecords( "db/qpc_ch.db", "BASE=TV4L1:PIP:01,PORT=B940:009:R17:PCI:03,CONTROLLER=B940:009:R17:PCI:03,CHANNEL=3,TTLCHAN=7" )
dbLoadRecords( "db/qpc_ch.db", "BASE=TV3L:PIP:01,PORT=B940:009:R17:PCI:03,CONTROLLER=B940:009:R17:PCI:03,CHANNEL=4,TTLCHAN=8" )
dbLoadRecords( "db/qpc_ch.db", "BASE=TV5L1:PIP:01,PORT=B940:009:R17:PCI:04,CONTROLLER=B940:009:R17:PCI:04,CHANNEL=1,TTLCHAN=5" )




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
