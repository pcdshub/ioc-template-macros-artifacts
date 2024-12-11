#!/reg/g/pcds/epics/ioc/common/ek9000/R1.3.1/bin/rhel7-x86_64/ek9000IOC

epicsEnvSet("IOCNAME", "ioc-mec-ek9000-01")
epicsEnvSet("ENGINEER", "Christina Pino (cpino)")
epicsEnvSet("LOCATION", "H6 R64B")
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> ")
epicsEnvSet("IOC_PV", "MEC:EK9K:IOC:BHC")
epicsEnvSet("IOCTOP", "/reg/g/pcds/epics/ioc/common/ek9000/R1.3.1")

< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/mec/ek9000/R1.3.1/build")
cd ("$(IOCTOP)")

< /reg/d/iocCommon/All/pre_linux.cmd

## Register all support components
dbLoadDatabase("dbd/ek9000IOC.dbd")
ek9000IOC_registerRecordDeviceDriver(pdbbase)

# Configure all EK9000 devices
ek9000Configure("MEC_EK9K1","bhc-mec-ek9000-01",502,17)

#=====================================================#
# Now add all the terminals and load the records



#=====================================================#



# Now add all the terminals and load the records
ek9000ConfigureTerminal("MEC_EK9K1","MEC:EK9K1:AI1","EL3164",12)
dbLoadRecords("db/EL3164.template", "TERMINAL=MEC:EK9K1:AI1")
ek9000ConfigureTerminal("MEC_EK9K1","MEC:EK9K1:AI2","EL3164",13)
dbLoadRecords("db/EL3164.template", "TERMINAL=MEC:EK9K1:AI2")
ek9000ConfigureTerminal("MEC_EK9K1","MEC:EK9K1:AI3","EL3164",14)
dbLoadRecords("db/EL3164.template", "TERMINAL=MEC:EK9K1:AI3")

ek9000ConfigureTerminal("MEC_EK9K1","MEC:EK9K1:AO1","EL4134",16)
dbLoadRecords("db/EL4134.template", "TERMINAL=MEC:EK9K1:AO1")
ek9000ConfigureTerminal("MEC_EK9K1","MEC:EK9K1:AO2","EL4134",17)
dbLoadRecords("db/EL4134.template", "TERMINAL=MEC:EK9K1:AO2")

ek9000ConfigureTerminal("MEC_EK9K1","MEC:EK9K1:BO1","EL2004",4)
dbLoadRecords("db/EL2004.template", "TERMINAL=MEC:EK9K1:BO1")
ek9000ConfigureTerminal("MEC_EK9K1","MEC:EK9K1:BO2","EL2004",5)
dbLoadRecords("db/EL2004.template", "TERMINAL=MEC:EK9K1:BO2")
ek9000ConfigureTerminal("MEC_EK9K1","MEC:EK9K1:BO3","EL2004",6)
dbLoadRecords("db/EL2004.template", "TERMINAL=MEC:EK9K1:BO3")
ek9000ConfigureTerminal("MEC_EK9K1","MEC:EK9K1:BO4","EL2808",7)
dbLoadRecords("db/EL2808.template", "TERMINAL=MEC:EK9K1:BO4")
ek9000ConfigureTerminal("MEC_EK9K1","MEC:EK9K1:BO5","EL2124",9)
dbLoadRecords("db/EL2124.template", "TERMINAL=MEC:EK9K1:BO5")
ek9000ConfigureTerminal("MEC_EK9K1","MEC:EK9K1:BO6","EL2124",10)
dbLoadRecords("db/EL2124.template", "TERMINAL=MEC:EK9K1:BO6")
ek9000ConfigureTerminal("MEC_EK9K1","MEC:EK9K1:BO7","EL2124",11)
dbLoadRecords("db/EL2124.template", "TERMINAL=MEC:EK9K1:BO7")

ek9000ConfigureTerminal("MEC_EK9K1","MEC:EK9K1:BI1","EL1004",1)
dbLoadRecords("db/EL1004.template", "TERMINAL=MEC:EK9K1:BI1")
ek9000ConfigureTerminal("MEC_EK9K1","MEC:EK9K1:BI2","EL1004",2)
dbLoadRecords("db/EL1004.template", "TERMINAL=MEC:EK9K1:BI2")
ek9000ConfigureTerminal("MEC_EK9K1","MEC:EK9K1:BI3","EL1004",3)
dbLoadRecords("db/EL1004.template", "TERMINAL=MEC:EK9K1:BI3")




dbLoadRecords("db/alias.db", "RECORD=MEC:EK9K1:BO5:1,ALIAS=MEC:LAS:TTL:01")
dbLoadRecords("db/alias.db", "RECORD=MEC:EK9K1:BO5:2,ALIAS=MEC:LAS:TTL:02")
dbLoadRecords("db/alias.db", "RECORD=MEC:EK9K1:BO5:3,ALIAS=MEC:LAS:TTL:03")
dbLoadRecords("db/alias.db", "RECORD=MEC:EK9K1:BO5:4,ALIAS=MEC:LAS:TTL:04")
dbLoadRecords("db/alias.db", "RECORD=MEC:EK9K1:BO6:1,ALIAS=MEC:LAS:TTL:05")
dbLoadRecords("db/alias.db", "RECORD=MEC:EK9K1:BO6:2,ALIAS=MEC:LAS:TTL:06")
dbLoadRecords("db/alias.db", "RECORD=MEC:EK9K1:BO6:3,ALIAS=MEC:LAS:TTL:07")
dbLoadRecords("db/alias.db", "RECORD=MEC:EK9K1:BO6:4,ALIAS=MEC:LAS:TTL:08")
dbLoadRecords("db/alias.db", "RECORD=MEC:EK9K1:BO7:1,ALIAS=MEC:LAS:TTL:09")
dbLoadRecords("db/alias.db", "RECORD=MEC:EK9K1:BO7:2,ALIAS=MEC:LAS:TTL:10")
dbLoadRecords("db/alias.db", "RECORD=MEC:EK9K1:BO7:3,ALIAS=MEC:LAS:TTL:11")
dbLoadRecords("db/alias.db", "RECORD=MEC:EK9K1:BO7:4,ALIAS=MEC:LAS:TTL:12")

dbLoadRecords( "db/iocSoft.db",            "IOC=MEC:EK9K:IOC:BHC" )
dbLoadRecords( "db/save_restoreStatus.db", "P=MEC:EK9K:IOC:BHC" )

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
