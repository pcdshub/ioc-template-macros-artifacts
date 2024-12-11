#!$$IOCTOP/bin/linux-x86_64/unixCam$$PDV_VERSION

epicsEnvSet("IOCNAME", "$$IOCNAME")
epicsEnvSet("ENGINEER", "$$ENGINEER" )
epicsEnvSet("LOCATION", "$$LOCATION" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("STREAM_PROTOCOL_PATH", "db" )
epicsEnvSet("IOC_PV", "$$IOC_PV")
epicsEnvSet("IOCTOP", "$$IOCTOP")

< $(IOCTOP)/iocBoot/ioc/cameraDefs
< $(IOCTOP)/iocBoot/ioc/envPaths
< envPaths
epicsEnvSet("TOP", "$$TOP")
cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd
epicsEnvSet("EPICS_CA_MAX_ARRAY_BYTES", "$$IF(MAX_ARRAY,$$MAX_ARRAY,8000000)" )

# Load EPICS database definition
dbLoadDatabase("dbd/unixCam.dbd",0,0)

# Register all support components
unixCam_registerRecordDeviceDriver(pdbbase)

# Initialize debug variables
var IMAGE_REDUCE_DEBUG $$IF(IMAGE_REDUCE_DEBUG,$$IMAGE_REDUCE_DEBUG,0)
var EDT_UNIX_DEV_DEBUG $$IF(EDT_UNIX_DEV_DEBUG,$$EDT_UNIX_DEV_DEBUG,0)
var DEBUG_HI_RES_TIME 0
ErDebugLevel( 0 )

$$LOOP(EXTRA)
$$IF(INITTIME)
$$INCLUDE(NAME)
$$ENDIF(INITTIME)
$$ENDLOOP(EXTRA)

## Load EPICS records
$$LOOP(EVR)
dbLoadRecords( $(EVRDB_$$TYPE), "IOC=$(IOC_PV),EVR=$$(NAME),CARD=$$IF(CARD,$$CARD,$$INDEX)$$LOOP(CAMERA),CAM$$INDEX=$$NAME$$IF(TRIG),TU$$INDEX=$$NAME:TRIGGER_DELAY,IP$$(TRIG)E=Enabled$$ENDIF(TRIG)$$ENDLOOP(CAMERA)" )
$$ENDLOOP(EVR)

$$LOOP(EVENTCODE)
dbLoadRecords( "db/usrseq.db", "DEV=$$EVRNAME0,NAME=$$NAME,ID=$$ID,LNAME=$$LNAME" )
$$ENDLOOP(EVENTCODE)

$$LOOP(CAMERA)
$$IF(TRIG)
dbLoadRecords( "db/camdelay.db", "CAM=$$NAME,EVR=$$EVRNAME,TRIGGER=$$TRIG,BAUDRATE=$$IF(BAUDRATE)$$BAUDRATE$$ELSE(BAUDRATE)$(CAMERA_BAUD_$$TYPE)$$ENDIF(BAUDRATE)")
dbLoadRecords("db/evrDevInfo.db", "BASE=$$NAME,EVR=$$EVRNAME,TRIG=$$TRIG,NAME=$$NAME")
$$ENDIF(TRIG)
$$ENDLOOP(CAMERA)

# Initialize the cameras
$$LOOP(CAMERA)
$$IF(NOINIT)
$$ELSE(NOINIT)
$$IF(TRIG)
epicsCamInit( "$$NAME", $$BOARD, $$CHAN, "$(EDT_UNIX)/camera_config/$(CAMERA_CFG_$$IF(CFG,$$CFG,$$TYPE))", "$$EVRNAME:Triggers.$$TRANSLATE(TRIG,"0123456789AB","ABCDEFGHIJKL")", "$$NAME:TRIGGER_DELAY", "$$NAME:SYNC" )
$$ELSE(TRIG)
epicsCamInit( "$$NAME", $$BOARD, $$CHAN, "$(EDT_UNIX)/camera_config/$(CAMERA_CFG_$$IF(CFG,$$CFG,$$TYPE))")
$$ENDIF(TRIG)
$$ENDIF(NOINIT)
$$ENDLOOP(CAMERA)

# Enable sleep() calls as needed to diagnose startup errors
# epicsThreadSleep( 5.0 )

$$LOOP(EVR)
# Initialize EVR
ErConfigure( $$IF(CARD,$$CARD,$$INDEX), 0, 0, 0, $(EVRID_$$TYPE) )
$$ENDLOOP(EVR)

## Load EPICS records
dbLoadRecords( "db/iocSoft.db",				"IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db",	"IOC=$(IOC_PV)" )

$$LOOP(CAMERA)
$$IF(ASYNTRACE)
asynSetTraceIOMask(	"$$NAME", 0, 2 )
asynSetTraceMask(	"$$NAME", 0, 9 )
$$ENDIF(ASYNTRACE)
$$IF(TRIG)
dbLoadRecords( "db/fastlink.db", "CAM=$$NAME,LNK1=$$NAME:AVERAGER$$IF(FAST_FLNK),LNK2=$$FAST_FLNK$$ENDIF(FAST_FLNK)$$IF(DOPRJ),LNK3=$$NAME:COMPRESSOR,LNK4=$$NAME:IMAGE:DoPrj$$ELSE(DOPRJ)$$IF(COMPRESS),LNK3=$$NAME:COMPRESSOR$$ENDIF(COMPRESS)$$ENDIF(DOPRJ)" )

dbLoadRecords( $(CAMERA_DB_$$TYPE),	 "CAM=$$NAME,TS_EVENT=$$EVRNAME:Triggers.$$TRANSLATE(TRIG,"0123456789AB","ABCDEFGHIJKL"),FAST_FLNK=$$NAME:FASTLINK,BOARD=$$BOARD,CHAN=$$CHAN,TRIG=$$TRIG,EVR=$$EVRNAME" )

$$IF(DOPRJ)
dbLoadRecords( "db/compress.db"	"CAM=$$NAME,EVR=$$EVRNAME,TRIG=$$TRIG$$IF(XO),XO=$$XO$$ENDIF(XO)$$IF(XRC),XRC=$$XRC$$ENDIF(XRC)$$IF(YO),YO=$$YO$$ENDIF(YO)$$IF(YRC),YRC=$$YRC$$ENDIF(YRC)")
dbLoadRecords( "db/doprj.db"	"CAM=$$NAME$$IF(ROTATE),ROTATE=$$ROTATE$$ENDIF(ROTATE)$$IF(HSIZE),HSIZE=$$HSIZE$$ENDIF(HSIZE)$$IF(VSIZE),VSIZE=$$VSIZE$$ENDIF(VSIZE)")
$$IF(BLDID)
dbLoadRecords( "db/bldSettings.db", "BLD=$(IOC_PV):B$$INDEX,BLDNO=$$INDEX" )
$$ENDIF(BLDID)
$$ELSE(DOPRJ)
$$IF(COMPRESS)
dbLoadRecords( "db/compress.db"	"CAM=$$NAME,EVR=$$EVRNAME,TRIG=$$TRIG")
$$ENDIF(COMPRESS)
$$ENDIF(DOPRJ)
$$ELSE(TRIG)
dbLoadRecords( $(CAMERA_DB_$$TYPE),      "CAM=$$NAME,TS_EVENT=140" )
$$ENDIF(TRIG)
$$ENDLOOP(CAMERA)

$$LOOP(TRIGCTRL)
dbLoadRecords( "db/trigctrl$$IF(OUT,1,2).db", "NAME=$$CAMERANAME:$$NAME,OUT=$$IF(CAMERACOMPRESS)$$CAMERANAME:ENABLE$$ELSE(CAMERACOMPRESS)$$IF(CAMERADOPRJ,$$CAMERANAME:ENABLE,$$CAMERAEVRNAME:TRIG$$CAMERATRIG:TCTL)$$ENDIF(CAMERACOMPRESS)$$IF(A),A=$$A$$ENDIF(A)$$IF(B),B=$$B$$ENDIF(B)$$IF(C),C=$$C$$ENDIF(C)$$IF(D),D=$$D$$ENDIF(D),CALC=$$CALC$$IF(OUT),VAL=$$OUT$$ENDIF(OUT)")
$$ENDLOOP(TRIGCTRL)

$$LOOP(EXTRA)
$$IF(LOADTIME)
$$INCLUDE(NAME)
$$ENDIF(LOADTIME)
$$ENDLOOP(EXTRA)

# Setup autosave
set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(TOP)/autosave" )
save_restoreSet_status_prefix( "$(IOC_PV):" )

save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

set_pass0_restoreFile( "$(IOCNAME).sav" )
set_pass1_restoreFile( "$(IOCNAME).sav" )

# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set( "$(IOCNAME).req", 5, "IOC=$(IOC_PV),EVR=$$EVRNAME0" )

$$LOOP(CAMERA)
$$IF(DOPRJ)
dbpf $$NAME:CMPX_COL.PROC 1
dbpf $$NAME:CMPX_ROW.PROC 1

$$IF(BLDID)
SpectroBLD($$BLDID, 72)
BldSetID($$INDEX)
BldConfig( "239.255.24.$$BLDID", 10148, 8192, 0, $$BLDID, 72, "$$NAME:CURRENTFID", "$$NAME:BLDNEXT", "$$NAME:CURRENTFID", "$$NAME:IMAGE_CMPX:HPrj,$$NAME:IMAGE_CMPX:VPrj" )
BldSetDebugLevel(1)
# Uncomment the next line for BLD generation.
$$(NOBLD)BldStart()
BldShowConfig()
$$ENDIF(BLDID)
$$ENDIF(DOPRJ)
$$ENDLOOP(CAMERA)

StartCams(1)

epicsThreadSleep( 2.0 )
$$LOOP(CAMERA)
dbpf $$NAME:HWROI_ENABLE 1
dbpf $$NAME:HWROI_SET.PROC 1
$$ENDLOOP(CAMERA)

$$LOOP(EXTRA)
$$IF(FINISHTIME)
$$INCLUDE(NAME)
$$ENDIF(FINISHTIME)
$$ENDLOOP(EXTRA)

# Run the post startup script
< /reg/d/iocCommon/All/post_linux.cmd
