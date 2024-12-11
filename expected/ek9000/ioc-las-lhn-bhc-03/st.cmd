#!/cds/group/pcds/epics/ioc/common/ek9000/R1.7.3/bin/rhel7-x86_64/ek9000IOC

epicsEnvSet("IOCNAME", "ioc-las-lhn-bhc-03")
epicsEnvSet("ENGINEER", "Lana Jansen-Whealey (ljansen7)")
epicsEnvSet("LOCATION", "LAS TIMING ADC ZONE 3")
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> ")
epicsEnvSet("IOC_PV", "IOC:LAS:ADC:BHC:03")
epicsEnvSet("IOCTOP", "/cds/group/pcds/epics/ioc/common/ek9000/R1.7.3")

< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/las/ek9000/R2.0.0/build")
cd ("$(IOCTOP)")

< /reg/d/iocCommon/All/pre_linux.cmd

## Register all support components
dbLoadDatabase("dbd/ek9000IOC.dbd")
ek9000IOC_registerRecordDeviceDriver(pdbbase)

# Configure all EK9000 devices
ek9000Configure("LAS-LHN-ADC-EK9K3","bhc-las-timing-03",502,3)
# TODO: Uncomment me after R.1.7.2!!!
#dbLoadRecords("db/ek9000_status.db", "RECORD=IOC:LAS:ADC:BHC:03:LAS-LHN-ADC-EK9K3,EK9K=LAS-LHN-ADC-EK9K3")

#=====================================================#
# Now add all the terminals and load the records
ek9000ConfigureTerminal("LAS-LHN-ADC-EK9K3","LAS:LHN:ADC:03:BHC:AI1","EL3174",1)
dbLoadRecords("db/EL3174.template", "TERMINAL=LAS:LHN:ADC:03:BHC:AI1,DEVICE=LAS-LHN-ADC-EK9K3,POS=1")
ek9000ConfigureTerminal("LAS-LHN-ADC-EK9K3","LAS:LHN:ADC:03:BHC:AI2","EL3174",2)
dbLoadRecords("db/EL3174.template", "TERMINAL=LAS:LHN:ADC:03:BHC:AI2,DEVICE=LAS-LHN-ADC-EK9K3,POS=2")
ek9000ConfigureTerminal("LAS-LHN-ADC-EK9K3","LAS:LHN:ADC:03:BHC:AI3","EL3174",3)
dbLoadRecords("db/EL3174.template", "TERMINAL=LAS:LHN:ADC:03:BHC:AI3,DEVICE=LAS-LHN-ADC-EK9K3,POS=3")



#=====================================================#



# Now add all the terminals and load the records





dbLoadRecords("db/alias.db", "RECORD=LAS:LHN:ADC:03:BHC:AI1:1,ALIAS=LAS:LHN:ADC:03:PRESS_1")
dbLoadRecords("db/alias.db", "RECORD=LAS:LHN:ADC:03:BHC:AI1:2,ALIAS=LAS:LHN:ADC:03:HUMID_1")
dbLoadRecords("db/alias.db", "RECORD=LAS:LHN:ADC:03:BHC:AI1:3,ALIAS=LAS:LHN:ADC:03:TEMP_1")
dbLoadRecords("db/alias.db", "RECORD=LAS:LHN:ADC:03:BHC:AI3:1,ALIAS=LAS:LHN:ADC:03:PRESS_2")
dbLoadRecords("db/alias.db", "RECORD=LAS:LHN:ADC:03:BHC:AI3:2,ALIAS=LAS:LHN:ADC:03:HUMID_2")
dbLoadRecords("db/alias.db", "RECORD=LAS:LHN:ADC:03:BHC:AI3:3,ALIAS=LAS:LHN:ADC:03:TEMP_2")



dbLoadRecords( "db/iocSoft.db",            "IOC=IOC:LAS:ADC:BHC:03" )
dbLoadRecords( "db/save_restoreStatus.db", "P=IOC:LAS:ADC:BHC:03" )

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
