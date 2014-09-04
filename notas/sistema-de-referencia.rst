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

- EPSG:32621 - WGS 84 / UTM zone 21N: es posible que este SRS haya sido usado por error en algún conjunto de datos. Una vez re-proyectados estos conjuntos de datos, puede eliminarse esta referencia.

  +proj=utm +zone=21 +ellps=WGS84 +datum=WGS84 +units=m +no_defs 

- EPSG:32721 - WGS 84 / UTM zone 21S: este es el SRS que se iba a utilizar originalmente. Una vez re-proyectados estos conjuntos de datos, puede eliminarse esta referencia.

  +proj=utm +zone=21 +south +ellps=WGS84 +datum=WGS84 +units=m +no_defs 

- EPSG:92720 (equivalente a "EPSG:32720 - WGS 84 / UTM zone 20S"): agregada porque al usar la EPSG:32720 que viene definida en el archivo epsg, los resultados no eran los esperados. Se había usado para datos de Lincoln así que probablemente no se utilice en el proceso de organización de los datos (eliminar la referencia al terminar).

  +proj=tmerc +lat_0=0 +lon_0=-63.0 +k=0.9996 +x_0=500000 +y_0=10000000 +north +ellps=WGS84 +datum=WGS84 +units=m +no_defs

- EPSG:92721 (equivalente a "EPSG:32721 - WGS 84 / UTM zone 21S"): agregada porque al usar la EPSG:32721 que viene definida en el archivo epsg, los resultados no eran los esperados.

  +proj=tmerc +lat_0=0 +lon_0=-57.0 +k=0.9996 +x_0=500000 +y_0=10000000 +ellps=WGS84 +datum=WGS84 +units=m +no_defs

``Acerca de las diferencias que motivaron el uso de los epsg 92720 y 92721: aparentemente estaban mal configurados (false_northing; corregido de 0 a 10000000). Tal vez esto tiene que ver los errores de superposición de capas de distinto SRS de origen y que dieron lugar al uso de SRS personalizados para reemplazar las definiciones del sistema UTM internas de proj4 . En un primer momento se pensó que había algún error relacionado al uso de esas definiciones de UTM (de códigos 32720 y 32721) y eso motivó el agregado manual de SRS equivalentes. Como esa prueba dió resultado positivo, pensamos que la posibilidad de encontrarnos ante un bug era cierta. Ahora los cálculos coinciden, así que estas diferencias correspondieron a un manejo incorrecto de los datos, o bien si se trataba de un error el mismo ya no se produce.``

- EPSG:98765 - Local - Partidos de Baradero y Lincoln: el meridiano central corresponde a un punto intermedio entre las ciudades de Baradero y Lincoln. Es el SRS que se iba a usar en el trabajo anterior. Hay algunos conjuntos de datos usando este SRS, los cuales serán convertidos al "SRS Local - Partido de Baradero".

  +proj=tmerc +lat_0=-34.5 +lon_0=-60.5 +k=0.9996 +x_0=500000 +y_0=500000 +ellps=WGS84 +datum=WGS84 +units=m +no_defs

- EPSG:22185 - POSGAR 94 / Argentina Faja 5: es el SRS oficial de la cartografía nacional que corresponde a la región del Partido de Baradero.

  +proj=tmerc +lat_0=-90 +lon_0=-60 +k=1 +x_0=5500000 +y_0=0 +ellps=WGS84 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs

**Ejemplos**

Para tener algunos valores de referencia vamos a calcular las coordenadas de la Ciudad de Baradero en los distintos sistemas de referencia. Esto podemos hacerlo usando el programa proj.

La idea de tener estos valores es la de compararlos con las coordenadas promedio de los distintos conjuntos de datos, para identificar rápidamente el SRS que les corresponde.

Ciudad de Baradero: Latitud : -33.7967 Longitud : -59.5208

Transformar a coordenadas planas en los distintos SRS usados en los conjuntos de datos explorados y en el SRS Local:

# Ver calculos-de-referencia.sh

# Salida:

WGS84:

-33.7967 -59.5208

epsg:98765 - SRS Local Baradero / Lincoln:

590643.55   577551.53

epsg:98766 - SRS Local - Partido de Baradero:

98074.60    122540.93

epsg:32721 - UTM21S:

266627.55   6257528.40

