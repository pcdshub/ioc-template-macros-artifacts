#!/reg/g/pcds/epics/ioc/common/aerotech/R1.2.1/bin/rhel7-x86_64/aerotech
epicsEnvSet("IOCNAME",    "ioc-xcs-ensemble-c" )
epicsEnvSet("ENGINEER",   "Michael Browne (mcbrowne)")
epicsEnvSet("LOCATION",   "XRT Alcove")
epicsEnvSet("IOCSH_PS1",  "$(IOCNAME)> ")
epicsEnvSet("IOC_PV",     "IOC:XCS:ENS:C")
epicsEnvSet("IOCTOP",     "/reg/g/pcds/epics/ioc/common/aerotech/R1.2.1")
epicsEnvSet("STREAM_PROTOCOL_PATH", "$(IOCTOP)/protocol")
< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/common/aerotech/R1.2.1/children/build")
cd("$(IOCTOP)")

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/aerotech.dbd")
aerotech_registerRecordDeviceDriver(pdbbase)

#
# Sigh.  Motor number != Ensemble axis number.  If all axes are used,
# they are the same... but let's add the ability to dynamically leave
# gaps by defining Am=n in the config file.
#
epicsEnvSet("E0_AXIS0", 0)
epicsEnvSet("E0_AXIS1", 1)
epicsEnvSet("E0_AXIS2", 2)
epicsEnvSet("E0_AXIS3", 3)
epicsEnvSet("E0_AXIS4", 4)
epicsEnvSet("E0_AXIS5", 5)
epicsEnvSet("E0_AXIS6", 6)
epicsEnvSet("E0_AXIS7", 7)
epicsEnvSet("E0_AXIS8", 8)
epicsEnvSet("E0_AXIS9", 9)

drvAsynIPPortConfigure("TCP0", "aerotech-ics-c:8000 TCP", 0, 0, 0 )
#asynSetTraceMask(  "TCP0",	0,		9)
#asynSetTraceIOMask("TCP0",	0,		2)

EnsembleAsynSetup(1)

asynOctetSetInputEos("TCP0",0,"\n")
asynOctetSetOutputEos("TCP0",0,"\n")

#     (1) Controller number being configured
#     (2) ASYN port name
#     (3) ASYN address (GPIB only)
#     (4) Number of axes this controller supports
#     (5) Time to poll (msec) when an axis is in motion
#     (6) Time to poll (msec) when an axis is idle. 0 for no polling
EnsembleAsynConfig(0, "TCP0", 0, 4, 100, 1000)

#   (1) Asyn port
#   (2) Driver name
#   (3) Controller index
#   (4) Max. number of axes
drvAsynMotorConfigure("AeroE0","motorEnsemble",0,4)


# Load record instances
dbLoadRecords("db/iocSoft.db", "IOC=$(IOC_PV)")
#dbLoadRecords("db/save_restoreStatus.db", "IOC=$(IOC_PV)")
dbLoadRecords("db/save_restoreStatus.db", "P=$(IOC_PV):")
dbLoadRecords("db/AeroAsyn.db", "BASE=XCS:ENS:C,N=0,A=$(E0_AXIS0),PORT=AeroE0,TCP=TCP0")
dbLoadRecords("db/AeroAsyn.db", "BASE=XCS:ENS:C,N=1,A=$(E0_AXIS1),PORT=AeroE0,TCP=TCP0")
dbLoadRecords("db/AeroAsyn.db", "BASE=XCS:ENS:C,N=2,A=$(E0_AXIS2),PORT=AeroE0,TCP=TCP0")
dbLoadRecords("db/AeroAsyn.db", "BASE=XCS:ENS:C,N=3,A=$(E0_AXIS3),PORT=AeroE0,TCP=TCP0")
dbLoadRecords("db/asynRecord.db", "P=XCS:ENS:C,R=:ASYN,PORT=TCP0,ADDR=0,OMAX=0,IMAX=0")
dbLoadRecords("db/aerotech_global.db", "BASE=XCS:ENS:C,PORT=TCP0,AXIS=0")
dbLoadRecords("db/aerotech_alias.db", "OLD=XCS:ENS:C:m0,NEW=XCS:SND:T1:TH1")
dbLoadRecords("db/aerotech_alias.db", "OLD=XCS:ENS:C:m1,NEW=XCS:SND:T1:TH2")
dbLoadRecords("db/aerotech_alias.db", "OLD=XCS:ENS:C:m2,NEW=XCS:SND:T4:TH1")
dbLoadRecords("db/aerotech_alias.db", "OLD=XCS:ENS:C:m3,NEW=XCS:SND:T4:TH2")


# Analog Track
dbLoadRecords("db/aerotech_analog_track.db", "BASE=XCS:ENS:C,AXIS=0,PORT=TCP0")
dbLoadRecords("db/aerotech_analog_track.db", "BASE=XCS:ENS:C,AXIS=0,PORT=TCP1")
dbLoadRecords("db/aerotech_analog_track.db", "BASE=XCS:ENS:C,AXIS=0,PORT=TCP2")
dbLoadRecords("db/aerotech_analog_track.db", "BASE=XCS:ENS:C,AXIS=0,PORT=TCP3")
# ##################


# Trajectory stuff?!?

# Setup autosave
set_savefile_path("$(IOC_DATA)/$(IOC)/autosave")
set_requestfile_path("$(TOP)/autosave")
save_restoreSet_status_prefix("$(IOC_PV):")
save_restoreSet_IncompleteSetsOk(1)
save_restoreSet_DatedBackupFiles(1)

# Just restore the settings
set_pass0_restoreFile("ioc-xcs-ensemble-c.sav")
set_pass1_restoreFile("ioc-xcs-ensemble-c.sav")

# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set("ioc-xcs-ensemble-c.req", 5, "")

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
