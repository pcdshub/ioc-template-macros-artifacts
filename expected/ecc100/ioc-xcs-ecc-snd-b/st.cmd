#!/reg/g/pcds/epics/ioc/common/ecc100/R1.0.6/bin/linux-x86/eccTest100

## You may have to change ecc100 to something else
## everywhere it appears in this file

epicsEnvSet("IOCNAME", "ioc-xcs-ecc-snd-b" )
epicsEnvSet("ENGINEER", "Michael Browne (mcbrowne)" )
epicsEnvSet("LOCATION", "unknown" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "IOC:XCS:SND:ECC:B")
< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/common/ecc100/R1.0.6/children/build")
cd( "/reg/g/pcds/epics/ioc/common/ecc100/R1.0.6" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

## Register all support components
dbLoadDatabase("dbd/eccTest100.dbd")
eccTest100_registerRecordDeviceDriver(pdbbase)

## Create the Asyn IP port
drvAsynIPPortConfigure("IP0","ecc-xcs-snd-b:2101",0,0,0)

## Create the ECC motor record layer
ecc100AsynMotorCreate("IP0","0","0","3")
drvAsynMotorConfigure("ECC0", "ecc100AsynMotor","0","3")

## Load record instances
dbLoadRecords "db/eccTest.db", "P=XCS:SND:ECC:B,PORT=IP0,DEV=ECC0"

dbLoadRecords( "db/iocSoft.db",            "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "IOC=$(IOC_PV)" )

dbLoadRecords("db/ecc_alias.db", "OLD=XCS:SND:ECC:B,NEW=XCS:SND:T1:CHI2,M=0")
dbLoadRecords("db/ecc_alias.db", "OLD=XCS:SND:ECC:B,NEW=XCS:SND:T1:DH,M=1")

# Setup autosave
set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(TOP)/autosave" )
save_restoreSet_status_prefix( "$(IOC_PV):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )
set_pass0_restoreFile( "$(IOCNAME).sav" )
set_pass1_restoreFile( "$(IOCNAME).sav" )

cd ${TOP}/iocBoot/${IOC}
iocInit()

# Start autosave backups
create_monitor_set( "$(IOCNAME).req", 5, "IOC=$(IOC_PV)" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
