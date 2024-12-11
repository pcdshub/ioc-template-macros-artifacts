#!/reg/g/pcds/epics/ioc/common/epixMon/R1.4.2/bin/rhel7-x86_64/epixMonIoc

epicsEnvSet("IOCNAME", "ioc-mfx-epix1" )
epicsEnvSet("ENGINEER", "Michael Browne (mcbrowne)" )
epicsEnvSet("LOCATION", "MFX" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "IOC:MFX:EPIX")
epicsEnvSet("IOCTOP", "/reg/g/pcds/epics/ioc/common/epixMon/R1.4.2")

< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/common/epixMon/R1.4.2/children/build")
cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/epixMonIoc.dbd")
epixMonIoc_registerRecordDeviceDriver(pdbbase)

#var PGP_reg_debug 1

dbLoadRecords("db/epixMon_trigger.db", "BASE=MFX:EPIX:1")

PgpRegister("PGP0", 0x10, 8, 0)

EpixMonRegister("MFX:EPIX:1", "PGP0", "MFX:EPIX:1:RUNNING")

# Load remaining record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "IOC=$(IOC_PV),P=$(IOC_PV):" )

dbLoadRecords("db/epixMon.db", "IOC=$(IOC_PV),BASE=MFX:EPIX:1,BOX=PGP0,MASK=16,SRPV3=0")

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
