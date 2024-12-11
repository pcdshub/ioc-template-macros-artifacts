#!/reg/g/pcds/epics/ioc/tmo/ek9000/R1.0.3/bin/rhel7-x86_64/ek9000IOC

epicsEnvSet("IOCNAME", "ioc-kfe-rtd01")
epicsEnvSet("ENGINEER", "Jeremy Lorelli (lorelli)")
epicsEnvSet("LOCATION", "K0S5")
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> ")
epicsEnvSet("IOC_PV", "IOC:KFE:RTD:01")
epicsEnvSet("IOCTOP", "/reg/g/pcds/epics/ioc/tmo/ek9000/R1.0.3")

< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/tmo/ek9000/R1.0.3/children/build")
cd ("$(IOCTOP)")

< /reg/d/iocCommon/All/pre_linux.cmd

## Register all support components
dbLoadDatabase("dbd/ek9000IOC.dbd")
ek9000IOC_registerRecordDeviceDriver(pdbbase)

# Configure all EK9000 devices
ek9000Configure("SXR1-EK9K","bcp-kfe-01",502,2)
ek9000Configure("SXR2-EK9K","bcp-kfe-02",502,3)

#=====================================================#
# Now add all the terminals and load the records
ek9000ConfigureTerminal("SXR1-EK9K","K0S02:RTD:1:TEMP","EL3202",1)
dbLoadRecords("db/EL3202.template", "TERMINAL=K0S02:RTD:1:TEMP")
ek9000ConfigureTerminal("SXR1-EK9K","SL2K0:RTD:1:TEMP","EL3202",2)
dbLoadRecords("db/EL3202.template", "TERMINAL=SL2K0:RTD:1:TEMP")
ek9000ConfigureTerminal("SXR2-EK9K","MR1K4:RTD:1:TEMP","EL3202",1)
dbLoadRecords("db/EL3202.template", "TERMINAL=MR1K4:RTD:1:TEMP")
ek9000ConfigureTerminal("SXR2-EK9K","MR1K4:RTD:2:TEMP","EL3202",2)
dbLoadRecords("db/EL3202.template", "TERMINAL=MR1K4:RTD:2:TEMP")
ek9000ConfigureTerminal("SXR2-EK9K","IM1K4:RTD:1:TEMP","EL3202",3)
dbLoadRecords("db/EL3202.template", "TERMINAL=IM1K4:RTD:1:TEMP")



#=====================================================#



# Now add all the terminals and load the records





dbLoadRecords("db/alias.db", "RECORD=K0S02:RTD:1:TEMP:1,ALIAS=K0S02:RTD:1:TEMP")
dbLoadRecords("db/alias.db", "RECORD=K0S02:RTD:2:TEMP:2,ALIAS=K0S03:RTD:1:TEMP")
dbLoadRecords("db/alias.db", "RECORD=SL2K0:RTD:1:TEMP:1,ALIAS=SL2K0:RTD:1:TEMP")
dbLoadRecords("db/alias.db", "RECORD=MR1K4:RTD:1:TEMP:1,ALIAS=MR1K4:RTD:1:TEMP")
dbLoadRecords("db/alias.db", "RECORD=MR1K4:RTD:1:TEMP:2,ALIAS=MR1K4:RTD:2:TEMP")
dbLoadRecords("db/alias.db", "RECORD=MR1K4:RTD:2:TEMP:1,ALIAS=MR1K4:RTD:3:TEMP")
dbLoadRecords("db/alias.db", "RECORD=MR1K4:RTD:2:TEMP:2,ALIAS=MR1K4:RTD:4:TEMP")
dbLoadRecords("db/alias.db", "RECORD=IM1K4:RTD:1:TEMP:1,ALIAS=K4S20:RTD:1:TEMP")
dbLoadRecords("db/alias.db", "RECORD=IM4K4:RTD:1:TEMP:1,ALIAS=IM1K4:RTD:1:TEMP")



dbLoadRecords( "db/iocSoft.db",            "IOC=IOC:KFE:RTD:01" )
dbLoadRecords( "db/save_restoreStatus.db", "P=IOC:KFE:RTD:01" )

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
