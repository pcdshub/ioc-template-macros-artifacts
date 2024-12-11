#!/reg/g/pcds/package/epics/3.14/ioc/common/pvNotepad/R1.1.0/bin/linux-x86_64/pvNotepad

epicsEnvSet( "EPICS_NAME", "IOC:CXI:ROWRUNNER" )
epicsEnvSet( "ENGINEER",  "Teddy Rendahl (trendahl)" )
epicsEnvSet( "LOCATION",  "SLAC:LCLS:CXI" )
epicsEnvSet( "IOCSH_PS1", "ioc-cxi-rowRunner> ")

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

dbLoadRecords("$(TOP)/db/specials.db",           "PV=CXI:USR:NAME,RECTYPE=stringin,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=CXI:USR:CHIP,RECTYPE=stringin,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=CXI:USR:TYPE,RECTYPE=stringin,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=CXI:USR:COMM,RECTYPE=stringin,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=CXI:USR:ANGLE,RECTYPE=ao,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=CXI:USR:PITCH,RECTYPE=ao,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=CXI:USR:VERTICALPITCH,RECTYPE=ao,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=CXI:USR:HORIZONTALPITCH,RECTYPE=ao,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=CXI:USR:PATT,RECTYPE=ao,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=CXI:USR:ROW,RECTYPE=longout,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=CXI:USR:ACC,RECTYPE=longout,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=CXI:USR:FREQ,RECTYPE=longout,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=CXI:USR:CELLS,RECTYPE=longout,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=CXI:USR:WINDOWS,RECTYPE=longout,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=CXI:USR:GAP,RECTYPE=longout,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=CXI:USR:USELASER,RECTYPE=bo,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=CXI:USR:DAQ_STATE,RECTYPE=bo,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=CXI:USR:USE_DAQ,RECTYPE=bo,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=CXI:USR:RECORD,RECTYPE=bo,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=CXI:USR:CONFSEQ,RECTYPE=longout,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=CXI:USR:STRRUN,RECTYPE=longout,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=CXI:USR:OKTRG,RECTYPE=longout,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=CXI:USR:TRG,RECTYPE=longout,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=CXI:USR:ENDRUN,RECTYPE=longout,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=CXI:USR:STOP,RECTYPE=longout,,")
# Setup autosave
save_restoreSet_status_prefix("$(EPICS_NAME):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

set_requestfile_path( "$(PWD)/../../autosave"             )
set_savefile_path   ( "$(IOC_DATA)/ioc-cxi-rowRunner/autosave" )

set_pass0_restoreFile( "ioc-cxi-rowRunner.sav" )        #just restore the settings
set_pass1_restoreFile( "ioc-cxi-rowRunner.sav" )        #just restore the settings


# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set( "ioc-cxi-rowRunner.req", 30, "" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

