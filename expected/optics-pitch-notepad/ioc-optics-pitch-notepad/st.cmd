#!/reg/g/pcds/epics/ioc/common/pvNotepad/R2.0.1/bin/linux-x86_64/pvNotepad

epicsEnvSet( "EPICS_NAME", "IOC:OPTICS:PITCH:NOTEPAD" )
epicsEnvSet( "ENGINEER",  "engineer (engineer)" )
epicsEnvSet( "LOCATION",  "SLAC:LCLS" )
epicsEnvSet( "IOCSH_PS1", "ioc-optics-pitch-notepad> ")

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

dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MR1L0:PITCH:Coating1,DESC=mr1l0 pitch coating 1 position,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MR1L0:PITCH:Coating2,DESC=mr1l0 pitch coating 2 position,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MR2L0:PITCH:Coating1,DESC=mr2l0 pitch coating 1 position,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MR2L0:PITCH:Coating2,DESC=mr2l0 pitch coating 2 position,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MR1L4:PITCH:MEC:Coating1,DESC=mr1l4 mec pitch coating 1 position,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MR1L4:PITCH:MEC:Coating2,DESC=mr1l4 mec pitch coating 2 position,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MR1L4:PITCH:MFX:Coating1,DESC=mr1l4 MFX pitch coating 1 position,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MR1L4:PITCH:MFX:Coating2,DESC=mr1l4 MFX pitch coating 2 position,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MR1L3:PITCH:Coating1,DESC=mr1l3 pitch coating 1 position,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MR1L3:PITCH:Coating2,DESC=mr1l3 pitch coating 2 position,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MR2L3:PITCH:Coating1,DESC=mr2l3 pitch coating 1 position,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MR2L3:PITCH:Coating2,DESC=mr2l3 pitch coating 2 position,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MR2L3:PITCH:CCM:Coating1,DESC=mr2l3 pitch coating 1 ccm position,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MR2L3:PITCH:CCM:Coating2,DESC=mr2l3 pitch coating 2 ccm position,DTYP=Soft Channel")

# Setup autosave
save_restoreSet_status_prefix("$(EPICS_NAME):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

set_requestfile_path( "$(PWD)/../../autosave"             )
set_savefile_path   ( "$(IOC_DATA)/ioc-optics-pitch-notepad/autosave" )

set_pass0_restoreFile( "ioc-optics-pitch-notepad.sav" )        #just restore the settings
set_pass1_restoreFile( "ioc-optics-pitch-notepad.sav" )        #just restore the settings


# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set( "ioc-optics-pitch-notepad.req", 30, "" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

