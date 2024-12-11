#!$$IOCTOP/bin/$$IF(ARCH,$$ARCH,rhel7-x86_64)/usdusb4

< envPaths
epicsEnvSet("IOCNAME", "$$IOCNAME" )
epicsEnvSet("ENGINEER", "$$ENGINEER" )
epicsEnvSet("LOCATION", "$$LOCATION" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "$$IOC_PV")
epicsEnvSet("EVRID_PMC",  "1")
epicsEnvSet("EVRID_SLAC", "15")
epicsEnvSet("EVRDB_PMC",  "db/evrPmc230.db")
epicsEnvSet("EVRDB_SLAC", "db/evrSLAC.db")
epicsEnvSet("IOCTOP", "$$IOCTOP")
epicsEnvSet("TOP", "$$TOP")

cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd
# Register all support components
dbLoadDatabase("dbd/usdusb4.dbd")
usdusb4_registerRecordDeviceDriver(pdbbase)

$$LOOP(EVR)
ErDebugLevel( 0 )
$$ENDLOOP(EVR)

###########################
# initialize all hardware #
###########################

$$LOOP(EVR)
# Initialize EVR
ErConfigure($$IF(CARD,$$CARD,$$INDEX), 0, 0, 0, $(EVRID_$$TYPE))

# Load EVR record instances
dbLoadRecords($(EVRDB_$$TYPE), "IOC=$$(IOC_PV),EVR=$$(NAME),CARD=$$IF(CARD,$$CARD,$$INDEX)$$LOOP(USDUSB4),IP$$(TRIG)E=Enabled$$ENDLOOP(USDUSB4)$$LOOP(USETRIG),IP$$(TRIG)E=Enabled$$ENDLOOP(USETRIG)")
$$ENDLOOP(EVR)

$$LOOP(USDUSB4)
dbLoadRecords("db/USDUSB4delay.db", "BASE=$$NAME:$$CALC{INDEX+1,%02d},EVR=$$EVRNAME,TRIGGER=$$TRIG")
dbLoadRecords("db/evrDevInfo.db", "BASE=$$NAME:$$CALC{INDEX+1,%02d},EVR=$$EVRNAME,TRIG=$$TRIG,NAME=$$NAME:$$CALC{INDEX+1,%02d}")

usdusb4Create("$$NAME:$$CALC{INDEX+1,%02d}", $$INDEX, "$$EVRNAME:Triggers.$$TRANSLATE(TRIG,"0123456789AB","ABCDEFGHIJKL")", "$$NAME:$$CALC{INDEX+1,%02d}:TRIGGER_DELAY", "$$NAME:$$CALC{INDEX+1,%02d}:SYNC", $$IF(BLDID,$$BLDID,255))

# Load record instances
dbLoadRecords("db/USDUSB4.db", "BASE=$$NAME:$$CALC{INDEX+1,%02d},CARD=$$INDEX")
$$ENDLOOP(USDUSB4)

dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)")
dbLoadRecords( "db/save_restoreStatus.db", "IOC=$(IOC_PV),P=$(IOC_PV):")

# Setup autosave
set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(TOP)/autosave" )
save_restoreSet_status_prefix( "$(IOC_PV):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )
set_pass0_restoreFile( "$(IOCNAME).sav" )
set_pass1_restoreFile( "$(IOCNAME).sav" )

$$LOOP(USDUSB4)
$$IF(BLDID)
# Configure the BLD client
BldConfigSend( "239.255.24.$$BLDID", 10148, 8000 )
$$(NOBLD)BldStart()
BldIsStarted()
$$ENDIF(BLDID)
$$ENDLOOP(USDUSB4)

# Initialize the IOC and start processing records
iocInit()

# Start the USDUSB4 processing.
usdusb4Start(1)

# Start autosave backups
create_monitor_set( "$(IOCNAME).req", 5, "IOC=$(IOC_PV)" )

# Fix up the EVR descriptions!
$$LOOP(TRIGGER)
dbpf $$EVRNAME:FP$$(TRIG)L.DESC "$$NAME"
$$ENDLOOP(TRIGGER)

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
