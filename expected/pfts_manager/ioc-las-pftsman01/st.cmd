#!/reg/g/pcds/epics/ioc/common/pfts_manager/R1.0.11/bin/rhel7-x86_64/pftsman

< envPaths

epicsEnvSet( "ENGINEER" ,  "Michael Browne (mcbrowne)" )
epicsEnvSet( "IOCSH_PS1",  "ioc-las-pftsman01>" )
epicsEnvSet( "IOCPVROOT",  "IOC:LAS:PFTS:01"   )
epicsEnvSet( "LOCATION",   "Fiber Timing Lab")
epicsEnvSet( "IOC_TOP",    "/reg/g/pcds/epics/ioc/common/pfts_manager/R1.0.11"   )
epicsEnvSet( "TOP",        "/reg/g/pcds/epics/ioc/common/pfts_manager/R1.0.11/children/build"      )
epicsEnvSet( "PFTSBASE",   "LAS:PFTS:01"      )
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

epicsEnvSet("SIM1",    "0")
epicsEnvSet("SIM2",    "0")
epicsEnvSet("SIM3",    "0")
epicsEnvSet("SIM4",    "0")
epicsEnvSet("SIM5",    "0")
epicsEnvSet("SIM6",    "0")
epicsEnvSet("SIM7",    "0")
epicsEnvSet("SIM8",    "0")
#------------------------------------------------------------------------------
# Set monitoring base PVs.
epicsEnvSet("DSTMON0", "LAS:PFTS:01:NONE")
epicsEnvSet("DSTMON1", "LAS:PFTS:01:NONE")
epicsEnvSet("DSTMON2", "LAS:PFTS:01:NONE")
epicsEnvSet("DSTMON3", "LAS:PFTS:01:NONE")
epicsEnvSet("DSTMON4", "LAS:PFTS:01:NONE")
epicsEnvSet("DSTMON5", "LAS:PFTS:01:NONE")
epicsEnvSet("DSTMON6", "LAS:PFTS:01:NONE")
epicsEnvSet("DSTMON7", "LAS:PFTS:01:NONE")
epicsEnvSet("DSTMON8", "LAS:PFTS:01:NONE")
epicsEnvSet("DSTMON9", "LAS:PFTS:01:NONE")
epicsEnvSet("DSTMON10", "LAS:PFTS:01:NONE")
epicsEnvSet("DSTMON11", "LAS:PFTS:01:NONE")
epicsEnvSet("DSTMON12", "LAS:PFTS:01:NONE")
epicsEnvSet("DSTMON13", "LAS:PFTS:01:NONE")
epicsEnvSet("DSTMON14", "LAS:PFTS:01:NONE")
epicsEnvSet("DSTMON15", "LAS:PFTS:01:NONE")
epicsEnvSet("DSTMON16", "LAS:PFTS:01:NONE")
epicsEnvSet("DSTMON17", "LAS:PFTS:01:NONE")
epicsEnvSet("DSTMON18", "LAS:PFTS:01:NONE")
epicsEnvSet("DSTMON19", "LAS:PFTS:01:NONE")

#------------------------------------------------------------------------------
# Load record instances


epicsEnvSet("PVLIST00", "ENB_PV=FLS:ENABLEFLS,POS_PV=STAGE:POSITION,MOVE_PV=STAGE:POSITION,VEL_PV=STAGE:VELOCITY")
epicsEnvSet("PVLIST01", "ENB_PV=ENABLELINKLOCK,POS_PV=ODLPOSITION,MOVE_PV=SETODLPOSITION,VEL_PV=SETVELOCITY")
epicsEnvSet("PVLIST10", "$(PVLIST00)")
epicsEnvSet("PVLIST11", "$(PVLIST00)")

epicsEnvSet("FLS1", "$(FLS1_00)")
$(IF1_0) dbLoadRecords("db/fls.db", "P=LAS:PFTS:01,DESC=$(FLSDESC1),L=$(FLSLINK1)")
dbLoadRecords("db/src.db", "P=LAS:PFTS:01,DESC=$(FLSDESC1),DBASE=LAS:FTL:FSW:01,N=1,CBASE=$(FLS1),EN=1,SIM=$(SIM1),$(PVLIST00)")
epicsEnvSet("STVER", "db/src_oldstate.db")
$(IF0_0)$(IF1_0) epicsEnvSet("STVER", "db/src_newstate.db")
dbLoadRecords("$(STVER)", "P=LAS:PFTS:01,N=1,CBASE=$(FLS1)")

epicsEnvSet("FLS2", "$(FLS2_00)")
$(IF1_0) dbLoadRecords("db/fls.db", "P=LAS:PFTS:01,DESC=$(FLSDESC2),L=$(FLSLINK2)")
dbLoadRecords("db/src.db", "P=LAS:PFTS:01,DESC=$(FLSDESC2),DBASE=LAS:FTL:FSW:01,N=2,CBASE=$(FLS2),EN=1,SIM=$(SIM2),$(PVLIST00)")
epicsEnvSet("STVER", "db/src_oldstate.db")
$(IF0_0)$(IF1_0) epicsEnvSet("STVER", "db/src_newstate.db")
dbLoadRecords("$(STVER)", "P=LAS:PFTS:01,N=2,CBASE=$(FLS2)")

epicsEnvSet("FLS3", "$(FLS3_00)")
$(IF1_0) dbLoadRecords("db/fls.db", "P=LAS:PFTS:01,DESC=$(FLSDESC3),L=$(FLSLINK3)")
dbLoadRecords("db/src.db", "P=LAS:PFTS:01,DESC=$(FLSDESC3),DBASE=LAS:FTL:FSW:01,N=3,CBASE=$(FLS3),EN=1,SIM=$(SIM3),$(PVLIST00)")
epicsEnvSet("STVER", "db/src_oldstate.db")
$(IF0_0)$(IF1_0) epicsEnvSet("STVER", "db/src_newstate.db")
dbLoadRecords("$(STVER)", "P=LAS:PFTS:01,N=3,CBASE=$(FLS3)")

epicsEnvSet("FLS4", "$(FLS4_01)")
$(IF1_0) dbLoadRecords("db/fls.db", "P=LAS:PFTS:01,DESC=$(FLSDESC4),L=$(FLSLINK4)")
dbLoadRecords("db/src.db", "P=LAS:PFTS:01,DESC=$(FLSDESC4),DBASE=LAS:FTL:FSW:01,N=4,CBASE=$(FLS4),EN=1,SIM=$(SIM4),$(PVLIST01)")
epicsEnvSet("STVER", "db/src_oldstate.db")
$(IF0_0)$(IF1_1) epicsEnvSet("STVER", "db/src_newstate.db")
dbLoadRecords("$(STVER)", "P=LAS:PFTS:01,N=4,CBASE=$(FLS4)")

epicsEnvSet("FLS5", "$(FLS5_01)")
$(IF1_0) dbLoadRecords("db/fls.db", "P=LAS:PFTS:01,DESC=$(FLSDESC5),L=$(FLSLINK5)")
dbLoadRecords("db/src.db", "P=LAS:PFTS:01,DESC=$(FLSDESC5),DBASE=LAS:FTL:FSW:01,N=5,CBASE=$(FLS5),EN=1,SIM=$(SIM5),$(PVLIST01)")
epicsEnvSet("STVER", "db/src_oldstate.db")
$(IF0_0)$(IF1_1) epicsEnvSet("STVER", "db/src_newstate.db")
dbLoadRecords("$(STVER)", "P=LAS:PFTS:01,N=5,CBASE=$(FLS5)")

epicsEnvSet("FLS6", "$(FLS6_01)")
$(IF1_0) dbLoadRecords("db/fls.db", "P=LAS:PFTS:01,DESC=$(FLSDESC6),L=$(FLSLINK6)")
dbLoadRecords("db/src.db", "P=LAS:PFTS:01,DESC=$(FLSDESC6),DBASE=LAS:FTL:FSW:01,N=6,CBASE=$(FLS6),EN=1,SIM=$(SIM6),$(PVLIST01)")
epicsEnvSet("STVER", "db/src_oldstate.db")
$(IF0_0)$(IF1_1) epicsEnvSet("STVER", "db/src_newstate.db")
dbLoadRecords("$(STVER)", "P=LAS:PFTS:01,N=6,CBASE=$(FLS6)")

epicsEnvSet("FLS7", "$(FLS7_01)")
$(IF1_0) dbLoadRecords("db/fls.db", "P=LAS:PFTS:01,DESC=$(FLSDESC7),L=$(FLSLINK7)")
dbLoadRecords("db/src.db", "P=LAS:PFTS:01,DESC=$(FLSDESC7),DBASE=LAS:FTL:FSW:01,N=7,CBASE=$(FLS7),EN=0,SIM=$(SIM7),$(PVLIST01)")
epicsEnvSet("STVER", "db/src_oldstate.db")
$(IF0_0)$(IF1_1) epicsEnvSet("STVER", "db/src_newstate.db")
dbLoadRecords("$(STVER)", "P=LAS:PFTS:01,N=7,CBASE=$(FLS7)")

epicsEnvSet("FLS8", "$(FLS8_10)")
$(IF1_1) dbLoadRecords("db/fls.db", "P=LAS:PFTS:01,DESC=$(FLSDESC8),L=$(FLSLINK8)")
dbLoadRecords("db/src.db", "P=LAS:PFTS:01,DESC=$(FLSDESC8),DBASE=LAS:FTL:FSW:01,N=8,CBASE=$(FLS8),EN=0,SIM=$(SIM8),$(PVLIST10)")
epicsEnvSet("STVER", "db/src_oldstate.db")
$(IF0_1)$(IF1_0) epicsEnvSet("STVER", "db/src_newstate.db")
dbLoadRecords("$(STVER)", "P=LAS:PFTS:01,N=8,CBASE=$(FLS8)")


dbLoadRecords("db/pftsman.db", "P=LAS:PFTS:01,FLS1=$(FLS1),FLS2=$(FLS2),FLS3=$(FLS3),FLS4=$(FLS4),FLS5=$(FLS5),FLS6=$(FLS6),FLS7=$(FLS7),FLS8=$(FLS8),DSTMON0=$(DSTMON0),DSTMON1=$(DSTMON1),DSTMON2=$(DSTMON2),DSTMON3=$(DSTMON3),DSTMON4=$(DSTMON4),DSTMON5=$(DSTMON5),DSTMON6=$(DSTMON6),DSTMON7=$(DSTMON7),DSTMON8=$(DSTMON8),DSTMON9=$(DSTMON9),DSTMON10=$(DSTMON10),DSTMON11=$(DSTMON11),DSTMON12=$(DSTMON12),DSTMON13=$(DSTMON13),DSTMON14=$(DSTMON14),DSTMON15=$(DSTMON15),DSTMON16=$(DSTMON16),DSTMON17=$(DSTMON17),DSTMON18=$(DSTMON18),DSTMON19=$(DSTMON19),DST_EN=0")


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

dbpf LAS:PFTS:01:FLS1:INITCHAN.PROC 1
dbpf LAS:PFTS:01:FLS2:INITCHAN.PROC 1
dbpf LAS:PFTS:01:FLS3:INITCHAN.PROC 1
dbpf LAS:PFTS:01:FLS4:INITCHAN.PROC 1
dbpf LAS:PFTS:01:FLS5:INITCHAN.PROC 1
dbpf LAS:PFTS:01:FLS6:INITCHAN.PROC 1
dbpf LAS:PFTS:01:FLS7:INITCHAN.PROC 1
dbpf LAS:PFTS:01:FLS8:INITCHAN.PROC 1
