#!/reg/g/pcds/package/epics/3.14/ioc/common/eDrive/R0.1.2/bin/linux-x86_64/eDrive


< envPaths

epicsEnvSet( "ENGINEER" , "tjohnson" )
epicsEnvSet( "IOCSH_PS1", "ioc-mec-lpl-lco-02>" )
epicsEnvSet( "IOCENAME", "IOC:MEC:LPL:LCO:02" )
epicsEnvSet( "IOCPVROOT", "MEC:LPL:LCO:IOC:02")
epicsEnvSet( "LOCATION",  "MEC:LPL:LCO:IOC:02")
epicsEnvSet( "IP",        "172.21.76.193"       )
epicsEnvSet( "IP_PORT",	  "502"     )
epicsEnvSet( "BASE_NAME", "MEC:LPL:LCO:02"     )
epicsEnvSet( "IOC_TOP",    "/reg/g/pcds/package/epics/3.14/ioc/common/eDrive/R0.1.2"   )
epicsEnvSet( "TOP",       "/reg/g/pcds/epics/ioc/mec/eDrive/R0.1.4/build"      )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IOC_TOP)/eDriveApp/srcProtocol" )

cd( "$(IOC_TOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/eDrive.dbd")
eDrive_registerRecordDeviceDriver(pdbbase)

#------------------------------------------------------------------------------
# Asyn support

# Set this to enable LOTS of stream module diagnostics
#var streamDebug 1

# Initialize IP Asyn support, configure logging before enabling autoconnect
drvAsynIPPortConfigure("$(BASE_NAME)","$(IP):$(IP_PORT)", 0, 0, 0)
asynSetTraceFile( "$(BASE_NAME)", 0, "$(IOC_DATA)$(IOC)/iocInfo/asyn.log" )

#define ASYN_TRACE_ERROR     0x0001
#define ASYN_TRACEIO_DEVICE  0x0002
#define ASYN_TRACEIO_FILTER  0x0004
#define ASYN_TRACEIO_DRIVER  0x0008
#define ASYN_TRACE_FLOW      0x0010
asynSetTraceMask( "$(BASE_NAME)", 0, 0xff) # log everything
#asynSetTraceIOMask( "$(BASE_NAME)", 0, 4)

## Asyn record support
dbLoadRecords( "db/asynRecord.db","P=$(BASE_NAME),R=,PORT=$(BASE_NAME),ADDR=0,OMAX=0,IMAX=0")

asynAutoConnect("$(BASE_NAME)", 0, 1)
epicsThreadSleep(0.01) # give autoconnect time, or other asyn commands fail.

# Disable error messages from asyn.
asynSetTraceMask("$(BASE_NAME)", 0, 0x0)

# MODBUS configuration
#modbusInterposeConfig(portName,
#                      linkType,
#                      timeoutMsec,
#                      writeDelayMsec)
modbusInterposeConfig("$(BASE_NAME)", 0, 3500, 0)

#drvModbusAsynConfigure(portName,
#                       tcpPortName,
#                       slaveAddress,
#                       modbusFunction,
#                       modbusStartAddress,
#                       modbusLength,
#                       dataType,
#                       pollMsec,
#                       plcType)
drvModbusAsynConfigure("readWriteableBits", "$(BASE_NAME)", 1, 1, 0, 57, 0, 500, "eDrive")
drvModbusAsynConfigure("writeBit", "$(BASE_NAME)", 1, 5, 0, 57, 0, 500, "eDrive")
drvModbusAsynConfigure("readOnlyBits", "$(BASE_NAME)", 1, 2, 0, 118, 0, 500, "eDrive")
drvModbusAsynConfigure("ReadChannel1Info", "$(BASE_NAME)", 1, 3, 16, 7, 0, 500, "eDrive")
drvModbusAsynConfigure("WriteChannel1Info", "$(BASE_NAME)", 1, 16, 16, 7, 0, 500, "eDrive")
drvModbusAsynConfigure("ReadOnlyChannel1Info", "$(BASE_NAME)", 1, 4, 19, 3, 0, 500, "eDrive")

#------------------------------------------------------------------------------
# Load record instances

dbLoadRecords( "db/eDriveDevice.db",           	"P=$(BASE_NAME)" )
dbLoadRecords( "db/iocAdmin.db",		"IOC=$(IOCENAME)" )
dbLoadRecords( "db/save_restoreStatus.db",	"IOC=$(IOCPVROOT)" )

#------------------------------------------------------------------------------
# Setup autosave

set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(TOP)/autosave" )
save_restoreSet_status_prefix( "$(IOCPVROOT):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

# Just restore the settings
set_pass0_restoreFile( "$(IOC).sav" )
set_pass1_restoreFile( "$(IOC).sav" )


# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set( "$(IOC).req", 5, "" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
