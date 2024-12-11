#!/reg/g/pcds/epics/ioc/common/aerotech/R1.2.1/bin/rhel7-x86_64/aerotech
epicsEnvSet("IOCNAME",    "ioc-xcs-ensemble-a" )
epicsEnvSet("ENGINEER",   "Michael Browne (mcbrowne)")
epicsEnvSet("LOCATION",   "XRT Alcove")
epicsEnvSet("IOCSH_PS1",  "$(IOCNAME)> ")
epicsEnvSet("IOC_PV",     "IOC:XCS:ENS:A")
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

drvAsynIPPortConfigure("TCP0", "aerotech-ics-a:8000 TCP", 0, 0, 0 )
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
EnsembleAsynConfig(0, "TCP0", 0, 9, 100, 1000)

#   (1) Asyn port
#   (2) Driver name
#   (3) Controller index
#   (4) Max. number of axes
drvAsynMotorConfigure("AeroE0","motorEnsemble",0,9)


# Load record instances
dbLoadRecords("db/iocSoft.db", "IOC=$(IOC_PV)")
#dbLoadRecords("db/save_restoreStatus.db", "IOC=$(IOC_PV)")
dbLoadRecords("db/save_restoreStatus.db", "P=$(IOC_PV):")
dbLoadRecords("db/AeroAsyn.db", "BASE=XCS:ENS:A,N=0,A=$(E0_AXIS0),PORT=AeroE0,TCP=TCP0")
dbLoadRecords("db/AeroAsyn.db", "BASE=XCS:ENS:A,N=1,A=$(E0_AXIS1),PORT=AeroE0,TCP=TCP0")
dbLoadRecords("db/AeroAsyn.db", "BASE=XCS:ENS:A,N=2,A=$(E0_AXIS2),PORT=AeroE0,TCP=TCP0")
dbLoadRecords("db/AeroAsyn.db", "BASE=XCS:ENS:A,N=3,A=$(E0_AXIS3),PORT=AeroE0,TCP=TCP0")
dbLoadRecords("db/AeroAsyn.db", "BASE=XCS:ENS:A,N=4,A=$(E0_AXIS4),PORT=AeroE0,TCP=TCP0")
dbLoadRecords("db/AeroAsyn.db", "BASE=XCS:ENS:A,N=5,A=$(E0_AXIS5),PORT=AeroE0,TCP=TCP0")
dbLoadRecords("db/AeroAsyn.db", "BASE=XCS:ENS:A,N=6,A=$(E0_AXIS6),PORT=AeroE0,TCP=TCP0")
dbLoadRecords("db/AeroAsyn.db", "BASE=XCS:ENS:A,N=7,A=$(E0_AXIS7),PORT=AeroE0,TCP=TCP0")
dbLoadRecords("db/AeroAsyn.db", "BASE=XCS:ENS:A,N=8,A=$(E0_AXIS8),PORT=AeroE0,TCP=TCP0")
dbLoadRecords("db/asynRecord.db", "P=XCS:ENS:A,R=:ASYN,PORT=TCP0,ADDR=0,OMAX=0,IMAX=0")
dbLoadRecords("db/aerotech_global.db", "BASE=XCS:ENS:A,PORT=TCP0,AXIS=0")
dbLoadRecords("db/aerotech_alias.db", "OLD=XCS:ENS:A:m0,NEW=XCS:SND:T4:X")
dbLoadRecords("db/aerotech_alias.db", "OLD=XCS:ENS:A:m1,NEW=XCS:SND:T4:TTH")
dbLoadRecords("db/aerotech_alias.db", "OLD=XCS:ENS:A:m2,NEW=XCS:SND:T3:X")
dbLoadRecords("db/aerotech_alias.db", "OLD=XCS:ENS:A:m3,NEW=XCS:SND:T3:TH")
dbLoadRecords("db/aerotech_alias.db", "OLD=XCS:ENS:A:m4,NEW=XCS:SND:DIA:DCC:Y")
dbLoadRecords("db/aerotech_alias.db", "OLD=XCS:ENS:A:m5,NEW=XCS:SND:DIA:DO:X")
dbLoadRecords("db/aerotech_alias.db", "OLD=XCS:ENS:A:m6,NEW=XCS:SND:DIA:DCO:X")
dbLoadRecords("db/aerotech_alias.db", "OLD=XCS:ENS:A:m7,NEW=XCS:SND:DIA:DCC:X")
dbLoadRecords("db/aerotech_alias.db", "OLD=XCS:ENS:A:m8,NEW=XCS:SND:T4:L")

dbLoadRecords("db/estop.db", "SENSOR=XCS:SND:N2:T4:GPS,VALUE=1,COND=A=B,MOTOR=XCS:ENS:A:m0")
dbLoadRecords("db/estop.db", "SENSOR=XCS:SND:N2:T4:GPS,VALUE=1,COND=A=B,MOTOR=XCS:ENS:A:m1")
dbLoadRecords("db/estop.db", "SENSOR=XCS:SND:N2:T4:GPS,VALUE=1,COND=A=B,MOTOR=XCS:ENS:A:m8")

# Analog Track
dbLoadRecords("db/aerotech_analog_track.db", "BASE=XCS:ENS:A,AXIS=0,PORT=TCP0")
dbLoadRecords("db/aerotech_analog_track.db", "BASE=XCS:ENS:A,AXIS=0,PORT=TCP1")
dbLoadRecords("db/aerotech_analog_track.db", "BASE=XCS:ENS:A,AXIS=0,PORT=TCP2")
dbLoadRecords("db/aerotech_analog_track.db", "BASE=XCS:ENS:A,AXIS=0,PORT=TCP3")
dbLoadRecords("db/aerotech_analog_track.db", "BASE=XCS:ENS:A,AXIS=0,PORT=TCP4")
dbLoadRecords("db/aerotech_analog_track.db", "BASE=XCS:ENS:A,AXIS=0,PORT=TCP5")
dbLoadRecords("db/aerotech_analog_track.db", "BASE=XCS:ENS:A,AXIS=0,PORT=TCP6")
dbLoadRecords("db/aerotech_analog_track.db", "BASE=XCS:ENS:A,AXIS=0,PORT=TCP7")
dbLoadRecords("db/aerotech_analog_track.db", "BASE=XCS:ENS:A,AXIS=0,PORT=TCP8")
# ##################


# Trajectory stuff?!?

# Setup autosave
set_savefile_path("$(IOC_DATA)/$(IOC)/autosave")
set_requestfile_path("$(TOP)/autosave")
save_restoreSet_status_prefix("$(IOC_PV):")
save_restoreSet_IncompleteSetsOk(1)
save_restoreSet_DatedBackupFiles(1)

# Just restore the settings
set_pass0_restoreFile("ioc-xcs-ensemble-a.sav")
set_pass1_restoreFile("ioc-xcs-ensemble-a.sav")

# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set("ioc-xcs-ensemble-a.req", 5, "")

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
