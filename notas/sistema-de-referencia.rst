Organizando los datos espaciales se ha encontrado cartografía en distintos sistemas de referencia. Algunos de estos SRS están citados por errores o confusiones, y la base de datos debe depurarse para conservar solamente los SRS necesarios.  

El SRS elegido para realizar el trabajo es un sistema local al que, para uso propio, le asignamos el código epsg:98766. Es una proyección Gauss Kruger con centro en Baradero y coordenadas positivas en el área de trabajo:

- EPSG:98766 - Local. El meridiano central corresponde al area de la Ciudad y las coordenadas resultan positivas en toda la extensión del partido.

Determinar parámetros en base a centro geométrico del departamento Baradero y su extensión, de manera que las coordenadas sean siempre positivas:

+proj=tmerc +lat_0=-XX.X +lon_0=-XX.XX +k=0.9996 +x_0=500000? +y_0=500000? +ellps=WGS84 +datum=WGS84 +units=m +no_defs

El almacenamiento de los datos se realizará preferiblemente en el SRS Local o en coordenadas geográficas referidas al sistema WGS 84 su fuese necesario.

Todos los conjuntos de datos que sean inventariados en el proceso de organización de datos serán convertidos a uno de estos sistemas de referencia, es decir a epsg:4326 o epsg:9876.

A continuación, el listado de los SRS encontrados o citados en las bases de datos exploradas:

- EPSG:32621 - WGS 84 / UTM zone 21N

+proj=utm +zone=21 +ellps=WGS84 +datum=WGS84 +units=m +no_defs 

PROJCS["WGS 84 / UTM zone 21N",GEOGCS["WGS 84",DATUM["WGS_1984",SPHEROID["WGS 84",6378137,298.257223563,AUTHORITY["EPSG","7030"]],AUTHORITY["EPSG","6326"]],PRIMEM["Greenwich",0,AUTHORITY["EPSG","8901"]],UNIT["degree",0.01745329251994328,AUTHORITY["EPSG","9122"]],AUTHORITY["EPSG","4326"]],UNIT["metre",1,AUTHORITY["EPSG","9001"]],PROJECTION["Transverse_Mercator"],PARAMETER["latitude_of_origin",0],PARAMETER["central_meridian",-57],PARAMETER["scale_factor",0.9996],PARAMETER["false_easting",500000],PARAMETER["false_northing",0],AUTHORITY["EPSG","32621"],AXIS["Easting",EAST],AXIS["Northing",NORTH]]

- EPSG:32721 - WGS 84 / UTM zone 21S

+proj=utm +zone=21 +south +ellps=WGS84 +datum=WGS84 +units=m +no_defs 

PROJCS["WGS 84 / UTM zone 21S",GEOGCS["WGS 84",DATUM["WGS_1984",SPHEROID["WGS 84",6378137,298.257223563,AUTHORITY["EPSG","7030"]],AUTHORITY["EPSG","6326"]],PRIMEM["Greenwich",0,AUTHORITY["EPSG","8901"]],UNIT["degree",0.01745329251994328,AUTHORITY["EPSG","9122"]],AUTHORITY["EPSG","4326"]],UNIT["metre",1,AUTHORITY["EPSG","9001"]],PROJECTION["Transverse_Mercator"],PARAMETER["latitude_of_origin",0],PARAMETER["central_meridian",-57],PARAMETER["scale_factor",0.9996],PARAMETER["false_easting",500000],PARAMETER["false_northing",10000000],AUTHORITY["EPSG","32721"],AXIS["Easting",EAST],AXIS["Northing",NORTH]]

- EPSG:92720 - Proyección Equivalente a "EPSG:32720 - WGS 84 / UTM zone 20S". Esta proyección fue agregada porque al usar la EPSG:32721 que viene definida en el archivo epsg, los resultados no eran los esperados. (Creo que este se había usado para datos de Lincoln; verificar y eliminar)

+proj=tmerc +lat_0=0 +lon_0=-63.0 +k=0.9996 +x_0=500000 +y_0=10000000 +north +ellps=WGS84 +datum=WGS84 +units=m +no_defs

- EPSG:92721 - Proyección Equivalente a "EPSG:32721 - WGS 84 / UTM zone 21S". Esta proyección fue agregada porque al usar la EPSG:32721 que viene definida en el archivo epsg, los resultados no eran los esperados.

+proj=tmerc +lat_0=0 +lon_0=-57.0 +k=0.9996 +x_0=500000 +y_0=10000000 +ellps=WGS84 +datum=WGS84 +units=m +no_defs

ATENCIÓN: aparentemente el SRS EPSG:92721 estaba mal configurado (false_northing; corregido de 0 a 10000000). Tal vez esto tiene que ver con algunos errores de superposición de capas de distinto SRS de origen al intentar combinarlas en EPSG:32721 (UTM 21S) y que dieron lugar a la creación del EPSG:92721. En un primer momento se pensó que tal vez había algún problema o error (bug) relacionado al uso del SRS EPSG:32721, y eso motivó el agregado de esa misma proyección manualmente, para evitar usar la que viene incluída en el programa de cálculo geodésico proj4. Como esa prueba dió resultado positivo, pensamos que la posibilidad de encontrarnos ante un bug era cierta. Ahora conviene revisar esta situación ya que se pudo haber tratado de un manejo incorrecto de los datos.

- EPSG:98765 - Local. El meridiano central corresponde a un punto intermedio entre las ciudades de Baradero y Lincoln. Es el SRS que se iba a usar en el trabajo anterior. Hay algunos conjuntos de datos usando este SRS.

+proj=tmerc +lat_0=-34.5 +lon_0=-60.5 +k=0.9996 +x_0=500000 +y_0=500000 +ellps=WGS84 +datum=WGS84 +units=m +no_defs

- EPSG:5347 - POSGAR 2007 / Argentina Faja 5

+proj=tmerc +lat_0=-90 +lon_0=-60 +k=1 +x_0=5500000 +y_0=0 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs  <>

Ejemplos

Para tener algunos valores de referencia vamos a calcular las coordenadas de la Ciudad de Baradero en los distintos sistemas de referencia. Esto podemos hacerlo usando el programa proj.

La idea de tener estos valores es la de compararlos con las coordenadas promedio de los distintos conjuntos de datos, para identificar rápidamente el SRS que les corresponde.

Ciudad de Baradero: Latitud : -33.7967 Longitud : -59.5208

Transformar esas coordenadas a coordenadas planas:

# Ver calculos-de-referencia.sh

# Salida:

WGS84
-33.7967 -59.5208

epsg:98765 - SRS Local Baradero - Lincoln
590643.55   577551.53

epsg:32721 - UTM21S
266627.55   6257528.40





