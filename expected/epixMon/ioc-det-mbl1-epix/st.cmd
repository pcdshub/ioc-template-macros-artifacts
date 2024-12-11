#!/reg/g/pcds/epics/ioc/common/epixMon/R1.4.2/bin/rhel7-x86_64/epixMonIoc

epicsEnvSet("IOCNAME", "ioc-det-mbl1-epix" )
epicsEnvSet("ENGINEER", "Daniel Damiani (ddamiani)" )
epicsEnvSet("LOCATION", "DET:MBL1:EPIX" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "IOC:DET:MBL1:EPIX")
epicsEnvSet("IOCTOP", "/reg/g/pcds/epics/ioc/common/epixMon/R1.4.2")

< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/common/epixMon/R1.4.2/children/build")
cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/epixMonIoc.dbd")
epixMonIoc_registerRecordDeviceDriver(pdbbase)

#var PGP_reg_debug 1

dbLoadRecords("db/epixMon_trigger.db", "BASE=DET:MBL1:EPIX:Q0")
dbLoadRecords("db/epixMon_trigger.db", "BASE=DET:MBL1:EPIX:Q1")
dbLoadRecords("db/epixMon_trigger.db", "BASE=DET:MBL1:EPIX:Q2")
dbLoadRecords("db/epixMon_trigger.db", "BASE=DET:MBL1:EPIX:Q3")

PgpRegister("PGP0", 0x10, 8, 0)
PgpRegister("PGP1", 0x11, 8, 0)
PgpRegister("PGP2", 0x21, 8, 0)
PgpRegister("PGP3", 0x40, 8, 0)

EpixMonRegister("DET:MBL1:EPIX:Q0", "PGP0", "DET:MBL1:EPIX:Q0:RUNNING")
EpixMonRegister("DET:MBL1:EPIX:Q1", "PGP1", "DET:MBL1:EPIX:Q1:RUNNING")
EpixMonRegister("DET:MBL1:EPIX:Q2", "PGP2", "DET:MBL1:EPIX:Q2:RUNNING")
EpixMonRegister("DET:MBL1:EPIX:Q3", "PGP3", "DET:MBL1:EPIX:Q3:RUNNING")

# Load remaining record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "IOC=$(IOC_PV),P=$(IOC_PV):" )

dbLoadRecords("db/epixQuadMon.db", "IOC=$(IOC_PV),BASE=DET:MBL1:EPIX:Q0,BOX=PGP0,MASK=16,SRPV3=1")
dbLoadRecords("db/epixQuadMon.db", "IOC=$(IOC_PV),BASE=DET:MBL1:EPIX:Q1,BOX=PGP1,MASK=17,SRPV3=1")
dbLoadRecords("db/epixQuadMon.db", "IOC=$(IOC_PV),BASE=DET:MBL1:EPIX:Q2,BOX=PGP2,MASK=33,SRPV3=1")
dbLoadRecords("db/epixQuadMon.db", "IOC=$(IOC_PV),BASE=DET:MBL1:EPIX:Q3,BOX=PGP3,MASK=64,SRPV3=1")

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