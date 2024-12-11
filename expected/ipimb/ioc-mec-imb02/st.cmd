#!/reg/g/pcds/package/epics/3.14/ioc/common/ipimb/R3.1.7/bin/linux-x86_64/ipimbIoc

epicsEnvSet("IOCNAME", "ioc-mec-imb02" )
epicsEnvSet("ENGINEER", "Michael Browne (mcbrowne)" )
epicsEnvSet("LOCATION", "MEC:R64A:24" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "IOC:MEC:IMB02")
epicsEnvSet("EVRID_PMC",  "1")
epicsEnvSet("EVRID_SLAC", "15")
epicsEnvSet("EVRDB_PMC",  "db/evrPmc230.db")
epicsEnvSet("EVRDB_SLAC", "db/evrSLAC.db")
epicsEnvSet("IOCTOP", "/reg/g/pcds/package/epics/3.14/ioc/common/ipimb/R3.1.7")
< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/mec/ipimb/R4.2.0/build")
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
dbLoadRecords( $(EVRDB_PMC), "IOC=IOC:MEC:IMB02,EVR=MEC:XT2:EVR:01,CARD=0,IP0E=Enabled,IP0E=Enabled" )


# Datatype is Id_SharedIpimb (35), Version 1, so 65536+35 = 65571
ipimbAdd("MEC-XT2-PIM-02", "/dev/ttyPS2", "239.255.24.42", 42, 35, MEC:XT2:EVR:01:Triggers.A, 0, MEC:XT2:PIM:02:DATA_DELAY, MEC:XT2:PIM:02:SYNC)
ipimbAdd("MEC-XT2-PIM-03", "/dev/ttyPS0", "239.255.24.43", 43, 35, MEC:XT2:EVR:01:Triggers.A, 0, MEC:XT2:PIM:03:DATA_DELAY, MEC:XT2:PIM:03:SYNC)

# Load remaining record instances
dbLoadRecords( "db/ipimb_iocAdmin.db", "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "IOC=$(IOC_PV)" )

dbLoadRecords( "db/bldSettings.db", "BLD=$(IOC_PV):B0,BLDNO=0" )
dbLoadRecords( "db/bldSettings.db", "BLD=$(IOC_PV):B1,BLDNO=1" )

dbLoadRecords( "db/ipimb.db", "RECNAME=MEC:XT2:PIM:02,BOX=MEC-XT2-PIM-02,EVR=MEC:XT2:EVR:01,TRIG=0,FLNK=")
dbLoadRecords( "db/evralias.db", "BASE=MEC:XT2:PIM:02,EVR=MEC:XT2:EVR:01,CH=0")
dbLoadRecords( "db/ipimb.db", "RECNAME=MEC:XT2:PIM:03,BOX=MEC-XT2-PIM-03,EVR=MEC:XT2:EVR:01,TRIG=0,FLNK=")
dbLoadRecords( "db/evralias.db", "BASE=MEC:XT2:PIM:03,EVR=MEC:XT2:EVR:01,CH=0")

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
BldConfig( "239.255.24.42", 10148, 512, 0, 42, 65571, "MEC:XT2:PIM:02:CURRENTFID", "MEC:XT2:PIM:02:YPOS", "MEC:XT2:PIM:02:CURRENTFID", "MEC:XT2:PIM:02:CH0_RAW.INP,MEC:XT2:PIM:02:CH0,MEC:XT2:PIM:02:CH1,MEC:XT2:PIM:02:CH2,MEC:XT2:PIM:02:CH3,MEC:XT2:PIM:02:SUM,MEC:XT2:PIM:02:XPOS,MEC:XT2:PIM:02:YPOS" )
BldSetDebugLevel(1)
# Uncomment the next line for BLD generation.
BldStart()
BldShowConfig()

BldSetID(1)
BldConfig( "239.255.24.43", 10148, 512, 0, 43, 65571, "MEC:XT2:PIM:03:CURRENTFID", "MEC:XT2:PIM:03:YPOS", "MEC:XT2:PIM:03:CURRENTFID", "MEC:XT2:PIM:03:CH0_RAW.INP,MEC:XT2:PIM:03:CH0,MEC:XT2:PIM:03:CH1,MEC:XT2:PIM:03:CH2,MEC:XT2:PIM:03:CH3,MEC:XT2:PIM:03:SUM,MEC:XT2:PIM:03:XPOS,MEC:XT2:PIM:03:YPOS" )
BldSetDebugLevel(1)
# Uncomment the next line for BLD generation.
BldStart()
BldShowConfig()


# Configure the IPIMBs.
dbpf MEC:XT2:PIM:02:DoConfig 1
dbpf MEC:XT2:PIM:03:DoConfig 1

# Fix up the EVR descriptions!
dbpf MEC:XT2:EVR:01:FP0L.DESC "MEC:XT2:{IPM,PIM}:{02,03}"
dbpf MEC:XT2:EVR:01:FP1L.DESC ""
dbpf MEC:XT2:EVR:01:FP2L.DESC ""
dbpf MEC:XT2:EVR:01:FP3L.DESC ""

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
