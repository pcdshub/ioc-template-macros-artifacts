#!/reg/g/pcds/epics/ioc/common/setra/R0.1.2/bin/rhel7-x86_64/setra

< envPaths
epicsEnvSet( "ENGINEER" , "Michael Browne (mcbrowne)" )
epicsEnvSet( "IOCSH_PS1", "ioc-tst-setra>" )
epicsEnvSet( "IOC_PV",    "MEC:IOC:GIGE:01"   )
epicsEnvSet( "LOCATION",  "Somewhere Over the Rainbow")
epicsEnvSet( "IOCTOP",    "/reg/g/pcds/epics/ioc/common/setra/R0.1.2"   )
epicsEnvSet( "TOP",       "/reg/g/pcds/epics/ioc/common/setra/R0.1.2/children/build"      )

cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/setra.dbd")
setra_registerRecordDeviceDriver(pdbbase)

# Bump up queue sizes!
scanOnceSetQueueSize(4000)
callbackSetQueueSize(4000)

# Configure each device

drvAsynIPPortConfigure( "SETRA0", "172.21.148.33:502 TCP", 0, 0, 1 )
modbusInterposeConfig("SETRA0",0,5000,0)
#asynSetTraceIOMask("SETRA0", 0, 4)
#asynSetTraceMask("SETRA0", 0, 9) 
#asynSetTraceFile("SETRA0", 0, "/reg/d/iocData/$(IOC)/logs/SETRA0.log" )

# Register definitions are From Setra modbus datasheet go as followed
#
# Setra$(N)_set_write-  Writes to device a register #8000. Used to read snapshot of Setra_read_register records.
#
# Setra$(N)_samp_read/write- Read/Write device registers #5000-#5032.
#
# Setra$(N)_data_read - Read device registers #9000-#9085. 

# drvModbusAsynConfigure(modbusPort,                 asynPort,     slave, func, offset, length, type, polltime, debugname)

drvModbusAsynConfigure(  "Setra0_chan_cnt",  "SETRA0",  247,   3,  1036,   1,  0,  5000, "SETRA0_RegCnt")
drvModbusAsynConfigure(  "Setra0_chan_en",   "SETRA0",  247,   3,  6000,   6,  0,  5000, "SETRA0_ChEn")
drvModbusAsynConfigure(  "Setra0_chan_size", "SETRA0",  247,   3,  6100,  12,  0,  5000, "SETRA0_ChSize")
drvModbusAsynConfigure(  "Setra0_chan_pm",   "SETRA0",  247,   3, 10900,  12,  0,  5000, "SETRA0_PartMass")
drvModbusAsynConfigure(  "Setra0_chan_tpm",  "SETRA0",  247,   3, 11700,  12,  0,  5000, "SETRA0_TotPartMass")
drvModbusAsynConfigure(  "Setra0_set_write", "SETRA0",  247,  16,  8000,   4,  0,  5000, "SETRA0_Set")
drvModbusAsynConfigure(  "Setra0_samp_read", "SETRA0",  247,   3,  5000,  15,  0,  5000, "SETRA0_SampR")
drvModbusAsynConfigure(  "Setra0_samp_write","SETRA0",  247,  16,  5000,  15,  0,  5000, "SETRA0_SampW")
drvModbusAsynConfigure(  "Setra0_data_read", "SETRA0",  247,   3,  9000,  85,  0,  5000, "SETRA0_Read")

#asynSetTraceFile("SETRA0_Read", 0, "/reg/d/iocData/$(IOC)/logs/SETRA0_Read.log" )

# Load record instances

dbLoadRecords( "db/iocSoft.db",            "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "P=$(IOC_PV):" )
dbLoadRecords( "db/setra.db",       "DEV=TST:SETRA:01,N=0" )
#dbLoadRecords( "db/asynRecord.db", "Dev=NAME, PORT=PORT")

# Setup autosave
set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave")
set_requestfile_path( "$(TOP)/autosave")
save_restoreSet_status_prefix( "$(IOC_PV)" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

# Just restore the settings
set_pass0_restoreFile( "$(IOC).sav" )
set_pass1_restoreFile( "$(IOC).sav" )

# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set( "$(IOC).req", 5, "" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
