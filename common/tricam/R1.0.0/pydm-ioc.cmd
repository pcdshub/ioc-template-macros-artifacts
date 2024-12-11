
#!/usr/bin/bash

source pcds_conda

TOP="$(dirname "$(realpath "$0")")/../../../../screens"

$$LOOP(DEVICE)
pydm -m "BASE=$$BASE" $TOP/TriCAM_Main.ui
$$ENDLOOP(DEVICE)

