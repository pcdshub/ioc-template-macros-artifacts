export LIBUSB=/reg/g/pcds/package/external/libusb-1.0.0
$$IF(ARCH,linux-x86_64)
export USDUSB4=/reg/g/pcds/package/external/usdusb4-rhel5
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${USDUSB4}/lib/x86_64-linux-dbg:${LIBUSB}/lib/x86_64-linux-dbg
$$ENDIF(ARCH)
$$IF(ARCH,rhel7-x86_64)
export USDUSB4=/reg/g/pcds/package/usdusb4
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${USDUSB4}/lib64:${LIBUSB}/lib/x86_64-linux-dbg
$$ENDIF(ARCH)
