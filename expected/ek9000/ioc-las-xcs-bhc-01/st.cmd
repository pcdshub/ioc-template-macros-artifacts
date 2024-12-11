#!/cds/group/pcds/epics/ioc/common/ek9000/R1.7.3/bin/rhel7-x86_64/ek9000IOC

epicsEnvSet("IOCNAME", "ioc-las-xcs-bhc-01")
epicsEnvSet("ENGINEER", "Lana Jansen-Whealey (ljansen7)")
epicsEnvSet("LOCATION", "LAS TIMING ADC XCS")
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> ")
epicsEnvSet("IOC_PV", "IOC:LAS:XCS:BHC:01")
epicsEnvSet("IOCTOP", "/cds/group/pcds/epics/ioc/common/ek9000/R1.7.3")

< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/las/ek9000/R2.0.0/build")
cd ("$(IOCTOP)")

< /reg/d/iocCommon/All/pre_linux.cmd

## Register all support components
dbLoadDatabase("dbd/ek9000IOC.dbd")
ek9000IOC_registerRecordDeviceDriver(pdbbase)

# Configure all EK9000 devices
ek9000Configure("LAS-XCS-ADC-EK9K1","bhc-las-xcs-01",502,5)
# TODO: Uncomment me after R.1.7.2!!!
#dbLoadRecords("db/ek9000_status.db", "RECORD=IOC:LAS:XCS:BHC:01:LAS-XCS-ADC-EK9K1,EK9K=LAS-XCS-ADC-EK9K1")

#=====================================================#
# Now add all the terminals and load the records
ek9000ConfigureTerminal("LAS-XCS-ADC-EK9K1","LAS:XCS:ADC:01:BHC:AI1","EL3174",2)
dbLoadRecords("db/EL3174.template", "TERMINAL=LAS:XCS:ADC:01:BHC:AI1,DEVICE=LAS-XCS-ADC-EK9K1,POS=2")
ek9000ConfigureTerminal("LAS-XCS-ADC-EK9K1","LAS:XCS:ADC:01:BHC:AI2","EL3174",3)
dbLoadRecords("db/EL3174.template", "TERMINAL=LAS:XCS:ADC:01:BHC:AI2,DEVICE=LAS-XCS-ADC-EK9K1,POS=3")
ek9000ConfigureTerminal("LAS-XCS-ADC-EK9K1","LAS:XCS:ADC:01:BHC:AI3","EL3174",4)
dbLoadRecords("db/EL3174.template", "TERMINAL=LAS:XCS:ADC:01:BHC:AI3,DEVICE=LAS-XCS-ADC-EK9K1,POS=4")
ek9000ConfigureTerminal("LAS-XCS-ADC-EK9K1","LAS:XCS:ADC:01:BHC:AI4","EL3174",5)
dbLoadRecords("db/EL3174.template", "TERMINAL=LAS:XCS:ADC:01:BHC:AI4,DEVICE=LAS-XCS-ADC-EK9K1,POS=5")

ek9000ConfigureTerminal("LAS-XCS-ADC-EK9K1","LAS:XCS:ADC:01:BHC:AO1","EL4104",1)
dbLoadRecords("db/EL4104.template", "TERMINAL=LAS:XCS:ADC:01:BHC:AO1,DEVICE=LAS-XCS-ADC-EK9K1,POS=1")


#=====================================================#



# Now add all the terminals and load the records




dbLoadRecords("db/alias.db", "RECORD=LAS:XCS:ADC:01:BHC:AO1:1,ALIAS=LAS:XCS:ADC:01:RF_LOCK")
dbLoadRecords("db/alias.db", "RECORD=LAS:XCS:ADC:01:BHC:AO1:2,ALIAS=LAS:XCS:ADC:01:FB_GAIN")

dbLoadRecords("db/alias.db", "RECORD=LAS:XCS:ADC:01:BHC:AI1:1,ALIAS=LAS:XCS:ADC:01:RF_PWR")
dbLoadRecords("db/alias.db", "RECORD=LAS:XCS:ADC:01:BHC:AI1:2,ALIAS=LAS:XCS:ADC:01:DIODE_PWR")
dbLoadRecords("db/alias.db", "RECORD=LAS:XCS:ADC:01:BHC:AI1:3,ALIAS=LAS:XCS:ADC:01:PIEZO_MON")
dbLoadRecords("db/alias.db", "RECORD=LAS:XCS:ADC:01:BHC:AI1:4,ALIAS=LAS:XCS:ADC:01:TIME_ERR")
dbLoadRecords("db/alias.db", "RECORD=LAS:XCS:ADC:01:BHC:AI2:1,ALIAS=LAS:XCS:ADC:01:PRESS_1")
dbLoadRecords("db/alias.db", "RECORD=LAS:XCS:ADC:01:BHC:AI2:2,ALIAS=LAS:XCS:ADC:01:HUMID_1")
dbLoadRecords("db/alias.db", "RECORD=LAS:XCS:ADC:01:BHC:AI2:3,ALIAS=LAS:XCS:ADC:01:TEMP_1")
dbLoadRecords("db/alias.db", "RECORD=LAS:XCS:ADC:01:BHC:AI4:1,ALIAS=LAS:XCS:ADC:01:PRESS_2")
dbLoadRecords("db/alias.db", "RECORD=LAS:XCS:ADC:01:BHC:AI4:2,ALIAS=LAS:XCS:ADC:01:HUMID_2")
dbLoadRecords("db/alias.db", "RECORD=LAS:XCS:ADC:01:BHC:AI4:3,ALIAS=LAS:XCS:ADC:01:TEMP_2")



dbLoadRecords( "db/iocSoft.db",            "IOC=IOC:LAS:XCS:BHC:01" )
dbLoadRecords( "db/save_restoreStatus.db", "P=IOC:LAS:XCS:BHC:01" )

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
