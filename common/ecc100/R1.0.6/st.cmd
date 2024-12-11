#!$$IOCTOP/bin/$$IF(ARCH,$$ARCH,linux-x86)/eccTest100

## You may have to change ecc100 to something else
## everywhere it appears in this file

epicsEnvSet("IOCNAME", "$$IOCNAME" )
epicsEnvSet("ENGINEER", "$$ENGINEER" )
epicsEnvSet("LOCATION", "$$LOCATION" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "$$IOC_PV")
< envPaths
epicsEnvSet("TOP", "$$TOP")
cd( "$$IOCTOP" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

## Register all support components
dbLoadDatabase("dbd/eccTest100.dbd")
eccTest100_registerRecordDeviceDriver(pdbbase)

$$LOOP(ECC)
## Create the Asyn IP port
drvAsynIPPortConfigure("IP$$INDEX","$$ADDRESS:2101",0,0,0)

## Create the ECC motor record layer
ecc100AsynMotorCreate("IP$$INDEX","0","0","3")
drvAsynMotorConfigure("ECC$$INDEX", "ecc100AsynMotor","0","3")

## Load record instances
dbLoadRecords "db/eccTest.db", "P=$$NAME,PORT=IP$$INDEX,DEV=ECC$$INDEX"
$$ENDLOOP(ECC)

dbLoadRecords( "db/iocSoft.db",            "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "IOC=$(IOC_PV)" )

$$LOOP(MOTORALIAS)
$$IF(ECCBASE)
dbLoadRecords("db/ecc_alias.db", "OLD=$$ECCNAME,NEW=$$ALIAS,M=$$M")
$$ELSE(ECCBASE)
$$LOOP(ECC)
dbLoadRecords("db/ecc_alias.db", "OLD=$$NAME,NEW=$$ALIAS,M=$$M")
$$ENDLOOP(ECC)
$$ENDIF(ECCBASE)
$$ENDLOOP(MOTORALIAS)

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
