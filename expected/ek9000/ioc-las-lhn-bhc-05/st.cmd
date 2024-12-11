#!/cds/group/pcds/epics/ioc/common/ek9000/R1.7.3/bin/rhel7-x86_64/ek9000IOC

epicsEnvSet("IOCNAME", "ioc-las-lhn-bhc-05")
epicsEnvSet("ENGINEER", "Sameen Yunus (sfsyunus)")
epicsEnvSet("LOCATION", "LAS SHUTTER CTRL")
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> ")
epicsEnvSet("IOC_PV", "IOC:LAS:LHN:BHC:05")
epicsEnvSet("IOCTOP", "/cds/group/pcds/epics/ioc/common/ek9000/R1.7.3")

< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/las/ek9000/R2.0.0/build")
cd ("$(IOCTOP)")

< /reg/d/iocCommon/All/pre_linux.cmd

## Register all support components
dbLoadDatabase("dbd/ek9000IOC.dbd")
ek9000IOC_registerRecordDeviceDriver(pdbbase)

# Configure all EK9000 devices
ek9000Configure("LAS-LHN-LSC-EK9K1","bhc-las-lhn-lsc-01",502,3)
# TODO: Uncomment me after R.1.7.2!!!
#dbLoadRecords("db/ek9000_status.db", "RECORD=IOC:LAS:LHN:BHC:05:LAS-LHN-LSC-EK9K1,EK9K=LAS-LHN-LSC-EK9K1")

#=====================================================#
# Now add all the terminals and load the records


ek9000ConfigureTerminal("LAS-LHN-LSC-EK9K1","LAS:LHN:LSC:01:BHC:BO1","EL2004",1)
dbLoadRecords("db/EL2004.template", "TERMINAL=LAS:LHN:LSC:01:BHC:BO1,DEVICE=LAS-LHN-LSC-EK9K1,POS=1")

ek9000ConfigureTerminal("LAS-LHN-LSC-EK9K1","LAS:LHN:LSC:01:BHC:BI1","EL1004",2)
dbLoadRecords("db/EL1004.template", "TERMINAL=LAS:LHN:LSC:01:BHC:BI1,DEVICE=LAS-LHN-LSC-EK9K1,POS=2")
ek9000ConfigureTerminal("LAS-LHN-LSC-EK9K1","LAS:LHN:LSC:01:BHC:BI2","EL1004",3)
dbLoadRecords("db/EL1004.template", "TERMINAL=LAS:LHN:LSC:01:BHC:BI2,DEVICE=LAS-LHN-LSC-EK9K1,POS=3")
#=====================================================#



# Now add all the terminals and load the records






dbLoadRecords("db/alias.db", "RECORD=LAS:LHN:LSC:01:BHC:BI1:1,ALIAS=LTLHN:LS1:LST:OPN")
dbLoadRecords("db/alias.db", "RECORD=LAS:LHN:LSC:01:BHC:BI1:2,ALIAS=LTLHN:LS1:LST:CLS")
dbLoadRecords("db/alias.db", "RECORD=LAS:LHN:LSC:01:BHC:BI1:3,ALIAS=LTLHN:LS3:LST:OPN")
dbLoadRecords("db/alias.db", "RECORD=LAS:LHN:LSC:01:BHC:BI1:4,ALIAS=LTLHN:LS3:LST:CLS")
dbLoadRecords("db/alias.db", "RECORD=LAS:LHN:LSC:01:BHC:BI2:1,ALIAS=LTLHN:LS5:LST:OPN")
dbLoadRecords("db/alias.db", "RECORD=LAS:LHN:LSC:01:BHC:BI2:2,ALIAS=LTLHN:LS5:LST:CLS")
dbLoadRecords("db/alias.db", "RECORD=LAS:LHN:LSC:01:BHC:BI2:3,ALIAS=LTLHN:LS8:LST:OPN")
dbLoadRecords("db/alias.db", "RECORD=LAS:LHN:LSC:01:BHC:BI2:4,ALIAS=LTLHN:LS8:LST:CLS")

dbLoadRecords("db/alias.db", "RECORD=LAS:LHN:LSC:01:BHC:BO1:1,ALIAS=LTLHN:LS1:LST:REQ")
dbLoadRecords("db/alias.db", "RECORD=LAS:LHN:LSC:01:BHC:BO1:2,ALIAS=LTLHN:LS3:LST:REQ")
dbLoadRecords("db/alias.db", "RECORD=LAS:LHN:LSC:01:BHC:BO1:3,ALIAS=LTLHN:LS5:LST:REQ")
dbLoadRecords("db/alias.db", "RECORD=LAS:LHN:LSC:01:BHC:BO1:4,ALIAS=LTLHN:LS8:LST:REQ")

dbLoadRecords( "db/iocSoft.db",            "IOC=IOC:LAS:LHN:BHC:05" )
dbLoadRecords( "db/save_restoreStatus.db", "P=IOC:LAS:LHN:BHC:05" )

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
