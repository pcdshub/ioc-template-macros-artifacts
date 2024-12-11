#!$$IOCTOP/bin/$$IF(ARCH,$$ARCH,linux-x86_64)/analogScaleOffset

< envPaths
epicsEnvSet("IOCNAME", "$$IOCNAME" )
epicsEnvSet("ENGINEER", "$$ENGINEER" )
epicsEnvSet("LOCATION", "$$LOCATION" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "$$IOC_PV")
epicsEnvSet("IOCTOP", "$$IOCTOP")
epicsEnvSet("TOP", "$$TOP")

cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase( "dbd/analogScaleOffset.dbd" )
analogScaleOffset_registerRecordDeviceDriver(pdbbase)


# Load record instances
dbLoadRecords( "db/iocSoft.db",             "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db",  "IOC=$(IOC_PV)" )
$$LOOP(ANALOG)
dbLoadRecords( "db/analogScaleOffset.db",   "DEV=$$NAME,NUM=$$NUM$$IF(AIN),ANLIN=$$AIN$$ENDIF(AIN)$$IF(AOUT),ANLOUT=$$AOUT$$ENDIF(AOUT)" )
$$ENDLOOP(ANALOG)

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