#!/reg/g/pcds/epics/ioc/common/ipimb/R3.2.3/bin/rhel7-x86_64/ipimbIoc

epicsEnvSet("IOCNAME", "ioc-xrt-xcsimb1" )
epicsEnvSet("ENGINEER", "Michael Browne (mcbrowne)" )
epicsEnvSet("LOCATION", "XCS:R04:IOC:34" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "XCS:R04:IOC:34")
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
dbLoadRecords( $(EVRDB_PMC), "IOC=XCS:R04:IOC:34,EVR=XCS:R04:EVR:34,CARD=0,IP2E=Enabled,IP2E=Enabled" )


# Datatype is Id_SharedIpimb (35), Version 1, so 65536+35 = 65571
ipimbAdd("XCS-DG1-IMB-01", "/dev/ttyPS0", "239.255.24.4", 4, 35, XCS:R04:EVR:34:Triggers.C, 0, XCS:DG1:IMB:01:DATA_DELAY, XCS:DG1:IMB:01:SYNC)
ipimbAdd("XCS-DG1-IMB-02", "/dev/ttyPS1", "239.255.24.5", 5, 35, XCS:R04:EVR:34:Triggers.C, 0, XCS:DG1:IMB:02:DATA_DELAY, XCS:DG1:IMB:02:SYNC)

# Load remaining record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "IOC=$(IOC_PV)" )

dbLoadRecords( "db/bldSettings.db", "BLD=$(IOC_PV):B0,BLDNO=0" )
dbLoadRecords( "db/bldSettings.db", "BLD=$(IOC_PV):B1,BLDNO=1" )

dbLoadRecords( "db/ipimb.db", "RECNAME=XCS:DG1:IMB:01,BOX=XCS-DG1-IMB-01,EVR=XCS:R04:EVR:34,TRIG=2,FLNK=XCS:DG1:IMB:01:BSAFANOUT")
dbLoadRecords("db/evrDevInfo.db", "BASE=XCS:DG1:IMB:01,EVR=XCS:R04:EVR:34,TRIG=2,NAME=XCS:DG1:IMB:01")
dbLoadRecords("db/BSAfanout.db", "RECNAME=XCS:DG1:IMB:01,L1=XCS:DG1:IMB:01:EFSUM")

dbLoadRecords( "db/ipimbBSA.db", "RECNAME=XCS:DG1:IMB:01,ATTR=SUM")
dbLoadRecords( "db/ipimb.db", "RECNAME=XCS:DG1:IMB:02,BOX=XCS-DG1-IMB-02,EVR=XCS:R04:EVR:34,TRIG=2,FLNK=XCS:DG1:IMB:02:BSAFANOUT")
dbLoadRecords("db/evrDevInfo.db", "BASE=XCS:DG1:IMB:02,EVR=XCS:R04:EVR:34,TRIG=2,NAME=XCS:DG1:IMB:02")
dbLoadRecords("db/BSAfanout.db", "RECNAME=XCS:DG1:IMB:02")


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
BldConfig( "239.255.24.4", 10148, 512, 0, 4, 65571, "XCS:DG1:IMB:01:CURRENTFID", "XCS:DG1:IMB:01:YPOS", "XCS:DG1:IMB:01:CURRENTFID", "XCS:DG1:IMB:01:CH0_RAW.INP,XCS:DG1:IMB:01:CH0,XCS:DG1:IMB:01:CH1,XCS:DG1:IMB:01:CH2,XCS:DG1:IMB:01:CH3,XCS:DG1:IMB:01:SUM,XCS:DG1:IMB:01:XPOS,XCS:DG1:IMB:01:YPOS" )
BldSetDebugLevel(1)
# Uncomment the next line for BLD generation.
BldStart()
BldShowConfig()

BldSetID(1)
BldConfig( "239.255.24.5", 10148, 512, 0, 5, 65571, "XCS:DG1:IMB:02:CURRENTFID", "XCS:DG1:IMB:02:YPOS", "XCS:DG1:IMB:02:CURRENTFID", "XCS:DG1:IMB:02:CH0_RAW.INP,XCS:DG1:IMB:02:CH0,XCS:DG1:IMB:02:CH1,XCS:DG1:IMB:02:CH2,XCS:DG1:IMB:02:CH3,XCS:DG1:IMB:02:SUM,XCS:DG1:IMB:02:XPOS,XCS:DG1:IMB:02:YPOS" )
BldSetDebugLevel(1)
# Uncomment the next line for BLD generation.
BldStart()
BldShowConfig()


# Configure the IPIMBs.
dbpf XCS:DG1:IMB:01:DoConfig 1
dbpf XCS:DG1:IMB:02:DoConfig 1

# Fix up the EVR descriptions!
dbpf XCS:R04:EVR:34:FP0L.DESC ""
dbpf XCS:R04:EVR:34:FP1L.DESC ""
dbpf XCS:R04:EVR:34:FP2L.DESC "XCS:DG1:IMB:{01,02}"
dbpf XCS:R04:EVR:34:FP3L.DESC ""

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd