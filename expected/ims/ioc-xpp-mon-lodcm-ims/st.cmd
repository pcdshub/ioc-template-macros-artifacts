#!/reg/g/pcds/epics/ioc/common/ims/R6.7.0/bin/rhel7-x86_64/ims

< envPaths

epicsEnvSet( "EPICS_NAME",           "IOC:XPP:MON:LODCM:IMS" )
epicsEnvSet( "LOCATION",             "XPP:MON"  )
epicsEnvSet( "IOCSH_PS1",            "ioc-xpp-mon-lodcm-ims> " )

epicsEnvSet( "DVER",                 "4"           )
epicsEnvSet( "STREAM_PROTOCOL_PATH", "$(IMS)/misc" )

epicsEnvSet( "ENGINEER",             "Ali Sabbah (sabbah01)"  )


# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase( "$(TOP)/dbd/ims.dbd" )
ims_registerRecordDeviceDriver( pdbbase )

# Load record instances
dbLoadRecords( "$(TOP)/db/iocSoft.db",            "IOC=$(EPICS_NAME)" )
dbLoadRecords( "$(TOP)/db/save_restoreStatus.db", "IOC=$(EPICS_NAME),P=$(EPICS_NAME):" )
dbLoadRecords( "$(TOP)/db/check_update.db",       "IOC=$(EPICS_NAME)" )











dbLoadRecords( "$(TOP)/db/ims_long.db", "IOC=$(EPICS_NAME),MOTOR=XPP:MON:MMS:04,PORT=moxa-xpp-04:4015,ASYN=XPP:MON:MMS:04,DVER=$(DVER),ERBL=,DESC=,TYPE=,EE=Disable,EL=512,MT=0,HT=500,RCMX=5,RC=5,HCMX=0,HC=0,EGU=,DIR=Pos,SREV=51200,UREV=1,BDST=0,HDST=5,RDBD=3,PDBD=5,SBAS=0.5,SMAX=2.0,S=1.0,BS=1.0,HS=1.0,ACCL=1,BACC=1,HACC=1,DLLM=0,DHLM=0,FW_MEANS=+,REV_MEANS=-" )
dbLoadRecords( "$(TOP)/db/ims_long.db", "IOC=$(EPICS_NAME),MOTOR=XPP:MON:MMS:05,PORT=moxa-xpp-03:4009,ASYN=XPP:MON:MMS:05,DVER=$(DVER),ERBL=,DESC=,TYPE=,EE=Disable,EL=512,MT=0,HT=500,RCMX=5,RC=5,HCMX=0,HC=0,EGU=,DIR=Pos,SREV=51200,UREV=1,BDST=0,HDST=5,RDBD=3,PDBD=5,SBAS=0.5,SMAX=2.0,S=1.0,BS=1.0,HS=1.0,ACCL=1,BACC=1,HACC=1,DLLM=0,DHLM=0,FW_MEANS=+,REV_MEANS=-" )
dbLoadRecords( "$(TOP)/db/ims_long.db", "IOC=$(EPICS_NAME),MOTOR=XPP:MON:MMS:06,PORT=moxa-xpp-03:4010,ASYN=XPP:MON:MMS:06,DVER=$(DVER),ERBL=,DESC=,TYPE=,EE=Disable,EL=512,MT=0,HT=500,RCMX=5,RC=5,HCMX=0,HC=0,EGU=,DIR=Pos,SREV=51200,UREV=1,BDST=0,HDST=5,RDBD=3,PDBD=5,SBAS=0.5,SMAX=2.0,S=1.0,BS=1.0,HS=1.0,ACCL=1,BACC=1,HACC=1,DLLM=0,DHLM=0,FW_MEANS=+,REV_MEANS=-" )
dbLoadRecords( "$(TOP)/db/ims_long.db", "IOC=$(EPICS_NAME),MOTOR=XPP:MON:MMS:07,PORT=moxa-xpp-03:4011,ASYN=XPP:MON:MMS:07,DVER=$(DVER),ERBL=,DESC=,TYPE=,EE=Disable,EL=512,MT=0,HT=500,RCMX=5,RC=5,HCMX=0,HC=0,EGU=,DIR=Pos,SREV=51200,UREV=1,BDST=0,HDST=5,RDBD=3,PDBD=5,SBAS=0.5,SMAX=2.0,S=1.0,BS=1.0,HS=1.0,ACCL=1,BACC=1,HACC=1,DLLM=0,DHLM=0,FW_MEANS=+,REV_MEANS=-" )
dbLoadRecords( "$(TOP)/db/ims_long.db", "IOC=$(EPICS_NAME),MOTOR=XPP:MON:MMS:08,PORT=moxa-xpp-03:4012,ASYN=XPP:MON:MMS:08,DVER=$(DVER),ERBL=,DESC=,TYPE=,EE=Disable,EL=512,MT=0,HT=500,RCMX=5,RC=5,HCMX=0,HC=0,EGU=,DIR=Pos,SREV=51200,UREV=1,BDST=0,HDST=5,RDBD=3,PDBD=5,SBAS=0.5,SMAX=2.0,S=1.0,BS=1.0,HS=1.0,ACCL=1,BACC=1,HACC=1,DLLM=0,DHLM=0,FW_MEANS=+,REV_MEANS=-" )
dbLoadRecords( "$(TOP)/db/ims_long.db", "IOC=$(EPICS_NAME),MOTOR=XPP:MON:MMS:09,PORT=moxa-xpp-03:4013,ASYN=XPP:MON:MMS:09,DVER=$(DVER),ERBL=,DESC=,TYPE=,EE=Disable,EL=512,MT=0,HT=500,RCMX=5,RC=5,HCMX=0,HC=0,EGU=,DIR=Pos,SREV=51200,UREV=1,BDST=0,HDST=5,RDBD=3,PDBD=5,SBAS=0.5,SMAX=2.0,S=1.0,BS=1.0,HS=1.0,ACCL=1,BACC=1,HACC=1,DLLM=0,DHLM=0,FW_MEANS=+,REV_MEANS=-" )
dbLoadRecords( "$(TOP)/db/ims_long.db", "IOC=$(EPICS_NAME),MOTOR=XPP:MON:MMS:10,PORT=moxa-xpp-04:4016,ASYN=XPP:MON:MMS:10,DVER=$(DVER),ERBL=,DESC=,TYPE=,EE=Disable,EL=512,MT=0,HT=500,RCMX=5,RC=5,HCMX=0,HC=0,EGU=,DIR=Pos,SREV=51200,UREV=1,BDST=0,HDST=5,RDBD=3,PDBD=5,SBAS=0.5,SMAX=2.0,S=1.0,BS=1.0,HS=1.0,ACCL=1,BACC=1,HACC=1,DLLM=0,DHLM=0,FW_MEANS=+,REV_MEANS=-" )
dbLoadRecords( "$(TOP)/db/ims_long.db", "IOC=$(EPICS_NAME),MOTOR=XPP:MON:MMS:11,PORT=moxa-xpp-03:4006,ASYN=XPP:MON:MMS:11,DVER=$(DVER),ERBL=,DESC=,TYPE=,EE=Disable,EL=512,MT=0,HT=500,RCMX=5,RC=5,HCMX=0,HC=0,EGU=,DIR=Pos,SREV=51200,UREV=1,BDST=0,HDST=5,RDBD=3,PDBD=5,SBAS=0.5,SMAX=2.0,S=1.0,BS=1.0,HS=1.0,ACCL=1,BACC=1,HACC=1,DLLM=0,DHLM=0,FW_MEANS=+,REV_MEANS=-" )
dbLoadRecords( "$(TOP)/db/ims_long.db", "IOC=$(EPICS_NAME),MOTOR=XPP:MON:MMS:12,PORT=moxa-xpp-03:4014,ASYN=XPP:MON:MMS:12,DVER=$(DVER),ERBL=,DESC=,TYPE=,EE=Disable,EL=512,MT=0,HT=500,RCMX=5,RC=5,HCMX=0,HC=0,EGU=,DIR=Pos,SREV=51200,UREV=1,BDST=0,HDST=5,RDBD=3,PDBD=5,SBAS=0.5,SMAX=2.0,S=1.0,BS=1.0,HS=1.0,ACCL=1,BACC=1,HACC=1,DLLM=0,DHLM=0,FW_MEANS=+,REV_MEANS=-" )
dbLoadRecords( "$(TOP)/db/ims_long.db", "IOC=$(EPICS_NAME),MOTOR=XPP:MON:MMS:13,PORT=moxa-xpp-03:4007,ASYN=XPP:MON:MMS:13,DVER=$(DVER),ERBL=,DESC=,TYPE=,EE=Disable,EL=512,MT=0,HT=500,RCMX=5,RC=5,HCMX=0,HC=0,EGU=,DIR=Pos,SREV=51200,UREV=1,BDST=0,HDST=5,RDBD=3,PDBD=5,SBAS=0.5,SMAX=2.0,S=1.0,BS=1.0,HS=1.0,ACCL=1,BACC=1,HACC=1,DLLM=0,DHLM=0,FW_MEANS=+,REV_MEANS=-" )
dbLoadRecords( "$(TOP)/db/ims_long.db", "IOC=$(EPICS_NAME),MOTOR=XPP:MON:MMS:14,PORT=moxa-xpp-03:4008,ASYN=XPP:MON:MMS:14,DVER=$(DVER),ERBL=,DESC=,TYPE=,EE=Disable,EL=512,MT=0,HT=500,RCMX=5,RC=5,HCMX=0,HC=0,EGU=,DIR=Pos,SREV=51200,UREV=1,BDST=0,HDST=5,RDBD=3,PDBD=5,SBAS=0.5,SMAX=2.0,S=1.0,BS=1.0,HS=1.0,ACCL=1,BACC=1,HACC=1,DLLM=0,DHLM=0,FW_MEANS=+,REV_MEANS=-" )
dbLoadRecords( "$(TOP)/db/ims_long.db", "IOC=$(EPICS_NAME),MOTOR=XPP:MON:MMS:15,PORT=moxa-xpp-03:4015,ASYN=XPP:MON:MMS:15,DVER=$(DVER),ERBL=,DESC=,TYPE=,EE=Disable,EL=512,MT=0,HT=500,RCMX=5,RC=5,HCMX=0,HC=0,EGU=,DIR=Pos,SREV=51200,UREV=1,BDST=0,HDST=5,RDBD=3,PDBD=5,SBAS=0.5,SMAX=2.0,S=1.0,BS=1.0,HS=1.0,ACCL=1,BACC=1,HACC=1,DLLM=0,DHLM=0,FW_MEANS=+,REV_MEANS=-" )
dbLoadRecords( "$(TOP)/db/ims_long.db", "IOC=$(EPICS_NAME),MOTOR=XPP:MON:MMS:16,PORT=moxa-xpp-03:4001,ASYN=XPP:MON:MMS:16,DVER=$(DVER),ERBL=,DESC=,TYPE=,EE=Disable,EL=512,MT=0,HT=500,RCMX=5,RC=5,HCMX=0,HC=0,EGU=,DIR=Pos,SREV=51200,UREV=1,BDST=0,HDST=5,RDBD=3,PDBD=5,SBAS=0.5,SMAX=2.0,S=1.0,BS=1.0,HS=1.0,ACCL=1,BACC=1,HACC=1,DLLM=0,DHLM=0,FW_MEANS=+,REV_MEANS=-" )
dbLoadRecords( "$(TOP)/db/ims_long.db", "IOC=$(EPICS_NAME),MOTOR=XPP:MON:MMS:17,PORT=moxa-xpp-03:4002,ASYN=XPP:MON:MMS:17,DVER=$(DVER),ERBL=,DESC=,TYPE=,EE=Disable,EL=512,MT=0,HT=500,RCMX=5,RC=5,HCMX=0,HC=0,EGU=,DIR=Pos,SREV=51200,UREV=1,BDST=0,HDST=5,RDBD=3,PDBD=5,SBAS=0.5,SMAX=2.0,S=1.0,BS=1.0,HS=1.0,ACCL=1,BACC=1,HACC=1,DLLM=0,DHLM=0,FW_MEANS=+,REV_MEANS=-" )
dbLoadRecords( "$(TOP)/db/ims_long.db", "IOC=$(EPICS_NAME),MOTOR=XPP:MON:MMS:18,PORT=moxa-xpp-03:4003,ASYN=XPP:MON:MMS:18,DVER=$(DVER),ERBL=,DESC=,TYPE=,EE=Disable,EL=512,MT=0,HT=500,RCMX=5,RC=5,HCMX=0,HC=0,EGU=,DIR=Pos,SREV=51200,UREV=1,BDST=0,HDST=5,RDBD=3,PDBD=5,SBAS=0.5,SMAX=2.0,S=1.0,BS=1.0,HS=1.0,ACCL=1,BACC=1,HACC=1,DLLM=0,DHLM=0,FW_MEANS=+,REV_MEANS=-" )
dbLoadRecords( "$(TOP)/db/ims_long.db", "IOC=$(EPICS_NAME),MOTOR=XPP:MON:MMS:19,PORT=moxa-xpp-03:4004,ASYN=XPP:MON:MMS:19,DVER=$(DVER),ERBL=,DESC=,TYPE=,EE=Disable,EL=512,MT=0,HT=500,RCMX=5,RC=5,HCMX=0,HC=0,EGU=,DIR=Pos,SREV=51200,UREV=1,BDST=0,HDST=5,RDBD=3,PDBD=5,SBAS=0.5,SMAX=2.0,S=1.0,BS=1.0,HS=1.0,ACCL=1,BACC=1,HACC=1,DLLM=0,DHLM=0,FW_MEANS=+,REV_MEANS=-" )
dbLoadRecords( "$(TOP)/db/ims_long.db", "IOC=$(EPICS_NAME),MOTOR=XPP:MON:MMS:20,PORT=moxa-xpp-03:4016,ASYN=XPP:MON:MMS:20,DVER=$(DVER),ERBL=,DESC=,TYPE=,EE=Disable,EL=512,MT=0,HT=500,RCMX=5,RC=5,HCMX=0,HC=0,EGU=,DIR=Pos,SREV=51200,UREV=1,BDST=0,HDST=5,RDBD=3,PDBD=5,SBAS=0.5,SMAX=2.0,S=1.0,BS=1.0,HS=1.0,ACCL=1,BACC=1,HACC=1,DLLM=0,DHLM=0,FW_MEANS=+,REV_MEANS=-" )
dbLoadRecords( "$(TOP)/db/ims_long.db", "IOC=$(EPICS_NAME),MOTOR=XPP:MON:MMS:21,PORT=moxa-xpp-03:4005,ASYN=XPP:MON:MMS:21,DVER=$(DVER),ERBL=,DESC=,TYPE=,EE=Disable,EL=512,MT=0,HT=500,RCMX=5,RC=5,HCMX=0,HC=0,EGU=,DIR=Pos,SREV=51200,UREV=1,BDST=0,HDST=5,RDBD=3,PDBD=5,SBAS=0.5,SMAX=2.0,S=1.0,BS=1.0,HS=1.0,ACCL=1,BACC=1,HACC=1,DLLM=0,DHLM=0,FW_MEANS=+,REV_MEANS=-" )
dbLoadRecords( "$(TOP)/db/ims_long.db", "IOC=$(EPICS_NAME),MOTOR=XPP:MON:MMS:27,PORT=moxa-xpp-04:4014,ASYN=XPP:MON:MMS:27,DVER=$(DVER),ERBL=,DESC=,TYPE=,EE=Disable,EL=512,MT=0,HT=500,RCMX=5,RC=5,HCMX=0,HC=0,EGU=,DIR=Pos,SREV=51200,UREV=1,BDST=0,HDST=5,RDBD=3,PDBD=5,SBAS=0.5,SMAX=2.0,S=1.0,BS=1.0,HS=1.0,ACCL=1,BACC=1,HACC=1,DLLM=0,DHLM=0,FW_MEANS=+,REV_MEANS=-" )


dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:LODCM:Y1,STATE=C,SET=37.29,DELTA=0.05,MOVER=XPP:MON:MMS:06.VAL,RBV=XPP:MON:MMS:06.RBV,DMOV=XPP:MON:MMS:06.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:LODCM:Y1,STATE=Si,SET=12.5,DELTA=0.05,MOVER=XPP:MON:MMS:06.VAL,RBV=XPP:MON:MMS:06.RBV,DMOV=XPP:MON:MMS:06.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XPP:LODCM:Y1,STATE1=C,SEVR1=NO_ALARM,STATE2=Si,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XPP:MON:MMS:06,ALIAS=XPP:LODCM:Y1:MOTOR" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:LODCM:Y2,STATE=C,SET=20.63,DELTA=0.05,MOVER=XPP:MON:MMS:12.VAL,RBV=XPP:MON:MMS:12.RBV,DMOV=XPP:MON:MMS:12.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:LODCM:Y2,STATE=Si,SET=-6,DELTA=0.05,MOVER=XPP:MON:MMS:12.VAL,RBV=XPP:MON:MMS:12.RBV,DMOV=XPP:MON:MMS:12.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XPP:LODCM:Y2,STATE1=C,SEVR1=NO_ALARM,STATE2=Si,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XPP:MON:MMS:12,ALIAS=XPP:LODCM:Y2:MOTOR" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:LODCM:H1N,STATE=OUT,SET=-15,DELTA=0.05,MOVER=XPP:MON:MMS:09.VAL,RBV=XPP:MON:MMS:09.RBV,DMOV=XPP:MON:MMS:09.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:LODCM:H1N,STATE=C,SET=-3.78,DELTA=0.005,MOVER=XPP:MON:MMS:09.VAL,RBV=XPP:MON:MMS:09.RBV,DMOV=XPP:MON:MMS:09.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:LODCM:H1N,STATE=Si,SET=-2.4,DELTA=0.005,MOVER=XPP:MON:MMS:09.VAL,RBV=XPP:MON:MMS:09.RBV,DMOV=XPP:MON:MMS:09.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_3states.db", "DEVICE=XPP:LODCM:H1N,STATE1=OUT,SEVR1=NO_ALARM,STATE2=C,SEVR2=NO_ALARM,STATE3=Si,SEVR3=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XPP:MON:MMS:09,ALIAS=XPP:LODCM:H1N:MOTOR" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:LODCM:H2N,STATE=C,SET=2.61,DELTA=0.005,MOVER=XPP:MON:MMS:15.VAL,RBV=XPP:MON:MMS:15.RBV,DMOV=XPP:MON:MMS:15.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:LODCM:H2N,STATE=Si,SET=2.6,DELTA=0.005,MOVER=XPP:MON:MMS:15.VAL,RBV=XPP:MON:MMS:15.RBV,DMOV=XPP:MON:MMS:15.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XPP:LODCM:H2N,STATE1=C,SEVR1=NO_ALARM,STATE2=Si,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XPP:MON:MMS:15,ALIAS=XPP:LODCM:H2N:MOTOR" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:LODCM:CHI1,STATE=C,SET=-3.15,DELTA=0.05,MOVER=XPP:MON:MMS:08.VAL,RBV=XPP:MON:MMS:08.RBV,DMOV=XPP:MON:MMS:08.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:LODCM:CHI1,STATE=Si,SET=-0.6835,DELTA=0.05,MOVER=XPP:MON:MMS:08.VAL,RBV=XPP:MON:MMS:08.RBV,DMOV=XPP:MON:MMS:08.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XPP:LODCM:CHI1,STATE1=C,SEVR1=NO_ALARM,STATE2=Si,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XPP:MON:MMS:08,ALIAS=XPP:LODCM:CHI1:MOTOR" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:LODCM:CHI2,STATE=C,SET=-2.18,DELTA=0.05,MOVER=XPP:MON:MMS:14.VAL,RBV=XPP:MON:MMS:14.RBV,DMOV=XPP:MON:MMS:14.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:LODCM:CHI2,STATE=Si,SET=0.3792,DELTA=0.05,MOVER=XPP:MON:MMS:14.VAL,RBV=XPP:MON:MMS:14.RBV,DMOV=XPP:MON:MMS:14.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XPP:LODCM:CHI2,STATE1=C,SEVR1=NO_ALARM,STATE2=Si,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XPP:MON:MMS:14,ALIAS=XPP:LODCM:CHI2:MOTOR" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:LODCM:DV,STATE=OUT,SET=40,DELTA=0.05,MOVER=XPP:MON:MMS:17.VAL,RBV=XPP:MON:MMS:17.RBV,DMOV=XPP:MON:MMS:17.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:LODCM:DV,STATE=YAG,SET=0.67,DELTA=0.05,MOVER=XPP:MON:MMS:17.VAL,RBV=XPP:MON:MMS:17.RBV,DMOV=XPP:MON:MMS:17.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:LODCM:DV,STATE=SLIT1,SET=20.5,DELTA=0.05,MOVER=XPP:MON:MMS:17.VAL,RBV=XPP:MON:MMS:17.RBV,DMOV=XPP:MON:MMS:17.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:LODCM:DV,STATE=SLIT2,SET=25.5,DELTA=0.05,MOVER=XPP:MON:MMS:17.VAL,RBV=XPP:MON:MMS:17.RBV,DMOV=XPP:MON:MMS:17.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:LODCM:DV,STATE=SLIT3,SET=30.5,DELTA=0.05,MOVER=XPP:MON:MMS:17.VAL,RBV=XPP:MON:MMS:17.RBV,DMOV=XPP:MON:MMS:17.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_5states.db", "DEVICE=XPP:LODCM:DV,STATE1=OUT,SEVR1=NO_ALARM,STATE2=YAG,SEVR2=NO_ALARM,STATE3=SLIT1,SEVR3=NO_ALARM,STATE4=SLIT2,SEVR4=NO_ALARM,STATE5=SLIT3,SEVR5=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XPP:MON:MMS:17,ALIAS=XPP:LODCM:DV:MOTOR" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:LODCM:DH,STATE=OUT,SET=110,DELTA=0.05,MOVER=XPP:MON:MMS:16.VAL,RBV=XPP:MON:MMS:16.RBV,DMOV=XPP:MON:MMS:16.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:LODCM:DH,STATE=DECTRIS,SET=33.4,DELTA=0.05,MOVER=XPP:MON:MMS:16.VAL,RBV=XPP:MON:MMS:16.RBV,DMOV=XPP:MON:MMS:16.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:LODCM:DH,STATE=SLIT1,SET=49.5,DELTA=0.05,MOVER=XPP:MON:MMS:16.VAL,RBV=XPP:MON:MMS:16.RBV,DMOV=XPP:MON:MMS:16.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:LODCM:DH,STATE=SLIT2,SET=26.5,DELTA=0.05,MOVER=XPP:MON:MMS:16.VAL,RBV=XPP:MON:MMS:16.RBV,DMOV=XPP:MON:MMS:16.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:LODCM:DH,STATE=SLIT3,SET=8,DELTA=0.05,MOVER=XPP:MON:MMS:16.VAL,RBV=XPP:MON:MMS:16.RBV,DMOV=XPP:MON:MMS:16.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:LODCM:DH,STATE=OUTLOW,SET=0,DELTA=0.05,MOVER=XPP:MON:MMS:16.VAL,RBV=XPP:MON:MMS:16.RBV,DMOV=XPP:MON:MMS:16.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_6states.db", "DEVICE=XPP:LODCM:DH,STATE1=OUT,SEVR1=NO_ALARM,STATE2=DECTRIS,SEVR2=NO_ALARM,STATE3=SLIT1,SEVR3=NO_ALARM,STATE4=SLIT2,SEVR4=NO_ALARM,STATE5=SLIT3,SEVR5=NO_ALARM,STATE6=OUTLOW,SEVR6=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XPP:MON:MMS:16,ALIAS=XPP:LODCM:DH:MOTOR" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:LODCM:DIODE,STATE=OUT,SET=0,DELTA=0.05,MOVER=XPP:MON:MMS:18.VAL,RBV=XPP:MON:MMS:18.RBV,DMOV=XPP:MON:MMS:18.DMOV" )
dbLoadRecords( "$(TOP)/db/one_state.db", "DEVICE=XPP:LODCM:DIODE,STATE=IN,SET=24,DELTA=0.05,MOVER=XPP:MON:MMS:18.VAL,RBV=XPP:MON:MMS:18.RBV,DMOV=XPP:MON:MMS:18.DMOV" )
dbLoadRecords( "$(TOP)/db/device_with_2states.db", "DEVICE=XPP:LODCM:DIODE,STATE1=OUT,SEVR1=NO_ALARM,STATE2=IN,SEVR2=NO_ALARM" )
dbLoadRecords( "$(TOP)/db/alias.db", "SOURCE=XPP:MON:MMS:18,ALIAS=XPP:LODCM:DIODE:MOTOR" )


dbLoadRecords( "$(TOP)/db/temperature_ilk.db", "ILK=XPP:MON:MMS:04:ILK,DESC=LODCM Temperature Interlock,MOTOR=XPP:MON:MMS:04,TEMP=XPP:MON:MMS:04:TEMP,LOCK=120,RELEASE=100" )
dbLoadRecords( "$(TOP)/db/temperature_ilk.db", "ILK=XPP:MON:MMS:05:ILK,DESC=LODCM Temperature Interlock,MOTOR=XPP:MON:MMS:05,TEMP=XPP:MON:MMS:05:TEMP,LOCK=120,RELEASE=100" )
dbLoadRecords( "$(TOP)/db/temperature_ilk.db", "ILK=XPP:MON:MMS:06:ILK,DESC=LODCM Temperature Interlock,MOTOR=XPP:MON:MMS:06,TEMP=XPP:MON:MMS:06:TEMP,LOCK=120,RELEASE=100" )
dbLoadRecords( "$(TOP)/db/temperature_ilk.db", "ILK=XPP:MON:MMS:07:ILK,DESC=LODCM Temperature Interlock,MOTOR=XPP:MON:MMS:07,TEMP=XPP:MON:MMS:07:TEMP,LOCK=120,RELEASE=100" )
dbLoadRecords( "$(TOP)/db/temperature_ilk.db", "ILK=XPP:MON:MMS:08:ILK,DESC=LODCM Temperature Interlock,MOTOR=XPP:MON:MMS:08,TEMP=XPP:MON:MMS:08:TEMP,LOCK=120,RELEASE=100" )
dbLoadRecords( "$(TOP)/db/temperature_ilk.db", "ILK=XPP:MON:MMS:09:ILK,DESC=LODCM Temperature Interlock,MOTOR=XPP:MON:MMS:09,TEMP=XPP:MON:MMS:09:TEMP,LOCK=120,RELEASE=100" )
dbLoadRecords( "$(TOP)/db/temperature_ilk.db", "ILK=XPP:MON:MMS:10:ILK,DESC=LODCM Temperature Interlock,MOTOR=XPP:MON:MMS:10,TEMP=XPP:MON:MMS:10:TEMP,LOCK=120,RELEASE=100" )
dbLoadRecords( "$(TOP)/db/temperature_ilk.db", "ILK=XPP:MON:MMS:11:ILK,DESC=LODCM Temperature Interlock,MOTOR=XPP:MON:MMS:11,TEMP=XPP:MON:MMS:11:TEMP,LOCK=120,RELEASE=100" )
dbLoadRecords( "$(TOP)/db/temperature_ilk.db", "ILK=XPP:MON:MMS:12:ILK,DESC=LODCM Temperature Interlock,MOTOR=XPP:MON:MMS:12,TEMP=XPP:MON:MMS:12:TEMP,LOCK=120,RELEASE=100" )
dbLoadRecords( "$(TOP)/db/temperature_ilk.db", "ILK=XPP:MON:MMS:13:ILK,DESC=LODCM Temperature Interlock,MOTOR=XPP:MON:MMS:13,TEMP=XPP:MON:MMS:13:TEMP,LOCK=120,RELEASE=100" )
dbLoadRecords( "$(TOP)/db/temperature_ilk.db", "ILK=XPP:MON:MMS:14:ILK,DESC=LODCM Temperature Interlock,MOTOR=XPP:MON:MMS:14,TEMP=XPP:MON:MMS:14:TEMP,LOCK=120,RELEASE=100" )
dbLoadRecords( "$(TOP)/db/temperature_ilk.db", "ILK=XPP:MON:MMS:15:ILK,DESC=LODCM Temperature Interlock,MOTOR=XPP:MON:MMS:15,TEMP=XPP:MON:MMS:15:TEMP,LOCK=120,RELEASE=100" )
dbLoadRecords( "$(TOP)/db/temperature_ilk.db", "ILK=XPP:MON:MMS:16:ILK,DESC=LODCM Temperature Interlock,MOTOR=XPP:MON:MMS:16,TEMP=XPP:MON:MMS:16:TEMP,LOCK=120,RELEASE=100" )
dbLoadRecords( "$(TOP)/db/temperature_ilk.db", "ILK=XPP:MON:MMS:17:ILK,DESC=LODCM Temperature Interlock,MOTOR=XPP:MON:MMS:17,TEMP=XPP:MON:MMS:17:TEMP,LOCK=120,RELEASE=100" )
dbLoadRecords( "$(TOP)/db/temperature_ilk.db", "ILK=XPP:MON:MMS:18:ILK,DESC=LODCM Temperature Interlock,MOTOR=XPP:MON:MMS:18,TEMP=XPP:MON:MMS:18:TEMP,LOCK=120,RELEASE=100" )
dbLoadRecords( "$(TOP)/db/temperature_ilk.db", "ILK=XPP:MON:MMS:19:ILK,DESC=LODCM Temperature Interlock,MOTOR=XPP:MON:MMS:19,TEMP=XPP:MON:MMS:19:TEMP,LOCK=120,RELEASE=100" )
dbLoadRecords( "$(TOP)/db/temperature_ilk.db", "ILK=XPP:MON:MMS:20:ILK,DESC=LODCM Temperature Interlock,MOTOR=XPP:MON:MMS:20,TEMP=XPP:MON:MMS:20:TEMP,LOCK=120,RELEASE=100" )
dbLoadRecords( "$(TOP)/db/temperature_ilk.db", "ILK=XPP:MON:MMS:21:ILK,DESC=LODCM Temperature Interlock,MOTOR=XPP:MON:MMS:21,TEMP=XPP:MON:MMS:21:TEMP,LOCK=120,RELEASE=100" )
dbLoadRecords( "$(TOP)/db/temperature_ilk.db", "ILK=XPP:MON:MMS:27:ILK,DESC=LODCM Temperature Interlock,MOTOR=XPP:MON:MMS:27,TEMP=XPP:MON:MMS:27:TEMP,LOCK=120,RELEASE=100" )

var imsRecordDebug 0
# var save_restoreDebug 30

# autosave
save_restoreSet_status_prefix( "$(EPICS_NAME):" )
save_restoreSet_NumSeqFiles       (  5 )
save_restoreSet_SeqPeriodInSeconds( 30 )

save_restoreSet_IncompleteSetsOk  (  1 )
save_restoreSet_DatedBackupFiles  (  1 )

set_requestfile_path ( "$(PWD)/../../autosave"          )
set_savefile_path    ( "$(IOC_DATA)/ioc-xpp-mon-lodcm-ims/autosave" )

set_pass0_restoreFile( "ioc-xpp-mon-lodcm-ims.sav"                  )

# Initialize the IOC and start processing records
iocInit()

create_monitor_set( "ioc-xpp-mon-lodcm-ims.req", 30, "" );

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

