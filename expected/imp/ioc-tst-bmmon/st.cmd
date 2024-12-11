#!/reg/g/pcds/package/epics/3.14/ioc/common/imp/R1.0.7/bin/linux-x86_64/impIoc

epicsEnvSet("IOCNAME", "ioc-tst-bmmon" )
epicsEnvSet("ENGINEER", "Michael Browne (mcbrowne)" )
epicsEnvSet("LOCATION", "unknown" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "IOC:TST:BMMON")
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
dbLoadRecords( $(EVRDB_SLAC), "IOC=IOC:TST:BMMON,EVR=EVR:TST:BMMON,CARD=0,IP0E=Enabled,IP1E=Enabled" )

PgpRegister(PGP0, 0x10)

Imp2Register(IMP:TST:BMMON, PGP0, EVR:TST:BMMON, 0x0, 255)

Imp2Auto 0

# Load remaining record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "IOC=$(IOC_PV)" )

dbLoadRecords("db/imp2.db", "IOC=$(IOC_PV),BASE=IMP:TST:BMMON,BOX=PGP0,EVR=EVR:TST:BMMON,TRIG=0,DATALNK=")
dbLoadRecords("db/evrDevInfo.db", "BASE=IMP:TST:BMMON,EVR=EVR:TST:BMMON,TRIG=0,NAME=IMP:TST:BMMON")


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

# Configure the IMPs.
dbpf IMP:TST:BMMON:DO_CONFIG.PROC 1

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
