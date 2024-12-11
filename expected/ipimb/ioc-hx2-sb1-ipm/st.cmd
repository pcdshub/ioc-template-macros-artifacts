#!/reg/g/pcds/package/epics/3.14/ioc/common/ipimb/R3.2.4/bin/linux-x86_64/ipimbIoc

epicsEnvSet("IOCNAME", "ioc-hx2-sb1-ipm" )
epicsEnvSet("ENGINEER", "Michael Browne (mcbrowne)" )
epicsEnvSet("LOCATION", "HX2:SB1:IPM:IOC" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "HX2:SB1:IPM:IOC")
epicsEnvSet("EVRID_PMC",  "1")
epicsEnvSet("EVRID_SLAC", "15")
epicsEnvSet("EVRDB_PMC",  "db/evrPmc230.db")
epicsEnvSet("EVRDB_SLAC", "db/evrSLAC.db")
epicsEnvSet("IOCTOP", "/reg/g/pcds/package/epics/3.14/ioc/common/ipimb/R3.2.4")
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
ErConfigure( 0, 0, 0, 0, $(EVRID_PMC) )

# Load EVR record instances
dbLoadRecords( $(EVRDB_PMC), "IOC=HX2:SB1:IPM:IOC,EVR=HX2:EVR:IPM,CARD=0,IP0E=Enabled,IP1E=Enabled" )


# Datatype is Id_SharedIpimb (35), Version 1, so 65536+35 = 65571
ipimbAdd("HX2-SB1-IPM-01", "/dev/ttyPS6", "239.255.24.3", 3, 35, HX2:EVR:IPM:Triggers.A, 0, HX2:SB1:IPM:01:DATA_DELAY, HX2:SB1:IPM:01:SYNC)
ipimbAdd("HX2-SB1-IPM-02", "/dev/ttyPS7", "239.255.24.45", 45, 35, HX2:EVR:IPM:Triggers.B, 0, HX2:SB1:IPM:02:DATA_DELAY, HX2:SB1:IPM:02:SYNC)

# Load remaining record instances
dbLoadRecords( "db/iocSoft.db", "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "IOC=$(IOC_PV)" )

dbLoadRecords( "db/bldSettings.db", "BLD=$(IOC_PV):B0,BLDNO=0" )
dbLoadRecords( "db/bldSettings.db", "BLD=$(IOC_PV):B1,BLDNO=1" )

dbLoadRecords( "db/ipimb.db", "RECNAME=HX2:SB1:IPM:01,BOX=HX2-SB1-IPM-01,EVR=HX2:EVR:IPM,TRIG=0,FLNK=HX2:SB1:IPM:01:BSAFANOUT")
dbLoadRecords("db/evrDevInfo.db", "BASE=HX2:SB1:IPM:01,EVR=HX2:EVR:IPM,TRIG=0,NAME=HX2:SB1:IPM:01")
dbLoadRecords("db/BSAfanout.db", "RECNAME=HX2:SB1:IPM:01,L1=HX2:SB1:IPM:01:EFSUM")

dbLoadRecords( "db/ipimbBSA.db", "RECNAME=HX2:SB1:IPM:01,ATTR=SUM")
dbLoadRecords( "db/ipimb.db", "RECNAME=HX2:SB1:IPM:02,BOX=HX2-SB1-IPM-02,EVR=HX2:EVR:IPM,TRIG=1,FLNK=HX2:SB1:IPM:02:BSAFANOUT")
dbLoadRecords("db/evrDevInfo.db", "BASE=HX2:SB1:IPM:02,EVR=HX2:EVR:IPM,TRIG=1,NAME=HX2:SB1:IPM:02")
dbLoadRecords("db/BSAfanout.db", "RECNAME=HX2:SB1:IPM:02")


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
BldConfig( "239.255.24.3", 10148, 512, 0, 3, 65571, "HX2:SB1:IPM:01:CURRENTFID", "HX2:SB1:IPM:01:YPOS", "HX2:SB1:IPM:01:CURRENTFID", "HX2:SB1:IPM:01:CH0_RAW.INP,HX2:SB1:IPM:01:CH0,HX2:SB1:IPM:01:CH1,HX2:SB1:IPM:01:CH2,HX2:SB1:IPM:01:CH3,HX2:SB1:IPM:01:SUM,HX2:SB1:IPM:01:XPOS,HX2:SB1:IPM:01:YPOS" )
BldSetDebugLevel(1)
# Uncomment the next line for BLD generation.
BldStart()
BldShowConfig()

BldSetID(1)
BldConfig( "239.255.24.45", 10148, 512, 0, 45, 65571, "HX2:SB1:IPM:02:CURRENTFID", "HX2:SB1:IPM:02:YPOS", "HX2:SB1:IPM:02:CURRENTFID", "HX2:SB1:IPM:02:CH0_RAW.INP,HX2:SB1:IPM:02:CH0,HX2:SB1:IPM:02:CH1,HX2:SB1:IPM:02:CH2,HX2:SB1:IPM:02:CH3,HX2:SB1:IPM:02:SUM,HX2:SB1:IPM:02:XPOS,HX2:SB1:IPM:02:YPOS" )
BldSetDebugLevel(1)
# Uncomment the next line for BLD generation.
BldStart()
BldShowConfig()


# Configure the IPIMBs.
dbpf HX2:SB1:IPM:01:DoConfig 1
dbpf HX2:SB1:IPM:02:DoConfig 1

# Fix up the EVR descriptions!
dbpf HX2:EVR:IPM:FP0L.DESC "HX2:SB1:IPM:01"
dbpf HX2:EVR:IPM:FP1L.DESC "HX2:SB1:IPM:02"
dbpf HX2:EVR:IPM:FP2L.DESC ""
dbpf HX2:EVR:IPM:FP3L.DESC ""

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
