#!$$IOCTOP/bin/$$IF(TARGET_ARCH,$$TARGET_ARCH,rhel7-x86_64)/mpod

epicsEnvSet( "BUILD_TOP",    "$$TOP" )
< envPaths
epicsEnvSet( "IOCNAME",      "$$IOCNAME" )
epicsEnvSet( "ENGINEER",     "$$ENGINEER" )
epicsEnvSet( "LOCATION",     "$$LOCATION" )
epicsEnvSet( "IOCSH_PS1",    "$(IOCNAME)> " )
epicsEnvSet( "IOCTOP",       "$$IOCTOP" )
epicsEnvSet( "EPICS_PVA_AUTO_ADDR_LIST",         "TRUE" )
epicsEnvSet( "EPICS_PVAS_AUTO_BEACON_ADDR_LIST", "TRUE" )
epicsEnvSet( "IOC_PV",       "$$IOC_PV" )
epicsEnvSet( "PRE",          "$$PREFIX" )
epicsEnvSet( "CRATE",        "$$CRATE" )
epicsEnvSet( "MIBDIRS",   "/usr/share/snmp/mibs:/reg/g/pcds/package/net-snmp-5.7.2/share/snmp/mibs:$(IOCTOP)/mibs" )

cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< $(IOC_COMMON)/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/mpod.dbd")
mpod_registerRecordDeviceDriver(pdbbase)

# Load record instances
dbLoadRecords( "db/iocSoft.db",                 "IOC=$(IOC_PV)" )

$$ASSIGN{TOTAL,0}
$$LOOP(BOARD)
# $$IF(TYPE,lv)low$$ELSE(TYPE)high$$ENDIF(TYPE) voltage $$(COUNT)-channel module $$COMMENT
dbLoadRecords("db/mpod_$$(TYPE)module_$$(COUNT)channel.db", "HOST=$(CRATE),PRE=$(PRE),M1=$$IF(INDEX,0)$$ELSE(INDEX)$$(INDEX)$$ENDIF(INDEX),M2=$$IF(INDEX,0)$$ELSE(INDEX)$$(INDEX)0$$ENDIF(INDEX),MOD=$$IF(INDEX,0)$$IF(ZMOD)0$$IF(COUNT,8)0$$ENDIF(COUNT)$$ENDIF(ZMOD)$$ELSE(INDEX)$$(INDEX)$$IF(COUNT,8)0$$ENDIF(COUNT)$$ENDIF(INDEX)")
dbLoadRecords("db/mpod_module_$$(COUNT)channel_CgSv.db","HOST=$(CRATE),PRE=$(PRE),M1=$$IF(INDEX,0)$$ELSE(INDEX)$$(INDEX)$$ENDIF(INDEX),M2=$$IF(INDEX,0)$$ELSE(INDEX)$$(INDEX)0$$ENDIF(INDEX),MOD=$$IF(INDEX,0)$$IF(ZMOD)0$$IF(COUNT,8)0$$ENDIF(COUNT)$$ENDIF(ZMOD)$$ELSE(INDEX)$$(INDEX)$$IF(COUNT,8)0$$ENDIF(COUNT)$$ENDIF(INDEX)")
$$ASSIGN{TOTAL,$$TOTAL+$$COUNT}
$$ENDLOOP(BOARD)
$$IF(DISABLE_GROUP)$$ELSE(DISABLE_GROUP)
# group records for dis(/en)abling kill
dbLoadRecords("db/mpod_group.db","HOST=$(CRATE),PRE=$(PRE)")
$$ENDIF(DISABLE_GROUP)

# Debug settings
SNMP_DRV_DEBUG($$IF(SNMP_DRV_DEBUG,$$SNMP_DRV_DEBUG,0))
SNMP_DEV_DEBUG($$IF(SNMP_DEV_DEBUG,$$SNMP_DEV_DEBUG,0))

# Each SNMP query message could query multi variables.
# This number needs to be the minimum one of all your agents
snmpMaxVarsPerMsg(30)

read_mib( "$(TOP)/mibs/SNMPv2-SMI.txt" )  # These must be before Snmp2cWalk!
read_mib( "$(TOP)/mibs/SNMPv2-TC.txt" )
read_mib( "$(TOP)/mibs/WIENER-CRATE-MIB.txt" )

# See $(TOP)/MIB_NOTE.
Snmp2cWalk("$(CRATE)", "guru", "WIENER-CRATE-MIB::outputStatus",              $$CALC{11*$$TOTAL}, 1.0)
Snmp2cWalk("$(CRATE)", "guru", "WIENER-CRATE-MIB::outputSupervisionBehavior", $$CALC{10*$$TOTAL}, 1.0)
Snmp2cWalk("$(CRATE)", "guru", "WIENER-CRATE-MIB::outputCurrentRiseRate",     $$CALC{3*$$TOTAL},  1.0)
Snmp2cWalk("$(CRATE)", "guru", "WIENER-CRATE-MIB::outputUserConfig",          $$CALC{3*$$TOTAL},  1.0)
$$IF(DISABLE_GROUP)$$ELSE(DISABLE_GROUP)
Snmp2cWalk("$(CRATE)", "guru", "WIENER-CRATE-MIB::groupsSwitch.0",            6,   1.0)
$$ENDIF(DISABLE_GROUP)

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
