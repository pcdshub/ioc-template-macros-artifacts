#!/reg/g/pcds/epics/ioc/common/lusiAtt/R1.5.0/bin/rhel7-x86_64/lusiAtt

< envPaths
epicsEnvSet( "IOCNAME", "ioc-cxi-dsb-lusiAtt" )
epicsEnvSet( "ENGINEER", "Justin Garofoli (justing)" )
epicsEnvSet( "LOCATION", "CXI:Rxx:Exx" )
epicsEnvSet( "IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet( "IOC_PV", "IOC:CXI:ATC" )
epicsEnvSet( "MAT_Si", "0")
epicsEnvSet( "MAT_C*", "1")
epicsEnvSet( "MAT_Al2O3", "2")
epicsEnvSet("IOCTOP", "/reg/g/pcds/epics/ioc/common/lusiAtt/R1.5.0")
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/cxi/lusiAtt/R1.5.0/build")

cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/lusiAtt.dbd")
lusiAtt_registerRecordDeviceDriver(pdbbase)

# Load record instances
dbLoadRecords( "db/iocSoft.db",             "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db",  "IOC=$(IOC_PV)" )
dbLoadRecords( "db/lusiFiltMotor.db", "ATTBASE=CXI:DSB,FLT=CXI:DSB:ATT:80UM,MOT=CXI:DSB:MMS:25,ATTBIT=0,ATTNUM=01,MAT=$(MAT_Si),THK=80" )
dbLoadRecords( "db/lusiFiltMotor.db", "ATTBASE=CXI:DSB,FLT=CXI:DSB:ATT:160UM,MOT=CXI:DSB:MMS:24,ATTBIT=1,ATTNUM=02,MAT=$(MAT_Si),THK=160" )
dbLoadRecords( "db/lusiFiltMotor.db", "ATTBASE=CXI:DSB,FLT=CXI:DSB:ATT:320UM,MOT=CXI:DSB:MMS:23,ATTBIT=2,ATTNUM=03,MAT=$(MAT_Si),THK=320" )
dbLoadRecords( "db/lusiFiltMotor.db", "ATTBASE=CXI:DSB,FLT=CXI:DSB:ATT:640UM,MOT=CXI:DSB:MMS:22,ATTBIT=3,ATTNUM=04,MAT=$(MAT_Si),THK=640" )
dbLoadRecords( "db/lusiFiltMotor.db", "ATTBASE=CXI:DSB,FLT=CXI:DSB:ATT:1280UM,MOT=CXI:DSB:MMS:21,ATTBIT=4,ATTNUM=05,MAT=$(MAT_Si),THK=1280" )
dbLoadRecords( "db/lusiAtt5.db", "ATTBASE=CXI:DSB,ATTNUM=5" )

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
