#!/reg/g/pcds/package/epics/3.14/ioc/common/pvNotepad/R1.3.1/bin/linux-x86_64/pvNotepad

epicsEnvSet( "EPICS_NAME", "IOC:CXI:USERPV" )
epicsEnvSet( "ENGINEER",  "Teddy Rendahl (trendahl)" )
epicsEnvSet( "LOCATION",  "SLAC:LCLS:CXI" )
epicsEnvSet( "IOCSH_PS1", "ioc-cxi-userPV> ")

< envPaths

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("$(TOP)/dbd/pvNotepad.dbd")
pvNotepad_registerRecordDeviceDriver(pdbbase)

# Load record instances
dbLoadRecords("$(TOP)/db/iocSoft.db",            "IOC=$(EPICS_NAME)" )
dbLoadRecords("$(TOP)/db/save_restoreStatus.db", "IOC=$(EPICS_NAME)" )

#Standard array option

dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:VARS:INT:01,RECTYPE=longout")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:VARS:INT:02,RECTYPE=longout")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:VARS:INT:03,RECTYPE=longout")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:VARS:INT:04,RECTYPE=longout")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:VARS:INT:05,RECTYPE=longout")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:VARS:INT:06,RECTYPE=longout")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:VARS:INT:07,RECTYPE=longout")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:VARS:INT:08,RECTYPE=longout")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:VARS:INT:09,RECTYPE=longout")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:VARS:INT:10,RECTYPE=longout")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:VARS:BIN:01,RECTYPE=bo")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:VARS:BIN:02,RECTYPE=bo")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:VARS:BIN:03,RECTYPE=bo")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:VARS:BIN:04,RECTYPE=bo")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:VARS:BIN:05,RECTYPE=bo")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:VARS:BIN:06,RECTYPE=bo")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:VARS:BIN:07,RECTYPE=bo")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:VARS:BIN:08,RECTYPE=bo")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:VARS:BIN:09,RECTYPE=bo")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:VARS:BIN:10,RECTYPE=bo")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:VARS:STRING:01,RECTYPE=stringin")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:VARS:STRING:02,RECTYPE=stringin")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:VARS:STRING:03,RECTYPE=stringin")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:VARS:STRING:04,RECTYPE=stringin")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:VARS:STRING:05,RECTYPE=stringin")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:VARS:STRING:06,RECTYPE=stringin")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:VARS:STRING:07,RECTYPE=stringin")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:VARS:STRING:08,RECTYPE=stringin")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:VARS:STRING:09,RECTYPE=stringin")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:VARS:STRING:10,RECTYPE=stringin")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:VARS:FLOAT:01,RECTYPE=ao")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:VARS:FLOAT:02,RECTYPE=ao")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:VARS:FLOAT:03,RECTYPE=ao")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:VARS:FLOAT:04,RECTYPE=ao")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:VARS:FLOAT:05,RECTYPE=ao")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:VARS:FLOAT:06,RECTYPE=ao")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:VARS:FLOAT:07,RECTYPE=ao")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:VARS:FLOAT:08,RECTYPE=ao")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:VARS:FLOAT:09,RECTYPE=ao")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:VARS:FLOAT:10,RECTYPE=ao")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:DAQ:CPV:NUM_VAL:01,RECTYPE=ao")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:DAQ:CPV:NUM_VAL:02,RECTYPE=ao")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:DAQ:CPV:NUM_VAL:03,RECTYPE=ao")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:DAQ:NEVT,RECTYPE=longout")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:DAQ:RUNNO,RECTYPE=longout")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:DAQ:BEGIN,RECTYPE=bo")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:DAQ:END,RECTYPE=bo")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:DAQ:WAIT,RECTYPE=bo")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:DAQ:DCONNECT,RECTYPE=bo")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:DAQ:CONNECT,RECTYPE=bo")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:DAQ:CONF,RECTYPE=bo")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:DAQ:EXP,RECTYPE=bo")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:DAQ:COLLDONE,RECTYPE=bo")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:DAQ:CPV:STR_DESC:01,RECTYPE=stringin")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:DAQ:CPV:STR_DESC:02,RECTYPE=stringin")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:DAQ:CPV:STR_DESC:03,RECTYPE=stringin")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:DAQ:CPV:STR_VAL:01,RECTYPE=stringin")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:DAQ:CPV:STR_VAL:02,RECTYPE=stringin")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:DAQ:CPV:STR_VAL:03,RECTYPE=stringin")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:DAQ:CPV:NUM_DESC:01,RECTYPE=stringin")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:DAQ:CPV:NUM_DESC:02,RECTYPE=stringin")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:DAQ:CPV:NUM_DESC:03,RECTYPE=stringin")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:SCAN:NSHOTS,RECTYPE=longout")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:SCAN:NSTEPS,RECTYPE=longout")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:SCAN:ISTEP,RECTYPE=longout")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:SCAN:ISSCAN,RECTYPE=longout")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:SCAN:SCANVAR00,RECTYPE=stringin")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:SCAN:SCANVAR01,RECTYPE=stringin")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:SCAN:SCANVAR02,RECTYPE=stringin")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:SCAN:MIN00,RECTYPE=ao")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:SCAN:MIN01,RECTYPE=ao")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:SCAN:MIN02,RECTYPE=ao")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:SCAN:MAX00,RECTYPE=ao")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:SCAN:MAX01,RECTYPE=ao")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:SCAN:MAX02,RECTYPE=ao")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:USER:MCC:EPHOT,RECTYPE=ao,PREC=16,DESC=MCC Photon Energy")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:USER:FS5:T0_SHIFTER,RECTYPE=ao,PREC=16,DESC=CXI Laser FS5 T0_SHIFTER")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:USER:LAS:T0_MONITOR,RECTYPE=ao,PREC=16,DESC=CXI Laser T0_MONITOR")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:USER:LAS:E_PULSE,RECTYPE=ao,PREC=16,DESC=CXI Laser E_PULSE")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:USER:LAS:E0,RECTYPE=ao,PREC=16,DESC=CXI Laser E0")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:USER:LAS:E_LEAK,RECTYPE=ao,PREC=16,DESC=CXI Laser E_LEAK")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:USER:LAS:TIME_DELAY,RECTYPE=ao,PREC=16,DESC=CXI Laser Time Delay")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:USER:LAS:FS5_MIN,RECTYPE=ao,PREC=16,DESC=CXI Laser FS5 Min")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:USER:LAS:FS5_MAX,RECTYPE=ao,PREC=16,DESC=CXI Laser FS5 MAX")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:USER:LAS:EVR0_OSC,RECTYPE=ao,PREC=16,DESC=CXI Laser EVR0_Osc.")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:USER:LAS:EVR0_GATE,RECTYPE=ao,PREC=16,DESC=CXI Laser EVR0 Gate")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:USER:LAS:SDG0,RECTYPE=ao,PREC=16,DESC=CXI Laser SDG0")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:USER:LAS:E_PULSE2,RECTYPE=ao,PREC=16,DESC=CXI Laser 2 E_Pulse")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:USER:LAS:E02,RECTYPE=ao,PREC=16,DESC=CXI Laser 2 E0")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:USER:LAS:E_LEAK2,RECTYPE=ao,PREC=16,DESC=CXI Laser 2 E_LEAK")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:USER:VIT:T0,RECTYPE=ao,PREC=16,DESC=CXI Laser Vitara T0")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:USER:VIT:TD,RECTYPE=ao,PREC=16,DESC=CXI Laser Vitara TD")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:USER:LXT,RECTYPE=ao,PREC=16,DESC=CXI LXT")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=CXI:USER:LXTTC,RECTYPE=ao,PREC=16,DESC=CXI LXTTC")

# Setup autosave
save_restoreSet_status_prefix("$(EPICS_NAME):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

set_requestfile_path( "$(PWD)/../../autosave"             )
set_savefile_path   ( "$(IOC_DATA)/ioc-cxi-userPV/autosave" )

set_pass0_restoreFile( "ioc-cxi-userPV.sav" )        #just restore the settings
set_pass1_restoreFile( "ioc-cxi-userPV.sav" )        #just restore the settings


# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set( "ioc-cxi-userPV.req", 30, "" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

