#!$$IOCTOP/bin/$$IF(ARCH,$$ARCH,linux-x86_64)/lusiAtt

< envPaths
epicsEnvSet( "IOCNAME", "$$IOCNAME" )
epicsEnvSet( "ENGINEER", "$$ENGINEER" )
epicsEnvSet( "LOCATION", "$$LOCATION" )
epicsEnvSet( "IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet( "IOC_PV", "$$IOC_PV" )
epicsEnvSet( "MAT_Si", "0")
epicsEnvSet( "MAT_C*", "1")
epicsEnvSet( "MAT_Al2O3", "2")
epicsEnvSet("IOCTOP", "$$IOCTOP")
epicsEnvSet("TOP", "$$TOP")

cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/lusiAtt.dbd")
lusiAtt_registerRecordDeviceDriver(pdbbase)

# Load record instances
dbLoadRecords( "db/iocSoft.db",             "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db",  "IOC=$(IOC_PV)" )
$$LOOP(FILT)
dbLoadRecords( "db/lusiFilt$$IF(TYPE,$$TYPE,Motor).db", "ATTBASE=$$ATTBASE,FLT=$$NAME,MOT=$$IF(MOTOR,$$MOTOR,$$NAME),ATTBIT=$$INDEX,ATTNUM=$$CALC{INDEX+1,%02d},MAT=$$IF(MATERIAL)$(MAT_$$MATERIAL)$$ELSE(MATERIAL)$(MAT_Si)$$ENDIF(MATERIAL),THK=$$IF(THICK,$$THICK,$$CALC{20*2**INDEX})" )
$$ENDLOOP(FILT)
dbLoadRecords( "db/lusiAtt$$COUNT(FILT).db", "ATTBASE=$$ATTBASE,ATTNUM=$$COUNT(FILT)" )

# Setup autosave
set_savefile_path( "$(IOC_DATA)/$(IOCNAME)/autosave" )
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
