#!/reg/g/pcds/epics/ioc/common/lusiAtt/R1.3.3/bin/linux-x86_64/lusiAtt

< envPaths
epicsEnvSet( "IOCNAME", "ioc-mfx-lusiAtt" )
epicsEnvSet( "ENGINEER", "Daniel Damiani (ddamiani)" )
epicsEnvSet( "LOCATION", "MFX:R46:E46" )
epicsEnvSet( "IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet( "IOC_PV", "IOC:MFX:ATT" )
epicsEnvSet( "MAT_Si", "0")
epicsEnvSet( "MAT_C*", "1")
epicsEnvSet( "MAT_Al2O3", "2")
epicsEnvSet("IOCTOP", "/reg/g/pcds/epics/ioc/common/lusiAtt/R1.3.3")
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/mfx/lusiAtt/R0.1.3/build")

cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/lusiAtt.dbd")
lusiAtt_registerRecordDeviceDriver(pdbbase)

# Load record instances
dbLoadRecords( "db/iocSoft.db",             "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db",  "IOC=$(IOC_PV)" )
dbLoadRecords( "db/lusiFiltPneumatic.db", "ATTBASE=MFX,FLT=MFX:DIA:MPA:FLT:01,MOT=MFX:DIA:MPA:FLT:01,ATTBIT=0,ATTNUM=01,MAT=$(MAT_Si),THK=20" )
dbLoadRecords( "db/lusiFiltPneumatic.db", "ATTBASE=MFX,FLT=MFX:DIA:MPA:FLT:02,MOT=MFX:DIA:MPA:FLT:02,ATTBIT=1,ATTNUM=02,MAT=$(MAT_Si),THK=40" )
dbLoadRecords( "db/lusiFiltPneumatic.db", "ATTBASE=MFX,FLT=MFX:DIA:MPA:FLT:03,MOT=MFX:DIA:MPA:FLT:03,ATTBIT=2,ATTNUM=03,MAT=$(MAT_Si),THK=80" )
dbLoadRecords( "db/lusiFiltPneumatic.db", "ATTBASE=MFX,FLT=MFX:DIA:MPA:FLT:04,MOT=MFX:DIA:MPA:FLT:04,ATTBIT=3,ATTNUM=04,MAT=$(MAT_Si),THK=160" )
dbLoadRecords( "db/lusiFiltPneumatic.db", "ATTBASE=MFX,FLT=MFX:DIA:MPA:FLT:05,MOT=MFX:DIA:MPA:FLT:05,ATTBIT=4,ATTNUM=05,MAT=$(MAT_Si),THK=320" )
dbLoadRecords( "db/lusiFiltPneumatic.db", "ATTBASE=MFX,FLT=MFX:DIA:MPA:FLT:06,MOT=MFX:DIA:MPA:FLT:06,ATTBIT=5,ATTNUM=06,MAT=$(MAT_Si),THK=640" )
dbLoadRecords( "db/lusiFiltPneumatic.db", "ATTBASE=MFX,FLT=MFX:DIA:MPA:FLT:07,MOT=MFX:DIA:MPA:FLT:07,ATTBIT=6,ATTNUM=07,MAT=$(MAT_Si),THK=1280" )
dbLoadRecords( "db/lusiFiltPneumatic.db", "ATTBASE=MFX,FLT=MFX:DIA:MPA:FLT:08,MOT=MFX:DIA:MPA:FLT:08,ATTBIT=7,ATTNUM=08,MAT=$(MAT_Si),THK=2560" )
dbLoadRecords( "db/lusiFiltPneumatic.db", "ATTBASE=MFX,FLT=MFX:DIA:MPA:FLT:09,MOT=MFX:DIA:MPA:FLT:09,ATTBIT=8,ATTNUM=09,MAT=$(MAT_Si),THK=5120" )
dbLoadRecords( "db/lusiFiltPneumatic.db", "ATTBASE=MFX,FLT=MFX:DIA:MPA:FLT:10,MOT=MFX:DIA:MPA:FLT:10,ATTBIT=9,ATTNUM=10,MAT=$(MAT_Si),THK=10240" )
dbLoadRecords( "db/lusiFiltPneumatic.db", "ATTBASE=MFX,FLT=MFX:DIA:MPA:FLT:11,MOT=MFX:DIA:MPA:FLT:11,ATTBIT=10,ATTNUM=11,MAT=$(MAT_Si),THK=20480" )
dbLoadRecords( "db/lusiAtt11.db", "ATTBASE=MFX,ATTNUM=11" )

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
