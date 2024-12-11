#!/reg/g/pcds/package/epics/3.14/ioc/common/analogScaleOffset/R0.9.1/bin/linux-x86_64/analogScaleOffset

< envPaths
epicsEnvSet("IOCNAME", "ioc-xpp-analogScaleOffset" )
epicsEnvSet("ENGINEER", "Silke Nelson (snelson)" )
epicsEnvSet("LOCATION", "XPP:USER:REGULATOR" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "XPP:USER:REGULATOR")
epicsEnvSet("IOCTOP", "/reg/g/pcds/package/epics/3.14/ioc/common/analogScaleOffset/R0.9.1")
epicsEnvSet("TOP", "/reg/g/pcds/package/epics/3.14/ioc/xpp/analogScaleOffset/R1.0.0/build")

cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase( "dbd/analogScaleOffset.dbd" )
analogScaleOffset_registerRecordDeviceDriver(pdbbase)


# Load record instances
dbLoadRecords( "db/iocSoft.db",             "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db",  "IOC=$(IOC_PV)" )
dbLoadRecords( "db/analogScaleOffset.db",   "DEV=XPP:USR:OXY,NUM=01,ANLIN=XPP:USR:ai1:7" )

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
create_monitor_set( "$(IOCNAME).req", 5 )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

#End of st.cmd
