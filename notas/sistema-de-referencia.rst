***Sistema de Referencia Espacial (SRS)***

El SRS elegido para realizar el trabajo es un sistema local al que, para uso propio, le asignamos el código epsg:98766. Es una proyección Gauss Kruger con centro en Baradero y coordenadas positivas en el área de trabajo:

Organizando los datos espaciales se ha encontrado cartografía en distintos sistemas de referencia. Algunos de estos SRS están citados por errores o confusiones, y la base de datos debe depurarse para conservar solamente los SRS necesarios. Todos los conjuntos de datos que sean inventariados en el proceso de organización de datos serán convertidos a uno de estos sistemas de referencia, es decir a epsg:4326 o epsg:9876.

El almacenamiento de los datos se realizará preferiblemente en el SRS Local o en coordenadas geográficas referidas al sistema WGS 84 si por alguna circunstancia fuese más conveniente.

***Elección del SRS Local***

Los parámetros de la definición del SRS Local se harán en base al centroide del polígono límite del departamento Baradero y su extensión, de manera que las coordenadas sean siempre positivas.

Para determinar el centroide del polígono que representa los límites del Partido de Baradero:

Se puede hacer con la calculadora de campos de QGIS. La expresión correspondiente es:

geomToWKT(centroid($geometry))

Se obtuvieron los siguientes valores:

-33.93378 ; -59.49449

Ahora debemos calcular la extensión del area de interés, a los fines de elegir parámetros que permitan trabajar con coordenadas positivas.
Para ello proyectamos el shape en el que hemos aislado el polígono de trabajo en un SRS auxiliar. El SRS auxiliar es el mismo SRS Local que vamos a usar en el trabajo, sólo que los valores de falso este y falso norte están igualados a cero, con lo cual tendremos coordenadas positivas y negativas:

/usr/bin/ogr2ogr -f "ESRI Shapefile" departamento-baradero-poligono_srs-auxiliar.shp /archivos/ot/datos-espaciales/departamento-baradero-poligono.shp -t_srs "+proj=tmerc +lat_0=-34.0 +lon_0=-59.5 +k=0.9996 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs" -s_srs "EPSG:4326"

Y el resúmen de la geometría proyectada se obtiene de la siguiente manera:

ogrinfo departamento-baradero-poligono_srs-auxiliar.shp -al -so

Extent: (-24176.510339, -19242.379560) - (30306.610371, 38895.129366)

Calculamos la extensión con una simple calculadora, bc:

30306.610371+24176.510339
54483.120710
38895.129366+19242.379560
58137.508926

Se puede deducir que con un valor de 50000 unidades se puede garantizar que toda la extensión del partido tendrá coordenadas positivas. Para asegurar además un margen que permita obtener coordenadas positivas en una extensión regional, elegimos el valor 100000. El SRS Local finalmente queda como:

<98766> +proj=tmerc +lat_0=-34.0 +lon_0=-59.5 +k=0.9996 +x_0=100000 +y_0=100000 +ellps=WGS84 +datum=WGS84 +units=m +no_defs <> 

Para revisar los valores elegidos y probar la configuración actualizada de proj4, nuevamente proyectamos la geometría límite del departamente, esta vez desde las coordenadas geográficas al SRS Local definitivo y calculamos su extensión, que en este caso equivale a imprimir un sumario de la geometría del shape:

/usr/bin/ogr2ogr -f "ESRI Shapefile" departamento-baradero-poligono_srs-local.shp /archivos/ot/datos-espaciales/departamento-baradero-poligono.shp -t_srs "EPSG:98766" -s_srs "EPSG:4326"

ogrinfo   -al departamento-baradero-poligono_srs-local.shp -geom=SUMMARY

Extent: (75823.489661, 80757.620440) - (130306.610371, 138895.129366)

**SRS encontrados**

A continuación, un listado de los SRS encontrados o citados en las bases de datos exploradas. Este listado se arma con el objetivo de tener como referencia esta información que puede ser necesaria para identificar el SRS en el que se encuentra un determinado conjunto de datos y para reproyectarlo al SRS Local:

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

**Ejemplos**

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

epsg:98766 - SRS Local - Partido de Baradero
98074.60    122540.93

epsg:32721 - UTM21S
266627.55   6257528.40





