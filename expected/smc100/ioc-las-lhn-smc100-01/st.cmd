#!/cds/group/pcds/epics/ioc/common/smc100/R1.1.2/bin/rhel7-x86_64/smc100

epicsEnvSet( "EPICS_NAME", "IOC:LAS:LHN:SMC100:01" )
epicsEnvSet( "LOCATION",   "LAS:FS11:VIT"  )
epicsEnvSet( "IOCSH_PS1",  "ioc-las-lhn-smc100-01> " )
epicsEnvSet( "ENGINEER",   "Sameen Yunus (sfsyunus)"  )
epicsEnvSet( "IOCTOP",     "/cds/group/pcds/epics/ioc/common/smc100/R1.1.2")
epicsEnvSet( "IOC_PV",     "")
< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/las/smc100/R0.3.6/build")
cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase( "dbd/smc100.dbd" )
smc100_registerRecordDeviceDriver( pdbbase )

# Load record instances
dbLoadRecords( "db/iocSoft.db",                "IOC=$(EPICS_NAME),TODFORMAT=%d.%m.%Y %H:%M:%S,FLNK=" )
dbLoadRecords( "db/save_restoreStatus.db",      "IOC=$(EPICS_NAME),P=LAS:FS11:MMN:FQ" )

# Load EPICS records for motor
dbLoadRecords( "db/smc100.db","P=LAS:FS11:MMN:FQ,M=,PORT=SMC100_1,ADDR=0,DESC=LHN FS11 Vitara Freq Ctrl,EGU=mm,DIR=Neg,VELO=0.16,VBAS=0,ACCL=0.1,BDST=0,BVEL=0.04,BACC=0.2,MRES=0.0000977,PREC=5,DHLM=25,DLLM=-25,INIT=,RTRY=10,FW_MEANS=+,REV_MEANS=-" )

# Open serial communication with motor
drvAsynIPPortConfigure("M1", "moxa-las-01:4003 TCP", 0, 0, 0)
asynOctetSetInputEos("M1",0,"\r\n")
asynOctetSetOutputEos("M1",0,"\r\n")

# Newport SMC100 Support
# (driver port, asyn port, axis num, ms mov poll, ms idle poll, egu per step)
SMC100CreateController("SMC100_1", "M1", 1, 100, 0, "0.0000977")

# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )

set_requestfile_path ( "$(TOP)/autosave"  )
set_savefile_path    ( "$(IOC_DATA)/ioc-las-lhn-smc100-01/autosave" )

set_pass0_restoreFile( "ioc-las-lhn-smc100-01.sav"                  )

save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-las-lhn-smc100-01.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

