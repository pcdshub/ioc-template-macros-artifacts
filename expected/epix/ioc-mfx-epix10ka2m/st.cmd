#!/reg/g/pcds/epics/ioc/common/epix/R1.5.1/bin/rhel7-x86_64/epixMonIoc

epicsEnvSet("IOCNAME", "ioc-mfx-epix10ka2m" )
epicsEnvSet("ENGINEER", "Russell Woods (rcjwoods)" )
epicsEnvSet("LOCATION", "MFX:EPIX2M" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "IOC:MFX:EPIX2M")
epicsEnvSet("IOCTOP", "/reg/g/pcds/epics/ioc/common/epix/R1.5.1")

< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/mfx/epix/R1.5.2/build")

# Sigh. EPICS 7.0.3 is not a fan of hex constants.
epicsEnvSet("PGP0_MASK", 16)
epicsEnvSet("PGP1_MASK", 32)
epicsEnvSet("PGP2_MASK", 17)
epicsEnvSet("PGP3_MASK", 33)

cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/epixMonIoc.dbd")
epixMonIoc_registerRecordDeviceDriver(pdbbase)



dbLoadRecords("db/epixMon_trigger.db", "BASE=MFX:EPIX2M:01:Q0")
dbLoadRecords("db/epixMon_trigger.db", "BASE=MFX:EPIX2M:01:Q1")
dbLoadRecords("db/epixMon_trigger.db", "BASE=MFX:EPIX2M:01:Q2")
dbLoadRecords("db/epixMon_trigger.db", "BASE=MFX:EPIX2M:01:Q3")

PgpRegister("PGP0", 0x10, 0x8, 0)
PgpRegister("PGP1", 0x20, 0x8, 0)
PgpRegister("PGP2", 0x11, 0x8, 0)
PgpRegister("PGP3", 0x21, 0x8, 0)



EpixMonRegister("MFX:EPIX2M:01:Q0", "PGP0", "MFX:EPIX2M:01:Q0:RUNNING")
EpixMonRegister("MFX:EPIX2M:01:Q1", "PGP1", "MFX:EPIX2M:01:Q1:RUNNING")
EpixMonRegister("MFX:EPIX2M:01:Q2", "PGP2", "MFX:EPIX2M:01:Q2:RUNNING")
EpixMonRegister("MFX:EPIX2M:01:Q3", "PGP3", "MFX:EPIX2M:01:Q3:RUNNING")

# Load remaining record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "IOC=$(IOC_PV),P=$(IOC_PV):" )



dbLoadRecords("db/detector-epix.db", "DET=MFX:EPIX2M:01:Q0,PREM=MFX:DET,DLVCHN=101,ALVCHN=100,HVCHN=000,AMB_OMSL=supervisory,AMB_DOL=20")
dbLoadRecords("db/detector-epix.db", "DET=MFX:EPIX2M:01:Q1,PREM=MFX:DET,DLVCHN=103,ALVCHN=102,HVCHN=001,AMB_OMSL=supervisory,AMB_DOL=20")
dbLoadRecords("db/detector-epix.db", "DET=MFX:EPIX2M:01:Q2,PREM=MFX:DET,DLVCHN=105,ALVCHN=104,HVCHN=002,AMB_OMSL=supervisory,AMB_DOL=20")
dbLoadRecords("db/detector-epix.db", "DET=MFX:EPIX2M:01:Q3,PREM=MFX:DET,DLVCHN=107,ALVCHN=106,HVCHN=003,AMB_OMSL=supervisory,AMB_DOL=20")
dbLoadRecords("db/chiller.db", "DET=MFX:EPIX2M:01:Q0,CH=MFX:DET:TTK:01")
dbLoadRecords("db/chiller.db", "DET=MFX:EPIX2M:01:Q1,CH=MFX:DET:TTK:01")
dbLoadRecords("db/chiller.db", "DET=MFX:EPIX2M:01:Q2,CH=MFX:DET:TTK:01")
dbLoadRecords("db/chiller.db", "DET=MFX:EPIX2M:01:Q3,CH=MFX:DET:TTK:01")
dbLoadRecords("db/epix2m.db", "DET=MFX:EPIX2M:01,C=1")



dbLoadRecords("db/epixQuadMon.db", "IOC=$(IOC_PV),BASE=MFX:EPIX2M:01:Q0,BOX=PGP0,MASK=$(PGP0_MASK),SRPV3=1")
dbLoadRecords("db/epixQuadMon.db", "IOC=$(IOC_PV),BASE=MFX:EPIX2M:01:Q1,BOX=PGP1,MASK=$(PGP1_MASK),SRPV3=1")
dbLoadRecords("db/epixQuadMon.db", "IOC=$(IOC_PV),BASE=MFX:EPIX2M:01:Q2,BOX=PGP2,MASK=$(PGP2_MASK),SRPV3=1")
dbLoadRecords("db/epixQuadMon.db", "IOC=$(IOC_PV),BASE=MFX:EPIX2M:01:Q3,BOX=PGP3,MASK=$(PGP3_MASK),SRPV3=1")



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
