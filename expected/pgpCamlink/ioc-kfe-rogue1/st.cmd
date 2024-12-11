#!/reg/g/pcds/epics/ioc/common/pgpCamlink/R1.7.1/bin/rhel7-x86_64/pgpRogue


epicsEnvSet( "BUILD_TOP",    "/reg/g/pcds/epics/ioc/common/pgpCamlink/R1.7.1/children/build" )
< envPaths
epicsEnvSet( "IOCNAME",      "ioc-kfe-rogue1" )
epicsEnvSet( "ENGINEER",     "Bruce Hill (bhill)" )
epicsEnvSet( "LOCATION",     "B940, R06, E26 KFE Hutch" )
epicsEnvSet( "IOCSH_PS1",    "$(IOCNAME)> " )
epicsEnvSet( "IOC_PV",       "IM0K0:IOC:ROGUE1" )
epicsEnvSet( "IOCTOP",       "/reg/g/pcds/epics/ioc/common/pgpCamlink/R1.7.1" )
epicsEnvSet( "EPICS_PVA_AUTO_ADDR_LIST",         "TRUE" )
epicsEnvSet( "EPICS_PVAS_AUTO_BEACON_ADDR_LIST", "TRUE" )

# Set Max array size
epicsEnvSet( "EPICS_CA_MAX_ARRAY_BYTES", "20000000" )

# Specify PGP_PV
epicsEnvSet( "PGP_PV",       "IM0K0:PGP:ROGUE1" )

# Specify PGP_PORT
epicsEnvSet( "PGP_PORT",     "PGP" )
epicsEnvSet( "PGP_BOARD",    "0" )

##< pgpRogue.cmd
#
cd( "$(IOCTOP)" )


# Register support components
dbLoadDatabase( "dbd/pgpRogue.dbd" )
pgpRogue_registerRecordDeviceDriver(pdbbase)


# Set iocsh debug variables
var DEBUG_ROGUE_DEV 1
var DEBUG_PGP_ROGUE 1
var save_restoreLogMissingRecords 0
#var dbLoadSuspendOnError 1


# =========================================================
# Configure a rogueDev driver for the specified PGP Port
# =========================================================
epicsEnvSet( "EVR_TYPE", "pgpRogue" )
rogueDevConfig(  "$(PGP_PORT)",     "$(PGP_BOARD)", "0" )

#
# Load devRogue PVs (Read/Write of PGP registers by varPath via Rogue Library)
dbLoadRecords("db/roguePcie.db",		"P=$(PGP_PV),R=:,B=$(PGP_BOARD)")

# Load 4 Camera Lanes
dbLoadRecords("db/ClinkLane.db",		"P=$(PGP_PV),R=:Ch0:,B=$(PGP_BOARD),L=0,F=0")
dbLoadRecords("db/ClinkLane.db",		"P=$(PGP_PV),R=:Ch1:,B=$(PGP_BOARD),L=1,F=1")
dbLoadRecords("db/ClinkLane.db",		"P=$(PGP_PV),R=:Ch2:,B=$(PGP_BOARD),L=2,F=2")
dbLoadRecords("db/ClinkLane.db",		"P=$(PGP_PV),R=:Ch3:,B=$(PGP_BOARD),L=3,F=3")

# Load records for various configuration sequences
dbLoadRecords("db/PgpCannedSequences.db",	"PGP=$(PGP_PV)")
dbLoadRecords("db/PgpChCannedSequences.db",	"PGP=$(PGP_PV),CH=0")
dbLoadRecords("db/PgpChCannedSequences.db",	"PGP=$(PGP_PV),CH=1")
dbLoadRecords("db/PgpChCannedSequences.db",	"PGP=$(PGP_PV),CH=2")
dbLoadRecords("db/PgpChCannedSequences.db",	"PGP=$(PGP_PV),CH=3")


# Load soft ioc related record instances
dbLoadRecords( "db/iocSoft.db",				"IOC=$(IOC_PV)" )
dbLoadRecords( "db/iocRelease.db",			"IOC=$(IOC_PV)" )

# Load devIocInfo for PGP
epicsEnvSet( "DEV_INFO", "DEV=$(PGP_PV),IOC=$(IOC_PV),IOCNAME=$(IOCNAME)" )
epicsEnvSet( "DEV_INFO", "$(DEV_INFO),COM_TYPE=pciE,COM_PORT=Board $(PGP_BOARD)" )
dbLoadRecords( "db/devIocInfo.db",			"$(DEV_INFO)" )


# Setup autosave
dbLoadRecords( "db/save_restoreStatus.db",	"P=$(IOC_PV):SR:" )
set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(BUILD_TOP)/autosave" )
# Also look in the iocData autosave folder for auto generated req files
set_requestfile_path( "$(IOC_DATA)/$(IOC)/autosave" )
save_restoreSet_status_prefix( "$(IOC_PV):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )
#- pass0 autosave restore IS needed for cameras
set_pass0_restoreFile( "autoSettings.sav" )
#- pass1 for restoring event code
set_pass1_restoreFile( "autoPositions.sav" )

#
# iocInit: Initialize the IOC and start processing records
#
iocInit()

# iocInit done

# Create autosave files from info directives
makeAutosaveFileFromDbInfo( "$(IOC_DATA)/$(IOC)/autosave/autoSettings.req", "autosaveFields" )
makeAutosaveFileFromDbInfo( "$(IOC_DATA)/$(IOC)/autosave/autoPositions.req", "autosaveFields_pass1" )

# Start autosave backups
create_monitor_set( "autoSettings.req",  5,  "" )
create_monitor_set( "autoPositions.req",  5,  "" )

# Update archive file
system( "cp $(BUILD_TOP)/archive/$(IOC).archive $(IOC_DATA)/$(IOC)/archive/$(IOC).archive" ) 



#- TODO: Remove these dbpf calls if possible
dbpf $(PGP_PV):LAUNCH_EDM "$(BUILD_TOP)/iocBoot/$(IOCNAME)/edm-$(IOCNAME).cmd"

var DEBUG_ROGUE_DEV 1
var DEBUG_PGP_ROGUE 1

# Force a read of all Rogue PGP registers
DumpPgpVars $(PGP_PORT) $(IOC_DATA)/$(IOCNAME)/dumpreg-EPICS-LCLS1-boot.txt 0 1
DumpPgpVars $(PGP_PORT) $(IOC_DATA)/$(IOCNAME)/cfgreg-EPICS-LCLS1-boot.txt  1 1


