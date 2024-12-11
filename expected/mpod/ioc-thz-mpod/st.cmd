#!/reg/g/pcds/epics/ioc/common/mpod/R3.0.0/bin/rhel7-x86_64/mpod

epicsEnvSet( "BUILD_TOP",    "/reg/g/pcds/epics/ioc/common/mpod/R3.0.0/children/build" )
< envPaths
epicsEnvSet( "IOCNAME",      "ioc-thz-mpod" )
epicsEnvSet( "ENGINEER",     "Garth Brown (gwbrown)" )
epicsEnvSet( "LOCATION",     "THZ:IOC:MPOD" )
epicsEnvSet( "IOCSH_PS1",    "$(IOCNAME)> " )
epicsEnvSet( "IOCTOP",       "/reg/g/pcds/epics/ioc/common/mpod/R3.0.0" )
epicsEnvSet( "EPICS_PVA_AUTO_ADDR_LIST",         "TRUE" )
epicsEnvSet( "EPICS_PVAS_AUTO_BEACON_ADDR_LIST", "TRUE" )
epicsEnvSet( "IOC_PV",       "THZ:R03:IOC:01:MPOD" )
epicsEnvSet( "PRE",          "THZ:R03:MPD:1" )
epicsEnvSet( "CRATE",        "mpod-thz-01" )
epicsEnvSet( "MIBDIRS",   "/usr/share/snmp/mibs:/reg/g/pcds/package/net-snmp-5.7.2/share/snmp/mibs:$(IOCTOP)/mibs" )

cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< $(IOC_COMMON)/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/mpod.dbd")
mpod_registerRecordDeviceDriver(pdbbase)

# Load record instances
dbLoadRecords( "db/iocSoft.db",                 "IOC=$(IOC_PV)" )

# low voltage 8-channel module 
dbLoadRecords("db/mpod_lvmodule_8channel.db", "HOST=$(CRATE),PRE=$(PRE),M1=,M2=,MOD=")
dbLoadRecords("db/mpod_module_8channel_CgSv.db","HOST=$(CRATE),PRE=$(PRE),M1=,M2=,MOD=")

# Debug settings
SNMP_DRV_DEBUG(0)
SNMP_DEV_DEBUG(0)

# Each SNMP query message could query multi variables.
# This number needs to be the minimum one of all your agents
snmpMaxVarsPerMsg(30)

read_mib( "$(TOP)/mibs/SNMPv2-SMI.txt" )  # These must be before Snmp2cWalk!
read_mib( "$(TOP)/mibs/SNMPv2-TC.txt" )
read_mib( "$(TOP)/mibs/WIENER-CRATE-MIB.txt" )

# See $(TOP)/MIB_NOTE.
Snmp2cWalk("$(CRATE)", "guru", "WIENER-CRATE-MIB::outputStatus",              88, 1.0)
Snmp2cWalk("$(CRATE)", "guru", "WIENER-CRATE-MIB::outputSupervisionBehavior", 80, 1.0)
Snmp2cWalk("$(CRATE)", "guru", "WIENER-CRATE-MIB::outputCurrentRiseRate",     24,  1.0)
Snmp2cWalk("$(CRATE)", "guru", "WIENER-CRATE-MIB::outputUserConfig",          24,  1.0)

# Setup autosave
dbLoadRecords( "db/save_restoreStatus.db",	"P=$(IOC_PV):" )
set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(BUILD_TOP)/autosave" )
save_restoreSet_status_prefix( "$(IOC_PV):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )
set_pass0_restoreFile( "$(IOC).sav" )
set_pass1_restoreFile( "$(IOC).sav" )

# Configure access security: this is required for caPutLog.
asSetFilename("$(TOP)/iocBoot/templates/unrestricted.acf")

#
# iocInit: Initialize the IOC and start processing records
#
iocInit()

# iocInit done

# caPutLogInit("HOST:PORT", config)
# config options:
#       caPutLogNone       -1: no logging (disable)
#       caPutLogOnChange    0: log only on value change
#       caPutLogAll         1: log all puts
#       caPutLogAllNoFilter 2: log all puts no filtering on same PV
caPutLogInit("${EPICS_CA_PUT_LOG_ADDR}", 0)

# Start autosave backups
create_monitor_set( "$(IOCNAME).req",    5,  "" )

# Update archive file
system( "cp $(BUILD_TOP)/archive/$(IOC).archive $(IOC_DATA)/$(IOC)/archive/$(IOC).archive" )

# All IOCs should dump some common info after initial startup.
< $(IOC_COMMON)/All/post_linux.cmd
