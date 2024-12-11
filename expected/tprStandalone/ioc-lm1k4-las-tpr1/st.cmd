#!/reg/g/pcds/epics/ioc/common/tprStandalone/R1.2.0/bin/rhel7-x86_64/tpr

# Run common startup commands for linux soft IOC's
< $(IOC_COMMON)/All/pre_linux.cmd

< envPaths
epicsEnvSet( "IOCNAME",      "ioc-lm1k4-las-tpr1" )
epicsEnvSet( "ENGINEER",     "Michael Browne" )
epicsEnvSet( "LOCATION",     "LM1K4 laser (ctl-las-ip1-srv01)" )
epicsEnvSet( "IOCSH_PS1",    "$(IOCNAME)> " )
epicsEnvSet( "IOC_PV",       "LM1K4:IOC:TPR:01" )
epicsEnvSet( "IOCTOP",       "/reg/g/pcds/epics/ioc/common/tprStandalone/R1.2.0" )
epicsEnvSet( "BUILD_TOP",    "/cds/group/pcds/epics/ioc/las/tprStandalone/R1.0.5/build" )
cd( "$(IOCTOP)" )

# Set Max array size
epicsEnvSet( "EPICS_CA_MAX_ARRAY_BYTES", "20000000" )
epicsEnvSet( "TPR_CARD",     "0" )
epicsEnvSet( "TPR_PV",       "LM1K4:TPR:01" )

# Register all support components
dbLoadDatabase( "dbd/tpr.dbd" )
tpr_registerRecordDeviceDriver(pdbbase)
epicsThreadSleep(2)

# TPR driver DB
dbLoadRecords("db/pcie_tprTrig.db",    "DEV=LM1K4:TPR:01,PORT=trig0,NAME=$(IOCNAME)")
#dbLoadRecords("db/pcie_tprTrig.db",   "DEV=LM1K4:TPR:01:1,LOCA=B84,IOC_UNIT=TR01,INST=1,PORT=trig1")

#dbLoadRecords("db/evTSTest.db", "user=${IOC_PV},N=1000")
#dbLoadRecords("db/evTSTest.db", "user=${IOC_PV},N=1001")
#dbLoadRecords("db/evTSTest.db", "user=${IOC_PV},N=1002")

#dbLoadRecords("db/subRec.db", "DEVICE=LM1K4:TPR:01,NAME=TIME_TEST,TSE=-1,EVNT=9")
#dbLoadRecords("db/subRec.db", "DEVICE=LM1K4:TPR:01,NAME=FIDTEST_TS1,TSE=-2,EVNT=FIDTEST_TS1")
#dbLoadRecords("db/subRec.db", "DEVICE=LM1K4:TPR:01,NAME=FIDTEST_TS2,TSE=-2,EVNT=FIDTEST_TS2")
#dbLoadRecords("db/subRec.db", "DEVICE=LM1K4:TPR:01,NAME=FIDTEST_TS3,TSE=-2,EVNT=FIDTEST_TS3")
#dbLoadRecords("db/subRec.db", "DEVICE=LM1K4:TPR:01,NAME=FIDTEST_TS4,TSE=-2,EVNT=FIDTEST_TS4")
#dbLoadRecords("db/subRec.db", "DEVICE=LM1K4:TPR:01,NAME=FIDTEST_TS5,TSE=-2,EVNT=FIDTEST_TS5")
#dbLoadRecords("db/subRec.db", "DEVICE=LM1K4:TPR:01,NAME=FIDTEST_TS6,TSE=-2,EVNT=FIDTEST_TS6")

#dbLoadRecords("db/bsaTest.db")

# =================================
# Load YAML
# =================================
epicsThreadSleep(2)
epicsEnvSet("HASH",   "pcie-hash-58070ee")
epicsEnvSet("YAML_DIR",      "${TOP}/firmware/${HASH}/yaml")
epicsEnvSet("YAML_TOP_FILE", "${YAML_DIR}/000TopLevel.yaml")

# use slot A pcie tpr for root_0, override to use slot_a
cpswLoadYamlFile("${YAML_TOP_FILE}", "MemDev", "", "/dev/tpra", "root_0")

# use slot B pcie tpr for root_1, override to use slot_b
#cpswLoadYamlFile("${YAML_TOP_FILE}", "MemDev", "", "/dev/tprb", "root_1")

epicsThreadSleep(2)
# ===================================
# Load configuration from YAML file
# ====================================
#cd ("IOC_DATA/vioc-b84-ev02/yamlConfig")
#cpswLoadConfigFile("configDump.yaml", "mmio/AmcCarrierTimingGenerator/ApplicationCore", "")

epicsThreadSleep(2)
# ====================================
# crossbarControlAsynDriverConfigure
# ====================================
crossbarControlAsynDriverConfigure("crossbar0", "PCIe:/mmio/SfpXbar", "root_0")
#crossbarControlAsynDriverConfigure("crossbar1", "PCIe:/mmio/SfpXbar", "root_1")

# Since the crossbar driver has been developed for the ATCA system
# the crossbar options have different meaning on PCIe TPR
# Please, just set up as the followings to make PCIe TPR works

epicsThreadSleep(2)
# ====================================
# Setup TPR Driver
# ====================================
tprTriggerAsynDriverConfigure("trig0", "PCIe:/mmio", "root_0")
#tprTriggerAsynDriverConfigure("trig1", "PCIe:/mmio", "root_1")

# Setup debugging


# Got this from hpsTprLab.  Not working yet here.
#registerFiducialTestFunction("FIDTEST_TS1",1)
#registerFiducialTestFunction("FIDTEST_TS2",2)
#registerFiducialTestFunction("FIDTEST_TS3",3)
#registerFiducialTestFunction("FIDTEST_TS4",4)
#registerFiducialTestFunction("FIDTEST_TS5",5)
#registerFiducialTestFunction("FIDTEST_TS6",6)

# Load soft ioc related record instances
dbLoadRecords( "db/iocSoft.db",				"IOC=LM1K4:IOC:TPR:01" )
dbLoadRecords( "db/iocRelease.db",			"IOC=LM1K4:IOC:TPR:01" )

# Setup autosave
dbLoadRecords( "db/save_restoreStatus.db",	"P=LM1K4:IOC:TPR:01:SR:" )


set_savefile_path( "$(IOC_DATA)/$(IOC)/autosave" )
set_requestfile_path( "$(BUILD_TOP)/autosave" )
# Also look in the iocData autosave folder for auto generated req files
set_requestfile_path( "$(IOC_DATA)/$(IOC)/autosave" )
save_restoreSet_status_prefix( "$(IOC_PV):SR:" )
save_restoreSet_IncompleteSetsOk( 1 )
save_restoreSet_DatedBackupFiles( 1 )
set_pass0_restoreFile( "autoSettings.sav" )
set_pass0_restoreFile( "$(IOC).sav" )
set_pass1_restoreFile( "autoSettings.sav" )
set_pass1_restoreFile( "$(IOC).sav" )

# Configure access security: this is required for caPutLog.
asSetFilename("$(TOP)/iocBoot/templates/unrestricted.acf")

#
# Initialize the IOC and start processing records
#
epicsThreadSleep(2)
iocInit()

# =====================================================
# Turn on caPutLogging:
epicsThreadSleep(2)
# caPutLogInit("HOST:PORT", config)
# config options:
#       caPutLogNone       -1: no logging (disable)
#       caPutLogOnChange    0: log only on value change
#       caPutLogAll         1: log all puts
#       caPutLogAllNoFilter 2: log all puts no filtering on same PV
# TODO:  See if caPutLogInit should be in post_linux.cmd
caPutLogInit("${EPICS_CA_PUT_LOG_ADDR}",0)
caPutLogShow(2)

# Create autosave files from info directives
makeAutosaveFileFromDbInfo( "$(IOC_DATA)/$(IOC)/autosave/autoSettings.req", "autosaveFields" )

# Start autosave backups
create_monitor_set( "autoSettings.req",  5,  "" )
create_monitor_set( "$(IOCNAME).req",    5,  "" )


# All IOCs should dump some common info after initial startup.
< $(IOC_COMMON)/All/post_linux.cmd

