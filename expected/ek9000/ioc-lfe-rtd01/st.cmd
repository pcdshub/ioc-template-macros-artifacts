#!/reg/g/pcds/epics/ioc/tmo/ek9000/R1.0.3/bin/rhel7-x86_64/ek9000IOC

epicsEnvSet("IOCNAME", "ioc-lfe-rtd01")
epicsEnvSet("ENGINEER", "Jeremy Lorelli (lorelli)")
epicsEnvSet("LOCATION", "L0S19-L0S10")
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> ")
epicsEnvSet("IOC_PV", "IOC:LFE:RTD:01")
epicsEnvSet("IOCTOP", "/reg/g/pcds/epics/ioc/tmo/ek9000/R1.0.3")

< envPaths
epicsEnvSet("TOP", "/reg/g/pcds/epics/ioc/tmo/ek9000/R1.0.3/children/build")
cd ("$(IOCTOP)")

< /reg/d/iocCommon/All/pre_linux.cmd

## Register all support components
dbLoadDatabase("dbd/ek9000IOC.dbd")
ek9000IOC_registerRecordDeviceDriver(pdbbase)

# Configure all EK9000 devices
ek9000Configure("M1L0-HXR1-EK9000","bcp-lfe-01",502,4)
ek9000Configure("M2L0-HXR2-EK9000","bcp-lfe-02",502,3)

#=====================================================#
# Now add all the terminals and load the records
ek9000ConfigureTerminal("M1L0-HXR1-EK9000","L0S6:RTD:1:TEMP","EL3202",1)
dbLoadRecords("db/EL3202.template", "TERMINAL=L0S6:RTD:1:TEMP")
ek9000ConfigureTerminal("M1L0-HXR1-EK9000","L0S8:RTD:1:TEMP","EL3202",2)
dbLoadRecords("db/EL3202.template", "TERMINAL=L0S8:RTD:1:TEMP")
ek9000ConfigureTerminal("M1L0-HXR1-EK9000","MR1L0:RTD:1:TEMP","EL3202",3)
dbLoadRecords("db/EL3202.template", "TERMINAL=MR1L0:RTD:1:TEMP")
ek9000ConfigureTerminal("M1L0-HXR1-EK9000","MR1L0:RTD:3:TEMP","EL3202",4)
dbLoadRecords("db/EL3202.template", "TERMINAL=MR1L0:RTD:3:TEMP")
ek9000ConfigureTerminal("M2L0-HXR2-EK9000","MR2L0:RTD:1:TEMP","EL3202",1)
dbLoadRecords("db/EL3202.template", "TERMINAL=MR2L0:RTD:1:TEMP")
ek9000ConfigureTerminal("M2L0-HXR2-EK9000","MR2L0:RTD:3:TEMP","EL3202",2)
dbLoadRecords("db/EL3202.template", "TERMINAL=MR2L0:RTD:3:TEMP")
ek9000ConfigureTerminal("M2L0-HXR2-EK9000","TV3L0:RTD:1:TEMP","EL3202",3)
dbLoadRecords("db/EL3202.template", "TERMINAL=TV3L0:RTD:1:TEMP")



#=====================================================#



# Now add all the terminals and load the records





dbLoadRecords("db/alias.db", "RECORD=L0S6:RTD:1:TEMP:1,ALIAS=L0S6:RTD:1:TEMP")
dbLoadRecords("db/alias.db", "RECORD=L0S6:RTD:1:TEMP:2,ALIAS=L0S7:RTD:1:TEMP")
dbLoadRecords("db/alias.db", "RECORD=L0S8:RTD:1:TEMP:1,ALIAS=L0S8:RTD:1:TEMP")
dbLoadRecords("db/alias.db", "RECORD=L0S8:RTD:1:TEMP:2,ALIAS=L0S9:RTD:1:TEMP")
dbLoadRecords("db/alias.db", "RECORD=MR1L0:RTD:1:TEMP:1,ALIAS=MR1L0:RTD:1:TEMP")
dbLoadRecords("db/alias.db", "RECORD=MR1L0:RTD:1:TEMP:2,ALIAS=MR1L0:RTD:2:TEMP")
dbLoadRecords("db/alias.db", "RECORD=MR1L0:RTD:3:TEMP:1,ALIAS=MR1L0:RTD:3:TEMP")
dbLoadRecords("db/alias.db", "RECORD=MR1L0:RTD:3:TEMP:2,ALIAS=MR1L0:RTD:4:TEMP")
dbLoadRecords("db/alias.db", "RECORD=MR2L0:RTD:1:TEMP:1,ALIAS=MR2L0:RTD:1:TEMP")
dbLoadRecords("db/alias.db", "RECORD=MR2L0:RTD:1:TEMP:2,ALIAS=MR2L0:RTD:2:TEMP")
dbLoadRecords("db/alias.db", "RECORD=MR2L0:RTD:3:TEMP:1,ALIAS=MR2L0:RTD:3:TEMP")
dbLoadRecords("db/alias.db", "RECORD=MR2L0:RTD:3:TEMP:2,ALIAS=MR2L0:RTD:4:TEMP")
dbLoadRecords("db/alias.db", "RECORD=TV3L0:RTD:1:TEMP:1,ALIAS=TV3L0:RTD:1:TEMP")
dbLoadRecords("db/alias.db", "RECORD=TV3L0:RTD:1:TEMP:2,ALIAS=PC3L0:RTD:1:TEMP")



dbLoadRecords( "db/iocSoft.db",            "IOC=IOC:LFE:RTD:01" )
dbLoadRecords( "db/save_restoreStatus.db", "P=IOC:LFE:RTD:01" )

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
