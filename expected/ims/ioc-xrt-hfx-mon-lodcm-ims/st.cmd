#!/reg/g/pcds/epics/ioc/common/ims/R6.3.0/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:XRT:HFX:MON:LODCM:IMS" )
epicsEnvSet( "LOCATION",             "XRT:MON"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-xrt-hfx-mon-lodcm-ims> " )

epicsEnvSet( "DVER",                 "4"           )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IMS)/misc" )

epicsEnvSet( "ENGINEER",             "Tyler Pennebaker (pennebak)"  )


# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase( "$(TOP)/dbd/ims.dbd" )
ims_registerRecordDeviceDriver( pdbbase )

# Load record instances
dbLoadRecords( "$(TOP)/db/iocSoft.db",            "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/save_restoreStatus.db", "IOC=$(EPICS_NAME),P=$(EPICS_NAME):" )
dbLoadRecords( "$(TOP)/db/check_update.db",       "IOC=$(EPICS_NAME)" )











dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=HFX:MON:MMS:04,PORT=moxa-xrt-mon-01:4012,ASYN=HFX:MON:MMS:04,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=HFX:MON:MMS:05,PORT=moxa-xrt-mon-02:4009,ASYN=HFX:MON:MMS:05,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=HFX:MON:MMS:06,PORT=moxa-xrt-mon-02:4010,ASYN=HFX:MON:MMS:06,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=HFX:MON:MMS:07,PORT=moxa-xrt-mon-02:4011,ASYN=HFX:MON:MMS:07,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=HFX:MON:MMS:08,PORT=moxa-xrt-mon-02:4012,ASYN=HFX:MON:MMS:08,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=HFX:MON:MMS:09,PORT=moxa-xrt-mon-01:4005,ASYN=HFX:MON:MMS:09,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=HFX:MON:MMS:10,PORT=moxa-xrt-mon-01:4013,ASYN=HFX:MON:MMS:10,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=HFX:MON:MMS:11,PORT=moxa-xrt-mon-02:4006,ASYN=HFX:MON:MMS:11,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=HFX:MON:MMS:12,PORT=moxa-xrt-mon-01:4006,ASYN=HFX:MON:MMS:12,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=HFX:MON:MMS:13,PORT=moxa-xrt-mon-02:4007,ASYN=HFX:MON:MMS:13,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=HFX:MON:MMS:14,PORT=moxa-xrt-mon-02:4008,ASYN=HFX:MON:MMS:14,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=HFX:MON:MMS:15,PORT=moxa-xrt-mon-01:4007,ASYN=HFX:MON:MMS:15,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=HFX:MON:MMS:16,PORT=moxa-xrt-mon-02:4001,ASYN=HFX:MON:MMS:16,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=HFX:MON:MMS:17,PORT=moxa-xrt-mon-02:4002,ASYN=HFX:MON:MMS:17,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=HFX:MON:MMS:18,PORT=moxa-xrt-mon-02:4003,ASYN=HFX:MON:MMS:18,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=HFX:MON:MMS:19,PORT=moxa-xrt-mon-02:4004,ASYN=HFX:MON:MMS:19,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=HFX:MON:MMS:20,PORT=moxa-xrt-mon-01:4008,ASYN=HFX:MON:MMS:20,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=HFX:MON:MMS:21,PORT=moxa-xrt-mon-02:4005,ASYN=HFX:MON:MMS:21,DVER=$(DVER),ERBL=" )
dbLoadRecords( "$(TOP)/db/ims_short.db", "IOC=$(EPICS_NAME),MOTOR=HFX:MON:MMS:22,PORT=moxa-xrt-mon-02:4016,ASYN=HFX:MON:MMS:22,DVER=$(DVER),ERBL=" )


dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:LODCM:X1,STATE=OUT,SET=-4.5,DELTA=0.05,MOVER=HFX:MON:MMS:05.VAL,RBV=HFX:MON:MMS:05.RBV,DMOV=HFX:MON:MMS:05.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:LODCM:X1,STATE=IN,SET=0,DELTA=0.05,MOVER=HFX:MON:MMS:05.VAL,RBV=HFX:MON:MMS:05.RBV,DMOV=HFX:MON:MMS:05.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XCS:LODCM:X1,STATE1=OUT,SEVR1=NO_ALARM,STATE2=IN,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=HFX:MON:MMS:05,ALIAS=XCS:LODCM:X1:MOTOR" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:LODCM:Y1,STATE=C,SET=14.2,DELTA=3.7,MOVER=HFX:MON:MMS:06.VAL,RBV=HFX:MON:MMS:06.RBV,DMOV=HFX:MON:MMS:06.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:LODCM:Y1,STATE=Si,SET=39.2,DELTA=5.5,MOVER=HFX:MON:MMS:06.VAL,RBV=HFX:MON:MMS:06.RBV,DMOV=HFX:MON:MMS:06.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XCS:LODCM:Y1,STATE1=C,SEVR1=NO_ALARM,STATE2=Si,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=HFX:MON:MMS:06,ALIAS=XCS:LODCM:Y1:MOTOR" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:LODCM:Y2,STATE=C,SET=42.4,DELTA=1.0,MOVER=HFX:MON:MMS:12.VAL,RBV=HFX:MON:MMS:12.RBV,DMOV=HFX:MON:MMS:12.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:LODCM:Y2,STATE=Si,SET=10,DELTA=4.0,MOVER=HFX:MON:MMS:12.VAL,RBV=HFX:MON:MMS:12.RBV,DMOV=HFX:MON:MMS:12.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XCS:LODCM:Y2,STATE1=C,SEVR1=NO_ALARM,STATE2=Si,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=HFX:MON:MMS:12,ALIAS=XCS:LODCM:Y2:MOTOR" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:LODCM:H1N,STATE=OUT,SET=-19.5,DELTA=0.05,MOVER=HFX:MON:MMS:09.VAL,RBV=HFX:MON:MMS:09.RBV,DMOV=HFX:MON:MMS:09.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:LODCM:H1N,STATE=C,SET=-10.3,DELTA=0.005,MOVER=HFX:MON:MMS:09.VAL,RBV=HFX:MON:MMS:09.RBV,DMOV=HFX:MON:MMS:09.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:LODCM:H1N,STATE=Si,SET=-9.3,DELTA=0.005,MOVER=HFX:MON:MMS:09.VAL,RBV=HFX:MON:MMS:09.RBV,DMOV=HFX:MON:MMS:09.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_3states.db", "DEVICE=XCS:LODCM:H1N,STATE1=OUT,SEVR1=NO_ALARM,STATE2=C,SEVR2=NO_ALARM,STATE3=Si,SEVR3=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=HFX:MON:MMS:09,ALIAS=XCS:LODCM:H1N:MOTOR" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:LODCM:H2N,STATE=C,SET=2.0,DELTA=0.005,MOVER=HFX:MON:MMS:15.VAL,RBV=HFX:MON:MMS:15.RBV,DMOV=HFX:MON:MMS:15.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:LODCM:H2N,STATE=Si,SET=0.0,DELTA=0.005,MOVER=HFX:MON:MMS:15.VAL,RBV=HFX:MON:MMS:15.RBV,DMOV=HFX:MON:MMS:15.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XCS:LODCM:H2N,STATE1=C,SEVR1=NO_ALARM,STATE2=Si,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=HFX:MON:MMS:15,ALIAS=XCS:LODCM:H2N:MOTOR" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:LODCM:CHI1,STATE=C,SET=0.0,DELTA=0.05,MOVER=HFX:MON:MMS:08.VAL,RBV=HFX:MON:MMS:08.RBV,DMOV=HFX:MON:MMS:08.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:LODCM:CHI1,STATE=Si,SET=0.7513,DELTA=0.05,MOVER=HFX:MON:MMS:08.VAL,RBV=HFX:MON:MMS:08.RBV,DMOV=HFX:MON:MMS:08.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XCS:LODCM:CHI1,STATE1=C,SEVR1=NO_ALARM,STATE2=Si,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=HFX:MON:MMS:08,ALIAS=XCS:LODCM:CHI1:MOTOR" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:LODCM:CHI2,STATE=C,SET=0.0,DELTA=0.05,MOVER=HFX:MON:MMS:14.VAL,RBV=HFX:MON:MMS:14.RBV,DMOV=HFX:MON:MMS:14.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:LODCM:CHI2,STATE=Si,SET=-0.2367,DELTA=0.05,MOVER=HFX:MON:MMS:14.VAL,RBV=HFX:MON:MMS:14.RBV,DMOV=HFX:MON:MMS:14.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XCS:LODCM:CHI2,STATE1=C,SEVR1=NO_ALARM,STATE2=Si,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=HFX:MON:MMS:14,ALIAS=XCS:LODCM:CHI2:MOTOR" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:LODCM:DV,STATE=OUT,SET=40,DELTA=0.05,MOVER=HFX:MON:MMS:17.VAL,RBV=HFX:MON:MMS:17.RBV,DMOV=HFX:MON:MMS:17.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:LODCM:DV,STATE=YAG,SET=2.0,DELTA=0.05,MOVER=HFX:MON:MMS:17.VAL,RBV=HFX:MON:MMS:17.RBV,DMOV=HFX:MON:MMS:17.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:LODCM:DV,STATE=SLIT1,SET=20.5,DELTA=0.05,MOVER=HFX:MON:MMS:17.VAL,RBV=HFX:MON:MMS:17.RBV,DMOV=HFX:MON:MMS:17.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:LODCM:DV,STATE=SLIT2,SET=25.5,DELTA=0.05,MOVER=HFX:MON:MMS:17.VAL,RBV=HFX:MON:MMS:17.RBV,DMOV=HFX:MON:MMS:17.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:LODCM:DV,STATE=SLIT3,SET=30.5,DELTA=0.05,MOVER=HFX:MON:MMS:17.VAL,RBV=HFX:MON:MMS:17.RBV,DMOV=HFX:MON:MMS:17.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_5states.db", "DEVICE=XCS:LODCM:DV,STATE1=OUT,SEVR1=NO_ALARM,STATE2=YAG,SEVR2=NO_ALARM,STATE3=SLIT1,SEVR3=NO_ALARM,STATE4=SLIT2,SEVR4=NO_ALARM,STATE5=SLIT3,SEVR5=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=HFX:MON:MMS:17,ALIAS=XCS:LODCM:DV:MOTOR" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:LODCM:DH,STATE=OUT,SET=110,DELTA=0.05,MOVER=HFX:MON:MMS:16.VAL,RBV=HFX:MON:MMS:16.RBV,DMOV=HFX:MON:MMS:16.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:LODCM:DH,STATE=DECTRIS,SET=74.0,DELTA=0.05,MOVER=HFX:MON:MMS:16.VAL,RBV=HFX:MON:MMS:16.RBV,DMOV=HFX:MON:MMS:16.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:LODCM:DH,STATE=SLIT1,SET=49.5,DELTA=0.05,MOVER=HFX:MON:MMS:16.VAL,RBV=HFX:MON:MMS:16.RBV,DMOV=HFX:MON:MMS:16.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:LODCM:DH,STATE=SLIT2,SET=26.5,DELTA=0.05,MOVER=HFX:MON:MMS:16.VAL,RBV=HFX:MON:MMS:16.RBV,DMOV=HFX:MON:MMS:16.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:LODCM:DH,STATE=SLIT3,SET=8,DELTA=0.05,MOVER=HFX:MON:MMS:16.VAL,RBV=HFX:MON:MMS:16.RBV,DMOV=HFX:MON:MMS:16.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:LODCM:DH,STATE=OUTLOW,SET=0,DELTA=0.05,MOVER=HFX:MON:MMS:16.VAL,RBV=HFX:MON:MMS:16.RBV,DMOV=HFX:MON:MMS:16.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_6states.db", "DEVICE=XCS:LODCM:DH,STATE1=OUT,SEVR1=NO_ALARM,STATE2=DECTRIS,SEVR2=NO_ALARM,STATE3=SLIT1,SEVR3=NO_ALARM,STATE4=SLIT2,SEVR4=NO_ALARM,STATE5=SLIT3,SEVR5=NO_ALARM,STATE6=OUTLOW,SEVR6=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=HFX:MON:MMS:16,ALIAS=XCS:LODCM:DH:MOTOR" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:LODCM:DIODE,STATE=OUT,SET=0,DELTA=0.05,MOVER=HFX:MON:MMS:18.VAL,RBV=HFX:MON:MMS:18.RBV,DMOV=HFX:MON:MMS:18.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XCS:LODCM:DIODE,STATE=IN,SET=24,DELTA=0.05,MOVER=HFX:MON:MMS:18.VAL,RBV=HFX:MON:MMS:18.RBV,DMOV=HFX:MON:MMS:18.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XCS:LODCM:DIODE,STATE1=OUT,SEVR1=NO_ALARM,STATE2=IN,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=HFX:MON:MMS:18,ALIAS=XCS:LODCM:DIODE:MOTOR" )


dbLoadRecords( "$(TOP)/db/temperature_ilk.db", "ILK=HFX:MON:MMS:04:ILK,DESC=LODCM Temperature Interlock,MOTOR=HFX:MON:MMS:04,TEMP=HFX:MON:MMS:04:TEMP,LOCK=120,RELEASE=100" )
dbLoadRecords( "$(TOP)/db/temperature_ilk.db", "ILK=HFX:MON:MMS:05:ILK,DESC=LODCM Temperature Interlock,MOTOR=HFX:MON:MMS:05,TEMP=HFX:MON:MMS:05:TEMP,LOCK=120,RELEASE=100" )
dbLoadRecords( "$(TOP)/db/temperature_ilk.db", "ILK=HFX:MON:MMS:06:ILK,DESC=LODCM Temperature Interlock,MOTOR=HFX:MON:MMS:06,TEMP=HFX:MON:MMS:06:TEMP,LOCK=120,RELEASE=100" )
dbLoadRecords( "$(TOP)/db/temperature_ilk.db", "ILK=HFX:MON:MMS:07:ILK,DESC=LODCM Temperature Interlock,MOTOR=HFX:MON:MMS:07,TEMP=HFX:MON:MMS:07:TEMP,LOCK=120,RELEASE=100" )
dbLoadRecords( "$(TOP)/db/temperature_ilk.db", "ILK=HFX:MON:MMS:08:ILK,DESC=LODCM Temperature Interlock,MOTOR=HFX:MON:MMS:08,TEMP=HFX:MON:MMS:08:TEMP,LOCK=120,RELEASE=100" )
dbLoadRecords( "$(TOP)/db/temperature_ilk.db", "ILK=HFX:MON:MMS:09:ILK,DESC=LODCM Temperature Interlock,MOTOR=HFX:MON:MMS:09,TEMP=HFX:MON:MMS:09:TEMP,LOCK=120,RELEASE=100" )
dbLoadRecords( "$(TOP)/db/temperature_ilk.db", "ILK=HFX:MON:MMS:10:ILK,DESC=LODCM Temperature Interlock,MOTOR=HFX:MON:MMS:10,TEMP=HFX:MON:MMS:10:TEMP,LOCK=120,RELEASE=100" )
dbLoadRecords( "$(TOP)/db/temperature_ilk.db", "ILK=HFX:MON:MMS:11:ILK,DESC=LODCM Temperature Interlock,MOTOR=HFX:MON:MMS:11,TEMP=HFX:MON:MMS:11:TEMP,LOCK=120,RELEASE=100" )
dbLoadRecords( "$(TOP)/db/temperature_ilk.db", "ILK=HFX:MON:MMS:12:ILK,DESC=LODCM Temperature Interlock,MOTOR=HFX:MON:MMS:12,TEMP=HFX:MON:MMS:12:TEMP,LOCK=120,RELEASE=100" )
dbLoadRecords( "$(TOP)/db/temperature_ilk.db", "ILK=HFX:MON:MMS:13:ILK,DESC=LODCM Temperature Interlock,MOTOR=HFX:MON:MMS:13,TEMP=HFX:MON:MMS:13:TEMP,LOCK=120,RELEASE=100" )
dbLoadRecords( "$(TOP)/db/temperature_ilk.db", "ILK=HFX:MON:MMS:14:ILK,DESC=LODCM Temperature Interlock,MOTOR=HFX:MON:MMS:14,TEMP=HFX:MON:MMS:14:TEMP,LOCK=120,RELEASE=100" )
dbLoadRecords( "$(TOP)/db/temperature_ilk.db", "ILK=HFX:MON:MMS:15:ILK,DESC=LODCM Temperature Interlock,MOTOR=HFX:MON:MMS:15,TEMP=HFX:MON:MMS:15:TEMP,LOCK=120,RELEASE=100" )
dbLoadRecords( "$(TOP)/db/temperature_ilk.db", "ILK=HFX:MON:MMS:16:ILK,DESC=LODCM Temperature Interlock,MOTOR=HFX:MON:MMS:16,TEMP=HFX:MON:MMS:16:TEMP,LOCK=120,RELEASE=100" )
dbLoadRecords( "$(TOP)/db/temperature_ilk.db", "ILK=HFX:MON:MMS:17:ILK,DESC=LODCM Temperature Interlock,MOTOR=HFX:MON:MMS:17,TEMP=HFX:MON:MMS:17:TEMP,LOCK=120,RELEASE=100" )
dbLoadRecords( "$(TOP)/db/temperature_ilk.db", "ILK=HFX:MON:MMS:18:ILK,DESC=LODCM Temperature Interlock,MOTOR=HFX:MON:MMS:18,TEMP=HFX:MON:MMS:18:TEMP,LOCK=120,RELEASE=100" )
dbLoadRecords( "$(TOP)/db/temperature_ilk.db", "ILK=HFX:MON:MMS:19:ILK,DESC=LODCM Temperature Interlock,MOTOR=HFX:MON:MMS:19,TEMP=HFX:MON:MMS:19:TEMP,LOCK=120,RELEASE=100" )
dbLoadRecords( "$(TOP)/db/temperature_ilk.db", "ILK=HFX:MON:MMS:20:ILK,DESC=LODCM Temperature Interlock,MOTOR=HFX:MON:MMS:20,TEMP=HFX:MON:MMS:20:TEMP,LOCK=120,RELEASE=100" )
dbLoadRecords( "$(TOP)/db/temperature_ilk.db", "ILK=HFX:MON:MMS:21:ILK,DESC=LODCM Temperature Interlock,MOTOR=HFX:MON:MMS:21,TEMP=HFX:MON:MMS:21:TEMP,LOCK=120,RELEASE=100" )
dbLoadRecords( "$(TOP)/db/temperature_ilk.db", "ILK=HFX:MON:MMS:22:ILK,DESC=LODCM Temperature Interlock,MOTOR=HFX:MON:MMS:22,TEMP=HFX:MON:MMS:22:TEMP,LOCK=120,RELEASE=100" )

var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-xrt-hfx-mon-lodcm-ims/autosave" )

set_pass0_restoreFile( "ioc-xrt-hfx-mon-lodcm-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-xrt-hfx-mon-lodcm-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

