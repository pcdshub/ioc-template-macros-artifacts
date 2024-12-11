#!$$IOCTOP/bin/linux-x86_64/mmc

< envPaths

epicsEnvSet( "EPICS_NAME",           "$$TRANSLATE(IOCNAME,"a-z_-","A-Z::")" )
epicsEnvSet( "LOCATION",             "$$LOCATION"  )
epicsEnvSet( "IOCSH_PS1",            "$$IOCNAME> " )

epicsEnvSet( "ENGINEER",             "$$ENGINEER"  )


# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase( "$(TOP)/dbd/mmc.dbd" )
mmc_registerRecordDeviceDriver( pdbbase )

# Load record instances
dbLoadRecords( "$(TOP)/db/iocSoft.db",            "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/save_restoreStatus.db", "IOC=$(EPICS_NAME)" )

$$IF(PORT)
dbLoadRecords( "$(TOP)/db/mmc.db",  "CTRL=$$CTRL,PORT=$$PORT,NAXS=$$NAXS,ASYN=$$IF(ASYN,$$ASYN,$$CTRL)" )
$$ELSE(PORT)
dbLoadRecords( "$(TOP)/db/mmc.db",  "CTRL=$$CTRL,PORT=/dev/ftdi-$$SERIAL,NAXS=$$NAXS,ASYN=$$IF(ASYN,$$ASYN,$$CTRL)" )
dbLoadRecords( "$(TOP)/db/usbsn.db", "CTRL=$$CTRL,SERIAL=$$SERIAL,ASYN=$$IF(ASYN,$$ASYN,$$CTRL),TIME=1" )
$$ENDIF(PORT)


$$LOOP(AXIS)
dbLoadRecords( "$(TOP)/db/mmca.db", "CTRL=$$CTRL,MOTOR=$$NAME,AXIS=$$INDEX" )
$$ENDLOOP(AXIS)


var mmcRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/$$IOCNAME/autosave" )

set_pass0_restoreFile( "$$IOCNAME.sav"                  )


# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "$$IOCNAME.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

