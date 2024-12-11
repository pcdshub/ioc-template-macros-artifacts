
#!/usr/bin/bash

source pcds_conda

TOP="$(dirname "$(realpath "$0")")/../../../../screens"

pydm -m "BASE=TMO-TRICAM-01" $TOP/TriCAM_Main.ui

