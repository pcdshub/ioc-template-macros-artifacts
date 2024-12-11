#!/reg/g/pcds/package/epics/3.14/ioc/common/imp/R1.0.7/bin/linux-x86_64/impIoc

epicsEnvSet("IOCNAME", "ioc-xcs-bmmon" )
epicsEnvSet("ENGINEER", "Michael Browne (mcbrowne)" )
epicsEnvSet("LOCATION", "unknown" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "IOC:XCS:BMMON")
epicsEnvSet("EVRID_PMC",  "1")
epicsEnvSet("EVRID_SLAC", "15")
epicsEnvSet("EVRDB_PMC",  "db/evrPmc230.db")
epicsEnvSet("EVRDB_SLAC", "db/evrSLAC.db")
epicsEnvSet("IOCTOP", "/reg/g/pcds/package/epics/3.14/ioc/common/imp/R1.0.7")

< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/package/epics/3.14/ioc/common/imp/R1.0.7/children/build")
cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/impIoc.dbd")
impIoc_registerRecordDeviceDriver(pdbbase)

ErDebugLevel( 0 )

# Initialize EVR
ErConfigure( 0, 0, 0, 0, $(EVRID_SLAC) )

# Load EVR record instances
dbLoadRecords( $(EVRDB_SLAC), "IOC=IOC:XCS:BMMON,EVR=EVR:XCS:BMMON,CARD=0,IP1E=Enabled,IP0E=Enabled" )

PgpRegister(PGP0, 0x80)

Imp2Register(IMP:XCS:BMMON, PGP0, EVR:XCS:BMMON, 0x1, 62)

Imp2Auto 0

# Load remaining record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "IOC=$(IOC_PV)" )

dbLoadRecords("db/imp2.db", "IOC=$(IOC_PV),BASE=IMP:XCS:BMMON,BOX=PGP0,EVR=EVR:XCS:BMMON,TRIG=1,DATALNK=")
dbLoadRecords("db/evrDevInfo.db", "BASE=IMP:XCS:BMMON,EVR=EVR:XCS:BMMON,TRIG=1,NAME=IMP:XCS:BMMON")
dbLoadRecords("db/bldSettings.db", "BLD=$(IOC_PV):B0,BLDNO=0" )


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

ImpStartAll()
BldSetID(0)
# Datatype is Id_BeamMonitorBldData (98), Version 0.
BldConfig( "239.255.24.62", 10148, 1512, 0, 62, 98, "IMP:XCS:BMMON:CURRENTFID", "IMP:XCS:BMMON:_Y_Position", "IMP:XCS:BMMON:CURRENTFID","IMP:XCS:BMMON:_TotalIntensity,IMP:XCS:BMMON:_X_Position,IMP:XCS:BMMON:_Y_Position,IMP:XCS:BMMON:_peakA_0,IMP:XCS:BMMON:_peakA_1,IMP:XCS:BMMON:_peakA_2,IMP:XCS:BMMON:_peakA_3,IMP:XCS:BMMON:_peakA_4,IMP:XCS:BMMON:_peakA_5,IMP:XCS:BMMON:_peakA_6,IMP:XCS:BMMON:_peakA_7,IMP:XCS:BMMON:_peakA_8,IMP:XCS:BMMON:_peakA_9,IMP:XCS:BMMON:_peakA_10,IMP:XCS:BMMON:_peakA_11,IMP:XCS:BMMON:_peakA_12,IMP:XCS:BMMON:_peakA_13,IMP:XCS:BMMON:_peakA_14,IMP:XCS:BMMON:_peakA_15,IMP:XCS:BMMON:_peakT_0,IMP:XCS:BMMON:_peakT_1,IMP:XCS:BMMON:_peakT_2,IMP:XCS:BMMON:_peakT_3,IMP:XCS:BMMON:_peakT_4,IMP:XCS:BMMON:_peakT_5,IMP:XCS:BMMON:_peakT_6,IMP:XCS:BMMON:_peakT_7,IMP:XCS:BMMON:_peakT_8,IMP:XCS:BMMON:_peakT_9,IMP:XCS:BMMON:_peakT_10,IMP:XCS:BMMON:_peakT_11,IMP:XCS:BMMON:_peakT_12,IMP:XCS:BMMON:_peakT_13,IMP:XCS:BMMON:_peakT_14,IMP:XCS:BMMON:_peakT_15" )
BldSetDebugLevel(1)
# Uncomment the next line for BLD generation.
BldStart()
BldShowConfig()

# Configure the IMPs.
dbpf IMP:XCS:BMMON:DO_CONFIG.PROC 1

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
