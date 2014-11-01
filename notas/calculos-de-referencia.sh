#!/bin/bash

LAT=-33.7967
LON=-59.5208

echo
echo "WGS84:"
echo $LAT $LON
echo

# SRS Personalizado: epsg:98765
echo "epsg:98765 - SRS Local Baradero / Lincoln"
proj +proj=tmerc +lat_0=-34.5 +lon_0=-60.5 +k=0.9996 +x_0=500000 +y_0=500000 +ellps=WGS84 +datum=WGS84 +units=m +no_defs -r <<EOF
$LAT $LON
EOF
echo

# SRS Personalizado: epsg:98766
echo "epsg:98766 - SRS Local - Partido de Baradero"
proj +proj=tmerc +lat_0=-34.0 +lon_0=-59.5 +k=0.9996 +x_0=100000 +y_0=100000 +ellps=WGS84 +datum=WGS84 +units=m +no_defs -r <<EOF
$LAT $LON
EOF
echo

# Hay al menos cuatro formas de realizar esta transformación. En este caso usamos las cuatro
# con fines didácticos, y en los siguientes ejemplos usaremos solamente la forma más simple.

# UTM20S
echo "epsg:32620 - UTM20N"

# # Forma 1
# proj +proj=utm  +lon_0=63w +south +ellps=WGS84 -r <<EOF
# $LAT $LON
# EOF

# # Forma 2
# proj +proj=utm +zone=20 +south +ellps=WGS84 +datum=WGS84 +units=m +no_defs -r <<EOF
# $LAT $LON
# EOF

# Forma 3
proj +init=epsg:32620 -r <<EOF
$LAT $LON
EOF
echo

# # Forma 4
# proj +proj=tmerc +lat_0=0 +lon_0=-57.0 +k=0.9996 +x_0=500000 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs -r <<EOF
# $LAT $LON
# EOF

# UTM20S (duplicada)
echo "epsg:92720 - UTM20N (duplicada)"
proj +init=epsg:92720 -r <<EOF
$LAT $LON
EOF
echo

# UTM21N
echo "epsg:32621 - UTM21N"
proj +init=epsg:32621 -r <<EOF
$LAT $LON
EOF
echo

# UTM21N (duplicada)
echo "epsg:92721 - UTM21N (duplicada)"
proj +init=epsg:92721 -r <<EOF
$LAT $LON
EOF
echo

# UTM20S
echo "epsg:32720 - UTM20S"
proj +init=epsg:32720 -r <<EOF
$LAT $LON
EOF
echo

# UTM21S
echo "epsg:32721 - UTM21S"
proj +init=epsg:32721 -r <<EOF
$LAT $LON
EOF
echo

# POSGAR 95 / Argentina Faja 5
echo "epsg:22185 - POSGAR 95 / Argentina Faja 5"
proj +init=epsg:22185 -r <<EOF
$LAT $LON
EOF
echo

