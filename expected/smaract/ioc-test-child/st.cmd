#!/reg/g/pcds/epics/ioc/common/smaract/R1.0.25/bin/rhel7-x86_64/smaract
epicsEnvSet("IOCNAME",    "ioc-test-child" )
epicsEnvSet("ENGINEER",   "Michael Browne (mcbrowne)")
epicsEnvSet("LOCATION",   "Laser Hole")
epicsEnvSet("IOCSH_PS1",  "$(IOCNAME)> ")
epicsEnvSet("IOC_PV",     "IOC:LAS:MCS2:01")
epicsEnvSet("EVRID_PMC",  "1")
epicsEnvSet("EVRID_SLAC", "15")
epicsEnvSet("EVRDB_PMC",  "db/evrPmc230.db")
epicsEnvSet("EVRDB_SLAC", "db/evrSLAC.db")
epicsEnvSet("IOCTOP",     "/reg/g/pcds/epics/ioc/common/smaract/R1.0.25")
epicsEnvSet("STREAM_PROTOCOL_PATH", "$(IOCTOP)/protocol")
< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/common/smaract/R1.0.25/children/build")

cd("$(IOCTOP)")

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/smaract.dbd")
smaract_registerRecordDeviceDriver(pdbbase)

ErDebugLevel( 0 )

# Initialize EVR
ErConfigure( 0, 0, 0, 0, $(EVRID_SLAC) )

# Load EVR record instances
dbLoadRecords( $(EVRDB_SLAC), "IOC=IOC:LAS:MCS2:01,EVR=EVR:LAS:MCS2,CARD=0" )

drvAsynIPPortConfigure("TCP0", "mcs-las-tst03:55551 TCP", 0, 0, 0 )
#asynSetTraceMask(  "TCP0",	0, 9)
#asynSetTraceIOMask("TCP0",	0, 2)
asynOctetSetInputEos("TCP0",0,"\r\n")
asynOctetSetOutputEos("TCP0",0,"\r\n")


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

smarActMCS2CreateController("MCS0", "TCP0", 10, 0.07, 1.0)
smarActMCS2CreateAxis("MCS0",1,0)
smarActMCS2CreateAxis("MCS0",2,1)
smarActMCS2CreateAxis("MCS0",4,3)
smarActMCS2CreateAxis("MCS0",5,4)
smarActMCS2CreateAxis("MCS0",7,6)
smarActMCS2CreateAxis("MCS0",8,7)
smarActMCS2CreateAxis("MCS0",10,9)
smarActMCS2CreateAxis("MCS0",12,11)
smarActMCS2CreateAxis("MCS0",13,12)
smarActMCS2CreateAxis("MCS0",14,13)
smarActMCS2CreateAxis("MCS0",16,15)

# Load record instances
dbLoadRecords("db/iocSoft.db", "IOC=$(IOC_PV)")
dbLoadRecords("db/save_restoreStatus.db", "IOC=$(IOC_PV),P=$(IOC_PV):")

dbLoadRecords("db/asynRecord.db", "P=LAS:TST:MCS2:02,R=:ASYN,PORT=TCP0,ADDR=0,OMAX=0,IMAX=0")
dbLoadRecords("db/SmarAct_global.db", "BASE=LAS:TST:MCS2:02,DEF_EC=40,TCP=TCP0")

# reset our MODNUM iterator

# Initialize Sensor Module 1
dbLoadRecords("db/SmarAct_module.db", "BASE=LAS:TST:MCS2:02,CH1=0,CH2=1,CH3=2,MOD=0,PORT=MCS0,TCP=TCP0")
dbLoadRecords("db/SmarAct.db", "BASE=LAS:TST:MCS2:02,N=1,CH=0,MOD=0,PORT=MCS0,TCP=TCP0,PSEN=0")
dbLoadRecords("db/PicoScaleChannel.db", "BASE=,N=1,CH=0,PS=PS0")
dbLoadRecords("db/SmarAct.db", "BASE=LAS:TST:MCS2:02,N=2,CH=1,MOD=0,PORT=MCS0,TCP=TCP0,PSEN=0")
dbLoadRecords("db/PicoScaleChannel.db", "BASE=,N=2,CH=1,PS=PS0")

# Initialize Sensor Module 2
dbLoadRecords("db/SmarAct_module.db", "BASE=LAS:TST:MCS2:02,CH1=3,CH2=4,CH3=5,MOD=1,PORT=MCS0,TCP=TCP0")
dbLoadRecords("db/SmarAct.db", "BASE=LAS:TST:MCS2:02,N=4,CH=3,MOD=1,PORT=MCS0,TCP=TCP0,PSEN=0")

dbLoadRecords("db/SmarAct.db", "BASE=LAS:TST:MCS2:02,N=5,CH=4,MOD=1,PORT=MCS0,TCP=TCP0,PSEN=0")


# Initialize Sensor Module 3
dbLoadRecords("db/SmarAct_module.db", "BASE=LAS:TST:MCS2:02,CH1=6,CH2=7,CH3=8,MOD=2,PORT=MCS0,TCP=TCP0")
dbLoadRecords("db/SmarAct.db", "BASE=LAS:TST:MCS2:02,N=7,CH=6,MOD=2,PORT=MCS0,TCP=TCP0,PSEN=0")

dbLoadRecords("db/SmarAct.db", "BASE=LAS:TST:MCS2:02,N=8,CH=7,MOD=2,PORT=MCS0,TCP=TCP0,PSEN=0")


# Initialize Sensor Module 4
dbLoadRecords("db/SmarAct_module.db", "BASE=LAS:TST:MCS2:02,CH1=9,CH2=10,CH3=11,MOD=3,PORT=MCS0,TCP=TCP0")
dbLoadRecords("db/SmarAct.db", "BASE=LAS:TST:MCS2:02,N=10,CH=9,MOD=3,PORT=MCS0,TCP=TCP0,PSEN=0")

dbLoadRecords("db/SmarAct.db", "BASE=LAS:TST:MCS2:02,N=12,CH=11,MOD=3,PORT=MCS0,TCP=TCP0,PSEN=0")


# Initialize Sensor Module 5
dbLoadRecords("db/SmarAct_module.db", "BASE=LAS:TST:MCS2:02,CH1=12,CH2=13,CH3=14,MOD=4,PORT=MCS0,TCP=TCP0")
dbLoadRecords("db/SmarAct.db", "BASE=LAS:TST:MCS2:02,N=13,CH=12,MOD=4,PORT=MCS0,TCP=TCP0,PSEN=0")

dbLoadRecords("db/SmarAct.db", "BASE=LAS:TST:MCS2:02,N=14,CH=13,MOD=4,PORT=MCS0,TCP=TCP0,PSEN=0")


# Initialize Sensor Module 6
dbLoadRecords("db/SmarAct_module.db", "BASE=LAS:TST:MCS2:02,CH1=15,CH2=16,CH3=17,MOD=5,PORT=MCS0,TCP=TCP0")
dbLoadRecords("db/SmarAct.db", "BASE=LAS:TST:MCS2:02,N=16,CH=15,MOD=5,PORT=MCS0,TCP=TCP0,PSEN=0")


# Let's assign our aliases
dbLoadRecords("db/alias.db", "RECORD=LAS:TST:MCS2:02:m1,ALIAS=TEST:TEST_STAGE_A")
dbLoadRecords("db/alias.db", "RECORD=LAS:TST:MCS2:02:m2,ALIAS=TEST:TEST_STAGE_B")
dbLoadRecords("db/alias.db", "RECORD=LAS:TST:MCS2:02:m4,ALIAS=TEST:TEST_STAGE_C")
dbLoadRecords("db/alias.db", "RECORD=LAS:TST:MCS2:02:m5,ALIAS=TEST:TEST_STAGE_D")
dbLoadRecords("db/alias.db", "RECORD=LAS:TST:MCS2:02:m7,ALIAS=TEST:TEST_STAGE_E")
dbLoadRecords("db/alias.db", "RECORD=LAS:TST:MCS2:02:m8,ALIAS=TEST:TEST_STAGE_F")
dbLoadRecords("db/alias.db", "RECORD=LAS:TEST:MCS2:02:m10,ALIAS=TEST:TEST_STAGE_G")
dbLoadRecords("db/alias.db", "RECORD=LAS:TEST:MCS2:02:m12,ALIAS=TEST:TEST_STAGE_H")
dbLoadRecords("db/alias.db", "RECORD=LAS:TEST:MCS2:02:m13,ALIAS=TEST:TEST_STAGE_I")
dbLoadRecords("db/alias.db", "RECORD=LAS:TEST:MCS2:02:m14,ALIAS=TEST:TEST_STAGE_J")
dbLoadRecords("db/alias.db", "RECORD=LAS:TEST:MCS2:02:m16,ALIAS=TEST:TEST_STAGE_K")

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
set_pass0_restoreFile("ioc-test-child.sav")

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
create_monitor_set("ioc-test-child.req", 5, "")

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


dbpf("LAS:TST:MCS2:02:MOD0:CHECK_SENSORS.PROC", "1")

dbpf("LAS:TST:MCS2:02:MOD1:CHECK_SENSORS.PROC", "1")

dbpf("LAS:TST:MCS2:02:MOD2:CHECK_SENSORS.PROC", "1")

dbpf("LAS:TST:MCS2:02:MOD3:CHECK_SENSORS.PROC", "1")

dbpf("LAS:TST:MCS2:02:MOD4:CHECK_SENSORS.PROC", "1")

dbpf("LAS:TST:MCS2:02:MOD5:CHECK_SENSORS.PROC", "1")
