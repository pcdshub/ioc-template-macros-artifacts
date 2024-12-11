#!/reg/g/pcds/epics/ioc/common/pvNotepad/R2.1.0/bin/rhel7-x86_64/pvNotepad

epicsEnvSet( "EPICS_NAME", "IOC:TMO:PCDSDEVICES" )
epicsEnvSet( "ENGINEER",  "Tyler Pennebaker (pennebak)" )
epicsEnvSet( "LOCATION",  "SLAC:LCLS:TMO" )
epicsEnvSet( "IOCSH_PS1", "ioc-tmo-pcdsdevices> ")
epicsEnvSet( "IOCTOP",       "/reg/g/pcds/epics/ioc/common/pvNotepad/R2.1.0" )
epicsEnvSet( "BUILD_TOP",    "/reg/g/pcds/epics/ioc/tmo/pvNotepad/R1.2.0/build" )
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

dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:FS14:lxt:OphydOffset,DESC=lxt.user_offset,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:FS14:lxt:OphydReadback,DESC=lxt.notepad_readback,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:FS14:lxt:OphydSetpoint,DESC=lxt.notepad_setpoint,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:LHN:LLG2:01:lxt:OphydOffset,DESC=lxt.user_offset,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:LHN:LLG2:01:lxt:OphydReadback,DESC=lxt.notepad_readback,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:LHN:LLG2:01:lxt:OphydSetpoint,DESC=lxt.notepad_setpoint,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:TMO:lxt:OphydOffset,DESC=lxt.user_offset,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:TMO:lxt:OphydReadback,DESC=lxt.notepad_readback,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:TMO:lxt:OphydSetpoint,DESC=lxt.notepad_setpoint,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LM1K4:COM_MP2_DLY1:OphydOffset,DESC=txt.user_offset,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LM1K4:COM_MP2_DLY1:delay:OphydReadback,DESC=txt.notepad_readback,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LM1K4:COM_MP2_DLY1:delay:OphydSetpoint,DESC=txt.notepad_setpoint,DTYP=Soft Channel")

# Setup autosave
save_restoreSet_status_prefix("$(EPICS_NAME):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

set_requestfile_path( "$(PWD)/../../autosave"             )
set_savefile_path   ( "$(IOC_DATA)/ioc-tmo-pcdsdevices/autosave" )

set_pass0_restoreFile( "ioc-tmo-pcdsdevices.sav" )        #just restore the settings
set_pass1_restoreFile( "ioc-tmo-pcdsdevices.sav" )        #just restore the settings


# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set( "ioc-tmo-pcdsdevices.req", 30, "" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

