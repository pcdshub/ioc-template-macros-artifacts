#!$$IOCTOP/bin/rhel7-x86_64/ek9000IOC

epicsEnvSet("IOCNAME", "$$IOCNAME")
epicsEnvSet("ENGINEER", "$$ENGINEER")
epicsEnvSet("LOCATION", "$$LOCATION")
epicsEnvSet("IOCSH_PS1", "$(IOCNAME)> ")
epicsEnvSet("IOC_PV", "$$IOC_PV")
epicsEnvSet("IOCTOP", "$$IOCTOP")

< envPaths
epicsEnvSet("TOP", "$$TOP")
cd ("$(IOCTOP)")

< /reg/d/iocCommon/All/pre_linux.cmd

## Register all support components
dbLoadDatabase("dbd/ek9000IOC.dbd")
ek9000IOC_registerRecordDeviceDriver(pdbbase)

# Configure all EK9000 devices
$$LOOP(EK9000)
ek9000Configure("$$NAME","$$IP",$$PORT,$$SLAVES)
# TODO: Uncomment me after R.1.7.2!!!
#dbLoadRecords("db/ek9000_status.db", "RECORD=$$IOC_PV:$$NAME,EK9K=$$NAME")
$$ENDLOOP(EK9000)

#=====================================================#
# Now add all the terminals and load the records
$$LOOP(TERMINAL_N_AI)
ek9000ConfigureTerminal("$$EK9000","$$RECORD","$$TYPE",$$SLAVE)
dbLoadRecords("db/$$TYPE.template", "TERMINAL=$$RECORD,DEVICE=$$EK9000,POS=$$SLAVE")
$$ENDLOOP(TERMINAL_N_AI)

$$LOOP(TERMINAL_N_AO)
ek9000ConfigureTerminal("$$EK9000","$$RECORD","$$TYPE",$$SLAVE)
dbLoadRecords("db/$$TYPE.template", "TERMINAL=$$RECORD,DEVICE=$$EK9000,POS=$$SLAVE")
$$ENDLOOP(TERMINAL_N_AO)

$$LOOP(TERMINAL_N_BO)
ek9000ConfigureTerminal("$$EK9000","$$RECORD","$$TYPE",$$SLAVE)
dbLoadRecords("db/$$TYPE.template", "TERMINAL=$$RECORD,DEVICE=$$EK9000,POS=$$SLAVE")
$$ENDLOOP(TERMINAL_N_BO)

$$LOOP(TERMINAL_N_BI)
ek9000ConfigureTerminal("$$EK9000","$$RECORD","$$TYPE",$$SLAVE)
dbLoadRecords("db/$$TYPE.template", "TERMINAL=$$RECORD,DEVICE=$$EK9000,POS=$$SLAVE")
$$ENDLOOP(TERMINAL_N_BI)
#=====================================================#



# Now add all the terminals and load the records
$$LOOP(TERMINAL_AI)
ek9000ConfigureTerminal("$$EK9000","$$RECORD","$$TYPE",$$SLAVE)
dbLoadRecords("db/$$TYPE.template", "TERMINAL=$$RECORD,DEVICE=$$EK9000,POS=$$SLAVE")
$$ENDLOOP(TERMINAL_AI)

$$LOOP(TERMINAL_AO)
ek9000ConfigureTerminal("$$EK9000","$$RECORD","$$TYPE",$$SLAVE)
dbLoadRecords("db/$$TYPE.template", "TERMINAL=$$RECORD,DEVICE=$$EK9000,POS=$$SLAVE")
$$ENDLOOP(TERMINAL_AO)

$$LOOP(TERMINAL_BO)
ek9000ConfigureTerminal("$$EK9000","$$RECORD","$$TYPE",$$SLAVE)
dbLoadRecords("db/$$TYPE.template", "TERMINAL=$$RECORD,DEVICE=$$EK9000,POS=$$SLAVE")
$$ENDLOOP(TERMINAL_BO)

$$LOOP(TERMINAL_BI)
ek9000ConfigureTerminal("$$EK9000","$$RECORD","$$TYPE",$$SLAVE)
dbLoadRecords("db/$$TYPE.template", "TERMINAL=$$RECORD,DEVICE=$$EK9000,POS=$$SLAVE")
$$ENDLOOP(TERMINAL_BI)

$$LOOP(ALIAS_AO)
dbLoadRecords("db/alias.db", "RECORD=$$RECORD,ALIAS=$$ALIAS")
$$ENDLOOP(ALIAS_AO)

$$LOOP(ALIAS_AI)
dbLoadRecords("db/alias.db", "RECORD=$$RECORD,ALIAS=$$ALIAS")
$$ENDLOOP(ALIAS_AI)

$$LOOP(ALIAS_BI)
dbLoadRecords("db/alias.db", "RECORD=$$RECORD,ALIAS=$$ALIAS")
$$ENDLOOP(ALIAS_BI)

$$LOOP(ALIAS_BO)
dbLoadRecords("db/alias.db", "RECORD=$$RECORD,ALIAS=$$ALIAS")
$$ENDLOOP(ALIAS_BO)

dbLoadRecords( "db/iocSoft.db",            "IOC=$$IOC_PV" )
dbLoadRecords( "db/save_restoreStatus.db", "P=$$IOC_PV" )

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
