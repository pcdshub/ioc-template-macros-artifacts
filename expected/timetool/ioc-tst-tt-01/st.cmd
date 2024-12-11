#!/reg/g/pcds/epics/ioc/common/timetool/R1.0.7/bin/rhel7-x86_64/gsd

epicsEnvSet( "IOCNAME",	  "ioc-tst-tt-01" )
epicsEnvSet( "ENGINEER",  "Michael Browne (mcbrowne)" )
epicsEnvSet( "LOCATION",  "Somewhere" )
epicsEnvSet( "IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet( "IOC_PV",	  "IOC:TST:TT:01" )
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


## Load record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)")
dbLoadRecords( "db/save_restoreStatus.db", "P=$(IOC_PV):")



dbLoadRecords( "db/output.db", "BASE=TST:TT:01,NAME=A,FLNK=TST:TT:01:LATESTBUILD" )
dbLoadRecords( "db/output.db", "BASE=TST:TT:01,NAME=B,FLNK=TST:TT:01:LATESTBUILD" )
dbLoadRecords( "db/output.db", "BASE=TST:TT:01,NAME=C,FLNK=TST:TT:01:LATESTBUILD" )
dbLoadRecords( "db/output.db", "BASE=TST:TT:01,NAME=LATEST,TSEL=TST:TT:01:LATESTBUILD.TIME" )
dbLoadRecords( "db/output.db", "BASE=TST:TT:01,NAME=INDEX,TSEL=TST:TT:01:LATESTBUILD.TIME,TYPE=longout" )


dbLoadRecords( "db/lbuild.db", "NAME=TST:TT:01:LATESTBUILD,INPA=TST:TT:01:A,INPB=TST:TT:01:B,INPC=TST:TT:01:C,OUT=TST:TT:01:LATEST PP NMS,INDEX=TST:TT:01:INDEX PP NMS" )

## Setup autosave
set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(TOP)/autosave" )
# Also look in the iocData autosave folder for auto generated req files
set_requestfile_path( "$(IOC_DATA)/$(IOC)/autosave" )
save_restoreSet_status_prefix( "$(IOC_PV):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

set_pass0_restoreFile( "autoSettings.sav" )
set_pass0_restoreFile( "ioc-tst-tt-01.sav" )

# Initialize the IOC and start processing records
iocInit()

# Create autosave files from info directives
makeAutosaveFileFromDbInfo( "$(IOC_DATA)/$(IOC)/autosave/autoSettings.req", "autosaveFields" )

# Start autosave backups
create_monitor_set( "autoSettings.req", 5, "" )
create_monitor_set( "ioc-tst-tt-01.req", 5, "" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

# Initialize the waveform strings.


dbpf TST:TT:01:LATEST:DESC "Final output"
dbpf TST:TT:01:LATEST.DESC "Final output"
dbpf TST:TT:01:INDEX:DESC "Output Index"
dbpf TST:TT:01:INDEX.DESC "Output Index"



