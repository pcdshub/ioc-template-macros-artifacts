#!$$IOCTOP/bin/$$IF(ARCH,$$ARCH,linux-x86_64)/epixMonIoc

epicsEnvSet("IOCNAME", "$$IOCNAME" )
epicsEnvSet("ENGINEER", "$$ENGINEER" )
epicsEnvSet("LOCATION", "$$LOCATION" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "$$IOC_PV")
epicsEnvSet("IOCTOP", "$$IOCTOP")

< envPaths
epicsEnvSet("TOP", "$$TOP")
cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/epixMonIoc.dbd")
epixMonIoc_registerRecordDeviceDriver(pdbbase)

#var PGP_reg_debug 1

$$LOOP(EPIXMON)
dbLoadRecords("db/epixMon_trigger.db", "BASE=$$NAME")
$$ENDLOOP(EPIXMON)
$$LOOP(EPIXHRMON)
dbLoadRecords("db/epixMon_trigger.db", "BASE=$$NAME")
$$ENDLOOP(EPIXHRMON)
$$LOOP(EPIXQUADMON)
dbLoadRecords("db/epixMon_trigger.db", "BASE=$$NAME")
$$ENDLOOP(EPIXQUADMON)

$$LOOP(PGP)
PgpRegister("$$BOX", $$MASK, 8, $$IF(SRPV3,$$SRPV3,0))
$$ENDLOOP(PGP)

$$LOOP(EPIXMON)
EpixMonRegister("$$NAME", "$$PGPBOX", "$$NAME:RUNNING")
$$ENDLOOP(EPIXMON)
$$LOOP(EPIXHRMON)
EpixMonRegister("$$NAME", "$$PGPBOX", "$$NAME:RUNNING")
$$ENDLOOP(EPIXHRMON)
$$LOOP(EPIXQUADMON)
EpixMonRegister("$$NAME", "$$PGPBOX", "$$NAME:RUNNING")
$$ENDLOOP(EPIXQUADMON)

# Load remaining record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "IOC=$(IOC_PV),P=$(IOC_PV):" )

$$LOOP(EPIXMON)
dbLoadRecords("db/epixMon.db", "IOC=$(IOC_PV),BASE=$$NAME,BOX=$$PGPBOX,MASK=$$CALC{PGPMASK},SRPV3=$$IF(SRPV3,$$SRPV3,0)")
$$ENDLOOP(EPIXMON)
$$LOOP(EPIXHRMON)
dbLoadRecords("db/epixHrMon.db", "IOC=$(IOC_PV),BASE=$$NAME,BOX=$$PGPBOX,MASK=$$CALC{PGPMASK},SRPV3=$$IF(SRPV3,$$SRPV3,1)")
$$ENDLOOP(EPIXHRMON)
$$LOOP(EPIXQUADMON)
dbLoadRecords("db/epixQuadMon.db", "IOC=$(IOC_PV),BASE=$$NAME,BOX=$$PGPBOX,MASK=$$CALC{PGPMASK},SRPV3=$$IF(SRPV3,$$SRPV3,1)")
$$ENDLOOP(EPIXQUADMON)

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
