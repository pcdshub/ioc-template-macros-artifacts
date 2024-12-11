#!/reg/g/pcds/package/epics/3.14/ioc/common/ipimb/R3.1.7/bin/linux-x86_64/ipimbIoc

epicsEnvSet("IOCNAME", "ioc-mec-ipimb01" )
epicsEnvSet("ENGINEER", "Michael Browne (mcbrowne)" )
epicsEnvSet("LOCATION", "MEC:R64B:39" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "IOC:MEC:IPIMB01")
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
dbLoadRecords( $(EVRDB_PMC), "IOC=IOC:MEC:IPIMB01,EVR=MEC:TC1:EVR:01,CARD=0,IP0E=Enabled,IP1E=Enabled,IP2E=Enabled,IP2E=Enabled,IP2E=Enabled" )

dbLoadRecords( "db/usrseq.db", "DEV=MEC:TC1:EVR:01,NAME=E182,ID=182,LNAME=Event Code 182" )

# Datatype is Id_SharedIpimb (35), Version 1, so 65536+35 = 65571
ipimbAdd("MEC-TC1-IMB-01", "/dev/ttyPS7", "239.255.24.22", 22, 35, MEC:TC1:EVR:01:Triggers.A, 0, MEC:TC1:IMB:01:DATA_DELAY, MEC:TC1:IMB:01:SYNC)
ipimbAdd("MEC-USR-IMB-01", "/dev/ttyPS6", "239.255.24.21", 21, 35, MEC:TC1:EVR:01:Triggers.B, 0, MEC:USR:IMB:01:DATA_DELAY, MEC:USR:IMB:01:SYNC)
ipimbAdd("MEC-USR-IMB-02", "/dev/ttyPS5", "239.255.24.20", 20, 35, MEC:TC1:EVR:01:Triggers.C, 0, MEC:USR:IMB:02:DATA_DELAY, MEC:USR:IMB:02:SYNC)
ipimbAdd("MEC-LAS-IMB-02", "/dev/ttyPS2", "239.255.24.254", 254, 35, MEC:TC1:EVR:01:Triggers.C, 0, MEC:LAS:IMB:02:DATA_DELAY, MEC:LAS:IMB:02:SYNC)
ipimbAdd("MEC-LAS-IMB-01", "/dev/ttyPS1", "239.255.24.254", 254, 35, MEC:TC1:EVR:01:Triggers.C, 0, MEC:LAS:IMB:01:DATA_DELAY, MEC:LAS:IMB:01:SYNC)

# Load remaining record instances
dbLoadRecords( "db/ipimb_iocAdmin.db", "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "IOC=$(IOC_PV)" )

dbLoadRecords( "db/bldSettings.db", "BLD=$(IOC_PV):B0,BLDNO=0" )
dbLoadRecords( "db/bldSettings.db", "BLD=$(IOC_PV):B1,BLDNO=1" )
dbLoadRecords( "db/bldSettings.db", "BLD=$(IOC_PV):B2,BLDNO=2" )
dbLoadRecords( "db/bldSettings.db", "BLD=$(IOC_PV):B3,BLDNO=3" )
dbLoadRecords( "db/bldSettings.db", "BLD=$(IOC_PV):B4,BLDNO=4" )

dbLoadRecords( "db/ipimb.db", "RECNAME=MEC:TC1:IMB:01,BOX=MEC-TC1-IMB-01,EVR=MEC:TC1:EVR:01,TRIG=0,FLNK=")
dbLoadRecords( "db/evralias.db", "BASE=MEC:TC1:IMB:01,EVR=MEC:TC1:EVR:01,CH=0")
dbLoadRecords( "db/ipimb.db", "RECNAME=MEC:USR:IMB:01,BOX=MEC-USR-IMB-01,EVR=MEC:TC1:EVR:01,TRIG=1,FLNK=")
dbLoadRecords( "db/evralias.db", "BASE=MEC:USR:IMB:01,EVR=MEC:TC1:EVR:01,CH=1")
dbLoadRecords( "db/ipimb.db", "RECNAME=MEC:USR:IMB:02,BOX=MEC-USR-IMB-02,EVR=MEC:TC1:EVR:01,TRIG=2,FLNK=")
dbLoadRecords( "db/evralias.db", "BASE=MEC:USR:IMB:02,EVR=MEC:TC1:EVR:01,CH=2")
dbLoadRecords( "db/ipimb.db", "RECNAME=MEC:LAS:IMB:02,BOX=MEC-LAS-IMB-02,EVR=MEC:TC1:EVR:01,TRIG=2,FLNK=")
dbLoadRecords( "db/evralias.db", "BASE=MEC:LAS:IMB:02,EVR=MEC:TC1:EVR:01,CH=2")
dbLoadRecords( "db/ipimb.db", "RECNAME=MEC:LAS:IMB:01,BOX=MEC-LAS-IMB-01,EVR=MEC:TC1:EVR:01,TRIG=2,FLNK=")
dbLoadRecords( "db/evralias.db", "BASE=MEC:LAS:IMB:01,EVR=MEC:TC1:EVR:01,CH=2")

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
BldConfig( "239.255.24.22", 10148, 512, 0, 22, 65571, "MEC:TC1:IMB:01:CURRENTFID", "MEC:TC1:IMB:01:YPOS", "MEC:TC1:IMB:01:CURRENTFID", "MEC:TC1:IMB:01:CH0_RAW.INP,MEC:TC1:IMB:01:CH0,MEC:TC1:IMB:01:CH1,MEC:TC1:IMB:01:CH2,MEC:TC1:IMB:01:CH3,MEC:TC1:IMB:01:SUM,MEC:TC1:IMB:01:XPOS,MEC:TC1:IMB:01:YPOS" )
BldSetDebugLevel(1)
# Uncomment the next line for BLD generation.
BldStart()
BldShowConfig()

BldSetID(1)
BldConfig( "239.255.24.21", 10148, 512, 0, 21, 65571, "MEC:USR:IMB:01:CURRENTFID", "MEC:USR:IMB:01:YPOS", "MEC:USR:IMB:01:CURRENTFID", "MEC:USR:IMB:01:CH0_RAW.INP,MEC:USR:IMB:01:CH0,MEC:USR:IMB:01:CH1,MEC:USR:IMB:01:CH2,MEC:USR:IMB:01:CH3,MEC:USR:IMB:01:SUM,MEC:USR:IMB:01:XPOS,MEC:USR:IMB:01:YPOS" )
BldSetDebugLevel(1)
# Uncomment the next line for BLD generation.
BldStart()
BldShowConfig()

BldSetID(2)
BldConfig( "239.255.24.20", 10148, 512, 0, 20, 65571, "MEC:USR:IMB:02:CURRENTFID", "MEC:USR:IMB:02:YPOS", "MEC:USR:IMB:02:CURRENTFID", "MEC:USR:IMB:02:CH0_RAW.INP,MEC:USR:IMB:02:CH0,MEC:USR:IMB:02:CH1,MEC:USR:IMB:02:CH2,MEC:USR:IMB:02:CH3,MEC:USR:IMB:02:SUM,MEC:USR:IMB:02:XPOS,MEC:USR:IMB:02:YPOS" )
BldSetDebugLevel(1)
# Uncomment the next line for BLD generation.
BldStart()
BldShowConfig()




# Configure the IPIMBs.
dbpf MEC:TC1:IMB:01:DoConfig 1
dbpf MEC:USR:IMB:01:DoConfig 1
dbpf MEC:USR:IMB:02:DoConfig 1
dbpf MEC:LAS:IMB:02:DoConfig 1
dbpf MEC:LAS:IMB:01:DoConfig 1

# Fix up the EVR descriptions!
dbpf MEC:TC1:EVR:01:FP0L.DESC "MEC:TC1:IMB:01"
dbpf MEC:TC1:EVR:01:FP1L.DESC "MEC:USR:IMB:01"
dbpf MEC:TC1:EVR:01:FP2L.DESC "MEC:USR:IMB:02"
dbpf MEC:TC1:EVR:01:FP2L.DESC "MEC:LAS:IMB:02"
dbpf MEC:TC1:EVR:01:FP2L.DESC "MEC:LAS:IMB:01"
dbpf MEC:TC1:EVR:01:FP3L.DESC ""

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
