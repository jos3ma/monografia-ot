.. note: Este archivo puede ser interesante conservarlo como referencia general, pero a los fines de la monografía de OT, debe ser depurado y convertido en un anexo destinado a documentar específicamente el SRS utilizado, aunque tal vez podría extenderse un poco y dedicarse a todos los aspectos de la cartografía elaborada que se considere relevante incluir, aunque en principio no se me ocurre más que las especificaciones del SRS, con el objetivo de facilitar la reutilización de los datos espaciales.

Sistema de Referencia Espacial (SRS)
------------------------------------

El SRS elegido para elaborar la cartografía es un sistema local, diseñado de manera que permita trabajar con coordenadas de valores positivos y de valores no muy grandes. Se trata de una proyección Mercator Transversa, cuyo meridiano y parelelo centrales se encuentran en la zona de trabajo, y con valores para falso norte y falso este acordes a las condiciones mencionadas. El datum utilizado es WGS84. Los valores de referencia serían los siguientes:

:Proyección: Mercator Transversa
:Paralelo Central: -34.0
:Meridiano Central: -59.5
:Factor de Escala: 0.9996
:Falso Norte: 100000
:Falso Este: 100000
:Elipsoide: WGS84
:Datum: WGS84
:Unidades: Metros

El código asignado al SRS local a los fines de integrarlo en las definiciones del sistema de clasificación EPSG, es el 98766.

El almacenamiento de los datos ser hará preferentemente en el sistema local, y alternativamente coordenadas geográficas, utilizando WGS84, cuyo código EPSG es 4326.

Datos Espaciales
----------------

La base de datos espaciales disponible contiene conjuntos de datos que se fueron acumulando en el desarrollo de varios temas. Por esa razón es necesario hacer un trabajo de depuración, selección, y adaptación de los mismos. Una parte de este trabajo consiste en homogeneizar el SRS utilizado.

Todos los conjuntos de datos que sean inventariados en el proceso de organización de datos serán convertidos a uno de estos sistemas de referencia, es decir a los SRS identificados con los números 98766 (local) o 4326 (WGS84) en la clasificación EPSG.

SRS encontrados
---------------

Para referencia, a continuación se enumeran los distintos SRS utilizados en los conjuntos de datos disponibles. En cada caso, se transformaran las coordenadas para homogeneizar el SRS y simplificar y acelerar los procesos de elaboración de cartografía.

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
