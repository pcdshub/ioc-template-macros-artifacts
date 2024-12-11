#!$$IOCTOP/bin/linux-x86_64/pvNotepad

epicsEnvSet( "EPICS_NAME", "$$TRANSLATE(IOCNAME,"a-z_-","A-Z::")" )
epicsEnvSet( "ENGINEER",  "$$ENGINEER" )
epicsEnvSet( "LOCATION",  "$$LOCATION" )
epicsEnvSet( "IOCSH_PS1", "$$IOCNAME> ")

< envPaths

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("$(TOP)/dbd/pvNotepad.dbd")
pvNotepad_registerRecordDeviceDriver(pdbbase)

# Load record instances
dbLoadRecords("$(TOP)/db/iocSoft.db",            "IOC=$(EPICS_NAME)" )
dbLoadRecords("$(TOP)/db/save_restoreStatus.db", "IOC=$(EPICS_NAME)" )

#Standard array option
$$LOOP(ARRAY_1)
dbLoadRecords("$(TOP)/db/array_1.db",    "HUTCH=$$HUTCH,$$IF(NELM,NELM=$$NELM,NELM=500),$$IF(FTYPE,FTYPE=$$FTYPE,FTYPE=DOUBLE),$$IF(EGU,EGU=$$EGU,),$$IF(PREC,PREC=$$PREC,),$$IF(INP,INP=$$INP,),$$IF(IDENTIFIER,IDENTIFIER=$$IDENTIFIER,IDENTIFIER=01)")
$$ENDLOOP(ARRAY_1)
$$LOOP(ARRAY_10)
dbLoadRecords("$(TOP)/db/array_10.db",    "HUTCH=$$HUTCH,$$IF(NELM,NELM=$$NELM,NELM=500),$$IF(FTYPE,FTYPE=$$FTYPE,FTYPE=DOUBLE),$$IF(EGU,EGU=$$EGU,),$$IF(PREC,PREC=$$PREC,),$$IF(INP,INP=$$INP,),$$IF(IDENTIFIER,IDENTIFIER=$$IDENTIFIER,IDENTIFIER=01)")
$$ENDLOOP(ARRAY_10)
$$LOOP(ARRAY_20)
dbLoadRecords("$(TOP)/db/array_20.db",    "HUTCH=$$HUTCH,$$IF(NELM,NELM=$$NELM,NELM=500),$$IF(FTYPE,FTYPE=$$FTYPE,FTYPE=DOUBLE),$$IF(EGU,EGU=$$EGU,),$$IF(PREC,PREC=$$PREC,),$$IF(INP,INP=$$INP,),$$IF(IDENTIFIER,IDENTIFIER=$$IDENTIFIER,IDENTIFIER=01)")
$$ENDLOOP(ARRAY_20)
$$LOOP(HUTCH)
dbLoadRecords("$(TOP)/db/hutch.db",    "PV=$$PV")
$$ENDLOOP(HUTCH)

$$LOOP(SPECIAL)
dbLoadRecords("$(TOP)/db/specials.db",     "PV=$$PV,RECTYPE=$$RECTYPE$$IF(NELM),NELM=$$NELM$$ENDIF(NELM)$$IF(FTYPE),FTYPE=$$FTYPE$$ENDIF(FTYPE)$$IF(EGU),EGU=$$EGU$$ENDIF(EGU)$$IF(PREC),PREC=$$PREC$$ENDIF(PREC)$$IF(DESC),DESC=$$DESC$$ENDIF(DESC)$$IF(INP),INP=$$INP$$ENDIF(INP)")
$$ENDLOOP(SPECIAL)

# Setup autosave
save_restoreSet_status_prefix("$(EPICS_NAME):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

set_requestfile_path( "$(PWD)/../../autosave"             )
set_savefile_path   ( "$(IOC_DATA)/$$IOCNAME/autosave" )

set_pass0_restoreFile( "$$IOCNAME.sav" )        #just restore the settings
set_pass1_restoreFile( "$$IOCNAME.sav" )        #just restore the settings


# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set( "$$IOCNAME.req", 30, "" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

