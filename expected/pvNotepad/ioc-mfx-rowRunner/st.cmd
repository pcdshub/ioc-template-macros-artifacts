#!/reg/g/pcds/package/epics/3.14/ioc/common/pvNotepad/R1.1.0/bin/linux-x86_64/pvNotepad

epicsEnvSet( "EPICS_NAME", "IOC:MFX:ROWRUNNER" )
epicsEnvSet( "ENGINEER",  "Jackson Sheppard (sheppard)" )
epicsEnvSet( "LOCATION",  "SLAC:LCLS:MFX" )
epicsEnvSet( "IOCSH_PS1", "ioc-mfx-rowRunner> ")

< envPaths

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("$(TOP)/dbd/pvNotepad.dbd")
pvNotepad_registerRecordDeviceDriver(pdbbase)

# Load record instances
dbLoadRecords("$(TOP)/db/iocSoft.db",            "IOC=$(EPICS_NAME)" )
dbLoadRecords("$(TOP)/db/save_restoreStatus.db", "IOC=$(EPICS_NAME)" )

#Record choices

dbLoadRecords("$(TOP)/db/specials.db",           "PV=MFX:USR:NAME,RECTYPE=stringin,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=MFX:USR:TYPE,RECTYPE=stringin,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=MFX:USR:COMM,RECTYPE=stringin,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=MFX:USR:ANGLE,RECTYPE=ao,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=MFX:USR:PITCH,RECTYPE=ao,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=MFX:USR:VERTICALPITCH,RECTYPE=ao,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=MFX:USR:HORIZONTALPITCH,RECTYPE=ao,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=MFX:USR:PATT,RECTYPE=ao,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=MFX:USR:ROW,RECTYPE=longout,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=MFX:USR:ACC,RECTYPE=longout,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=MFX:USR:FREQ,RECTYPE=longout,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=MFX:USR:CELLS,RECTYPE=longout,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=MFX:USR:WINDOWS,RECTYPE=longout,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=MFX:USR:GAP,RECTYPE=longout,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=MFX:USR:DAQ_STATE,RECTYPE=bo,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=MFX:USR:USE_DAQ,RECTYPE=bo,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=MFX:USR:RECORD,RECTYPE=bo,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=MFX:USR:CONFSEQ,RECTYPE=longout,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=MFX:USR:STRRUN,RECTYPE=longout,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=MFX:USR:OKTRG,RECTYPE=longout,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=MFX:USR:TRG,RECTYPE=longout,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=MFX:USR:ENDRUN,RECTYPE=longout,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=MFX:USR:STOP,RECTYPE=longout,,")
# Setup autosave
save_restoreSet_status_prefix("$(EPICS_NAME):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

set_requestfile_path( "$(PWD)/../../autosave"             )
set_savefile_path   ( "$(IOC_DATA)/ioc-mfx-rowRunner/autosave" )

set_pass0_restoreFile( "ioc-mfx-rowRunner.sav" )        #just restore the settings
set_pass1_restoreFile( "ioc-mfx-rowRunner.sav" )        #just restore the settings


# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set( "ioc-mfx-rowRunner.req", 30, "" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

