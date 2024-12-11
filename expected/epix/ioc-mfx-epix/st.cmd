#!/reg/g/pcds/epics/ioc/common/epix/R1.5.1/bin/rhel7-x86_64/epixMonIoc

epicsEnvSet("IOCNAME", "ioc-mfx-epix" )
epicsEnvSet("ENGINEER", "Russell Woods (rcjwoods)" )
epicsEnvSet("LOCATION", "MFX" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "IOC:MFX:EPIX")
epicsEnvSet("IOCTOP", "/reg/g/pcds/epics/ioc/common/epix/R1.5.1")

< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/mfx/epix/R1.5.2/build")

# Sigh. EPICS 7.0.3 is not a fan of hex constants.
epicsEnvSet("PGP0_MASK", 16)
epicsEnvSet("PGP1_MASK", 32)

cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/epixMonIoc.dbd")
epixMonIoc_registerRecordDeviceDriver(pdbbase)

dbLoadRecords("db/epixMon_trigger.db", "BASE=MFX:EPIX:01")
dbLoadRecords("db/epixMon_trigger.db", "BASE=MFX:EPIX:02")



PgpRegister("PGP0", 0x10, 0x8, 0)
PgpRegister("PGP1", 0x20, 0x8, 0)

EpixMonRegister("MFX:EPIX:01", "PGP0", "MFX:EPIX:01:RUNNING")
EpixMonRegister("MFX:EPIX:02", "PGP1", "MFX:EPIX:02:RUNNING")



# Load remaining record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "IOC=$(IOC_PV),P=$(IOC_PV):" )

dbLoadRecords("db/detector-epix-peltier.db", "DET=MFX:EPIX:01,PREM=MFX:DET,DLVCHN=201,ALVCHN=200,PLVCHN=204,HVCHN=004,AMB_OMSL=supervisory,AMB_DOL=20")
dbLoadRecords("db/detector-epix-peltier.db", "DET=MFX:EPIX:02,PREM=MFX:DET,DLVCHN=203,ALVCHN=202,PLVCHN=205,HVCHN=005,AMB_OMSL=supervisory,AMB_DOL=20")



dbLoadRecords("db/epixMon.db", "IOC=$(IOC_PV),BASE=MFX:EPIX:01,BOX=PGP0,MASK=$(PGP0_MASK),SRPV3=0,FIRM=0")
dbLoadRecords("db/epixMon.db", "IOC=$(IOC_PV),BASE=MFX:EPIX:02,BOX=PGP1,MASK=$(PGP1_MASK),SRPV3=0,FIRM=0")





# Setup autosave
set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
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
