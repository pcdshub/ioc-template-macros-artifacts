#!/reg/g/pcds/package/epics/3.14/ioc/common/protura/R1.0.0/bin/linux-x86_64/protura

epicsEnvSet("IOCNAME", "ioc-mfx-tfs-protura")
epicsEnvSet("ENGINEER", "Teddy Rendahl (trendahl)")
epicsEnvSet("LOCATION", "IOC:MFX:TFS:PRTA")
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "IOC:MFX:TFS:PRTA")
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

epicsEnvSet( "USB0", "MFX:TFS:MMS:01" )
epicsEnvSet( "USB1", "MFX:TFS:MMS:02" )
epicsEnvSet( "USB2", "MFX:TFS:MMS:03" )
epicsEnvSet( "USB3", "MFX:TFS:MMS:04" )
epicsEnvSet( "USB4", "MFX:TFS:MMS:05" )
epicsEnvSet( "USB5", "MFX:TFS:MMS:06" )
epicsEnvSet( "USB6", "MFX:TFS:MMS:07" )
epicsEnvSet( "USB7", "MFX:TFS:MMS:08" )
epicsEnvSet( "USB8", "MFX:TFS:MMS:09" )
epicsEnvSet( "USB9", "MFX:TFS:MMS:10" )
epicsEnvSet( "USB10", "MFX:TFS:MMS:11" )
epicsEnvSet( "USB11", "MFX:TFS:MMS:12" )
epicsEnvSet( "USB12", "MFX:TFS:MMS:13" )
epicsEnvSet( "USB13", "MFX:TFS:MMS:14" )
epicsEnvSet( "USB14", "MFX:TFS:MMS:15" )
epicsEnvSet( "USB15", "MFX:TFS:MMS:16" )
epicsEnvSet( "USB16", "MFX:TFS:MMS:17" )
epicsEnvSet( "USB17", "MFX:TFS:MMS:18" )
epicsEnvSet( "USB18", "MFX:TFS:MMS:19" )
epicsEnvSet( "USB19", "MFX:TFS:MMS:20" )
epicsEnvSet( "USB20", "MFX:TFS:MMS:21" )

USB_Map("$(USB0):USB","FTFSGFT")
USB_Map("$(USB1):USB","FTFSGDB")
USB_Map("$(USB2):USB","FTFSICR")
USB_Map("$(USB3):USB","FTFSHSO")
USB_Map("$(USB4):USB","FTFSIFA")
USB_Map("$(USB5):USB","FTFSHW5")
USB_Map("$(USB6):USB","FTFSI84")
USB_Map("$(USB7):USB","FTFSGEX")
USB_Map("$(USB8):USB","FTFSGUP")
USB_Map("$(USB9):USB","FTFSI14")
USB_Map("$(USB10):USB","FTFSIBO")
USB_Map("$(USB11):USB","FTFSI5P")
USB_Map("$(USB12):USB","FTDJBZD")
USB_Map("$(USB13):USB","FTFSGP9")
USB_Map("$(USB14):USB","FTFSHZ8")
USB_Map("$(USB15):USB","FTFSI2I")
USB_Map("$(USB16):USB","FTFSGSG")
USB_Map("$(USB17):USB","FTFSILM")
USB_Map("$(USB18):USB","FTFSIEH")
USB_Map("$(USB19):USB","FTFSHQX")
USB_Map("$(USB20):USB","FTFSI6Z")

# Load record instances
dbLoadRecords( "db/iocSoft.db",            "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "IOC=$(IOC_PV)" )

dbLoadRecords( "db/asynRecord.db", "P=$(USB0):USB,R=:asyn,PORT=$(USB0):USB,IMAX=100,OMAX=100,ADDR=0" )
dbLoadRecords("db/protura.db", "NAME=$(USB0):LE,MOTOR=1,PORT=$(USB0):USB,BITS=26,SERIAL=FTFSGFT,SCAN=.1 second,TIME=30")

##dbLoadRecords("db/streamfix.db", "P=$(USB0):LE,SFP=$(USB0):LE:POSITIONGET,SCAN=.2 second")
dbLoadRecords( "db/asynRecord.db", "P=$(USB1):USB,R=:asyn,PORT=$(USB1):USB,IMAX=100,OMAX=100,ADDR=0" )
dbLoadRecords("db/protura.db", "NAME=$(USB1):LE,MOTOR=1,PORT=$(USB1):USB,BITS=26,SERIAL=FTFSGDB,SCAN=.1 second,TIME=30")

##dbLoadRecords("db/streamfix.db", "P=$(USB1):LE,SFP=$(USB1):LE:POSITIONGET,SCAN=.2 second")
dbLoadRecords( "db/asynRecord.db", "P=$(USB2):USB,R=:asyn,PORT=$(USB2):USB,IMAX=100,OMAX=100,ADDR=0" )
dbLoadRecords("db/protura.db", "NAME=$(USB2):LE,MOTOR=1,PORT=$(USB2):USB,BITS=26,SERIAL=FTFSICR,SCAN=.1 second,TIME=30")

##dbLoadRecords("db/streamfix.db", "P=$(USB2):LE,SFP=$(USB2):LE:POSITIONGET,SCAN=.2 second")
dbLoadRecords( "db/asynRecord.db", "P=$(USB3):USB,R=:asyn,PORT=$(USB3):USB,IMAX=100,OMAX=100,ADDR=0" )
dbLoadRecords("db/protura.db", "NAME=$(USB3):LE,MOTOR=1,PORT=$(USB3):USB,BITS=26,SERIAL=FTFSHSO,SCAN=.1 second,TIME=30")

##dbLoadRecords("db/streamfix.db", "P=$(USB3):LE,SFP=$(USB3):LE:POSITIONGET,SCAN=.2 second")
dbLoadRecords( "db/asynRecord.db", "P=$(USB4):USB,R=:asyn,PORT=$(USB4):USB,IMAX=100,OMAX=100,ADDR=0" )
dbLoadRecords("db/protura.db", "NAME=$(USB4):LE,MOTOR=1,PORT=$(USB4):USB,BITS=26,SERIAL=FTFSIFA,SCAN=.1 second,TIME=30")

##dbLoadRecords("db/streamfix.db", "P=$(USB4):LE,SFP=$(USB4):LE:POSITIONGET,SCAN=.2 second")
dbLoadRecords( "db/asynRecord.db", "P=$(USB5):USB,R=:asyn,PORT=$(USB5):USB,IMAX=100,OMAX=100,ADDR=0" )
dbLoadRecords("db/protura.db", "NAME=$(USB5):LE,MOTOR=1,PORT=$(USB5):USB,BITS=26,SERIAL=FTFSHW5,SCAN=.1 second,TIME=30")

##dbLoadRecords("db/streamfix.db", "P=$(USB5):LE,SFP=$(USB5):LE:POSITIONGET,SCAN=.2 second")
dbLoadRecords( "db/asynRecord.db", "P=$(USB6):USB,R=:asyn,PORT=$(USB6):USB,IMAX=100,OMAX=100,ADDR=0" )
dbLoadRecords("db/protura.db", "NAME=$(USB6):LE,MOTOR=1,PORT=$(USB6):USB,BITS=26,SERIAL=FTFSI84,SCAN=.1 second,TIME=30")

##dbLoadRecords("db/streamfix.db", "P=$(USB6):LE,SFP=$(USB6):LE:POSITIONGET,SCAN=.2 second")
dbLoadRecords( "db/asynRecord.db", "P=$(USB7):USB,R=:asyn,PORT=$(USB7):USB,IMAX=100,OMAX=100,ADDR=0" )
dbLoadRecords("db/protura.db", "NAME=$(USB7):LE,MOTOR=1,PORT=$(USB7):USB,BITS=26,SERIAL=FTFSGEX,SCAN=.1 second,TIME=30")

##dbLoadRecords("db/streamfix.db", "P=$(USB7):LE,SFP=$(USB7):LE:POSITIONGET,SCAN=.2 second")
dbLoadRecords( "db/asynRecord.db", "P=$(USB8):USB,R=:asyn,PORT=$(USB8):USB,IMAX=100,OMAX=100,ADDR=0" )
dbLoadRecords("db/protura.db", "NAME=$(USB8):LE,MOTOR=1,PORT=$(USB8):USB,BITS=26,SERIAL=FTFSGUP,SCAN=.1 second,TIME=30")

##dbLoadRecords("db/streamfix.db", "P=$(USB8):LE,SFP=$(USB8):LE:POSITIONGET,SCAN=.2 second")
dbLoadRecords( "db/asynRecord.db", "P=$(USB9):USB,R=:asyn,PORT=$(USB9):USB,IMAX=100,OMAX=100,ADDR=0" )
dbLoadRecords("db/protura.db", "NAME=$(USB9):LE,MOTOR=1,PORT=$(USB9):USB,BITS=26,SERIAL=FTFSI14,SCAN=.1 second,TIME=30")

##dbLoadRecords("db/streamfix.db", "P=$(USB9):LE,SFP=$(USB9):LE:POSITIONGET,SCAN=.2 second")
dbLoadRecords( "db/asynRecord.db", "P=$(USB10):USB,R=:asyn,PORT=$(USB10):USB,IMAX=100,OMAX=100,ADDR=0" )
dbLoadRecords("db/protura.db", "NAME=$(USB10):LE,MOTOR=1,PORT=$(USB10):USB,BITS=26,SERIAL=FTFSIBO,SCAN=.1 second,TIME=30")

##dbLoadRecords("db/streamfix.db", "P=$(USB10):LE,SFP=$(USB10):LE:POSITIONGET,SCAN=.2 second")
dbLoadRecords( "db/asynRecord.db", "P=$(USB11):USB,R=:asyn,PORT=$(USB11):USB,IMAX=100,OMAX=100,ADDR=0" )
dbLoadRecords("db/protura.db", "NAME=$(USB11):LE,MOTOR=1,PORT=$(USB11):USB,BITS=26,SERIAL=FTFSI5P,SCAN=.1 second,TIME=30")

##dbLoadRecords("db/streamfix.db", "P=$(USB11):LE,SFP=$(USB11):LE:POSITIONGET,SCAN=.2 second")
dbLoadRecords( "db/asynRecord.db", "P=$(USB12):USB,R=:asyn,PORT=$(USB12):USB,IMAX=100,OMAX=100,ADDR=0" )
dbLoadRecords("db/protura.db", "NAME=$(USB12):LE,MOTOR=1,PORT=$(USB12):USB,BITS=26,SERIAL=FTDJBZD,SCAN=.1 second,TIME=30")

##dbLoadRecords("db/streamfix.db", "P=$(USB12):LE,SFP=$(USB12):LE:POSITIONGET,SCAN=.2 second")
dbLoadRecords( "db/asynRecord.db", "P=$(USB13):USB,R=:asyn,PORT=$(USB13):USB,IMAX=100,OMAX=100,ADDR=0" )
dbLoadRecords("db/protura.db", "NAME=$(USB13):LE,MOTOR=1,PORT=$(USB13):USB,BITS=26,SERIAL=FTFSGP9,SCAN=.1 second,TIME=30")

##dbLoadRecords("db/streamfix.db", "P=$(USB13):LE,SFP=$(USB13):LE:POSITIONGET,SCAN=.2 second")
dbLoadRecords( "db/asynRecord.db", "P=$(USB14):USB,R=:asyn,PORT=$(USB14):USB,IMAX=100,OMAX=100,ADDR=0" )
dbLoadRecords("db/protura.db", "NAME=$(USB14):LE,MOTOR=1,PORT=$(USB14):USB,BITS=26,SERIAL=FTFSHZ8,SCAN=.1 second,TIME=30")

##dbLoadRecords("db/streamfix.db", "P=$(USB14):LE,SFP=$(USB14):LE:POSITIONGET,SCAN=.2 second")
dbLoadRecords( "db/asynRecord.db", "P=$(USB15):USB,R=:asyn,PORT=$(USB15):USB,IMAX=100,OMAX=100,ADDR=0" )
dbLoadRecords("db/protura.db", "NAME=$(USB15):LE,MOTOR=1,PORT=$(USB15):USB,BITS=26,SERIAL=FTFSI2I,SCAN=.1 second,TIME=30")

##dbLoadRecords("db/streamfix.db", "P=$(USB15):LE,SFP=$(USB15):LE:POSITIONGET,SCAN=.2 second")
dbLoadRecords( "db/asynRecord.db", "P=$(USB16):USB,R=:asyn,PORT=$(USB16):USB,IMAX=100,OMAX=100,ADDR=0" )
dbLoadRecords("db/protura.db", "NAME=$(USB16):LE,MOTOR=1,PORT=$(USB16):USB,BITS=26,SERIAL=FTFSGSG,SCAN=.1 second,TIME=30")

##dbLoadRecords("db/streamfix.db", "P=$(USB16):LE,SFP=$(USB16):LE:POSITIONGET,SCAN=.2 second")
dbLoadRecords( "db/asynRecord.db", "P=$(USB17):USB,R=:asyn,PORT=$(USB17):USB,IMAX=100,OMAX=100,ADDR=0" )
dbLoadRecords("db/protura.db", "NAME=$(USB17):LE,MOTOR=1,PORT=$(USB17):USB,BITS=26,SERIAL=FTFSILM,SCAN=.1 second,TIME=30")

##dbLoadRecords("db/streamfix.db", "P=$(USB17):LE,SFP=$(USB17):LE:POSITIONGET,SCAN=.2 second")
dbLoadRecords( "db/asynRecord.db", "P=$(USB18):USB,R=:asyn,PORT=$(USB18):USB,IMAX=100,OMAX=100,ADDR=0" )
dbLoadRecords("db/protura.db", "NAME=$(USB18):LE,MOTOR=1,PORT=$(USB18):USB,BITS=26,SERIAL=FTFSIEH,SCAN=.1 second,TIME=30")

##dbLoadRecords("db/streamfix.db", "P=$(USB18):LE,SFP=$(USB18):LE:POSITIONGET,SCAN=.2 second")
dbLoadRecords( "db/asynRecord.db", "P=$(USB19):USB,R=:asyn,PORT=$(USB19):USB,IMAX=100,OMAX=100,ADDR=0" )
dbLoadRecords("db/protura.db", "NAME=$(USB19):LE,MOTOR=1,PORT=$(USB19):USB,BITS=26,SERIAL=FTFSHQX,SCAN=.1 second,TIME=30")

##dbLoadRecords("db/streamfix.db", "P=$(USB19):LE,SFP=$(USB19):LE:POSITIONGET,SCAN=.2 second")
dbLoadRecords( "db/asynRecord.db", "P=$(USB20):USB,R=:asyn,PORT=$(USB20):USB,IMAX=100,OMAX=100,ADDR=0" )
dbLoadRecords("db/protura.db", "NAME=$(USB20):LE,MOTOR=1,PORT=$(USB20):USB,BITS=26,SERIAL=FTFSI6Z,SCAN=.1 second,TIME=30")

##dbLoadRecords("db/streamfix.db", "P=$(USB20):LE,SFP=$(USB20):LE:POSITIONGET,SCAN=.2 second")

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
#asynSetTraceIOMask("$(USB5):USB",0,7)
#asynSetTraceMask("$(USB5):USB",0,9)
#asynSetTraceFile($(USB5), 0, $(IOC_DATA)/$(IOC)/logs/$(USB5).log)
#asynSetTraceIOMask("$(USB6):USB",0,7)
#asynSetTraceMask("$(USB6):USB",0,9)
#asynSetTraceFile($(USB6), 0, $(IOC_DATA)/$(IOC)/logs/$(USB6).log)
#asynSetTraceIOMask("$(USB7):USB",0,7)
#asynSetTraceMask("$(USB7):USB",0,9)
#asynSetTraceFile($(USB7), 0, $(IOC_DATA)/$(IOC)/logs/$(USB7).log)
#asynSetTraceIOMask("$(USB8):USB",0,7)
#asynSetTraceMask("$(USB8):USB",0,9)
#asynSetTraceFile($(USB8), 0, $(IOC_DATA)/$(IOC)/logs/$(USB8).log)
#asynSetTraceIOMask("$(USB9):USB",0,7)
#asynSetTraceMask("$(USB9):USB",0,9)
#asynSetTraceFile($(USB9), 0, $(IOC_DATA)/$(IOC)/logs/$(USB9).log)
#asynSetTraceIOMask("$(USB10):USB",0,7)
#asynSetTraceMask("$(USB10):USB",0,9)
#asynSetTraceFile($(USB10), 0, $(IOC_DATA)/$(IOC)/logs/$(USB10).log)
#asynSetTraceIOMask("$(USB11):USB",0,7)
#asynSetTraceMask("$(USB11):USB",0,9)
#asynSetTraceFile($(USB11), 0, $(IOC_DATA)/$(IOC)/logs/$(USB11).log)
#asynSetTraceIOMask("$(USB12):USB",0,7)
#asynSetTraceMask("$(USB12):USB",0,9)
#asynSetTraceFile($(USB12), 0, $(IOC_DATA)/$(IOC)/logs/$(USB12).log)
#asynSetTraceIOMask("$(USB13):USB",0,7)
#asynSetTraceMask("$(USB13):USB",0,9)
#asynSetTraceFile($(USB13), 0, $(IOC_DATA)/$(IOC)/logs/$(USB13).log)
#asynSetTraceIOMask("$(USB14):USB",0,7)
#asynSetTraceMask("$(USB14):USB",0,9)
#asynSetTraceFile($(USB14), 0, $(IOC_DATA)/$(IOC)/logs/$(USB14).log)
#asynSetTraceIOMask("$(USB15):USB",0,7)
#asynSetTraceMask("$(USB15):USB",0,9)
#asynSetTraceFile($(USB15), 0, $(IOC_DATA)/$(IOC)/logs/$(USB15).log)
#asynSetTraceIOMask("$(USB16):USB",0,7)
#asynSetTraceMask("$(USB16):USB",0,9)
#asynSetTraceFile($(USB16), 0, $(IOC_DATA)/$(IOC)/logs/$(USB16).log)
#asynSetTraceIOMask("$(USB17):USB",0,7)
#asynSetTraceMask("$(USB17):USB",0,9)
#asynSetTraceFile($(USB17), 0, $(IOC_DATA)/$(IOC)/logs/$(USB17).log)
#asynSetTraceIOMask("$(USB18):USB",0,7)
#asynSetTraceMask("$(USB18):USB",0,9)
#asynSetTraceFile($(USB18), 0, $(IOC_DATA)/$(IOC)/logs/$(USB18).log)
#asynSetTraceIOMask("$(USB19):USB",0,7)
#asynSetTraceMask("$(USB19):USB",0,9)
#asynSetTraceFile($(USB19), 0, $(IOC_DATA)/$(IOC)/logs/$(USB19).log)
#asynSetTraceIOMask("$(USB20):USB",0,7)
#asynSetTraceMask("$(USB20):USB",0,9)
#asynSetTraceFile($(USB20), 0, $(IOC_DATA)/$(IOC)/logs/$(USB20).log)

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
dbpf $(USB5):LE:BITSSET 0
dbpf $(USB6):LE:BITSSET 0
dbpf $(USB7):LE:BITSSET 0
dbpf $(USB8):LE:BITSSET 0
dbpf $(USB9):LE:BITSSET 0
dbpf $(USB10):LE:BITSSET 0
dbpf $(USB11):LE:BITSSET 0
dbpf $(USB12):LE:BITSSET 0
dbpf $(USB13):LE:BITSSET 0
dbpf $(USB14):LE:BITSSET 0
dbpf $(USB15):LE:BITSSET 0
dbpf $(USB16):LE:BITSSET 0
dbpf $(USB17):LE:BITSSET 0
dbpf $(USB18):LE:BITSSET 0
dbpf $(USB19):LE:BITSSET 0
dbpf $(USB20):LE:BITSSET 0
