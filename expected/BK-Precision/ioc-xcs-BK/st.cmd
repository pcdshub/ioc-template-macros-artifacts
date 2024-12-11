#!/reg/g/pcds/package/epics/3.14/ioc/common/BK-Precision/R1.1.0/bin/linux-x86_64/BK-Precision

< envPaths
epicsEnvSet("IOCNAME",   "ioc-xcs-BK")
epicsEnvSet("ENGINEER",  "Daniel Damiani (ddamiani)")
epicsEnvSet("LOCATION",  "IOC:XCS:USR:BK1")
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> ")
epicsEnvSet("IOC_PV",    "IOC:XCS:USR:BK1")
epicsEnvSet("IOCTOP",    "/reg/g/pcds/package/epics/3.14/ioc/common/BK-Precision/R1.1.0")
epicsEnvSet("TOP",       "/reg/g/pcds/package/epics/3.14/ioc/xcs/BK-Precision/R1.0.0/build")
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
drvAsynIPPortConfigure ("bus0","digi-xcs-19:2007",0,0,0)
#

# Load record instances
dbLoadRecords("db/iocSoft.db","IOC=$(IOC_PV)")

## Load record instances (BK Precision)
dbLoadRecords("db/BK_Precision.db","cont=XCS:USR:BK1, bus=0")

# Asyn messages
##############################

# Initialize the IOC and start processing records
iocInit()

## Now we need to do a favor for the IRMIS crawler
## All IOCs should dump some common info after initial
## startup.
# Run the post startup script
< /reg/d/iocCommon/All/post_linux.cmd

