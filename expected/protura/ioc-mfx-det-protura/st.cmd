#!/reg/g/pcds/package/epics/3.14/ioc/common/protura/R1.0.0/bin/linux-x86_64/protura

epicsEnvSet("IOCNAME", "ioc-mfx-det-protura")
epicsEnvSet("ENGINEER", "Teddy Rendahl (trendahl)")
epicsEnvSet("LOCATION", "IOC:MFX:DET:PRTA")
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "IOC:MFX:DET:PRTA")
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

epicsEnvSet( "USB0", "MFX:DET:MMS:01" )
epicsEnvSet( "USB1", "MFX:DET:MMS:02" )
epicsEnvSet( "USB2", "MFX:DET:MMS:03" )
epicsEnvSet( "USB3", "MFX:DET:MMS:04" )

USB_Map("$(USB0):USB","FTABV16")
USB_Map("$(USB1):USB","FTABUZD")
USB_Map("$(USB2):USB","FTWWVPAH")
USB_Map("$(USB3):USB","FTWWVPJJ")

# Load record instances
dbLoadRecords( "db/iocSoft.db",            "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "IOC=$(IOC_PV)" )

dbLoadRecords( "db/asynRecord.db", "P=$(USB0):USB,R=:asyn,PORT=$(USB0):USB,IMAX=100,OMAX=100,ADDR=0" )
dbLoadRecords("db/protura.db", "NAME=$(USB0):LE,MOTOR=1,PORT=$(USB0):USB,BITS=32,SERIAL=FTABV16,SCAN=.1 second,TIME=30")

##dbLoadRecords("db/streamfix.db", "P=$(USB0):LE,SFP=$(USB0):LE:POSITIONGET,SCAN=.2 second")
dbLoadRecords( "db/asynRecord.db", "P=$(USB1):USB,R=:asyn,PORT=$(USB1):USB,IMAX=100,OMAX=100,ADDR=0" )
dbLoadRecords("db/protura.db", "NAME=$(USB1):LE,MOTOR=1,PORT=$(USB1):USB,BITS=32,SERIAL=FTABUZD,SCAN=.1 second,TIME=30")

##dbLoadRecords("db/streamfix.db", "P=$(USB1):LE,SFP=$(USB1):LE:POSITIONGET,SCAN=.2 second")
dbLoadRecords( "db/asynRecord.db", "P=$(USB2):USB,R=:asyn,PORT=$(USB2):USB,IMAX=100,OMAX=100,ADDR=0" )
dbLoadRecords("db/protura.db", "NAME=$(USB2):LE,MOTOR=1,PORT=$(USB2):USB,BITS=32,SERIAL=FTWWVPAH,SCAN=.1 second,TIME=30")

##dbLoadRecords("db/streamfix.db", "P=$(USB2):LE,SFP=$(USB2):LE:POSITIONGET,SCAN=.2 second")
dbLoadRecords( "db/asynRecord.db", "P=$(USB3):USB,R=:asyn,PORT=$(USB3):USB,IMAX=100,OMAX=100,ADDR=0" )
dbLoadRecords("db/protura.db", "NAME=$(USB3):LE,MOTOR=1,PORT=$(USB3):USB,BITS=32,SERIAL=FTWWVPJJ,SCAN=.1 second,TIME=30")

##dbLoadRecords("db/streamfix.db", "P=$(USB3):LE,SFP=$(USB3):LE:POSITIONGET,SCAN=.2 second")

#asynSetTraceIOMask("$(USB0):USB",0,7)
#asynSetTraceMask("$(USB0):USB",0,9)
#asynSetTraceFile($(USB0), 0, $(IOC_DATA)/$(IOC)/logs/$(USB0).log)
#asynSetTraceIOMask("$(USB1):USB",0,7)
#asynSetTraceMask("$(USB1):USB",0,9)
#asynSetTraceFile($(USB1), 0, $(IOC_DATA)/$(IOC)/logs/$(USB1).log)
#asynSetTraceIOMask("$(USB2):USB",0,7)
#asynSetTraceMask("$(USB2):USB",0,9)
#asynSetTraceFile($(USB2), 0, $(IOC_DATA)/$(IOC)/logs/$(USB2).log)
#asynSetTraceIOMask("$(USB3):USB",0,7)
#asynSetTraceMask("$(USB3):USB",0,9)
#asynSetTraceFile($(USB3), 0, $(IOC_DATA)/$(IOC)/logs/$(USB3).log)

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
dbpf $(USB0):LE:BITSSET 0
dbpf $(USB1):LE:BITSSET 0
dbpf $(USB2):LE:BITSSET 0
dbpf $(USB3):LE:BITSSET 0
