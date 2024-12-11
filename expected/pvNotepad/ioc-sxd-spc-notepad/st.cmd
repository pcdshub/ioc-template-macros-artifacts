#!/cds/group/pcds/epics/ioc/common/pvNotepad/R2.1.0/bin/rhel7-x86_64/pvNotepad

epicsEnvSet( "EPICS_NAME", "IOC:SXD:SPC:NOTEPAD" )
epicsEnvSet( "ENGINEER",  "Daniel Damiani (ddamiani)" )
epicsEnvSet( "LOCATION",  "SLAC:LCLS" )
epicsEnvSet( "IOCSH_PS1", "ioc-sxd-spc-notepad> ")
epicsEnvSet( "IOCTOP",       "/cds/group/pcds/epics/ioc/common/pvNotepad/R2.1.0" )
epicsEnvSet( "BUILD_TOP",    "/reg/g/pcds/epics/ioc/det/pvNotepad/R1.0.4/build" )
epicsEnvSet( "EPICS_PVA_AUTO_ADDR_LIST",         "TRUE" )
epicsEnvSet( "EPICS_PVAS_AUTO_BEACON_ADDR_LIST", "TRUE" )

< envPaths

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("$(TOP)/dbd/pvNotepad.dbd")
pvNotepad_registerRecordDeviceDriver(pdbbase)

# Load record instances
dbLoadRecords("$(TOP)/db/iocSoft.db",            "IOC=$(EPICS_NAME)" )
dbLoadRecords("$(TOP)/db/save_restoreStatus.db", "P=$(EPICS_NAME):" )

#Standard array option

dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=SXD:SPC:ANDOR:TEMP")

# Setup autosave
save_restoreSet_status_prefix("$(EPICS_NAME):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

set_requestfile_path( "$(PWD)/../../autosave"             )
set_savefile_path   ( "$(IOC_DATA)/ioc-sxd-spc-notepad/autosave" )

set_pass0_restoreFile( "ioc-sxd-spc-notepad.sav" )        #just restore the settings
set_pass1_restoreFile( "ioc-sxd-spc-notepad.sav" )        #just restore the settings


# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set( "ioc-sxd-spc-notepad.req", 30, "" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

