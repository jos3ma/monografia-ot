#!/bin/bash

LAT=-33.7967
LON=-59.5208

echo "WGS84"
echo $LAT $LON

# SRS Personalizado: epsg:98765

echo "epsg:98765 - SRS Local Baradero / Lincoln"
proj +proj=tmerc +lat_0=-34.5 +lon_0=-60.5 +k=0.9996 +x_0=500000 +y_0=500000 +ellps=WGS84 +datum=WGS84 +units=m +no_defs -r <<EOF
$LAT $LON
EOF

# SRS Personalizado: epsg:98766

echo "epsg:98765 - SRS Local - Partido de Baradero"
proj +proj=tmerc +lat_0=- +lon_0=- +k=0.9996 +x_0=500000 +y_0=500000 +ellps=WGS84 +datum=WGS84 +units=m +no_defs -r <<EOF
$LAT $LON
EOF

# UTM21S

echo "epsg:32721 - UTM21S"

# # Forma 1
# proj +proj=utm  +lon_0=57w +south +ellps=WGS84 -r <<EOF
# $LAT $LON
# EOF

# # Forma 2
# proj +proj=utm +zone=21 +south +ellps=WGS84 +datum=WGS84 +units=m +no_defs -r <<EOF
# $LAT $LON
# EOF

# Forma 3
proj +init=epsg:32721 -r <<EOF
$LAT $LON
EOF

# # Forma 4
# proj +proj=tmerc +lat_0=0 +lon_0=-57.0 +k=0.9996 +x_0=500000 +y_0=10000000 +ellps=WGS84 +datum=WGS84 +units=m +no_defs -r <<EOF
# $LAT $LON
# EOF
