#!/reg/g/pcds/epics/ioc/common/pvNotepad/R2.1.0/bin/rhel7-x86_64/pvNotepad

epicsEnvSet( "EPICS_NAME", "IOC:TMO:USERPV" )
epicsEnvSet( "ENGINEER",  "Silke Nelson (snelson)" )
epicsEnvSet( "LOCATION",  "SLAC:LCLS:TMO" )
epicsEnvSet( "IOCSH_PS1", "ioc-tmo-userPV> ")
epicsEnvSet( "IOCTOP",       "/reg/g/pcds/epics/ioc/common/pvNotepad/R2.1.0" )
epicsEnvSet( "BUILD_TOP",    "/reg/g/pcds/epics/ioc/tmo/pvNotepad/R1.2.0/build" )
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

dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=TMO:USER:MCC:EPHOTK:VER,PREC=16,DESC=MCC Photon Energy,DTYP=Soft Channel,SCAN=Passive,PINI=YES")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=TMO:USER:MCC:EPHOTK:UND,PREC=16,DESC=MCC Photon Energy,DTYP=Soft Channel,SCAN=Passive,PINI=YES")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=TMO:USER:MCC:EPHOTK:REQ,PREC=16,DESC=MCC Photon Energy,DTYP=Soft Channel,SCAN=Passive,PINI=YES")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=TMO:USER:MCC:EPHOTK:SET1,PREC=16,DESC=MCC Photon Energy,DTYP=Soft Channel,SCAN=Passive,PINI=YES")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=TMO:USER:MCC:EPHOTK:SET2,PREC=16,DESC=MCC Photon Energy,DTYP=Soft Channel,SCAN=Passive,PINI=YES")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=TMO:USER:MCC:EPHOTK:REF1,PREC=16,DESC=MCC Photon Energy,DTYP=Soft Channel,SCAN=Passive,PINI=YES")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=TMO:USER:MCC:EPHOTK:REF2,PREC=16,DESC=MCC Photon Energy,DTYP=Soft Channel,SCAN=Passive,PINI=YES")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=TMO:USER:MCC:DPHI_REQUEST,DESC=User req phase shift for soft und")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=TMO:USER:MCC:DPHI_STATE,DESC=User req phase shift for soft und state")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=TMO:USER:BYKIKS:ABORT,DESC=Did we request abort")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=TMO:USER:BYKIKS:LAST_NUM_SHOTS,DESC=Num aborted shots before abort req")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=TMO:USER:BYKIKS:ABORT_EN,DESC=Was abort enabled before emergency abort")
dbLoadRecords("$(TOP)/db/special_longout.db",     "PV=TMO:SCAN:NSHOTS,DESC=Number of shots at each step in scan")
dbLoadRecords("$(TOP)/db/special_longout.db",     "PV=TMO:SCAN:NSTEPS,DESC=Number of steps in scan")
dbLoadRecords("$(TOP)/db/special_longout.db",     "PV=TMO:SCAN:ISTEP,DESC=Current step number of scan")
dbLoadRecords("$(TOP)/db/special_longout.db",     "PV=TMO:SCAN:ISSCAN,DESC=Run is scan,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=TMO:SCAN:SCANVAR00,DESC=Scan Variable 1,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=TMO:SCAN:SCANVAR01,DESC=Scan Variable 2,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=TMO:SCAN:SCANVAR02,DESC=Scan Variable 3,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=TMO:SCAN:MIN00,DESC=Scan Variable 1 minimum value")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=TMO:SCAN:MIN01,DESC=Scan Variable 2 minimum value")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=TMO:SCAN:MIN02,DESC=Scan Variable 3 minimum value")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=TMO:SCAN:MAX00,DESC=Scan Variable 1 maximum value")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=TMO:SCAN:MAX01,DESC=Scan Variable 2 maximum value")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=TMO:SCAN:MAX02,DESC=Scan Variable 3 maximum value")
dbLoadRecords("$(TOP)/db/special_longout.db",     "PV=TMO:VARS:INT:01")
dbLoadRecords("$(TOP)/db/special_longout.db",     "PV=TMO:VARS:INT:02")
dbLoadRecords("$(TOP)/db/special_longout.db",     "PV=TMO:VARS:INT:03")
dbLoadRecords("$(TOP)/db/special_longout.db",     "PV=TMO:VARS:INT:04")
dbLoadRecords("$(TOP)/db/special_longout.db",     "PV=TMO:VARS:INT:05")
dbLoadRecords("$(TOP)/db/special_longout.db",     "PV=TMO:VARS:INT:06")
dbLoadRecords("$(TOP)/db/special_longout.db",     "PV=TMO:VARS:INT:07")
dbLoadRecords("$(TOP)/db/special_longout.db",     "PV=TMO:VARS:INT:08")
dbLoadRecords("$(TOP)/db/special_longout.db",     "PV=TMO:VARS:INT:09")
dbLoadRecords("$(TOP)/db/special_longout.db",     "PV=TMO:VARS:INT:10")
dbLoadRecords("$(TOP)/db/special_bo.db",     "PV=TMO:VARS:BIN:01,ZNAM=False,ONAM=True,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_bo.db",     "PV=TMO:VARS:BIN:02,ZNAM=False,ONAM=True,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_bo.db",     "PV=TMO:VARS:BIN:03,ZNAM=False,ONAM=True,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_bo.db",     "PV=TMO:VARS:BIN:04,ZNAM=False,ONAM=True,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_bo.db",     "PV=TMO:VARS:BIN:05,ZNAM=False,ONAM=True,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_bo.db",     "PV=TMO:VARS:BIN:06,ZNAM=False,ONAM=True,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_bo.db",     "PV=TMO:VARS:BIN:07,ZNAM=False,ONAM=True,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_bo.db",     "PV=TMO:VARS:BIN:08,ZNAM=False,ONAM=True,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_bo.db",     "PV=TMO:VARS:BIN:09,ZNAM=False,ONAM=True,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_bo.db",     "PV=TMO:VARS:BIN:10,ZNAM=False,ONAM=True,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=TMO:VARS:STRING:01,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=TMO:VARS:STRING:02,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=TMO:VARS:STRING:03,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=TMO:VARS:STRING:04,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=TMO:VARS:STRING:05,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=TMO:VARS:STRING:06,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=TMO:VARS:STRING:07,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=TMO:VARS:STRING:08,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=TMO:VARS:STRING:09,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=TMO:VARS:STRING:10,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=TMO:VARS:FLOAT:01")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=TMO:VARS:FLOAT:02")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=TMO:VARS:FLOAT:03")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=TMO:VARS:FLOAT:04")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=TMO:VARS:FLOAT:05")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=TMO:VARS:FLOAT:06")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=TMO:VARS:FLOAT:07")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=TMO:VARS:FLOAT:08")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=TMO:VARS:FLOAT:09")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=TMO:VARS:FLOAT:10")
dbLoadRecords("$(TOP)/db/special_longout.db",     "PV=TMO:VARS:TTZF_sStatus")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=TMO:VARS:TTZF_sPost1")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=TMO:VARS:TTZF_sPost2")
dbLoadRecords("$(TOP)/db/special_waveform.db",     "PV=TMO:TIMETOOL:TTALL,NELM=6,NORD=3,FTYPE=DOUBLE,EGU=Counts,PREC=16,DESC=TMO TT PeakPos Ampl Vector,DTYP=Soft Channel,SCAN=Passive,PINI=YES")
dbLoadRecords("$(TOP)/db/special_waveform.db",     "PV=TMO:TIMETOOL:SHM:TTALL,NELM=6,NORD=3,FTYPE=DOUBLE,EGU=Counts,PREC=16,DESC=TMO TT shm Vector,DTYP=Soft Channel,SCAN=Passive,PINI=YES")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=TMO:HSD:ALIAS:0,DESC=Alias for HSD 0,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=TMO:HSD:ALIAS:1,DESC=Alias for HSD 1,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=TMO:HSD:ALIAS:2,DESC=Alias for HSD 2,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=TMO:HSD:ALIAS:3,DESC=Alias for HSD 3,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=TMO:HSD:ALIAS:4,DESC=Alias for HSD 4,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=TMO:HSD:ALIAS:5,DESC=Alias for HSD 5,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=TMO:HSD:ALIAS:6,DESC=Alias for HSD 6,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=TMO:HSD:ALIAS:7,DESC=Alias for HSD 7,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=TMO:HSD:ALIAS:8,DESC=Alias for HSD 8,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=TMO:HSD:ALIAS:9,DESC=Alias for HSD 9,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=TMO:HSD:ALIAS:10,DESC=Alias for HSD 10,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=TMO:HSD:ALIAS:11,DESC=Alias for HSD 11,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=TMO:HSD:ALIAS:12,DESC=Alias for HSD 12,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=TMO:HSD:ALIAS:13,DESC=Alias for HSD 13,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=TMO:HSD:ALIAS:14,DESC=Alias for HSD 14,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_stringin.db",     "PV=TMO:HSD:ALIAS:15,DESC=Alias for HSD 15,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=KFE:MR1K1:Transmisstion,DESC=KFE MR1K1 mirror transmisstion,DTYP=Soft Channel")
dbLoadRecords("$(TOP)/db/special_ao.db",     "PV=TMO:MR2K4:Transmisstion,DESC=KFE MR2K4 mirror transmisstion,DTYP=Soft Channel")

# Setup autosave
save_restoreSet_status_prefix("$(EPICS_NAME):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

set_requestfile_path( "$(PWD)/../../autosave"             )
set_savefile_path   ( "$(IOC_DATA)/ioc-tmo-userPV/autosave" )

set_pass0_restoreFile( "ioc-tmo-userPV.sav" )        #just restore the settings
set_pass1_restoreFile( "ioc-tmo-userPV.sav" )        #just restore the settings


# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set( "ioc-tmo-userPV.req", 30, "" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

