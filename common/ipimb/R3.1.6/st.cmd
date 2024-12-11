#!$$IOCTOP/bin/$$IF(ARCH,$$ARCH,linux-x86)/ipimbIoc

epicsEnvSet("IOCNAME", "$$IOCNAME" )
epicsEnvSet("ENGINEER", "$$ENGINEER" )
epicsEnvSet("LOCATION", "$$LOCATION" )
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> " )
epicsEnvSet("IOC_PV", "$$IOC_PV")
epicsEnvSet("EVRID_PMC",  "1")
epicsEnvSet("EVRID_SLAC", "15")
epicsEnvSet("EVRDB_PMC",  "db/evrPmc230.db")
epicsEnvSet("EVRDB_SLAC", "db/evrSLAC.db")
epicsEnvSet("IOCTOP", "$$IOCTOP")
< envPaths
epicsEnvSet("TOP", "$$TOP")
cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("dbd/ipimbIoc.dbd")
ipimbIoc_registerRecordDeviceDriver(pdbbase)

ErDebugLevel( 0 )

$$LOOP(EVR)
# Initialize EVR
ErConfigure( $$IF(CARD,$$CARD,$$INDEX), 0, 0, 0, $(EVRID_$$TYPE) )

# Load EVR record instances
dbLoadRecords( $(EVRDB_$$TYPE), "IOC=$$(IOC_PV),EVR=$$(NAME),CARD=$$IF(CARD,$$CARD,$$INDEX)$$LOOP(IPIMB),IP$$(TRIG)E=Enabled$$ENDLOOP(IPIMB)$$LOOP(USETRIG),IP$$(TRIG)E=Enabled$$ENDLOOP(USETRIG)" )
$$ENDLOOP(EVR)

$$LOOP(EVENTCODE)
dbLoadRecords( "db/usrseq.db", "DEV=$$EVRNAME0,NAME=$$NAME,ID=$$ID,LNAME=$$LNAME" )
$$ENDLOOP(EVENTCODE)

# Datatype is Id_SharedIpimb (35), Version 1, so 65536+35 = 65571
$$LOOP(IPIMB)
ipimbAdd("$$TRANSLATE(NAME,":","-")", "$$PORT", "239.255.24.$$IF(BLDID,$$BLDID,254)", $$IF(BLDID,$$BLDID,254), 35, $$EVRNAME:Triggers.$$TRANSLATE(TRIG,"0123456789AB","ABCDEFGHIJKL"), 0, $$NAME:DATA_DELAY, $$NAME:SYNC)
$$ENDLOOP(IPIMB)

# Load remaining record instances
dbLoadRecords( "db/ipimb_iocAdmin.db", "IOC=$(IOC_PV)" )
dbLoadRecords( "db/save_restoreStatus.db", "IOC=$(IOC_PV)" )

$$LOOP(IPIMB)
dbLoadRecords( "db/bldSettings.db", "BLD=$(IOC_PV):B$$INDEX,BLDNO=$$INDEX" )
$$ENDLOOP(IPIMB)

$$LOOP(IPIMB)
dbLoadRecords( "db/ipimb.db", "RECNAME=$$NAME,BOX=$$TRANSLATE(NAME,":","-"),EVR=$$EVRNAME,TRIG=$$TRIG,FLNK=$$IF(BSA)$$NAME:EFSUM$$ENDIF(BSA)")
dbLoadRecords("db/evrDevInfo.db", "BASE=$$NAME,EVR=$$EVRNAME,TRIG=$$TRIG,NAME=$$NAME")
$$IF(BSA)
dbLoadRecords( "db/ipimbBSA.db", "RECNAME=$$NAME")
$$ENDIF(BSA)
$$ENDLOOP(IPIMB)

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

$$LOOP(IPIMB)
$$IF(BLDID)
BldSetID($$INDEX)
BldConfig( "239.255.24.$$BLDID", 10148, 512, 0, $$BLDID, 65571, "$$NAME:CURRENTFID", "$$NAME:YPOS", "$$NAME:CURRENTFID", "$$NAME:CH0_RAW.INP,$$NAME:CH0,$$NAME:CH1,$$NAME:CH2,$$NAME:CH3,$$NAME:SUM,$$NAME:XPOS,$$NAME:YPOS" )
BldSetDebugLevel(1)
# Uncomment the next line for BLD generation.
$$(NOBLD)BldStart()
BldShowConfig()
$$ENDIF(BLDID)

$$ENDLOOP(IPIMB)

# Configure the IPIMBs.
$$LOOP(IPIMB)
$$(NOCFG)dbpf $$NAME:DoConfig 1
$$ENDLOOP(IPIMB)

# Fix up the EVR descriptions!
$$LOOP(TRIGGER)
dbpf $$EVRNAME:FP$$(TRIG)L.DESC "$$NAME"
$$ENDLOOP(TRIGGER)

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd
