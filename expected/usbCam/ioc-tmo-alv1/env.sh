export ADVIMBA=`awk -F\" '/ADVIMBA/{print $4;}' envPaths`
export HOST_ARCH=`/cds/group/pcds/epics/base/R7.0.3.1-2.0/startup/EpicsHostArch.pl`
export GENICAM_GENTL64_PATH=$ADVIMBA/bin/$HOST_ARCH
echo Setting GENICAM_GENTL64_PATH to $ADVIMBA/bin/$HOST_ARCH.
# Limit number of cores for pixel format conversion.
export OMP_NUM_THREADS=4
$GENICAM_GENTL64_PATH/reset_usb 018NR
sleep 10
