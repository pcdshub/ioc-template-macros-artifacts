#!/reg/g/pcds/epics/ioc/common/ipimb/R3.2.3/bin/rhel7-x86_64/ipimbIoc

epicsEnvSet("IOCNAME", "ioc-xrt-xcsimb3" )
epicsEnvSet("ENGINEER", "Michael Browne (mcbrowne)" )
epicsEnvSet("LOCATION", "XCS:R38:IOC:43" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "XCS:R38:IOC:43")
epicsEnvSet("EVRID_PMC",  "1")
epicsEnvSet("EVRID_SLAC", "15")
epicsEnvSet("EVRDB_PMC",  "db/evrPmc230.db")
epicsEnvSet("EVRDB_SLAC", "db/evrSLAC.db")
epicsEnvSet("IOCTOP", "/reg/g/pcds/epics/ioc/common/ipimb/R3.2.3")
< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/xrt/ipimb/R4.2.1/build")
cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/ipimbIoc.dbd")
ipimbIoc_registerRecordDeviceDriver(pdbbase)

ErDebugLevel( 0 )

# Initialize EVR
ErConfigure( 0, 0, 0, 0, $(EVRID_PMC) )

# Load EVR record instances
dbLoadRecords( $(EVRDB_PMC), "IOC=XCS:R38:IOC:43,EVR=XCS:R38:EVR:43,CARD=0,IP2E=Enabled,IP2E=Enabled,IP2E=Enabled,IP2E=Enabled,IP2E=Enabled,IP2E=Enabled,IP2E=Enabled,IP2E=Enabled" )


# Datatype is Id_SharedIpimb (35), Version 1, so 65536+35 = 65571
ipimbAdd("HFX-MON-IMB-02", "/dev/ttyPS7", "239.255.24.18", 18, 35, XCS:R38:EVR:43:Triggers.C, 0, HFX:MON:IMB:02:DATA_DELAY, HFX:MON:IMB:02:SYNC)
ipimbAdd("HFX-DG3-IMB-02", "/dev/ttyPS6", "239.255.24.11", 11, 35, XCS:R38:EVR:43:Triggers.C, 0, HFX:DG3:IMB:02:DATA_DELAY, HFX:DG3:IMB:02:SYNC)
ipimbAdd("HFX-MON-IMB-01", "/dev/ttyPS5", "239.255.24.17", 17, 35, XCS:R38:EVR:43:Triggers.C, 0, HFX:MON:IMB:01:DATA_DELAY, HFX:MON:IMB:01:SYNC)
ipimbAdd("XCS-DG3-IMB-04", "/dev/ttyPS4", "239.255.24.9", 9, 35, XCS:R38:EVR:43:Triggers.C, 0, XCS:DG3:IMB:04:DATA_DELAY, XCS:DG3:IMB:04:SYNC)
ipimbAdd("HFX-MON-IMB-03", "/dev/ttyPS3", "239.255.24.19", 19, 35, XCS:R38:EVR:43:Triggers.C, 0, HFX:MON:IMB:03:DATA_DELAY, HFX:MON:IMB:03:SYNC)
ipimbAdd("HFX-DG2-IMB-02", "/dev/ttyPS2", "239.255.24.7", 7, 35, XCS:R38:EVR:43:Triggers.C, 0, HFX:DG2:IMB:02:DATA_DELAY, HFX:DG2:IMB:02:SYNC)
ipimbAdd("HFX-DG2-IMB-01", "/dev/ttyPS1", "239.255.24.6", 6, 35, XCS:R38:EVR:43:Triggers.C, 0, HFX:DG2:IMB:01:DATA_DELAY, HFX:DG2:IMB:01:SYNC)
ipimbAdd("XCS-DG3-IMB-03", "/dev/ttyPS0", "239.255.24.8", 8, 35, XCS:R38:EVR:43:Triggers.C, 0, XCS:DG3:IMB:03:DATA_DELAY, XCS:DG3:IMB:03:SYNC)

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

dbLoadRecords( "db/ipimb.db", "RECNAME=HFX:MON:IMB:02,BOX=HFX-MON-IMB-02,EVR=XCS:R38:EVR:43,TRIG=2,FLNK=HFX:MON:IMB:02:BSAFANOUT")
dbLoadRecords("db/evrDevInfo.db", "BASE=HFX:MON:IMB:02,EVR=XCS:R38:EVR:43,TRIG=2,NAME=HFX:MON:IMB:02")
dbLoadRecords("db/BSAfanout.db", "RECNAME=HFX:MON:IMB:02")

dbLoadRecords( "db/ipimb.db", "RECNAME=HFX:DG3:IMB:02,BOX=HFX-DG3-IMB-02,EVR=XCS:R38:EVR:43,TRIG=2,FLNK=HFX:DG3:IMB:02:BSAFANOUT")
dbLoadRecords("db/evrDevInfo.db", "BASE=HFX:DG3:IMB:02,EVR=XCS:R38:EVR:43,TRIG=2,NAME=HFX:DG3:IMB:02")
dbLoadRecords("db/BSAfanout.db", "RECNAME=HFX:DG3:IMB:02")

dbLoadRecords( "db/ipimb.db", "RECNAME=HFX:MON:IMB:01,BOX=HFX-MON-IMB-01,EVR=XCS:R38:EVR:43,TRIG=2,FLNK=HFX:MON:IMB:01:BSAFANOUT")
dbLoadRecords("db/evrDevInfo.db", "BASE=HFX:MON:IMB:01,EVR=XCS:R38:EVR:43,TRIG=2,NAME=HFX:MON:IMB:01")
dbLoadRecords("db/BSAfanout.db", "RECNAME=HFX:MON:IMB:01")

dbLoadRecords( "db/ipimb.db", "RECNAME=XCS:DG3:IMB:04,BOX=XCS-DG3-IMB-04,EVR=XCS:R38:EVR:43,TRIG=2,FLNK=XCS:DG3:IMB:04:BSAFANOUT")
dbLoadRecords("db/evrDevInfo.db", "BASE=XCS:DG3:IMB:04,EVR=XCS:R38:EVR:43,TRIG=2,NAME=XCS:DG3:IMB:04")
dbLoadRecords("db/BSAfanout.db", "RECNAME=XCS:DG3:IMB:04")

dbLoadRecords( "db/ipimb.db", "RECNAME=HFX:MON:IMB:03,BOX=HFX-MON-IMB-03,EVR=XCS:R38:EVR:43,TRIG=2,FLNK=HFX:MON:IMB:03:BSAFANOUT")
dbLoadRecords("db/evrDevInfo.db", "BASE=HFX:MON:IMB:03,EVR=XCS:R38:EVR:43,TRIG=2,NAME=HFX:MON:IMB:03")
dbLoadRecords("db/BSAfanout.db", "RECNAME=HFX:MON:IMB:03")

dbLoadRecords( "db/ipimb.db", "RECNAME=HFX:DG2:IMB:02,BOX=HFX-DG2-IMB-02,EVR=XCS:R38:EVR:43,TRIG=2,FLNK=HFX:DG2:IMB:02:BSAFANOUT")
dbLoadRecords("db/evrDevInfo.db", "BASE=HFX:DG2:IMB:02,EVR=XCS:R38:EVR:43,TRIG=2,NAME=HFX:DG2:IMB:02")
dbLoadRecords("db/BSAfanout.db", "RECNAME=HFX:DG2:IMB:02")

dbLoadRecords( "db/ipimb.db", "RECNAME=HFX:DG2:IMB:01,BOX=HFX-DG2-IMB-01,EVR=XCS:R38:EVR:43,TRIG=2,FLNK=HFX:DG2:IMB:01:BSAFANOUT")
dbLoadRecords("db/evrDevInfo.db", "BASE=HFX:DG2:IMB:01,EVR=XCS:R38:EVR:43,TRIG=2,NAME=HFX:DG2:IMB:01")
dbLoadRecords("db/BSAfanout.db", "RECNAME=HFX:DG2:IMB:01")

dbLoadRecords( "db/ipimb.db", "RECNAME=XCS:DG3:IMB:03,BOX=XCS-DG3-IMB-03,EVR=XCS:R38:EVR:43,TRIG=2,FLNK=XCS:DG3:IMB:03:BSAFANOUT")
dbLoadRecords("db/evrDevInfo.db", "BASE=XCS:DG3:IMB:03,EVR=XCS:R38:EVR:43,TRIG=2,NAME=XCS:DG3:IMB:03")
dbLoadRecords("db/BSAfanout.db", "RECNAME=XCS:DG3:IMB:03")


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
BldConfig( "239.255.24.18", 10148, 512, 0, 18, 65571, "HFX:MON:IMB:02:CURRENTFID", "HFX:MON:IMB:02:YPOS", "HFX:MON:IMB:02:CURRENTFID", "HFX:MON:IMB:02:CH0_RAW.INP,HFX:MON:IMB:02:CH0,HFX:MON:IMB:02:CH1,HFX:MON:IMB:02:CH2,HFX:MON:IMB:02:CH3,HFX:MON:IMB:02:SUM,HFX:MON:IMB:02:XPOS,HFX:MON:IMB:02:YPOS" )
BldSetDebugLevel(1)
# Uncomment the next line for BLD generation.
BldStart()
BldShowConfig()

BldSetID(1)
BldConfig( "239.255.24.11", 10148, 512, 0, 11, 65571, "HFX:DG3:IMB:02:CURRENTFID", "HFX:DG3:IMB:02:YPOS", "HFX:DG3:IMB:02:CURRENTFID", "HFX:DG3:IMB:02:CH0_RAW.INP,HFX:DG3:IMB:02:CH0,HFX:DG3:IMB:02:CH1,HFX:DG3:IMB:02:CH2,HFX:DG3:IMB:02:CH3,HFX:DG3:IMB:02:SUM,HFX:DG3:IMB:02:XPOS,HFX:DG3:IMB:02:YPOS" )
BldSetDebugLevel(1)
# Uncomment the next line for BLD generation.
BldStart()
BldShowConfig()

BldSetID(2)
BldConfig( "239.255.24.17", 10148, 512, 0, 17, 65571, "HFX:MON:IMB:01:CURRENTFID", "HFX:MON:IMB:01:YPOS", "HFX:MON:IMB:01:CURRENTFID", "HFX:MON:IMB:01:CH0_RAW.INP,HFX:MON:IMB:01:CH0,HFX:MON:IMB:01:CH1,HFX:MON:IMB:01:CH2,HFX:MON:IMB:01:CH3,HFX:MON:IMB:01:SUM,HFX:MON:IMB:01:XPOS,HFX:MON:IMB:01:YPOS" )
BldSetDebugLevel(1)
# Uncomment the next line for BLD generation.
BldStart()
BldShowConfig()

BldSetID(3)
BldConfig( "239.255.24.9", 10148, 512, 0, 9, 65571, "XCS:DG3:IMB:04:CURRENTFID", "XCS:DG3:IMB:04:YPOS", "XCS:DG3:IMB:04:CURRENTFID", "XCS:DG3:IMB:04:CH0_RAW.INP,XCS:DG3:IMB:04:CH0,XCS:DG3:IMB:04:CH1,XCS:DG3:IMB:04:CH2,XCS:DG3:IMB:04:CH3,XCS:DG3:IMB:04:SUM,XCS:DG3:IMB:04:XPOS,XCS:DG3:IMB:04:YPOS" )
BldSetDebugLevel(1)
# Uncomment the next line for BLD generation.
BldStart()
BldShowConfig()

BldSetID(4)
BldConfig( "239.255.24.19", 10148, 512, 0, 19, 65571, "HFX:MON:IMB:03:CURRENTFID", "HFX:MON:IMB:03:YPOS", "HFX:MON:IMB:03:CURRENTFID", "HFX:MON:IMB:03:CH0_RAW.INP,HFX:MON:IMB:03:CH0,HFX:MON:IMB:03:CH1,HFX:MON:IMB:03:CH2,HFX:MON:IMB:03:CH3,HFX:MON:IMB:03:SUM,HFX:MON:IMB:03:XPOS,HFX:MON:IMB:03:YPOS" )
BldSetDebugLevel(1)
# Uncomment the next line for BLD generation.
BldStart()
BldShowConfig()

BldSetID(5)
BldConfig( "239.255.24.7", 10148, 512, 0, 7, 65571, "HFX:DG2:IMB:02:CURRENTFID", "HFX:DG2:IMB:02:YPOS", "HFX:DG2:IMB:02:CURRENTFID", "HFX:DG2:IMB:02:CH0_RAW.INP,HFX:DG2:IMB:02:CH0,HFX:DG2:IMB:02:CH1,HFX:DG2:IMB:02:CH2,HFX:DG2:IMB:02:CH3,HFX:DG2:IMB:02:SUM,HFX:DG2:IMB:02:XPOS,HFX:DG2:IMB:02:YPOS" )
BldSetDebugLevel(1)
# Uncomment the next line for BLD generation.
BldStart()
BldShowConfig()

BldSetID(6)
BldConfig( "239.255.24.6", 10148, 512, 0, 6, 65571, "HFX:DG2:IMB:01:CURRENTFID", "HFX:DG2:IMB:01:YPOS", "HFX:DG2:IMB:01:CURRENTFID", "HFX:DG2:IMB:01:CH0_RAW.INP,HFX:DG2:IMB:01:CH0,HFX:DG2:IMB:01:CH1,HFX:DG2:IMB:01:CH2,HFX:DG2:IMB:01:CH3,HFX:DG2:IMB:01:SUM,HFX:DG2:IMB:01:XPOS,HFX:DG2:IMB:01:YPOS" )
BldSetDebugLevel(1)
# Uncomment the next line for BLD generation.
BldStart()
BldShowConfig()

BldSetID(7)
BldConfig( "239.255.24.8", 10148, 512, 0, 8, 65571, "XCS:DG3:IMB:03:CURRENTFID", "XCS:DG3:IMB:03:YPOS", "XCS:DG3:IMB:03:CURRENTFID", "XCS:DG3:IMB:03:CH0_RAW.INP,XCS:DG3:IMB:03:CH0,XCS:DG3:IMB:03:CH1,XCS:DG3:IMB:03:CH2,XCS:DG3:IMB:03:CH3,XCS:DG3:IMB:03:SUM,XCS:DG3:IMB:03:XPOS,XCS:DG3:IMB:03:YPOS" )
BldSetDebugLevel(1)
# Uncomment the next line for BLD generation.
BldStart()
BldShowConfig()


# Configure the IPIMBs.
dbpf HFX:MON:IMB:02:DoConfig 1
dbpf HFX:DG3:IMB:02:DoConfig 1
dbpf HFX:MON:IMB:01:DoConfig 1
dbpf XCS:DG3:IMB:04:DoConfig 1
dbpf HFX:MON:IMB:03:DoConfig 1
dbpf HFX:DG2:IMB:02:DoConfig 1
dbpf HFX:DG2:IMB:01:DoConfig 1
dbpf XCS:DG3:IMB:03:DoConfig 1

# Fix up the EVR descriptions!
dbpf XCS:R38:EVR:43:FP0L.DESC ""
dbpf XCS:R38:EVR:43:FP1L.DESC ""
dbpf XCS:R38:EVR:43:FP2L.DESC "XCS:{DG2,DG3,MON} IPIMBs"
dbpf XCS:R38:EVR:43:FP3L.DESC ""

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
