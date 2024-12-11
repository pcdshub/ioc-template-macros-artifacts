#!/cds/group/pcds/epics/ioc/common/ek9000/R1.7.1/bin/rhel7-x86_64/ek9000IOC

epicsEnvSet("IOCNAME", "ioc-xcs-bhc-01")
epicsEnvSet("ENGINEER", "Carolyn Gee (cagee)")
epicsEnvSet("LOCATION", "XCS Rack 42")
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> ")
epicsEnvSet("IOC_PV", "IOC:XCS:BHC:01")
epicsEnvSet("IOCTOP", "/cds/group/pcds/epics/ioc/common/ek9000/R1.7.1")

< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/xcs/ek9000/R1.0.0/build")
cd ("$(IOCTOP)")

< /reg/d/iocCommon/All/pre_linux.cmd

## Register all support components
dbLoadDatabase("dbd/ek9000IOC.dbd")
ek9000IOC_registerRecordDeviceDriver(pdbbase)

# Configure all EK9000 devices
ek9000Configure("XCS-EK9K1","bhc-xcs-11",502,1)
# TODO: Uncomment me after R.1.7.2!!!
#dbLoadRecords("db/ek9000_status.db", "RECORD=IOC:XCS:BHC:01:XCS-EK9K1,EK9K=XCS-EK9K1")

#=====================================================#
# Now add all the terminals and load the records


ek9000ConfigureTerminal("XCS-EK9K1","XCS:BHC:01:BO1","EL2794",1)
dbLoadRecords("db/EL2794.template", "TERMINAL=XCS:BHC:01:BO1,DEVICE=XCS-EK9K1,POS=1")

#=====================================================#



# Now add all the terminals and load the records








dbLoadRecords( "db/iocSoft.db",            "IOC=IOC:XCS:BHC:01" )
dbLoadRecords( "db/save_restoreStatus.db", "P=IOC:XCS:BHC:01" )

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
