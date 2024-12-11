#!/reg/g/pcds/epics/ioc/common/lusiAtt/R1.5.0/bin/linux-x86_64/lusiAtt

< envPaths
epicsEnvSet( "IOCNAME", "ioc-xcs-lusiAtt" )
epicsEnvSet( "ENGINEER", "Jose E. Ortiz (jortiz)" )
epicsEnvSet( "LOCATION", "XCS:R35:E46" )
epicsEnvSet( "IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet( "IOC_PV", "IOC:XCS:ATT" )
epicsEnvSet( "MAT_Si", "0")
epicsEnvSet( "MAT_C*", "1")
epicsEnvSet( "MAT_Al2O3", "2")
epicsEnvSet("IOCTOP", "/reg/g/pcds/epics/ioc/common/lusiAtt/R1.5.0")
epicsEnvSet("TOP", "/cds/group/pcds/epics/ioc/xcs/lusiAtt/R1.5.0/build")

cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/lusiAtt.dbd")
lusiAtt_registerRecordDeviceDriver(pdbbase)

# Load record instances
dbLoadRecords( "db/iocSoft.db",             "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db",  "IOC=$(IOC_PV)" )
dbLoadRecords( "db/lusiFiltMotor.db", "ATTBASE=XCS,FLT=XCS:ATT:20UM,MOT=XCS:SB2:MMS:14,ATTBIT=0,ATTNUM=01,MAT=$(MAT_Si),THK=20" )
dbLoadRecords( "db/lusiFiltMotor.db", "ATTBASE=XCS,FLT=XCS:ATT:40UM,MOT=XCS:SB2:MMS:12,ATTBIT=1,ATTNUM=02,MAT=$(MAT_Si),THK=40" )
dbLoadRecords( "db/lusiFiltMotor.db", "ATTBASE=XCS,FLT=XCS:ATT:80UM,MOT=XCS:SB2:MMS:13,ATTBIT=2,ATTNUM=03,MAT=$(MAT_Si),THK=80" )
dbLoadRecords( "db/lusiFiltMotor.db", "ATTBASE=XCS,FLT=XCS:ATT:160UM,MOT=XCS:SB2:MMS:11,ATTBIT=3,ATTNUM=04,MAT=$(MAT_Si),THK=160" )
dbLoadRecords( "db/lusiFiltMotor.db", "ATTBASE=XCS,FLT=XCS:ATT:320UM,MOT=XCS:SB2:MMS:15,ATTBIT=4,ATTNUM=05,MAT=$(MAT_Si),THK=320" )
dbLoadRecords( "db/lusiFiltMotor.db", "ATTBASE=XCS,FLT=XCS:ATT:640UM,MOT=XCS:SB2:MMS:16,ATTBIT=5,ATTNUM=06,MAT=$(MAT_Si),THK=640" )
dbLoadRecords( "db/lusiFiltMotor.db", "ATTBASE=XCS,FLT=XCS:ATT:1280UM,MOT=XCS:SB2:MMS:17,ATTBIT=6,ATTNUM=07,MAT=$(MAT_Si),THK=1280" )
dbLoadRecords( "db/lusiFiltMotor.db", "ATTBASE=XCS,FLT=XCS:ATT:2560UM,MOT=XCS:SB2:MMS:18,ATTBIT=7,ATTNUM=08,MAT=$(MAT_Si),THK=2560" )
dbLoadRecords( "db/lusiFiltMotor.db", "ATTBASE=XCS,FLT=XCS:ATT:5120UM,MOT=XCS:SB2:MMS:19,ATTBIT=8,ATTNUM=09,MAT=$(MAT_Si),THK=5120" )
dbLoadRecords( "db/lusiFiltMotor.db", "ATTBASE=XCS,FLT=XCS:ATT:10240UM,MOT=XCS:SB2:MMS:20,ATTBIT=9,ATTNUM=10,MAT=$(MAT_Si),THK=10240" )
dbLoadRecords( "db/lusiAtt10.db", "ATTBASE=XCS,ATTNUM=10" )

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
