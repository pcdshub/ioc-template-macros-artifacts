#!/cds/group/pcds/epics/ioc/common/smaract/R1.0.23/bin/rhel7-x86_64/smaract
epicsEnvSet("IOCNAME",    "ioc-las-opcpa-mcs2-02" )
epicsEnvSet("ENGINEER",   "tjohnson")
epicsEnvSet("LOCATION",   "Laser Hall Bay 2 Table")
epicsEnvSet("IOCSH_PS1",  "$(IOCNAME)> ")
epicsEnvSet("IOC_PV",     "IOC:LAS:OPCPA:MCS2:02")
epicsEnvSet("EVRID_PMC",  "1")
epicsEnvSet("EVRID_SLAC", "15")
epicsEnvSet("EVRDB_PMC",  "db/evrPmc230.db")
epicsEnvSet("EVRDB_SLAC", "db/evrSLAC.db")
epicsEnvSet("IOCTOP",     "/cds/group/pcds/epics/ioc/common/smaract/R1.0.23")
epicsEnvSet("STREAM_PROTOCOL_PATH", "$(IOCTOP)/protocol")
< envPaths
epicsEnvSet("TOP", "/cds/group/pcds/epics/ioc/las/smaract/R1.0.7/build")

cd("$(IOCTOP)")

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/smaract.dbd")
smaract_registerRecordDeviceDriver(pdbbase)


drvAsynIPPortConfigure("TCP0", "mcp-las-opcpa-02:55551 TCP", 0, 0, 0 )
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

smarActMCS2CreateController("MCS0", "TCP0", 4, 0.2, 1.0)
smarActMCS2CreateAxis("MCS0",1,0)
smarActMCS2CreateAxis("MCS0",2,1)
smarActMCS2CreateAxis("MCS0",3,2)

# Load record instances
dbLoadRecords("db/iocSoft.db", "IOC=$(IOC_PV)")
dbLoadRecords("db/save_restoreStatus.db", "IOC=$(IOC_PV),P=$(IOC_PV):")

dbLoadRecords("db/asynRecord.db", "P=LAS:OPCPA:MCS2:02,R=:ASYN,PORT=TCP0,ADDR=0,OMAX=0,IMAX=0")
dbLoadRecords("db/SmarAct_global.db", "BASE=LAS:OPCPA:MCS2:02,DEF_EC=0")
dbLoadRecords("db/SmarAct.db", "BASE=LAS:OPCPA:MCS2:02,N=1,CH=0,MOD=0,PORT=MCS0,TCP=TCP0,PSEN=0")
dbLoadRecords("db/SmarAct.db", "BASE=LAS:OPCPA:MCS2:02,N=2,CH=1,MOD=0,PORT=MCS0,TCP=TCP0,PSEN=0")
dbLoadRecords("db/SmarAct.db", "BASE=LAS:OPCPA:MCS2:02,N=3,CH=2,MOD=0,PORT=MCS0,TCP=TCP0,PSEN=0")
dbLoadRecords("db/SmarAct_module.db", "BASE=LAS:OPCPA:MCS2:02,CH1=0,CH2=1,CH3=2,MOD=0,PORT=MCS0,TCP=TCP0")

# reset our MODNUM iterator

# Let's assign our aliases

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
set_pass0_restoreFile("ioc-las-opcpa-mcs2-02.sav")

# Initialize the IOC and start processing records
iocInit()

# Create autosave files from info directives
makeAutosaveFileFromDbInfo( "$(IOC_DATA)/$(IOC)/autosave/autoSettings.req", "autosaveFields" )

# Start autosave backups
create_monitor_set( "autoSettings.req", 5, "" )
create_monitor_set("ioc-las-opcpa-mcs2-02.req", 5, "")

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

# Let's quickly check if there are incompatible configs on any channels in the sensor modules
dbpf("LAS:OPCPA:MCS2:02:MOD0:CHECK_SENSORS.PROC", "1")

