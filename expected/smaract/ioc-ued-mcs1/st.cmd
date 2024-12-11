#!/reg/g/pcds/epics/ioc/common/smaract/R1.0.8/bin/rhel7-x86_64/smaract
epicsEnvSet("IOCNAME",    "ioc-ued-mcs1" )
epicsEnvSet("ENGINEER",   "Michael Browne (mcbrowne)")
epicsEnvSet("LOCATION",   "UED")
epicsEnvSet("IOCSH_PS1",  "$(IOCNAME)> ")
epicsEnvSet("IOC_PV",     "IOC:UED:MCS:01")
epicsEnvSet("EVRID_PMC",  "1")
epicsEnvSet("EVRID_SLAC", "15")
epicsEnvSet("EVRDB_PMC",  "db/evrPmc230.db")
epicsEnvSet("EVRDB_SLAC", "db/evrSLAC.db")
epicsEnvSet("IOCTOP",     "/reg/g/pcds/epics/ioc/common/smaract/R1.0.8")
epicsEnvSet("STREAM_PROTOCOL_PATH", "$(IOCTOP)/protocol")
epicsEnvSet( "EPICS_PVA_AUTO_ADDR_LIST",         "TRUE" )
epicsEnvSet( "EPICS_PVAS_AUTO_BEACON_ADDR_LIST", "TRUE" )
< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/ued/smaract/R1.0.0/build")
cd("$(IOCTOP)")

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/smaract.dbd")
smaract_registerRecordDeviceDriver(pdbbase)


drvAsynIPPortConfigure("TCP0", "mcs-ued-01:55551 TCP", 0, 0, 0 )
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
smarActMCS2CreateAxis("MCS0",3,2)
smarActMCS2CreateAxis("MCS0",4,3)
smarActMCS2CreateAxis("MCS0",5,4)
smarActMCS2CreateAxis("MCS0",6,5)
smarActMCS2CreateAxis("MCS0",7,6)
smarActMCS2CreateAxis("MCS0",8,7)
smarActMCS2CreateAxis("MCS0",9,8)

# Load record instances
dbLoadRecords("db/iocSoft.db", "IOC=$(IOC_PV)")
dbLoadRecords("db/save_restoreStatus.db", "IOC=$(IOC_PV)")
dbLoadRecords("db/asynRecord.db", "P=UED:MCS:01,R=:ASYN,PORT=TCP0,ADDR=0,OMAX=0,IMAX=0")
dbLoadRecords("db/SmarAct_global.db", "BASE=UED:MCS:01,DEF_EC=0")
dbLoadRecords("db/SmarAct.db", "BASE=UED:MCS:01,N=1,CH=0,PORT=MCS0,TCP=TCP0")
dbLoadRecords("db/SmarAct.db", "BASE=UED:MCS:01,N=2,CH=1,PORT=MCS0,TCP=TCP0")
dbLoadRecords("db/SmarAct.db", "BASE=UED:MCS:01,N=3,CH=2,PORT=MCS0,TCP=TCP0")
dbLoadRecords("db/SmarAct.db", "BASE=UED:MCS:01,N=4,CH=3,PORT=MCS0,TCP=TCP0")
dbLoadRecords("db/SmarAct.db", "BASE=UED:MCS:01,N=5,CH=4,PORT=MCS0,TCP=TCP0")
dbLoadRecords("db/SmarAct.db", "BASE=UED:MCS:01,N=6,CH=5,PORT=MCS0,TCP=TCP0")
dbLoadRecords("db/SmarAct.db", "BASE=UED:MCS:01,N=7,CH=6,PORT=MCS0,TCP=TCP0")
dbLoadRecords("db/SmarAct.db", "BASE=UED:MCS:01,N=8,CH=7,PORT=MCS0,TCP=TCP0")
dbLoadRecords("db/SmarAct.db", "BASE=UED:MCS:01,N=9,CH=8,PORT=MCS0,TCP=TCP0")

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
set_pass0_restoreFile("ioc-ued-mcs1.sav")

# Initialize the IOC and start processing records
iocInit()

# Create autosave files from info directives
makeAutosaveFileFromDbInfo( "$(IOC_DATA)/$(IOC)/autosave/autoSettings.req", "autosaveFields" )

# Start autosave backups
create_monitor_set( "autoSettings.req", 5, "" )
create_monitor_set("ioc-ued-mcs1.req", 5, "")

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
