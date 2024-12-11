#!$$IOCTOP/bin/$$IF(ARCH,$$ARCH,linux-86_64)/gsd

epicsEnvSet( "IOCNAME",	  "$$IOCNAME" )
epicsEnvSet( "ENGINEER",  "$$ENGINEER" )
epicsEnvSet( "LOCATION",  "$$LOCATION" )
epicsEnvSet( "IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet( "IOC_PV",	  "$$IOC_PV" )
epicsEnvSet("EVRID_PMC",  "1")
epicsEnvSet("EVRID_SLAC", "15")
epicsEnvSet("EVRDB_PMC",  "db/evrPmc230.db")
epicsEnvSet("EVRDB_SLAC", "db/evrSLAC.db")
epicsEnvSet( "IOCTOP",	  "$$IOCTOP" )
< envPaths
epicsEnvSet("TOP", "$$TOP")
cd("$(IOCTOP)")

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

## Register all support components
dbLoadDatabase( "dbd/gsd.dbd" )
gsd_registerRecordDeviceDriver(pdbbase)

ErDebugLevel( 0 )

$$LOOP(EVR)
# Initialize EVR
ErConfigure( $$IF(CARD,$$CARD,$$INDEX), 0, 0, 0, $(EVRID_$$TYPE) )

# Load EVR record instances
dbLoadRecords( $(EVRDB_$$TYPE), "IOC=$$(IOC_PV),EVR=$$(NAME),CARD=$$IF(CARD,$$CARD,$$INDEX)" )
$$ENDLOOP(EVR)

## Load record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)")
dbLoadRecords( "db/save_restoreStatus.db", "P=$(IOC_PV):")

$$LOOP(TTALL)
dbLoadRecords( "db/ttall.db", "BASE=$$BASE$$IF(FLNK),FLNK=$$BASE:$$FLNK$$ENDIF(FLNK)" )
$$IF(FLNK)
dbLoadRecords( "db/flnk.db", "NAME=$$BASE:TTALL:DESC,FLNK=$$BASE:$$FLNK:MAKE_DESC" )
$$ENDIF(FLNK)
$$ENDLOOP(TTALL)

$$LOOP(LOCAL)
dbLoadRecords( "db/local.db", "BASE=$$BASE,NAME=$$NAME,REMOTE=$$REMOTE$$IF(FLNK),FLNK=$$BASE:$$FLNK$$ENDIF(FLNK)" )
$$IF(FLNK)
dbLoadRecords( "db/flnk.db", "NAME=$$BASE:$$NAME:DESC,FLNK=$$BASE:$$FLNK:MAKE_DESC" )
$$ENDIF(FLNK)
$$ENDLOOP(LOCAL)

$$LOOP(EBUILD)
dbLoadRecords( "db/ebuild.db", "NAME=$$BASE:$$NAME,NOVA=$$NOVA,INPA=$$BASE:$$INPA,NOA=$$NOA,INPB=$$BASE:$$INPB,NOB=$$NOB$$IF(INPC),INPC=$$BASE:$$INPC,NOC=$$NOC$$ENDIF(INPC)$$IF(INPD),INPD=$$BASE:$$INPD,NOD=$$NOD$$ENDIF(INPD)$$IF(INPE),INPE=$$BASE:$$INPE,NOE=$$NOE$$ENDIF(INPE)$$IF(INPF),INPF=$$BASE:$$INPF,NOF=$$NOF$$ENDIF(INPF)$$IF(INPG),INPG=$$BASE:$$INPG,NOG=$$NOG$$ENDIF(INPG)$$IF(INPH),INPH=$$BASE:$$INPH,NOH=$$NOH$$ENDIF(INPH)$$IF(INPI),INPI=$$BASE:$$INPI,NOI=$$NOI$$ENDIF(INPI)$$IF(INPJ),INPJ=$$BASE:$$INPJ,NOJ=$$NOJ$$ENDIF(INPJ)$$IF(INPK),INPK=$$BASE:$$INPK,NOK=$$NOK$$ENDIF(INPK)$$IF(INPL),INPL=$$BASE:$$INPL,NOL=$$NOL$$ENDIF(INPL)$$IF(INPM),INPM=$$BASE:$$INPM,NOM=$$NOM$$ENDIF(INPM)$$IF(INPN),INPN=$$BASE:$$INPN,NON=$$NON$$ENDIF(INPN)$$IF(INPO),INPO=$$BASE:$$INPO,NOO=$$NOO$$ENDIF(INPO)$$IF(INPP),INPP=$$BASE:$$INPP,NOP=$$NOP$$ENDIF(INPP)$$IF(INPQ),INPQ=$$BASE:$$INPQ,NOQ=$$NOQ$$ENDIF(INPQ)$$IF(INPR),INPR=$$BASE:$$INPR,NOR=$$NOR$$ENDIF(INPR)$$IF(INPS),INPS=$$BASE:$$INPS,NOS=$$NOS$$ENDIF(INPS)$$IF(INPT),INPT=$$BASE:$$INPT,NOT=$$NOT$$ENDIF(INPT)$$IF(INPU),INPU=$$BASE:$$INPU,NOU=$$NOU$$ENDIF(INPU)$$IF(DSCA),DSCA=$$BASE:$$DSCA$$ENDIF(DSCA)$$IF(DSCB),DSCB=$$BASE:$$DSCB$$ENDIF(DSCB)$$IF(DSCC),DSCC=$$BASE:$$DSCC$$ENDIF(DSCC)$$IF(DSCD),DSCD=$$BASE:$$DSCD$$ENDIF(DSCD)$$IF(DSCE),DSCE=$$BASE:$$DSCE$$ENDIF(DSCE)$$IF(DSCF),DSCF=$$BASE:$$DSCF$$ENDIF(DSCF)$$IF(DSCG),DSCG=$$BASE:$$DSCG$$ENDIF(DSCG)$$IF(DSCH),DSCH=$$BASE:$$DSCH$$ENDIF(DSCH)$$IF(DSCI),DSCI=$$BASE:$$DSCI$$ENDIF(DSCI)$$IF(DSCJ),DSCJ=$$BASE:$$DSCJ$$ENDIF(DSCJ)$$IF(DSCK),DSCK=$$BASE:$$DSCK$$ENDIF(DSCK)$$IF(DSCL),DSCL=$$BASE:$$DSCL$$ENDIF(DSCL)$$IF(DSCM),DSCM=$$BASE:$$DSCM$$ENDIF(DSCM)$$IF(DSCN),DSCN=$$BASE:$$DSCN$$ENDIF(DSCN)$$IF(DSCO),DSCO=$$BASE:$$DSCO$$ENDIF(DSCO)$$IF(DSCP),DSCP=$$BASE:$$DSCP$$ENDIF(DSCP)$$IF(DSCQ),DSCQ=$$BASE:$$DSCQ$$ENDIF(DSCQ)$$IF(DSCR),DSCR=$$BASE:$$DSCR$$ENDIF(DSCR)$$IF(DSCS),DSCS=$$BASE:$$DSCS$$ENDIF(DSCS)$$IF(DSCT),DSCT=$$BASE:$$DSCT$$ENDIF(DSCT)$$IF(DSCU),DSCU=$$BASE:$$DSCU$$ENDIF(DSCU)$$IF(FLNK),FLNK=$$BASE:$$FLNK$$ENDIF(FLNK)" )
$$IF(FLNK)
dbLoadRecords( "db/flnk.db", "NAME=$$BASE:$$NAME:DESC,FLNK=$$BASE:$$FLNK:MAKE_DESC" )
$$ENDIF(FLNK)
$$ENDLOOP(EBUILD)

## Setup autosave
set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(TOP)/autosave" )
# Also look in the iocData autosave folder for auto generated req files
set_requestfile_path( "$(IOC_DATA)/$(IOC)/autosave" )
save_restoreSet_status_prefix( "$(IOC_PV):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

set_pass0_restoreFile( "autoSettings.sav" )
set_pass0_restoreFile( "$$IOCNAME.sav" )

# Initialize the IOC and start processing records
iocInit()

# Create autosave files from info directives
makeAutosaveFileFromDbInfo( "$(IOC_DATA)/$(IOC)/autosave/autoSettings.req", "autosaveFields" )

# Start autosave backups
create_monitor_set( "autoSettings.req", 5, "" )
create_monitor_set( "$$IOCNAME.req", 5, "" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

# Initialize the waveform strings.
$$LOOP(TTALL)
dbpf $$BASE:TTALL:DESC0 "Fitted Peak Pos (pixels)"
dbpf $$BASE:TTALL:DESC1 "Fitted Peak Pos (time)"
dbpf $$BASE:TTALL:DESC2 "Peak Amplitude (adu)"
dbpf $$BASE:TTALL:DESC3 "2nd Peak Amplitude (adu)"
dbpf $$BASE:TTALL:DESC4 "Background ref (adu)"
dbpf $$BASE:TTALL:DESC5 "FWHM (pixels)"
dbpf $$BASE:TTALL:DESC6 "Sum"
dbpf $$BASE:TTALL:DESC7 "DAQ timestamp"
dbpf $$BASE:TTALL:MAKE_DESC.PROC 1
$$ENDLOOP(TTALL)

$$LOOP(LOCAL)
dbpf $$BASE:$$NAME:DESC "$$IF(DESC,$$DESC,$$REMOTE)"
$$ENDLOOP(LOCAL)

$$LOOP(EBUILD)
dbpf $$BASE:$$NAME:MAKE_DESC.PROC 1
$$ENDLOOP(EBUILD)
