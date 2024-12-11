#!/reg/g/pcds/epics/ioc/common/lusiAtt/R1.5.0/bin/linux-x86_64/lusiAtt

< envPaths
epicsEnvSet( "IOCNAME", "ioc-mec-lusiAtt" )
epicsEnvSet( "ENGINEER", "Peregrine McGehee (peregrin)" )
epicsEnvSet( "LOCATION", "MEC:R64A:E42" )
epicsEnvSet( "IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet( "IOC_PV", "IOC:MEC:ATT" )
epicsEnvSet( "MAT_Si", "0")
epicsEnvSet( "MAT_C*", "1")
epicsEnvSet( "MAT_Al2O3", "2")
epicsEnvSet("IOCTOP", "/reg/g/pcds/epics/ioc/common/lusiAtt/R1.5.0")
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/mec/lusiAtt/R1.0.0/build")

cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/lusiAtt.dbd")
lusiAtt_registerRecordDeviceDriver(pdbbase)

# Load record instances
dbLoadRecords( "db/iocSoft.db",             "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db",  "IOC=$(IOC_PV)" )
dbLoadRecords( "db/lusiFiltMotor.db", "ATTBASE=MEC,FLT=MEC:ATT:20UM,MOT=MEC:HXM:MMS:05,ATTBIT=0,ATTNUM=01,MAT=$(MAT_Si),THK=20" )
dbLoadRecords( "db/lusiFiltMotor.db", "ATTBASE=MEC,FLT=MEC:ATT:40UM,MOT=MEC:HXM:MMS:06,ATTBIT=1,ATTNUM=02,MAT=$(MAT_Si),THK=40" )
dbLoadRecords( "db/lusiFiltMotor.db", "ATTBASE=MEC,FLT=MEC:ATT:80UM,MOT=MEC:HXM:MMS:07,ATTBIT=2,ATTNUM=03,MAT=$(MAT_Si),THK=80" )
dbLoadRecords( "db/lusiFiltMotor.db", "ATTBASE=MEC,FLT=MEC:ATT:160UM,MOT=MEC:HXM:MMS:08,ATTBIT=3,ATTNUM=04,MAT=$(MAT_Si),THK=160" )
dbLoadRecords( "db/lusiFiltMotor.db", "ATTBASE=MEC,FLT=MEC:ATT:320UM,MOT=MEC:HXM:MMS:09,ATTBIT=4,ATTNUM=05,MAT=$(MAT_Si),THK=320" )
dbLoadRecords( "db/lusiFiltMotor.db", "ATTBASE=MEC,FLT=MEC:ATT:640UM,MOT=MEC:HXM:MMS:10,ATTBIT=5,ATTNUM=06,MAT=$(MAT_Si),THK=640" )
dbLoadRecords( "db/lusiFiltMotor.db", "ATTBASE=MEC,FLT=MEC:ATT:1280UM,MOT=MEC:HXM:MMS:11,ATTBIT=6,ATTNUM=07,MAT=$(MAT_Si),THK=1280" )
dbLoadRecords( "db/lusiFiltMotor.db", "ATTBASE=MEC,FLT=MEC:ATT:2560UM,MOT=MEC:HXM:MMS:12,ATTBIT=7,ATTNUM=08,MAT=$(MAT_Si),THK=2560" )
dbLoadRecords( "db/lusiFiltMotor.db", "ATTBASE=MEC,FLT=MEC:ATT:5120UM,MOT=MEC:HXM:MMS:13,ATTBIT=8,ATTNUM=09,MAT=$(MAT_Si),THK=5120" )
dbLoadRecords( "db/lusiFiltMotor.db", "ATTBASE=MEC,FLT=MEC:ATT:10240UM,MOT=MEC:HXM:MMS:14,ATTBIT=9,ATTNUM=10,MAT=$(MAT_Si),THK=10240" )
dbLoadRecords( "db/lusiAtt10.db", "ATTBASE=MEC,ATTNUM=10" )

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
