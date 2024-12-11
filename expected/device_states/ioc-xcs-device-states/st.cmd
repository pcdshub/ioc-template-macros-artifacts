#!/reg/g/pcds/package/epics/3.14/ioc/common/device_states/R1.3.1/bin/linux-x86_64/states

< envPaths
epicsEnvSet("IOCNAME", "ioc-xcs-device-states" )
epicsEnvSet("ENGINEER", "Daniel Damiani (ddamiani)" )
epicsEnvSet("LOCATION", "IOC:XCS:DEVICE:STATES" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "IOC:XCS:DEVICE:STATES")
epicsEnvSet("IOCTOP", "/reg/g/pcds/package/epics/3.14/ioc/common/device_states/R1.3.1")
epicsEnvSet("TOP", "/reg/g/pcds/package/epics/3.14/ioc/xcs/device_states/R1.0.1/build")

cd( "$(IOCTOP)" )

# Run the pre startup script
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/states.dbd")
states_registerRecordDeviceDriver(pdbbase)

# Load record instances
dbLoadRecords("db/iocSoft.db", "IOC=$(IOC_PV)")
dbLoadRecords("db/save_restoreStatus.db", "IOC=$(IOC_PV)")
dbLoadRecords( "db/one_state.db", "DEVICE=XCS:LODCM:FOIL,STATE=OUT,SET=0.5,DELTA=0.1,MOVER=HFX:MON:MMS:22.VAL,RBV=HFX:MON:MMS:22.RBV" )
dbLoadRecords( "db/one_state.db", "DEVICE=XCS:LODCM:FOIL,STATE=Mo,SET=70,DELTA=0.1,MOVER=HFX:MON:MMS:22.VAL,RBV=HFX:MON:MMS:22.RBV" )
dbLoadRecords( "db/one_state.db", "DEVICE=XCS:LODCM:FOIL,STATE=Zr,SET=105,DELTA=0.1,MOVER=HFX:MON:MMS:22.VAL,RBV=HFX:MON:MMS:22.RBV" )
dbLoadRecords( "db/one_state.db", "DEVICE=XCS:LODCM:FOIL,STATE=Ge,SET=142,DELTA=0.1,MOVER=HFX:MON:MMS:22.VAL,RBV=HFX:MON:MMS:22.RBV" )
dbLoadRecords( "db/one_state.db", "DEVICE=XCS:LODCM:FOIL,STATE=Cu,SET=177.5,DELTA=0.1,MOVER=HFX:MON:MMS:22.VAL,RBV=HFX:MON:MMS:22.RBV" )
dbLoadRecords( "db/one_state.db", "DEVICE=XCS:LODCM:FOIL,STATE=Ni,SET=214,DELTA=0.1,MOVER=HFX:MON:MMS:22.VAL,RBV=HFX:MON:MMS:22.RBV" )
dbLoadRecords( "db/one_state.db", "DEVICE=XCS:LODCM:FOIL,STATE=Fe,SET=249,DELTA=0.1,MOVER=HFX:MON:MMS:22.VAL,RBV=HFX:MON:MMS:22.RBV" )
dbLoadRecords( "db/one_state.db", "DEVICE=XCS:LODCM:FOIL,STATE=Ti,SET=284,DELTA=0.1,MOVER=HFX:MON:MMS:22.VAL,RBV=HFX:MON:MMS:22.RBV" )
dbLoadRecords( "db/device_with_8states.db", "DEVICE=XCS:LODCM:FOIL,STATE1=OUT,SEVR1=NO_ALARM,STATE2=Mo,SEVR2=NO_ALARM,STATE3=Zr,SEVR3=NO_ALARM,STATE4=Ge,SEVR4=NO_ALARM,STATE5=Cu,SEVR5=NO_ALARM,STATE6=Ni,SEVR6=NO_ALARM,STATE7=Fe,SEVR7=NO_ALARM,STATE8=Ti,SEVR8=NO_ALARM" )
dbLoadRecords( "db/one_state.db", "DEVICE=XCS:SB2:PP:Y,STATE=OUT,SET=9.5,DELTA=1.0,MOVER=XCS:SB2:MMS:21.VAL,RBV=XCS:SB2:MMS:21.RBV" )
dbLoadRecords( "db/one_state.db", "DEVICE=XCS:SB2:PP:Y,STATE=CCM,SET=6.3,DELTA=1.0,MOVER=XCS:SB2:MMS:21.VAL,RBV=XCS:SB2:MMS:21.RBV" )
dbLoadRecords( "db/one_state.db", "DEVICE=XCS:SB2:PP:Y,STATE=PINK,SET=1.0,DELTA=1.0,MOVER=XCS:SB2:MMS:21.VAL,RBV=XCS:SB2:MMS:21.RBV" )
dbLoadRecords( "db/device_with_3states.db", "DEVICE=XCS:SB2:PP:Y,STATE1=OUT,SEVR1=NO_ALARM,STATE2=CCM,SEVR2=MINOR,STATE3=PINK,SEVR3=MINOR" )


# Setup autosave
set_savefile_path("$(IOC_DATA)/$(IOCNAME)/autosave")
set_requestfile_path("$(TOP)/autosave")
save_restoreSet_status_prefix("$(IOC_PV):")
save_restoreSet_IncompleteSetsOk(1)
save_restoreSet_DatedBackupFiles(1)
set_pass0_restoreFile("$(IOCNAME).sav")
set_pass1_restoreFile("$(IOCNAME).sav")
save_restoreSet_NumSeqFiles(5)
save_restoreSet_SeqPeriodInSeconds(30)

# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set("$(IOCNAME).req", 30, "IOC=$(IOC_PV)")
 
# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
