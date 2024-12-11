TOP = ../..
IOC=
# Try and set the IOC application top
-include ./IOC_APPL_TOP
ifneq (,$(IOC_APPL_TOP))
TOP = $(IOC_APPL_TOP)
endif

# Include config, set arch if it's not already specified
include $(TOP)/configure/CONFIG
ifndef ARCH
ARCH = rhel7-x86_64
endif

INSTALL_LOCATION = ../..
INSTALL_LOCATION_BIN = $(TOP)/bin

TARGETS = envPaths

# Ensures that the archive is fully expanced
USR_ARCHIVEFLAGS += -V

# Create & install archive
ARCHIVE += ioc-mec-ek9000-01.archive

# Create & install autosave
REQ += ioc-mec-ek9000-01.req

include $(TOP)/configure/RULES.ioc
-include $(TOP)/configure/RULES.archive
-include $(TOP)/configure/RULES.autosave
