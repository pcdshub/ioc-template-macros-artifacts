#!$$IOCTOP/bin/$$IF(ARCH,$$ARCH,linux-x86)/smaract
epicsEnvSet("IOCNAME",    "$$IOCNAME" )
epicsEnvSet("ENGINEER",   "$$ENGINEER")
epicsEnvSet("LOCATION",   "$$LOCATION")
epicsEnvSet("IOCSH_PS1",  "$(IOCNAME)> ")
epicsEnvSet("IOC_PV",     "$$IOC_PV")
epicsEnvSet("EVRID_PMC",  "1")
epicsEnvSet("EVRID_SLAC", "15")
epicsEnvSet("EVRDB_PMC",  "db/evrPmc230.db")
epicsEnvSet("EVRDB_SLAC", "db/evrSLAC.db")
epicsEnvSet("IOCTOP",     "$$IOCTOP")
epicsEnvSet("STREAM_PROTOCOL_PATH", "$(IOCTOP)/protocol")
< envPaths
epicsEnvSet("TOP", "$$TOP")

cd("$(IOCTOP)")

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/smaract.dbd")
smaract_registerRecordDeviceDriver(pdbbase)

$$LOOP(EVR)
ErDebugLevel( 0 )

# Initialize EVR
ErConfigure( $$IF(CARD,$$CARD,$$INDEX), 0, 0, 0, $(EVRID_$$TYPE) )

# Load EVR record instances
dbLoadRecords( $(EVRDB_$$TYPE), "IOC=$$(IOC_PV),EVR=$$(NAME),CARD=$$IF(CARD,$$CARD,$$INDEX)" )
$$ENDLOOP(EVR)

$$LOOP(SMARACT)
drvAsynIPPortConfigure("TCP$$INDEX", "$$IP:55551 TCP", 0, 0, 0 )
$$IF(TRACE)$$ELSE(TRACE)#$$ENDIF(TRACE)asynSetTraceMask(  "TCP$$INDEX",	0, $$IF(TLEVEL,$$TLEVEL,9))
$$IF(TRACE)$$ELSE(TRACE)#$$ENDIF(TRACE)asynSetTraceIOMask("TCP$$INDEX",	0, 2)
asynOctetSetInputEos("TCP$$INDEX",0,"\r\n")
asynOctetSetOutputEos("TCP$$INDEX",0,"\r\n")
$$IF(TFILE)asynSetTraceFile("TCP$$INDEX",0,"$(IOC_DATA)/$(IOC)/iocInfo/$$TFILE")$$ENDIF(TFILE)
$$ENDLOOP(SMARACT)

# smarActMCS2CreateController parameters:
#     (1) ASYN controller port name
#     (2) ASYN I/O port name
#     (3) Number of axes this controller supports
#     (4) Time to poll (sec) when an axis is in motion
#     (5) Time to poll (sec) when an axis is idle. 0 for no polling
# smarActMCS2CreateAxis parameters:
#     (1) Asyn port
#     (2) Axis number
#     (3) Channel number

$$LOOP(SMARACT)
smarActMCS2CreateController("MCS$$INDEX", "TCP$$INDEX", $$IF(COUNT,$$CALC{COUNT+1},10), $$IF(MPOLL,$$MPOLL,0.2), $$IF(SPOLL,$$SPOLL,1.0))
$$IF(ALL)
$$LOOP(COUNT)
smarActMCS2CreateAxis("MCS$$INDEX1",$$CALC{INDEX+1},$$INDEX)
$$ENDLOOP(COUNT)
$$ENDIF(ALL)
$$IF(PSLOC)
picoscaleConfig("PS$$INDEX", "$$PSLOC")
$$ENDIF(PSLOC)
$$ENDLOOP(SMARACT)
$$LOOP(AXIS)
smarActMCS2CreateAxis("MCS$$SMARACTINDEX",$$CHANNEL,$$CALC{CHANNEL-1})
$$ENDLOOP(AXIS)

# Load record instances
dbLoadRecords("db/iocSoft.db", "IOC=$(IOC_PV)")
dbLoadRecords("db/save_restoreStatus.db", "IOC=$(IOC_PV),P=$(IOC_PV):")

$$LOOP(SMARACT)
dbLoadRecords("db/asynRecord.db", "P=$$BASE,R=:ASYN,PORT=TCP$$INDEX,ADDR=0,OMAX=0,IMAX=0")
dbLoadRecords("db/SmarAct_global.db", "BASE=$$BASE,DEF_EC=$$IF(EVRNAME0,40,0)")
$$IF(PSLOC)
dbLoadRecords("db/Picoscale_global.db", "BASE=$$BASE,PS=PS$$INDEX,LOC=$$PSLOC")
$$ENDIF(PSLOC)
$$IF(ALL)
$$ASSIGN{MODNUM,1}
$$LOOP(COUNT)
dbLoadRecords("db/SmarAct.db", "BASE=$$BASE,N=$$CALC{INDEX+1},CH=$$INDEX,MOD=$$CALC{$$MODNUM-1,%d},PORT=MCS$$INDEX1,TCP=TCP$$INDEX1,PSEN=$$IF(PSLOC)$$CALC{1 if ((7&PSMASK) if PSMASK else 7)&(1<<INDEX) else 0}$$ELSE(PSLOC)0$$ENDIF(PSLOC)")
$$IFCALC{($$INDEX+1)%3}$$ELSE(CALC)
dbLoadRecords("db/SmarAct_module.db", "BASE=$$BASE,CH1=$$CALC{$$MODNUM*3-3,%d},CH2=$$CALC{$$MODNUM*3-2,%d},CH3=$$CALC{$$MODNUM*3-1,%d},MOD=$$CALC{$$MODNUM-1,%d},PORT=MCS$$INDEX1,TCP=TCP$$INDEX1")
$$ASSIGN{MODNUM,$$MODNUM+1}
$$ENDIF(CALC)
$$IF(PSLOC)
$$IFCALC{((7&PSMASK) if PSMASK else 7)&(1<<INDEX)}dbLoadRecords("db/Picoscale.db", "BASE=$$BASE,N=$$CALC{INDEX+1},CH=$$INDEX,PS=PS$$INDEX1")$$ENDIF(CALC)
$$ENDIF(PSLOC)
$$ENDLOOP(COUNT)
$$ENDIF(ALL)
$$ENDLOOP(SMARACT)

# reset our MODNUM iterator
$$ASSIGN{MODNUM,1}
$$ASSIGN{PREVMOD,10}
$$LOOP(AXIS)
$$IF(MODULE)
$$ASSIGN{MODNUM,$$MODULE}
$$ELSE(MODULE)
$$ASSIGN{J,$$CHANNEL-1}
$$ASSIGN{MODNUM,(($$J+3)-($$J%3))/3}
$$ENDIF(MODULE)
$$IFCALC{($$MODNUM/$$PREVMOD)-1}
# Initialize Sensor Module $$CALC{$$MODNUM,%d}
dbLoadRecords("db/SmarAct_module.db", "BASE=$$IF(BASE,$$BASE,$$SMARACTBASE),CH1=$$CALC{$$MODNUM*3-3,%d},CH2=$$CALC{$$MODNUM*3-2,%d},CH3=$$CALC{$$MODNUM*3-1,%d},MOD=$$CALC{$$MODNUM-1,%d},PORT=MCS$$SMARACTINDEX,TCP=TCP$$SMARACTINDEX")
$$ELSE(CALC)
$$ENDIF(CALC)
dbLoadRecords("db/SmarAct.db", "BASE=$$IF(BASE,$$BASE,$$SMARACTBASE),N=$$CHANNEL,CH=$$CALC{CHANNEL-1},MOD=$$CALC{$$MODNUM-1,%d},PORT=MCS$$SMARACTINDEX,TCP=TCP$$SMARACTINDEX,PSEN=$$IF(SMARACTPSLOC)$$CALC{1 if ((7&SMARACTPSMASK) if SMARACTPSMASK else 7)&(1<<(CHANNEL-1)) else 0}$$ELSE(SMARACTPSLOC)0$$ENDIF(SMARACTPSLOC)")
$$IFCALC{((7&SMARACTPSMASK) if SMARACTPSMASK else 7)&(1<<(CHANNEL-1))}dbLoadRecords("db/PicoScaleChannel.db", "BASE=$$BASE,N=$$CHANNEL,CH=$$CALC{CHANNEL-1},PS=PS$$SMARACTINDEX")$$ENDIF(CALC)
$$ASSIGN{PREVMOD,$$MODNUM}
$$ENDLOOP(AXIS)

# Let's assign our aliases
$$LOOP(ALIAS)
dbLoadRecords("db/alias.db", "RECORD=$$RECORD,ALIAS=$$ALIAS")
$$ENDLOOP(ALIAS)

# Trajectory stuff?!?

# Setup autosave
set_savefile_path("$(IOC_DATA)/$(IOC)/autosave")
set_requestfile_path("$(TOP)/autosave")
# Also look in the iocData autosave folder for auto generated req files
set_requestfile_path( "$(IOC_DATA)/$(IOC)/autosave" )
save_restoreSet_status_prefix("$(IOC_PV):")
save_restoreSet_IncompleteSetsOk(1)
save_restoreSet_DatedBackupFiles(1)

# Just restore the settings
set_pass0_restoreFile( "autoSettings.sav" )
set_pass0_restoreFile("$$IOCNAME.sav")

# Configure access security: this is required for caPutLog
asSetFilename("$(IOCTOP)/iocBoot/templates/default.acf")

# Setting the caPutLog file location
caPutLogFile("$(IOC_DATA)/$(IOC)/logs/caPutLog.log")

# Initialize the IOC and start processing records
iocInit()

# Create autosave files from info directives
makeAutosaveFileFromDbInfo( "$(IOC_DATA)/$(IOC)/autosave/autoSettings.req", "autosaveFields" )

# Start autosave backups
create_monitor_set( "autoSettings.req", 5, "" )
create_monitor_set("$$IOCNAME.req", 5, "")

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

# Start caPutLog
# caPutLogInit("HOST:PORT", config)
# config options:
#       caPutLogNone       -1: no logging (disable)
#       caPutLogOnChange    0: log only on value change
#       caPutLogAll         1: log all puts
#       caPutLogAllNoFilter 2: log all puts no filtering on same PV
caPutLogInit("${EPICS_CAPUTLOG_HOST}:${EPICS_CAPUTLOG_PORT}", 0)

# Let's quickly check if there are incompatible configs on any channels in the sensor modules
$$LOOP(SMARACT)
$$IF(PSLOC)
$$ENDIF(PSLOC)
$$IF(ALL)
$$ASSIGN{MODNUM,1}
$$LOOP(COUNT)
$$IFCALC{($$INDEX+1)%3}$$ELSE(CALC)
dbpf("$$IF(BASE,$$BASE,$$SMARACTBASE):MOD$$CALC{$$MODNUM-1,%d}:CHECK_SENSORS.PROC", "1")
$$ASSIGN{MODNUM,$$MODNUM+1}
$$ENDIF(CALC)
$$IF(PSLOC)
$$ENDIF(PSLOC)
$$ENDLOOP(COUNT)
$$ENDIF(ALL)
$$ENDLOOP(SMARACT)

$$ASSIGN{MODNUM,1}
$$ASSIGN{PREVMOD,10}
$$LOOP(AXIS)
$$IF(MODULE)
$$ASSIGN{MODNUM,$$MODULE}
$$ELSE(MODULE)
$$ASSIGN{J,$$CHANNEL-1}
$$ASSIGN{MODNUM,(($$J+3)-($$J%3))/3}
$$ENDIF(MODULE)
$$IFCALC{($$MODNUM/$$PREVMOD)-1}
dbpf("$$IF(BASE,$$BASE,$$SMARACTBASE):MOD$$CALC{$$MODNUM-1,%d}:CHECK_SENSORS.PROC", "1")
$$ELSE(CALC)
$$ENDIF(CALC)
$$ASSIGN{PREVMOD,$$MODNUM}
$$ENDLOOP(AXIS)
