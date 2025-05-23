#!/reg/g/pcds/epics/ioc/common/pvNotepad/R2.1.0/bin/rhel7-x86_64/pvNotepad

epicsEnvSet( "EPICS_NAME", "IOC:MEC:PVNOTEPAD" )
epicsEnvSet( "ENGINEER",  "Peregrine McGehee (peregrin)" )
epicsEnvSet( "LOCATION",  "SLAC:LCLS:MEC" )
epicsEnvSet( "IOCSH_PS1", "ioc-mec-pvnotepad> ")
epicsEnvSet( "IOCTOP",       "/reg/g/pcds/epics/ioc/common/pvNotepad/R2.1.0" )
epicsEnvSet( "BUILD_TOP",    "/reg/g/pcds/epics/ioc/mec/pvNotepad/R1.1.0/build" )
epicsEnvSet( "EPICS_PVA_AUTO_ADDR_LIST",         "TRUE" )
epicsEnvSet( "EPICS_PVAS_AUTO_BEACON_ADDR_LIST", "TRUE" )

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

dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:USER:MCC:DPHI_REQUEST,DESC=User requested phase shift for soft undulators")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:USER:MCC:DPHI_STATE,DESC=User requested phase shift for soft undulators state")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:USER:MCC:EPHOT:SET1,PREC=16,DESC=MCC Photon Energy,DTYP=Soft Channel,SCAN=Passive,PINI=YES")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:USER:MCC:EPHOT:SET2,PREC=16,DESC=MCC Photon Energy,DTYP=Soft Channel,SCAN=Passive,PINI=YES")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:USER:MCC:EPHOT:REF1,PREC=16,DESC=MCC Photon Energy Reference,DTYP=Soft Channel,SCAN=Passive,PINI=YES")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:USER:MCC:EPHOT:REF2,PREC=16,DESC=MCC Photon Energy Reference,DTYP=Soft Channel,SCAN=Passive,PINI=YES")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:USER:MCC:EPHOT:VER,PREC=16,DESC=MCC Photon Energy PV Vernier,DTYP=Soft Channel,SCAN=Passive,PINI=YES")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:USER:MCC:EPHOT:UND,PREC=16,DESC=MCC Photon Energy PV Undulator,DTYP=Soft Channel,SCAN=Passive,PINI=YES")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:USER:MCC:EPHOT:REQ,PREC=16,DESC=MCC Photon Energy PV Request,DTYP=Soft Channel,SCAN=Passive,PINI=YES")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:USER:BYKIKS:ABORT,DESC=Did we request abort")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:USER:BYKIKS:LAST_NUM_SHOTS,DESC=The number of aborted shots before the abort was requested")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:USER:BYKIKS:ABORT_EN,DESC=Was abort enabled before emergency abort")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:USER:MCC:EPHOT:SET1,PREC=16,DESC=MCC Photon Energy,DTYP=Soft Channel,SCAN=Passive,PINI=YES")
dbLoadRecords("$(TOP)/db/special_longout.db",     "PV=MEC:SCAN:NSHOTS")
dbLoadRecords("$(TOP)/db/special_longout.db",     "PV=MEC:SCAN:NSTEPS")
dbLoadRecords("$(TOP)/db/special_longout.db",     "PV=MEC:SCAN:ISTEP")
dbLoadRecords("$(TOP)/db/special_longout.db",     "PV=MEC:SCAN:ISSCAN,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=MEC:SCAN:SCANVAR00,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=MEC:SCAN:SCANVAR01,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=MEC:SCAN:SCANVAR02,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:SCAN:MIN00")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:SCAN:MIN01")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:SCAN:MIN02")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:SCAN:MAX00")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:SCAN:MAX01")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:SCAN:MAX02")
dbLoadRecords("$(TOP)/db/special_longout.db",     "PV=MEC:VARS:INT:01")
dbLoadRecords("$(TOP)/db/special_longout.db",     "PV=MEC:VARS:INT:02")
dbLoadRecords("$(TOP)/db/special_longout.db",     "PV=MEC:VARS:INT:03")
dbLoadRecords("$(TOP)/db/special_longout.db",     "PV=MEC:VARS:INT:04")
dbLoadRecords("$(TOP)/db/special_longout.db",     "PV=MEC:VARS:INT:05")
dbLoadRecords("$(TOP)/db/special_longout.db",     "PV=MEC:VARS:INT:06")
dbLoadRecords("$(TOP)/db/special_longout.db",     "PV=MEC:VARS:INT:07")
dbLoadRecords("$(TOP)/db/special_longout.db",     "PV=MEC:VARS:INT:08")
dbLoadRecords("$(TOP)/db/special_longout.db",     "PV=MEC:VARS:INT:09")
dbLoadRecords("$(TOP)/db/special_longout.db",     "PV=MEC:VARS:INT:10")
dbLoadRecords("$(TOP)/db/special_bo.db",     "PV=MEC:VARS:BIN:01,ZNAM=False,ONAM=True,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_bo.db",     "PV=MEC:VARS:BIN:02,ZNAM=False,ONAM=True,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_bo.db",     "PV=MEC:VARS:BIN:03,ZNAM=False,ONAM=True,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_bo.db",     "PV=MEC:VARS:BIN:04,ZNAM=False,ONAM=True,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_bo.db",     "PV=MEC:VARS:BIN:05,ZNAM=False,ONAM=True,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_bo.db",     "PV=MEC:VARS:BIN:06,ZNAM=False,ONAM=True,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_bo.db",     "PV=MEC:VARS:BIN:08,ZNAM=False,ONAM=True,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_bo.db",     "PV=MEC:VARS:BIN:09,ZNAM=False,ONAM=True,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_bo.db",     "PV=MEC:VARS:BIN:10,ZNAM=False,ONAM=True,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=MEC:VARS:STRING:01,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=MEC:VARS:STRING:02,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=MEC:VARS:STRING:03,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=MEC:VARS:STRING:04,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=MEC:VARS:STRING:05,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=MEC:VARS:STRING:06,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=MEC:VARS:STRING:07,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=MEC:VARS:STRING:08,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=MEC:VARS:STRING:09,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=MEC:VARS:STRING:10,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:VARS:FLOAT:01")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:VARS:FLOAT:02")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:VARS:FLOAT:03")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:VARS:FLOAT:04")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:VARS:FLOAT:05")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:VARS:FLOAT:06")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:VARS:FLOAT:07")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:VARS:FLOAT:08")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:VARS:FLOAT:09")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:VARS:FLOAT:10")
dbLoadRecords("$(TOP)/db/special_waveform.db",     "PV=MEC:TIMETOOL:TTALL,NELM=6,NORD=3,FTYPE=DOUBLE,EGU=Counts,PREC=16,DESC=MEC TT PeakPos Ampl Vector,DTYP=Soft Channel,SCAN=Passive,PINI=YES")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:LAS:FLOAT:01")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:LAS:FLOAT:02")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:LAS:FLOAT:03")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:LAS:FLOAT:04")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:LAS:FLOAT:05")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:LAS:FLOAT:06")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:LAS:FLOAT:07")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:LAS:FLOAT:08")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:LAS:FLOAT:09")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:LAS:FLOAT:10")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:LAS:FLOAT:11")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:LAS:FLOAT:12")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:LAS:FLOAT:13")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:LAS:FLOAT:14")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:LAS:FLOAT:15")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:LAS:FLOAT:16")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:LAS:FLOAT:17")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:LAS:FLOAT:18")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:LAS:FLOAT:19")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:LAS:FLOAT:20")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:LAS:FLOAT:21")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:LAS:FLOAT:22")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:LAS:FLOAT:23")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:LAS:FLOAT:24")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:LAS:FLOAT:25")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:LAS:FLOAT:26")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:LAS:FLOAT:27")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:LAS:FLOAT:28")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:LAS:FLOAT:29")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:LAS:FLOAT:30")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:LAS:FLOAT:31")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:LAS:FLOAT:32")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:LAS:FLOAT:33")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:LAS:FLOAT:34")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:LAS:FLOAT:35")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:LAS:FLOAT:36")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:LAS:FLOAT:37")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:LAS:FLOAT:38")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:LAS:FLOAT:39")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=MEC:LAS:FLOAT:40")
dbLoadRecords("$(TOP)/db/special_array.db",     "PV=MEC:LAS:ARRAY:01,NELM=10,FTYPE=FLOAT,DESC=loaded pulse segment lengths")
dbLoadRecords("$(TOP)/db/special_array.db",     "PV=MEC:LAS:ARRAY:02,NELM=20,FTYPE=FLOAT,DESC=loaded pulse segment endpoints")
dbLoadRecords("$(TOP)/db/special_array.db",     "PV=MEC:LAS:ARRAY:03,NELM=140,FTYPE=FLOAT,DESC=Highland grafana")
dbLoadRecords("$(TOP)/db/special_array.db",     "PV=MEC:LAS:ARRAY:04,NELM=140,FTYPE=FLOAT,DESC=YFE grafana")
dbLoadRecords("$(TOP)/db/special_array.db",     "PV=MEC:LAS:ARRAY:05,NELM=140,FTYPE=FLOAT,DESC=YFEgoal grafana")
dbLoadRecords("$(TOP)/db/special_array.db",     "PV=MEC:LAS:ARRAY:06,NELM=140,FTYPE=FLOAT,DESC=1in1w grafana")
dbLoadRecords("$(TOP)/db/special_array.db",     "PV=MEC:LAS:ARRAY:07,NELM=140,FTYPE=FLOAT,DESC=2in1w grafana")
dbLoadRecords("$(TOP)/db/special_array.db",     "PV=MEC:LAS:ARRAY:08,NELM=140,FTYPE=FLOAT,DESC=2in2w grafana")
dbLoadRecords("$(TOP)/db/special_array.db",     "PV=MEC:LAS:ARRAY:09,NELM=140,FTYPE=FLOAT,DESC=2in2wgoal grafana")
dbLoadRecords("$(TOP)/db/special_array.db",     "PV=MEC:LAS:ARRAY:10,NELM=140,FTYPE=FLOAT,DESC=Spare grafana")
dbLoadRecords("$(TOP)/db/special_array.db",     "PV=MEC:LAS:ARRAY:11,NELM=1000,FTYPE=FLOAT,DESC=Grafana")
dbLoadRecords("$(TOP)/db/special_array.db",     "PV=MEC:LAS:ARRAY:12,NELM=1000,FTYPE=FLOAT,DESC=Grafana")
dbLoadRecords("$(TOP)/db/special_array.db",     "PV=MEC:LAS:ARRAY:13,NELM=1000,FTYPE=FLOAT,DESC=Grafana")
dbLoadRecords("$(TOP)/db/special_array.db",     "PV=MEC:LAS:ARRAY:14,NELM=1000,FTYPE=FLOAT,DESC=Grafana")

# Setup autosave
save_restoreSet_status_prefix("$(EPICS_NAME):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

set_requestfile_path( "$(PWD)/../../autosave"             )
set_savefile_path   ( "$(IOC_DATA)/ioc-mec-pvnotepad/autosave" )

set_pass0_restoreFile( "ioc-mec-pvnotepad.sav" )        #just restore the settings
set_pass1_restoreFile( "ioc-mec-pvnotepad.sav" )        #just restore the settings


# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set( "ioc-mec-pvnotepad.req", 30, "" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

