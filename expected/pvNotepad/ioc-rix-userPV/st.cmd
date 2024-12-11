#!/reg/g/pcds/epics/ioc/common/pvNotepad/R2.0.3/bin/rhel7-x86_64/pvNotepad

epicsEnvSet( "EPICS_NAME", "IOC:RIX:USERPV" )
epicsEnvSet( "ENGINEER",  "Silke Nelson (snelson)" )
epicsEnvSet( "LOCATION",  "SLAC:LCLS:RIX" )
epicsEnvSet( "IOCSH_PS1", "ioc-rix-userPV> ")

< envPaths

# Run common startup commands for linux soft IOC's
< /reg/d/iocCommon/All/pre_linux.cmd

# Register all support components
dbLoadDatabase("$(TOP)/dbd/pvNotepad.dbd")
pvNotepad_registerRecordDeviceDriver(pdbbase)

# Load record instances
dbLoadRecords("$(TOP)/db/iocSoft.db",            "IOC=$(EPICS_NAME)" )
dbLoadRecords("$(TOP)/db/save_restoreStatus.db", "P=$(EPICS_NAME):" )

#Standard array option

dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=RIX:USER:MCC:DPHI_REQUEST,DESC=User requested phase shift for soft undulators")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=RIX:USER:MCC:DPHI_STATE,DESC=User requested phase shift for soft undulators state")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=RIX:USER:MCC:EPHOTK:SET1,PREC=16,DESC=MCC Photon Energy,DTYP=Soft Channel,SCAN=Passive,PINI=YES")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=RIX:USER:MCC:EPHOTK:SET2,PREC=16,DESC=MCC Photon Energy,DTYP=Soft Channel,SCAN=Passive,PINI=YES")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=RIX:USER:MCC:EPHOTK:REF1,PREC=16,DESC=MCC Photon Energy Reference,DTYP=Soft Channel,SCAN=Passive,PINI=YES")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=RIX:USER:MCC:EPHOTK:REF2,PREC=16,DESC=MCC Photon Energy Reference,DTYP=Soft Channel,SCAN=Passive,PINI=YES")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=RIX:USER:MCC:EPHOTK:VER,PREC=16,DESC=MCC Photon Energy PV Vernier,DTYP=Soft Channel,SCAN=Passive,PINI=YES")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=RIX:USER:MCC:EPHOTK:UND,PREC=16,DESC=MCC Photon Energy PV Undulator,DTYP=Soft Channel,SCAN=Passive,PINI=YES")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=RIX:USER:MCC:EPHOTK:REQ,PREC=16,DESC=MCC Photon Energy PV Request,DTYP=Soft Channel,SCAN=Passive,PINI=YES")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=RIX:USER:BYKIKS:ABORT,DESC=Did we request abort")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=RIX:USER:BYKIKS:LAST_NUM_SHOTS,DESC=The number of aborted shots before the abort was requested")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=RIX:USER:BYKIKS:ABORT_EN,DESC=Was abort enabled before emergency abort")
dbLoadRecords("$(TOP)/db/special_longout.db",     "PV=RIX:SCAN:NSHOTS")
dbLoadRecords("$(TOP)/db/special_longout.db",     "PV=RIX:SCAN:NSTEPS")
dbLoadRecords("$(TOP)/db/special_longout.db",     "PV=RIX:SCAN:ISTEP")
dbLoadRecords("$(TOP)/db/special_longout.db",     "PV=RIX:SCAN:ISSCAN,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=RIX:SCAN:SCANVAR00,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=RIX:SCAN:SCANVAR01,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=RIX:SCAN:SCANVAR02,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=RIX:SCAN:MIN00")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=RIX:SCAN:MIN01")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=RIX:SCAN:MIN02")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=RIX:SCAN:MAX00")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=RIX:SCAN:MAX01")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=RIX:SCAN:MAX02")
dbLoadRecords("$(TOP)/db/special_longout.db",     "PV=RIX:VARS:INT:01")
dbLoadRecords("$(TOP)/db/special_longout.db",     "PV=RIX:VARS:INT:02")
dbLoadRecords("$(TOP)/db/special_longout.db",     "PV=RIX:VARS:INT:03")
dbLoadRecords("$(TOP)/db/special_longout.db",     "PV=RIX:VARS:INT:04")
dbLoadRecords("$(TOP)/db/special_longout.db",     "PV=RIX:VARS:INT:05")
dbLoadRecords("$(TOP)/db/special_longout.db",     "PV=RIX:VARS:INT:06")
dbLoadRecords("$(TOP)/db/special_longout.db",     "PV=RIX:VARS:INT:07")
dbLoadRecords("$(TOP)/db/special_longout.db",     "PV=RIX:VARS:INT:08")
dbLoadRecords("$(TOP)/db/special_longout.db",     "PV=RIX:VARS:INT:09")
dbLoadRecords("$(TOP)/db/special_longout.db",     "PV=RIX:VARS:INT:10")
dbLoadRecords("$(TOP)/db/special_bo.db",     "PV=RIX:VARS:BIN:01,ZNAM=False,ONAM=True,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_bo.db",     "PV=RIX:VARS:BIN:02,ZNAM=False,ONAM=True,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_bo.db",     "PV=RIX:VARS:BIN:03,ZNAM=False,ONAM=True,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_bo.db",     "PV=RIX:VARS:BIN:04,ZNAM=False,ONAM=True,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_bo.db",     "PV=RIX:VARS:BIN:05,ZNAM=False,ONAM=True,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_bo.db",     "PV=RIX:VARS:BIN:06,ZNAM=False,ONAM=True,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_bo.db",     "PV=RIX:VARS:BIN:07,ZNAM=False,ONAM=True,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_bo.db",     "PV=RIX:VARS:BIN:08,ZNAM=False,ONAM=True,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_bo.db",     "PV=RIX:VARS:BIN:09,ZNAM=False,ONAM=True,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_bo.db",     "PV=RIX:VARS:BIN:10,ZNAM=False,ONAM=True,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=RIX:VARS:STRING:01,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=RIX:VARS:STRING:02,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=RIX:VARS:STRING:03,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=RIX:VARS:STRING:04,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=RIX:VARS:STRING:05,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=RIX:VARS:STRING:06,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=RIX:VARS:STRING:07,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=RIX:VARS:STRING:08,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=RIX:VARS:STRING:09,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=RIX:VARS:STRING:10,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=RIX:VARS:FLOAT:01")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=RIX:VARS:FLOAT:02")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=RIX:VARS:FLOAT:03")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=RIX:VARS:FLOAT:04")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=RIX:VARS:FLOAT:05")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=RIX:VARS:FLOAT:06")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=RIX:VARS:FLOAT:07")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=RIX:VARS:FLOAT:08")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=RIX:VARS:FLOAT:09")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=RIX:VARS:FLOAT:10")
dbLoadRecords("$(TOP)/db/special_waveform.db",     "PV=RIX:TIMETOOL:TTALL,NELM=6,NORD=3,FTYPE=DOUBLE,EGU=Counts,PREC=16,DESC=RIX TT PeakPos Ampl Vector,DTYP=Soft Channel,SCAN=Passive,PINI=YES")

# Setup autosave
save_restoreSet_status_prefix("$(EPICS_NAME):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

set_requestfile_path( "$(PWD)/../../autosave"             )
set_savefile_path   ( "$(IOC_DATA)/ioc-rix-userPV/autosave" )

set_pass0_restoreFile( "ioc-rix-userPV.sav" )        #just restore the settings
set_pass1_restoreFile( "ioc-rix-userPV.sav" )        #just restore the settings


# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set( "ioc-rix-userPV.req", 30, "" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

