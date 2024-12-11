#!$$IOCTOP/bin/$$IF(ARCH,$$ARCH,rhel7-x86_64)/epixMonIoc

epicsEnvSet("IOCNAME", "$$IOCNAME" )
epicsEnvSet("ENGINEER", "$$ENGINEER" )
epicsEnvSet("LOCATION", "$$LOCATION" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "$$IOC_PV")
epicsEnvSet("IOCTOP", "$$IOCTOP")

< envPaths
epicsEnvSet("TOP", "$$TOP")

# Sigh. EPICS 7.0.3 is not a fan of hex constants.
$$LOOP(PGP)
epicsEnvSet("$$(BOX)_MASK", $$CALC{MASK})
$$ENDLOOP(PGP)

cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/epixMonIoc.dbd")
epixMonIoc_registerRecordDeviceDriver(pdbbase)

$$LOOP(EPIX)
dbLoadRecords("db/epixMon_trigger.db", "BASE=$$BASE:$$NAME")
$$ENDLOOP(EPIX)

$$LOOP(EPIXHR)
dbLoadRecords("db/epixMon_trigger.db", "BASE=$$BASE:$$NAME")
$$ENDLOOP(EPIXHR)

$$LOOP(EPIX2M)
$$IF(Q0_PGP)
dbLoadRecords("db/epixMon_trigger.db", "BASE=$$BASE:$$NAME:Q0")
$$ENDIF(Q0_PGP)
$$IF(Q1_PGP)
dbLoadRecords("db/epixMon_trigger.db", "BASE=$$BASE:$$NAME:Q1")
$$ENDIF(Q1_PGP)
$$IF(Q2_PGP)
dbLoadRecords("db/epixMon_trigger.db", "BASE=$$BASE:$$NAME:Q2")
$$ENDIF(Q2_PGP)
$$IF(Q3_PGP)
dbLoadRecords("db/epixMon_trigger.db", "BASE=$$BASE:$$NAME:Q3")
$$ENDIF(Q3_PGP)
$$ENDLOOP(EPIX2M)

$$LOOP(PGP)
PgpRegister("$$BOX", $$MASK, 0x8, $$IF(SRPV3,$$SRPV3,0))
$$ENDLOOP(PGP)

$$LOOP(EPIX)
$$IF(PGPBOX)
EpixMonRegister("$$BASE:$$NAME", "$$PGPBOX", "$$BASE:$$NAME:RUNNING")
$$ENDIF(PGPBOX)
$$ENDLOOP(EPIX)

$$LOOP(EPIXHR)
$$IF(PGPBOX)
EpixMonRegister("$$BASE:$$NAME", "$$PGPBOX", "$$BASE:$$NAME:RUNNING")
$$ENDIF(PGPBOX)
$$ENDLOOP(EPIXHR)

$$LOOP(EPIX2M)
$$IF(Q0_PGP)
EpixMonRegister("$$BASE:$$NAME:Q0", "$$NAME(Q0_PGP,BOX)", "$$BASE:$$NAME:Q0:RUNNING")
$$ENDIF(Q0_PGP)
$$IF(Q1_PGP)
EpixMonRegister("$$BASE:$$NAME:Q1", "$$NAME(Q1_PGP,BOX)", "$$BASE:$$NAME:Q1:RUNNING")
$$ENDIF(Q1_PGP)
$$IF(Q2_PGP)
EpixMonRegister("$$BASE:$$NAME:Q2", "$$NAME(Q2_PGP,BOX)", "$$BASE:$$NAME:Q2:RUNNING")
$$ENDIF(Q2_PGP)
$$IF(Q3_PGP)
EpixMonRegister("$$BASE:$$NAME:Q3", "$$NAME(Q3_PGP,BOX)", "$$BASE:$$NAME:Q3:RUNNING")
$$ENDIF(Q3_PGP)
$$ENDLOOP(EPIX2M)

# Load remaining record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "IOC=$(IOC_PV),P=$(IOC_PV):" )

$$LOOP(EPIX)
dbLoadRecords("db/detector-epix$$IF(QUAD,,-peltier).db", "DET=$$BASE:$$NAME,PREM=$$MPOD,DLVCHN=$$DLV,ALVCHN=$$ALV$$IF(QUAD)$$ELSE(QUAD),PLVCHN=$$PLV$$ENDIF(QUAD),HVCHN=$$HV,$$IF(TEMPPV)AMB_OMSL=closed_loop,AMB_DOL=$$TEMPPV CPP$$ELSE(TEMPPV)AMB_OMSL=supervisory,AMB_DOL=20$$ENDIF(TEMPPV)")
$$LOOP(CHILLER)
dbLoadRecords("db/chiller.db", "DET=$$BASE:$$NAME,CH=$$CH")
$$ENDLOOP(CHILLER)
$$ENDLOOP(EPIX)

$$LOOP(EPIXHR)
dbLoadRecords("db/detector-epix-peltier.db", "DET=$$BASE:$$NAME,PREM=$$MPOD,DLVCHN=$$DLV,ALVCHN=$$ALV,PLVCHN=$$PLV,HVCHN=$$HV,$$IF(TEMPPV)AMB_OMSL=closed_loop,AMB_DOL=$$TEMPPV CPP$$ELSE(TEMPPV)AMB_OMSL=supervisory,AMB_DOL=20$$ENDIF(TEMPPV)")
$$LOOP(CHILLER)
dbLoadRecords("db/chiller.db", "DET=$$BASE:$$NAME,CH=$$CH")
$$ENDLOOP(CHILLER)
$$ENDLOOP(EPIXHR)

$$LOOP(EPIX2M)
dbLoadRecords("db/detector-epix.db", "DET=$$BASE:$$NAME:Q0,PREM=$$MPOD,DLVCHN=$$Q0_DLV,ALVCHN=$$Q0_ALV,HVCHN=$$Q0_HV,$$IF(TEMPPV)AMB_OMSL=closed_loop,AMB_DOL=$$TEMPPV CPP$$ELSE(TEMPPV)AMB_OMSL=supervisory,AMB_DOL=20$$ENDIF(TEMPPV)")
dbLoadRecords("db/detector-epix.db", "DET=$$BASE:$$NAME:Q1,PREM=$$MPOD,DLVCHN=$$Q1_DLV,ALVCHN=$$Q1_ALV,HVCHN=$$Q1_HV,$$IF(TEMPPV)AMB_OMSL=closed_loop,AMB_DOL=$$TEMPPV CPP$$ELSE(TEMPPV)AMB_OMSL=supervisory,AMB_DOL=20$$ENDIF(TEMPPV)")
dbLoadRecords("db/detector-epix.db", "DET=$$BASE:$$NAME:Q2,PREM=$$MPOD,DLVCHN=$$Q2_DLV,ALVCHN=$$Q2_ALV,HVCHN=$$Q2_HV,$$IF(TEMPPV)AMB_OMSL=closed_loop,AMB_DOL=$$TEMPPV CPP$$ELSE(TEMPPV)AMB_OMSL=supervisory,AMB_DOL=20$$ENDIF(TEMPPV)")
dbLoadRecords("db/detector-epix.db", "DET=$$BASE:$$NAME:Q3,PREM=$$MPOD,DLVCHN=$$Q3_DLV,ALVCHN=$$Q3_ALV,HVCHN=$$Q3_HV,$$IF(TEMPPV)AMB_OMSL=closed_loop,AMB_DOL=$$TEMPPV CPP$$ELSE(TEMPPV)AMB_OMSL=supervisory,AMB_DOL=20$$ENDIF(TEMPPV)")
$$LOOP(CHILLER)
dbLoadRecords("db/chiller.db", "DET=$$BASE:$$NAME:Q0,CH=$$CH")
dbLoadRecords("db/chiller.db", "DET=$$BASE:$$NAME:Q1,CH=$$CH")
dbLoadRecords("db/chiller.db", "DET=$$BASE:$$NAME:Q2,CH=$$CH")
dbLoadRecords("db/chiller.db", "DET=$$BASE:$$NAME:Q3,CH=$$CH")
$$ENDLOOP(CHILLER)
dbLoadRecords("db/epix2m.db", "DET=$$BASE:$$NAME,C=$$COUNT(CHILLER)")
$$ENDLOOP(EPIX2M)

$$LOOP(EPIX)
$$IF(PGPBOX)
dbLoadRecords("db/epix$$IF(QUAD,Quad,)Mon.db", "IOC=$(IOC_PV),BASE=$$BASE:$$NAME,BOX=$$PGPBOX,MASK=$($$(PGPBOX)_MASK),SRPV3=$$IF(QUAD)$$IF(SRPV3,$$SRPV3,1)$$ELSE(QUAD)$$IF(SRPV3,$$SRPV3,0)$$ENDIF(QUAD)$$IF(QUAD)$$ELSE(QUAD),FIRM=$$IF(NEWFIRM,1,0)$$ENDIF(QUAD)")
$$ENDIF(PGPBOX)
$$ENDLOOP(EPIX)

$$LOOP(EPIXHR)
$$IF(PGPBOX)
dbLoadRecords("db/epixHrMon.db", "IOC=$(IOC_PV),BASE=$$BASE:$$NAME,BOX=$$PGPBOX,MASK=$($$(PGPBOX)_MASK),SRPV3=$$IF(SRPV3,$$SRPV3,1)")
$$ENDIF(PGPBOX)
$$ENDLOOP(EPIXHR)

$$LOOP(EPIX2M)
$$IF(Q0_PGP)
dbLoadRecords("db/epixQuadMon.db", "IOC=$(IOC_PV),BASE=$$BASE:$$NAME:Q0,BOX=$$NAME(Q0_PGP,BOX),MASK=$($$(Q0_PGP)_MASK),SRPV3=$$IF(SRPV3,$$SRPV3,1)")
$$ENDIF(Q0_PGP)
$$IF(Q1_PGP)
dbLoadRecords("db/epixQuadMon.db", "IOC=$(IOC_PV),BASE=$$BASE:$$NAME:Q1,BOX=$$NAME(Q1_PGP,BOX),MASK=$($$(Q1_PGP)_MASK),SRPV3=$$IF(SRPV3,$$SRPV3,1)")
$$ENDIF(Q1_PGP)
$$IF(Q2_PGP)
dbLoadRecords("db/epixQuadMon.db", "IOC=$(IOC_PV),BASE=$$BASE:$$NAME:Q2,BOX=$$NAME(Q2_PGP,BOX),MASK=$($$(Q2_PGP)_MASK),SRPV3=$$IF(SRPV3,$$SRPV3,1)")
$$ENDIF(Q2_PGP)
$$IF(Q3_PGP)
dbLoadRecords("db/epixQuadMon.db", "IOC=$(IOC_PV),BASE=$$BASE:$$NAME:Q3,BOX=$$NAME(Q3_PGP,BOX),MASK=$($$(Q3_PGP)_MASK),SRPV3=$$IF(SRPV3,$$SRPV3,1)")
$$ENDIF(Q3_PGP)
$$ENDLOOP(EPIX2M)

$$LOOP(VAR)
dbLoadRecords("db/var.db", "VAR=$$BASE:$$NAME,DEFAULT=$$IF(DEFAULT,$$DEFAULT,0),PREC=$$IF(PREC,$$PREC,0)")
$$ENDLOOP(VAR)

$$LOOP(INTERLOCK)
dbLoadRecords("db/interlock.db", "DET=$$BASE:$$EPIXNAME,NAME=INTER$$INDEX,A=$$IF(APV)$$APV CPP$$ELSE(APV)$$IF(AVAR,$$BASE:$$AVAR CPP,0)$$ENDIF(APV),B=$$IF(BPV)$$BPV CPP$$ELSE(BPV)$$IF(BVAR,$$BASE:$$BVAR CPP,0)$$ENDIF(BPV),C=$$IF(CPV)$$CPV CPP$$ELSE(CPV)$$IF(CVAR,$$BASE:$$CVAR CPP,0)$$ENDIF(CPV),D=$$IF(DPV)$$DPV CPP$$ELSE(DPV)$$IF(DVAR,$$BASE:$$DVAR CPP,0)$$ENDIF(DPV),E=$$IF(EPV)$$EPV CPP$$ELSE(EPV)$$IF(EVAR,$$BASE:$$EVAR CPP,0)$$ENDIF(EPV),F=$$IF(FPV)$$FPV CPP$$ELSE(FPV)$$IF(FVAR,$$BASE:$$FVAR CPP,0)$$ENDIF(FPV),DESC=$$DESC,CALC=$$COND")
$$ENDLOOP(INTERLOCK)

# Setup autosave
set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
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
