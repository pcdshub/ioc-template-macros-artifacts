#!/reg/g/pcds/package/epics/3.14/ioc/common/TDS3000/R1.0.0/bin/linux-x86_64/TDS3000

<envPaths
epicsEnvSet("IOC_NAME", "ioc-mfx-scope-portable01" )
epicsEnvSet("ENGINEER", "Michael Browne (mcbrowne)" )
epicsEnvSet("LOCATION", "MFX:IOC:TDS3000:01" )
epicsEnvSet("IOCSH_PS1", "$(IOC_NAME)> " )
epicsEnvSet("IOC_PV", "MFX:IOC:TDS3000:01")
epicsEnvSet("IOCTOP", "/reg/g/pcds/package/epics/3.14/ioc/common/TDS3000/R1.0.0")
epicsEnvSet("TOP","/reg/g/pcds/epics/ioc/mfx/TDS3000/R1.0.0/build")


# Device Configuration
epicsEnvSet( "FAMILY1", "3000")     # Scope family 3000 or 5000
epicsEnvSet( "ETHER1", "tds3k-mfx-portable01" )                           # Scope IP address
epicsEnvSet( "DEV1", "MFX:LAS:OSC:01" )                             # Scope PV name
epicsEnvSet( "NAME1", "tds3k-mfx-portable01" )                            # Scope descriptive name
epicsEnvSet( "ASYNPORT1", "0")    # Scope asyn port #

# Ensure that we can transfer a complete waveform
epicsEnvSet( "EPICS_CA_MAX_ARRAY_BYTES" , "100000" )
cd( "$(IOCTOP)" )

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd


## Register all support components
dbLoadDatabase("dbd/TDS3000.dbd")
TDS3000_registerRecordDeviceDriver(pdbbase)

## Load IOCAdmin Record
dbLoadRecords( "db/iocAdmin.db",            "IOC=$(LOCATION)" )
dbLoadRecords( "db/save_restoreStatus.db",  "IOC=$(LOCATION)" )

## Load diagnostic record instance
#dbLoadRecords("db/asynRecord.db","P=$(SCOPE1),R=,PORT=L$(ASYNPORT1),ADDR=0,OMAX=0,IMAX=0")
#dbLoadRecords("db/asynRecord.db","Dev=$(DEV1),PORT=L$(ASYNPORT1)")

## Load oscilloscope db's if using Auto Print/Re-arm trig SNL program. 
dbLoadRecords("db/TDS3000Message.db","scope=$(DEV1):,L=0,A=0,ASG=DEFAULT,rfsys=1")

## This is the main db.
dbLoadRecords("db/TDSxxxx.db","scope=$(DEV1):,L=$(ASYNPORT1),A=0,ASG=DEFAULT,Name=$(NAME1),FAMILY=$(FAMILY1)")

## Reboot scopes (Ethernet only)
#TDS3000Reboot $(ETHER1)
#epicsThreadSleep(60)

## Set up IOC/hardware links -- Direct network connection
vxi11Configure("L$(ASYNPORT1)", "$(ETHER1)", 0, 0.0, "inst0", 0)

## Set this to see messages from mySub
#var mySubDebug 1

## Turn on all diagnostic messages to stdout
#asynSetTraceMask("L$(ASYNPORT1)", -1, 0x9)
#asynSetTraceIOMask("L$(ASYNPORT1)", -1, 0x2)
#asynSetTraceIOTruncateSize("L$(ASYNPORT1)", -1, 120)
## Output debug to file
#asynSetTraceFile("L$(ASYNPORT1)",0,"/reg/d/iocData/$(IOC_NAME)/logs/$(DEV1).log")

# Setup autosave
save_restoreSet_status_prefix( "$(LOCATION):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

set_savefile_path( "$(IOC_DATA)/$(IOC_NAME)/autosave" )
set_requestfile_path( "$(TOP)/autosave" )

# Just restore the settings
set_pass0_restoreFile( "$(IOC_NAME).sav" )
set_pass1_restoreFile( "$(IOC_NAME).sav" )


# Initialize the IOC and start processing records
iocInit()

## Start any sequence programs
#seq TDS3000AutoArmPrint,"scope=$(DEV1):"


## Now we need to do a favor for the IRMIS crawler
## All IOCs should dump some common info after initial
## startup.
## The file: post_st.cmd does the trick
< /reg/d/iocCommon/All/post_linux.cmd
