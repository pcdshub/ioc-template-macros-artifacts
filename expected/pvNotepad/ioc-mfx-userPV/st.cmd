#!/reg/g/pcds/epics/ioc/common/pvNotepad/R2.0.1/bin/linux-x86_64/pvNotepad

epicsEnvSet( "EPICS_NAME", "IOC:MFX:USERPV" )
epicsEnvSet( "ENGINEER",  "Jackson Sheppard (sheppard)" )
epicsEnvSet( "LOCATION",  "SLAC:LCLS:MFX" )
epicsEnvSet( "IOCSH_PS1", "ioc-mfx-userPV> ")

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

dbLoadRecords("$(TOP)/db/special_longout.db",     "PV=MFX:SCAN:NSHOTS")
dbLoadRecords("$(TOP)/db/special_longout.db",     "PV=MFX:SCAN:NSTEPS")
dbLoadRecords("$(TOP)/db/special_longout.db",     "PV=MFX:SCAN:ISTEP")
dbLoadRecords("$(TOP)/db/special_longout.db",     "PV=MFX:SCAN:ISSCAN")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=MFX:SCAN:SCANVAR00")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=MFX:SCAN:SCANVAR01")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=MFX:SCAN:SCANVAR02")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MFX:SCAN:MIN00")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MFX:SCAN:MIN01")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MFX:SCAN:MIN02")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MFX:SCAN:MAX00")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MFX:SCAN:MAX01")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MFX:SCAN:MAX02")
dbLoadRecords("$(TOP)/db/special_waveform.db",     "PV=MFX:TIMETOOL:TTALL,NELM=6,NORD=3,FTYPE=DOUBLE,EGU=Counts,PREC=16,DESC=MFX TT PeakPos Ampl Vector,DTYP=Soft Channel,SCAN=Passive,PINI=YES")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MFX:USER:MCC:EPHOT:SET1,PREC=16,DESC=MCC Photon Energy,DTYP=Soft Channel,SCAN=Passive,PINI=YES")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MFX:USER:MCC:EPHOT:SET2,PREC=16,DESC=MCC Photon Energy,DTYP=Soft Channel,SCAN=Passive,PINI=YES")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MFX:USER:MCC:EPHOT:REF1,PREC=16,DESC=MCC Photon Energy Reference,DTYP=Soft Channel,SCAN=Passive,PINI=YES")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MFX:USER:MCC:EPHOT:REF2,PREC=16,DESC=MCC Photon Energy Reference,DTYP=Soft Channel,SCAN=Passive,PINI=YES")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MFX:USER:MCC:EPHOT:VER,PREC=16,DESC=MCC Photon Energy PV Vernier,DTYP=Soft Channel,SCAN=Passive,PINI=YES")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MFX:USER:MCC:EPHOT:UND,PREC=16,DESC=MCC Photon Energy PV Undulator,DTYP=Soft Channel,SCAN=Passive,PINI=YES")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MFX:USER:MCC:EPHOT:REQ,PREC=16,DESC=MCC Photon Energy PV Request,DTYP=Soft Channel,SCAN=Passive,PINI=YES")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MFX:JTRK:REQ:DIFF_INTENSITY,DESC=MFX JetTracking Detector Intensity,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MFX:JTRK:REQ:I0,DESC=MFX JetTracking Initial Intensity,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MFX:JTRK:REQ:RATIO,DESC=MFX JetTracking Intensity Ratio,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MFX:JTRK:REQ:DROPPED,DESC=MFX JetTracking Dropped Shots,DTYP=Soft Channel")

# Setup autosave
save_restoreSet_status_prefix("$(EPICS_NAME):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

set_requestfile_path( "$(PWD)/../../autosave"             )
set_savefile_path   ( "$(IOC_DATA)/ioc-mfx-userPV/autosave" )

set_pass0_restoreFile( "ioc-mfx-userPV.sav" )        #just restore the settings
set_pass1_restoreFile( "ioc-mfx-userPV.sav" )        #just restore the settings


# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set( "ioc-mfx-userPV.req", 30, "" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

