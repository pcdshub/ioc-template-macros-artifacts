#!/reg/g/pcds/epics/ioc/common/pvNotepad/R2.1.0/bin/rhel7-x86_64/pvNotepad

epicsEnvSet( "EPICS_NAME", "IOC:XPP:PCDSDEVICES" )
epicsEnvSet( "ENGINEER",  "engineer (engineer)" )
epicsEnvSet( "LOCATION",  "SLAC:LCLS:xpp" )
epicsEnvSet( "IOCSH_PS1", "ioc-xpp-pcdsdevices> ")
epicsEnvSet( "IOCTOP",       "/reg/g/pcds/epics/ioc/common/pvNotepad/R2.1.0" )
epicsEnvSet( "BUILD_TOP",    "/reg/g/pcds/epics/ioc/xpp/pvNotepad/R1.1.9/build" )
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

dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:FS11:lxt:OphydOffset,DESC=xpp_lxt.user_offset,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:FS11:lxt:OphydSetpoint,DESC=xpp_lxt.setpoint,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:FS11:lxt:OphydReadback,DESC=xpp_lxt.readback,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:FS14:lxt:OphydOffset,DESC=xpp_lxt.user_offset,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:FS14:lxt:OphydSetpoint,DESC=xpp_lxt.setpoint,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:FS14:lxt:OphydReadback,DESC=xpp_lxt.readback,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=XPP:LAS:MMN:02:delay:OphydReadback,DESC=xpp_lxt_fast1.notepad_readback,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=XPP:LAS:MMN:02:delay:OphydSetpoint,DESC=xpp_lxt_fast1.notepad_setpoint,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=XPP:LAS:MMN:02:OphydOffset,DESC=xpp_lxt_fast1.user_offset,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=XPP:LAS:MMN:01:delay:OphydReadback,DESC=xpp_lxt_fast2.notepad_readback,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=XPP:LAS:MMN:01:delay:OphydSetpoint,DESC=xpp_lxt_fast2.notepad_setpoint,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=XPP:LAS:MMN:01:OphydOffset,DESC=xpp_lxt_fast2.user_offset,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=XPP:LAS:MMN:16:delay:OphydReadback,DESC=xpp_txt.notepad_readback,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=XPP:LAS:MMN:16:delay:OphydSetpoint,DESC=xpp_txt.notepad_setpoint,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=XPP:LAS:MMN:16:OphydOffset,DESC=xpp_txt.user_offset,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=XPP:MON:MMS:22:pseudo:OphydReadback,DESC=xpp_ccm.notepad_readback,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=XPP:MON:MMS:22:pseudo:OphydSetpoint,DESC=xpp_ccm.notepad_setpoint,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=XPP:MON:MMS:24:pseudo:OphydReadback,DESC=xpp_ccm.notepad_readback,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=XPP:MON:MMS:24:pseudo:OphydSetpoint,DESC=xpp_ccm.notepad_setpoint,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=XPP:MON:MPZ:07A:energy:OphydReadback,DESC=xpp_ccm.notepad_readback,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=XPP:MON:MPZ:07A:energy:OphydSetpoint,DESC=xpp_ccm.notepad_setpoint,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=XPP:MON:MPZ:07A:energy_with_vernier:OphydReadback,DESC=xpp_ccm.notepad_readback,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=XPP:MON:MPZ:07A:energy_with_vernier:OphydSetpoint,DESC=xpp_ccm.notepad_setpoint,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=XPP:MON:MPZ:07A:theta:OphydReadback,DESC=xpp_ccm.notepad_readback,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=XPP:MON:MPZ:07A:theta:OphydSetpoint,DESC=xpp_ccm.notepad_setpoint,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=XPP:MON:MPZ:07A:wavelength:OphydReadback,DESC=xpp_ccm.notepad_readback,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=XPP:MON:MPZ:07A:wavelength:OphydSetpoint,DESC=xpp_ccm.notepad_setpoint,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=:e_chi:OphydReadback,DESC=kappa.e_chi.notepad_readback,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=:e_eta:OphydReadback,DESC=kappa.e_eta.notepad_readback,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=:e_phi:OphydReadback,DESC=kappa.e_phi.notepad_readback,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=:e_chi:OphydSetpoint,DESC=kappa.e_chi.notepad_setpoint,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=:e_eta:OphydSetpoint,DESC=kappa.e_eta.notepad_setpoint,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=:e_phi:OphydSetpoint,DESC=kappa.e_phi.notepad_setpoint,DTYP=Soft Channel")

# Setup autosave
save_restoreSet_status_prefix("$(EPICS_NAME):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

set_requestfile_path( "$(PWD)/../../autosave"             )
set_savefile_path   ( "$(IOC_DATA)/ioc-xpp-pcdsdevices/autosave" )

set_pass0_restoreFile( "ioc-xpp-pcdsdevices.sav" )        #just restore the settings
set_pass1_restoreFile( "ioc-xpp-pcdsdevices.sav" )        #just restore the settings


# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set( "ioc-xpp-pcdsdevices.req", 30, "" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

