#!/cds/group/pcds/epics/ioc/common/ipimb/R3.2.4/bin/rhel7-x86_64/ipimbIoc

epicsEnvSet("IOCNAME", "ioc-xpp-ipimb01" )
epicsEnvSet("ENGINEER", "Michael Browne (mcbrowne)" )
epicsEnvSet("LOCATION", "XPP:IPM:IOC" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "XPP:IPM:IOC")
epicsEnvSet("EVRID_PMC",  "1")
epicsEnvSet("EVRID_SLAC", "15")
epicsEnvSet("EVRDB_PMC",  "db/evrPmc230.db")
epicsEnvSet("EVRDB_SLAC", "db/evrSLAC.db")
epicsEnvSet("IOCTOP", "/cds/group/pcds/epics/ioc/common/ipimb/R3.2.4")
< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/xpp/ipimb/R4.1.7/build")
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
dbLoadRecords( $(EVRDB_SLAC), "IOC=XPP:IPM:IOC,EVR=XPP:IPM:EVR,CARD=0,IP0E=Enabled,IP1E=Enabled,IP2E=Enabled,IP3E=Enabled,IP4E=Enabled,IP5E=Enabled,IP6E=Enabled,IP7E=Enabled" )


# Datatype is Id_SharedIpimb (35), Version 1, so 65536+35 = 65571
ipimbAdd("XPP-MON-IPM-01", "/dev/ttyPS0", "239.255.24.34", 34, 35, XPP:IPM:EVR:Triggers.A, 0, XPP:MON:IPM:01:DATA_DELAY, XPP:MON:IPM:01:SYNC)
ipimbAdd("XPP-MON-IPM-02", "/dev/ttyPS1", "239.255.24.35", 35, 35, XPP:IPM:EVR:Triggers.B, 0, XPP:MON:IPM:02:DATA_DELAY, XPP:MON:IPM:02:SYNC)
ipimbAdd("XPP-SB2-IPM-01", "/dev/ttyPS2", "239.255.24.36", 36, 35, XPP:IPM:EVR:Triggers.C, 0, XPP:SB2:IPM:01:DATA_DELAY, XPP:SB2:IPM:01:SYNC)
ipimbAdd("XPP-SB3-IPM-01", "/dev/ttyPS3", "239.255.24.37", 37, 35, XPP:IPM:EVR:Triggers.D, 0, XPP:SB3:IPM:01:DATA_DELAY, XPP:SB3:IPM:01:SYNC)
ipimbAdd("XPP-SB3-IPM-02", "/dev/ttyPS4", "239.255.24.38", 38, 35, XPP:IPM:EVR:Triggers.E, 0, XPP:SB3:IPM:02:DATA_DELAY, XPP:SB3:IPM:02:SYNC)
ipimbAdd("XPP-SB4-IPM-01", "/dev/ttyPS5", "239.255.24.39", 39, 35, XPP:IPM:EVR:Triggers.F, 0, XPP:SB4:IPM:01:DATA_DELAY, XPP:SB4:IPM:01:SYNC)
ipimbAdd("XPP-USR-IPM-01", "/dev/ttyPS6", "239.255.24.40", 40, 35, XPP:IPM:EVR:Triggers.G, 0, XPP:USR:IPM:01:DATA_DELAY, XPP:USR:IPM:01:SYNC)
ipimbAdd("XPP-USR-IPM-02", "/dev/ttyPS7", "239.255.24.41", 41, 35, XPP:IPM:EVR:Triggers.H, 0, XPP:USR:IPM:02:DATA_DELAY, XPP:USR:IPM:02:SYNC)

# Load remaining record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "IOC=$(IOC_PV)" )

dbLoadRecords( "db/bldSettings.db", "BLD=$(IOC_PV):B0,BLDNO=0" )
dbLoadRecords( "db/bldSettings.db", "BLD=$(IOC_PV):B1,BLDNO=1" )
dbLoadRecords( "db/bldSettings.db", "BLD=$(IOC_PV):B2,BLDNO=2" )
dbLoadRecords( "db/bldSettings.db", "BLD=$(IOC_PV):B3,BLDNO=3" )
dbLoadRecords( "db/bldSettings.db", "BLD=$(IOC_PV):B4,BLDNO=4" )
dbLoadRecords( "db/bldSettings.db", "BLD=$(IOC_PV):B5,BLDNO=5" )
dbLoadRecords( "db/bldSettings.db", "BLD=$(IOC_PV):B6,BLDNO=6" )
dbLoadRecords( "db/bldSettings.db", "BLD=$(IOC_PV):B7,BLDNO=7" )

dbLoadRecords( "db/ipimb.db", "RECNAME=XPP:MON:IPM:01,BOX=XPP-MON-IPM-01,EVR=XPP:IPM:EVR,TRIG=0,FLNK=XPP:MON:IPM:01:BSAFANOUT")
dbLoadRecords("db/evrDevInfo.db", "BASE=XPP:MON:IPM:01,EVR=XPP:IPM:EVR,TRIG=0,NAME=XPP:MON:IPM:01")
dbLoadRecords("db/BSAfanout.db", "RECNAME=XPP:MON:IPM:01")

dbLoadRecords( "db/ipimb.db", "RECNAME=XPP:MON:IPM:02,BOX=XPP-MON-IPM-02,EVR=XPP:IPM:EVR,TRIG=1,FLNK=XPP:MON:IPM:02:BSAFANOUT")
dbLoadRecords("db/evrDevInfo.db", "BASE=XPP:MON:IPM:02,EVR=XPP:IPM:EVR,TRIG=1,NAME=XPP:MON:IPM:02")
dbLoadRecords("db/BSAfanout.db", "RECNAME=XPP:MON:IPM:02,L2=XPP:MON:IPM:02:EFSUM,L3=XPP:MON:IPM:02:EFCH0")

dbLoadRecords( "db/ipimbBSA.db", "RECNAME=XPP:MON:IPM:02,ATTR=SUM")
dbLoadRecords( "db/ipimbBSA.db", "RECNAME=XPP:MON:IPM:02,ATTR=CH0")
dbLoadRecords( "db/ipimb.db", "RECNAME=XPP:SB2:IPM:01,BOX=XPP-SB2-IPM-01,EVR=XPP:IPM:EVR,TRIG=2,FLNK=XPP:SB2:IPM:01:BSAFANOUT")
dbLoadRecords("db/evrDevInfo.db", "BASE=XPP:SB2:IPM:01,EVR=XPP:IPM:EVR,TRIG=2,NAME=XPP:SB2:IPM:01")
dbLoadRecords("db/BSAfanout.db", "RECNAME=XPP:SB2:IPM:01,L1=XPP:SB2:IPM:01:EFSUM")

dbLoadRecords( "db/ipimbBSA.db", "RECNAME=XPP:SB2:IPM:01,ATTR=SUM")
dbLoadRecords( "db/ipimb.db", "RECNAME=XPP:SB3:IPM:01,BOX=XPP-SB3-IPM-01,EVR=XPP:IPM:EVR,TRIG=3,FLNK=XPP:SB3:IPM:01:BSAFANOUT")
dbLoadRecords("db/evrDevInfo.db", "BASE=XPP:SB3:IPM:01,EVR=XPP:IPM:EVR,TRIG=3,NAME=XPP:SB3:IPM:01")
dbLoadRecords("db/BSAfanout.db", "RECNAME=XPP:SB3:IPM:01")

dbLoadRecords( "db/ipimb.db", "RECNAME=XPP:SB3:IPM:02,BOX=XPP-SB3-IPM-02,EVR=XPP:IPM:EVR,TRIG=4,FLNK=XPP:SB3:IPM:02:BSAFANOUT")
dbLoadRecords("db/evrDevInfo.db", "BASE=XPP:SB3:IPM:02,EVR=XPP:IPM:EVR,TRIG=4,NAME=XPP:SB3:IPM:02")
dbLoadRecords("db/BSAfanout.db", "RECNAME=XPP:SB3:IPM:02")

dbLoadRecords( "db/ipimb.db", "RECNAME=XPP:SB4:IPM:01,BOX=XPP-SB4-IPM-01,EVR=XPP:IPM:EVR,TRIG=5,FLNK=XPP:SB4:IPM:01:BSAFANOUT")
dbLoadRecords("db/evrDevInfo.db", "BASE=XPP:SB4:IPM:01,EVR=XPP:IPM:EVR,TRIG=5,NAME=XPP:SB4:IPM:01")
dbLoadRecords("db/BSAfanout.db", "RECNAME=XPP:SB4:IPM:01")

dbLoadRecords( "db/ipimb.db", "RECNAME=XPP:USR:IPM:01,BOX=XPP-USR-IPM-01,EVR=XPP:IPM:EVR,TRIG=6,FLNK=XPP:USR:IPM:01:BSAFANOUT")
dbLoadRecords("db/evrDevInfo.db", "BASE=XPP:USR:IPM:01,EVR=XPP:IPM:EVR,TRIG=6,NAME=XPP:USR:IPM:01")
dbLoadRecords("db/BSAfanout.db", "RECNAME=XPP:USR:IPM:01")

dbLoadRecords( "db/ipimb.db", "RECNAME=XPP:USR:IPM:02,BOX=XPP-USR-IPM-02,EVR=XPP:IPM:EVR,TRIG=7,FLNK=XPP:USR:IPM:02:BSAFANOUT")
dbLoadRecords("db/evrDevInfo.db", "BASE=XPP:USR:IPM:02,EVR=XPP:IPM:EVR,TRIG=7,NAME=XPP:USR:IPM:02")
dbLoadRecords("db/BSAfanout.db", "RECNAME=XPP:USR:IPM:02")


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
BldConfig( "239.255.24.34", 10148, 512, 0, 34, 65571, "XPP:MON:IPM:01:CURRENTFID", "XPP:MON:IPM:01:YPOS", "XPP:MON:IPM:01:CURRENTFID", "XPP:MON:IPM:01:CH0_RAW.INP,XPP:MON:IPM:01:CH0,XPP:MON:IPM:01:CH1,XPP:MON:IPM:01:CH2,XPP:MON:IPM:01:CH3,XPP:MON:IPM:01:SUM,XPP:MON:IPM:01:XPOS,XPP:MON:IPM:01:YPOS" )
BldSetDebugLevel(1)
# Uncomment the next line for BLD generation.
BldStart()
BldShowConfig()

BldSetID(1)
BldConfig( "239.255.24.35", 10148, 512, 0, 35, 65571, "XPP:MON:IPM:02:CURRENTFID", "XPP:MON:IPM:02:YPOS", "XPP:MON:IPM:02:CURRENTFID", "XPP:MON:IPM:02:CH0_RAW.INP,XPP:MON:IPM:02:CH0,XPP:MON:IPM:02:CH1,XPP:MON:IPM:02:CH2,XPP:MON:IPM:02:CH3,XPP:MON:IPM:02:SUM,XPP:MON:IPM:02:XPOS,XPP:MON:IPM:02:YPOS" )
BldSetDebugLevel(1)
# Uncomment the next line for BLD generation.
BldStart()
BldShowConfig()

BldSetID(2)
BldConfig( "239.255.24.36", 10148, 512, 0, 36, 65571, "XPP:SB2:IPM:01:CURRENTFID", "XPP:SB2:IPM:01:YPOS", "XPP:SB2:IPM:01:CURRENTFID", "XPP:SB2:IPM:01:CH0_RAW.INP,XPP:SB2:IPM:01:CH0,XPP:SB2:IPM:01:CH1,XPP:SB2:IPM:01:CH2,XPP:SB2:IPM:01:CH3,XPP:SB2:IPM:01:SUM,XPP:SB2:IPM:01:XPOS,XPP:SB2:IPM:01:YPOS" )
BldSetDebugLevel(1)
# Uncomment the next line for BLD generation.
BldStart()
BldShowConfig()

BldSetID(3)
BldConfig( "239.255.24.37", 10148, 512, 0, 37, 65571, "XPP:SB3:IPM:01:CURRENTFID", "XPP:SB3:IPM:01:YPOS", "XPP:SB3:IPM:01:CURRENTFID", "XPP:SB3:IPM:01:CH0_RAW.INP,XPP:SB3:IPM:01:CH0,XPP:SB3:IPM:01:CH1,XPP:SB3:IPM:01:CH2,XPP:SB3:IPM:01:CH3,XPP:SB3:IPM:01:SUM,XPP:SB3:IPM:01:XPOS,XPP:SB3:IPM:01:YPOS" )
BldSetDebugLevel(1)
# Uncomment the next line for BLD generation.
BldStart()
BldShowConfig()

BldSetID(4)
BldConfig( "239.255.24.38", 10148, 512, 0, 38, 65571, "XPP:SB3:IPM:02:CURRENTFID", "XPP:SB3:IPM:02:YPOS", "XPP:SB3:IPM:02:CURRENTFID", "XPP:SB3:IPM:02:CH0_RAW.INP,XPP:SB3:IPM:02:CH0,XPP:SB3:IPM:02:CH1,XPP:SB3:IPM:02:CH2,XPP:SB3:IPM:02:CH3,XPP:SB3:IPM:02:SUM,XPP:SB3:IPM:02:XPOS,XPP:SB3:IPM:02:YPOS" )
BldSetDebugLevel(1)
# Uncomment the next line for BLD generation.
BldStart()
BldShowConfig()

BldSetID(5)
BldConfig( "239.255.24.39", 10148, 512, 0, 39, 65571, "XPP:SB4:IPM:01:CURRENTFID", "XPP:SB4:IPM:01:YPOS", "XPP:SB4:IPM:01:CURRENTFID", "XPP:SB4:IPM:01:CH0_RAW.INP,XPP:SB4:IPM:01:CH0,XPP:SB4:IPM:01:CH1,XPP:SB4:IPM:01:CH2,XPP:SB4:IPM:01:CH3,XPP:SB4:IPM:01:SUM,XPP:SB4:IPM:01:XPOS,XPP:SB4:IPM:01:YPOS" )
BldSetDebugLevel(1)
# Uncomment the next line for BLD generation.
BldStart()
BldShowConfig()

BldSetID(6)
BldConfig( "239.255.24.40", 10148, 512, 0, 40, 65571, "XPP:USR:IPM:01:CURRENTFID", "XPP:USR:IPM:01:YPOS", "XPP:USR:IPM:01:CURRENTFID", "XPP:USR:IPM:01:CH0_RAW.INP,XPP:USR:IPM:01:CH0,XPP:USR:IPM:01:CH1,XPP:USR:IPM:01:CH2,XPP:USR:IPM:01:CH3,XPP:USR:IPM:01:SUM,XPP:USR:IPM:01:XPOS,XPP:USR:IPM:01:YPOS" )
BldSetDebugLevel(1)
# Uncomment the next line for BLD generation.
BldStart()
BldShowConfig()

BldSetID(7)
BldConfig( "239.255.24.41", 10148, 512, 0, 41, 65571, "XPP:USR:IPM:02:CURRENTFID", "XPP:USR:IPM:02:YPOS", "XPP:USR:IPM:02:CURRENTFID", "XPP:USR:IPM:02:CH0_RAW.INP,XPP:USR:IPM:02:CH0,XPP:USR:IPM:02:CH1,XPP:USR:IPM:02:CH2,XPP:USR:IPM:02:CH3,XPP:USR:IPM:02:SUM,XPP:USR:IPM:02:XPOS,XPP:USR:IPM:02:YPOS" )
BldSetDebugLevel(1)
# Uncomment the next line for BLD generation.
#BldStart()
BldShowConfig()


# Configure the IPIMBs.
dbpf XPP:MON:IPM:01:DoConfig 1
dbpf XPP:MON:IPM:02:DoConfig 1
dbpf XPP:SB2:IPM:01:DoConfig 1
dbpf XPP:SB3:IPM:01:DoConfig 1
dbpf XPP:SB3:IPM:02:DoConfig 1
dbpf XPP:SB4:IPM:01:DoConfig 1
dbpf XPP:USR:IPM:01:DoConfig 1
#dbpf XPP:USR:IPM:02:DoConfig 1

# Fix up the EVR descriptions!
dbpf XPP:IPM:EVR:FP0L.DESC "XPP-MON-IPM-01"
dbpf XPP:IPM:EVR:FP1L.DESC "XPP-MON-IPM-02"
dbpf XPP:IPM:EVR:FP2L.DESC "XPP-SB2-IPM-01"
dbpf XPP:IPM:EVR:FP3L.DESC "XPP-SB3-IPM-01"
dbpf XPP:IPM:EVR:FP4L.DESC "XPP-SB3-IPM-02"
dbpf XPP:IPM:EVR:FP5L.DESC "XPP-SB4-IPM-01"
dbpf XPP:IPM:EVR:FP6L.DESC "XPP-USR-IPM-01"
dbpf XPP:IPM:EVR:FP7L.DESC "XPP-USR-IPM-02"

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
