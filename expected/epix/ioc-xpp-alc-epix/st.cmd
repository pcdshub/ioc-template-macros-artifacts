#!/reg/g/pcds/epics/ioc/common/epix/R1.5.0/bin/rhel7-x86_64/epixMonIoc

epicsEnvSet("IOCNAME", "ioc-xpp-alc-epix" )
epicsEnvSet("ENGINEER", "Tyler Pennebaker (pennebak)" )
epicsEnvSet("LOCATION", "XPP:ALC" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "IOC:XPP:ALC:EPIX:01")
epicsEnvSet("IOCTOP", "/reg/g/pcds/epics/ioc/common/epix/R1.5.0")

< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/xpp/epix/R1.5.0/build")

# Sigh. EPICS 7.0.3 is not a fan of hex constants.
epicsEnvSet("PGP0_MASK", 80)
epicsEnvSet("PGP1_MASK", 96)
epicsEnvSet("PGP2_MASK", 112)
epicsEnvSet("PGP3_MASK", 128)

cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/epixMonIoc.dbd")
epixMonIoc_registerRecordDeviceDriver(pdbbase)

dbLoadRecords("db/epixMon_trigger.db", "BASE=XPP:ALC:EPIX:01")
dbLoadRecords("db/epixMon_trigger.db", "BASE=XPP:ALC:EPIX:02")
dbLoadRecords("db/epixMon_trigger.db", "BASE=XPP:ALC:EPIX:03")
dbLoadRecords("db/epixMon_trigger.db", "BASE=XPP:ALC:EPIX:04")



PgpRegister("PGP0", 0x50, 0x8, 0)
PgpRegister("PGP1", 0x60, 0x8, 0)
PgpRegister("PGP2", 0x70, 0x8, 0)
PgpRegister("PGP3", 0x80, 0x8, 0)

EpixMonRegister("XPP:ALC:EPIX:01", "PGP0", "XPP:ALC:EPIX:01:RUNNING")
EpixMonRegister("XPP:ALC:EPIX:02", "PGP1", "XPP:ALC:EPIX:02:RUNNING")
EpixMonRegister("XPP:ALC:EPIX:03", "PGP2", "XPP:ALC:EPIX:03:RUNNING")
EpixMonRegister("XPP:ALC:EPIX:04", "PGP3", "XPP:ALC:EPIX:04:RUNNING")



# Load remaining record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "IOC=$(IOC_PV),P=$(IOC_PV):" )

dbLoadRecords("db/detector-epix-peltier.db", "DET=XPP:ALC:EPIX:01,PREM=XPP:ALC,DLVCHN=201,ALVCHN=200,PLVCHN=204,HVCHN=4,AMB_OMSL=supervisory,AMB_DOL=20")
dbLoadRecords("db/detector-epix-peltier.db", "DET=XPP:ALC:EPIX:02,PREM=XPP:ALC,DLVCHN=203,ALVCHN=202,PLVCHN=205,HVCHN=5,AMB_OMSL=supervisory,AMB_DOL=20")
dbLoadRecords("db/detector-epix-peltier.db", "DET=XPP:ALC:EPIX:03,PREM=XPP:ALC,DLVCHN=105,ALVCHN=104,PLVCHN=206,HVCHN=2,AMB_OMSL=supervisory,AMB_DOL=20")
dbLoadRecords("db/detector-epix-peltier.db", "DET=XPP:ALC:EPIX:04,PREM=XPP:ALC,DLVCHN=107,ALVCHN=106,PLVCHN=207,HVCHN=3,AMB_OMSL=supervisory,AMB_DOL=20")



dbLoadRecords("db/epixMon.db", "IOC=$(IOC_PV),BASE=XPP:ALC:EPIX:01,BOX=PGP0,MASK=$(PGP0_MASK),SRPV3=0,FIRM=0")
dbLoadRecords("db/epixMon.db", "IOC=$(IOC_PV),BASE=XPP:ALC:EPIX:02,BOX=PGP1,MASK=$(PGP1_MASK),SRPV3=0,FIRM=0")
dbLoadRecords("db/epixMon.db", "IOC=$(IOC_PV),BASE=XPP:ALC:EPIX:03,BOX=PGP2,MASK=$(PGP2_MASK),SRPV3=0,FIRM=0")
dbLoadRecords("db/epixMon.db", "IOC=$(IOC_PV),BASE=XPP:ALC:EPIX:04,BOX=PGP3,MASK=$(PGP3_MASK),SRPV3=0,FIRM=0")





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
