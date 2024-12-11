#!/cds/group/pcds/epics/ioc/common/ek9000/R1.7.3/bin/rhel7-x86_64/ek9000IOC

epicsEnvSet("IOCNAME", "ioc-las-ftl-bhc-01")
epicsEnvSet("ENGINEER", "tjohnson")
epicsEnvSet("LOCATION", "FTL R02")
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> ")
epicsEnvSet("IOC_PV", "IOC:LAS:FTL:BHC:01")
epicsEnvSet("IOCTOP", "/cds/group/pcds/epics/ioc/common/ek9000/R1.7.3")

< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/las/ek9000/R2.0.0/build")
cd ("$(IOCTOP)")

< /reg/d/iocCommon/All/pre_linux.cmd

## Register all support components
dbLoadDatabase("dbd/ek9000IOC.dbd")
ek9000IOC_registerRecordDeviceDriver(pdbbase)

# Configure all EK9000 devices
ek9000Configure("LAS-FTL-EK9K1","bhc-las-ftl-01",502,4)
# TODO: Uncomment me after R.1.7.2!!!
#dbLoadRecords("db/ek9000_status.db", "RECORD=IOC:LAS:FTL:BHC:01:LAS-FTL-EK9K1,EK9K=LAS-FTL-EK9K1")

#=====================================================#
# Now add all the terminals and load the records
ek9000ConfigureTerminal("LAS-FTL-EK9K1","LAS:FTL:BHC:01:AI1","EL3174",2)
dbLoadRecords("db/EL3174.template", "TERMINAL=LAS:FTL:BHC:01:AI1,DEVICE=LAS-FTL-EK9K1,POS=2")
ek9000ConfigureTerminal("LAS-FTL-EK9K1","LAS:FTL:BHC:01:AI2","EL3174",3)
dbLoadRecords("db/EL3174.template", "TERMINAL=LAS:FTL:BHC:01:AI2,DEVICE=LAS-FTL-EK9K1,POS=3")
ek9000ConfigureTerminal("LAS-FTL-EK9K1","LAS:FTL:BHC:01:AI3","EL3174",4)
dbLoadRecords("db/EL3174.template", "TERMINAL=LAS:FTL:BHC:01:AI3,DEVICE=LAS-FTL-EK9K1,POS=4")

ek9000ConfigureTerminal("LAS-FTL-EK9K1","LAS:FTL:BHC:01:AO1","EL4102",1)
dbLoadRecords("db/EL4102.template", "TERMINAL=LAS:FTL:BHC:01:AO1,DEVICE=LAS-FTL-EK9K1,POS=1")


#=====================================================#



# Now add all the terminals and load the records








dbLoadRecords( "db/iocSoft.db",            "IOC=IOC:LAS:FTL:BHC:01" )
dbLoadRecords( "db/save_restoreStatus.db", "P=IOC:LAS:FTL:BHC:01" )

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
