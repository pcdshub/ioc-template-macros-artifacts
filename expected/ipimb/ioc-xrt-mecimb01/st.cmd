#!/reg/g/pcds/epics/ioc/common/ipimb/R3.2.3/bin/rhel7-x86_64/ipimbIoc

epicsEnvSet("IOCNAME", "ioc-xrt-mecimb01" )
epicsEnvSet("ENGINEER", "James Young (jry24)" )
epicsEnvSet("LOCATION", "XRT:R44:IOC:39" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "XRT:R44:IOC:39")
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
dbLoadRecords( $(EVRDB_PMC), "IOC=XRT:R44:IOC:39,EVR=XRT:R44:EVR:39,CARD=0,IP2E=Enabled,IP2E=Enabled,IP0E=Enabled" )


# Datatype is Id_SharedIpimb (35), Version 1, so 65536+35 = 65571
ipimbAdd("MEC-HXM-IPM-01", "/dev/ttyPS7", "239.255.24.25", 25, 35, XRT:R44:EVR:39:Triggers.C, 0, MEC:HXM:IPM:01:DATA_DELAY, MEC:HXM:IPM:01:SYNC)
ipimbAdd("MEC-HXM-PIM-01", "/dev/ttyPS6", "239.255.24.254", 254, 35, XRT:R44:EVR:39:Triggers.C, 0, MEC:HXM:PIM:01:DATA_DELAY, MEC:HXM:PIM:01:SYNC)

# Load remaining record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "IOC=$(IOC_PV)" )

dbLoadRecords( "db/bldSettings.db", "BLD=$(IOC_PV):B0,BLDNO=0" )
dbLoadRecords( "db/bldSettings.db", "BLD=$(IOC_PV):B1,BLDNO=1" )

dbLoadRecords( "db/ipimb.db", "RECNAME=MEC:HXM:IPM:01,BOX=MEC-HXM-IPM-01,EVR=XRT:R44:EVR:39,TRIG=2,FLNK=MEC:HXM:IPM:01:BSAFANOUT")
dbLoadRecords("db/evrDevInfo.db", "BASE=MEC:HXM:IPM:01,EVR=XRT:R44:EVR:39,TRIG=2,NAME=MEC:HXM:IPM:01")
dbLoadRecords("db/BSAfanout.db", "RECNAME=MEC:HXM:IPM:01")

dbLoadRecords( "db/ipimb.db", "RECNAME=MEC:HXM:PIM:01,BOX=MEC-HXM-PIM-01,EVR=XRT:R44:EVR:39,TRIG=2,FLNK=MEC:HXM:PIM:01:BSAFANOUT")
dbLoadRecords("db/evrDevInfo.db", "BASE=MEC:HXM:PIM:01,EVR=XRT:R44:EVR:39,TRIG=2,NAME=MEC:HXM:PIM:01")
dbLoadRecords("db/BSAfanout.db", "RECNAME=MEC:HXM:PIM:01")


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
BldConfig( "239.255.24.25", 10148, 512, 0, 25, 65571, "MEC:HXM:IPM:01:CURRENTFID", "MEC:HXM:IPM:01:YPOS", "MEC:HXM:IPM:01:CURRENTFID", "MEC:HXM:IPM:01:CH0_RAW.INP,MEC:HXM:IPM:01:CH0,MEC:HXM:IPM:01:CH1,MEC:HXM:IPM:01:CH2,MEC:HXM:IPM:01:CH3,MEC:HXM:IPM:01:SUM,MEC:HXM:IPM:01:XPOS,MEC:HXM:IPM:01:YPOS" )
BldSetDebugLevel(1)
# Uncomment the next line for BLD generation.
BldStart()
BldShowConfig()



# Configure the IPIMBs.
dbpf MEC:HXM:IPM:01:DoConfig 1
dbpf MEC:HXM:PIM:01:DoConfig 1

# Fix up the EVR descriptions!
dbpf XRT:R44:EVR:39:FP0L.DESC ""
dbpf XRT:R44:EVR:39:FP1L.DESC ""
dbpf XRT:R44:EVR:39:FP2L.DESC "MEC:HXM:{IPM,PIM}:01"
dbpf XRT:R44:EVR:39:FP3L.DESC ""

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
