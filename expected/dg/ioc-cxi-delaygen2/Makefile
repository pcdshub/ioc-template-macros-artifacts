# Makefile for ioc instance
TOP = ../..
-include ./IOC_APPL_TOP
ifneq (,$(IOC_APPL_TOP))
TOP = $(IOC_APPL_TOP)
endif

include $(TOP)/configure/CONFIG
ifndef ARCH
ARCH = linux-x86_64
endif

INSTALL_LOCATION = ../..
INSTALL_LOCATION_BIN = $(TOP)/bin

TARGETS = envPaths

# Make sure these archive files are fully expanded
USR_ARCHIVEFLAGS += -V

#----------------------------------------------------
# Create and install IOC archive file
#
ARCHIVE += ioc-cxi-delaygen2.archive

#----------------------------------------------------
# Create and install IOC autosave file
#

include $(TOP)/configure/RULES.ioc
-include $(TOP)/configure/RULES.archive
