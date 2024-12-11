#!/reg/g/pcds/epics/ioc/common/pvNotepad/R2.1.0/bin/rhel7-x86_64/pvNotepad

epicsEnvSet( "EPICS_NAME", "IOC:LAS:STRING:GLUEPV" )
epicsEnvSet( "ENGINEER",  "Lana Jansen-Whealey (ljansen7)" )
epicsEnvSet( "LOCATION",  "SLAC:LCLS:LAS" )
epicsEnvSet( "IOCSH_PS1", "ioc-las-string-gluePV> ")
epicsEnvSet( "IOCTOP",       "/reg/g/pcds/epics/ioc/common/pvNotepad/R2.1.0" )
epicsEnvSet( "BUILD_TOP",    "/reg/g/pcds/epics/ioc/las/pvNotepad/R1.0.4/build" )
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

dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:TIMING:STR:01")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:TIMING:STR:02")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:TIMING:STR:03")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:TIMING:STR:04")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:TIMING:STR:05")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:TIMING:STR:06")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:TIMING:STR:07")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:TIMING:STR:08")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:TIMING:STR:09")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:TIMING:STR:10")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:TIMING:STR:11")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:TIMING:STR:12")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:TIMING:STR:13")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:TIMING:STR:14")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:TIMING:STR:15")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:TIMING:STR:16")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:TIMING:STR:17")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:TIMING:STR:18")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:TIMING:STR:19")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:TIMING:STR:20")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:TIMING:STR:21")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:TIMING:STR:22")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:TIMING:STR:23")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:TIMING:STR:24")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:TIMING:STR:25")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:TIMING:STR:26")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:TIMING:STR:27")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:TIMING:STR:28")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:TIMING:STR:29")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:TIMING:STR:30")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:TIMING:STR:31")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:TIMING:STR:32")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:TIMING:STR:33")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:TIMING:STR:34")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:TIMING:STR:35")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:TIMING:STR:36")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:TIMING:STR:37")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:TIMING:STR:38")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:TIMING:STR:39")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:TIMING:STR:40")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:TIMING:STR:41")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:TIMING:STR:42")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:TIMING:STR:43")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:TIMING:STR:44")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:TIMING:STR:45")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:TIMING:STR:46")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:TIMING:STR:47")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:TIMING:STR:48")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:TIMING:STR:49")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=LAS:TIMING:STR:50")

# Setup autosave
save_restoreSet_status_prefix("$(EPICS_NAME):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

set_requestfile_path( "$(PWD)/../../autosave"             )
set_savefile_path   ( "$(IOC_DATA)/ioc-las-string-gluePV/autosave" )

set_pass0_restoreFile( "ioc-las-string-gluePV.sav" )        #just restore the settings
set_pass1_restoreFile( "ioc-las-string-gluePV.sav" )        #just restore the settings


# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set( "ioc-las-string-gluePV.req", 30, "" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

