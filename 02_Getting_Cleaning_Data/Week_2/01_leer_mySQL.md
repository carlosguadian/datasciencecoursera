Leer de mySQL
================

## mySQL

-   Software de BBDD ampliamente utilizado, open source y gratuito
-   Se utiliza en muchas aplicaciones de Internet
-   Los datos se estructuran en:
    -   BBDD
    -   Tablas dentro de las BBDD
    -   Campos dentro de las tablas
-   Cada fila es un registro.

## RMySQL()

Si no se tiene instalado el paquete RMySQL descomentar la línea. Si ya
lo tienes procede a cargar directamente la librería.

``` r
# install.packages("RMySQL")
library(RMySQL)
```

    ## Loading required package: DBI

## Conectar y listar BBDD

El paquete RMySQL nos permite conectar a BBDD, podemos definir un handle
con el usuario y el host para hacer cualquier tipo de consulta.

Es importante desconectarse una vez acabada la consulta/trabajo.

En este caso nos vamos a conectar para consultar las BBDD disponibles en
UCSC.

``` r
ucscDB <- dbConnect(MySQL(), user = "genome", host = "genome-mysql.cse.ucsc.edu")
result <- dbGetQuery(ucscDB, "show databases;")
head(result)
```

    ##   Database
    ## 1  acaChl1
    ## 2  ailMel1
    ## 3  allMis1
    ## 4  allSin1
    ## 5  amaVit1
    ## 6  anaPla1

``` r
dbDisconnect(ucscDB) # Cuando se acaba de hacer la consulta se ha de desconectar
```

    ## [1] TRUE

Para conectarnos a una específica, en este caso hay que incorporar el
nombre de la BBDD, vamos a hacerlo a hg19

``` r
hg19 <- dbConnect(MySQL(), user = "genome", db = "hg19", host = "genome-mysql.cse.ucsc.edu")
allTables <- dbListTables(hg19)
length(allTables)
```

    ## [1] 12535

``` r
allTables[1:5]
```

    ## [1] "HInv"         "HInvGeneMrna" "acembly"      "acemblyClass" "acemblyPep"

Si queremos trabajar con una tabla específica, debemos conocer su nombre
para poder acceder a ella. De esta manera podemos hacer todo tipo de
operaciones. Desde la consulta de los campos que tiene, a realizar
consultas SQL como calcular el número de registros que tiene.

``` r
dbListFields(hg19, "affyU133Plus2") # Consultamos los campos que tiene la tabla
```

    ##  [1] "bin"         "matches"     "misMatches"  "repMatches"  "nCount"     
    ##  [6] "qNumInsert"  "qBaseInsert" "tNumInsert"  "tBaseInsert" "strand"     
    ## [11] "qName"       "qSize"       "qStart"      "qEnd"        "tName"      
    ## [16] "tSize"       "tStart"      "tEnd"        "blockCount"  "blockSizes" 
    ## [21] "qStarts"     "tStarts"

``` r
dbGetQuery(hg19, "select count(*) from affyU133Plus2") # Calcular el número de registros
```

    ##   count(*)
    ## 1    58463

Se puede obtener la información de una tabla a modo de dataframe para
trabajar con ella.

``` r
library(tidyverse)
```

    ## ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.1 ──

    ## ✓ ggplot2 3.3.5     ✓ purrr   0.3.4
    ## ✓ tibble  3.1.4     ✓ dplyr   1.0.7
    ## ✓ tidyr   1.1.3     ✓ stringr 1.4.0
    ## ✓ readr   2.0.1     ✓ forcats 0.5.1

    ## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

``` r
affyData <- dbReadTable(hg19, "affyU133Plus2")
affyData <- tbl_df(affyData)
affyData
```

    ## # A tibble: 58,463 × 22
    ##      bin matches misMatches repMatches nCount qNumInsert qBaseInsert tNumInsert
    ##    <dbl>   <dbl>      <dbl>      <dbl>  <dbl>      <dbl>       <dbl>      <dbl>
    ##  1   585     530          4          0     23          3          41          3
    ##  2   585    3355         17          0    109          9          67          9
    ##  3   585    4156         14          0     83         16          18          2
    ##  4   585    4667          9          0     68         21          42          3
    ##  5   585    5180         14          0    167         10          38          1
    ##  6   585     468          5          0     14          0           0          0
    ##  7   585     723          3          0      6          1           1          1
    ##  8   585    1180          0          0      8          1           1          2
    ##  9    73    2585         21          0     56          2           2          1
    ## 10   585    1364         23          0     75         22          41          3
    ## # … with 58,453 more rows, and 14 more variables: tBaseInsert <dbl>,
    ## #   strand <chr>, qName <chr>, qSize <dbl>, qStart <dbl>, qEnd <dbl>,
    ## #   tName <chr>, tSize <dbl>, tStart <dbl>, tEnd <dbl>, blockCount <dbl>,
    ## #   blockSizes <chr>, qStarts <chr>, tStarts <chr>

Teniendo en cuenta que una BBDD puede contener mucha cantidad de
información, una tabla puede ser tan grande que sea difícil leerla en R
(recordemos que trabjamos en local y que dependemos de la capacidad de
nuestro ordenador).

Por lo tanto sería conveniente, en lugar de trabajar con la tabla
entera, hacer un subset y trabajar sólo con los datos que nos interesen.
En este caso seleccionamos de la BBDD hg19, y de la tabla affyU133Plus2
solo los registros que tengan un valor entre 1 y 3 en la variable
misMatches. Reducimos el número de registros de 58463 a 500. Una vez
guardado el subset en un nuevo dataframe, ya podemos realizar el
análisis que queramos.

``` r
query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")
affyMis <- fetch(query)
quantile(affyMis$misMatches)
```

    ##   0%  25%  50%  75% 100% 
    ##    1    1    2    2    3

También podemos traer una pequeña cantidad de la tabla en cuestión para
ver si es lo que buscamos. Vamos a pedir las primeras 10 líneas. Hay que
limpiar de la cache de la BBDD la query para que sea efectiva.

``` r
affyMisSmall <- fetch(query, n = 10)
dbClearResult(query)
```

    ## [1] TRUE

``` r
dim(affyMisSmall)
```

    ## [1] 10 22

No hay que olvidar desconectar la conexión

``` r
dbDisconnect(hg19)
```

    ## [1] TRUE
