#!/reg/g/pcds/package/epics/3.14/ioc/common/protura/R1.0.0/bin/linux-x86_64/protura

epicsEnvSet("IOCNAME", "ioc-mfx-robot-protura")
epicsEnvSet("ENGINEER", "Silke Nelson (snelson)")
epicsEnvSet("LOCATION", "IOC:MFX:ROB:PRTA")
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "IOC:MFX:ROB:PRTA")
epicsEnvSet("IOCTOP", "/reg/g/pcds/package/epics/3.14/ioc/common/protura/R1.0.0")

< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/mfx/protura/R0.0.5/build")
cd( "$(IOCTOP)" )

epicsEnvSet("STREAM_PROTOCOL_PATH", "./proturaApp/protocols")

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/protura.dbd")
protura_registerRecordDeviceDriver(pdbbase)

epicsEnvSet( "USB10", "MFX:ROB:MMS:08" )

USB_Map("$(USB10):USB","FTWWVPHM")

# Load record instances
dbLoadRecords( "db/iocSoft.db",            "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "IOC=$(IOC_PV)" )

dbLoadRecords( "db/asynRecord.db", "P=$(USB10):USB,R=:asyn,PORT=$(USB10):USB,IMAX=100,OMAX=100,ADDR=0" )
dbLoadRecords("db/protura.db", "NAME=$(USB10):LE,MOTOR=1,PORT=$(USB10):USB,BITS=32,SERIAL=FTWWVPHM,SCAN=.1 second,TIME=30")

##dbLoadRecords("db/streamfix.db", "P=$(USB10):LE,SFP=$(USB10):LE:POSITIONGET,SCAN=.2 second")

#asynSetTraceIOMask("$(USB10):USB",0,7)
#asynSetTraceMask("$(USB10):USB",0,9)
#asynSetTraceFile($(USB10), 0, $(IOC_DATA)/$(IOC)/logs/$(USB10).log)

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
dbpf $(USB10):LE:BITSSET 0
