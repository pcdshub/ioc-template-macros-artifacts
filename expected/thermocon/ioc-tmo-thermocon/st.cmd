#!/reg/g/pcds/epics/ioc/common/thermocon/R2.0.0/bin/rhel7-x86_64/thermocon

< envPaths
epicsEnvSet( "ENGINEER" , "Janez Govednik (janezg)" )
epicsEnvSet( "IOCSH_PS1", "ioc-tmo-thermocon>" )
epicsEnvSet( "IOC_PV",    "IOC:MR2K4:KBO:CHL"   )
epicsEnvSet( "LOCATION",  "TMO MIRROR KB1(MR2K4)")
epicsEnvSet( "IOCTOP",    "/reg/g/pcds/epics/ioc/common/thermocon/R2.0.0"   )
epicsEnvSet( "TOP",       "/reg/g/pcds/epics/ioc/tmo/thermocon/R2.0.0/build"      )

cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/thermocon.dbd")
thermocon_registerRecordDeviceDriver(pdbbase)

# Configure each device

drvAsynIPPortConfigure( "THERMOCON0", "ser-tmo-01:4001 TCP", 0, 0, 0 )
asynOctetSetOutputEos( "THERMOCON0", 0, "\r\n" )
asynOctetSetInputEos ( "THERMOCON0", 0, "\r\n" )
modbusInterposeConfig( "THERMOCON0", 2, 2000, 0)

# drvModbusAsynConfigure(modbusPort,  asynPort,  slave address, modbus_function, offset, data_length,
#                        data_type, timeout, debug name)

drvModbusAsynConfigure(  "THERMOCON0_read_reg" , "THERMOCON0",  1,   3,  64,  7,  0,  2000, "THERMOCON0_Read"    )
drvModbusAsynConfigure(  "THERMOCON0_read_ctrl", "THERMOCON0",  1,   3,  80,  2,  0,  2000, "THERMOCON0_ReadCtrl")
drvModbusAsynConfigure(  "THERMOCON0_set_ctrl" , "THERMOCON0",  1,   6,  80,  1,  0,  2000, "THERMOCON0_SetCtrl" )
drvModbusAsynConfigure(  "THERMOCON0_set_temp" , "THERMOCON0",  1,   6,  81,  1,  0,  2000, "THERMOCON0_SetTemp" )

# USED AS DEBUGGING TOOL
#asynSetTraceIOMask("THERMOCON0", 0, 0x6)
#asynSetTraceMask("THERMOCON0", 0, 0x9) 

# Send trace output to motor specific log files
#asynSetTraceFile(   "THERMOCON0", 0, "/reg/d/iocData/$(IOC)/logs/THERMOCON0.log" )
#asynSetTraceFile(   "THERMOCON0_Read", 0, "/reg/d/iocData/$(IOC)/logs/THERMOCON0_Read.log" )

# Load record instances

dbLoadRecords( "db/iocSoft.db",            "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "P=$(IOC_PV):" )
dbLoadRecords( "db/thermocon.db",       "DEV=MR2K4:KBO:CHL,N=0" )
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



