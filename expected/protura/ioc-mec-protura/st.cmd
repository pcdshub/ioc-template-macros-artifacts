#!/reg/g/pcds/package/epics/3.14/ioc/common/protura/R1.0.0/bin/linux-x86_64/protura

epicsEnvSet("IOCNAME", "ioc-mec-protura")
epicsEnvSet("ENGINEER", "Richard Dabney")
epicsEnvSet("LOCATION", "MEC:HOM:IOC:01")
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "MEC:HOM:IOC:01")
epicsEnvSet("IOCTOP", "/reg/g/pcds/package/epics/3.14/ioc/common/protura/R1.0.0")

< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/package/epics/3.14/ioc/mec/protura/R2.0.0/build")
cd( "$(IOCTOP)" )

epicsEnvSet("STREAM_PROTOCOL_PATH", "./proturaApp/protocols")

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/protura.dbd")
protura_registerRecordDeviceDriver(pdbbase)

epicsEnvSet( "USB0", "HXX:HXM:MMS:01" )
epicsEnvSet( "USB1", "HXX:HXM:MMS:02" )

USB_Map("$(USB0):USB","FTU99IEQ")
USB_Map("$(USB1):USB","FTU99IBP")

# Load record instances
dbLoadRecords( "db/iocSoft.db",            "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "IOC=$(IOC_PV)" )

dbLoadRecords( "db/asynRecord.db", "P=$(USB0):USB,R=:asyn,PORT=$(USB0):USB,IMAX=100,OMAX=100,ADDR=0" )
dbLoadRecords("db/protura.db", "NAME=$(USB0):EN,MOTOR=1,PORT=$(USB0):USB,BITS=26,SERIAL=FTU99IEQ,SCAN=.1 second,TIME=30")

##dbLoadRecords("db/streamfix.db", "P=$(USB0):EN,SFP=$(USB0):EN:POSITIONGET,SCAN=.2 second")
dbLoadRecords( "db/asynRecord.db", "P=$(USB1):USB,R=:asyn,PORT=$(USB1):USB,IMAX=100,OMAX=100,ADDR=0" )
dbLoadRecords("db/protura.db", "NAME=$(USB1):EN,MOTOR=1,PORT=$(USB1):USB,BITS=26,SERIAL=FTU99IBP,SCAN=.1 second,TIME=30")

##dbLoadRecords("db/streamfix.db", "P=$(USB1):EN,SFP=$(USB1):EN:POSITIONGET,SCAN=.2 second")

#asynSetTraceIOMask("$(USB0):USB",0,7)
#asynSetTraceMask("$(USB0):USB",0,9)
#asynSetTraceFile($(USB0), 0, $(IOC_DATA)/$(IOC)/logs/$(USB0).log)
#asynSetTraceIOMask("$(USB1):USB",0,7)
#asynSetTraceMask("$(USB1):USB",0,9)
#asynSetTraceFile($(USB1), 0, $(IOC_DATA)/$(IOC)/logs/$(USB1).log)

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
dbpf $(USB0):EN:BITSSET 0
dbpf $(USB1):EN:BITSSET 0
