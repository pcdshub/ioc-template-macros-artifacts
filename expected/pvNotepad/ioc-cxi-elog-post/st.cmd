#!/reg/g/pcds/package/epics/3.14/ioc/common/pvNotepad/R1.1.0/bin/linux-x86_64/pvNotepad

epicsEnvSet( "EPICS_NAME", "IOC:CXI:ELOG:POST" )
epicsEnvSet( "ENGINEER",  "Jason Koglin (koglin)" )
epicsEnvSet( "LOCATION",  "SLAC:LCLS:CXI" )
epicsEnvSet( "IOCSH_PS1", "ioc-cxi-elog-post> ")

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

dbLoadRecords("$(TOP)/db/specials.db",           "PV=CXI:ELOG:TITLE,RECTYPE=stringin,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=CXI:ELOG:TXTFILE,RECTYPE=stringin,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=CXI:ELOG:EXP,RECTYPE=stringin,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=CXI:ELOG:FILE,RECTYPE=stringin,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=CXI:ELOG:FILE2,RECTYPE=stringin,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=CXI:ELOG:FILE3,RECTYPE=stringin,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=CXI:ELOG:TAG1,RECTYPE=stringin,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=CXI:ELOG:TAG2,RECTYPE=stringin,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=CXI:ELOG:TAG3,RECTYPE=stringin,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=CXI:ELOG:RUN,RECTYPE=longout,,")
dbLoadRecords("$(TOP)/db/specials.db",           "PV=CXI:ELOG:POST,RECTYPE=longout,,")
# Setup autosave
save_restoreSet_status_prefix("$(EPICS_NAME):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

set_requestfile_path( "$(PWD)/../../autosave"             )
set_savefile_path   ( "$(IOC_DATA)/ioc-cxi-elog-post/autosave" )

set_pass0_restoreFile( "ioc-cxi-elog-post.sav" )        #just restore the settings
set_pass1_restoreFile( "ioc-cxi-elog-post.sav" )        #just restore the settings


# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set( "ioc-cxi-elog-post.req", 30, "" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

