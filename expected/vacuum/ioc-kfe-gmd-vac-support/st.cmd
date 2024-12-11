#!/reg/g/pcds/epics/ioc/common/vacuum/R1.0.7/bin/rhel7-x86_64/vacuum

< envPaths

epicsEnvSet( "ENGINEER" , "Nolan Brown (nwbrown)" )
epicsEnvSet( "IOCSH_PS1", "ioc-kfe-gmd-vac-support>" )
epicsEnvSet( "IOCPVROOT", "IOC:KFE:GMD:VAC:SUPPORT"   )
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


drvAsynIPPortConfigure("B940:009:R08:GCT:01", "ser-kfe-01:4001 TCP", 0, 0, 0 )
#asynSetTraceMask( "B940:009:R08:GCT:01", 0, 0x19) # log everything
#asynSetTraceIOMask( "B940:009:R08:GCT:01", 0, 2)  # Escape the strings.
dbLoadRecords( "db/asynRecord.db","P=B940:009:R08:GCT:01,R=,PORT=B940:009:R08:GCT:01,ADDR=0,OMAX=0,IMAX=0")
drvAsynIPPortConfigure("B930:007:WALL:NE:GCT:01", "ser-kfe-gmd-02:2101 TCP", 0, 0, 0 )
#asynSetTraceMask( "B930:007:WALL:NE:GCT:01", 0, 0x19) # log everything
#asynSetTraceIOMask( "B930:007:WALL:NE:GCT:01", 0, 2)  # Escape the strings.
dbLoadRecords( "db/asynRecord.db","P=B930:007:WALL:NE:GCT:01,R=,PORT=B930:007:WALL:NE:GCT:01,ADDR=0,OMAX=0,IMAX=0")
drvAsynIPPortConfigure("B940:009:R08:GCT:02", "ser-kfe-01:4002 TCP", 0, 0, 0 )
#asynSetTraceMask( "B940:009:R08:GCT:02", 0, 0x19) # log everything
#asynSetTraceIOMask( "B940:009:R08:GCT:02", 0, 2)  # Escape the strings.
dbLoadRecords( "db/asynRecord.db","P=B940:009:R08:GCT:02,R=,PORT=B940:009:R08:GCT:02,ADDR=0,OMAX=0,IMAX=0")
drvAsynIPPortConfigure("B940:009:R08:GCT:03", "ser-kfe-01:4003 TCP", 0, 0, 0 )
#asynSetTraceMask( "B940:009:R08:GCT:03", 0, 0x19) # log everything
#asynSetTraceIOMask( "B940:009:R08:GCT:03", 0, 2)  # Escape the strings.
dbLoadRecords( "db/asynRecord.db","P=B940:009:R08:GCT:03,R=,PORT=B940:009:R08:GCT:03,ADDR=0,OMAX=0,IMAX=0")


drvAsynIPPortConfigure("EM1K0:GMD:PCT:10", "ser-kfe-05:4001 TCP", 0, 0, 0 )
#asynSetTraceMask( "EM1K0:GMD:PCT:10", 0, 0x19) # log everything
#asynSetTraceIOMask( "EM1K0:GMD:PCT:10", 0, 2)  # Escape the strings.
dbLoadRecords( "db/asynRecord.db","P=EM1K0:GMD:PCT:10,R=,PORT=EM1K0:GMD:PCT:10,ADDR=0,OMAX=0,IMAX=0")
drvAsynIPPortConfigure("EM1K0:GMD:PCT:20", "ser-kfe-05:4002 TCP", 0, 0, 0 )
#asynSetTraceMask( "EM1K0:GMD:PCT:20", 0, 0x19) # log everything
#asynSetTraceIOMask( "EM1K0:GMD:PCT:20", 0, 2)  # Escape the strings.
dbLoadRecords( "db/asynRecord.db","P=EM1K0:GMD:PCT:20,R=,PORT=EM1K0:GMD:PCT:20,ADDR=0,OMAX=0,IMAX=0")
drvAsynIPPortConfigure("EM1K0:GMD:PCT:30", "ser-kfe-05:4003 TCP", 0, 0, 0 )
#asynSetTraceMask( "EM1K0:GMD:PCT:30", 0, 0x19) # log everything
#asynSetTraceIOMask( "EM1K0:GMD:PCT:30", 0, 2)  # Escape the strings.
dbLoadRecords( "db/asynRecord.db","P=EM1K0:GMD:PCT:30,R=,PORT=EM1K0:GMD:PCT:30,ADDR=0,OMAX=0,IMAX=0")
drvAsynIPPortConfigure("EM1K0:GMD:PCT:40", "ser-kfe-05:4004 TCP", 0, 0, 0 )
#asynSetTraceMask( "EM1K0:GMD:PCT:40", 0, 0x19) # log everything
#asynSetTraceIOMask( "EM1K0:GMD:PCT:40", 0, 2)  # Escape the strings.
dbLoadRecords( "db/asynRecord.db","P=EM1K0:GMD:PCT:40,R=,PORT=EM1K0:GMD:PCT:40,ADDR=0,OMAX=0,IMAX=0")
drvAsynIPPortConfigure("EM1K0:GMD:PCT:50", "ser-kfe-05:4005 TCP", 0, 0, 0 )
#asynSetTraceMask( "EM1K0:GMD:PCT:50", 0, 0x19) # log everything
#asynSetTraceIOMask( "EM1K0:GMD:PCT:50", 0, 2)  # Escape the strings.
dbLoadRecords( "db/asynRecord.db","P=EM1K0:GMD:PCT:50,R=,PORT=EM1K0:GMD:PCT:50,ADDR=0,OMAX=0,IMAX=0")
drvAsynIPPortConfigure("EM1K0:GMD:PCT:60", "ser-kfe-05:4006 TCP", 0, 0, 0 )
#asynSetTraceMask( "EM1K0:GMD:PCT:60", 0, 0x19) # log everything
#asynSetTraceIOMask( "EM1K0:GMD:PCT:60", 0, 2)  # Escape the strings.
dbLoadRecords( "db/asynRecord.db","P=EM1K0:GMD:PCT:60,R=,PORT=EM1K0:GMD:PCT:60,ADDR=0,OMAX=0,IMAX=0")
drvAsynIPPortConfigure("EM1K0:GMD:PCT:70", "ser-kfe-05:4007 TCP", 0, 0, 0 )
#asynSetTraceMask( "EM1K0:GMD:PCT:70", 0, 0x19) # log everything
#asynSetTraceIOMask( "EM1K0:GMD:PCT:70", 0, 2)  # Escape the strings.
dbLoadRecords( "db/asynRecord.db","P=EM1K0:GMD:PCT:70,R=,PORT=EM1K0:GMD:PCT:70,ADDR=0,OMAX=0,IMAX=0")


drvAsynIPPortConfigure("EM1K0:GMD:GSR:1", "ser-kfe-gmd-01:2102 TCP", 0, 0, 0 )
#asynSetTraceMask( "EM1K0:GMD:GSR:1", 0, 0x19) # log everything
#asynSetTraceIOMask( "EM1K0:GMD:GSR:1", 0, 2)  # Escape the strings.
dbLoadRecords( "db/asynRecord.db","P=EM1K0:GMD:GSR:1,R=,PORT=EM1K0:GMD:GSR:1,ADDR=0,OMAX=0,IMAX=0")

#------------------------------------------------------------------------------
# Load record instances


dbLoadRecords( "db/vac_mks937b_serial.template", "controller=B940:009:R08:GCT:01,port=B940:009:R08:GCT:01,channel=GCT,addr=253,medEvt=2,slowEvt=3" )
dbLoadRecords( "db/vac_mks937b_serial.template", "controller=B930:007:WALL:NE:GCT:01,port=B930:007:WALL:NE:GCT:01,channel=GCT,addr=253,medEvt=2,slowEvt=3" )
dbLoadRecords( "db/vac_mks937b_serial.template", "controller=B940:009:R08:GCT:02,port=B940:009:R08:GCT:02,channel=GCT,addr=253,medEvt=2,slowEvt=3" )
dbLoadRecords( "db/vac_mks937b_serial.template", "controller=B940:009:R08:GCT:03,port=B940:009:R08:GCT:03,channel=GCT,addr=253,medEvt=2,slowEvt=3" )
dbLoadRecords( "db/vac_mks937b_serial_cc.template", "device=EM1K0:GMD:GCC:10,port=B940:009:R08:GCT:01,channel=1,addr=253,fastEvt=1,medEvt=2,slowEvt=3,setpointA=$(MKS937B_cc_setA_ch1),setpointB=$(MKS937B_cc_setB_ch1),setpointC=$(MKS937B_cc_setC_ch1),setpointD=$(MKS937B_cc_setD_ch1)" )
dbLoadRecords( "db/vac_mks937b_serial_cc.template", "device=EM1K0:GMD:GCC:20,port=B940:009:R08:GCT:01,channel=3,addr=253,fastEvt=1,medEvt=2,slowEvt=3,setpointA=$(MKS937B_cc_setA_ch3),setpointB=$(MKS937B_cc_setB_ch3),setpointC=$(MKS937B_cc_setC_ch3),setpointD=$(MKS937B_cc_setD_ch3)" )
dbLoadRecords( "db/vac_mks937b_serial_cc.template", "device=EM1K0:GMD:GCC:30,port=B940:009:R08:GCT:01,channel=5,addr=253,fastEvt=1,medEvt=2,slowEvt=3,setpointA=$(MKS937B_cc_setA_ch5),setpointB=$(MKS937B_cc_setB_ch5),setpointC=$(MKS937B_cc_setC_ch5),setpointD=$(MKS937B_cc_setD_ch5)" )
dbLoadRecords( "db/vac_mks937b_serial_cc.template", "device=EM1K0:GMD:GCC:40,port=B930:007:WALL:NE:GCT:01,channel=3,addr=253,fastEvt=1,medEvt=2,slowEvt=3,setpointA=$(MKS937B_cc_setA_ch3),setpointB=$(MKS937B_cc_setB_ch3),setpointC=$(MKS937B_cc_setC_ch3),setpointD=$(MKS937B_cc_setD_ch3)" )
dbLoadRecords( "db/vac_mks937b_serial_pr.template", "device=EM1K0:GMD:GPI:40,port=B930:007:WALL:NE:GCT:01,channel=5,addr=253,fastEvt=1,medEvt=2,slowEvt=3,setpointA=$(MKS937B_pr_setA_ch5),setpointB=$(MKS937B_pr_setB_ch5)" )
dbLoadRecords( "db/vac_mks937b_serial_pr.template", "device=EM1K0:GMD:GPI:10,port=B930:007:WALL:NE:GCT:01,channel=6,addr=253,fastEvt=1,medEvt=2,slowEvt=3,setpointA=$(MKS937B_pr_setA_ch6),setpointB=$(MKS937B_pr_setB_ch6)" )
dbLoadRecords( "db/vac_mks937b_serial_cc.template", "device=EM1K0:GMD:GCC:50,port=B940:009:R08:GCT:02,channel=1,addr=253,fastEvt=1,medEvt=2,slowEvt=3,setpointA=$(MKS937B_cc_setA_ch1),setpointB=$(MKS937B_cc_setB_ch1),setpointC=$(MKS937B_cc_setC_ch1),setpointD=$(MKS937B_cc_setD_ch1)" )
dbLoadRecords( "db/vac_mks937b_serial_cc.template", "device=EM1K0:GMD:GCC:60,port=B940:009:R08:GCT:02,channel=3,addr=253,fastEvt=1,medEvt=2,slowEvt=3,setpointA=$(MKS937B_cc_setA_ch3),setpointB=$(MKS937B_cc_setB_ch3),setpointC=$(MKS937B_cc_setC_ch3),setpointD=$(MKS937B_cc_setD_ch3)" )
dbLoadRecords( "db/vac_mks937b_serial_pr.template", "device=EM1K0:GMD:GPI:70,port=B940:009:R08:GCT:02,channel=6,addr=253,fastEvt=1,medEvt=2,slowEvt=3,setpointA=$(MKS937B_pr_setA_ch6),setpointB=$(MKS937B_pr_setB_ch6)" )
dbLoadRecords( "db/vac_mks937b_serial_cc.template", "device=EM1K0:GMD:GCC:70,port=B940:009:R08:GCT:03,channel=1,addr=253,fastEvt=1,medEvt=2,slowEvt=3,setpointA=$(MKS937B_cc_setA_ch1),setpointB=$(MKS937B_cc_setB_ch1),setpointC=$(MKS937B_cc_setC_ch1),setpointD=$(MKS937B_cc_setD_ch1)" )


dbLoadRecords( "db/twistorr_ro.db", "BASE=EM1K0:GMD:PCT:10,PORT=EM1K0:GMD:PCT:10" )
dbLoadRecords( "db/twistorr_ro.db", "BASE=EM1K0:GMD:PCT:20,PORT=EM1K0:GMD:PCT:20" )
dbLoadRecords( "db/twistorr_ro.db", "BASE=EM1K0:GMD:PCT:30,PORT=EM1K0:GMD:PCT:30" )
dbLoadRecords( "db/twistorr_ro.db", "BASE=EM1K0:GMD:PCT:40,PORT=EM1K0:GMD:PCT:40" )
dbLoadRecords( "db/twistorr_ro.db", "BASE=EM1K0:GMD:PCT:50,PORT=EM1K0:GMD:PCT:50" )
dbLoadRecords( "db/twistorr_ro.db", "BASE=EM1K0:GMD:PCT:60,PORT=EM1K0:GMD:PCT:60" )
dbLoadRecords( "db/twistorr_ro.db", "BASE=EM1K0:GMD:PCT:70,PORT=EM1K0:GMD:PCT:70" )


dbLoadRecords( "db/srg.db", "BASE=EM1K0:GMD:GSR:1,PORT=EM1K0:GMD:GSR:1" )
dbLoadRecords("db/srg_temp.db", "BASE=EM1K0:GMD:GSR:1,TEMP=EM1K0:GMD:RTD:1:TEMP_RBV")

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
