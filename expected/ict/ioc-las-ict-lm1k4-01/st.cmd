#!/cds/group/pcds/epics/ioc/common/ict/R1.0.7/bin/rhel7-x86_64/ict

# Run common startup commands for linux soft IOC's
< $(IOC_COMMON)/All/pre_linux.cmd

< envPaths
epicsEnvSet( "IOCNAME",      "ioc-las-ict-lm1k4-01" )
epicsEnvSet( "ENGINEER",     "Lana Jansen-Whealey (ljansen7)" )
epicsEnvSet( "LOCATION",     "B950-100H1-R01-E16" )
epicsEnvSet( "IOCSH_PS1",    "$(IOCNAME)> " )
epicsEnvSet( "IOC_PV",       "IOC:LM1K4:ICT:01" )
epicsEnvSet( "IOCTOP",       "/cds/group/pcds/epics/ioc/common/ict/R1.0.7" )
epicsEnvSet( "BUILD_TOP",    "/reg/g/pcds/epics/ioc/las/ict/1.0.0/build" )
epicsEnvSet( "MIBDIRS",	  "$(IOCTOP)/mibs:/usr/share/snmp/mibs:/reg/g/pcds/package/net-snmp-5.7.2/share/snmp/mibs" )

cd( "$(IOCTOP)" )

# Set Max array size
epicsEnvSet( "EPICS_CA_MAX_ARRAY_BYTES", "20000000" )

# Register all support components
dbLoadDatabase("dbd/ict.dbd")
ict_registerRecordDeviceDriver(pdbbase)

# Add local mib directory
add_mibdir( "/usr/share/snmp/mibs" )
add_mibdir( "$(IOCTOP)/mibs" )

# Debug settings
SNMP_DEV_DEBUG( 0 )
SNMP_DRV_DEBUG( 0 )

# Each SNMP query message could query multi variables.
# This number needs to be the minimum one of all your agents
snmpMaxVarsPerMsg( 30 )

# Load soft ioc related record instances
dbLoadRecords( "db/iocSoft.db",				"IOC=$(IOC_PV)" )
dbLoadRecords( "db/iocRelease.db",			"IOC=$(IOC_PV)" )

# Configure the ICT
dbLoadRecords( "db/ict.db", "HOST=plv-las-lm1k4-pdu-01,PRE=LAS:LM1K4:PDU:ICT:01" )
dbLoadRecords( "db/ict24VbusA.db", "HOST=plv-las-lm1k4-pdu-01,PRE=LAS:LM1K4:PDU:ICT:01" )
dbLoadRecords( "db/ict24VbusB.db", "HOST=plv-las-lm1k4-pdu-01,PRE=LAS:LM1K4:PDU:ICT:01" )
epicsEnvSet( "DEV_INFO", "DEV=LAS:LM1K4:PDU:ICT:01,IOC=$(IOC_PV),IOCNAME=$(IOCNAME)" )
epicsEnvSet( "DEV_INFO", "$(DEV_INFO),COM_TYPE=snmp,COM_PORT=plv-las-lm1k4-pdu-01" )
dbLoadRecords( "db/devIocInfo.db",			"$(DEV_INFO)" )


read_mib( "$(IOCTOP)/mibs/SNMPv2-SMI.txt" )  # These must be before Snmp2cWalk!
read_mib( "$(IOCTOP)/mibs/SNMPv2-TC.txt" )
read_mib( "$(IOCTOP)/mibs/ict_distribution_series_mib.mib" )
Snmp2cWalk("plv-las-lm1k4-pdu-01", "write", "ICT-MIB::deviceModel", 95, 2.0)

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