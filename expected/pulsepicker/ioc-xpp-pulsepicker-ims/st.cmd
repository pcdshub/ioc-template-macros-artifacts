#!/reg/g/pcds/epics/ioc/common/pulsepicker/R1.2.1/bin/linux-x86_64/motion

< envPaths
epicsEnvSet( "ENGINEER", "Jeff Ludvik (jsludvik)" )
epicsEnvSet( "LOCATION", "XPP:SB2" )
# Local protocol for MEC specific
epicsEnvSet( "STREAM_PROTOCOL_PATH", "protocol" )
# Picker motor settings
epicsEnvSet( "PP_PORT",  "moxa-xpp-08.pcdsn:4014" )
epicsEnvSet( "PP_MOTOR", "29" )
# X translation settings
epicsEnvSet( "XT_PORT",  "moxa-xpp-08.pcdsn:4013" )
epicsEnvSet( "XT_MOTOR", "28" )
# Y translation settings
epicsEnvSet( "YT_PORT",  "moxa-xpp-10.pcdsn:4016" )
epicsEnvSet( "YT_MOTOR", "16" )
# PV settings
epicsEnvSet( "LOC", "XPP" )
epicsEnvSet( "SYS", "SB2" )
epicsEnvSet( "MMS", "MMS" )
epicsEnvSet( "IOC",    "ioc-xpp-pulsepicker-ims" )
epicsEnvSet( "IOC_PV", "XPP:IOC:PULSEPICKER:IMS" )
epicsEnvSet( "IOCTOP", "/reg/g/pcds/epics/ioc/common/pulsepicker/R1.2.1" )
epicsEnvSet( "IOCSH_PS1", "$(IOC)> " )
cd( "$(IOCTOP)" )

< /reg/d/iocCommon/All/pre_linux.cmd

## Register all support components
dbLoadDatabase("dbd/motion.dbd",0,0)
motion_registerRecordDeviceDriver(pdbbase)
 
# IMS MDrive driver setup parameters:
#     (1) maximum number of controllers in system

MDrivePlusSetup(3)

# Associate a name with an ASYN connection.  This name will then be
# associated with a motor.

# List motors in IOC here
# Pulse picker motor
drvAsynIPPortConfigure("M$(PP_MOTOR)","$(PP_PORT) TCP",0,0,0)

# 2-axis control motors
drvAsynIPPortConfigure("M$(XT_MOTOR)","$(XT_PORT) TCP",0,0,0)
drvAsynIPPortConfigure("M$(YT_MOTOR)","$(YT_PORT) TCP",0,0,0)

# IMS MDrive driver configuration parameters:
#     (1) controller# being configured,
#     (2) ASYN port name,
#     (3) motor task polling rate (min=1Hz,max=60Hz)

MDrivePlusConfig(0, "M$(PP_MOTOR)", 5)
MDrivePlusConfig(1, "M$(XT_MOTOR)", 5)
MDrivePlusConfig(2, "M$(YT_MOTOR)", 5)

# Enable tracing on *all* channels.

#asynSetTraceIOMask( "M$(PP_MOTOR)",  0, 2 )
#asynSetTraceIOMask( "M$(XT_MOTOR)",  0, 2 )
#asynSetTraceIOMask( "M$(YT_MOTOR)",  0, 2 )

#asynSetTraceMask( "M$(PP_MOTOR)",  0, 9 )
#asynSetTraceMask( "M$(XT_MOTOR)",  0, 9 )
#asynSetTraceMask( "M$(YT_MOTOR)",  0, 9 )

# Requires that ImsSrc motor built with DEBUG
#var(drvMDrivePlusdebug,6)
#var(motorRecordDebug,  6)
#var(motordrvComdebug,  6)

## Load record instances -------------------------------------------------------
dbLoadRecords("db/iocAdmin.db",         "IOC=XPP:IOC:PULSEPICKER:IMS")
dbLoadRecords("db/pulse-motor-ims.db", 	"LOC=$(LOC),SYS=$(SYS),MMS=$(MMS),M01=$(PP_MOTOR),DVER=3")
dbLoadRecords("db/2-axis-control.db",   "LOC=$(LOC),SYS=$(SYS),MMS=$(MMS),M01=$(PP_MOTOR),M02=$(XT_MOTOR),M03=$(YT_MOTOR),DVER=4")
dbLoadRecords("db/save_restoreStatus.db", "IOC=$(IOC_PV)" )
#-------------------------------------------------------------------------------

####### Autosave #############

save_restoreSet_status_prefix("$(IOC_PV)")
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(TOP)/autosave" )

set_pass0_restoreFile( "$(IOC).sav" )
set_pass1_restoreFile( "$(IOC).sav" )

save_restoreSet_NumSeqFiles(5)
save_restoreSet_SeqPeriodInSeconds(30)



######################################################################

## Set this to see messages from mySub
#var(drvMDrivePlusdebug,6)
#var(motorRecordDebug,6)
#var(motordrvComdebug,6)

iocInit()

######################################################################
create_monitor_set( "$(IOC).req", 30, "" )

< /reg/d/iocCommon/All/post_linux.cmd
