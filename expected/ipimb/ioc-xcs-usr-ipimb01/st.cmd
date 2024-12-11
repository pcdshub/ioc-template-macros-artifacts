#!/reg/g/pcds/package/epics/3.14/ioc/common/ipimb/R3.1.6/bin/linux-x86_64/ipimbIoc

epicsEnvSet("IOCNAME", "ioc-xcs-usr-ipimb01" )
epicsEnvSet("ENGINEER", "Daniel Damiani (ddamiani)" )
epicsEnvSet("LOCATION", "IOC:XCS:USR:IPM" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "IOC:XCS:USR:IPM")
epicsEnvSet("EVRID_PMC",  "1")
epicsEnvSet("EVRID_SLAC", "15")
epicsEnvSet("EVRDB_PMC",  "db/evrPmc230.db")
epicsEnvSet("EVRDB_SLAC", "db/evrSLAC.db")
epicsEnvSet("IOCTOP", "/reg/g/pcds/package/epics/3.14/ioc/common/ipimb/R3.1.6")
< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/package/epics/3.14/ioc/xcs/ipimb/R4.1.5/build")
cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/ipimbIoc.dbd")
ipimbIoc_registerRecordDeviceDriver(pdbbase)

ErDebugLevel( 0 )

# Initialize EVR
ErConfigure( 0, 0, 0, 0, $(EVRID_SLAC) )

# Load EVR record instances
dbLoadRecords( $(EVRDB_SLAC), "IOC=IOC:XCS:USR:IPM,EVR=XCS:R42:EVR:01,CARD=0,IPAE=Enabled,IPAE=Enabled,IPAE=Enabled,IPAE=Enabled,IP0E=Enabled,IP1E=Enabled,IP2E=Enabled,IP4E=Enabled,IP5E=Enabled,IP6E=Enabled,IP7E=Enabled,IPBE=Enabled" )


# Datatype is Id_SharedIpimb (35), Version 1, so 65536+35 = 65571
ipimbAdd("XCS-USR-IMB-01", "/dev/ttyPS0", "239.255.24.57", 57, 35, XCS:R42:EVR:01:Triggers.K, 0, XCS:USR:IMB:01:DATA_DELAY, XCS:USR:IMB:01:SYNC)
ipimbAdd("XCS-USR-IMB-02", "/dev/ttyPS1", "239.255.24.50", 50, 35, XCS:R42:EVR:01:Triggers.K, 0, XCS:USR:IMB:02:DATA_DELAY, XCS:USR:IMB:02:SYNC)
ipimbAdd("XCS-USR-IMB-03", "/dev/ttyPS2", "239.255.24.51", 51, 35, XCS:R42:EVR:01:Triggers.K, 0, XCS:USR:IMB:03:DATA_DELAY, XCS:USR:IMB:03:SYNC)
ipimbAdd("XCS-USR-IMB-04", "/dev/ttyPS3", "239.255.24.52", 52, 35, XCS:R42:EVR:01:Triggers.K, 0, XCS:USR:IMB:04:DATA_DELAY, XCS:USR:IMB:04:SYNC)

# Load remaining record instances
dbLoadRecords( "db/ipimb_iocAdmin.db", "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "IOC=$(IOC_PV)" )

dbLoadRecords( "db/bldSettings.db", "BLD=$(IOC_PV):B0,BLDNO=0" )
dbLoadRecords( "db/bldSettings.db", "BLD=$(IOC_PV):B1,BLDNO=1" )
dbLoadRecords( "db/bldSettings.db", "BLD=$(IOC_PV):B2,BLDNO=2" )
dbLoadRecords( "db/bldSettings.db", "BLD=$(IOC_PV):B3,BLDNO=3" )

dbLoadRecords( "db/ipimb.db", "RECNAME=XCS:USR:IMB:01,BOX=XCS-USR-IMB-01,EVR=XCS:R42:EVR:01,TRIG=A,FLNK=")
dbLoadRecords("db/evrDevInfo.db", "BASE=XCS:USR:IMB:01,EVR=XCS:R42:EVR:01,TRIG=A,NAME=XCS:USR:IMB:01")
dbLoadRecords( "db/ipimb.db", "RECNAME=XCS:USR:IMB:02,BOX=XCS-USR-IMB-02,EVR=XCS:R42:EVR:01,TRIG=A,FLNK=")
dbLoadRecords("db/evrDevInfo.db", "BASE=XCS:USR:IMB:02,EVR=XCS:R42:EVR:01,TRIG=A,NAME=XCS:USR:IMB:02")
dbLoadRecords( "db/ipimb.db", "RECNAME=XCS:USR:IMB:03,BOX=XCS-USR-IMB-03,EVR=XCS:R42:EVR:01,TRIG=A,FLNK=")
dbLoadRecords("db/evrDevInfo.db", "BASE=XCS:USR:IMB:03,EVR=XCS:R42:EVR:01,TRIG=A,NAME=XCS:USR:IMB:03")
dbLoadRecords( "db/ipimb.db", "RECNAME=XCS:USR:IMB:04,BOX=XCS-USR-IMB-04,EVR=XCS:R42:EVR:01,TRIG=A,FLNK=")
dbLoadRecords("db/evrDevInfo.db", "BASE=XCS:USR:IMB:04,EVR=XCS:R42:EVR:01,TRIG=A,NAME=XCS:USR:IMB:04")

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

ipimbStart()

BldSetID(0)
BldConfig( "239.255.24.57", 10148, 512, 0, 57, 65571, "XCS:USR:IMB:01:CURRENTFID", "XCS:USR:IMB:01:YPOS", "XCS:USR:IMB:01:CURRENTFID", "XCS:USR:IMB:01:CH0_RAW.INP,XCS:USR:IMB:01:CH0,XCS:USR:IMB:01:CH1,XCS:USR:IMB:01:CH2,XCS:USR:IMB:01:CH3,XCS:USR:IMB:01:SUM,XCS:USR:IMB:01:XPOS,XCS:USR:IMB:01:YPOS" )
BldSetDebugLevel(1)
# Uncomment the next line for BLD generation.
BldStart()
BldShowConfig()

BldSetID(1)
BldConfig( "239.255.24.50", 10148, 512, 0, 50, 65571, "XCS:USR:IMB:02:CURRENTFID", "XCS:USR:IMB:02:YPOS", "XCS:USR:IMB:02:CURRENTFID", "XCS:USR:IMB:02:CH0_RAW.INP,XCS:USR:IMB:02:CH0,XCS:USR:IMB:02:CH1,XCS:USR:IMB:02:CH2,XCS:USR:IMB:02:CH3,XCS:USR:IMB:02:SUM,XCS:USR:IMB:02:XPOS,XCS:USR:IMB:02:YPOS" )
BldSetDebugLevel(1)
# Uncomment the next line for BLD generation.
BldStart()
BldShowConfig()

BldSetID(2)
BldConfig( "239.255.24.51", 10148, 512, 0, 51, 65571, "XCS:USR:IMB:03:CURRENTFID", "XCS:USR:IMB:03:YPOS", "XCS:USR:IMB:03:CURRENTFID", "XCS:USR:IMB:03:CH0_RAW.INP,XCS:USR:IMB:03:CH0,XCS:USR:IMB:03:CH1,XCS:USR:IMB:03:CH2,XCS:USR:IMB:03:CH3,XCS:USR:IMB:03:SUM,XCS:USR:IMB:03:XPOS,XCS:USR:IMB:03:YPOS" )
BldSetDebugLevel(1)
# Uncomment the next line for BLD generation.
BldStart()
BldShowConfig()

BldSetID(3)
BldConfig( "239.255.24.52", 10148, 512, 0, 52, 65571, "XCS:USR:IMB:04:CURRENTFID", "XCS:USR:IMB:04:YPOS", "XCS:USR:IMB:04:CURRENTFID", "XCS:USR:IMB:04:CH0_RAW.INP,XCS:USR:IMB:04:CH0,XCS:USR:IMB:04:CH1,XCS:USR:IMB:04:CH2,XCS:USR:IMB:04:CH3,XCS:USR:IMB:04:SUM,XCS:USR:IMB:04:XPOS,XCS:USR:IMB:04:YPOS" )
BldSetDebugLevel(1)
# Uncomment the next line for BLD generation.
BldStart()
BldShowConfig()


# Configure the IPIMBs.
dbpf XCS:USR:IMB:01:DoConfig 1
dbpf XCS:USR:IMB:02:DoConfig 1
dbpf XCS:USR:IMB:03:DoConfig 1
dbpf XCS:USR:IMB:04:DoConfig 1

# Fix up the EVR descriptions!
dbpf XCS:R42:EVR:01:FP0L.DESC "XCS-USR-GIGE-01"
dbpf XCS:R42:EVR:01:FP1L.DESC "XCS-USR-GIGE-02"
dbpf XCS:R42:EVR:01:FP2L.DESC "XCS-USR-GIGE-03"
dbpf XCS:R42:EVR:01:FP3L.DESC "XCS-USR-GIGE-04"
dbpf XCS:R42:EVR:01:FP4L.DESC "XCS-USR-EPICS-01"
dbpf XCS:R42:EVR:01:FP5L.DESC "XCS-USR-EPICS-02"
dbpf XCS:R42:EVR:01:FP6L.DESC "XCS-USR-EPICS-03"
dbpf XCS:R42:EVR:01:FP7L.DESC "XCS-USR-EPICS-04"
dbpf XCS:R42:EVR:01:FP8L.DESC "XCS-USR-CVV-01"
dbpf XCS:R42:EVR:01:FP9L.DESC "XCS-USR-CVV-02"
dbpf XCS:R42:EVR:01:FPAL.DESC "XCS-USR IPIMBs"
dbpf XCS:R42:EVR:01:FPBL.DESC "Fast Timing"

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
