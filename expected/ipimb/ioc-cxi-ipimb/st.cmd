#!/reg/g/pcds/epics/ioc/common/ipimb/R3.2.3//bin/rhel7-x86_64/ipimbIoc

epicsEnvSet("IOCNAME", "ioc-cxi-ipimb" )
epicsEnvSet("ENGINEER", "Christian Tsoi-A-Sue (ctsoi)" )
epicsEnvSet("LOCATION", "IOC:CXI:IPM" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "IOC:CXI:IPM")
epicsEnvSet("EVRID_PMC",  "1")
epicsEnvSet("EVRID_SLAC", "15")
epicsEnvSet("EVRDB_PMC",  "db/evrPmc230.db")
epicsEnvSet("EVRDB_SLAC", "db/evrSLAC.db")
epicsEnvSet("IOCTOP", "/reg/g/pcds/epics/ioc/common/ipimb/R3.2.3/")
< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/cxi/ipimb/R1.1.1/build")
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
dbLoadRecords( $(EVRDB_SLAC), "IOC=IOC:CXI:IPM,EVR=CXI:IPM:EVR,CARD=0,IP3E=Enabled,IP3E=Enabled,IP3E=Enabled,IP3E=Enabled,IP3E=Enabled,IP3E=Enabled,IP3E=Enabled" )


# Datatype is Id_SharedIpimb (35), Version 1, so 65536+35 = 65571
ipimbAdd("CXI-DG2-IMB-02", "/dev/ttyPS6", "239.255.24.29", 29, 35, CXI:IPM:EVR:Triggers.D, 0, CXI:DG2:IMB:02:DATA_DELAY, CXI:DG2:IMB:02:SYNC)
ipimbAdd("CXI-SC2-IMB-01", "/dev/ttyPS5", "239.255.24.254", 254, 35, CXI:IPM:EVR:Triggers.D, 0, CXI:SC2:IMB:01:DATA_DELAY, CXI:SC2:IMB:01:SYNC)
ipimbAdd("CXI-DG1-IMB-01", "/dev/ttyPS4", "239.255.24.27", 27, 35, CXI:IPM:EVR:Triggers.D, 0, CXI:DG1:IMB:01:DATA_DELAY, CXI:DG1:IMB:01:SYNC)
ipimbAdd("CXI-DG2-IMB-01", "/dev/ttyPS3", "239.255.24.28", 28, 35, CXI:IPM:EVR:Triggers.D, 0, CXI:DG2:IMB:01:DATA_DELAY, CXI:DG2:IMB:01:SYNC)
ipimbAdd("CXI-KB1-IMB-01", "/dev/ttyPS1", "239.255.24.254", 254, 35, CXI:IPM:EVR:Triggers.D, 0, CXI:KB1:IMB:01:DATA_DELAY, CXI:KB1:IMB:01:SYNC)
ipimbAdd("CXI-SC1-IMB-01", "/dev/ttyPS0", "239.255.24.254", 254, 35, CXI:IPM:EVR:Triggers.D, 0, CXI:SC1:IMB:01:DATA_DELAY, CXI:SC1:IMB:01:SYNC)
ipimbAdd("CXI-DG4-IMB-01", "/dev/ttyPS2", "239.255.24.30", 30, 35, CXI:IPM:EVR:Triggers.D, 0, CXI:DG4:IMB:01:DATA_DELAY, CXI:DG4:IMB:01:SYNC)

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

dbLoadRecords( "db/ipimb.db", "RECNAME=CXI:DG2:IMB:02,BOX=CXI-DG2-IMB-02,EVR=CXI:IPM:EVR,TRIG=3,FLNK=CXI:DG2:IMB:02:BSAFANOUT")
dbLoadRecords("db/evrDevInfo.db", "BASE=CXI:DG2:IMB:02,EVR=CXI:IPM:EVR,TRIG=3,NAME=CXI:DG2:IMB:02")
dbLoadRecords("db/BSAfanout.db", "RECNAME=CXI:DG2:IMB:02")

dbLoadRecords( "db/ipimb.db", "RECNAME=CXI:SC2:IMB:01,BOX=CXI-SC2-IMB-01,EVR=CXI:IPM:EVR,TRIG=3,FLNK=CXI:SC2:IMB:01:BSAFANOUT")
dbLoadRecords("db/evrDevInfo.db", "BASE=CXI:SC2:IMB:01,EVR=CXI:IPM:EVR,TRIG=3,NAME=CXI:SC2:IMB:01")
dbLoadRecords("db/BSAfanout.db", "RECNAME=CXI:SC2:IMB:01")

dbLoadRecords( "db/ipimb.db", "RECNAME=CXI:DG1:IMB:01,BOX=CXI-DG1-IMB-01,EVR=CXI:IPM:EVR,TRIG=3,FLNK=CXI:DG1:IMB:01:BSAFANOUT")
dbLoadRecords("db/evrDevInfo.db", "BASE=CXI:DG1:IMB:01,EVR=CXI:IPM:EVR,TRIG=3,NAME=CXI:DG1:IMB:01")
dbLoadRecords("db/BSAfanout.db", "RECNAME=CXI:DG1:IMB:01")

dbLoadRecords( "db/ipimb.db", "RECNAME=CXI:DG2:IMB:01,BOX=CXI-DG2-IMB-01,EVR=CXI:IPM:EVR,TRIG=3,FLNK=CXI:DG2:IMB:01:BSAFANOUT")
dbLoadRecords("db/evrDevInfo.db", "BASE=CXI:DG2:IMB:01,EVR=CXI:IPM:EVR,TRIG=3,NAME=CXI:DG2:IMB:01")
dbLoadRecords("db/BSAfanout.db", "RECNAME=CXI:DG2:IMB:01")

dbLoadRecords( "db/ipimb.db", "RECNAME=CXI:KB1:IMB:01,BOX=CXI-KB1-IMB-01,EVR=CXI:IPM:EVR,TRIG=3,FLNK=CXI:KB1:IMB:01:BSAFANOUT")
dbLoadRecords("db/evrDevInfo.db", "BASE=CXI:KB1:IMB:01,EVR=CXI:IPM:EVR,TRIG=3,NAME=CXI:KB1:IMB:01")
dbLoadRecords("db/BSAfanout.db", "RECNAME=CXI:KB1:IMB:01")

dbLoadRecords( "db/ipimb.db", "RECNAME=CXI:SC1:IMB:01,BOX=CXI-SC1-IMB-01,EVR=CXI:IPM:EVR,TRIG=3,FLNK=CXI:SC1:IMB:01:BSAFANOUT")
dbLoadRecords("db/evrDevInfo.db", "BASE=CXI:SC1:IMB:01,EVR=CXI:IPM:EVR,TRIG=3,NAME=CXI:SC1:IMB:01")
dbLoadRecords("db/BSAfanout.db", "RECNAME=CXI:SC1:IMB:01")

dbLoadRecords( "db/ipimb.db", "RECNAME=CXI:DG4:IMB:01,BOX=CXI-DG4-IMB-01,EVR=CXI:IPM:EVR,TRIG=3,FLNK=CXI:DG4:IMB:01:BSAFANOUT")
dbLoadRecords("db/evrDevInfo.db", "BASE=CXI:DG4:IMB:01,EVR=CXI:IPM:EVR,TRIG=3,NAME=CXI:DG4:IMB:01")
dbLoadRecords("db/BSAfanout.db", "RECNAME=CXI:DG4:IMB:01")


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
BldConfig( "239.255.24.29", 10148, 512, 0, 29, 65571, "CXI:DG2:IMB:02:CURRENTFID", "CXI:DG2:IMB:02:YPOS", "CXI:DG2:IMB:02:CURRENTFID", "CXI:DG2:IMB:02:CH0_RAW.INP,CXI:DG2:IMB:02:CH0,CXI:DG2:IMB:02:CH1,CXI:DG2:IMB:02:CH2,CXI:DG2:IMB:02:CH3,CXI:DG2:IMB:02:SUM,CXI:DG2:IMB:02:XPOS,CXI:DG2:IMB:02:YPOS" )
BldSetDebugLevel(1)
# Uncomment the next line for BLD generation.
BldStart()
BldShowConfig()


BldSetID(2)
BldConfig( "239.255.24.27", 10148, 512, 0, 27, 65571, "CXI:DG1:IMB:01:CURRENTFID", "CXI:DG1:IMB:01:YPOS", "CXI:DG1:IMB:01:CURRENTFID", "CXI:DG1:IMB:01:CH0_RAW.INP,CXI:DG1:IMB:01:CH0,CXI:DG1:IMB:01:CH1,CXI:DG1:IMB:01:CH2,CXI:DG1:IMB:01:CH3,CXI:DG1:IMB:01:SUM,CXI:DG1:IMB:01:XPOS,CXI:DG1:IMB:01:YPOS" )
BldSetDebugLevel(1)
# Uncomment the next line for BLD generation.
BldStart()
BldShowConfig()

BldSetID(3)
BldConfig( "239.255.24.28", 10148, 512, 0, 28, 65571, "CXI:DG2:IMB:01:CURRENTFID", "CXI:DG2:IMB:01:YPOS", "CXI:DG2:IMB:01:CURRENTFID", "CXI:DG2:IMB:01:CH0_RAW.INP,CXI:DG2:IMB:01:CH0,CXI:DG2:IMB:01:CH1,CXI:DG2:IMB:01:CH2,CXI:DG2:IMB:01:CH3,CXI:DG2:IMB:01:SUM,CXI:DG2:IMB:01:XPOS,CXI:DG2:IMB:01:YPOS" )
BldSetDebugLevel(1)
# Uncomment the next line for BLD generation.
BldStart()
BldShowConfig()



BldSetID(6)
BldConfig( "239.255.24.30", 10148, 512, 0, 30, 65571, "CXI:DG4:IMB:01:CURRENTFID", "CXI:DG4:IMB:01:YPOS", "CXI:DG4:IMB:01:CURRENTFID", "CXI:DG4:IMB:01:CH0_RAW.INP,CXI:DG4:IMB:01:CH0,CXI:DG4:IMB:01:CH1,CXI:DG4:IMB:01:CH2,CXI:DG4:IMB:01:CH3,CXI:DG4:IMB:01:SUM,CXI:DG4:IMB:01:XPOS,CXI:DG4:IMB:01:YPOS" )
BldSetDebugLevel(1)
# Uncomment the next line for BLD generation.
BldStart()
BldShowConfig()


# Configure the IPIMBs.
dbpf CXI:DG2:IMB:02:DoConfig 1
dbpf CXI:SC2:IMB:01:DoConfig 1
dbpf CXI:DG1:IMB:01:DoConfig 1
dbpf CXI:DG2:IMB:01:DoConfig 1
dbpf CXI:KB1:IMB:01:DoConfig 1
dbpf CXI:SC1:IMB:01:DoConfig 1
dbpf CXI:DG4:IMB:01:DoConfig 1

# Fix up the EVR descriptions!
dbpf CXI:IPM:EVR:FP3L.DESC "CXI-HUTCH-IPM"

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
