#!$$IOCTOP/bin/$$IF(ARCH,$$ARCH,linux-x86_64)/lockerman

< envPaths

epicsEnvSet( "ENGINEER" , "$$ENGINEER" )
epicsEnvSet( "IOCSH_PS1", "$$IOCNAME>" )
epicsEnvSet( "IOCPVROOT", "$$IOC_PV"   )
epicsEnvSet( "LOCATION",  "$$IF(LOCATION,$$LOCATION,$$IOC_PV)")
epicsEnvSet( "IOC_TOP",   "$$IOCTOP"   )
epicsEnvSet( "TOP",       "$$TOP"      )
epicsEnvSet( "DBFILES_TOP", "$(IOC_TOP)/app/Db" )

cd( "$(IOC_TOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/lockerman.dbd")
lockerman_registerRecordDeviceDriver(pdbbase)

#prefixPath("$$IOCTOP/scripts")

#------------------------------------------------------------------------------
# Load record instances

$$LOOP(FREQLOCK)
dbLoadRecords("db/pidLoop.db",     "BASE=$$BASE_PV,LOOP=FREQ,VALUE_RBV=$$VALUE_PV,CONTROL_VAL=$$CTL_PV,CONTROL_RBV=$$CTL_RBV")
$$ENDLOOP(FREQLOCK)

$$LOOP(PHASLOCK)
dbLoadRecords("db/pidLoop.db",     "BASE=$$BASE_PV,LOOP=PHAS,VALUE_RBV=$$VALUE_PV,CONTROL_VAL=$$CTL_PV,CONTROL_RBV=$$CTL_RBV")
$$ENDLOOP(PHASLOCK)

$$LOOP(PHASECONTROL)
dbLoadRecords("db/atca_phase.db",    "BASE=$$BASE_PV,FREQ_PHAS_COMP=$$FREQ_PHAS_COMP,ATCA_BASE=$$ATCA_BASE")
dbLoadRecords("db/calibrate.db",    "BASE=$$BASE_PV,ATCA_BASE=$$ATCA_BASE,TIC_BASE=$$TIC_BASE")
$$ENDLOOP(PHASECONTROL)

$$LOOP(TIMECONTROL)
dbLoadRecords("db/tpr_delay.db",     "BASE=$$BASE_PV,TRIG=$$TRIG_1,TPR_BASE=$$TPR_BASE,TPR_TRIG=$$TPR_TRIG_1")
dbLoadRecords("db/tpr_delay.db",     "BASE=$$BASE_PV,TRIG=$$TRIG_2,TPR_BASE=$$TPR_BASE,TPR_TRIG=$$TPR_TRIG_2")
dbLoadRecords("db/tpr_delay.db",     "BASE=$$BASE_PV,TRIG=$$TRIG_3,TPR_BASE=$$TPR_BASE,TPR_TRIG=$$TPR_TRIG_3")
dbLoadRecords("db/combined_control.db",    "BASE=$$BASE_PV,TRIG1=$$TRIG_1,TRIG2=$$TRIG_2,TRIG3=$$TRIG_3,TRIG4=$$TRIG_4")
dbLoadRecords("db/bucket_jump.db",    "BASE=$$BASE_PV")
$$ENDLOOP(TIMECONTROL)
$$LOOP(GOOSETRIG)
dbLoadRecords("db/goose_trig.db",     "BASE=$$BASE_PV,TPR_BASE=$$TPR_BASE,TPR_TRIG1=$$TPR_TRIG_1,TPR_TRIG2=$$TPR_TRIG_2,TPR_TRIG3=$$TPR_TRIG_3,TPR_TRIG4=$$TPR_TRIG_4,TPR_GS_TRIG1=$$TPR_GS_TRIG_1,TPR_GS_TRIG2=$$TPR_GS_TRIG_2,TPR_GS_TRIG3=$$TPR_GS_TRIG_3,TPR_GS_TRIG4=$$TPR_GS_TRIG_4")
$$ENDLOOP(GOOSETRIG)

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
