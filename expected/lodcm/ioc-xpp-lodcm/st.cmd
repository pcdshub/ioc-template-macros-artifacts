#!/reg/g/pcds/package/epics/3.14/ioc/common/lodcm/R1.0.0/bin/linux-x86_64/lodcm

< envPaths
epicsEnvSet("IOCNAME", "ioc-xpp-lodcm" )
epicsEnvSet("ENGINEER", "Daniel Damiani (ddamiani)" )
epicsEnvSet("LOCATION", "IOC:XPP:LODCM" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "IOC:XPP:LODCM")
epicsEnvSet("IOCTOP", "/reg/g/pcds/package/epics/3.14/ioc/common/lodcm/R1.0.0")
epicsEnvSet("TOP", "/reg/g/pcds/package/epics/3.14/ioc/xpp/lodcm/R1.0.0/build")

cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/lodcm.dbd")
lodcm_registerRecordDeviceDriver(pdbbase)

# Load record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "IOC=$(IOC_PV)" )
dbLoadRecords( "db/lodcm.db", "NAME=XPP:LODCM,MPRE=XPP:LODCM" )

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
