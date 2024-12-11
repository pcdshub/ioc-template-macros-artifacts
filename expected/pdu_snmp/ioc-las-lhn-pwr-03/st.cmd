#!/reg/g/pcds/epics/ioc/common/pdu_snmp/R2.4.4/bin/rhel7-x86_64/pdu

# Run common startup commands for linux soft IOC's
< $(IOC_COMMON)/All/pre_linux.cmd

< envPaths
epicsEnvSet( "IOCNAME",      "ioc-las-lhn-pwr-03" )
epicsEnvSet( "ENGINEER",     "Christina Pino (cpino)" )
epicsEnvSet( "LOCATION",     "LHN Timing PDU Bay 3" )
epicsEnvSet( "IOCSH_PS1",    "$(IOCNAME)> " )
epicsEnvSet( "IOC_PV",       "IOC:LAS:LHN:PWR:03" )
epicsEnvSet( "IOCTOP",       "/reg/g/pcds/epics/ioc/common/pdu_snmp/R2.4.4" )
epicsEnvSet( "BUILD_TOP",    "/reg/g/pcds/epics/ioc/las/pdu_snmp/R1.4.0/build" )
epicsEnvSet( "MIBDIRS",	  "$(IOCTOP)/mibs:/usr/share/snmp/mibs:/reg/g/pcds/package/net-snmp-5.7.2/share/snmp/mibs" )

# MIB walk variables.  This is more than a little bit hacky.
epicsEnvSet("FIRST_MIB_Sentry_24", "Sentry3-MIB::systemVersion.0")
epicsEnvSet("MIB_CNT_Sentry_24", "261")
epicsEnvSet("FIRST_MIB_Sentry4_24", "Sentry4-MIB::st4SystemProductName.0")
epicsEnvSet("MIB_CNT_Sentry4_24", "580")
epicsEnvSet("FIRST_MIB_Sentry4_8", "Sentry4-MIB::st4SystemProductName.0")
epicsEnvSet("MIB_CNT_Sentry4_8", "324")
cd( "$(IOCTOP)" )

# Set Max array size
epicsEnvSet( "EPICS_CA_MAX_ARRAY_BYTES", "20000000" )

# Register all support components
dbLoadDatabase("dbd/pdu.dbd")
pdu_registerRecordDeviceDriver(pdbbase)

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

# Load pdu instances
dbLoadRecords( "db/TrippLitePdu_24.db", "HOST=pac-las-lhn-03,PRE=LAS:LHN:PWR:03" )

epicsEnvSet( "DEV_INFO", "DEV=LAS:LHN:PWR:03,IOC=$(IOC_PV),IOCNAME=$(IOCNAME)" )
epicsEnvSet( "DEV_INFO", "$(DEV_INFO),COM_TYPE=snmp,COM_PORT=pac-las-lhn-03" )
dbLoadRecords( "db/devIocInfo.db",			"$(DEV_INFO)" )


# Read the mib files
read_mib( "$(TOP)/mibs/SNMPv2-SMI.txt" )  # These must be before Snmp2cWalk!
read_mib( "$(TOP)/mibs/SNMPv2-TC.txt" )
read_mib( "$(TOP)/mibs/SNMPv2-MIB.txt" )
read_mib( "$(TOP)/mibs/TRIPPLITE.MIB" )
read_mib( "$(TOP)/mibs/TRIPPLITE-PRODUCTS.MIB" )



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

