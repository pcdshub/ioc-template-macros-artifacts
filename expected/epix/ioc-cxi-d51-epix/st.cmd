#!/reg/g/pcds/epics/ioc/common/epix/R1.5.0/bin/rhel7-x86_64/epixMonIoc

epicsEnvSet("IOCNAME", "ioc-cxi-d51-epix" )
epicsEnvSet("ENGINEER", "Divya Thanasekaran (divya)" )
epicsEnvSet("LOCATION", "CXI:D51" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "IOC:CXI:EPIX")
epicsEnvSet("IOCTOP", "/reg/g/pcds/epics/ioc/common/epix/R1.5.0")

< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/cxi/epix/R1.5.0/build")

# Sigh. EPICS 7.0.3 is not a fan of hex constants.
epicsEnvSet("PGP0_MASK", 16)
epicsEnvSet("PGP1_MASK", 32)
epicsEnvSet("PGP2_MASK", 48)
epicsEnvSet("PGP3_MASK", 64)

cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/epixMonIoc.dbd")
epixMonIoc_registerRecordDeviceDriver(pdbbase)

dbLoadRecords("db/epixMon_trigger.db", "BASE=CXI:D51:EPIX:01")
dbLoadRecords("db/epixMon_trigger.db", "BASE=CXI:D51:EPIX:02")
dbLoadRecords("db/epixMon_trigger.db", "BASE=CXI:D51:EPIX:03")
dbLoadRecords("db/epixMon_trigger.db", "BASE=CXI:D51:EPIX:04")



PgpRegister("PGP0", 0x10, 0x8, 0)
PgpRegister("PGP1", 0x20, 0x8, 0)
PgpRegister("PGP2", 0x30, 0x8, 0)
PgpRegister("PGP3", 0x40, 0x8, 0)

EpixMonRegister("CXI:D51:EPIX:01", "PGP0", "CXI:D51:EPIX:01:RUNNING")
EpixMonRegister("CXI:D51:EPIX:02", "PGP1", "CXI:D51:EPIX:02:RUNNING")
EpixMonRegister("CXI:D51:EPIX:03", "PGP2", "CXI:D51:EPIX:03:RUNNING")
EpixMonRegister("CXI:D51:EPIX:04", "PGP3", "CXI:D51:EPIX:04:RUNNING")



# Load remaining record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "IOC=$(IOC_PV),P=$(IOC_PV):" )

dbLoadRecords("db/detector-epix-peltier.db", "DET=CXI:D51:EPIX:01,PREM=CXI:D51,DLVCHN=200,ALVCHN=201,PLVCHN=204,HVCHN=004,AMB_OMSL=supervisory,AMB_DOL=20")
dbLoadRecords("db/detector-epix-peltier.db", "DET=CXI:D51:EPIX:02,PREM=CXI:D51,DLVCHN=202,ALVCHN=203,PLVCHN=205,HVCHN=005,AMB_OMSL=supervisory,AMB_DOL=20")
dbLoadRecords("db/detector-epix-peltier.db", "DET=CXI:D51:EPIX:03,PREM=CXI:D51,DLVCHN=104,ALVCHN=105,PLVCHN=206,HVCHN=002,AMB_OMSL=supervisory,AMB_DOL=20")
dbLoadRecords("db/detector-epix-peltier.db", "DET=CXI:D51:EPIX:04,PREM=CXI:D51,DLVCHN=106,ALVCHN=107,PLVCHN=207,HVCHN=003,AMB_OMSL=supervisory,AMB_DOL=20")



dbLoadRecords("db/epixMon.db", "IOC=$(IOC_PV),BASE=CXI:D51:EPIX:01,BOX=PGP0,MASK=$(PGP0_MASK),SRPV3=0,FIRM=0")
dbLoadRecords("db/epixMon.db", "IOC=$(IOC_PV),BASE=CXI:D51:EPIX:02,BOX=PGP1,MASK=$(PGP1_MASK),SRPV3=0,FIRM=0")
dbLoadRecords("db/epixMon.db", "IOC=$(IOC_PV),BASE=CXI:D51:EPIX:03,BOX=PGP2,MASK=$(PGP2_MASK),SRPV3=0,FIRM=0")
dbLoadRecords("db/epixMon.db", "IOC=$(IOC_PV),BASE=CXI:D51:EPIX:04,BOX=PGP3,MASK=$(PGP3_MASK),SRPV3=0,FIRM=0")





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
