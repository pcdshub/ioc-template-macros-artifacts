#!$$IOCTOP/bin/$$IF(ARCH,$$ARCH,linux-x86_64)/pvNotepad

epicsEnvSet( "EPICS_NAME", "$$TRANSLATE(IOCNAME,"a-z_-","A-Z::")" )
epicsEnvSet( "ENGINEER",  "$$ENGINEER" )
epicsEnvSet( "LOCATION",  "$$LOCATION" )
epicsEnvSet( "IOCSH_PS1", "$$IOCNAME> ")
epicsEnvSet( "IOCTOP",       "$$IOCTOP" )
epicsEnvSet( "BUILD_TOP",    "$$TOP" )
epicsEnvSet( "EPICS_PVA_AUTO_ADDR_LIST",         "TRUE" )
epicsEnvSet( "EPICS_PVAS_AUTO_BEACON_ADDR_LIST", "TRUE" )

< envPaths

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("$(TOP)/dbd/pvNotepad.dbd")
pvNotepad_registerRecordDeviceDriver(pdbbase)

# Load record instances
dbLoadRecords("$(TOP)/db/iocSoft.db",            "IOC=$(EPICS_NAME)" )
dbLoadRecords("$(TOP)/db/save_restoreStatus.db", "P=$(EPICS_NAME):" )

#Standard array option
$$LOOP(ARRAY_1)
dbLoadRecords("$(TOP)/db/array_1.db","PV=$$PV,HUTCH=$$HUTCH,$$IF(NELM,NELM=$$NELM,NELM=500),$$IF(FTYPE,FTYPE=$$FTYPE,FTYPE=DOUBLE),$$IF(EGU,EGU=$$EGU,),$$IF(PREC,PREC=$$PREC,),$$IF(INP,INP=$$INP,),$$IF(IDENTIFIER,IDENTIFIER=$$IDENTIFIER,IDENTIFIER=01)")
$$ENDLOOP(ARRAY_1)
$$LOOP(ARRAY_10)
dbLoadRecords("$(TOP)/db/array_10.db","PV=$$PV,HUTCH=$$HUTCH,$$IF(NELM,NELM=$$NELM,NELM=500),$$IF(FTYPE,FTYPE=$$FTYPE,FTYPE=DOUBLE),$$IF(EGU,EGU=$$EGU,),$$IF(PREC,PREC=$$PREC,),$$IF(INP,INP=$$INP,),$$IF(IDENTIFIER,IDENTIFIER=$$IDENTIFIER,IDENTIFIER=01)")
$$ENDLOOP(ARRAY_10)
$$LOOP(ARRAY_20)
dbLoadRecords("$(TOP)/db/array_20.db","PV=$$PV,HUTCH=$$HUTCH,$$IF(NELM,NELM=$$NELM,NELM=500),$$IF(FTYPE,FTYPE=$$FTYPE,FTYPE=DOUBLE),$$IF(EGU,EGU=$$EGU,),$$IF(PREC,PREC=$$PREC,),$$IF(INP,INP=$$INP,),$$IF(IDENTIFIER,IDENTIFIER=$$IDENTIFIER,IDENTIFIER=01)")
$$ENDLOOP(ARRAY_20)
$$LOOP(HUTCH)
dbLoadRecords("$(TOP)/db/hutch.db",    "PV=$$PV")
$$ENDLOOP(HUTCH)

$$LOOP(SPECIAL)
dbLoadRecords("$(TOP)/db/special_$$RECTYPE.db",     "PV=$$PV$$IF(NELM),NELM=$$NELM$$ENDIF(NELM)$$IF(NORD),NORD=$$NORD$$ENDIF(NORD)$$IF(FTYPE),FTYPE=$$FTYPE$$ENDIF(FTYPE)$$IF(EGU),EGU=$$EGU$$ENDIF(EGU)$$IF(PREC),PREC=$$PREC$$ENDIF(PREC)$$IF(DESC),DESC=$$DESC$$ENDIF(DESC)$$IF(INP),INP=$$INP$$ENDIF(INP)$$IF(ZNAM),ZNAM=$$ZNAM$$ENDIF(ZNAM)$$IF(ONAM),ONAM=$$ONAM$$ENDIF(ONAM)$$IF(DTYP),DTYP=$$DTYP$$ENDIF(DTYP)$$IF(SCAN),SCAN=$$SCAN$$ENDIF(SCAN)$$IF(MDEL),MDEL=$$MDEL$$ENDIF(MDEL)$$IF(PINI),PINI=$$PINI$$ENDIF(PINI)$$IF(ZRST),ZRST=$$ZRST,ZRVL=$$IF(ZRVL,$$ZRVL,0)$$ENDIF(ZRST)$$IF(ONST),ONST=$$ONST,ONVL=$$IF(ONVL,$$ONVL,1)$$ENDIF(ONST)$$IF(TWST),TWST=$$TWST,TWVL=$$IF(TWVL,$$TWVL,2)$$ENDIF(TWST)$$IF(THST),THST=$$THST,THVL=$$IF(THVL,$$THVL,3)$$ENDIF(THST)$$IF(FRST),FRST=$$FRST,FRVL=$$IF(FRVL,$$FRVL,4)$$ENDIF(FRST)$$IF(FVST),FVST=$$FVST,FVVL=$$IF(FVVL,$$FVVL,5)$$ENDIF(FVST)$$IF(SXST),SXST=$$SXST,SXVL=$$IF(SXVL,$$SXVL,6)$$ENDIF(SXST)$$IF(SVST),SVST=$$SVST,SVVL=$$IF(SVVL,$$SVVL,7)$$ENDIF(SVST)$$IF(EIST),EIST=$$EIST,EIVL=$$IF(EIVL,$$EIVL,8)$$ENDIF(EIST)$$IF(NIST),NIST=$$NIST,NIVL=$$IF(NIVL,$$NIVL,9)$$ENDIF(NIST)$$IF(TEST),TEST=$$TEST,TEVL=$$IF(TEVL,$$TEVL,10)$$ENDIF(TEST)$$IF(ELST),ELST=$$ELST,ELVL=$$IF(ELVL,$$ELVL,11)$$ENDIF(ELST)$$IF(TVST),TVST=$$TVST,TVVL=$$IF(TVVL,$$TVVL,12)$$ENDIF(TVST)$$IF(TTST),TTST=$$TTST,TTVL=$$IF(TTVL,$$TTVL,13)$$ENDIF(TTST)$$IF(FTST),FTST=$$FTST,FTVL=$$IF(FTVL,$$FTVL,14)$$ENDIF(FTST)$$IF(FFST),FFST=$$FFST,FFVL=$$IF(FFVL,$$FFVL,15)$$ENDIF(FFST)")
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

