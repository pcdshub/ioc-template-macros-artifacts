#!/reg/g/pcds/epics/ioc/common/epix/R1.5.0/bin/rhel7-x86_64/epixMonIoc

epicsEnvSet("IOCNAME", "ioc-xcs-epix10ka2m" )
epicsEnvSet("ENGINEER", "Daniel Damiani (ddamiani)" )
epicsEnvSet("LOCATION", "XCS:EPIX2M" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "IOC:XCS:EPIX2M")
epicsEnvSet("IOCTOP", "/reg/g/pcds/epics/ioc/common/epix/R1.5.0")

< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/xcs/epix/R1.5.1/build")

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



dbLoadRecords("db/epixMon_trigger.db", "BASE=XCS:EPIX2M:01:Q0")
dbLoadRecords("db/epixMon_trigger.db", "BASE=XCS:EPIX2M:01:Q1")
dbLoadRecords("db/epixMon_trigger.db", "BASE=XCS:EPIX2M:01:Q2")
dbLoadRecords("db/epixMon_trigger.db", "BASE=XCS:EPIX2M:01:Q3")

PgpRegister("PGP0", 0x10, 0x8, 0)
PgpRegister("PGP1", 0x20, 0x8, 0)
PgpRegister("PGP2", 0x11, 0x8, 0)
PgpRegister("PGP3", 0x21, 0x8, 0)



EpixMonRegister("XCS:EPIX2M:01:Q0", "PGP0", "XCS:EPIX2M:01:Q0:RUNNING")
EpixMonRegister("XCS:EPIX2M:01:Q1", "PGP1", "XCS:EPIX2M:01:Q1:RUNNING")
EpixMonRegister("XCS:EPIX2M:01:Q2", "PGP2", "XCS:EPIX2M:01:Q2:RUNNING")
EpixMonRegister("XCS:EPIX2M:01:Q3", "PGP3", "XCS:EPIX2M:01:Q3:RUNNING")

# Load remaining record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "IOC=$(IOC_PV),P=$(IOC_PV):" )



dbLoadRecords("db/detector-epix.db", "DET=XCS:EPIX2M:01:Q0,PREM=XCS:DET,DLVCHN=101,ALVCHN=100,HVCHN=0,AMB_OMSL=supervisory,AMB_DOL=20")
dbLoadRecords("db/detector-epix.db", "DET=XCS:EPIX2M:01:Q1,PREM=XCS:DET,DLVCHN=103,ALVCHN=102,HVCHN=1,AMB_OMSL=supervisory,AMB_DOL=20")
dbLoadRecords("db/detector-epix.db", "DET=XCS:EPIX2M:01:Q2,PREM=XCS:DET,DLVCHN=105,ALVCHN=104,HVCHN=2,AMB_OMSL=supervisory,AMB_DOL=20")
dbLoadRecords("db/detector-epix.db", "DET=XCS:EPIX2M:01:Q3,PREM=XCS:DET,DLVCHN=107,ALVCHN=106,HVCHN=3,AMB_OMSL=supervisory,AMB_DOL=20")
dbLoadRecords("db/chiller.db", "DET=XCS:EPIX2M:01:Q0,CH=XCS:GON:TTK:01")
dbLoadRecords("db/chiller.db", "DET=XCS:EPIX2M:01:Q1,CH=XCS:GON:TTK:01")
dbLoadRecords("db/chiller.db", "DET=XCS:EPIX2M:01:Q2,CH=XCS:GON:TTK:01")
dbLoadRecords("db/chiller.db", "DET=XCS:EPIX2M:01:Q3,CH=XCS:GON:TTK:01")
dbLoadRecords("db/epix2m.db", "DET=XCS:EPIX2M:01,C=1")



dbLoadRecords("db/epixQuadMon.db", "IOC=$(IOC_PV),BASE=XCS:EPIX2M:01:Q0,BOX=PGP0,MASK=$(PGP0_MASK),SRPV3=1")
dbLoadRecords("db/epixQuadMon.db", "IOC=$(IOC_PV),BASE=XCS:EPIX2M:01:Q1,BOX=PGP1,MASK=$(PGP1_MASK),SRPV3=1")
dbLoadRecords("db/epixQuadMon.db", "IOC=$(IOC_PV),BASE=XCS:EPIX2M:01:Q2,BOX=PGP2,MASK=$(PGP2_MASK),SRPV3=1")
dbLoadRecords("db/epixQuadMon.db", "IOC=$(IOC_PV),BASE=XCS:EPIX2M:01:Q3,BOX=PGP3,MASK=$(PGP3_MASK),SRPV3=1")



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
