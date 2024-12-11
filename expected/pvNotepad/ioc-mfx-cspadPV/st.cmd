#!/reg/g/pcds/package/epics/3.14/ioc/common/pvNotepad/R1.3.1/bin/linux-x86_64/pvNotepad

epicsEnvSet( "EPICS_NAME", "IOC:MFX:CSPADPV" )
epicsEnvSet( "ENGINEER",  "Jackson Sheppard (sheppard)" )
epicsEnvSet( "LOCATION",  "SLAC:LCLS:MFX" )
epicsEnvSet( "IOCSH_PS1", "ioc-mfx-cspadPV> ")

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

dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:MODEL_XAXIS,RECTYPE=waveform,NELM=1024,FTYPE=DOUBLE,EGU=mm,PREC=3,DESC=Diffraction model xaxis waveform")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:MODEL_INTENSITY,RECTYPE=waveform,NELM=1024,FTYPE=DOUBLE,EGU=ADU,PREC=0,DESC=Diffraction model intensity waveform")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:MODEL_INTENSITY_ERR,RECTYPE=waveform,NELM=1024,FTYPE=DOUBLE,EGU=ADU,PREC=0,DESC=Diffraction model intensity waveform")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:MODEL_ADU,RECTYPE=ao,EGU=ADU,PREC=0,DESC=Total detector model ADU")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:MODEL_ADU_ERR,RECTYPE=ao,EGU=ADU,PREC=0,DESC=Total detector model ADU error estimate")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:X0,RECTYPE=ao,EGU=mm,PREC=3,DESC=Nominal X origin of diffraction")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:X0_ERR,RECTYPE=ao,EGU=mm,PREC=3,DESC=Nominal X error estimate origin of diffraction")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:Y0,RECTYPE=ao,EGU=mm,PREC=3,DESC=Nominal Y origin of diffraction")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:Y0_ERR,RECTYPE=ao,EGU=mm,PREC=3,DESC=Nominal Y error estimate origin of diffraction")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:STREAK_X,RECTYPE=ao,EGU=mm,PREC=3,DESC=Event X origin of diffraction streak")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:STREAK_X_ERR,RECTYPE=ao,EGU=mm,PREC=3,DESC=Event X error estimate origin of diffraction streak")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:STREAK_Y,RECTYPE=ao,EGU=mm,PREC=3,DESC=Event Y origin of diffraction streak")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:STREAK_Y_ERR,RECTYPE=ao,EGU=mm,PREC=3,DESC=Event Y error estimate origin of diffraction streak")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:STREAK_CALC_RATE,RECTYPE=ao,EGU=rad,PREC=6,DESC=Rate of processing of events for diffraction streaks")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:STREAK_FRACTION,RECTYPE=ao,EGU=rad,PREC=6,DESC=Fraction of events with diffraction streaks")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:STREAK_PHI,RECTYPE=ao,EGU=rad,PREC=6,DESC=Angle of diffraction streak")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:STREAK_PHI_ERR,RECTYPE=ao,EGU=rad,PREC=6,DESC=Angle error estimate of diffraction streak")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:STREAK_WIDTH,RECTYPE=ao,EGU=mm,PREC=6,DESC=Width of diffraction streak")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:STREAK_WIDTH_ERR,RECTYPE=ao,EGU=mm,PREC=6,DESC=Width error estimate of diffraction streak")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:STREAK_INTENSITY,RECTYPE=ao,EGU=ADU,PREC=6,DESC=Intensity of diffraction streak")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:STREAK_INTENSITY_ERR,RECTYPE=ao,EGU=ADU,PREC=6,DESC=Intensity error estimate of diffraction streak")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:TOTAL_ADU,RECTYPE=ao,EGU=ADU,PREC=0,DESC=Total detector ADU")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:TOTAL_ADU_ERR,RECTYPE=ao,EGU=ADU,PREC=0,DESC=Total detector ADU error estimate")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:STATS_MEAN,RECTYPE=ao,EGU=ADU,PREC=0,DESC=Mean Diffraction Statistic")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:STATS_STD,RECTYPE=ao,EGU=ADU,PREC=0,DESC=Std Diffraction Statistic")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:STATS_MIN,RECTYPE=ao,EGU=ADU,PREC=0,DESC=Min Diffraction Statistic")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:STATS_MAX,RECTYPE=ao,EGU=ADU,PREC=0,DESC=Max Diffraction Statistic")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:PSD_FREQUENCY,RECTYPE=ao,EGU=Hz,PREC=0,DESC=Diffraction Fundamental Frequencey from Periodogram")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:PSD_AMPLITUDE,RECTYPE=ao,PREC=0,DESC=Diffraction Amplitude of fundamental frequency from periodogram")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:PSD_RATE,RECTYPE=ao,EGU=Hz,PREC=0,DESC=Event frequency for periodogram")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:PSD_EVENTS,RECTYPE=ao,PREC=0,DESC=Number of events for periodogram (1200 max)")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:PSD_RESOLUTION,RECTYPE=ao,PREC=0,DESC=Resultion to smooth over for periodogram")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:PSD_FREQ_MIN,RECTYPE=ao,PREC=1,DESC=Minimum frequency for periodogram calcs")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:PSD_FREQ_WF,RECTYPE=waveform,NELM=1201,FTYPE=DOUBLE,EGU=Hz,PREC=1,DESC=Diffraction sum periodogram frequency waveform (1201 max)")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:PSD_AMP_WF,RECTYPE=waveform,NELM=1201,FTYPE=DOUBLE,PREC=3,DESC=Diffraction sum periodograom amplitude waveform (1201 max)")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:PSD_AMP_ARRAY,RECTYPE=waveform,NELM=57840,FTYPE=DOUBLE,PREC=3,DESC=Diffraction sum periodograom vs event array (241x240 max)")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:RING_ADU,RECTYPE=ao,EGU=ADU,PREC=0,DESC=Ring ADU")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:RING_ADU_ERR,RECTYPE=ao,EGU=ADU,PREC=0,DESC=Ring ADU error estimate")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:RING_RADIUS,RECTYPE=ao,EGU=mm,PREC=6,DESC=Radius of diffraction ring")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:RING_RADIUS_ERR,RECTYPE=ao,EGU=mm,PREC=6,DESC=Radius error estimate of diffraction ring")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:RING_WIDTH,RECTYPE=ao,EGU=mm,PREC=6,DESC=Width of diffraction ring")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:RING_WIDTH_ERR,RECTYPE=ao,EGU=mm,PREC=6,DESC=Width error estimate of diffraction ring")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:RING_INTENSITY,RECTYPE=ao,EGU=ADU,PREC=6,DESC=Intensity of diffraction ring")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:RING_INTENSITY_ERR,RECTYPE=ao,EGU=ADU,PREC=6,DESC=Intensity error estimate of diffraction ring")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:STATE,RECTYPE=mbbo")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:INLINE:CAM_X,RECTYPE=ao,EGU=mm,PREC=3,DESC=Onaxis camera origin x position")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:INLINE:CAM_Y,RECTYPE=ao,EGU=mm,PREC=3,DESC=Onaxis camera origin y position")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:INLINE:PXSIZE,RECTYPE=ao,EGU=mm,PREC=3,DESC=Onaxis camera pixel size")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:INLINE:BEAM_X,RECTYPE=ao,EGU=mm,PREC=3,DESC=X position of the x-ray beam")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:INLINE:BEAM_X_ERR,RECTYPE=ao,EGU=mm,PREC=3,DESC=X position error of the x-ray beam")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:INLINE:BEAM_Y,RECTYPE=ao,EGU=mm,PREC=3,DESC=Y position of the x-ray beam")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:INLINE:BEAM_Y_ERR,RECTYPE=ao,EGU=mm,PREC=3,DESC=Y position error of the x-ray beam")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:INLINE:BEAM_X_PX,RECTYPE=ao,EGU=px,PREC=3,DESC=X position of the x-ray beam in the camera image")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:INLINE:BEAM_Y_PX,RECTYPE=ao,EGU=px,PREC=3,DESC=Y position of the x-ray beam in the camera image")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:INLINE:CAM_ROLL,RECTYPE=ao,EGU=rad,PREC=3,DESC=Rotation of on axis camera around z axis")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:INLINE:CAM_ROLL_ERR,RECTYPE=ao,EGU=rad,PREC=3,DESC=Rotation error of on axis camera around z axis")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:INLINE:NOZZLE_X,RECTYPE=ao,EGU=mm,PREC=3,DESC=X position of jet coming out of nozzle")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:INLINE:NOZZLE_X_ERR,RECTYPE=ao,EGU=mm,PREC=3,DESC=X position error of jet coming out of nozzle")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:INLINE:NOZZLE_Y,RECTYPE=ao,EGU=mm,PREC=3,DESC=Y position of jet coming out of nozzle")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:INLINE:NOZZLE_Y_ERR,RECTYPE=ao,EGU=mm,PREC=3,DESC=Y position error of jet coming out of nozzle")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:INLINE:NOZZLE_XWIDTH,RECTYPE=ao,EGU=mm,PREC=3,DESC=Width of nozzle")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:INLINE:NOZZLE_XWIDTH_ERR,RECTYPE=ao,EGU=mm,PREC=3,DESC=Width error of nozzle")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:INLINE:NOZZLE_ROLL,RECTYPE=ao,EGU=rad,PREC=3,DESC=Rotation of nozzle about z-axis")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:INLINE:NOZZLE_ROLL_ERR,RECTYPE=ao,EGU=rad,PREC=3,DESC=Rotation error of nozzle about z-axis")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:INLINE:JET_ROLL,RECTYPE=ao,EGU=rad,PREC=3,DESC=Rotation of jet about z-axis")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:INLINE:JET_ROLL_ERR,RECTYPE=ao,EGU=rad,PREC=3,DESC=Rotation error of jet about z-axis")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:INLINE:JET_X,RECTYPE=ao,EGU=mm,PREC=3,DESC=X position of jet at beam height")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:INLINE:JET_X_ERR,RECTYPE=ao,EGU=mm,PREC=3,DESC=X position error of jet at beam height")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:INLINE:STATE,RECTYPE=mbbo")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:TOTAL_Counter,RECTYPE=ao,PREC=0,DESC=Diffraction total intensity event counter")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:RING_Counter,RECTYPE=ao,PREC=0,DESC=Diffraction ring intensity event counter")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:PSD_Counter,RECTYPE=ao,PREC=0,DESC=Diffraction periodogram event counter")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:STATS_Counter,RECTYPE=ao,PREC=0,DESC=Diffraction stats event counter")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:STREAK_Counter,RECTYPE=ao,PREC=0,DESC=Diffraction streak event counter")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:INLINE:JET_Counter,RECTYPE=ao,PREC=0,DESC=Jet event counter")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:INLINE:NOZZLE_Counter,RECTYPE=ao,PREC=0,DESC=Inline camera nozzle event counter")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:TOTAL_RepRate,RECTYPE=ao,EGU=Hz,PREC=0,DESC=Diffraction total intensity calc rate")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:RING_RepRate,RECTYPE=ao,EGU=Hz,PREC=0,DESC=Diffraction ring intensity event counter")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:PSD_RepRate,RECTYPE=ao,EGU=Hz,PREC=0,DESC=Diffraction periodogram event counter")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:STATS_RepRate,RECTYPE=ao,EGU=Hz,PREC=0,DESC=Diffraction stats event counter")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:STREAK_RepRate,RECTYPE=ao,EGU=Hz,PREC=0,DESC=Diffraction streak event counter")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:INLINE:JET_RepRate,RECTYPE=ao,EGU=Hz,PREC=0,DESC=Jet event counter")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:INLINE:NOZZLE_RepRate,RECTYPE=ao,EGU=Hz,PREC=0,DESC=Inline camera nozzle event counter")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:DIFFRACT:LATENCY,RECTYPE=ao,EGU=s,PREC=1,DESC=Diffraction calculation latency")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:INJECTOR:STATE,RECTYPE=mbbo")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:INJECTOR:XMIN,RECTYPE=ao,EGU=mm,PREC=3,DESC=Injector minimum X position")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:INJECTOR:XMAX,RECTYPE=ao,EGU=mm,PREC=3,DESC=Injector maximum X position")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:INJECTOR:XSTEP_SIZE,RECTYPE=ao,EGU=mm,PREC=3,DESC=Injector X step size")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:INJECTOR:BOUNCE_WIDTH,RECTYPE=ao,EGU=mm,PREC=3,DESC=Injector X bounce width")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:INJECTOR:XSCAN_MIN,RECTYPE=ao,EGU=mm,PREC=3,DESC=Injector X scan minimum")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:INJECTOR:XSCAN_MAX,RECTYPE=ao,EGU=mm,PREC=3,DESC=Injector X scan maximum")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:BEAM:PULSE_ENERGY,RECTYPE=ao,EGU=mJ,PREC=3,DESC=Pulse energy after transmission")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:BEAM:TRANS,RECTYPE=ao,PREC=3,DESC=Endstation transmission")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:BEAM:E_THRESH,RECTYPE=ao,EGU=mJ,PREC=3,DESC=Lowbeam energy threshold")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:BEAM:STATE,RECTYPE=mbbo")
dbLoadRecords("$(TOP)/db/specials.db",     "PV=MFX:DET:RE:STATE,RECTYPE=mbbo")

# Setup autosave
save_restoreSet_status_prefix("$(EPICS_NAME):" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )

set_requestfile_path( "$(PWD)/../../autosave"             )
set_savefile_path   ( "$(IOC_DATA)/ioc-mfx-cspadPV/autosave" )

set_pass0_restoreFile( "ioc-mfx-cspadPV.sav" )        #just restore the settings
set_pass1_restoreFile( "ioc-mfx-cspadPV.sav" )        #just restore the settings


# Initialize the IOC and start processing records
iocInit()

# Start autosave backups
create_monitor_set( "ioc-mfx-cspadPV.req", 30, "" )

# All IOCs should dump some common info after initial startup.
< /reg/d/iocCommon/All/post_linux.cmd

