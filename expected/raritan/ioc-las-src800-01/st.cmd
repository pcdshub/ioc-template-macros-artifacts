#!/cds/group/pcds/epics/ioc/common/raritan/R1.0.1/bin/rhel7-x86_64/snmp

# Run common startup commands for linux soft IOC's
< $(IOC_COMMON)/All/pre_linux.cmd

< envPaths
epicsEnvSet( "IOCNAME",      "ioc-las-src800-01" )
epicsEnvSet( "ENGINEER",     "Michael Browne (mcbrowne)" )
epicsEnvSet( "LOCATION",     "B901 Somewhere" )
epicsEnvSet( "IOCSH_PS1",    "$(IOCNAME)> " )
epicsEnvSet( "IOC_PV",       "LAS:IOC:SRC800:01" )
epicsEnvSet( "IOCTOP",       "/cds/group/pcds/epics/ioc/common/raritan/R1.0.1" )
epicsEnvSet( "BUILD_TOP",    "/cds/group/pcds/epics/ioc/las/raritan/R1.0.0/build" )
epicsEnvSet( "MIBDIRS",	  "$(IOCTOP)/mibs:/usr/share/snmp/mibs:/reg/g/pcds/package/net-snmp-5.7.2/share/snmp/mibs" )

epicsEnvSet( "FAST_EVENT",    "2")
epicsEnvSet( "MED_EVENT",     "3")
epicsEnvSet( "SLOW_EVENT",    "4")
epicsEnvSet( "DEFAULT_EVENT", "4")

cd( "$(IOCTOP)" )

# Set Max array size
epicsEnvSet( "EPICS_CA_MAX_ARRAY_BYTES", "20000000" )

# Register all support components
dbLoadDatabase("dbd/snmp.dbd")
snmp_registerRecordDeviceDriver(pdbbase)


# Debug settings
SNMP_DEV_DEBUG( 0 )
SNMP_DRV_DEBUG( 0 )

# Each SNMP query message could query multi variables.
# This number needs to be the minimum one of all your agents
snmpMaxVarsPerMsg( 30 )

# Load soft ioc related record instances
dbLoadRecords( "db/iocSoft.db",	   "IOC=$(IOC_PV)" )
dbLoadRecords( "db/iocRelease.db", "IOC=$(IOC_PV)" )
dbLoadRecords( "db/eventDriver.db", "IOC=$(IOC_PV),SLOW_PERIOD=60,MED_PERIOD=5,FAST_PERIOD=1")

dbLoadRecords("db/raritan.db","BASE=LAS:SRC800:01,HOST=emb-las-src800-01,COMM=public,WALK=I/O Intr,FAST_EVENT=$(FAST_EVENT),MED_EVENT=$(MED_EVENT),SLOW_EVENT=$(SLOW_EVENT),DEFAULT_EVENT=$(DEFAULT_EVENT)")
dbLoadRecords("db/raritan_sensor.db","BASE=LAS:SRC800:01,HOST=emb-las-src800-01,COMM=public,WALK=I/O Intr,FAST_EVENT=$(FAST_EVENT),MED_EVENT=$(MED_EVENT),SLOW_EVENT=$(SLOW_EVENT),DEFAULT_EVENT=$(DEFAULT_EVENT),IDX=1")
dbLoadRecords("db/raritan_sensor.db","BASE=LAS:SRC800:01,HOST=emb-las-src800-01,COMM=public,WALK=I/O Intr,FAST_EVENT=$(FAST_EVENT),MED_EVENT=$(MED_EVENT),SLOW_EVENT=$(SLOW_EVENT),DEFAULT_EVENT=$(DEFAULT_EVENT),IDX=2")
dbLoadRecords("db/raritan_sensor.db","BASE=LAS:SRC800:01,HOST=emb-las-src800-01,COMM=public,WALK=I/O Intr,FAST_EVENT=$(FAST_EVENT),MED_EVENT=$(MED_EVENT),SLOW_EVENT=$(SLOW_EVENT),DEFAULT_EVENT=$(DEFAULT_EVENT),IDX=3")
dbLoadRecords("db/raritan_sensor.db","BASE=LAS:SRC800:01,HOST=emb-las-src800-01,COMM=public,WALK=I/O Intr,FAST_EVENT=$(FAST_EVENT),MED_EVENT=$(MED_EVENT),SLOW_EVENT=$(SLOW_EVENT),DEFAULT_EVENT=$(DEFAULT_EVENT),IDX=4")
dbLoadRecords("db/raritan_sensor.db","BASE=LAS:SRC800:01,HOST=emb-las-src800-01,COMM=public,WALK=I/O Intr,FAST_EVENT=$(FAST_EVENT),MED_EVENT=$(MED_EVENT),SLOW_EVENT=$(SLOW_EVENT),DEFAULT_EVENT=$(DEFAULT_EVENT),IDX=5")
dbLoadRecords("db/raritan_sensor.db","BASE=LAS:SRC800:01,HOST=emb-las-src800-01,COMM=public,WALK=I/O Intr,FAST_EVENT=$(FAST_EVENT),MED_EVENT=$(MED_EVENT),SLOW_EVENT=$(SLOW_EVENT),DEFAULT_EVENT=$(DEFAULT_EVENT),IDX=6")

# Read the mib files
read_mib( "/usr/share/snmp/mibs/SNMPv2-SMI.txt" )  # These must be before Snmp2cWalk!
read_mib( "/usr/share/snmp/mibs/SNMPv2-TC.txt" )
read_mib( "/usr/share/snmp/mibs/SNMPv2-MIB.txt" )
read_mib( "/usr/share/snmp/mibs/INET-ADDRESS-MIB.txt" )
epicsEnvSet( "raritan_MIBS", "" )
epicsEnvSet( "raritan_sensor_MIBS", "" )
epicsEnvSet( "raritan_sensor_MIBS", "" )
epicsEnvSet( "raritan_sensor_MIBS", "" )
epicsEnvSet( "raritan_sensor_MIBS", "" )
epicsEnvSet( "raritan_sensor_MIBS", "" )
epicsEnvSet( "raritan_sensor_MIBS", "" )
$(raritan_MIBS) < $(TOP)/db/raritan_mibs.db
epicsEnvSet( "raritan_MIBS", "#" )
$(raritan_sensor_MIBS) < $(TOP)/db/raritan_sensor_mibs.db
epicsEnvSet( "raritan_sensor_MIBS", "#" )
$(raritan_sensor_MIBS) < $(TOP)/db/raritan_sensor_mibs.db
epicsEnvSet( "raritan_sensor_MIBS", "#" )
$(raritan_sensor_MIBS) < $(TOP)/db/raritan_sensor_mibs.db
epicsEnvSet( "raritan_sensor_MIBS", "#" )
$(raritan_sensor_MIBS) < $(TOP)/db/raritan_sensor_mibs.db
epicsEnvSet( "raritan_sensor_MIBS", "#" )
$(raritan_sensor_MIBS) < $(TOP)/db/raritan_sensor_mibs.db
epicsEnvSet( "raritan_sensor_MIBS", "#" )
$(raritan_sensor_MIBS) < $(TOP)/db/raritan_sensor_mibs.db
epicsEnvSet( "raritan_sensor_MIBS", "#" )

Snmp2cWalk("emb-las-src800-01", "public", "PDU2-MIB::externalSensorName.1", 60, 1.0)
Snmp2cWalk("emb-las-src800-01", "public", "PDU2-MIB::measurementsExternalSensorState.1", 12, 1.0)

# Setup autosave
dbLoadRecords( "db/save_restoreStatus.db",	"P=$(IOC_PV):" )
set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(BUILD_TOP)/autosave" )
# Also look in the iocData autosave folder for auto generated req files
set_requestfile_path( "$(IOC_DATA)/$(IOC)/autosave" )
save_restoreSet_status_prefix( "$(IOC_PV):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )
set_pass0_restoreFile( "autoSettings.sav" )
set_pass0_restoreFile( "$(IOC).sav" )
set_pass1_restoreFile( "autoSettings.sav" )
set_pass1_restoreFile( "$(IOC).sav" )

#
# Initialize the IOC and start processing records
#
iocInit()

write_mib_tree( "$(IOC_DATA)/$(IOC)/iocInfo/mib_tree.txt" )

# Create autosave files from info directives
makeAutosaveFileFromDbInfo( "$(IOC_DATA)/$(IOC)/autosave/autoSettings.req", "autosaveFields" )

# Start autosave backups
create_monitor_set( "autoSettings.req",  5,  "" )
create_monitor_set( "$(IOCNAME).req",    5,  "" )

# All IOCs should dump some common info after initial startup.
< $(IOC_COMMON)/All/post_linux.cmd

