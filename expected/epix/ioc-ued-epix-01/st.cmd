#!/reg/g/pcds/epics/ioc/common/epix/R1.4.5/bin/rhel7-x86_64/epixMonIoc

epicsEnvSet("IOCNAME", "ioc-ued-epix-01" )
epicsEnvSet("ENGINEER", "Michael Browne (mcbrowne)" )
epicsEnvSet("LOCATION", "UED:EPIX2M" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "IOC:UED:EPIX2M")
epicsEnvSet("IOCTOP", "/reg/g/pcds/epics/ioc/common/epix/R1.4.5")

< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/ued/epix/R1.0.4/build")
cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/epixMonIoc.dbd")
epixMonIoc_registerRecordDeviceDriver(pdbbase)

dbLoadRecords("db/epixMon_trigger.db", "BASE=UED:EPIX2M:01")



PgpRegister("PGP0", 0x10, 0x8, 0)

EpixMonRegister("UED:EPIX2M:01", "PGP0", "UED:EPIX2M:01:RUNNING")



# Load remaining record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "IOC=$(IOC_PV),P=$(IOC_PV):" )

dbLoadRecords("db/detector-epix.db", "DET=UED:EPIX2M:01,PREM=UED:01,DLVCHN=101,ALVCHN=100,HVCHN=000,AMB_OMSL=supervisory,AMB_DOL=20")
dbLoadRecords("db/chiller.db", "DET=UED:EPIX2M:01,CH=UED:TTK:01")



dbLoadRecords("db/epixQuadMon.db", "IOC=$(IOC_PV),BASE=UED:EPIX2M:01,BOX=PGP0,MASK=16,SRPV3=1")





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
