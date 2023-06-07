#!/bin/bash

echo
echo "proj" $(proj 2>&1 | head -n 1)
echo "geos" $(geos-config --version)
gdalinfo --version
ogrinfo --formats | grep FlatGeobuf
python --version
echo "node" $(node -v)
echo "npm" $(npm -v)

exit 0
