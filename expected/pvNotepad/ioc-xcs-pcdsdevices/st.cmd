#!/reg/g/pcds/epics/ioc/common/pvNotepad/R2.0.1/bin/linux-x86_64/pvNotepad

epicsEnvSet( "EPICS_NAME", "IOC:XCS:PCDSDEVICES" )
epicsEnvSet( "ENGINEER",  "engineer (engineer)" )
epicsEnvSet( "LOCATION",  "SLAC:LCLS:xcs" )
epicsEnvSet( "IOCSH_PS1", "ioc-xcs-pcdsdevices> ")

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

dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=XCS:LAS:MMN:01:OphydOffset,DESC=xcs_txt.user_offset,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=XCS:LAS:MMN:01:delay:OphydReadback,DESC=xcs_txt.delay.notepad_readback,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=XCS:LAS:MMN:01:delay:OphydSetpoint,DESC=xcs_txt.delay.notepad_setpoint,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=XCS:MON:MMS:24:pseudo:OphydReadback,DESC=xcs_ccm.x.pseudo.notepad_readback,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=XCS:MON:MMS:24:pseudo:OphydSetpoint,DESC=xcs_ccm.x.pseudo.notepad_setpoint,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=XCS:MON:MMS:26:pseudo:OphydReadback,DESC=xcs_ccm.y.pseudo.notepad_readback,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=XCS:MON:MMS:26:pseudo:OphydSetpoint,DESC=xcs_ccm.y.pseudo.notepad_setpoint,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=XCS:MON:MPZ:01:energy:OphydReadback,DESC=xcs_ccm.calc.energy.notepad_readback,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=XCS:MON:MPZ:01:energy:OphydSetpoint,DESC=xcs_ccm.calc.energy.notepad_setpoint,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=XCS:MON:MPZ:01:energy_with_vernier:OphydReadback,DESC=xcs_ccm.calc.energy_...notepad_readback,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=XCS:MON:MPZ:01:energy_with_vernier:OphydSetpoint,DESC=xcs_ccm.calc.energy_...notepad_setpoint,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=XCS:MON:MPZ:01:theta:OphydReadback,DESC=xcs_ccm.calc.theta.notepad_readback,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=XCS:MON:MPZ:01:theta:OphydSetpoint,DESC=xcs_ccm.calc.theta.notepad_setpoint,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=XCS:MON:MPZ:01:wavelength:OphydReadback,DESC=xcs_ccm.calc.wavelen...notepad_readback,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=XCS:MON:MPZ:01:wavelength:OphydSetpoint,DESC=xcs_ccm.calc.wavelen...notepad_setpoint,DTYP=Soft Channel")

# Setup autosave
save_restoreSet_status_prefix("$(EPICS_NAME):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

set_requestfile_path( "$(PWD)/../../autosave"             )
set_savefile_path   ( "$(IOC_DATA)/ioc-xcs-pcdsdevices/autosave" )

set_pass0_restoreFile( "ioc-xcs-pcdsdevices.sav" )        #just restore the settings
set_pass1_restoreFile( "ioc-xcs-pcdsdevices.sav" )        #just restore the settings


# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set( "ioc-xcs-pcdsdevices.req", 30, "" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

