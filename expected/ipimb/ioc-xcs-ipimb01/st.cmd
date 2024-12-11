#!/reg/g/pcds/package/epics/3.14/ioc/common/ipimb/R3.1.6/bin/linux-x86_64/ipimbIoc

epicsEnvSet("IOCNAME", "ioc-xcs-ipimb01" )
epicsEnvSet("ENGINEER", "Daniel Damiani (ddamiani)" )
epicsEnvSet("LOCATION", "IOC:XCS:IPM" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "IOC:XCS:IPM")
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
dbLoadRecords( $(EVRDB_SLAC), "IOC=IOC:XCS:IPM,EVR=XCS:R44:EVR:01,CARD=0,IP2E=Enabled,IP2E=Enabled,IP2E=Enabled,IP2E=Enabled,IP2E=Enabled,IP2E=Enabled" )


# Datatype is Id_SharedIpimb (35), Version 1, so 65536+35 = 65571
ipimbAdd("XCS-SB1-IMB-02", "/dev/ttyPS0", "239.255.24.54", 54, 35, XCS:R44:EVR:01:Triggers.C, 0, XCS:SB1:IMB:02:DATA_DELAY, XCS:SB1:IMB:02:SYNC)
ipimbAdd("XCS-SB2-IMB-01", "/dev/ttyPS1", "239.255.24.55", 55, 35, XCS:R44:EVR:01:Triggers.C, 0, XCS:SB2:IMB:01:DATA_DELAY, XCS:SB2:IMB:01:SYNC)
ipimbAdd("XCS-SB2-IMB-02", "/dev/ttyPS2", "239.255.24.56", 56, 35, XCS:R44:EVR:01:Triggers.C, 0, XCS:SB2:IMB:02:DATA_DELAY, XCS:SB2:IMB:02:SYNC)
ipimbAdd("XCS-SB1-IMB-01", "/dev/ttyPS3", "239.255.24.53", 53, 35, XCS:R44:EVR:01:Triggers.C, 0, XCS:SB1:IMB:01:DATA_DELAY, XCS:SB1:IMB:01:SYNC)
ipimbAdd("XCS-LAM-IMB-01", "/dev/ttyPS4", "239.255.24.49", 49, 35, XCS:R44:EVR:01:Triggers.C, 0, XCS:LAM:IMB:01:DATA_DELAY, XCS:LAM:IMB:01:SYNC)
ipimbAdd("XCS-LAM-IMB-02", "/dev/ttyPS5", "239.255.24.58", 58, 35, XCS:R44:EVR:01:Triggers.C, 0, XCS:LAM:IMB:02:DATA_DELAY, XCS:LAM:IMB:02:SYNC)

# Load remaining record instances
dbLoadRecords( "db/ipimb_iocAdmin.db", "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "IOC=$(IOC_PV)" )

dbLoadRecords( "db/bldSettings.db", "BLD=$(IOC_PV):B0,BLDNO=0" )
dbLoadRecords( "db/bldSettings.db", "BLD=$(IOC_PV):B1,BLDNO=1" )
dbLoadRecords( "db/bldSettings.db", "BLD=$(IOC_PV):B2,BLDNO=2" )
dbLoadRecords( "db/bldSettings.db", "BLD=$(IOC_PV):B3,BLDNO=3" )
dbLoadRecords( "db/bldSettings.db", "BLD=$(IOC_PV):B4,BLDNO=4" )
dbLoadRecords( "db/bldSettings.db", "BLD=$(IOC_PV):B5,BLDNO=5" )

dbLoadRecords( "db/ipimb.db", "RECNAME=XCS:SB1:IMB:02,BOX=XCS-SB1-IMB-02,EVR=XCS:R44:EVR:01,TRIG=2,FLNK=")
dbLoadRecords("db/evrDevInfo.db", "BASE=XCS:SB1:IMB:02,EVR=XCS:R44:EVR:01,TRIG=2,NAME=XCS:SB1:IMB:02")
dbLoadRecords( "db/ipimb.db", "RECNAME=XCS:SB2:IMB:01,BOX=XCS-SB2-IMB-01,EVR=XCS:R44:EVR:01,TRIG=2,FLNK=")
dbLoadRecords("db/evrDevInfo.db", "BASE=XCS:SB2:IMB:01,EVR=XCS:R44:EVR:01,TRIG=2,NAME=XCS:SB2:IMB:01")
dbLoadRecords( "db/ipimb.db", "RECNAME=XCS:SB2:IMB:02,BOX=XCS-SB2-IMB-02,EVR=XCS:R44:EVR:01,TRIG=2,FLNK=")
dbLoadRecords("db/evrDevInfo.db", "BASE=XCS:SB2:IMB:02,EVR=XCS:R44:EVR:01,TRIG=2,NAME=XCS:SB2:IMB:02")
dbLoadRecords( "db/ipimb.db", "RECNAME=XCS:SB1:IMB:01,BOX=XCS-SB1-IMB-01,EVR=XCS:R44:EVR:01,TRIG=2,FLNK=")
dbLoadRecords("db/evrDevInfo.db", "BASE=XCS:SB1:IMB:01,EVR=XCS:R44:EVR:01,TRIG=2,NAME=XCS:SB1:IMB:01")
dbLoadRecords( "db/ipimb.db", "RECNAME=XCS:LAM:IMB:01,BOX=XCS-LAM-IMB-01,EVR=XCS:R44:EVR:01,TRIG=2,FLNK=")
dbLoadRecords("db/evrDevInfo.db", "BASE=XCS:LAM:IMB:01,EVR=XCS:R44:EVR:01,TRIG=2,NAME=XCS:LAM:IMB:01")
dbLoadRecords( "db/ipimb.db", "RECNAME=XCS:LAM:IMB:02,BOX=XCS-LAM-IMB-02,EVR=XCS:R44:EVR:01,TRIG=2,FLNK=")
dbLoadRecords("db/evrDevInfo.db", "BASE=XCS:LAM:IMB:02,EVR=XCS:R44:EVR:01,TRIG=2,NAME=XCS:LAM:IMB:02")

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
BldConfig( "239.255.24.54", 10148, 512, 0, 54, 65571, "XCS:SB1:IMB:02:CURRENTFID", "XCS:SB1:IMB:02:YPOS", "XCS:SB1:IMB:02:CURRENTFID", "XCS:SB1:IMB:02:CH0_RAW.INP,XCS:SB1:IMB:02:CH0,XCS:SB1:IMB:02:CH1,XCS:SB1:IMB:02:CH2,XCS:SB1:IMB:02:CH3,XCS:SB1:IMB:02:SUM,XCS:SB1:IMB:02:XPOS,XCS:SB1:IMB:02:YPOS" )
BldSetDebugLevel(1)
# Uncomment the next line for BLD generation.
BldStart()
BldShowConfig()

BldSetID(1)
BldConfig( "239.255.24.55", 10148, 512, 0, 55, 65571, "XCS:SB2:IMB:01:CURRENTFID", "XCS:SB2:IMB:01:YPOS", "XCS:SB2:IMB:01:CURRENTFID", "XCS:SB2:IMB:01:CH0_RAW.INP,XCS:SB2:IMB:01:CH0,XCS:SB2:IMB:01:CH1,XCS:SB2:IMB:01:CH2,XCS:SB2:IMB:01:CH3,XCS:SB2:IMB:01:SUM,XCS:SB2:IMB:01:XPOS,XCS:SB2:IMB:01:YPOS" )
BldSetDebugLevel(1)
# Uncomment the next line for BLD generation.
BldStart()
BldShowConfig()

BldSetID(2)
BldConfig( "239.255.24.56", 10148, 512, 0, 56, 65571, "XCS:SB2:IMB:02:CURRENTFID", "XCS:SB2:IMB:02:YPOS", "XCS:SB2:IMB:02:CURRENTFID", "XCS:SB2:IMB:02:CH0_RAW.INP,XCS:SB2:IMB:02:CH0,XCS:SB2:IMB:02:CH1,XCS:SB2:IMB:02:CH2,XCS:SB2:IMB:02:CH3,XCS:SB2:IMB:02:SUM,XCS:SB2:IMB:02:XPOS,XCS:SB2:IMB:02:YPOS" )
BldSetDebugLevel(1)
# Uncomment the next line for BLD generation.
BldStart()
BldShowConfig()

BldSetID(3)
BldConfig( "239.255.24.53", 10148, 512, 0, 53, 65571, "XCS:SB1:IMB:01:CURRENTFID", "XCS:SB1:IMB:01:YPOS", "XCS:SB1:IMB:01:CURRENTFID", "XCS:SB1:IMB:01:CH0_RAW.INP,XCS:SB1:IMB:01:CH0,XCS:SB1:IMB:01:CH1,XCS:SB1:IMB:01:CH2,XCS:SB1:IMB:01:CH3,XCS:SB1:IMB:01:SUM,XCS:SB1:IMB:01:XPOS,XCS:SB1:IMB:01:YPOS" )
BldSetDebugLevel(1)
# Uncomment the next line for BLD generation.
BldStart()
BldShowConfig()

BldSetID(4)
BldConfig( "239.255.24.49", 10148, 512, 0, 49, 65571, "XCS:LAM:IMB:01:CURRENTFID", "XCS:LAM:IMB:01:YPOS", "XCS:LAM:IMB:01:CURRENTFID", "XCS:LAM:IMB:01:CH0_RAW.INP,XCS:LAM:IMB:01:CH0,XCS:LAM:IMB:01:CH1,XCS:LAM:IMB:01:CH2,XCS:LAM:IMB:01:CH3,XCS:LAM:IMB:01:SUM,XCS:LAM:IMB:01:XPOS,XCS:LAM:IMB:01:YPOS" )
BldSetDebugLevel(1)
# Uncomment the next line for BLD generation.
BldStart()
BldShowConfig()

BldSetID(5)
BldConfig( "239.255.24.58", 10148, 512, 0, 58, 65571, "XCS:LAM:IMB:02:CURRENTFID", "XCS:LAM:IMB:02:YPOS", "XCS:LAM:IMB:02:CURRENTFID", "XCS:LAM:IMB:02:CH0_RAW.INP,XCS:LAM:IMB:02:CH0,XCS:LAM:IMB:02:CH1,XCS:LAM:IMB:02:CH2,XCS:LAM:IMB:02:CH3,XCS:LAM:IMB:02:SUM,XCS:LAM:IMB:02:XPOS,XCS:LAM:IMB:02:YPOS" )
BldSetDebugLevel(1)
# Uncomment the next line for BLD generation.
BldStart()
BldShowConfig()


# Configure the IPIMBs.
dbpf XCS:SB1:IMB:02:DoConfig 1
dbpf XCS:SB2:IMB:01:DoConfig 1
dbpf XCS:SB2:IMB:02:DoConfig 1
dbpf XCS:SB1:IMB:01:DoConfig 1
dbpf XCS:LAM:IMB:01:DoConfig 1
dbpf XCS:LAM:IMB:02:DoConfig 1

# Fix up the EVR descriptions!
dbpf XCS:R44:EVR:01:FP2L.DESC "XCS-HUTCH-IPM"

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
