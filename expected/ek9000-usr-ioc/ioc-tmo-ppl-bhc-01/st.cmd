#!/reg/g/pcds/epics/ioc/common/ek9000/R1.2.1/bin/rhel7-x86_64/ek9000IOC

epicsEnvSet("IOCNAME", "ioc-tmo-ppl-bhc-01")
epicsEnvSet("ENGINEER", "Sameen Yunus (sfsyunus)")
epicsEnvSet("LOCATION", "TMO USR GRANITE")
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> ")
epicsEnvSet("IOC_PV", "IOC:TMO:USR:BHC:01")
epicsEnvSet("IOCTOP", "/reg/g/pcds/epics/ioc/common/ek9000/R1.2.1")

< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/epics-dev/lorelli/tmo/ek9000-usr-ioc/build")
cd ("$(IOCTOP)")

< /reg/d/iocCommon/All/pre_linux.cmd

## Register all support components
dbLoadDatabase("dbd/ek9000IOC.dbd")
ek9000IOC_registerRecordDeviceDriver(pdbbase)

# Configure all EK9000 devices
ek9000Configure("TMO-USR-EK9K1","bhc-tmo-usr-01",502,12)

#=====================================================#
# Now add all the terminals and load the records
ek9000ConfigureTerminal("TMO-USR-EK9K1","TMO:USR:BHC:AI1","EL3164",8)
dbLoadRecords("db/EL3164.template", "TERMINAL=TMO:USR:BHC:AI1")
ek9000ConfigureTerminal("TMO-USR-EK9K1","TMO:USR:BHC:AI2","EL3104",9)
dbLoadRecords("db/EL3104.template", "TERMINAL=TMO:USR:BHC:AI2")
ek9000ConfigureTerminal("TMO-USR-EK9K1","TMO:USR:BHC:AI3","EL3114",10)
dbLoadRecords("db/EL3114.template", "TERMINAL=TMO:USR:BHC:AI3")
ek9000ConfigureTerminal("TMO-USR-EK9K1","TMO:USR:BHC:DMM","EL3681",11)
dbLoadRecords("db/EL3681.template", "TERMINAL=TMO:USR:BHC:DMM")
ek9000ConfigureTerminal("TMO-USR-EK9K1","TMO:USR:BHC:TC1","EL3314",12)
dbLoadRecords("db/EL3314.template", "TERMINAL=TMO:USR:BHC:TC1")

ek9000ConfigureTerminal("TMO-USR-EK9K1","TMO:USR:BHC:AO1","EL4104",5)
dbLoadRecords("db/EL4104.template", "TERMINAL=TMO:USR:BHC:AO1")
ek9000ConfigureTerminal("TMO-USR-EK9K1","TMO:USR:BHC:AO2","EL4134",6)
dbLoadRecords("db/EL4134.template", "TERMINAL=TMO:USR:BHC:AO2")
ek9000ConfigureTerminal("TMO-USR-EK9K1","TMO:USR:BHC:AO3","EL4114",7)
dbLoadRecords("db/EL4114.template", "TERMINAL=TMO:USR:BHC:AO3")

ek9000ConfigureTerminal("TMO-USR-EK9K1","TMO:USR:BHC:BO1","EL2004",3)
dbLoadRecords("db/EL2004.template", "TERMINAL=TMO:USR:BHC:BO1")
ek9000ConfigureTerminal("TMO-USR-EK9K1","TMO:USR:BHC:BO2","EL2004",4)
dbLoadRecords("db/EL2004.template", "TERMINAL=TMO:USR:BHC:BO2")

ek9000ConfigureTerminal("TMO-USR-EK9K1","TMO:USR:BHC:BI1","EL1004",1)
dbLoadRecords("db/EL1004.template", "TERMINAL=TMO:USR:BHC:BI1")
ek9000ConfigureTerminal("TMO-USR-EK9K1","TMO:USR:BHC:BI2","EL1004",2)
dbLoadRecords("db/EL1004.template", "TERMINAL=TMO:USR:BHC:BI2")
#=====================================================#



# Now add all the terminals and load the records




dbLoadRecords("db/alias.db", "RECORD=TMO:USR:BHC:AO1:1,ALIAS=TMO:USR:BHC:AOUT:1")
dbLoadRecords("db/alias.db", "RECORD=TMO:USR:BHC:AO1:2,ALIAS=TMO:USR:BHC:AOUT:2")
dbLoadRecords("db/alias.db", "RECORD=TMO:USR:BHC:AO1:3,ALIAS=TMO:USR:BHC:AOUT:3")
dbLoadRecords("db/alias.db", "RECORD=TMO:USR:BHC:AO1:4,ALIAS=TMO:USR:BHC:AOUT:4")
dbLoadRecords("db/alias.db", "RECORD=TMO:USR:BHC:AO2:1,ALIAS=TMO:USR:BHC:AOUT:5")
dbLoadRecords("db/alias.db", "RECORD=TMO:USR:BHC:AO2:2,ALIAS=TMO:USR:BHC:AOUT:6")
dbLoadRecords("db/alias.db", "RECORD=TMO:USR:BHC:AO2:3,ALIAS=TMO:USR:BHC:AOUT:7")
dbLoadRecords("db/alias.db", "RECORD=TMO:USR:BHC:AO2:4,ALIAS=TMO:USR:BHC:AOUT:8")
dbLoadRecords("db/alias.db", "RECORD=TMO:USR:BHC:AO3:1,ALIAS=TMO:USR:BHC:AOUT:9")
dbLoadRecords("db/alias.db", "RECORD=TMO:USR:BHC:AO3:2,ALIAS=TMO:USR:BHC:AOUT:10")
dbLoadRecords("db/alias.db", "RECORD=TMO:USR:BHC:AO3:3,ALIAS=TMO:USR:BHC:AOUT:11")
dbLoadRecords("db/alias.db", "RECORD=TMO:USR:BHC:AO3:4,ALIAS=TMO:USR:BHC:AOUT:12")

dbLoadRecords("db/alias.db", "RECORD=TMO:USR:BHC:TC1:1,ALIAS=TMO:USR:BHC:TC:1")
dbLoadRecords("db/alias.db", "RECORD=TMO:USR:BHC:TC1:2,ALIAS=TMO:USR:BHC:TC:2")
dbLoadRecords("db/alias.db", "RECORD=TMO:USR:BHC:TC1:3,ALIAS=TMO:USR:BHC:TC:3")
dbLoadRecords("db/alias.db", "RECORD=TMO:USR:BHC:TC1:4,ALIAS=TMO:USR:BHC:TC:4")
dbLoadRecords("db/alias.db", "RECORD=TMO:USR:BHC:AI1:1,ALIAS=TMO:USR:BHC:AIN:1")
dbLoadRecords("db/alias.db", "RECORD=TMO:USR:BHC:AI1:2,ALIAS=TMO:USR:BHC:AIN:2")
dbLoadRecords("db/alias.db", "RECORD=TMO:USR:BHC:AI1:3,ALIAS=TMO:USR:BHC:AIN:3")
dbLoadRecords("db/alias.db", "RECORD=TMO:USR:BHC:AI1:4,ALIAS=TMO:USR:BHC:AIN:4")
dbLoadRecords("db/alias.db", "RECORD=TMO:USR:BHC:AI2:1,ALIAS=TMO:USR:BHC:AIN:5")
dbLoadRecords("db/alias.db", "RECORD=TMO:USR:BHC:AI2:2,ALIAS=TMO:USR:BHC:AIN:6")
dbLoadRecords("db/alias.db", "RECORD=TMO:USR:BHC:AI2:3,ALIAS=TMO:USR:BHC:AIN:7")
dbLoadRecords("db/alias.db", "RECORD=TMO:USR:BHC:AI2:4,ALIAS=TMO:USR:BHC:AIN:8")
dbLoadRecords("db/alias.db", "RECORD=TMO:USR:BHC:AI3:1,ALIAS=TMO:USR:BHC:AIN:9")
dbLoadRecords("db/alias.db", "RECORD=TMO:USR:BHC:AI3:2,ALIAS=TMO:USR:BHC:AIN:10")
dbLoadRecords("db/alias.db", "RECORD=TMO:USR:BHC:AI3:3,ALIAS=TMO:USR:BHC:AIN:11")
dbLoadRecords("db/alias.db", "RECORD=TMO:USR:BHC:AI3:4,ALIAS=TMO:USR:BHC:AIN:12")

dbLoadRecords("db/alias.db", "RECORD=TMO:USR:BHC:BI1:1,ALIAS=TMO:USR:BHC:BIN:1")
dbLoadRecords("db/alias.db", "RECORD=TMO:USR:BHC:BI1:2,ALIAS=TMO:USR:BHC:BIN:2")
dbLoadRecords("db/alias.db", "RECORD=TMO:USR:BHC:BI1:3,ALIAS=TMO:USR:BHC:BIN:3")
dbLoadRecords("db/alias.db", "RECORD=TMO:USR:BHC:BI1:4,ALIAS=TMO:USR:BHC:BIN:4")
dbLoadRecords("db/alias.db", "RECORD=TMO:USR:BHC:BI2:1,ALIAS=TMO:USR:BHC:BIN:5")
dbLoadRecords("db/alias.db", "RECORD=TMO:USR:BHC:BI2:2,ALIAS=TMO:USR:BHC:BIN:6")
dbLoadRecords("db/alias.db", "RECORD=TMO:USR:BHC:BI2:3,ALIAS=TMO:USR:BHC:BIN:7")
dbLoadRecords("db/alias.db", "RECORD=TMO:USR:BHC:BI2:4,ALIAS=TMO:USR:BHC:BIN:8")

dbLoadRecords("db/alias.db", "RECORD=TMO:USR:BHC:BO1:1,ALIAS=TMO:USR:BHC:BOUT:1")
dbLoadRecords("db/alias.db", "RECORD=TMO:USR:BHC:BO1:2,ALIAS=TMO:USR:BHC:BOUT:2")
dbLoadRecords("db/alias.db", "RECORD=TMO:USR:BHC:BO1:3,ALIAS=TMO:USR:BHC:BOUT:3")
dbLoadRecords("db/alias.db", "RECORD=TMO:USR:BHC:BO1:4,ALIAS=TMO:USR:BHC:BOUT:4")
dbLoadRecords("db/alias.db", "RECORD=TMO:USR:BHC:BO2:1,ALIAS=TMO:USR:BHC:BOUT:5")
dbLoadRecords("db/alias.db", "RECORD=TMO:USR:BHC:BO2:2,ALIAS=TMO:USR:BHC:BOUT:6")
dbLoadRecords("db/alias.db", "RECORD=TMO:USR:BHC:BO2:3,ALIAS=TMO:USR:BHC:BOUT:7")
dbLoadRecords("db/alias.db", "RECORD=TMO:USR:BHC:BO2:4,ALIAS=TMO:USR:BHC:BOUT:8")

dbLoadRecords( "db/iocSoft.db",            "IOC=IOC:TMO:USR:BHC:01" )
dbLoadRecords( "db/save_restoreStatus.db", "P=IOC:TMO:USR:BHC:01" )

cd "${TOP}/iocBoot/${IOC}"

# Autosave stuff
set_savefile_path("$(IOC_DATA)/$(IOC)/autosave")
set_requestfile_path("$(TOP)/autosave")
set_requestfile_path("$(TOP)/iocBoot/$(IOC)")
save_restoreSet_status_prefix("$(IOC_PV)")
save_restoreSet_IncompleteSetsOk(1)
save_restoreSet_DatedBackupFiles(1)
set_pass0_restoreFile("$(IOCNAME).sav")
set_pass1_restoreFile("$(IOCNAME).sav")

iocInit

create_monitor_set("$(IOCNAME).req", 5, "IOC=$(IOC_PV)")

< /reg/d/iocCommon/All/post_linux.cmd
