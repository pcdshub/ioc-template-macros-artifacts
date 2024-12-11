#!/reg/g/pcds/epics/ioc/common/pfts_manager/R1.0.11/bin/rhel7-x86_64/pftsman

< envPaths

epicsEnvSet( "ENGINEER" ,  "Michael Browne (mcbrowne)" )
epicsEnvSet( "IOCSH_PS1",  "ioc-las-pftssim-01>" )
epicsEnvSet( "IOCPVROOT",  "IOC:LAS:PFTS:SIM"   )
epicsEnvSet( "LOCATION",   "Nowhere")
epicsEnvSet( "IOC_TOP",    "/reg/g/pcds/epics/ioc/common/pfts_manager/R1.0.11"   )
epicsEnvSet( "TOP",        "/reg/g/pcds/epics/ioc/common/pfts_manager/R1.0.11/children/build"      )
epicsEnvSet( "PFTSBASE",   "LAS:PFTS:SIM"      )
#
# Tricksy conditional macros.  The idea is that the preprocessor evaluates
# something to either 0 or 1, and we want to do something conditionally on
# its value.  We have four cases:
# $(IF1_0) xxx   - If the calc is not 1, skip it!
# $(IF1_1) xxx   - If the calc *is* 1, do it!
# $(IF0_0) xxx   - If the calc *is* 0, do it!
# $(IF0_1) xxx   - If the calc is not 0, skip it!
#
epicsEnvSet( "IF1_0",      "#")
epicsEnvSet( "IF1_1",      "")
epicsEnvSet( "IF0_0",      "")
epicsEnvSet( "IF0_1",      "#")

cd( "$(IOC_TOP)" )

< db/flsenv.db

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/pftsman.dbd")
pftsman_registerRecordDeviceDriver(pdbbase)

# Simulate FLS scanning motors!
# motorSimCreateController(port, axcnt)
motorSimCreateController("MP", 8)

# OK, more tricksy-ness!
#
# EPICS variables we are setting here:
#     STAGEn is the name of the scan stage PV.
#     RSn is used to comment in anything used for a *real* stage.
#     SSn is used to comment in anything used for a *simulated* stage.
#
# This logic is tricky: we want to use a real stage only if the FLS is 
# *not* simulated *and* we have given a stage name in the config file.
# We start by defining SSn as if we had a simulated stage, and then
# set RSn appropriately.  We can then use RSn to set STAGEn and 
# redefine SSn, if needed.
epicsEnvSet("SS1",    "")
epicsEnvSet("SS2",    "")
epicsEnvSet("SS3",    "")
epicsEnvSet("SS4",    "")
epicsEnvSet("SS5",    "")
epicsEnvSet("SS6",    "")
epicsEnvSet("SS7",    "")
epicsEnvSet("SS8",    "")
epicsEnvSet("RS1", "$(IF0_1)$(IF1_0)")
epicsEnvSet("RS2", "$(IF0_1)$(IF1_0)")
epicsEnvSet("RS3", "$(IF0_1)$(IF1_0)")
epicsEnvSet("RS4", "$(IF0_1)$(IF1_0)")
epicsEnvSet("RS5", "$(IF0_1)$(IF1_0)")
epicsEnvSet("RS6", "$(IF0_1)$(IF1_0)")
epicsEnvSet("RS7", "$(IF0_1)$(IF1_0)")
epicsEnvSet("RS8", "$(IF0_1)$(IF1_0)")

$(RS1) epicsEnvSet("STAGE1", "")
$(RS2) epicsEnvSet("STAGE2", "")
$(RS3) epicsEnvSet("STAGE3", "")
$(RS4) epicsEnvSet("STAGE4", "")
$(RS5) epicsEnvSet("STAGE5", "")
$(RS6) epicsEnvSet("STAGE6", "")
$(RS7) epicsEnvSet("STAGE7", "")
$(RS8) epicsEnvSet("STAGE8", "")

# motorSimConfigAxis(port, axnum, highlim, lowlim, home, start)
$(RS1) epicsEnvSet("SS1", "#")
$(RS1) epicsEnvSet("SIM1",    "0")
$(SS1) epicsEnvSet("STAGE1", "LAS:PFTS:SIM:FLS1:MSCAN")
$(SS1) motorSimConfigAxis("MP", 0, 500000, 0, 100000, 0)
$(SS1) epicsEnvSet("SIM1",    "1")
$(RS2) epicsEnvSet("SS2", "#")
$(RS2) epicsEnvSet("SIM2",    "0")
$(SS2) epicsEnvSet("STAGE2", "LAS:PFTS:SIM:FLS2:MSCAN")
$(SS2) motorSimConfigAxis("MP", 1, 500000, 0, 100000, 0)
$(SS2) epicsEnvSet("SIM2",    "1")
$(RS3) epicsEnvSet("SS3", "#")
$(RS3) epicsEnvSet("SIM3",    "0")
$(SS3) epicsEnvSet("STAGE3", "LAS:PFTS:SIM:FLS3:MSCAN")
$(SS3) motorSimConfigAxis("MP", 2, 500000, 0, 100000, 0)
$(SS3) epicsEnvSet("SIM3",    "1")
$(RS4) epicsEnvSet("SS4", "#")
$(RS4) epicsEnvSet("SIM4",    "0")
$(SS4) epicsEnvSet("STAGE4", "LAS:PFTS:SIM:FLS4:MSCAN")
$(SS4) motorSimConfigAxis("MP", 3, 500000, 0, 100000, 0)
$(SS4) epicsEnvSet("SIM4",    "1")
$(RS5) epicsEnvSet("SS5", "#")
$(RS5) epicsEnvSet("SIM5",    "0")
$(SS5) epicsEnvSet("STAGE5", "LAS:PFTS:SIM:FLS5:MSCAN")
$(SS5) motorSimConfigAxis("MP", 4, 500000, 0, 100000, 0)
$(SS5) epicsEnvSet("SIM5",    "1")
$(RS6) epicsEnvSet("SS6", "#")
$(RS6) epicsEnvSet("SIM6",    "0")
$(SS6) epicsEnvSet("STAGE6", "LAS:PFTS:SIM:FLS6:MSCAN")
$(SS6) motorSimConfigAxis("MP", 5, 500000, 0, 100000, 0)
$(SS6) epicsEnvSet("SIM6",    "1")
$(RS7) epicsEnvSet("SS7", "#")
$(RS7) epicsEnvSet("SIM7",    "0")
$(SS7) epicsEnvSet("STAGE7", "LAS:PFTS:SIM:FLS7:MSCAN")
$(SS7) motorSimConfigAxis("MP", 6, 500000, 0, 100000, 0)
$(SS7) epicsEnvSet("SIM7",    "1")
$(RS8) epicsEnvSet("SS8", "#")
$(RS8) epicsEnvSet("SIM8",    "0")
$(SS8) epicsEnvSet("STAGE8", "LAS:PFTS:SIM:FLS8:MSCAN")
$(SS8) motorSimConfigAxis("MP", 7, 500000, 0, 100000, 0)
$(SS8) epicsEnvSet("SIM8",    "1")
#------------------------------------------------------------------------------
# Set monitoring base PVs.
epicsEnvSet("DSTMON0", "LAS:PFTS:SIM:NONE")
epicsEnvSet("DSTMON1", "LAS:PFTS:SIM:NONE")
epicsEnvSet("DSTMON2", "LAS:PFTS:SIM:NONE")
epicsEnvSet("DSTMON3", "LAS:PFTS:SIM:NONE")
epicsEnvSet("DSTMON4", "LAS:PFTS:SIM:NONE")
epicsEnvSet("DSTMON5", "LAS:PFTS:SIM:NONE")
epicsEnvSet("DSTMON6", "LAS:PFTS:SIM:NONE")
epicsEnvSet("DSTMON7", "LAS:PFTS:SIM:NONE")
epicsEnvSet("DSTMON8", "LAS:PFTS:SIM:NONE")
epicsEnvSet("DSTMON9", "LAS:PFTS:SIM:NONE")
epicsEnvSet("DSTMON10", "LAS:PFTS:SIM:NONE")
epicsEnvSet("DSTMON11", "LAS:PFTS:SIM:NONE")
epicsEnvSet("DSTMON12", "LAS:PFTS:SIM:NONE")
epicsEnvSet("DSTMON13", "LAS:PFTS:SIM:NONE")
epicsEnvSet("DSTMON14", "LAS:PFTS:SIM:NONE")
epicsEnvSet("DSTMON15", "LAS:PFTS:SIM:NONE")
epicsEnvSet("DSTMON16", "LAS:PFTS:SIM:NONE")
epicsEnvSet("DSTMON17", "LAS:PFTS:SIM:NONE")
epicsEnvSet("DSTMON18", "LAS:PFTS:SIM:NONE")
epicsEnvSet("DSTMON19", "LAS:PFTS:SIM:NONE")

#------------------------------------------------------------------------------
# Load record instances

dbLoadRecords("db/dicon.db",              "P=LAS:DICON:SIM")

epicsEnvSet("PVLIST00", "ENB_PV=FLS:ENABLEFLS,POS_PV=STAGE:POSITION,MOVE_PV=STAGE:POSITION,VEL_PV=STAGE:VELOCITY")
epicsEnvSet("PVLIST01", "ENB_PV=ENABLELINKLOCK,POS_PV=ODLPOSITION,MOVE_PV=SETODLPOSITION,VEL_PV=SETVELOCITY")
epicsEnvSet("PVLIST10", "$(PVLIST00)")
epicsEnvSet("PVLIST11", "$(PVLIST00)")

epicsEnvSet("FLS1", "$(FLS1_10)")
$(IF1_1) dbLoadRecords("db/fls.db", "P=LAS:PFTS:SIM,DESC=$(FLSDESC1),L=$(FLSLINK1)")
dbLoadRecords("db/src.db", "P=LAS:PFTS:SIM,DESC=$(FLSDESC1),DBASE=LAS:DICON:SIM,N=1,CBASE=$(FLS1),EN=1,SIM=$(SIM1),$(PVLIST10)")
epicsEnvSet("STVER", "db/src_oldstate.db")
$(IF0_1)$(IF1_0) epicsEnvSet("STVER", "db/src_newstate.db")
dbLoadRecords("$(STVER)", "P=LAS:PFTS:SIM,N=1,CBASE=$(FLS1)")

epicsEnvSet("FLS2", "$(FLS2_10)")
$(IF1_1) dbLoadRecords("db/fls.db", "P=LAS:PFTS:SIM,DESC=$(FLSDESC2),L=$(FLSLINK2)")
dbLoadRecords("db/src.db", "P=LAS:PFTS:SIM,DESC=$(FLSDESC2),DBASE=LAS:DICON:SIM,N=2,CBASE=$(FLS2),EN=1,SIM=$(SIM2),$(PVLIST10)")
epicsEnvSet("STVER", "db/src_oldstate.db")
$(IF0_1)$(IF1_0) epicsEnvSet("STVER", "db/src_newstate.db")
dbLoadRecords("$(STVER)", "P=LAS:PFTS:SIM,N=2,CBASE=$(FLS2)")

epicsEnvSet("FLS3", "$(FLS3_10)")
$(IF1_1) dbLoadRecords("db/fls.db", "P=LAS:PFTS:SIM,DESC=$(FLSDESC3),L=$(FLSLINK3)")
dbLoadRecords("db/src.db", "P=LAS:PFTS:SIM,DESC=$(FLSDESC3),DBASE=LAS:DICON:SIM,N=3,CBASE=$(FLS3),EN=1,SIM=$(SIM3),$(PVLIST10)")
epicsEnvSet("STVER", "db/src_oldstate.db")
$(IF0_1)$(IF1_0) epicsEnvSet("STVER", "db/src_newstate.db")
dbLoadRecords("$(STVER)", "P=LAS:PFTS:SIM,N=3,CBASE=$(FLS3)")

epicsEnvSet("FLS4", "$(FLS4_10)")
$(IF1_1) dbLoadRecords("db/fls.db", "P=LAS:PFTS:SIM,DESC=$(FLSDESC4),L=$(FLSLINK4)")
dbLoadRecords("db/src.db", "P=LAS:PFTS:SIM,DESC=$(FLSDESC4),DBASE=LAS:DICON:SIM,N=4,CBASE=$(FLS4),EN=0,SIM=$(SIM4),$(PVLIST10)")
epicsEnvSet("STVER", "db/src_oldstate.db")
$(IF0_1)$(IF1_0) epicsEnvSet("STVER", "db/src_newstate.db")
dbLoadRecords("$(STVER)", "P=LAS:PFTS:SIM,N=4,CBASE=$(FLS4)")

epicsEnvSet("FLS5", "$(FLS5_10)")
$(IF1_1) dbLoadRecords("db/fls.db", "P=LAS:PFTS:SIM,DESC=$(FLSDESC5),L=$(FLSLINK5)")
dbLoadRecords("db/src.db", "P=LAS:PFTS:SIM,DESC=$(FLSDESC5),DBASE=LAS:DICON:SIM,N=5,CBASE=$(FLS5),EN=0,SIM=$(SIM5),$(PVLIST10)")
epicsEnvSet("STVER", "db/src_oldstate.db")
$(IF0_1)$(IF1_0) epicsEnvSet("STVER", "db/src_newstate.db")
dbLoadRecords("$(STVER)", "P=LAS:PFTS:SIM,N=5,CBASE=$(FLS5)")

epicsEnvSet("FLS6", "$(FLS6_10)")
$(IF1_1) dbLoadRecords("db/fls.db", "P=LAS:PFTS:SIM,DESC=$(FLSDESC6),L=$(FLSLINK6)")
dbLoadRecords("db/src.db", "P=LAS:PFTS:SIM,DESC=$(FLSDESC6),DBASE=LAS:DICON:SIM,N=6,CBASE=$(FLS6),EN=0,SIM=$(SIM6),$(PVLIST10)")
epicsEnvSet("STVER", "db/src_oldstate.db")
$(IF0_1)$(IF1_0) epicsEnvSet("STVER", "db/src_newstate.db")
dbLoadRecords("$(STVER)", "P=LAS:PFTS:SIM,N=6,CBASE=$(FLS6)")

epicsEnvSet("FLS7", "$(FLS7_10)")
$(IF1_1) dbLoadRecords("db/fls.db", "P=LAS:PFTS:SIM,DESC=$(FLSDESC7),L=$(FLSLINK7)")
dbLoadRecords("db/src.db", "P=LAS:PFTS:SIM,DESC=$(FLSDESC7),DBASE=LAS:DICON:SIM,N=7,CBASE=$(FLS7),EN=0,SIM=$(SIM7),$(PVLIST10)")
epicsEnvSet("STVER", "db/src_oldstate.db")
$(IF0_1)$(IF1_0) epicsEnvSet("STVER", "db/src_newstate.db")
dbLoadRecords("$(STVER)", "P=LAS:PFTS:SIM,N=7,CBASE=$(FLS7)")

epicsEnvSet("FLS8", "$(FLS8_10)")
$(IF1_1) dbLoadRecords("db/fls.db", "P=LAS:PFTS:SIM,DESC=$(FLSDESC8),L=$(FLSLINK8)")
dbLoadRecords("db/src.db", "P=LAS:PFTS:SIM,DESC=$(FLSDESC8),DBASE=LAS:DICON:SIM,N=8,CBASE=$(FLS8),EN=0,SIM=$(SIM8),$(PVLIST10)")
epicsEnvSet("STVER", "db/src_oldstate.db")
$(IF0_1)$(IF1_0) epicsEnvSet("STVER", "db/src_newstate.db")
dbLoadRecords("$(STVER)", "P=LAS:PFTS:SIM,N=8,CBASE=$(FLS8)")


dbLoadRecords("db/pftsman.db", "P=LAS:PFTS:SIM,FLS1=$(FLS1),FLS2=$(FLS2),FLS3=$(FLS3),FLS4=$(FLS4),FLS5=$(FLS5),FLS6=$(FLS6),FLS7=$(FLS7),FLS8=$(FLS8),DSTMON0=$(DSTMON0),DSTMON1=$(DSTMON1),DSTMON2=$(DSTMON2),DSTMON3=$(DSTMON3),DSTMON4=$(DSTMON4),DSTMON5=$(DSTMON5),DSTMON6=$(DSTMON6),DSTMON7=$(DSTMON7),DSTMON8=$(DSTMON8),DSTMON9=$(DSTMON9),DSTMON10=$(DSTMON10),DSTMON11=$(DSTMON11),DSTMON12=$(DSTMON12),DSTMON13=$(DSTMON13),DSTMON14=$(DSTMON14),DSTMON15=$(DSTMON15),DSTMON16=$(DSTMON16),DSTMON17=$(DSTMON17),DSTMON18=$(DSTMON18),DSTMON19=$(DSTMON19),DST_EN=0")

$(SS1) dbLoadRecords("db/src_stage.db", "P=LAS:PFTS:SIM,PORT=MP,ADDR=0,N=1")
$(SS2) dbLoadRecords("db/src_stage.db", "P=LAS:PFTS:SIM,PORT=MP,ADDR=1,N=2")
$(SS3) dbLoadRecords("db/src_stage.db", "P=LAS:PFTS:SIM,PORT=MP,ADDR=2,N=3")
$(SS4) dbLoadRecords("db/src_stage.db", "P=LAS:PFTS:SIM,PORT=MP,ADDR=3,N=4")
$(SS5) dbLoadRecords("db/src_stage.db", "P=LAS:PFTS:SIM,PORT=MP,ADDR=4,N=5")
$(SS6) dbLoadRecords("db/src_stage.db", "P=LAS:PFTS:SIM,PORT=MP,ADDR=5,N=6")
$(SS7) dbLoadRecords("db/src_stage.db", "P=LAS:PFTS:SIM,PORT=MP,ADDR=6,N=7")
$(SS8) dbLoadRecords("db/src_stage.db", "P=LAS:PFTS:SIM,PORT=MP,ADDR=7,N=8")
dbLoadRecords("db/autooverlap.db", "P=LAS:PFTS:SIM,STAGE1=$(STAGE1),STAGE2=$(STAGE2),STAGE3=$(STAGE3),STAGE4=$(STAGE4),STAGE5=$(STAGE5),STAGE6=$(STAGE6),STAGE7=$(STAGE7),STAGE8=$(STAGE8)")

dbLoadRecords("db/iocSoft.db",		  "IOC=$(IOCPVROOT)" )
dbLoadRecords("db/save_restoreStatus.db", "P=$(IOCPVROOT):" )

#------------------------------------------------------------------------------
# Setup autosave

set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(TOP)/autosave" )
set_requestfile_path( "$(IOC_DATA)/$(IOC)/autosave" )
save_restoreSet_status_prefix( "$(IOCPVROOT):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

# Just restore the settings
set_pass0_restoreFile( "$(IOC).sav" )
set_pass0_restoreFile( "autoSettings.sav" )
set_pass1_restoreFile( "$(IOC).sav" )
set_pass1_restoreFile( "autoSettings.sav" )

# Initialize the IOC and start processing records
iocInit()

# Create autosave files from info directives
makeAutosaveFileFromDbInfo( "$(IOC_DATA)/$(IOC)/autosave/autoSettings.req", "autosaveFields" )

# Start autosave backups
create_monitor_set( "autoSettings.req", 5, "" )
create_monitor_set( "$(IOC).req", 5, "" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

dbpf LAS:PFTS:SIM:FLS1:INITCHAN.PROC 1
dbpf LAS:PFTS:SIM:FLS2:INITCHAN.PROC 1
dbpf LAS:PFTS:SIM:FLS3:INITCHAN.PROC 1
dbpf LAS:PFTS:SIM:FLS4:INITCHAN.PROC 1
dbpf LAS:PFTS:SIM:FLS5:INITCHAN.PROC 1
dbpf LAS:PFTS:SIM:FLS6:INITCHAN.PROC 1
dbpf LAS:PFTS:SIM:FLS7:INITCHAN.PROC 1
dbpf LAS:PFTS:SIM:FLS8:INITCHAN.PROC 1
