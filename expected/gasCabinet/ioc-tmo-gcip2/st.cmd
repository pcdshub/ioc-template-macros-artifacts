#!/reg/g/pcds/epics/ioc/common/gasCabinet/R1.0.1/bin/rhel7-x86_64/hpm900

< envPaths
epicsEnvSet( "ENGINEER" , "Janez Govednik (janezg)" )
epicsEnvSet( "IOCSH_PS1", "ioc-tmo-gcip2>" )
epicsEnvSet( "IOC_PV",    "IOC:TMO:IP2:GC"   )
epicsEnvSet( "LOCATION",  "TMO:IP2" )
epicsEnvSet( "IOCTOP",    "/reg/g/pcds/epics/ioc/common/gasCabinet/R1.0.1"   )
epicsEnvSet( "TOP",       "/reg/g/pcds/epics/ioc/common/gasCabinet/R1.0.1/children/build"      )

cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/hpm900.dbd")
hpm900_registerRecordDeviceDriver(pdbbase)

drvAsynIPPortConfigure("HPM9000", "172.21.132.147:502", 0, 0, 1)
modbusInterposeConfig("HPM9000",0,2000,0)
drvAsynIPPortConfigure("HPM9001", "172.21.132.153:502", 0, 0, 1)
modbusInterposeConfig("HPM9001",0,2000,0)

#If function code 6 is used then the data will be written in multiple messages,
#and there will be a short time period in which the device has incorrect data.

#drvModbusAsynConfigure(modbusPort,      asynPort,     slave, func, startAdd, length, type, polltime,plcType)

drvModbusAsynConfigure("HPM9000_read_reg", "HPM9000",  1,   3,  0,  41,  0,  500, "Siemens")
drvModbusAsynConfigure("HPM9000_set_reg",  "HPM9000",  1,  16, 60,  11,  0,  500, "Siemens")
drvModbusAsynConfigure("HPM9001_read_reg", "HPM9001",  1,   3,  0,  41,  0,  500, "Siemens")
drvModbusAsynConfigure("HPM9001_set_reg",  "HPM9001",  1,  16, 60,  11,  0,  500, "Siemens")

# Load record instances
dbLoadRecords("db/iocSoft.db",            "IOC=$(IOC_PV)")
dbLoadRecords("db/save_restoreStatus.db", "P=$(IOC_PV):")
dbLoadRecords("db/PlcInputs.db", "DEV=TMO:IP2:HAZ,N=0,INP=PLC_INPUTS_RBV")
dbLoadRecords("db/PlcOutputs.db", "DEV=TMO:IP2:HAZ,N=0,INP=PLC_OUTPUTS_RBV")
dbLoadRecords("db/SystemAlarm.db", "DEV=TMO:IP2:HAZ,N=0,INP=SYSTEM_ALARM_RBV")
dbLoadRecords("db/ValveOutputs.db", "DEV=TMO:IP2:HAZ,N=0,INP=VALVE_OUTPUTS_RBV")
dbLoadRecords("db/Hmi.db", "DEV=TMO:IP2:HAZ,N=0")
dbLoadRecords("db/ModePanels.db", "DEV=TMO:IP2:HAZ,N=0")
dbLoadRecords("db/SystemHeartbeat.db", "DEV=TMO:IP2:HAZ,N=0")
dbLoadRecords("db/RealNumbers.db", "DEV=TMO:IP2:HAZ,N=0")
dbLoadRecords("db/PlcInputs.db", "DEV=TMO:IP2:NONHAZ,N=1,INP=PLC_INPUTS_RBV")
dbLoadRecords("db/PlcOutputs.db", "DEV=TMO:IP2:NONHAZ,N=1,INP=PLC_OUTPUTS_RBV")
dbLoadRecords("db/SystemAlarm.db", "DEV=TMO:IP2:NONHAZ,N=1,INP=SYSTEM_ALARM_RBV")
dbLoadRecords("db/ValveOutputs.db", "DEV=TMO:IP2:NONHAZ,N=1,INP=VALVE_OUTPUTS_RBV")
dbLoadRecords("db/Hmi.db", "DEV=TMO:IP2:NONHAZ,N=1")
dbLoadRecords("db/ModePanels.db", "DEV=TMO:IP2:NONHAZ,N=1")
dbLoadRecords("db/SystemHeartbeat.db", "DEV=TMO:IP2:NONHAZ,N=1")
dbLoadRecords("db/RealNumbers_onepanel.db", "DEV=TMO:IP2:NONHAZ,N=1")


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



