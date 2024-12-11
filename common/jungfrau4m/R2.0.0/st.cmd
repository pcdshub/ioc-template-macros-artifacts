#!$$IOCTOP/bin/$$IF(ARCH,$$ARCH,linux-x86_64)/jungfrau4m

< envPaths
epicsEnvSet("IOCNAME", "$$IOCNAME" )
epicsEnvSet("ENGINEER", "$$ENGINEER" )
epicsEnvSet("LOCATION", "$$LOCATION" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "$$IOC_PV")
epicsEnvSet("IOCTOP", "$$IOCTOP")
epicsEnvSet("TOP", "$$TOP")
epicsEnvSet(streamDebug, 0)
$$IF(SLSDETBASE0)
epicsEnvSet("SLSDETDB_JF512k",  "db/jungfrau512k.db")
epicsEnvSet("SLSDETDB_JF1M",    "db/jungfrau1M.db")
epicsEnvSet("SLSDETDB_JF4M",    "db/jungfrau4M.db")
$$ENDIF(SLSDETBASE0)
## Add the path to the protocol files
epicsEnvSet("STREAM_PROTOCOL_PATH", "$(IOCTOP)/protocol")

cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/jungfrau4m.dbd")
jungfrau4m_registerRecordDeviceDriver(pdbbase)

# Configure each device
$$LOOP(SLSDET)
SlsDetConfigure( "$$BASE:CTRL", "$$IF(MOD0,$$MOD0+,)$$IF(MOD1,$$MOD1+,)$$IF(MOD2,$$MOD2+,)$$IF(MOD3,$$MOD3+,)$$IF(MOD4,$$MOD4+,)$$IF(MOD5,$$MOD5+,)$$IF(MOD6,$$MOD6+,)$$IF(MOD7,$$MOD7+,)", "$$CALC{($$INDEX+$$IF(SLSDET_ID_OFFSET)$$SLSDET_ID_OFFSET$$ELSE(SLSDET_ID_OFFSET)0$$ENDIF(SLSDET_ID_OFFSET))<<4}", "$$IF(TIMEOUT,$$TIMEOUT,0.5)" )
#define ASYN_TRACE_ERROR     0x0001
#define ASYN_TRACEIO_DEVICE  0x0002
#define ASYN_TRACEIO_FILTER  0x0004
#define ASYN_TRACEIO_DRIVER  0x0008
#define ASYN_TRACE_FLOW      0x0010
#define ASYN_TRACE_WARNING   0x0020
$$IF(MOD0)$$IF(DEBUG,,#)asynSetTraceMask( "$$BASE:CTRL", 0, 0x3B) # log everything
$$ENDIF(MOD0)$$IF(MOD1)$$IF(DEBUG,,#)asynSetTraceMask( "$$BASE:CTRL", 1, 0x3B) # log everything
$$ENDIF(MOD1)$$IF(MOD2)$$IF(DEBUG,,#)asynSetTraceMask( "$$BASE:CTRL", 2, 0x3B) # log everything
$$ENDIF(MOD2)$$IF(MOD3)$$IF(DEBUG,,#)asynSetTraceMask( "$$BASE:CTRL", 3, 0x3B) # log everything
$$ENDIF(MOD3)$$IF(MOD4)$$IF(DEBUG,,#)asynSetTraceMask( "$$BASE:CTRL", 4, 0x3B) # log everything
$$ENDIF(MOD4)$$IF(MOD5)$$IF(DEBUG,,#)asynSetTraceMask( "$$BASE:CTRL", 5, 0x3B) # log everything
$$ENDIF(MOD5)$$IF(MOD6)$$IF(DEBUG,,#)asynSetTraceMask( "$$BASE:CTRL", 6, 0x3B) # log everything
$$ENDIF(MOD6)$$IF(MOD7)$$IF(DEBUG,,#)asynSetTraceMask( "$$BASE:CTRL", 7, 0x3B) # log everything
$$ENDIF(MOD7)#define ASYN_TRACEIO_ASCII  0x0001
#define ASYN_TRACEIO_ESCAPE 0x0002
#define ASYN_TRACEIO_HEX    0x0004
$$IF(MOD0)$$IF(DEBUG,,#)asynSetTraceIOMask( "$$BASE:CTRL", 0, 2)  # Escape the strings.
$$ENDIF(MOD0)$$IF(MOD1)$$IF(DEBUG,,#)asynSetTraceIOMask( "$$BASE:CTRL", 1, 2)  # Escape the strings.
$$ENDIF(MOD1)$$IF(MOD2)$$IF(DEBUG,,#)asynSetTraceIOMask( "$$BASE:CTRL", 2, 2)  # Escape the strings.
$$ENDIF(MOD2)$$IF(MOD3)$$IF(DEBUG,,#)asynSetTraceIOMask( "$$BASE:CTRL", 3, 2)  # Escape the strings.
$$ENDIF(MOD3)$$IF(MOD4)$$IF(DEBUG,,#)asynSetTraceIOMask( "$$BASE:CTRL", 4, 2)  # Escape the strings.
$$ENDIF(MOD4)$$IF(MOD5)$$IF(DEBUG,,#)asynSetTraceIOMask( "$$BASE:CTRL", 5, 2)  # Escape the strings.
$$ENDIF(MOD5)$$IF(MOD6)$$IF(DEBUG,,#)asynSetTraceIOMask( "$$BASE:CTRL", 6, 2)  # Escape the strings.
$$ENDIF(MOD6)$$IF(MOD7)$$IF(DEBUG,,#)asynSetTraceIOMask( "$$BASE:CTRL", 7, 2)  # Escape the strings.$$ENDIF(MOD7)
$$ENDLOOP(SLSDET)
$$LOOP(JFPWR)
drvAsynIPPortConfigure( "$$BASE:PWR", "$$HOST:$$PORT TCP", 0, 0, 0 )
#define ASYN_TRACE_ERROR     0x0001
#define ASYN_TRACEIO_DEVICE  0x0002
#define ASYN_TRACEIO_FILTER  0x0004
#define ASYN_TRACEIO_DRIVER  0x0008
#define ASYN_TRACE_FLOW      0x0010
$$IF(DEBUG,,#)asynSetTraceMask( "$$BASE:PWR", 0, 0x19) # log everything
#define ASYN_TRACEIO_ASCII  0x0001
#define ASYN_TRACEIO_ESCAPE 0x0002
#define ASYN_TRACEIO_HEX    0x0004
$$IF(DEBUG,,#)asynSetTraceIOMask( "$$BASE:PWR", 0, 2)  # Escape the strings.
$$ENDLOOP(JFPWR)
$$LOOP(BME)
drvAsynSerialPortConfigure( "$$BASE:$$IF(NAME,$$NAME,BME280:$$INDEX)", "$$PORT", 0, 0, 0 )
#define ASYN_TRACE_ERROR     0x0001
#define ASYN_TRACEIO_DEVICE  0x0002
#define ASYN_TRACEIO_FILTER  0x0004
#define ASYN_TRACEIO_DRIVER  0x0008
#define ASYN_TRACE_FLOW      0x0010
$$IF(DEBUG,,#)asynSetTraceMask( "$$BASE:$$IF(NAME,$$NAME,BME280:$$INDEX)", 0, 0x19) # log everything
#define ASYN_TRACEIO_ASCII  0x0001
#define ASYN_TRACEIO_ESCAPE 0x0002
#define ASYN_TRACEIO_HEX    0x0004
$$IF(DEBUG,,#)asynSetTraceIOMask( "$$BASE:$$IF(NAME,$$NAME,BME280:$$INDEX)", 0, 2)  # Escape the strings.
$$ENDLOOP(BME)

# Load record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "P=$(IOC_PV):" )
$$LOOP(SLSDET)
dbLoadRecords( "$(SLSDETDB_$$TYPE)", "BASE=$$BASE,SLSDET=$$BASE:CTRL,PORT=$$BASE:CTRL,TIMEOUT=$$IF(TIMEOUT,$$TIMEOUT,0.5)" )
$$ENDLOOP(SLSDET)
$$LOOP(JFPWR)
dbLoadRecords( "db/jfpower.db", "BASE=$$BASE,JFPWR=$$BASE:PWR,JFCTRL=$$BASE:CTRL,PORT=$$BASE:PWR" )
$$ENDLOOP(JFPWR)
$$LOOP(POWER)
dbLoadRecords( "db/power.db", "BASE=$$BASE,IDX=$$INDEX,CHAN=$$CHAN$$IF(VLO),VLO=$$VLO$$ENDIF(VLO)$$IF(VHI),VHI=$$VHI$$ENDIF(VHI)$$IF(VDEF),VDEF=$$VDEF$$ENDIF(VDEF)")
$$ENDLOOP(POWER)
$$LOOP(BME)
dbLoadRecords( "db/bme280.db", "BASE=$$BASE,BME=$$BASE:$$IF(NAME,$$NAME,BME280:$$INDEX),PORT=$$BASE:$$IF(NAME,$$NAME,BME280:$$INDEX)" )
$$ENDLOOP(BME)
$$LOOP(INTERLOCK)
$$IF(LO)
dbLoadRecords( "db/newao.db", "NAME=$$BASE:$$IF(NAME,$$NAME,INTERLOCK$$INDEX):LOLO,VAL=$$IF(LO,$$LO,0),PV=$$PV.LOLO,EGU=$$EGU")
$$ENDIF(LO)
$$IF(HI)
dbLoadRecords( "db/newao.db", "NAME=$$BASE:$$IF(NAME,$$NAME,INTERLOCK$$INDEX):HIHI,VAL=$$IF(HI,$$HI,0),PV=$$PV.HIHI,EGU=$$EGU")
$$ENDIF(HI)
dbLoadRecords( "db/interlock.db", "BASE=$$BASE,NAME=$$BASE:$$IF(NAME,$$NAME,INTERLOCK$$INDEX),LOPV=$$IF(LOPV)$$LOPV CPP$$ELSE(LOPV)$$IF(LO)$$BASE:$$IF(NAME,$$NAME,INTERLOCK$$INDEX):LOLO CPP$$ELSE(LO)0$$ENDIF(LO)$$ENDIF(LOPV),HIPV=$$IF(HIPV)$$HIPV CPP$$ELSE(HIPV)$$IF(HI)$$BASE:$$IF(NAME,$$NAME,INTERLOCK$$INDEX):HIHI CPP$$ELSE(HI)0$$ENDIF(HI)$$ENDIF(HIPV),PV=$$PV")
$$ENDLOOP(INTERLOCK)
$$LOOP(BME)
dbLoadRecords( "db/aggregate.db", "NAME=$$BASE:$$IF(NAME,$$NAME,BME280:$$INDEX):INTERLOCK,INPA=$$BASE:$$IF(NAME,$$NAME,BME280:$$INDEX):TEMP_INTERLOCK:TEST CPP NMS,INPB=$$BASE:$$IF(NAME,$$NAME,BME280:$$INDEX):HUMID_INTERLOCK:TEST CPP NMS,INPC=$$BASE:$$IF(NAME,$$NAME,BME280:$$INDEX):VOLTAGE_INTERLOCK:TEST CPP NMS,INPD=$$BASE:$$IF(NAME,$$NAME,BME280:$$INDEX):CURRENT_INTERLOCK:TEST CPP NMS")
$$ENDLOOP(BME)
$$LOOP(JFPWR)
dbLoadRecords( "db/aggregate.db", "NAME=$$BASE:BME280:ALL:INTERLOCK$$LOOP(BME),INP$$TRANSLATE(INDEX,"0123456789","ABCDEFGHIJ")=$$BASE:$$IF(NAME,$$NAME,BME280:$$INDEX):INTERLOCK CPP NMS$$ENDLOOP(BME)")
dbLoadRecords( "db/aggregate.db", "NAME=$$BASE:PWR:INTERLOCK$$LOOP(INTERLOCK),INP$$TRANSLATE(INDEX,"0123456789","ABCDEFGHIJ")=$$BASE:$$IF(NAME,$$NAME,INTERLOCK$$INDEX):TEST CPP NMS$$ENDLOOP(INTERLOCK),INPK=$$BASE:PWR:BLOCKED,INPL=$$BASE:BME280:ALL:INTERLOCK CPP NMS")
$$ENDLOOP(JFPWR)

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
