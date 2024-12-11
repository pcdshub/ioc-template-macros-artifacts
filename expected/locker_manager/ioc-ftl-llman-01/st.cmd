#!/cds/group/pcds/epics/ioc/common/locker_manager/R0.14.1/bin/rhel7-x86_64/lockerman

< envPaths

epicsEnvSet( "ENGINEER" , "tjohnson" )
epicsEnvSet( "IOCSH_PS1", "ioc-ftl-llman-01>" )
epicsEnvSet( "IOCPVROOT", "IOC:LAS:FTL:LLG2:01"   )
epicsEnvSet( "LOCATION",  "NEH FTL")
epicsEnvSet( "IOC_TOP",   "/cds/group/pcds/epics/ioc/common/locker_manager/R0.14.1"   )
epicsEnvSet( "TOP",       "/cds/group/pcds/epics/ioc/common/locker_manager/R0.14.1/children/build"      )
epicsEnvSet( "DBFILES_TOP", "$(IOC_TOP)/app/Db" )

cd( "$(IOC_TOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/lockerman.dbd")
lockerman_registerRecordDeviceDriver(pdbbase)

#prefixPath("/cds/group/pcds/epics/ioc/common/locker_manager/R0.14.1/scripts")

#------------------------------------------------------------------------------
# Load record instances

dbLoadRecords("db/pidLoop.db",     "BASE=LAS:FTL:LLG2:01,LOOP=FREQ,VALUE_RBV=LAS:FTL:CNT:01:FQ:FREQ_RBCK,CONTROL_VAL=LAS:FTL:SLICE:01:CH1:VBIAS_SET,CONTROL_RBV=LAS:FTL:SLICE:01:CH1:VMEAS_GET")

dbLoadRecords("db/pidLoop.db",     "BASE=LAS:FTL:LLG2:01,LOOP=PHAS,VALUE_RBV=OSC:ASC01:0:M:ATOP:ACORE:SM:Status_13:Rd:CONV,CONTROL_VAL=LAS:FTL:SLICE:01:CH1:VBIAS_SET,CONTROL_RBV=LAS:FTL:SLICE:01:CH1:VBIAS_SET")



#dbLoadRecords("db/iocSoft.db",		  "IOC=$(IOCPVROOT)" )
#dbLoadRecords("db/save_restoreStatus.db", "P=$(IOCPVROOT):" )

#------------------------------------------------------------------------------
# Setup autosave

set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(TOP)/autosave" )
save_restoreSet_status_prefix( "$(IOCPVROOT):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

# Just restore the settings
set_pass0_restoreFile( "$(IOC).sav" )
set_pass1_restoreFile( "$(IOC).sav" )


# Initialize the IOC and start processing records
iocInit()

# Create autosave files from info directives
#makeAutosaveFileFromDbInfo( "$(IOC_DATA)/$(IOC)/autosave/autoSettings.req", "autosaveFields" )

# Start autosave backups
#create_monitor_set( "autoSettings.req", 5, "" )
create_monitor_set( "$(IOC).req", 5, "" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
