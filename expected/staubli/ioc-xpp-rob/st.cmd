#!/reg/g/pcds/package/epics/3.14/ioc/common/staubli/R1.3.0/bin/rhel7-x86_64/staubli

< envPaths
epicsEnvSet("IOCNAME", "ioc-xpp-rob" )
epicsEnvSet("ENGINEER", "Esposito Vincent (espov)" )
epicsEnvSet("LOCATION", "IOC:XPP:ROB" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "IOC:XPP:ROB")
epicsEnvSet("IOCTOP", "/reg/g/pcds/package/epics/3.14/ioc/common/staubli/R1.3.0")
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/xpp/staubli/R1.3.0/build")
## Add the path to the protocol files
epicsEnvSet("STREAM_PROTOCOL_PATH", "$(IOCTOP)/staubliApp/protocols")

cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/staubli.dbd")
staubli_registerRecordDeviceDriver(pdbbase)
#------------------------------------------------------------------------------
# Asyn support

## Asyn record support
dbLoadRecords("$(ASYN)/db/asynRecord.db","P=XPP:ROB,R=:asyn,PORT=bus0,ADDR=0,OMAX=0,IMAX=0")
drvAsynIPPortConfigure ("bus0","172.21.46.25:6000 TCP", 0, 0, 0)

# Asyn tracing settings
asynSetTraceMask("bus0", 0, 0x1) # logging for normal operation

# Load record instances
dbLoadRecords( "db/iocSoft.db",             "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db",  "P=$(IOC_PV):" )

# Load robot control
dbLoadRecords("db/staubli.db",       "NAME=XPP:ROB,bus=bus0,IOC_PV=$(IOC_PV)")
dbLoadRecords("db/staubli_mov.db",   "NAME=XPP:ROB,bus=bus0")
dbLoadRecords("db/staubli_abs_base.db",   "NAME=XPP:ROB,bus=bus0")
dbLoadRecords("db/staubli_abs_axes.db",   "NAME=XPP:ROB,bus=bus0")
dbLoadRecords("db/staubli_coords_base.db",   "NAME=XPP:ROB,bus=bus0")
dbLoadRecords("db/staubli_coord_ch.db",   "NAME=XPP:ROB,bus=bus0")
dbLoadRecords("db/staubli_world.db",   "NAME=XPP:ROB")
dbLoadRecords("db/staubli_joints.db",   "NAME=XPP:ROB")

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

