#!/reg/g/pcds/epics/ioc/common/epix/R1.5.0/bin/rhel7-x86_64/epixMonIoc

epicsEnvSet("IOCNAME", "ioc-mec-epix-01" )
epicsEnvSet("ENGINEER", "Sameen Yunus (sfsyunus)" )
epicsEnvSet("LOCATION", "MEC:EPIX" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "IOC:MEC:EPIX")
epicsEnvSet("IOCTOP", "/reg/g/pcds/epics/ioc/common/epix/R1.5.0")

< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/mec/epix/R1.5.0/build")

# Sigh. EPICS 7.0.3 is not a fan of hex constants.
epicsEnvSet("PGP1_MASK", 32)

cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/epixMonIoc.dbd")
epixMonIoc_registerRecordDeviceDriver(pdbbase)

dbLoadRecords("db/epixMon_trigger.db", "BASE=MEC:EPIX:01")



PgpRegister("PGP1", 0x20, 0x8, 0)

EpixMonRegister("MEC:EPIX:01", "PGP1", "MEC:EPIX:01:RUNNING")



# Load remaining record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "IOC=$(IOC_PV),P=$(IOC_PV):" )

dbLoadRecords("db/detector-epix-peltier.db", "DET=MEC:EPIX:01,PREM=MEC:D60,DLVCHN=203,ALVCHN=202,PLVCHN=205,HVCHN=5,AMB_OMSL=supervisory,AMB_DOL=20")



dbLoadRecords("db/epixMon.db", "IOC=$(IOC_PV),BASE=MEC:EPIX:01,BOX=PGP1,MASK=$(PGP1_MASK),SRPV3=0,FIRM=0")





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
