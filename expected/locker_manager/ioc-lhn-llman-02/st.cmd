#!/cds/group/pcds/epics/ioc/common/locker_manager/R0.14.1/bin/rhel7-x86_64/lockerman

< envPaths

epicsEnvSet( "ENGINEER" , "tjohnson" )
epicsEnvSet( "IOCSH_PS1", "ioc-lhn-llman-02>" )
epicsEnvSet( "IOCPVROOT", "IOC:LAS:LHN:LLG2:02"   )
epicsEnvSet( "LOCATION",  "NEH Laser Hall Bay 2")
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

dbLoadRecords("db/pidLoop.db",     "BASE=LAS:LHN:LLG2:02,LOOP=FREQ,VALUE_RBV=LAS:LHN:CNT:02:FQ:FREQ_RBCK,CONTROL_VAL=LAS:LHN:SLICE:02:CH1:VBIAS_SET,CONTROL_RBV=LAS:LHN:SLICE:02:CH1:VMEAS_GET")

dbLoadRecords("db/pidLoop.db",     "BASE=LAS:LHN:LLG2:02,LOOP=PHAS,VALUE_RBV=LAS:LHN:2:M:ATOP:ACORE:SM:Status_13:Rd:CONV,CONTROL_VAL=LAS:LHN:SLICE:02:CH1:VBIAS_SET,CONTROL_RBV=LAS:LHN:SLICE:02:CH1:VBIAS_SET")

dbLoadRecords("db/atca_phase.db",    "BASE=LAS:LHN:LLG2:02,FREQ_PHAS_COMP=2600000000,ATCA_BASE=LAS:LHN:2:M:ATOP:ACORE:SM")
dbLoadRecords("db/calibrate.db",    "BASE=LAS:LHN:LLG2:02,ATCA_BASE=LAS:LHN:2:M:ATOP:ACORE:SM,TIC_BASE=LAS:FS12:CNT:TI")

dbLoadRecords("db/tpr_delay.db",     "BASE=LAS:LHN:LLG2:02,TRIG=CBD,TPR_BASE=LAS:LHN:TPR:02,TPR_TRIG=01")
dbLoadRecords("db/tpr_delay.db",     "BASE=LAS:LHN:LLG2:02,TRIG=AMP,TPR_BASE=LAS:LHN:TPR:02,TPR_TRIG=03")
dbLoadRecords("db/tpr_delay.db",     "BASE=LAS:LHN:LLG2:02,TRIG=PP,TPR_BASE=LAS:LHN:TPR:02,TPR_TRIG=05")
dbLoadRecords("db/combined_control.db",    "BASE=LAS:LHN:LLG2:02,TRIG1=CBD,TRIG2=AMP,TRIG3=PP,TRIG4=TIC")
dbLoadRecords("db/bucket_jump.db",    "BASE=LAS:LHN:LLG2:02")
dbLoadRecords("db/goose_trig.db",     "BASE=LAS:LHN:LLG2:02,TPR_BASE=LAS:LHN:TPR:02,TPR_TRIG1=01,TPR_TRIG2=03,TPR_TRIG3=05,TPR_TRIG4=09,TPR_GS_TRIG1=00,TPR_GS_TRIG2=02,TPR_GS_TRIG3=04,TPR_GS_TRIG4=08")

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
