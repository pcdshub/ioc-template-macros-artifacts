#!$$IOCTOP/bin/$$IF(ARCH,$$ARCH,rhel7-x86_64)/snmp

# Run common startup commands for linux soft IOC's
< $(IOC_COMMON)/All/pre_linux.cmd

< envPaths
epicsEnvSet( "IOCNAME",      "$$IOCNAME" )
epicsEnvSet( "ENGINEER",     "$$ENGINEER" )
epicsEnvSet( "LOCATION",     "$$LOCATION" )
epicsEnvSet( "IOCSH_PS1",    "$(IOCNAME)> " )
epicsEnvSet( "IOC_PV",       "$$IOC_PV" )
epicsEnvSet( "IOCTOP",       "$$IOCTOP" )
epicsEnvSet( "BUILD_TOP",    "$$TOP" )
epicsEnvSet( "MIBDIRS",	  "$(IOCTOP)/mibs:/usr/share/snmp/mibs:/reg/g/pcds/package/net-snmp-5.7.2/share/snmp/mibs" )

epicsEnvSet( "FAST_EVENT",    "2")
epicsEnvSet( "MED_EVENT",     "3")
epicsEnvSet( "SLOW_EVENT",    "4")
epicsEnvSet( "DEFAULT_EVENT", "4")

cd( "$(IOCTOP)" )

# Set Max array size
epicsEnvSet( "EPICS_CA_MAX_ARRAY_BYTES", "$$IF(MAX_ARRAY,$$MAX_ARRAY,20000000)" )

# Register all support components
dbLoadDatabase("dbd/snmp.dbd")
snmp_registerRecordDeviceDriver(pdbbase)

$$IF(SNMP_WALKHOST0)
$$ELSE(SNMP_WALKHOST0)
# There are no SNMP walks in this IOC.
#
# Add local mib directory.
add_mibdir( "/usr/share/snmp/mibs" )
add_mibdir( "$(IOCTOP)/mibs" )
$$ENDIF(SNMP_WALKHOST0)

# Debug settings
SNMP_DEV_DEBUG( $$IF(SNMP_DEV_DEBUG,$$SNMP_DEV_DEBUG,0) )
SNMP_DRV_DEBUG( $$IF(SNMP_DRV_DEBUG,$$SNMP_DRV_DEBUG,0) )

# Each SNMP query message could query multi variables.
# This number needs to be the minimum one of all your agents
snmpMaxVarsPerMsg( $$IF(SNMP_MAX_PER_QUERY,$$SNMP_MAX_PER_QUERY,30) )

# Load soft ioc related record instances
dbLoadRecords( "db/iocSoft.db",	   "IOC=$(IOC_PV)" )
dbLoadRecords( "db/iocRelease.db", "IOC=$(IOC_PV)" )
dbLoadRecords( "db/eventDriver.db", "IOC=$(IOC_PV),SLOW_PERIOD=$$IF(SLOW_PERIOD,$$SLOW_PERIOD,60),MED_PERIOD=$$IF(MED_PERIOD,$$MED_PERIOD,5),FAST_PERIOD=$$IF(FAST_PERIOD,$$FAST_PERIOD,1)")

$$LOOP(SNMP_DEVICE)
dbLoadRecords("db/$$TYPE.db","BASE=$$BASE,HOST=$$HOST,COMM=$$COMM,WALK=$$IF(WALK,I/O Intr,Event),FAST_EVENT=$(FAST_EVENT),MED_EVENT=$(MED_EVENT),SLOW_EVENT=$(SLOW_EVENT),DEFAULT_EVENT=$(DEFAULT_EVENT)$$IF(IDX),IDX=$$IDX$$ENDIF(IDX)")
$$ENDLOOP(SNMP_DEVICE)

# Read the mib files
read_mib( "/usr/share/snmp/mibs/SNMPv2-SMI.txt" )  # These must be before Snmp2cWalk!
read_mib( "/usr/share/snmp/mibs/SNMPv2-TC.txt" )
read_mib( "/usr/share/snmp/mibs/SNMPv2-MIB.txt" )
read_mib( "/usr/share/snmp/mibs/INET-ADDRESS-MIB.txt" )
$$LOOP(SNMP_DEVICE)
epicsEnvSet( "$$(TYPE)_MIBS", "" )
$$ENDLOOP(SNMP_DEVICE)
$$LOOP(SNMP_DEVICE)
$($$(TYPE)_MIBS) < $(TOP)/db/$$(TYPE)_mibs.db
epicsEnvSet( "$$(TYPE)_MIBS", "#" )
$$ENDLOOP(SNMP_DEVICE)

$$LOOP(SNMP_WALK)
Snmp2cWalk("$$HOST", "$$COMM", "$$FIRST_MIB", $$COUNT, $$IF(PERIOD,$$PERIOD,2.0))
$$ENDLOOP(SNMP_WALK)

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

