#!/cds/group/pcds/epics/ioc/common/timetool/R1.0.3/bin/rhel7-x86_64/gsd

epicsEnvSet( "IOCNAME",	  "ioc-xpp-tt" )
epicsEnvSet( "ENGINEER",  "Vincent Esposito (espov)" )
epicsEnvSet( "LOCATION",  "XPP" )
epicsEnvSet( "IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet( "IOC_PV",	  "IOC:XPP:TT:01" )
epicsEnvSet("EVRID_PMC",  "1")
epicsEnvSet("EVRID_SLAC", "15")
epicsEnvSet("EVRDB_PMC",  "db/evrPmc230.db")
epicsEnvSet("EVRDB_SLAC", "db/evrSLAC.db")
epicsEnvSet( "IOCTOP",	  "/cds/group/pcds/epics/ioc/common/timetool/R1.0.3" )
< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/xpp/timetool/R1.0.0/build")
cd("$(IOCTOP)")

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

## Register all support components
dbLoadDatabase( "dbd/gsd.dbd" )
gsd_registerRecordDeviceDriver(pdbbase)

ErDebugLevel( 0 )

# Initialize EVR
ErConfigure( 0, 0, 0, 0, $(EVRID_SLAC) )

# Load EVR record instances
dbLoadRecords( $(EVRDB_SLAC), "IOC=IOC:XPP:TT:01,EVR=XPP:TT:EVR:01,CARD=0" )

## Load record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)")
dbLoadRecords( "db/save_restoreStatus.db", "P=$(IOC_PV):")

dbLoadRecords( "db/ttall.db", "BASE=XPP:TT:01,FLNK=XPP:TT:01:EVENTBUILD" )
dbLoadRecords( "db/flnk.db", "NAME=XPP:TT:01:TTALL:DESC,FLNK=XPP:TT:01:EVENTBUILD:MAKE_DESC" )

dbLoadRecords( "db/local.db", "BASE=XPP:TT:01,NAME=IPM1,REMOTE=HX2:SB1:BMMON:SUM,FLNK=XPP:TT:01:IPMS" )
dbLoadRecords( "db/flnk.db", "NAME=XPP:TT:01:IPM1:DESC,FLNK=XPP:TT:01:IPMS:MAKE_DESC" )
dbLoadRecords( "db/local.db", "BASE=XPP:TT:01,NAME=IPM2,REMOTE=XPP:SB2:BMMON:SUM,FLNK=XPP:TT:01:IPMS" )
dbLoadRecords( "db/flnk.db", "NAME=XPP:TT:01:IPM2:DESC,FLNK=XPP:TT:01:IPMS:MAKE_DESC" )
dbLoadRecords( "db/local.db", "BASE=XPP:TT:01,NAME=L3E,REMOTE=BLD:SYS0:500:ENERGY,FLNK=XPP:TT:01:BLD" )
dbLoadRecords( "db/flnk.db", "NAME=XPP:TT:01:L3E:DESC,FLNK=XPP:TT:01:BLD:MAKE_DESC" )
dbLoadRecords( "db/local.db", "BASE=XPP:TT:01,NAME=EPHOT,REMOTE=BLD:SYS0:500:PHOTONENERGY,FLNK=XPP:TT:01:BLD" )
dbLoadRecords( "db/flnk.db", "NAME=XPP:TT:01:EPHOT:DESC,FLNK=XPP:TT:01:BLD:MAKE_DESC" )
dbLoadRecords( "db/local.db", "BASE=XPP:TT:01,NAME=GDET241,REMOTE=GDET:FEE1:241:ENRC,FLNK=XPP:TT:01:BLD" )
dbLoadRecords( "db/flnk.db", "NAME=XPP:TT:01:GDET241:DESC,FLNK=XPP:TT:01:BLD:MAKE_DESC" )
dbLoadRecords( "db/local.db", "BASE=XPP:TT:01,NAME=GDET242,REMOTE=GDET:FEE1:242:ENRC,FLNK=XPP:TT:01:BLD" )
dbLoadRecords( "db/flnk.db", "NAME=XPP:TT:01:GDET242:DESC,FLNK=XPP:TT:01:BLD:MAKE_DESC" )
dbLoadRecords( "db/local.db", "BASE=XPP:TT:01,NAME=DIODEU:CH0,REMOTE=XPP:USR:IPM:01:CH0,FLNK=XPP:TT:01:DIODEU" )
dbLoadRecords( "db/flnk.db", "NAME=XPP:TT:01:DIODEU:CH0:DESC,FLNK=XPP:TT:01:DIODEU:MAKE_DESC" )
dbLoadRecords( "db/local.db", "BASE=XPP:TT:01,NAME=DIODEU:CH1,REMOTE=XPP:USR:IPM:01:CH1,FLNK=XPP:TT:01:DIODEU" )
dbLoadRecords( "db/flnk.db", "NAME=XPP:TT:01:DIODEU:CH1:DESC,FLNK=XPP:TT:01:DIODEU:MAKE_DESC" )
dbLoadRecords( "db/local.db", "BASE=XPP:TT:01,NAME=DIODEU:CH2,REMOTE=XPP:USR:IPM:01:CH2,FLNK=XPP:TT:01:DIODEU" )
dbLoadRecords( "db/flnk.db", "NAME=XPP:TT:01:DIODEU:CH2:DESC,FLNK=XPP:TT:01:DIODEU:MAKE_DESC" )
dbLoadRecords( "db/local.db", "BASE=XPP:TT:01,NAME=DIODEU:CH3,REMOTE=XPP:USR:IPM:01:CH3,FLNK=XPP:TT:01:DIODEU" )
dbLoadRecords( "db/flnk.db", "NAME=XPP:TT:01:DIODEU:CH3:DESC,FLNK=XPP:TT:01:DIODEU:MAKE_DESC" )
dbLoadRecords( "db/local.db", "BASE=XPP:TT:01,NAME=PIM3:CH0,REMOTE=XPP:SB3:IPM:02:CH0,FLNK=XPP:TT:01:DIODEU" )
dbLoadRecords( "db/flnk.db", "NAME=XPP:TT:01:PIM3:CH0:DESC,FLNK=XPP:TT:01:DIODEU:MAKE_DESC" )
dbLoadRecords( "db/local.db", "BASE=XPP:TT:01,NAME=PIM3:CH1,REMOTE=XPP:SB3:IPM:02:CH1,FLNK=XPP:TT:01:DIODEU" )
dbLoadRecords( "db/flnk.db", "NAME=XPP:TT:01:PIM3:CH1:DESC,FLNK=XPP:TT:01:DIODEU:MAKE_DESC" )
dbLoadRecords( "db/local.db", "BASE=XPP:TT:01,NAME=PIM3:CH2,REMOTE=XPP:SB3:IPM:02:CH2,FLNK=XPP:TT:01:DIODEU" )
dbLoadRecords( "db/flnk.db", "NAME=XPP:TT:01:PIM3:CH2:DESC,FLNK=XPP:TT:01:DIODEU:MAKE_DESC" )
dbLoadRecords( "db/local.db", "BASE=XPP:TT:01,NAME=PIM3:CH3,REMOTE=XPP:SB3:IPM:02:CH3,FLNK=XPP:TT:01:DIODEU" )
dbLoadRecords( "db/flnk.db", "NAME=XPP:TT:01:PIM3:CH3:DESC,FLNK=XPP:TT:01:DIODEU:MAKE_DESC" )

dbLoadRecords( "db/ebuild.db", "NAME=XPP:TT:01:IPMS,NOVA=2,INPA=XPP:TT:01:IPM1,NOA=1,INPB=XPP:TT:01:IPM2,NOB=1,FLNK=XPP:TT:01:EVTBUILDNOTT" )
dbLoadRecords( "db/flnk.db", "NAME=XPP:TT:01:IPMS:DESC,FLNK=XPP:TT:01:EVTBUILDNOTT:MAKE_DESC" )
dbLoadRecords( "db/ebuild.db", "NAME=XPP:TT:01:BLD,NOVA=4,INPA=XPP:TT:01:L3E,NOA=1,INPB=XPP:TT:01:EPHOT,NOB=1,INPC=XPP:TT:01:GDET241,NOC=1,INPD=XPP:TT:01:GDET242,NOD=1,FLNK=XPP:TT:01:EVTBUILDNOTT" )
dbLoadRecords( "db/flnk.db", "NAME=XPP:TT:01:BLD:DESC,FLNK=XPP:TT:01:EVTBUILDNOTT:MAKE_DESC" )
dbLoadRecords( "db/ebuild.db", "NAME=XPP:TT:01:DIODEU,NOVA=8,INPA=XPP:TT:01:DIODEU:CH0,NOA=1,INPB=XPP:TT:01:DIODEU:CH1,NOB=1,INPC=XPP:TT:01:DIODEU:CH2,NOC=1,INPD=XPP:TT:01:DIODEU:CH3,NOD=1,INPE=XPP:TT:01:PIM3:CH0,NOE=1,INPF=XPP:TT:01:PIM3:CH1,NOF=1,INPG=XPP:TT:01:PIM3:CH2,NOG=1,INPH=XPP:TT:01:PIM3:CH3,NOH=1,FLNK=XPP:TT:01:EVTBUILDNOTT" )
dbLoadRecords( "db/flnk.db", "NAME=XPP:TT:01:DIODEU:DESC,FLNK=XPP:TT:01:EVTBUILDNOTT:MAKE_DESC" )
dbLoadRecords( "db/ebuild.db", "NAME=XPP:TT:01:EVTBUILDNOTT,NOVA=14,INPA=XPP:TT:01:IPMS.VALA,NOA=2,INPB=XPP:TT:01:BLD.VALA,NOB=4,INPC=XPP:TT:01:DIODEU.VALA,NOC=8,DSCA=XPP:TT:01:IPMS,DSCB=XPP:TT:01:BLD,DSCC=XPP:TT:01:DIODEU,FLNK=XPP:TT:01:EVENTBUILD" )
dbLoadRecords( "db/flnk.db", "NAME=XPP:TT:01:EVTBUILDNOTT:DESC,FLNK=XPP:TT:01:EVENTBUILD:MAKE_DESC" )
dbLoadRecords( "db/ebuild.db", "NAME=XPP:TT:01:EVENTBUILD,NOVA=22,INPA=XPP:TT:01:EVTBUILDNOTT.VALA,NOA=14,INPB=XPP:TT:01:TTALL,NOB=8,DSCA=XPP:TT:01:EVTBUILDNOTT" )

## Setup autosave
set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(TOP)/autosave" )
# Also look in the iocData autosave folder for auto generated req files
set_requestfile_path( "$(IOC_DATA)/$(IOC)/autosave" )
save_restoreSet_status_prefix( "$(IOC_PV):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

set_pass0_restoreFile( "autoSettings.sav" )
set_pass0_restoreFile( "ioc-xpp-tt.sav" )

# Initialize the IOC and start processing records
iocInit()

# Create autosave files from info directives
makeAutosaveFileFromDbInfo( "$(IOC_DATA)/$(IOC)/autosave/autoSettings.req", "autosaveFields" )

# Start autosave backups
create_monitor_set( "autoSettings.req", 5, "" )
create_monitor_set( "ioc-xpp-tt.req", 5, "" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

# Initialize the waveform strings.
dbpf XPP:TT:01:TTALL:DESC0 "Fitted Peak Pos (pixels)"
dbpf XPP:TT:01:TTALL:DESC1 "Fitted Peak Pos (time)"
dbpf XPP:TT:01:TTALL:DESC2 "Peak Amplitude (adu)"
dbpf XPP:TT:01:TTALL:DESC3 "2nd Peak Amplitude (adu)"
dbpf XPP:TT:01:TTALL:DESC4 "Background ref (adu)"
dbpf XPP:TT:01:TTALL:DESC5 "FWHM (pixels)"
dbpf XPP:TT:01:TTALL:DESC6 "Sum"
dbpf XPP:TT:01:TTALL:DESC7 "DAQ timestamp"
dbpf XPP:TT:01:TTALL:MAKE_DESC.PROC 1

dbpf XPP:TT:01:IPM1:DESC "IPM1 Sum"
dbpf XPP:TT:01:IPM2:DESC "IPM2 Sum"
dbpf XPP:TT:01:L3E:DESC "L3E"
dbpf XPP:TT:01:EPHOT:DESC "Photon Energy"
dbpf XPP:TT:01:GDET241:DESC "GDET 241"
dbpf XPP:TT:01:GDET242:DESC "GDET 242"
dbpf XPP:TT:01:DIODEU:CH0:DESC "DiodeU Ch0"
dbpf XPP:TT:01:DIODEU:CH1:DESC "DiodeU Ch1"
dbpf XPP:TT:01:DIODEU:CH2:DESC "DiodeU Ch2"
dbpf XPP:TT:01:DIODEU:CH3:DESC "DiodeU Ch3"
dbpf XPP:TT:01:PIM3:CH0:DESC "Diode2 Ch0"
dbpf XPP:TT:01:PIM3:CH1:DESC "Diode2 Ch1"
dbpf XPP:TT:01:PIM3:CH2:DESC "Diode2 Ch2"
dbpf XPP:TT:01:PIM3:CH3:DESC "Diode2 Ch3"

dbpf XPP:TT:01:IPMS:MAKE_DESC.PROC 1
dbpf XPP:TT:01:BLD:MAKE_DESC.PROC 1
dbpf XPP:TT:01:DIODEU:MAKE_DESC.PROC 1
dbpf XPP:TT:01:EVTBUILDNOTT:MAKE_DESC.PROC 1
dbpf XPP:TT:01:EVENTBUILD:MAKE_DESC.PROC 1
