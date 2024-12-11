#!/cds/group/pcds/epics/ioc/common/pvNotepad/R2.1.0/bin/rhel7-x86_64/pvNotepad

epicsEnvSet( "EPICS_NAME", "IOC:DET:PROT:NOTEPAD" )
epicsEnvSet( "ENGINEER",  "Daniel Damiani (ddamiani)" )
epicsEnvSet( "LOCATION",  "SLAC:LCLS:DET" )
epicsEnvSet( "IOCSH_PS1", "ioc-det-prot-notepad> ")
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

dbLoadRecords("$(TOP)/db/special_bo.db",     "PV=DET:PROT:PICKER:READ_DF,ZNAM=Open,ONAM=Closed,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_bo.db",     "PV=DET:PROT:PICKER:S_CLOSE,ZNAM=Trip,ONAM=No Trip,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_bo.db",     "PV=DET:PROT:TRIGGER,ZNAM=Trip,ONAM=No Trip,DTYP=Soft Channel")

# Setup autosave
save_restoreSet_status_prefix("$(EPICS_NAME):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

set_requestfile_path( "$(PWD)/../../autosave"             )
set_savefile_path   ( "$(IOC_DATA)/ioc-det-prot-notepad/autosave" )

set_pass0_restoreFile( "ioc-det-prot-notepad.sav" )        #just restore the settings
set_pass1_restoreFile( "ioc-det-prot-notepad.sav" )        #just restore the settings


# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set( "ioc-det-prot-notepad.req", 30, "" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

