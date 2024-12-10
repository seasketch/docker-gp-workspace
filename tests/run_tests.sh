#!/bin/bash

# echo "proj" $(proj 2>&1 | head -n 1)
# echo "geos" $(geos-config --version)
gdalinfo --version
python3 --version
node -v
npm -v

exit 0
