#
# This is a special snowflake of an IOC.  RHEL7 only, with a special compiler (and version
# of libstdc++).  Set up the path to point to our compiler, the uEye library, and the 
# Thorlabs library.
#
export LD_LIBRARY_PATH=/reg/g/pcds/pkg_mgr/release/gcc/4.9.4/x86_64-rhel7-gcc48-opt/lib64:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/reg/g/pcds/package/external/ueye-4.91.1.0/usr/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/reg/g/pcds/epics/ioc/common/Thorlabs-WFS/R1.0.4/TLWFS:$LD_LIBRARY_PATH
export EPICS_HOST_ARCH=rhel7-gcc494-x86_64
