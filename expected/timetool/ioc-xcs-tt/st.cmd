#!/reg/g/pcds/epics/ioc/common/timetool/R1.0.7/bin/rhel7-x86_64/gsd

epicsEnvSet( "IOCNAME",	  "ioc-xcs-tt" )
epicsEnvSet( "ENGINEER",  "Jose E. Ortiz (jortiz)" )
epicsEnvSet( "LOCATION",  "XCS" )
epicsEnvSet( "IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet( "IOC_PV",	  "IOC:XCS:TT:01" )
epicsEnvSet("EVRID_PMC",  "1")
epicsEnvSet("EVRID_SLAC", "15")
epicsEnvSet("EVRDB_PMC",  "db/evrPmc230.db")
epicsEnvSet("EVRDB_SLAC", "db/evrSLAC.db")
epicsEnvSet( "IOCTOP",	  "/reg/g/pcds/epics/ioc/common/timetool/R1.0.7" )
< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/common/timetool/R1.0.7/children/build")
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
dbLoadRecords( $(EVRDB_SLAC), "IOC=IOC:XCS:TT:01,EVR=XCS:TT:EVR:01,CARD=0" )

## Load record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)")
dbLoadRecords( "db/save_restoreStatus.db", "P=$(IOC_PV):")

dbLoadRecords( "db/ttall.db", "BASE=XCS:TT:01,FLNK=XCS:TT:01:EVENTBUILD" )
dbLoadRecords( "db/flnk.db", "NAME=XCS:TT:01:TTALL:DESC,FLNK=XCS:TT:01:EVENTBUILD:MAKE_DESC" )

dbLoadRecords( "db/local.db", "BASE=XCS:TT:01,NAME=IPM1,REMOTE=HX2:SB1:BMMON:SUM,FLNK=XCS:TT:01:IPMS" )
dbLoadRecords( "db/flnk.db", "NAME=XCS:TT:01:IPM1:DESC,FLNK=XCS:TT:01:IPMS:MAKE_DESC" )
dbLoadRecords( "db/local.db", "BASE=XCS:TT:01,NAME=IPM4,REMOTE=XCS:SB1:BMMON:SUM,FLNK=XCS:TT:01:IPMS" )
dbLoadRecords( "db/flnk.db", "NAME=XCS:TT:01:IPM4:DESC,FLNK=XCS:TT:01:IPMS:MAKE_DESC" )
dbLoadRecords( "db/local.db", "BASE=XCS:TT:01,NAME=IPM5,REMOTE=XCS:SB2:BMMON:SUM,FLNK=XCS:TT:01:IPMS" )
dbLoadRecords( "db/flnk.db", "NAME=XCS:TT:01:IPM5:DESC,FLNK=XCS:TT:01:IPMS:MAKE_DESC" )
dbLoadRecords( "db/local.db", "BASE=XCS:TT:01,NAME=L3E,REMOTE=BLD:SYS0:500:ENERGY,FLNK=XCS:TT:01:BLD" )
dbLoadRecords( "db/flnk.db", "NAME=XCS:TT:01:L3E:DESC,FLNK=XCS:TT:01:BLD:MAKE_DESC" )
dbLoadRecords( "db/local.db", "BASE=XCS:TT:01,NAME=EPHOT,REMOTE=BLD:SYS0:500:PHOTONENERGY,FLNK=XCS:TT:01:BLD" )
dbLoadRecords( "db/flnk.db", "NAME=XCS:TT:01:EPHOT:DESC,FLNK=XCS:TT:01:BLD:MAKE_DESC" )
dbLoadRecords( "db/local.db", "BASE=XCS:TT:01,NAME=GDET241,REMOTE=GDET:FEE1:241:ENRC,FLNK=XCS:TT:01:BLD" )
dbLoadRecords( "db/flnk.db", "NAME=XCS:TT:01:GDET241:DESC,FLNK=XCS:TT:01:BLD:MAKE_DESC" )
dbLoadRecords( "db/local.db", "BASE=XCS:TT:01,NAME=GDET242,REMOTE=GDET:FEE1:242:ENRC,FLNK=XCS:TT:01:BLD" )
dbLoadRecords( "db/flnk.db", "NAME=XCS:TT:01:GDET242:DESC,FLNK=XCS:TT:01:BLD:MAKE_DESC" )
dbLoadRecords( "db/local.db", "BASE=XCS:TT:01,NAME=DIODEU:CH0,REMOTE=XCS:USR:IMB:01:CH0,FLNK=XCS:TT:01:DIODEU" )
dbLoadRecords( "db/flnk.db", "NAME=XCS:TT:01:DIODEU:CH0:DESC,FLNK=XCS:TT:01:DIODEU:MAKE_DESC" )
dbLoadRecords( "db/local.db", "BASE=XCS:TT:01,NAME=DIODEU:CH1,REMOTE=XCS:USR:IMB:01:CH1,FLNK=XCS:TT:01:DIODEU" )
dbLoadRecords( "db/flnk.db", "NAME=XCS:TT:01:DIODEU:CH1:DESC,FLNK=XCS:TT:01:DIODEU:MAKE_DESC" )
dbLoadRecords( "db/local.db", "BASE=XCS:TT:01,NAME=DIODEU:CH2,REMOTE=XCS:USR:IMB:01:CH2,FLNK=XCS:TT:01:DIODEU" )
dbLoadRecords( "db/flnk.db", "NAME=XCS:TT:01:DIODEU:CH2:DESC,FLNK=XCS:TT:01:DIODEU:MAKE_DESC" )
dbLoadRecords( "db/local.db", "BASE=XCS:TT:01,NAME=DIODEU:CH3,REMOTE=XCS:USR:IMB:01:CH3,FLNK=XCS:TT:01:DIODEU" )
dbLoadRecords( "db/flnk.db", "NAME=XCS:TT:01:DIODEU:CH3:DESC,FLNK=XCS:TT:01:DIODEU:MAKE_DESC" )


dbLoadRecords( "db/ebuild.db", "NAME=XCS:TT:01:IPMS,NOVA=3,INPA=XCS:TT:01:IPM1,NOA=1,INPB=XCS:TT:01:IPM4,NOB=1,INPC=XCS:TT:01:IPM5,NOC=1,FLNK=XCS:TT:01:EVTBUILDNOTT" )
dbLoadRecords( "db/flnk.db", "NAME=XCS:TT:01:IPMS:DESC,FLNK=XCS:TT:01:EVTBUILDNOTT:MAKE_DESC" )
dbLoadRecords( "db/ebuild.db", "NAME=XCS:TT:01:BLD,NOVA=4,INPA=XCS:TT:01:L3E,NOA=1,INPB=XCS:TT:01:EPHOT,NOB=1,INPC=XCS:TT:01:GDET241,NOC=1,INPD=XCS:TT:01:GDET242,NOD=1,FLNK=XCS:TT:01:EVTBUILDNOTT" )
dbLoadRecords( "db/flnk.db", "NAME=XCS:TT:01:BLD:DESC,FLNK=XCS:TT:01:EVTBUILDNOTT:MAKE_DESC" )
dbLoadRecords( "db/ebuild.db", "NAME=XCS:TT:01:DIODEU,NOVA=4,INPA=XCS:TT:01:DIODEU:CH0,NOA=1,INPB=XCS:TT:01:DIODEU:CH1,NOB=1,INPC=XCS:TT:01:DIODEU:CH2,NOC=1,INPD=XCS:TT:01:DIODEU:CH3,NOD=1,FLNK=XCS:TT:01:EVTBUILDNOTT" )
dbLoadRecords( "db/flnk.db", "NAME=XCS:TT:01:DIODEU:DESC,FLNK=XCS:TT:01:EVTBUILDNOTT:MAKE_DESC" )
dbLoadRecords( "db/ebuild.db", "NAME=XCS:TT:01:EVTBUILDNOTT,NOVA=11,INPA=XCS:TT:01:IPMS.VALA,NOA=3,INPB=XCS:TT:01:BLD.VALA,NOB=4,INPC=XCS:TT:01:DIODEU.VALA,NOC=4,DSCA=XCS:TT:01:IPMS,DSCB=XCS:TT:01:BLD,DSCC=XCS:TT:01:DIODEU,FLNK=XCS:TT:01:EVENTBUILD" )
dbLoadRecords( "db/flnk.db", "NAME=XCS:TT:01:EVTBUILDNOTT:DESC,FLNK=XCS:TT:01:EVENTBUILD:MAKE_DESC" )
dbLoadRecords( "db/ebuild.db", "NAME=XCS:TT:01:EVENTBUILD,NOVA=19,INPA=XCS:TT:01:EVTBUILDNOTT.VALA,NOA=11,INPB=XCS:TT:01:TTALL,NOB=8,DSCA=XCS:TT:01:EVTBUILDNOTT" )


## Setup autosave
set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(TOP)/autosave" )
# Also look in the iocData autosave folder for auto generated req files
set_requestfile_path( "$(IOC_DATA)/$(IOC)/autosave" )
save_restoreSet_status_prefix( "$(IOC_PV):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

set_pass0_restoreFile( "autoSettings.sav" )
set_pass0_restoreFile( "ioc-xcs-tt.sav" )

# Initialize the IOC and start processing records
iocInit()

# Create autosave files from info directives
makeAutosaveFileFromDbInfo( "$(IOC_DATA)/$(IOC)/autosave/autoSettings.req", "autosaveFields" )

# Start autosave backups
create_monitor_set( "autoSettings.req", 5, "" )
create_monitor_set( "ioc-xcs-tt.req", 5, "" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

# Initialize the waveform strings.
dbpf XCS:TT:01:TTALL:DESC0 "Fitted Peak Pos (pixels)"
dbpf XCS:TT:01:TTALL:DESC1 "Fitted Peak Pos (time)"
dbpf XCS:TT:01:TTALL:DESC2 "Peak Amplitude (adu)"
dbpf XCS:TT:01:TTALL:DESC3 "2nd Peak Amplitude (adu)"
dbpf XCS:TT:01:TTALL:DESC4 "Background ref (adu)"
dbpf XCS:TT:01:TTALL:DESC5 "FWHM (pixels)"
dbpf XCS:TT:01:TTALL:DESC6 "Sum"
dbpf XCS:TT:01:TTALL:DESC7 "DAQ timestamp"
dbpf XCS:TT:01:TTALL:MAKE_DESC.PROC 1

dbpf XCS:TT:01:IPM1:DESC "IPM1 Sum"
dbpf XCS:TT:01:IPM4:DESC "IPM4 Sum"
dbpf XCS:TT:01:IPM5:DESC "IPM5 Sum"
dbpf XCS:TT:01:L3E:DESC "L3E"
dbpf XCS:TT:01:EPHOT:DESC "Photon Energy"
dbpf XCS:TT:01:GDET241:DESC "GDET 241"
dbpf XCS:TT:01:GDET242:DESC "GDET 242"
dbpf XCS:TT:01:DIODEU:CH0:DESC "DiodeU Ch0"
dbpf XCS:TT:01:DIODEU:CH1:DESC "DiodeU Ch1"
dbpf XCS:TT:01:DIODEU:CH2:DESC "DiodeU Ch2"
dbpf XCS:TT:01:DIODEU:CH3:DESC "DiodeU Ch3"


dbpf XCS:TT:01:IPMS:MAKE_DESC.PROC 1
dbpf XCS:TT:01:BLD:MAKE_DESC.PROC 1
dbpf XCS:TT:01:DIODEU:MAKE_DESC.PROC 1
dbpf XCS:TT:01:EVTBUILDNOTT:MAKE_DESC.PROC 1
dbpf XCS:TT:01:EVENTBUILD:MAKE_DESC.PROC 1

