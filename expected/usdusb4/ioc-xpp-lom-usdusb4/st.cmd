#!/reg/g/pcds/epics/ioc/common/usdusb4/R1.0.7/bin/rhel7-x86_64/usdusb4

< envPaths
epicsEnvSet("IOCNAME", "ioc-xpp-lom-usdusb4" )
epicsEnvSet("ENGINEER", "Silke Nelson (snelson)" )
epicsEnvSet("LOCATION", "XPP:LOM:USDUSB4" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "IOC:XPP:LOM:USDUSB4")
epicsEnvSet("EVRID_PMC",  "1")
epicsEnvSet("EVRID_SLAC", "15")
epicsEnvSet("EVRDB_PMC",  "db/evrPmc230.db")
epicsEnvSet("EVRDB_SLAC", "db/evrSLAC.db")
epicsEnvSet("IOCTOP", "/reg/g/pcds/epics/ioc/common/usdusb4/R1.0.7")
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/common/usdusb4/R1.0.7/children/build")

cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd
# Register all support components
dbLoadDatabase("dbd/usdusb4.dbd")
usdusb4_registerRecordDeviceDriver(pdbbase)

ErDebugLevel( 0 )

###########################
# initialize all hardware #
###########################

# Initialize EVR
ErConfigure(0, 0, 0, 0, $(EVRID_SLAC))

# Load EVR record instances
dbLoadRecords($(EVRDB_SLAC), "IOC=IOC:XPP:LOM:USDUSB4,EVR=EVR:XPP:LOM:USDUSB4,CARD=0,IP4E=Enabled")

dbLoadRecords("db/USDUSB4delay.db", "BASE=XPP:LOM:USDUSB4:01,EVR=EVR:XPP:LOM:USDUSB4,TRIGGER=4")
dbLoadRecords("db/evrDevInfo.db", "BASE=XPP:LOM:USDUSB4:01,EVR=EVR:XPP:LOM:USDUSB4,TRIG=4,NAME=XPP:LOM:USDUSB4:01")

usdusb4Create("XPP:LOM:USDUSB4:01", 0, "EVR:XPP:LOM:USDUSB4:Triggers.E", "XPP:LOM:USDUSB4:01:TRIGGER_DELAY", "XPP:LOM:USDUSB4:01:SYNC", 69)

# Load record instances
dbLoadRecords("db/USDUSB4.db", "BASE=XPP:LOM:USDUSB4:01,CARD=0")

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

# Configure the BLD client
BldConfigSend( "239.255.24.69", 10148, 8000 )
BldStart()
BldIsStarted()

# Initialize the IOC and start processing records
iocInit()

# Start the USDUSB4 processing.
usdusb4Start(1)

# Start autosave backups
create_monitor_set( "$(IOCNAME).req", 5, "IOC=$(IOC_PV)" )

# Fix up the EVR descriptions!

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
