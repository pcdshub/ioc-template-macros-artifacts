#!$$IOCTOP/bin/$$IF(ARCH,$$ARCH,linux-x86_64)/chiller

< envPaths
epicsEnvSet("IOCNAME", "$$IOCNAME" )
epicsEnvSet("ENGINEER", "$$ENGINEER" )
epicsEnvSet("LOCATION", "$$LOCATION" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "$$IOC_PV")
epicsEnvSet("FLOWDB_CUBIC",   "db/cubicEX30AR-V.db")
epicsEnvSet("FLOWDB_PROTEUS", "db/proteusFlowMeter.db")
epicsEnvSet("FLOWDB_PROTEUSLOW", "db/proteusLowFlowMeter.db")
epicsEnvSet("IOCTOP", "$$IOCTOP")
epicsEnvSet("TOP", "$$TOP")
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
$$LOOP(CHILLER)
dbLoadRecords("$(ASYN)/db/asynRecord.db","P=$$NAME,R=:asyn,PORT=bus$$INDEX,ADDR=0,OMAX=0,IMAX=0")
drvAsynIPPortConfigure ("bus$$INDEX","$$PORT",0,0,0)
$$ENDLOOP(CHILLER)

# Asyn tracing settings
$$LOOP(CHILLER)
$$IF(ASYNTRACE)
asynSetTraceFile("bus$$INDEX", 0, "$(IOC_DATA)/$(IOCNAME)/iocInfo/asyn$$INDEX.log")
asynSetTraceMask("bus$$INDEX", 0, 0x1f) # log everything
asynSetTraceIOMask("bus$$INDEX", 0, 0x6)
$$ELSE(ASYNTRACE)
asynSetTraceMask("bus$$INDEX", 0, 0x1) # logging for normal operation
$$ENDIF(ASYNTRACE)
$$ENDLOOP(CHILLER)

# Load record instances
dbLoadRecords( "db/iocSoft.db",             "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db",  "IOC=$(IOC_PV)" )

# Load detetctor chiller control
$$LOOP(CHILLER)
dbLoadRecords("db/chiller.db", "PRE=$$NAME,bus=$$INDEX")
$$ENDLOOP(CHILLER)
$$LOOP(FLOWMETER)
dbLoadRecords("$(FLOWDB_$$TYPE)", "PRE=$$NAME,AI=$$AI")
$$ENDLOOP(FLOWMETER)

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

