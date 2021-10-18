Gestionar dataframes con dplyr()
================
Carlos Guadián

## Características de un dataframe

-   Hay una observación por fila
-   Cada columna representa una variable, medida o característica.
-   La implementación básica es la que hay por defecto en R
-   Otras implementaciones pueden ser sistemas de BBDD relacionales

## dplyr() package

Está diseñado específicamente para trabajar con dataframes. Tiene 6
verbos básicos:

-   arrange: reordena las filas del dataframe.
-   filter: extrae un subconjunto de filas del dataframe en base a
    condiciones lógicas.
-   select: devuelve un subconjunto de columnas del dataframe.
-   mutate: añade nuevas variables / columnas o transforma las
    existentes.
-   rename: renombra variables del dataframe.
-   summarise / summarize: genera sumarios estadísticos de diferentes
    variables del dataframe.

## Propiedades dplyr()

-   El primer argumento es el dataframe
-   Los siguientes argumentos describen lo que hacer con él y se pueden
    llamar las columnas directamente sin el $.
-   El resultado es un nuevo dataframe

## select()

Vamos a trabajar con un dataset de datos de la calidad del aire de
Chicago, en el que vemos que hay 6940 registros y 8 variables.

``` r
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
chicago <- readRDS("chicago.rds")
dim(chicago)
```

    ## [1] 6940    8

``` r
str(chicago)
```

    ## 'data.frame':    6940 obs. of  8 variables:
    ##  $ city      : chr  "chic" "chic" "chic" "chic" ...
    ##  $ tmpd      : num  31.5 33 33 29 32 40 34.5 29 26.5 32.5 ...
    ##  $ dptp      : num  31.5 29.9 27.4 28.6 28.9 ...
    ##  $ date      : Date, format: "1987-01-01" "1987-01-02" ...
    ##  $ pm25tmean2: num  NA NA NA NA NA NA NA NA NA NA ...
    ##  $ pm10tmean2: num  34 NA 34.2 47 NA ...
    ##  $ o3tmean2  : num  4.25 3.3 3.33 4.38 4.75 ...
    ##  $ no2tmean2 : num  20 23.2 23.8 30.4 30.3 ...

``` r
head(select(chicago, 1:5))
```

    ##   city tmpd   dptp       date pm25tmean2
    ## 1 chic 31.5 31.500 1987-01-01         NA
    ## 2 chic 33.0 29.875 1987-01-02         NA
    ## 3 chic 33.0 27.375 1987-01-03         NA
    ## 4 chic 29.0 28.625 1987-01-04         NA
    ## 5 chic 32.0 28.875 1987-01-05         NA
    ## 6 chic 40.0 35.125 1987-01-06         NA

En primer lugar vamos a pedir los nombres de las variables ya que con
dplyr() una de las cosas que podemos hacer es acceder a las variables
por su nombre y no sólo por su índice. Por ejmemplo, vamos a pedir todas
las variables que hay entre city y dptp.

``` r
names(chicago)
```

    ## [1] "city"       "tmpd"       "dptp"       "date"       "pm25tmean2"
    ## [6] "pm10tmean2" "o3tmean2"   "no2tmean2"

``` r
head(select(chicago, city:dptp))
```

    ##   city tmpd   dptp
    ## 1 chic 31.5 31.500
    ## 2 chic 33.0 29.875
    ## 3 chic 33.0 27.375
    ## 4 chic 29.0 28.625
    ## 5 chic 32.0 28.875
    ## 6 chic 40.0 35.125

También podemos excluir variables utilizando el signo -

``` r
names(chicago)
```

    ## [1] "city"       "tmpd"       "dptp"       "date"       "pm25tmean2"
    ## [6] "pm10tmean2" "o3tmean2"   "no2tmean2"

``` r
head(select(chicago, -(city:dptp)))
```

    ##         date pm25tmean2 pm10tmean2 o3tmean2 no2tmean2
    ## 1 1987-01-01         NA   34.00000 4.250000  19.98810
    ## 2 1987-01-02         NA         NA 3.304348  23.19099
    ## 3 1987-01-03         NA   34.16667 3.333333  23.81548
    ## 4 1987-01-04         NA   47.00000 4.375000  30.43452
    ## 5 1987-01-05         NA         NA 4.750000  30.33333
    ## 6 1987-01-06         NA   48.00000 5.833333  25.77233

Lo que en código base de R sería lo siguiente

``` r
i <- match("city", names(chicago))
j <- match("dptp", names(chicago))
head(chicago[, -(i:j)])
```

## filter()

Con filter() podemos segmentar el dataset basándonos en condiciones, por
ejemplo pedir todos aquellos registros en los que pm25tmean2 sea
superior a 30.

``` r
chic.f <- filter(chicago, pm25tmean2 > 30)
head(chic.f, 10)
```

    ##    city tmpd dptp       date pm25tmean2 pm10tmean2  o3tmean2 no2tmean2
    ## 1  chic   23 21.9 1998-01-17      38.10   32.46154  3.180556  25.30000
    ## 2  chic   28 25.8 1998-01-23      33.95   38.69231  1.750000  29.37630
    ## 3  chic   55 51.3 1998-04-30      39.40   34.00000 10.786232  25.31310
    ## 4  chic   59 53.7 1998-05-01      35.40   28.50000 14.295125  31.42905
    ## 5  chic   57 52.0 1998-05-02      33.30   35.00000 20.662879  26.79861
    ## 6  chic   57 56.0 1998-05-07      32.10   34.50000 24.270422  33.99167
    ## 7  chic   75 65.8 1998-05-15      56.50   91.00000 38.573007  29.03261
    ## 8  chic   61 59.0 1998-06-09      33.80   26.00000 17.890810  25.49668
    ## 9  chic   73 60.3 1998-07-13      30.30   64.50000 37.018865  37.93056
    ## 10 chic   78 67.1 1998-07-14      41.40   75.00000 40.080902  32.59054

Se pueden utilizar más de una condición. Añadimos a la condición
anterior que la temperatura sea superior a 80.

``` r
chic.f <- filter(chicago, pm25tmean2 > 30 & tmpd > 80)
# head(chic.f)
```

## arrange()

Reordenar las filas de un dataframe (conservando el orden
correspondiente de otras columnas) es complicado en R.

arrange() viene a dar una respuesta fácil a este problema.

Por ejemplo podemor ordenar por date

``` r
chicago <- arrange(chicago, date)
head(select(chicago, date, pm25tmean2), 3)
```

    ##         date pm25tmean2
    ## 1 1987-01-01         NA
    ## 2 1987-01-02         NA
    ## 3 1987-01-03         NA

``` r
tail(select(chicago, date, pm25tmean2), 3)
```

    ##            date pm25tmean2
    ## 6938 2005-12-29    7.45000
    ## 6939 2005-12-30   15.05714
    ## 6940 2005-12-31   15.00000

Hacerlo en orden invertido.

``` r
chicago <- arrange(chicago, desc(date))
head(select(chicago, date, pm25tmean2), 3)
```

    ##         date pm25tmean2
    ## 1 2005-12-31   15.00000
    ## 2 2005-12-30   15.05714
    ## 3 2005-12-29    7.45000

``` r
tail(select(chicago, date, pm25tmean2), 3)
```

    ##            date pm25tmean2
    ## 6938 1987-01-03         NA
    ## 6939 1987-01-02         NA
    ## 6940 1987-01-01         NA

## rename()

Renombrar una variable también puede ser complicado, pero con rename()
se simplifica el proceso.

``` r
head(chicago[, 1:5], 3)
```

    ##   city tmpd dptp       date pm25tmean2
    ## 1 chic   35 30.1 2005-12-31   15.00000
    ## 2 chic   36 31.0 2005-12-30   15.05714
    ## 3 chic   35 29.4 2005-12-29    7.45000

``` r
chicago <- rename(chicago, dewpoint = dptp, 
                  pm25 = pm25tmean2)
head(chicago[, 1:5], 3)
```

    ##   city tmpd dewpoint       date     pm25
    ## 1 chic   35     30.1 2005-12-31 15.00000
    ## 2 chic   36     31.0 2005-12-30 15.05714
    ## 3 chic   35     29.4 2005-12-29  7.45000

## mutate()

mutate() nos va a ayudar a cambiar una variable en base a un cálculo.

``` r
chicago <- mutate(chicago, 
                  pm25detrend=pm25-mean(pm25, na.rm=TRUE))
head(select(chicago, pm25, pm25detrend))
```

    ##       pm25 pm25detrend
    ## 1 15.00000   -1.230958
    ## 2 15.05714   -1.173815
    ## 3  7.45000   -8.780958
    ## 4 17.75000    1.519042
    ## 5 23.56000    7.329042
    ## 6  8.40000   -7.830958

## group\_by()

Genera sumarios de una variable agrupados por nivel. Esto nos permite
dividir el dataset.

Vamos a añadir una nueva categoría con diferentes niveles para generar
una estructura de datos.

``` r
chicago <- mutate(chicago, 
                  tempcat = factor(1 * (tmpd > 80), 
                                   labels = c("cold", "hot")))
hotcold <- group_by(chicago, tempcat)
hotcold
```

    ## # A tibble: 6,940 × 10
    ## # Groups:   tempcat [3]
    ##    city   tmpd dewpoint date        pm25 pm10tmean2 o3tmean2 no2tmean2
    ##    <chr> <dbl>    <dbl> <date>     <dbl>      <dbl>    <dbl>     <dbl>
    ##  1 chic     35     30.1 2005-12-31 15          23.5     2.53      13.2
    ##  2 chic     36     31   2005-12-30 15.1        19.2     3.03      22.8
    ##  3 chic     35     29.4 2005-12-29  7.45       23.5     6.79      20.0
    ##  4 chic     37     34.5 2005-12-28 17.8        27.5     3.26      19.3
    ##  5 chic     40     33.6 2005-12-27 23.6        27       4.47      23.5
    ##  6 chic     35     29.6 2005-12-26  8.4         8.5    14.0       16.8
    ##  7 chic     35     32.1 2005-12-25  6.7         8      14.4       13.8
    ##  8 chic     37     35.2 2005-12-24 30.8        25.2     1.77      32.0
    ##  9 chic     41     32.6 2005-12-23 32.9        34.5     6.91      29.1
    ## 10 chic     22     23.3 2005-12-22 36.6        42.5     5.39      33.7
    ## # … with 6,930 more rows, and 2 more variables: pm25detrend <dbl>,
    ## #   tempcat <fct>

``` r
summarize(hotcold, pm25 = mean(pm25, na.rm = TRUE), 
          o3 = max(o3tmean2), 
          no2 = median(no2tmean2))
```

    ## # A tibble: 3 × 4
    ##   tempcat  pm25    o3   no2
    ##   <fct>   <dbl> <dbl> <dbl>
    ## 1 cold     16.0 66.6   24.5
    ## 2 hot      26.5 63.0   24.9
    ## 3 <NA>     47.7  9.42  37.4

``` r
chicago <- mutate(chicago, year = as.POSIXlt(date)$year + 1900)
years <- group_by(chicago, year)
summarize(years, pm25 = mean(pm25, na.rm = TRUE), 
          o3 = max(o3tmean2, na.rm = TRUE), 
          no2 = median(no2tmean2, na.rm = TRUE))
```

    ## # A tibble: 19 × 4
    ##     year  pm25    o3   no2
    ##    <dbl> <dbl> <dbl> <dbl>
    ##  1  1987 NaN    63.0  23.5
    ##  2  1988 NaN    61.7  24.5
    ##  3  1989 NaN    59.7  26.1
    ##  4  1990 NaN    52.2  22.6
    ##  5  1991 NaN    63.1  21.4
    ##  6  1992 NaN    50.8  24.8
    ##  7  1993 NaN    44.3  25.8
    ##  8  1994 NaN    52.2  28.5
    ##  9  1995 NaN    66.6  27.3
    ## 10  1996 NaN    58.4  26.4
    ## 11  1997 NaN    56.5  25.5
    ## 12  1998  18.3  50.7  24.6
    ## 13  1999  18.5  57.5  24.7
    ## 14  2000  16.9  55.8  23.5
    ## 15  2001  16.9  51.8  25.1
    ## 16  2002  15.3  54.9  22.7
    ## 17  2003  15.2  56.2  24.6
    ## 18  2004  14.6  44.5  23.4
    ## 19  2005  16.2  58.8  22.6

## %&gt;%

``` r
chicago %>% mutate(month = as.POSIXlt(date)$mon + 1) %>% group_by(month) %>% summarize(pm25 = mean(pm25, na.rm = TRUE), o3 = max(o3tmean2, na.rm = TRUE), no2 = median(no2tmean2, na.rm = TRUE))
```

    ## # A tibble: 12 × 4
    ##    month  pm25    o3   no2
    ##    <dbl> <dbl> <dbl> <dbl>
    ##  1     1  17.8  28.2  25.4
    ##  2     2  20.4  37.4  26.8
    ##  3     3  17.4  39.0  26.8
    ##  4     4  13.9  47.9  25.0
    ##  5     5  14.1  52.8  24.2
    ##  6     6  15.9  66.6  25.0
    ##  7     7  16.6  59.5  22.4
    ##  8     8  16.9  54.0  23.0
    ##  9     9  15.9  57.5  24.5
    ## 10    10  14.2  47.1  24.2
    ## 11    11  15.2  29.5  23.6
    ## 12    12  17.5  27.7  24.5

## dplyr

Una vez que se aprende la “gramática” de dplyr hay algunos beneficios
adicionales

-   dplyr puede trabajar con otros “backends” de marcos de datos

-   `data.table` para tablas grandes y rápidas

-   Interfaz SQL para bases de datos relacionales a través del paquete
    DBI
