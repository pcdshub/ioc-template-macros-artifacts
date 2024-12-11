#!/reg/g/pcds/epics/ioc/common/epix/R1.5.0/bin/rhel7-x86_64/epixMonIoc

epicsEnvSet("IOCNAME", "ioc-xcs-epix4" )
epicsEnvSet("ENGINEER", "Jyoti Joshi (jjoshi)" )
epicsEnvSet("LOCATION", "XCS:EPIX" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "IOC:XCS:EPIX")
epicsEnvSet("IOCTOP", "/reg/g/pcds/epics/ioc/common/epix/R1.5.0")

< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/xcs/epix/R1.5.1/build")

# Sigh. EPICS 7.0.3 is not a fan of hex constants.
epicsEnvSet("PGP3_MASK", 64)

cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/epixMonIoc.dbd")
epixMonIoc_registerRecordDeviceDriver(pdbbase)

dbLoadRecords("db/epixMon_trigger.db", "BASE=XCS:EPIX:04")



PgpRegister("PGP3", 0x40, 0x8, 0)

EpixMonRegister("XCS:EPIX:04", "PGP3", "XCS:EPIX:04:RUNNING")



# Load remaining record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "IOC=$(IOC_PV),P=$(IOC_PV):" )

dbLoadRecords("db/detector-epix-peltier.db", "DET=XCS:EPIX:04,PREM=DET:MBL,DLVCHN=7,ALVCHN=6,PLVCHN=107,HVCHN=203,AMB_OMSL=supervisory,AMB_DOL=20")



dbLoadRecords("db/epixMon.db", "IOC=$(IOC_PV),BASE=XCS:EPIX:04,BOX=PGP3,MASK=$(PGP3_MASK),SRPV3=0,FIRM=0")





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
