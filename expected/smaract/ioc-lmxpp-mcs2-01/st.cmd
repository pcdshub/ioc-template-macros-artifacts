#!/reg/g/pcds/epics/ioc/common/smaract/R1.0.22/bin/rhel7-x86_64/smaract
epicsEnvSet("IOCNAME",    "ioc-lmxpp-mcs2-01" )
epicsEnvSet("ENGINEER",   "Tyler Johnson (tjohnson)")
epicsEnvSet("LOCATION",   "IP1 MODS Table")
epicsEnvSet("IOCSH_PS1",  "$(IOCNAME)> ")
epicsEnvSet("IOC_PV",     "IOC:LMXPP:MCS2:01")
epicsEnvSet("EVRID_PMC",  "1")
epicsEnvSet("EVRID_SLAC", "15")
epicsEnvSet("EVRDB_PMC",  "db/evrPmc230.db")
epicsEnvSet("EVRDB_SLAC", "db/evrSLAC.db")
epicsEnvSet("IOCTOP",     "/reg/g/pcds/epics/ioc/common/smaract/R1.0.22")
epicsEnvSet("STREAM_PROTOCOL_PATH", "$(IOCTOP)/protocol")
< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/xpp/smaract/R1.0.1/build")

cd("$(IOCTOP)")

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/smaract.dbd")
smaract_registerRecordDeviceDriver(pdbbase)


drvAsynIPPortConfigure("TCP0", "mcp-las-xpp-mods-01:55551 TCP", 0, 0, 0 )
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

smarActMCS2CreateController("MCS0", "TCP0", 16, 0.2, 1.0)
smarActMCS2CreateAxis("MCS0",1,0)
smarActMCS2CreateAxis("MCS0",2,1)
smarActMCS2CreateAxis("MCS0",3,2)
smarActMCS2CreateAxis("MCS0",4,3)
smarActMCS2CreateAxis("MCS0",5,4)
smarActMCS2CreateAxis("MCS0",6,5)
smarActMCS2CreateAxis("MCS0",7,6)
smarActMCS2CreateAxis("MCS0",8,7)
smarActMCS2CreateAxis("MCS0",9,8)
smarActMCS2CreateAxis("MCS0",10,9)
smarActMCS2CreateAxis("MCS0",11,10)
smarActMCS2CreateAxis("MCS0",12,11)
smarActMCS2CreateAxis("MCS0",13,12)
smarActMCS2CreateAxis("MCS0",14,13)
smarActMCS2CreateAxis("MCS0",15,14)

# Load record instances
dbLoadRecords("db/iocSoft.db", "IOC=$(IOC_PV)")
dbLoadRecords("db/save_restoreStatus.db", "IOC=$(IOC_PV),P=$(IOC_PV):")

dbLoadRecords("db/asynRecord.db", "P=LMXPP:MCS2:01,R=:ASYN,PORT=TCP0,ADDR=0,OMAX=0,IMAX=0")
dbLoadRecords("db/SmarAct_global.db", "BASE=LMXPP:MCS2:01,DEF_EC=0")

# reset our MODNUM iterator
dbLoadRecords("db/SmarAct.db", "BASE=LMXPP:MCS2:01,N=1,CH=0,MOD=0,PORT=MCS0,TCP=TCP0,PSEN=0")
dbLoadRecords("db/PicoScaleChannel.db", "BASE=,N=1,CH=0,PS=PS0")
dbLoadRecords("db/SmarAct.db", "BASE=LMXPP:MCS2:01,N=2,CH=1,MOD=0,PORT=MCS0,TCP=TCP0,PSEN=0")
dbLoadRecords("db/PicoScaleChannel.db", "BASE=,N=2,CH=1,PS=PS0")
dbLoadRecords("db/SmarAct.db", "BASE=LMXPP:MCS2:01,N=3,CH=2,MOD=0,PORT=MCS0,TCP=TCP0,PSEN=0")
dbLoadRecords("db/PicoScaleChannel.db", "BASE=,N=3,CH=2,PS=PS0")
dbLoadRecords("db/SmarAct.db", "BASE=LMXPP:MCS2:01,N=4,CH=3,MOD=1,PORT=MCS0,TCP=TCP0,PSEN=0")

dbLoadRecords("db/SmarAct.db", "BASE=LMXPP:MCS2:01,N=5,CH=4,MOD=1,PORT=MCS0,TCP=TCP0,PSEN=0")

dbLoadRecords("db/SmarAct.db", "BASE=LMXPP:MCS2:01,N=6,CH=5,MOD=1,PORT=MCS0,TCP=TCP0,PSEN=0")

dbLoadRecords("db/SmarAct.db", "BASE=LMXPP:MCS2:01,N=7,CH=6,MOD=2,PORT=MCS0,TCP=TCP0,PSEN=0")

dbLoadRecords("db/SmarAct.db", "BASE=LMXPP:MCS2:01,N=8,CH=7,MOD=2,PORT=MCS0,TCP=TCP0,PSEN=0")

dbLoadRecords("db/SmarAct.db", "BASE=LMXPP:MCS2:01,N=9,CH=8,MOD=2,PORT=MCS0,TCP=TCP0,PSEN=0")

dbLoadRecords("db/SmarAct.db", "BASE=LMXPP:MCS2:01,N=10,CH=9,MOD=3,PORT=MCS0,TCP=TCP0,PSEN=0")

dbLoadRecords("db/SmarAct.db", "BASE=LMXPP:MCS2:01,N=11,CH=10,MOD=3,PORT=MCS0,TCP=TCP0,PSEN=0")

dbLoadRecords("db/SmarAct.db", "BASE=LMXPP:MCS2:01,N=12,CH=11,MOD=3,PORT=MCS0,TCP=TCP0,PSEN=0")

dbLoadRecords("db/SmarAct.db", "BASE=LMXPP:MCS2:01,N=13,CH=12,MOD=4,PORT=MCS0,TCP=TCP0,PSEN=0")

dbLoadRecords("db/SmarAct.db", "BASE=LMXPP:MCS2:01,N=14,CH=13,MOD=4,PORT=MCS0,TCP=TCP0,PSEN=0")

dbLoadRecords("db/SmarAct.db", "BASE=LMXPP:MCS2:01,N=15,CH=14,MOD=4,PORT=MCS0,TCP=TCP0,PSEN=0")


dbLoadRecords("db/alias.db", "RECORD=LMXPP:MCS2:01:m1,ALIAS=LMXPP:INJ_MP1_MR1_TIP1")
dbLoadRecords("db/alias.db", "RECORD=LMXPP:MCS2:01:m2,ALIAS=LMXPP:INJ_MP1_MR1_TILT1")
dbLoadRecords("db/alias.db", "RECORD=LMXPP:MCS2:01:m3,ALIAS=LMXPP:INJ_MP1_ZOO1_LS2")
dbLoadRecords("db/alias.db", "RECORD=LMXPP:MCS2:01:m4,ALIAS=LMXPP:INJ_MP1_ZOO1_LS3")
dbLoadRecords("db/alias.db", "RECORD=LMXPP:MCS2:01:m5,ALIAS=LMXPP:INJ_MP1_MR3_TIP1")
dbLoadRecords("db/alias.db", "RECORD=LMXPP:MCS2:01:m6,ALIAS=LMXPP:INJ_MP1_MR3_TILT1")
dbLoadRecords("db/alias.db", "RECORD=LMXPP:MCS2:01:m7,ALIAS=LMXPP:INJ_MP1_MR4_TIP1")
dbLoadRecords("db/alias.db", "RECORD=LMXPP:MCS2:01:m8,ALIAS=LMXPP:INJ_MP1_MR4_TILT1")
dbLoadRecords("db/alias.db", "RECORD=LMXPP:MCS2:01:m9,ALIAS=LMXPP:NOT_USED")
dbLoadRecords("db/alias.db", "RECORD=LMXPP:MCS2:01:m10,ALIAS=LMXPP:USER_0")
dbLoadRecords("db/alias.db", "RECORD=LMXPP:MCS2:01:m11,ALIAS=LMXPP:USER_1")
dbLoadRecords("db/alias.db", "RECORD=LMXPP:MCS2:01:m12,ALIAS=LMXPP:USER_2")
dbLoadRecords("db/alias.db", "RECORD=LMXPP:MCS2:01:m13,ALIAS=LMXPP:USER_3")
dbLoadRecords("db/alias.db", "RECORD=LMXPP:MCS2:01:m14,ALIAS=LMXPP:USER_4")
dbLoadRecords("db/alias.db", "RECORD=LMXPP:MCS2:01:m15,ALIAS=LMXPP:USER_5")

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
set_pass0_restoreFile("ioc-lmxpp-mcs2-01.sav")

# Initialize the IOC and start processing records
iocInit()

# Create autosave files from info directives
makeAutosaveFileFromDbInfo( "$(IOC_DATA)/$(IOC)/autosave/autoSettings.req", "autosaveFields" )

# Start autosave backups
create_monitor_set( "autoSettings.req", 5, "" )
create_monitor_set("ioc-lmxpp-mcs2-01.req", 5, "")

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
