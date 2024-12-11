#!$$IOCTOP/bin/$$ARCH/protura

epicsEnvSet("IOCNAME", "$$IOCNAME")
epicsEnvSet("ENGINEER", "$$ENGINEER")
epicsEnvSet("LOCATION", "$$LOCATION")
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "$$IOC_PV")
epicsEnvSet("IOCTOP", "$$IOCTOP")

< envPaths
epicsEnvSet("TOP", "$$TOP")
cd( "$(IOCTOP)" )

epicsEnvSet("STREAM_PROTOCOL_PATH", "./proturaApp/protocols")

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/protura.dbd")
protura_registerRecordDeviceDriver(pdbbase)

$$LOOP(PROTURA)
epicsEnvSet( "$$NAME", "$$BASE" )
$$ENDLOOP(PROTURA)

$$LOOP(PROTURA)
USB_Map("$($$NAME):USB","$$SERIAL")
$$ENDLOOP(PROTURA)

# Load record instances
dbLoadRecords( "db/iocSoft.db",            "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "IOC=$(IOC_PV)" )

$$LOOP(PROTURA)
dbLoadRecords( "db/asynRecord.db", "P=$($$NAME):USB,R=:asyn,PORT=$($$NAME):USB,IMAX=100,OMAX=100,ADDR=0" )
dbLoadRecords("db/protura.db", "NAME=$($$NAME):$$IF(EXT,$$EXT,LE),MOTOR=1,PORT=$($$NAME):USB,BITS=$$(BITS),SERIAL=$$(SERIAL),SCAN=.1 second,TIME=$$IF(TIME,$$TIME,30)")

##dbLoadRecords("db/streamfix.db", "P=$($$NAME):$$IF(EXT,$$EXT,LE),SFP=$($$NAME):$$IF(EXT,$$EXT,LE):POSITIONGET,SCAN=.2 second")
$$ENDLOOP(PROTURA)

$$LOOP(PROTURA)
#asynSetTraceIOMask("$($$NAME):USB",0,7)
#asynSetTraceMask("$($$NAME):USB",0,9)
#asynSetTraceFile($($$NAME), 0, $(IOC_DATA)/$(IOC)/logs/$($$NAME).log)
$$ENDLOOP(PROTURA)

# Setup autosave
save_restoreSet_status_prefix( "$(IOC_PV):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )
set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "${TOP}/autosave" )
set_pass0_restoreFile( "$(IOC).sav" )
set_pass1_restoreFile( "$(IOC).sav" )

# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set( "$(IOC).req", 5, "IOC=$(IOC_PV)" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

#sets length of output
$$LOOP(PROTURA)
dbpf $($$NAME):$$IF(EXT,$$EXT,LE):BITSSET 0
$$ENDLOOP(PROTURA)
