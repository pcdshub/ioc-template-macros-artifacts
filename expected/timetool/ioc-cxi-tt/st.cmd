#!/cds/group/pcds/epics/ioc/common/timetool/R1.0.6/bin/rhel7-x86_64/gsd

epicsEnvSet( "IOCNAME",	  "ioc-cxi-tt" )
epicsEnvSet( "ENGINEER",  "Divya Thanaekaran (divya)" )
epicsEnvSet( "LOCATION",  "CXI" )
epicsEnvSet( "IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet( "IOC_PV",	  "IOC:CXI:TT:01" )
epicsEnvSet("EVRID_PMC",  "1")
epicsEnvSet("EVRID_SLAC", "15")
epicsEnvSet("EVRDB_PMC",  "db/evrPmc230.db")
epicsEnvSet("EVRDB_SLAC", "db/evrSLAC.db")
epicsEnvSet( "IOCTOP",	  "/cds/group/pcds/epics/ioc/common/timetool/R1.0.6" )
< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/cxi/timetool/R1.0.0/build")
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
dbLoadRecords( $(EVRDB_SLAC), "IOC=IOC:CXI:TT:01,EVR=CXI:TT:EVR:01,CARD=0" )

## Load record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)")
dbLoadRecords( "db/save_restoreStatus.db", "P=$(IOC_PV):")

dbLoadRecords( "db/ttall.db", "BASE=CXI:TT:01,FLNK=CXI:TT:01:EVENTBUILD" )
dbLoadRecords( "db/flnk.db", "NAME=CXI:TT:01:TTALL:DESC,FLNK=CXI:TT:01:EVENTBUILD:MAKE_DESC" )

dbLoadRecords( "db/local.db", "BASE=CXI:TT:01,NAME=IPMDG2,REMOTE=CXI:DG2:BMMON:SUM,FLNK=CXI:TT:01:IPMS" )
dbLoadRecords( "db/flnk.db", "NAME=CXI:TT:01:IPMDG2:DESC,FLNK=CXI:TT:01:IPMS:MAKE_DESC" )
dbLoadRecords( "db/local.db", "BASE=CXI:TT:01,NAME=IPMDG3,REMOTE=CXI:DG3:BMMON:SUM,FLNK=CXI:TT:01:IPMS" )
dbLoadRecords( "db/flnk.db", "NAME=CXI:TT:01:IPMDG3:DESC,FLNK=CXI:TT:01:IPMS:MAKE_DESC" )

dbLoadRecords( "db/ebuild.db", "NAME=CXI:TT:01:IPMS,NOVA=2,INPA=CXI:TT:01:IPMDG2,NOA=1,INPB=CXI:TT:01:IPMDG3,NOB=1,FLNK=CXI:TT:01:EVENTBUILD" )
dbLoadRecords( "db/flnk.db", "NAME=CXI:TT:01:IPMS:DESC,FLNK=CXI:TT:01:EVENTBUILD:MAKE_DESC" )
dbLoadRecords( "db/ebuild.db", "NAME=CXI:TT:01:EVENTBUILD,NOVA=10,INPA=CXI:TT:01:IPMS.VALA,NOA=2,INPB=CXI:TT:01:TTALL,NOB=8,DSCA=CXI:TT:01:IPMS" )

## Setup autosave
set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(TOP)/autosave" )
# Also look in the iocData autosave folder for auto generated req files
set_requestfile_path( "$(IOC_DATA)/$(IOC)/autosave" )
save_restoreSet_status_prefix( "$(IOC_PV):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

set_pass0_restoreFile( "autoSettings.sav" )
set_pass0_restoreFile( "ioc-cxi-tt.sav" )

# Initialize the IOC and start processing records
iocInit()

# Create autosave files from info directives
makeAutosaveFileFromDbInfo( "$(IOC_DATA)/$(IOC)/autosave/autoSettings.req", "autosaveFields" )

# Start autosave backups
create_monitor_set( "autoSettings.req", 5, "" )
create_monitor_set( "ioc-cxi-tt.req", 5, "" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

# Initialize the waveform strings.
dbpf CXI:TT:01:TTALL:DESC0 "Fitted Peak Pos (pixels)"
dbpf CXI:TT:01:TTALL:DESC1 "Fitted Peak Pos (time)"
dbpf CXI:TT:01:TTALL:DESC2 "Peak Amplitude (adu)"
dbpf CXI:TT:01:TTALL:DESC3 "2nd Peak Amplitude (adu)"
dbpf CXI:TT:01:TTALL:DESC4 "Background ref (adu)"
dbpf CXI:TT:01:TTALL:DESC5 "FWHM (pixels)"
dbpf CXI:TT:01:TTALL:DESC6 "Sum"
dbpf CXI:TT:01:TTALL:DESC7 "DAQ timestamp"
dbpf CXI:TT:01:TTALL:MAKE_DESC.PROC 1

dbpf CXI:TT:01:IPMDG2:DESC "ipm_dg2 Sum"
dbpf CXI:TT:01:IPMDG3:DESC "ipm_dg3 Sum"

dbpf CXI:TT:01:IPMS:MAKE_DESC.PROC 1
dbpf CXI:TT:01:EVENTBUILD:MAKE_DESC.PROC 1
