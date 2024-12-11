#!/reg/g/pcds/epics/ioc/common/vacuum/R1.0.7/bin/rhel7-x86_64/vacuum

< envPaths

epicsEnvSet( "ENGINEER" , "Nolan Brown (nwbrown)" )
epicsEnvSet( "IOCSH_PS1", "ioc-kfe-vac-support>" )
epicsEnvSet( "IOCPVROOT", "IOC:KFE:VAC:SUPPORT"   )
epicsEnvSet( "LOCATION",  "B940,B930")
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


drvAsynIPPortConfigure("B940:009:R09:GCT:08", "ser-kfe-02:4008 TCP", 0, 0, 0 )
#asynSetTraceMask( "B940:009:R09:GCT:08", 0, 0x19) # log everything
#asynSetTraceIOMask( "B940:009:R09:GCT:08", 0, 2)  # Escape the strings.
dbLoadRecords( "db/asynRecord.db","P=B940:009:R09:GCT:08,R=,PORT=B940:009:R09:GCT:08,ADDR=0,OMAX=0,IMAX=0")
drvAsynIPPortConfigure("B940:009:R09:GCT:09", "ser-kfe-02:4009 TCP", 0, 0, 0 )
#asynSetTraceMask( "B940:009:R09:GCT:09", 0, 0x19) # log everything
#asynSetTraceIOMask( "B940:009:R09:GCT:09", 0, 2)  # Escape the strings.
dbLoadRecords( "db/asynRecord.db","P=B940:009:R09:GCT:09,R=,PORT=B940:009:R09:GCT:09,ADDR=0,OMAX=0,IMAX=0")
drvAsynIPPortConfigure("B940:009:R09:GCT:10", "ser-kfe-02:4010 TCP", 0, 0, 0 )
#asynSetTraceMask( "B940:009:R09:GCT:10", 0, 0x19) # log everything
#asynSetTraceIOMask( "B940:009:R09:GCT:10", 0, 2)  # Escape the strings.
dbLoadRecords( "db/asynRecord.db","P=B940:009:R09:GCT:10,R=,PORT=B940:009:R09:GCT:10,ADDR=0,OMAX=0,IMAX=0")
drvAsynIPPortConfigure("B940:009:R09:GCT:11", "ser-kfe-02:4011 TCP", 0, 0, 0 )
#asynSetTraceMask( "B940:009:R09:GCT:11", 0, 0x19) # log everything
#asynSetTraceIOMask( "B940:009:R09:GCT:11", 0, 2)  # Escape the strings.
dbLoadRecords( "db/asynRecord.db","P=B940:009:R09:GCT:11,R=,PORT=B940:009:R09:GCT:11,ADDR=0,OMAX=0,IMAX=0")

drvAsynIPPortConfigure("B940:009:R09:PCI:01", "pci-kfe-vac-01:23 TCP", 0, 0, 0 )
#asynSetTraceMask( "B940:009:R09:PCI:01", 0, 0x19) # log everything
#asynSetTraceIOMask( "B940:009:R09:PCI:01", 0, 1)  # Escape the strings.
dbLoadRecords( "db/asynRecord.db","P=B940:009:R09:PCI:01,R=,PORT=B940:009:R09:PCI:01,ADDR=0,OMAX=0,IMAX=0")
drvAsynIPPortConfigure("B940:009:R09:PCI:03", "pci-kfe-vac-03:23 TCP", 0, 0, 0 )
#asynSetTraceMask( "B940:009:R09:PCI:03", 0, 0x19) # log everything
#asynSetTraceIOMask( "B940:009:R09:PCI:03", 0, 1)  # Escape the strings.
dbLoadRecords( "db/asynRecord.db","P=B940:009:R09:PCI:03,R=,PORT=B940:009:R09:PCI:03,ADDR=0,OMAX=0,IMAX=0")
drvAsynIPPortConfigure("B940:009:R09:PCI:04", "pci-kfe-vac-04:23 TCP", 0, 0, 0 )
#asynSetTraceMask( "B940:009:R09:PCI:04", 0, 0x19) # log everything
#asynSetTraceIOMask( "B940:009:R09:PCI:04", 0, 1)  # Escape the strings.
dbLoadRecords( "db/asynRecord.db","P=B940:009:R09:PCI:04,R=,PORT=B940:009:R09:PCI:04,ADDR=0,OMAX=0,IMAX=0")
drvAsynIPPortConfigure("B940:009:R09:PCI:06", "pci-kfe-vac-06:23 TCP", 0, 0, 0 )
#asynSetTraceMask( "B940:009:R09:PCI:06", 0, 0x19) # log everything
#asynSetTraceIOMask( "B940:009:R09:PCI:06", 0, 1)  # Escape the strings.
dbLoadRecords( "db/asynRecord.db","P=B940:009:R09:PCI:06,R=,PORT=B940:009:R09:PCI:06,ADDR=0,OMAX=0,IMAX=0")




#------------------------------------------------------------------------------
# Load record instances


dbLoadRecords( "db/vac_mks937b_serial.template", "controller=B940:009:R09:GCT:08,port=B940:009:R09:GCT:08,channel=GCT,addr=253,medEvt=2,slowEvt=3" )
dbLoadRecords( "db/vac_mks937b_serial.template", "controller=B940:009:R09:GCT:09,port=B940:009:R09:GCT:09,channel=GCT,addr=253,medEvt=2,slowEvt=3" )
dbLoadRecords( "db/vac_mks937b_serial.template", "controller=B940:009:R09:GCT:10,port=B940:009:R09:GCT:10,channel=GCT,addr=253,medEvt=2,slowEvt=3" )
dbLoadRecords( "db/vac_mks937b_serial.template", "controller=B940:009:R09:GCT:11,port=B940:009:R09:GCT:11,channel=GCT,addr=253,medEvt=2,slowEvt=3" )
dbLoadRecords( "db/vac_mks937b_serial_cc.template", "device=RTDSK0:GCC:1,port=B940:009:R09:GCT:08,channel=1,addr=253,fastEvt=1,medEvt=2,slowEvt=3,setpointA=$(MKS937B_cc_setA_ch1),setpointB=$(MKS937B_cc_setB_ch1),setpointC=$(MKS937B_cc_setC_ch1),setpointD=$(MKS937B_cc_setD_ch1)" )
dbLoadRecords( "db/vac_mks937b_serial_cc.template", "device=IM1K0:XTES:GCC:1,port=B940:009:R09:GCT:08,channel=3,addr=253,fastEvt=1,medEvt=2,slowEvt=3,setpointA=$(MKS937B_cc_setA_ch3),setpointB=$(MKS937B_cc_setB_ch3),setpointC=$(MKS937B_cc_setC_ch3),setpointD=$(MKS937B_cc_setD_ch3)" )
dbLoadRecords( "db/vac_mks937b_serial_pr.template", "device=RTDSK0:GPI:1,port=B940:009:R09:GCT:08,channel=5,addr=253,fastEvt=1,medEvt=2,slowEvt=3,setpointA=$(MKS937B_pr_setA_ch5),setpointB=$(MKS937B_pr_setB_ch5)" )
dbLoadRecords( "db/vac_mks937b_serial_pr.template", "device=IM1K0:XTES:GPI:1,port=B940:009:R09:GCT:08,channel=6,addr=253,fastEvt=1,medEvt=2,slowEvt=3,setpointA=$(MKS937B_pr_setA_ch6),setpointB=$(MKS937B_pr_setB_ch6)" )
dbLoadRecords( "db/vac_mks937b_serial_cc.template", "device=SL1K0:GCC:1,port=B940:009:R09:GCT:09,channel=1,addr=253,fastEvt=1,medEvt=2,slowEvt=3,setpointA=$(MKS937B_cc_setA_ch1),setpointB=$(MKS937B_cc_setB_ch1),setpointC=$(MKS937B_cc_setC_ch1),setpointD=$(MKS937B_cc_setD_ch1)" )
dbLoadRecords( "db/vac_mks937b_serial_cc.template", "device=PCPM3B:GFS:1,port=B940:009:R09:GCT:09,channel=3,addr=253,fastEvt=1,medEvt=2,slowEvt=3,setpointA=$(MKS937B_cc_setA_ch3),setpointB=$(MKS937B_cc_setB_ch3),setpointC=$(MKS937B_cc_setC_ch3),setpointD=$(MKS937B_cc_setD_ch3)" )
dbLoadRecords( "db/vac_mks937b_serial_pr.template", "device=SL1K0:GPI:1,port=B940:009:R09:GCT:09,channel=5,addr=253,fastEvt=1,medEvt=2,slowEvt=3,setpointA=$(MKS937B_pr_setA_ch5),setpointB=$(MKS937B_pr_setB_ch5)" )
dbLoadRecords( "db/vac_mks937b_serial_cc.template", "device=TV2K0:GCC:1,port=B940:009:R09:GCT:10,channel=1,addr=253,fastEvt=1,medEvt=2,slowEvt=3,setpointA=$(MKS937B_cc_setA_ch1),setpointB=$(MKS937B_cc_setB_ch1),setpointC=$(MKS937B_cc_setC_ch1),setpointD=$(MKS937B_cc_setD_ch1)" )
dbLoadRecords( "db/vac_mks937b_serial_cc.template", "device=TV2K0:GCC:2,port=B940:009:R09:GCT:10,channel=3,addr=253,fastEvt=1,medEvt=2,slowEvt=3,setpointA=$(MKS937B_cc_setA_ch3),setpointB=$(MKS937B_cc_setB_ch3),setpointC=$(MKS937B_cc_setC_ch3),setpointD=$(MKS937B_cc_setD_ch3)" )
dbLoadRecords( "db/vac_mks937b_serial_pr.template", "device=TV2K0:GPI:1,port=B940:009:R09:GCT:10,channel=5,addr=253,fastEvt=1,medEvt=2,slowEvt=3,setpointA=$(MKS937B_pr_setA_ch5),setpointB=$(MKS937B_pr_setB_ch5)" )
dbLoadRecords( "db/vac_mks937b_serial_pr.template", "device=TV2K0:GPI:2,port=B940:009:R09:GCT:10,channel=6,addr=253,fastEvt=1,medEvt=2,slowEvt=3,setpointA=$(MKS937B_pr_setA_ch6),setpointB=$(MKS937B_pr_setB_ch6)" )
dbLoadRecords( "db/vac_mks937b_serial_cc.template", "device=PA1K0:GCC:1,port=B940:009:R09:GCT:11,channel=1,addr=253,fastEvt=1,medEvt=2,slowEvt=3,setpointA=$(MKS937B_cc_setA_ch1),setpointB=$(MKS937B_cc_setB_ch1),setpointC=$(MKS937B_cc_setC_ch1),setpointD=$(MKS937B_cc_setD_ch1)" )
dbLoadRecords( "db/vac_mks937b_serial_cc.template", "device=MR1K1:BEND:GCC:1,port=B940:009:R09:GCT:11,channel=3,addr=253,fastEvt=1,medEvt=2,slowEvt=3,setpointA=$(MKS937B_cc_setA_ch3),setpointB=$(MKS937B_cc_setB_ch3),setpointC=$(MKS937B_cc_setC_ch3),setpointD=$(MKS937B_cc_setD_ch3)" )
dbLoadRecords( "db/vac_mks937b_serial_pr.template", "device=PA1K0:GPI:1,port=B940:009:R09:GCT:11,channel=5,addr=253,fastEvt=1,medEvt=2,slowEvt=3,setpointA=$(MKS937B_pr_setA_ch5),setpointB=$(MKS937B_pr_setB_ch5)" )
dbLoadRecords( "db/vac_mks937b_serial_pr.template", "device=MR1K1:BEND:GPI:1,port=B940:009:R09:GCT:11,channel=6,addr=253,fastEvt=1,medEvt=2,slowEvt=3,setpointA=$(MKS937B_pr_setA_ch6),setpointB=$(MKS937B_pr_setB_ch6)" )

dbLoadRecords( "db/qpc.db", "BASE=B940:009:R09:PCI:01,PORT=B940:009:R09:PCI:01" )
dbLoadRecords( "db/qpc.db", "BASE=B940:009:R09:PCI:03,PORT=B940:009:R09:PCI:03" )
dbLoadRecords( "db/qpc.db", "BASE=B940:009:R09:PCI:04,PORT=B940:009:R09:PCI:04" )
dbLoadRecords( "db/qpc.db", "BASE=B940:009:R09:PCI:06,PORT=B940:009:R09:PCI:06" )
dbLoadRecords( "db/qpc_ch.db", "BASE=RTDSK0:PIP:1,PORT=B940:009:R09:PCI:01,CONTROLLER=B940:009:R09:PCI:01,CHANNEL=1,TTLCHAN=5" )
dbLoadRecords( "db/qpc_ch.db", "BASE=RTDSK0:PIP:2,PORT=B940:009:R09:PCI:01,CONTROLLER=B940:009:R09:PCI:01,CHANNEL=2,TTLCHAN=6" )
dbLoadRecords( "db/qpc_ch.db", "BASE=RTDSK0:PIP:3,PORT=B940:009:R09:PCI:01,CONTROLLER=B940:009:R09:PCI:01,CHANNEL=3,TTLCHAN=7" )
dbLoadRecords( "db/qpc_ch.db", "BASE=RTDSK0:PIP:4,PORT=B940:009:R09:PCI:01,CONTROLLER=B940:009:R09:PCI:01,CHANNEL=4,TTLCHAN=8" )
dbLoadRecords( "db/qpc_ch.db", "BASE=RTDSK0:PIP:5,PORT=B940:009:R09:PCI:03,CONTROLLER=B940:009:R09:PCI:03,CHANNEL=2,TTLCHAN=6" )
dbLoadRecords( "db/qpc_ch.db", "BASE=MR1K1:BEND:PIP:1,PORT=B940:009:R09:PCI:03,CONTROLLER=B940:009:R09:PCI:03,CHANNEL=3,TTLCHAN=7" )
dbLoadRecords( "db/qpc_ch.db", "BASE=MR1K3:TXI:PIP:1,PORT=B940:009:R09:PCI:03,CONTROLLER=B940:009:R09:PCI:03,CHANNEL=4,TTLCHAN=8" )
dbLoadRecords( "db/qpc_ch.db", "BASE=MR2K3:TXI:PIP:1,PORT=B940:009:R09:PCI:04,CONTROLLER=B940:009:R09:PCI:04,CHANNEL=1,TTLCHAN=5" )
dbLoadRecords( "db/qpc_ch.db", "BASE=SP1K1:MONO:PIP:1,PORT=B940:009:R09:PCI:04,CONTROLLER=B940:009:R09:PCI:04,CHANNEL=2,TTLCHAN=6" )
dbLoadRecords( "db/qpc_ch.db", "BASE=SP1K1:MONO:PIP:2,PORT=B940:009:R09:PCI:04,CONTROLLER=B940:009:R09:PCI:04,CHANNEL=3,TTLCHAN=7" )
dbLoadRecords( "db/qpc_ch.db", "BASE=TV3K0:PIP:1,PORT=B940:009:R09:PCI:04,CONTROLLER=B940:009:R09:PCI:04,CHANNEL=4,TTLCHAN=8" )
dbLoadRecords( "db/qpc_ch.db", "BASE=PCPM3B:PIP:1,PORT=B940:009:R09:PCI:06,CONTROLLER=B940:009:R09:PCI:06,CHANNEL=1,TTLCHAN=5" )
dbLoadRecords( "db/qpc_ch.db", "BASE=PA1K0,PORT=B940:009:R09:PCI:06,CONTROLLER=B940:009:R09:PCI:06,CHANNEL=2,TTLCHAN=6" )
dbLoadRecords( "db/qpc_ch.db", "BASE=PA1K0:PIP:1,PORT=B940:009:R09:PCI:03,CONTROLLER=B940:009:R09:PCI:03,CHANNEL=3,TTLCHAN=7" )




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
