#!/reg/g/pcds/epics/ioc/common/ek9000/R1.7.3/bin/rhel7-x86_64/ek9000IOC

epicsEnvSet("IOCNAME", "ioc-ek9000-tst")
epicsEnvSet("ENGINEER", "Jeremy Lorelli (lorelli)")
epicsEnvSet("LOCATION", "B901")
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> ")
epicsEnvSet("IOC_PV", "bhc:tst:ek9000:1")
epicsEnvSet("IOCTOP", "/reg/g/pcds/epics/ioc/common/ek9000/R1.7.3")

< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/common/ek9000/R1.7.3/children/build")
cd ("$(IOCTOP)")

< /reg/d/iocCommon/All/pre_linux.cmd

## Register all support components
dbLoadDatabase("dbd/ek9000IOC.dbd")
ek9000IOC_registerRecordDeviceDriver(pdbbase)

# Configure all EK9000 devices
ek9000Configure("ek9k1","bhc-tst-ek9000",502,7)
# TODO: Uncomment me after R.1.7.2!!!
#dbLoadRecords("db/ek9000_status.db", "RECORD=bhc:tst:ek9000:1:ek9k1,EK9K=ek9k1")

#=====================================================#
# Now add all the terminals and load the records



#=====================================================#



# Now add all the terminals and load the records
ek9000ConfigureTerminal("ek9k1","TST:EK9000:AI1","EL3064",4)
dbLoadRecords("db/EL3064.template", "TERMINAL=TST:EK9000:AI1,DEVICE=ek9k1,POS=4")
ek9000ConfigureTerminal("ek9k1","TST:EK9000:ENC","EL5042",5)
dbLoadRecords("db/EL5042.template", "TERMINAL=TST:EK9000:ENC,DEVICE=ek9k1,POS=5")
ek9000ConfigureTerminal("ek9k1","TST:EK9000:BO2","EL2008",6)
dbLoadRecords("db/EL2008.template", "TERMINAL=TST:EK9000:BO2,DEVICE=ek9k1,POS=6")
ek9000ConfigureTerminal("ek9k1","TST:EK9000:AO1","EL4004",7)
dbLoadRecords("db/EL4004.template", "TERMINAL=TST:EK9000:AO1,DEVICE=ek9k1,POS=7")


ek9000ConfigureTerminal("ek9k1","TST:EK9000:BO1","EL2008",1)
dbLoadRecords("db/EL2008.template", "TERMINAL=TST:EK9000:BO1,DEVICE=ek9k1,POS=1")
ek9000ConfigureTerminal("ek9k1","TST:EK9000:THRM1","EL3314",3)
dbLoadRecords("db/EL3314.template", "TERMINAL=TST:EK9000:THRM1,DEVICE=ek9k1,POS=3")

ek9000ConfigureTerminal("ek9k1","TST:EK9000:BI1","EL1004",2)
dbLoadRecords("db/EL1004.template", "TERMINAL=TST:EK9000:BI1,DEVICE=ek9k1,POS=2")




dbLoadRecords("db/alias.db", "RECORD=TST:EK9000:BO1:1,ALIAS=TST:EK9000:BO1:COFFEE")
dbLoadRecords("db/alias.db", "RECORD=TST:EK9000:BO1:2,ALIAS=TST:EK9000:BO1:CHEETOS")
dbLoadRecords("db/alias.db", "RECORD=TST:EK9000:BO1:4,ALIAS=TST:EK9000:BO1:CHICKEN")

dbLoadRecords( "db/iocSoft.db",            "IOC=bhc:tst:ek9000:1" )
dbLoadRecords( "db/save_restoreStatus.db", "P=bhc:tst:ek9000:1" )

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
