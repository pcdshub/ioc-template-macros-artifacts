
#!/usr/bin/bash

source pcds_conda

TOP="$(dirname "$(realpath "$0")")/../../../../screens"

pydm -m "BASE=TMO:LAMP:RGA:01" $TOP/mksrga.ui

