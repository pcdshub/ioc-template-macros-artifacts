#!$$IOCTOP/bin/$$IF(ARCH,$$ARCH,linux-x86_64)/pftsman

< envPaths

epicsEnvSet( "ENGINEER" ,  "$$ENGINEER" )
epicsEnvSet( "IOCSH_PS1",  "$$IOCNAME>" )
epicsEnvSet( "IOCPVROOT",  "$$IOC_PV"   )
epicsEnvSet( "LOCATION",   "$$IF(LOCATION,$$LOCATION,$$IOC_PV)")
epicsEnvSet( "IOC_TOP",    "$$IOCTOP"   )
epicsEnvSet( "TOP",        "$$TOP"      )
$$LOOP(PFTS)
epicsEnvSet( "PFTSBASE",   "$$BASE"      )
$$ENDLOOP(PFTS)
#
# Tricksy conditional macros.  The idea is that the preprocessor evaluates
# something to either 0 or 1, and we want to do something conditionally on
# its value.  We have four cases:
# $(IF1_$$CALC{0}) xxx   - If the calc is not 1, skip it!
# $(IF1_$$CALC{1}) xxx   - If the calc *is* 1, do it!
# $(IF0_$$CALC{0}) xxx   - If the calc *is* 0, do it!
# $(IF0_$$CALC{1}) xxx   - If the calc is not 0, skip it!
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

$$IF(AOLSYSTEM)
# Simulate FLS scanning motors!
# motorSimCreateController(port, axcnt)
motorSimCreateController("MP", 8)

$$LOOP(PFTS)
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
$$LOOP(8)
epicsEnvSet("SS$$CALC{INDEX+1}",    "")
$$ENDLOOP(8)
epicsEnvSet("RS1", "$(IF0_$$CALC{(SIM>>0)&1})$(IF1_$$IF(STAGE1,1,0))")
epicsEnvSet("RS2", "$(IF0_$$CALC{(SIM>>1)&1})$(IF1_$$IF(STAGE2,1,0))")
epicsEnvSet("RS3", "$(IF0_$$CALC{(SIM>>2)&1})$(IF1_$$IF(STAGE3,1,0))")
epicsEnvSet("RS4", "$(IF0_$$CALC{(SIM>>3)&1})$(IF1_$$IF(STAGE4,1,0))")
epicsEnvSet("RS5", "$(IF0_$$CALC{(SIM>>4)&1})$(IF1_$$IF(STAGE5,1,0))")
epicsEnvSet("RS6", "$(IF0_$$CALC{(SIM>>5)&1})$(IF1_$$IF(STAGE6,1,0))")
epicsEnvSet("RS7", "$(IF0_$$CALC{(SIM>>6)&1})$(IF1_$$IF(STAGE7,1,0))")
epicsEnvSet("RS8", "$(IF0_$$CALC{(SIM>>7)&1})$(IF1_$$IF(STAGE8,1,0))")

$(RS1) epicsEnvSet("STAGE1", "$$STAGE1")
$(RS2) epicsEnvSet("STAGE2", "$$STAGE2")
$(RS3) epicsEnvSet("STAGE3", "$$STAGE3")
$(RS4) epicsEnvSet("STAGE4", "$$STAGE4")
$(RS5) epicsEnvSet("STAGE5", "$$STAGE5")
$(RS6) epicsEnvSet("STAGE6", "$$STAGE6")
$(RS7) epicsEnvSet("STAGE7", "$$STAGE7")
$(RS8) epicsEnvSet("STAGE8", "$$STAGE8")

# motorSimConfigAxis(port, axnum, highlim, lowlim, home, start)
$$LOOP(8)
$(RS$$CALC{INDEX+1}) epicsEnvSet("SS$$CALC{INDEX+1}", "#")
$(RS$$CALC{INDEX+1}) epicsEnvSet("SIM$$CALC{INDEX+1}",    "0")
$(SS$$CALC{INDEX+1}) epicsEnvSet("STAGE$$CALC{INDEX+1}", "$$BASE:FLS$$CALC{INDEX+1}:MSCAN")
$(SS$$CALC{INDEX+1}) motorSimConfigAxis("MP", $$INDEX, 500000, 0, 100000, 0)
$(SS$$CALC{INDEX+1}) epicsEnvSet("SIM$$CALC{INDEX+1}",    "1")
$$ENDLOOP(8)
$$ENDLOOP(PFTS)
$$ELSE(AOLSYSTEM)
$$LOOP(8)
epicsEnvSet("SIM$$CALC{INDEX+1}",    "0")
$$ENDLOOP(8)
$$ENDIF(AOLSYSTEM)
#------------------------------------------------------------------------------
# Set monitoring base PVs.
$$LOOP(PFTS)
epicsEnvSet("DSTMON0", "$$IF(DSTMON0,$$DSTMON0,$$BASE:NONE)")
epicsEnvSet("DSTMON1", "$$IF(DSTMON1,$$DSTMON1,$$BASE:NONE)")
epicsEnvSet("DSTMON2", "$$IF(DSTMON2,$$DSTMON2,$$BASE:NONE)")
epicsEnvSet("DSTMON3", "$$IF(DSTMON3,$$DSTMON3,$$BASE:NONE)")
epicsEnvSet("DSTMON4", "$$IF(DSTMON4,$$DSTMON4,$$BASE:NONE)")
epicsEnvSet("DSTMON5", "$$IF(DSTMON5,$$DSTMON5,$$BASE:NONE)")
epicsEnvSet("DSTMON6", "$$IF(DSTMON6,$$DSTMON6,$$BASE:NONE)")
epicsEnvSet("DSTMON7", "$$IF(DSTMON7,$$DSTMON7,$$BASE:NONE)")
epicsEnvSet("DSTMON8", "$$IF(DSTMON8,$$DSTMON8,$$BASE:NONE)")
epicsEnvSet("DSTMON9", "$$IF(DSTMON9,$$DSTMON9,$$BASE:NONE)")
epicsEnvSet("DSTMON10", "$$IF(DSTMON10,$$DSTMON10,$$BASE:NONE)")
epicsEnvSet("DSTMON11", "$$IF(DSTMON11,$$DSTMON11,$$BASE:NONE)")
epicsEnvSet("DSTMON12", "$$IF(DSTMON12,$$DSTMON12,$$BASE:NONE)")
epicsEnvSet("DSTMON13", "$$IF(DSTMON13,$$DSTMON13,$$BASE:NONE)")
epicsEnvSet("DSTMON14", "$$IF(DSTMON14,$$DSTMON14,$$BASE:NONE)")
epicsEnvSet("DSTMON15", "$$IF(DSTMON15,$$DSTMON15,$$BASE:NONE)")
epicsEnvSet("DSTMON16", "$$IF(DSTMON16,$$DSTMON16,$$BASE:NONE)")
epicsEnvSet("DSTMON17", "$$IF(DSTMON17,$$DSTMON17,$$BASE:NONE)")
epicsEnvSet("DSTMON18", "$$IF(DSTMON18,$$DSTMON18,$$BASE:NONE)")
epicsEnvSet("DSTMON19", "$$IF(DSTMON19,$$DSTMON19,$$BASE:NONE)")
$$ENDLOOP(PFTS)

#------------------------------------------------------------------------------
# Load record instances

$$LOOP(DICON)
dbLoadRecords("db/dicon.db",              "P=$$BASE")
$$ENDLOOP(DICON)

epicsEnvSet("PVLIST00", "ENB_PV=FLS:ENABLEFLS,POS_PV=STAGE:POSITION,MOVE_PV=STAGE:POSITION,VEL_PV=STAGE:VELOCITY")
epicsEnvSet("PVLIST01", "ENB_PV=ENABLELINKLOCK,POS_PV=ODLPOSITION,MOVE_PV=SETODLPOSITION,VEL_PV=SETVELOCITY")
epicsEnvSet("PVLIST10", "$(PVLIST00)")
epicsEnvSet("PVLIST11", "$(PVLIST00)")

$$LOOP(PFTS)
$$LOOP(8)
epicsEnvSet("FLS$$CALC{INDEX+1}", "$(FLS$$CALC{INDEX+1}_$$CALC{(SIM>>INDEX)&1}$$CALC{(NEW>>INDEX)&1})")
$(IF1_$$CALC{(SIM>>INDEX)&1}) dbLoadRecords("db/fls.db", "P=$$BASE,DESC=$(FLSDESC$$CALC{INDEX+1}),L=$(FLSLINK$$CALC{INDEX+1})")
dbLoadRecords("db/src.db", "P=$$BASE,DESC=$(FLSDESC$$CALC{INDEX+1}),DBASE=$$DBASE,N=$$CALC{INDEX+1},CBASE=$(FLS$$CALC{INDEX+1}),EN=$$CALC{(ENABLE>>INDEX)&1},SIM=$(SIM$$CALC{INDEX+1}),$(PVLIST$$CALC{(SIM>>INDEX)&1}$$CALC{(NEW>>INDEX)&1})")
epicsEnvSet("STVER", "db/src_oldstate.db")
$(IF0_$$CALC{(SIM>>INDEX)&1})$(IF1_$$CALC{(NEW>>INDEX)&1}) epicsEnvSet("STVER", "db/src_newstate.db")
dbLoadRecords("$(STVER)", "P=$$BASE,N=$$CALC{INDEX+1},CBASE=$(FLS$$CALC{INDEX+1})")

$$ENDLOOP(8)

dbLoadRecords("db/pftsman.db", "P=$$BASE$$LOOP(8),FLS$$CALC{INDEX+1}=$(FLS$$CALC{INDEX+1})$$ENDLOOP(8)$$LOOP(20),DSTMON$$INDEX=$(DSTMON$$INDEX)$$ENDLOOP(20),DST_EN=$$DST_EN")

$$IF(AOLSYSTEM)
$$LOOP(8)
$(SS$$CALC{INDEX+1}) dbLoadRecords("db/src_stage.db", "P=$$BASE,PORT=MP,ADDR=$$INDEX,N=$$CALC{INDEX+1}")
$$ENDLOOP(8)
dbLoadRecords("db/autooverlap.db", "P=$$BASE$$LOOP(8),STAGE$$CALC{INDEX+1}=$(STAGE$$CALC{INDEX+1})$$ENDLOOP(8)")
$$ENDIF(AOLSYSTEM)
$$ENDLOOP(PFTS)

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

$$LOOP(PFTS)
$$LOOP(8)
dbpf $$BASE:FLS$$CALC{INDEX+1}:INITCHAN.PROC 1
$$ENDLOOP(8)
$$ENDLOOP(PFTS)
