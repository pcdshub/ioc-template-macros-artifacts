#!$$IOCTOP/bin/$$IF(ARCH,$$ARCH,linux-x86_64)/BK-Precision

< envPaths
epicsEnvSet("IOCNAME",   "$$IOCNAME")
epicsEnvSet("ENGINEER",  "$$ENGINEER")
epicsEnvSet("LOCATION",  "$$LOCATION")
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> ")
epicsEnvSet("IOC_PV",    "$$IOC_PV")
epicsEnvSet("IOCTOP",    "$$IOCTOP")
epicsEnvSet("TOP",       "$$TOP")
## Add the path to the protocol files
epicsEnvSet("STREAM_PROTOCOL_PATH", "$(IOCTOP)/protocol")

cd( "$(IOCTOP)" )

# Run the pre startup script
< /reg/d/iocCommon/All/pre_linux.cmd

## Register all support components
dbLoadDatabase("dbd/BK-Precision.dbd")
BK_Precision_registerRecordDeviceDriver(pdbbase)

## Set up IOC/hardware links -- LAN connection
##############################################################
# For BK Precision ioc
$$LOOP(BKP)
drvAsynIPPortConfigure ("bus$$INDEX","$$PORT",0,0,0)
$$ENDLOOP(BKP)
#

# Load record instances
dbLoadRecords("db/iocSoft.db","IOC=$(IOC_PV)")

## Load record instances (BK Precision)
$$LOOP(BKP)
dbLoadRecords("db/BK_Precision.db","cont=$$NAME, bus=$$INDEX")
$$ENDLOOP(BKP)

# Asyn messages
##############################
$$LOOP(BKP)
$$IF(ASYNTRACE)
asynSetTraceMask("bus$$INDEX",1,0x9)    #for debug
asynSetTraceIOMask("bus$$INDEX",1,0x2)  #for debug
$$ENDIF(ASYNTRACE)
$$ENDLOOP(BKP)

# Initialize the IOC and start processing records
iocInit()

## Now we need to do a favor for the IRMIS crawler
## All IOCs should dump some common info after initial
## startup.
# Run the post startup script
< /reg/d/iocCommon/All/post_linux.cmd

