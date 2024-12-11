#!$$IOCTOP/bin/$$ARCH/smc100

epicsEnvSet( "EPICS_NAME", "$$TRANSLATE(IOCNAME,"a-z_-","A-Z::")" )
epicsEnvSet( "LOCATION",   "$$LOCATION"  )
epicsEnvSet( "IOCSH_PS1",  "$$IOCNAME> " )
epicsEnvSet( "ENGINEER",   "$$ENGINEER"  )
epicsEnvSet( "IOCTOP",     "$$IOCTOP")
epicsEnvSet( "IOC_PV",     "$$IOC_PV")
< envPaths
epicsEnvSet("TOP", "$$TOP")
cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase( "dbd/smc100.dbd" )
smc100_registerRecordDeviceDriver( pdbbase )

# Load record instances
dbLoadRecords( "db/iocSoft.db",                "IOC=$(EPICS_NAME),TODFORMAT=%d.%m.%Y %H:%M:%S,FLNK=" )
dbLoadRecords( "db/save_restoreStatus.db",      "IOC=$(EPICS_NAME),P=$$DEVICE" )

# Load EPICS records for motor
dbLoadRecords( "db/smc100.db","P=$$DEVICE,M=,PORT=SMC100_1,ADDR=0,DESC=$$DESC,EGU=$$EGU,DIR=$$DIR,VELO=$$VELO,VBAS=$$VBAS,ACCL=$$ACCL,BDST=$$BDST,BVEL=$$BVEL,BACC=$$BACC,MRES=$$MRES,PREC=$$PREC,DHLM=$$DHLM,DLLM=$$DLLM,INIT=$$INIT,RTRY=$$RTRY,FW_MEANS=$$FW_MEANS,REV_MEANS=$$REV_MEANS" )

# Open serial communication with motor
drvAsynIPPortConfigure("M1", "$$PORT TCP", 0, 0, 0)
asynOctetSetInputEos("M1",0,"\r\n")
asynOctetSetOutputEos("M1",0,"\r\n")

# Newport SMC100 Support
# (driver port, asyn port, axis num, ms mov poll, ms idle poll, egu per step)
SMC100CreateController("SMC100_1", "M1", 1, 100, 0, "$$MRES")

# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )

set_requestfile_path ( "$(TOP)/autosave"  )
set_savefile_path    ( "$(IOC_DATA)/$$IOCNAME/autosave" )

set_pass0_restoreFile( "$$IOCNAME.sav"                  )

save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "$$IOCNAME.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

