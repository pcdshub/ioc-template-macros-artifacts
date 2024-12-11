#!/reg/g/pcds/package/epics/3.14/ioc/common/protura/R1.0.0/bin/linux-x86_64/protura

epicsEnvSet("IOCNAME", "ioc-cxi-protura2")
epicsEnvSet("ENGINEER", "Richard Dabney")
epicsEnvSet("LOCATION", "CXI:R50:IOC:09")
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "CXI:R50:IOC:09")
epicsEnvSet("IOCTOP", "/reg/g/pcds/package/epics/3.14/ioc/common/protura/R1.0.0")

< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/package/epics/3.14/ioc/cxi/protura/R2.0.0/build")
cd( "$(IOCTOP)" )

epicsEnvSet("STREAM_PROTOCOL_PATH", "./proturaApp/protocols")

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/protura.dbd")
protura_registerRecordDeviceDriver(pdbbase)

epicsEnvSet( "USB0", "CXI:DS2:MMS:01" )
epicsEnvSet( "USB1", "CXI:DS2:MMS:02" )
epicsEnvSet( "USB2", "CXI:DS2:MMS:03" )
epicsEnvSet( "USB3", "CXI:DS2:MMS:04" )
epicsEnvSet( "USB4", "CXI:DS2:MMS:05" )

USB_Map("$(USB0):USB","FTU7E0V2")
USB_Map("$(USB1):USB","FTU7E0QA")
USB_Map("$(USB2):USB","FTU7E1JP")
USB_Map("$(USB3):USB","FTU99I8Z")
USB_Map("$(USB4):USB","FTU3BYLX")

# Load record instances
dbLoadRecords( "db/iocSoft.db",            "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "IOC=$(IOC_PV)" )

dbLoadRecords( "db/asynRecord.db", "P=$(USB0):USB,R=:asyn,PORT=$(USB0):USB,IMAX=100,OMAX=100,ADDR=0" )
dbLoadRecords("db/protura.db", "NAME=$(USB0):LE,MOTOR=1,PORT=$(USB0):USB,BITS=26,SERIAL=FTU7E0V2,SCAN=.1 second,TIME=30")

##dbLoadRecords("db/streamfix.db", "P=$(USB0):LE,SFP=$(USB0):LE:POSITIONGET,SCAN=.2 second")
dbLoadRecords( "db/asynRecord.db", "P=$(USB1):USB,R=:asyn,PORT=$(USB1):USB,IMAX=100,OMAX=100,ADDR=0" )
dbLoadRecords("db/protura.db", "NAME=$(USB1):LE,MOTOR=1,PORT=$(USB1):USB,BITS=26,SERIAL=FTU7E0QA,SCAN=.1 second,TIME=30")

##dbLoadRecords("db/streamfix.db", "P=$(USB1):LE,SFP=$(USB1):LE:POSITIONGET,SCAN=.2 second")
dbLoadRecords( "db/asynRecord.db", "P=$(USB2):USB,R=:asyn,PORT=$(USB2):USB,IMAX=100,OMAX=100,ADDR=0" )
dbLoadRecords("db/protura.db", "NAME=$(USB2):LE,MOTOR=1,PORT=$(USB2):USB,BITS=26,SERIAL=FTU7E1JP,SCAN=.1 second,TIME=30")

##dbLoadRecords("db/streamfix.db", "P=$(USB2):LE,SFP=$(USB2):LE:POSITIONGET,SCAN=.2 second")
dbLoadRecords( "db/asynRecord.db", "P=$(USB3):USB,R=:asyn,PORT=$(USB3):USB,IMAX=100,OMAX=100,ADDR=0" )
dbLoadRecords("db/protura.db", "NAME=$(USB3):LE,MOTOR=1,PORT=$(USB3):USB,BITS=26,SERIAL=FTU99I8Z,SCAN=.1 second,TIME=30")

##dbLoadRecords("db/streamfix.db", "P=$(USB3):LE,SFP=$(USB3):LE:POSITIONGET,SCAN=.2 second")
dbLoadRecords( "db/asynRecord.db", "P=$(USB4):USB,R=:asyn,PORT=$(USB4):USB,IMAX=100,OMAX=100,ADDR=0" )
dbLoadRecords("db/protura.db", "NAME=$(USB4):LE,MOTOR=1,PORT=$(USB4):USB,BITS=26,SERIAL=FTU3BYLX,SCAN=.1 second,TIME=30")

##dbLoadRecords("db/streamfix.db", "P=$(USB4):LE,SFP=$(USB4):LE:POSITIONGET,SCAN=.2 second")

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
#asynSetTraceIOMask("$(USB4):USB",0,7)
#asynSetTraceMask("$(USB4):USB",0,9)
#asynSetTraceFile($(USB4), 0, $(IOC_DATA)/$(IOC)/logs/$(USB4).log)

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
dbpf $(USB4):LE:BITSSET 0
