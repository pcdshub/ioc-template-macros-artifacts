#!$$IOCTOP/bin/$$IF(ARCH,$$ARCH,linux-x86_64)/vacuum

< envPaths

epicsEnvSet( "ENGINEER" , "$$ENGINEER" )
epicsEnvSet( "IOCSH_PS1", "$$IOCNAME>" )
epicsEnvSet( "IOCPVROOT", "$$IOC_PV"   )
epicsEnvSet( "LOCATION",  "$$IF(LOCATION,$$LOCATION,$$IOC_PV)")
epicsEnvSet( "IOC_TOP",   "$$IOCTOP"   )
epicsEnvSet( "TOP",       "$$TOP"      )
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

$$LOOP(MKS937A)
drvAsynIPPortConfigure("$$BASE", "$$PORT TCP", 0, 0, 0 )
$$IF(DEBUG,,#)asynSetTraceMask( "$$BASE", 0, 0x19) # log everything
$$IF(DEBUG,,#)asynSetTraceIOMask( "$$BASE", 0, 2)  # Escape the strings.
dbLoadRecords( "db/asynRecord.db","P=$$BASE,R=,PORT=$$BASE,ADDR=0,OMAX=0,IMAX=0")
$$ENDLOOP(MKS937A)

$$LOOP(MKS937B)
drvAsynIPPortConfigure("$$BASE", "$$PORT TCP", 0, 0, 0 )
$$IF(DEBUG,,#)asynSetTraceMask( "$$BASE", 0, 0x19) # log everything
$$IF(DEBUG,,#)asynSetTraceIOMask( "$$BASE", 0, 2)  # Escape the strings.
dbLoadRecords( "db/asynRecord.db","P=$$BASE,R=,PORT=$$BASE,ADDR=0,OMAX=0,IMAX=0")
$$ENDLOOP(MKS937B)

$$LOOP(QPC)
drvAsynIPPortConfigure("$$BASE", "$$PORT TCP", 0, 0, 0 )
$$IF(DEBUG,,#)asynSetTraceMask( "$$BASE", 0, 0x19) # log everything
$$IF(DEBUG,,#)asynSetTraceIOMask( "$$BASE", 0, 2)  # Escape the strings.
dbLoadRecords( "db/asynRecord.db","P=$$BASE,R=,PORT=$$BASE,ADDR=0,OMAX=0,IMAX=0")
$$ENDLOOP(QPC)

$$LOOP(TWISTORR)
drvAsynIPPortConfigure("$$BASE", "$$PORT TCP", 0, 0, 0 )
$$IF(DEBUG,,#)asynSetTraceMask( "$$BASE", 0, 0x19) # log everything
$$IF(DEBUG,,#)asynSetTraceIOMask( "$$BASE", 0, 2)  # Escape the strings.
dbLoadRecords( "db/asynRecord.db","P=$$BASE,R=,PORT=$$BASE,ADDR=0,OMAX=0,IMAX=0")
$$ENDLOOP(TWISTORR)

$$LOOP(NAVIGATOR)
drvAsynIPPortConfigure("$$BASE", "$$PORT TCP", 0, 0, 0 )
$$IF(DEBUG,,#)asynSetTraceMask( "$$BASE", 0, 0x19) # log everything
$$IF(DEBUG,,#)asynSetTraceIOMask( "$$BASE", 0, 2)  # Escape the strings.
dbLoadRecords( "db/asynRecord.db","P=$$BASE,R=,PORT=$$BASE,ADDR=0,OMAX=0,IMAX=0")
$$ENDLOOP(NAVIGATOR)

$$LOOP(SRG)
drvAsynIPPortConfigure("$$BASE", "$$PORT TCP", 0, 0, 0 )
$$IF(DEBUG,,#)asynSetTraceMask( "$$BASE", 0, 0x19) # log everything
$$IF(DEBUG,,#)asynSetTraceIOMask( "$$BASE", 0, 2)  # Escape the strings.
dbLoadRecords( "db/asynRecord.db","P=$$BASE,R=,PORT=$$BASE,ADDR=0,OMAX=0,IMAX=0")
$$ENDLOOP(SRG)

#------------------------------------------------------------------------------
# Load record instances

$$LOOP(MKS937A)
dbLoadRecords( "db/vac_mks937a_serial.template", "controller=$$BASE,port=$$BASE,slowEvt=3,phase=9" )
$$ENDLOOP(MKS937A)
$$LOOP(MKS937A_SLOT)
dbLoadRecords( "db/vac_mks937a_serial_$$TYPE.template", "device=$$BASE,port=$$MKS937ABASE,channel=$$CHANNEL,slot=$(MKS937A_CHANNEL_$$CHANNEL),fastEvt=1,medEvt=2,slowEvt=3" )
$$ENDLOOP(MKS937A_SLOT)

$$LOOP(MKS937B)
dbLoadRecords( "db/vac_mks937b_serial.template", "controller=$$BASE,port=$$BASE,channel=GCT,addr=253,medEvt=2,slowEvt=3" )
$$ENDLOOP(MKS937B)
$$LOOP(MKS937B_SLOT)
dbLoadRecords( "db/vac_mks937b_serial_$$TYPE.template", "device=$$BASE,port=$$MKS937BBASE,channel=$$CHANNEL,addr=253,fastEvt=1,medEvt=2,slowEvt=3,setpointA=$(MKS937B_$$(TYPE)_setA_ch$$CHANNEL),setpointB=$(MKS937B_$$(TYPE)_setB_ch$$CHANNEL)$$IF(TYPE,cc),setpointC=$(MKS937B_$$(TYPE)_setC_ch$$CHANNEL),setpointD=$(MKS937B_$$(TYPE)_setD_ch$$CHANNEL)$$ENDIF(TYPE)" )
$$ENDLOOP(MKS937B_SLOT)

$$LOOP(QPC)
dbLoadRecords( "db/qpc.db", "BASE=$$BASE,PORT=$$BASE" )
$$ENDLOOP(QPC)
$$LOOP(QPC_SLOT)
dbLoadRecords( "db/qpc_ch.db", "BASE=$$BASE,PORT=$$QPCBASE,CONTROLLER=$$QPCBASE,CHANNEL=$$CHANNEL,TTLCHAN=$$CALC{4+$$CHANNEL}" )
$$ENDLOOP(QPC_SLOT)

$$LOOP(TWISTORR)
dbLoadRecords( "db/twistorr_ro.db", "BASE=$$BASE,PORT=$$BASE" )
$$IF(READONLY)$$ELSE(READONLY)
dbLoadRecords( "db/twistorr.db", "BASE=$$BASE,PORT=$$BASE" )
$$ENDIF(READONLY)
$$ENDLOOP(TWISTORR)

$$LOOP(NAVIGATOR)
dbLoadRecords( "db/navigator.db", "BASE=$$BASE,PORT=$$BASE" )
$$ENDLOOP(NAVIGATOR)

$$LOOP(SRG)
dbLoadRecords( "db/srg.db", "BASE=$$BASE,PORT=$$BASE" )
$$IF(TEMP)
dbLoadRecords("db/srg_temp.db", "BASE=$$BASE,TEMP=$$TEMP")
$$ENDIF(TEMP)
$$ENDLOOP(SRG)

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
