Sistema de Referencia Espacial (SRS)
------------------------------------

El SRS elegido para elaborar la cartografía es Posgar 94 Faja 5, que es el sistema de referencia oficial que le corresponde al area de trabajo de acuerdo a las normas del Instituto Geográfico Nacional. El código EPSG de este SRS es 22185.

El SRS elegido para elaborar la cartografía es un sistema local, para tener coordenadas con valores numéricos más fáciles de manejar. Es una proyección similar a UTM  que usa como meridiano central el valor redondeado más cercano a la planta urbana, que es -59.5. Los valores falso norte y falso este son en ambos casos iguales a 100000 metros. El código asignado para agregarlo como SRS personalizado al archivo de definiciones EPSG es 98766.

Alternativamente algunos datos podrían ser almacenados en coordenadas geográficas. En este caso el SRS utilizado será WGS84, cuyo código EPSG es 4326.

Datos Espaciales
----------------

La base de datos espaciales disponible contiene conjuntos de datos que se fueron acumulando en el desarrollo de otros temas. Por esa razón es necesario hacer un trabajo de depuración, selección, y adaptación de los mismos. Una parte de ese trabajo consiste en homogeneizar el SRS utilizado.

Todos los conjuntos de datos que sean inventariados en el proceso de organización de datos serán convertidos a uno de estos sistemas de referencia, es decir a los SRS identificados con los números 4326 y 22185 en la clasificación EPSG.

SRS encontrados
---------------

.. topic:: EPSG:22185 - POSGAR 94 / Argentina Faja 5

    .. code-block:: text

        +proj=tmerc +lat_0=-90 +lon_0=-60 +k=1 +x_0=5500000 +y_0=0 +ellps=WGS84 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs

.. topic:: EPSG:32621 - WGS 84 / UTM zone 21N

    .. code-block:: text

        +proj=utm +zone=21 +ellps=WGS84 +datum=WGS84 +units=m +no_defs 

.. topic:: EPSG:32720 - WGS 84 / UTM zone 20S

    .. code-block:: text

        +proj=utm +zone=21 +south +ellps=WGS84 +datum=WGS84 +units=m +no_defs 

.. topic:: EPSG:32721 - WGS 84 / UTM zone 21S

    .. code-block:: text

        +proj=utm +zone=21 +south +ellps=WGS84 +datum=WGS84 +units=m +no_defs 

.. topic:: EPSG:92720 (equivalente a EPSG:32620)

    .. note:: Si el error por el cual se usó esta definición duplicada hubiese sido coherente, el código usado hubiese sido 92620 en lugar de 92720.

    .. code-block:: text

        +proj=tmerc +lat_0=0 +lon_0=-63.0 +k=0.9996 +x_0=500000 +y_0=10000000 +ellps=WGS84 +datum=WGS84 +units=m +no_defs


.. topic:: EPSG:92721 (equivalente a EPSG:32721")

    .. code-block:: text

        +proj=tmerc +lat_0=0 +lon_0=-57.0 +k=0.9996 +x_0=500000 +y_0=10000000 +ellps=WGS84 +datum=WGS84 +units=m +no_defs

.. topic:: EPSG:98766 - Sistema Local para el Partido de Baradero

    .. code-block:: text

        +proj=tmerc +lat_0=-34.0 +lon_0=-59.5 +k=0.9996 +x_0=100000 +y_0=100000 +ellps=WGS84 +datum=WGS84 +units=m +no_defs
        <98766> +proj=tmerc +lat_0=-34.0 +lon_0=-59.5 +k=0.9996 +x_0=100000 +y_0=100000 +ellps=WGS84 +datum=WGS84 +units=m +no_defs <>

Apuntes para la gestión de coordenadas
--------------------------------------

Cálculo de coordenadas de referencia
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

La idea es tener valores referencia para compararlos con las coordenadas de los conjuntos de datos encontrados, con el fin de identificar rápidamente el SRS correspondiente cuando el mismo no está especificado en los metadatos del archivo.

Las coordenadas de referencia a utilizar corresponden aproximadamente al centro de la Ciudad de Baradero

.. topic:: Ciudad de Baradero

    :Latitud: -33.7967
    :Longitud: -59.5208

El script `calculos-de-referencia.sh` usa el programa `proj` perteneciente a la librería `proj4`.

Transformar a coordenadas planas en los distintos SRS utilizados:

.. code-block:: bash

    $ bash calculos-de-referencia.sh

        WGS84:
        -33.7967 -59.5208

        epsg:98765 - SRS Local Baradero / Lincoln
        590643.55   577551.53

        epsg:98766 - SRS Local - Partido de Baradero
        98074.60    122540.93

        epsg:32620 - UTM20N
        822136.00   -3745059.31

        epsg:92720 - UTM20N (duplicada)
        822136.00   -3745059.31

        epsg:32621 - UTM21N
        266627.55   -3742471.60

        epsg:92721 - UTM21N (duplicada)
        266627.55   -3742471.60

        epsg:32720 - UTM20S
        822136.00   6254940.69

        epsg:32721 - UTM21S
        266627.55   6257528.40

        epsg:22185 - POSGAR 95 / Argentina Faja 5
        5544376.17  6260751.21

Datos vectoriales
~~~~~~~~~~~~~~~~~

.. topic:: Obtener información

    .. code-block:: bash

        # Metadatos y listado completo y detallado de elementos incluyendo la geometría.
        $ ogrinfo -al entrada.shp

            ...

        # Metadatos y listado completo de elementos con un sumario de la geometría.
        $ ogrinfo -al -geom=SUMMARY entrada.shp

            ...

        # Metadatos
        $ ogrinfo -so -al -geom=SUMMARY entrada.shp

            ...

.. topic:: Transformar coordenadas

    .. code-block:: bash

        $ ogr2ogr -f "ESRI Shapefile" -t_srs "EPSG:22185" -s_srs "EPSG:4326" salida.shp entrada.shp

Datos raster
~~~~~~~~~~~~

.. topic:: Obtener información

    .. code-block:: bash

        # Metadatos y estadísticas completas
        $ gdalinfo -nomd -noct entrada.tif

            ...

        # Metadatos y estadísticas resumidas
        $ gdalinfo entrada.tif

.. topic:: Transformar coordenadas

    .. code-block:: bash

        $ gdalwarp -s_srs EPSG:92721 -t_srs EPSG:4326 entrada.tif salida.tif

