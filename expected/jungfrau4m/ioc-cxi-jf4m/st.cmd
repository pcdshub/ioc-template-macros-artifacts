#!/reg/g/pcds/epics/ioc/common/jungfrau4m/R2.0.0/bin/rhel7-x86_64/jungfrau4m

< envPaths
epicsEnvSet("IOCNAME", "ioc-cxi-jf4m" )
epicsEnvSet("ENGINEER", "Daniel Damiani (ddamiani)" )
epicsEnvSet("LOCATION", "unknown" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "IOC:CXI:JF4M")
epicsEnvSet("IOCTOP", "/reg/g/pcds/epics/ioc/common/jungfrau4m/R2.0.0")
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/common/jungfrau4m/R2.0.0/children/build")
epicsEnvSet(streamDebug, 0)
epicsEnvSet("SLSDETDB_JF512k",  "db/jungfrau512k.db")
epicsEnvSet("SLSDETDB_JF1M",    "db/jungfrau1M.db")
epicsEnvSet("SLSDETDB_JF4M",    "db/jungfrau4M.db")
## Add the path to the protocol files
epicsEnvSet("STREAM_PROTOCOL_PATH", "$(IOCTOP)/protocol")

cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/jungfrau4m.dbd")
jungfrau4m_registerRecordDeviceDriver(pdbbase)

# Configure each device
SlsDetConfigure( "CXI:JF4M:CTRL", "cxi-jungfrau4m-00+cxi-jungfrau4m-01+cxi-jungfrau4m-02+cxi-jungfrau4m-03+cxi-jungfrau4m-04+cxi-jungfrau4m-05+cxi-jungfrau4m-06+cxi-jungfrau4m-07+", "0", "0.5" )
#define ASYN_TRACE_ERROR     0x0001
#define ASYN_TRACEIO_DEVICE  0x0002
#define ASYN_TRACEIO_FILTER  0x0004
#define ASYN_TRACEIO_DRIVER  0x0008
#define ASYN_TRACE_FLOW      0x0010
#define ASYN_TRACE_WARNING   0x0020
#asynSetTraceMask( "CXI:JF4M:CTRL", 0, 0x3B) # log everything
#asynSetTraceMask( "CXI:JF4M:CTRL", 1, 0x3B) # log everything
#asynSetTraceMask( "CXI:JF4M:CTRL", 2, 0x3B) # log everything
#asynSetTraceMask( "CXI:JF4M:CTRL", 3, 0x3B) # log everything
#asynSetTraceMask( "CXI:JF4M:CTRL", 4, 0x3B) # log everything
#asynSetTraceMask( "CXI:JF4M:CTRL", 5, 0x3B) # log everything
#asynSetTraceMask( "CXI:JF4M:CTRL", 6, 0x3B) # log everything
#asynSetTraceMask( "CXI:JF4M:CTRL", 7, 0x3B) # log everything
#define ASYN_TRACEIO_ASCII  0x0001
#define ASYN_TRACEIO_ESCAPE 0x0002
#define ASYN_TRACEIO_HEX    0x0004
#asynSetTraceIOMask( "CXI:JF4M:CTRL", 0, 2)  # Escape the strings.
#asynSetTraceIOMask( "CXI:JF4M:CTRL", 1, 2)  # Escape the strings.
#asynSetTraceIOMask( "CXI:JF4M:CTRL", 2, 2)  # Escape the strings.
#asynSetTraceIOMask( "CXI:JF4M:CTRL", 3, 2)  # Escape the strings.
#asynSetTraceIOMask( "CXI:JF4M:CTRL", 4, 2)  # Escape the strings.
#asynSetTraceIOMask( "CXI:JF4M:CTRL", 5, 2)  # Escape the strings.
#asynSetTraceIOMask( "CXI:JF4M:CTRL", 6, 2)  # Escape the strings.
#asynSetTraceIOMask( "CXI:JF4M:CTRL", 7, 2)  # Escape the strings.
drvAsynIPPortConfigure( "CXI:JF4M:PWR", "pwr-jungfrau4m:32415 TCP", 0, 0, 0 )
#define ASYN_TRACE_ERROR     0x0001
#define ASYN_TRACEIO_DEVICE  0x0002
#define ASYN_TRACEIO_FILTER  0x0004
#define ASYN_TRACEIO_DRIVER  0x0008
#define ASYN_TRACE_FLOW      0x0010
#asynSetTraceMask( "CXI:JF4M:PWR", 0, 0x19) # log everything
#define ASYN_TRACEIO_ASCII  0x0001
#define ASYN_TRACEIO_ESCAPE 0x0002
#define ASYN_TRACEIO_HEX    0x0004
#asynSetTraceIOMask( "CXI:JF4M:PWR", 0, 2)  # Escape the strings.
drvAsynSerialPortConfigure( "CXI:JF4M:BME280", "/dev/hl340-0", 0, 0, 0 )
#define ASYN_TRACE_ERROR     0x0001
#define ASYN_TRACEIO_DEVICE  0x0002
#define ASYN_TRACEIO_FILTER  0x0004
#define ASYN_TRACEIO_DRIVER  0x0008
#define ASYN_TRACE_FLOW      0x0010
#asynSetTraceMask( "CXI:JF4M:BME280", 0, 0x19) # log everything
#define ASYN_TRACEIO_ASCII  0x0001
#define ASYN_TRACEIO_ESCAPE 0x0002
#define ASYN_TRACEIO_HEX    0x0004
#asynSetTraceIOMask( "CXI:JF4M:BME280", 0, 2)  # Escape the strings.

# Load record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "P=$(IOC_PV):" )
dbLoadRecords( "$(SLSDETDB_JF4M)", "BASE=CXI:JF4M,SLSDET=CXI:JF4M:CTRL,PORT=CXI:JF4M:CTRL,TIMEOUT=0.5" )
dbLoadRecords( "db/jfpower.db", "BASE=CXI:JF4M,JFPWR=CXI:JF4M:PWR,JFCTRL=CXI:JF4M:CTRL,PORT=CXI:JF4M:PWR" )
dbLoadRecords( "db/power.db", "BASE=CXI:JF4M,IDX=0,CHAN=CXI:HMP:01:1,VLO=11.3,VHI=12.4,VDEF=12.4")
dbLoadRecords( "db/power.db", "BASE=CXI:JF4M,IDX=1,CHAN=CXI:HMP:01:2,VLO=11.3,VHI=12.4,VDEF=12.4")
dbLoadRecords( "db/power.db", "BASE=CXI:JF4M,IDX=2,CHAN=CXI:HMP:02:1,VLO=11.3,VHI=12.4,VDEF=12.4")
dbLoadRecords( "db/power.db", "BASE=CXI:JF4M,IDX=3,CHAN=CXI:HMP:02:2,VLO=11.3,VHI=12.4,VDEF=12.4")
dbLoadRecords( "db/bme280.db", "BASE=CXI:JF4M,BME=CXI:JF4M:BME280,PORT=CXI:JF4M:BME280" )
dbLoadRecords( "db/newao.db", "NAME=CXI:JF4M:LAKESHORE_INTERLOCK:LOLO,VAL=10,PV=CXI:JF4M:TCT:GET_TEMP_D.LOLO,EGU=C")
dbLoadRecords( "db/newao.db", "NAME=CXI:JF4M:LAKESHORE_INTERLOCK:HIHI,VAL=42,PV=CXI:JF4M:TCT:GET_TEMP_D.HIHI,EGU=C")
dbLoadRecords( "db/interlock.db", "BASE=CXI:JF4M,NAME=CXI:JF4M:LAKESHORE_INTERLOCK,LOPV=CXI:JF4M:LAKESHORE_INTERLOCK:LOLO CPP,HIPV=CXI:JF4M:LAKESHORE_INTERLOCK:HIHI CPP,PV=CXI:JF4M:TCT:GET_TEMP_D")
dbLoadRecords( "db/interlock.db", "BASE=CXI:JF4M,NAME=CXI:JF4M:DEWPOINT_INTERLOCK,LOPV=CXI:JF4M:BME280:DEWPOINT CPP,HIPV=0,PV=CXI:JF4M:TCT:GET_TEMP_D")
dbLoadRecords( "db/newao.db", "NAME=CXI:JF4M:DEWPOINT_MAX:HIHI,VAL=10,PV=CXI:JF4M:BME280:DEWPOINT.HIHI,EGU=C")
dbLoadRecords( "db/interlock.db", "BASE=CXI:JF4M,NAME=CXI:JF4M:DEWPOINT_MAX,LOPV=0,HIPV=CXI:JF4M:DEWPOINT_MAX:HIHI CPP,PV=CXI:JF4M:BME280:DEWPOINT")
dbLoadRecords( "db/newao.db", "NAME=CXI:JF4M:FLOW_INTERLOCK:LOLO,VAL=1,PV=CXI:JF4M:TTK:GET_PROC_FLOW.LOLO,EGU=l/m")
dbLoadRecords( "db/interlock.db", "BASE=CXI:JF4M,NAME=CXI:JF4M:FLOW_INTERLOCK,LOPV=CXI:JF4M:FLOW_INTERLOCK:LOLO CPP,HIPV=0,PV=CXI:JF4M:TTK:GET_PROC_FLOW")
dbLoadRecords( "db/aggregate.db", "NAME=CXI:JF4M:BME280:INTERLOCK,INPA=CXI:JF4M:BME280:TEMP_INTERLOCK:TEST CPP NMS,INPB=CXI:JF4M:BME280:HUMID_INTERLOCK:TEST CPP NMS,INPC=CXI:JF4M:BME280:VOLTAGE_INTERLOCK:TEST CPP NMS,INPD=CXI:JF4M:BME280:CURRENT_INTERLOCK:TEST CPP NMS")
dbLoadRecords( "db/aggregate.db", "NAME=CXI:JF4M:BME280:ALL:INTERLOCK,INPA=CXI:JF4M:BME280:INTERLOCK CPP NMS")
dbLoadRecords( "db/aggregate.db", "NAME=CXI:JF4M:PWR:INTERLOCK,INPA=CXI:JF4M:LAKESHORE_INTERLOCK:TEST CPP NMS,INPB=CXI:JF4M:DEWPOINT_INTERLOCK:TEST CPP NMS,INPC=CXI:JF4M:DEWPOINT_MAX:TEST CPP NMS,INPD=CXI:JF4M:FLOW_INTERLOCK:TEST CPP NMS,INPK=CXI:JF4M:PWR:BLOCKED,INPL=CXI:JF4M:BME280:ALL:INTERLOCK CPP NMS")

# Setup autosave
set_savefile_path( "$(IOC_DATA)/$(IOCNAME)/autosave" )
set_requestfile_path( "$(TOP)/autosave" )
save_restoreSet_status_prefix( "$(IOC_PV):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )
set_pass0_restoreFile( "$(IOCNAME).sav" )
set_pass1_restoreFile( "$(IOCNAME).sav" )

# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set( "$(IOCNAME).req", 5, "IOC=$(IOC_PV)" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
