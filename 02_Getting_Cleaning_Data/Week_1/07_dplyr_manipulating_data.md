Manipular datos con dplyr()
================

## Los 5 verbos

dplyr() facilita la manipulación de datos con 5 funciones, 5 verbos:

-   select()
-   filter()
-   arrange()
-   mutate()
-   summarize()

Cargamos dplyr()

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

Leemos el archivo cran para practicar con él

``` r
cran <- read.csv("./data/cran.csv")
```

Lo convertimos tibble, es más operativo, sobre todo en las impresiones
de resultados.

``` r
cran <- tbl_df(cran)
```

    ## Warning: `tbl_df()` was deprecated in dplyr 1.0.0.
    ## Please use `tibble::as_tibble()` instead.

``` r
cran
```

    ## # A tibble: 225,468 × 12
    ##      X.1     X date  time    size r_version r_arch r_os  package version country
    ##    <int> <int> <chr> <chr>  <int> <chr>     <chr>  <chr> <chr>   <chr>   <chr>  
    ##  1     1     1 2014… 00:5… 8.06e4 3.1.0     x86_64 ming… htmlto… 0.2.4   US     
    ##  2     2     2 2014… 00:5… 3.22e5 3.1.0     x86_64 ming… tseries 0.10-32 US     
    ##  3     3     3 2014… 00:4… 7.48e5 3.1.0     x86_64 linu… party   1.0-15  US     
    ##  4     4     4 2014… 00:4… 6.06e5 3.1.0     x86_64 linu… Hmisc   3.14-4  US     
    ##  5     5     5 2014… 00:4… 7.98e4 3.0.2     x86_64 linu… digest  0.6.4   CA     
    ##  6     6     6 2014… 00:4… 7.77e4 3.1.0     x86_64 linu… random… 4.6-7   US     
    ##  7     7     7 2014… 00:4… 3.94e5 3.1.0     x86_64 linu… plyr    1.8.1   US     
    ##  8     8     8 2014… 00:4… 2.82e4 3.0.2     x86_64 linu… whisker 0.3-2   US     
    ##  9     9     9 2014… 00:5… 5.93e3 <NA>      <NA>   <NA>  Rcpp    0.10.4  CN     
    ## 10    10    10 2014… 00:1… 2.21e6 3.0.2     x86_64 linu… hfligh… 0.1     US     
    ## # … with 225,458 more rows, and 1 more variable: ip_id <int>

## select()

select() facilita hacer un subset de las variables que queremos para
trabajar sólo con ellas. Por ejemplo si queremos solo las columnas
ip\_id, package y country del dataset cran

``` r
select(cran, ip_id, package, country)
```

    ## # A tibble: 225,468 × 3
    ##    ip_id package      country
    ##    <int> <chr>        <chr>  
    ##  1     1 htmltools    US     
    ##  2     2 tseries      US     
    ##  3     3 party        US     
    ##  4     3 Hmisc        US     
    ##  5     4 digest       CA     
    ##  6     3 randomForest US     
    ##  7     3 plyr         US     
    ##  8     5 whisker      US     
    ##  9     6 Rcpp         CN     
    ## 10     7 hflights     US     
    ## # … with 225,458 more rows

La selección que hacemos se genera en el mismo orden en el que incluímos
las variables. Ahora ponemos ip\_id al final

``` r
select(cran, package, country, ip_id)
```

    ## # A tibble: 225,468 × 3
    ##    package      country ip_id
    ##    <chr>        <chr>   <int>
    ##  1 htmltools    US          1
    ##  2 tseries      US          2
    ##  3 party        US          3
    ##  4 Hmisc        US          3
    ##  5 digest       CA          4
    ##  6 randomForest US          3
    ##  7 plyr         US          3
    ##  8 whisker      US          5
    ##  9 Rcpp         CN          6
    ## 10 hflights     US          7
    ## # … with 225,458 more rows

Podemos también utilizar rangos para seleccionar las variables que
queremos, por ejemplo para seleccionar las variables de r\_arch hasta
country

``` r
select(cran, r_arch:country)
```

    ## # A tibble: 225,468 × 5
    ##    r_arch r_os      package      version country
    ##    <chr>  <chr>     <chr>        <chr>   <chr>  
    ##  1 x86_64 mingw32   htmltools    0.2.4   US     
    ##  2 x86_64 mingw32   tseries      0.10-32 US     
    ##  3 x86_64 linux-gnu party        1.0-15  US     
    ##  4 x86_64 linux-gnu Hmisc        3.14-4  US     
    ##  5 x86_64 linux-gnu digest       0.6.4   CA     
    ##  6 x86_64 linux-gnu randomForest 4.6-7   US     
    ##  7 x86_64 linux-gnu plyr         1.8.1   US     
    ##  8 x86_64 linux-gnu whisker      0.3-2   US     
    ##  9 <NA>   <NA>      Rcpp         0.10.4  CN     
    ## 10 x86_64 linux-gnu hflights     0.1     US     
    ## # … with 225,458 more rows

Podemos también decidir que no queremos una o varias variables con el
signo -

``` r
select(cran, -time) #sn la variable time
```

    ## # A tibble: 225,468 × 11
    ##      X.1     X date    size r_version r_arch r_os  package version country ip_id
    ##    <int> <int> <chr>  <int> <chr>     <chr>  <chr> <chr>   <chr>   <chr>   <int>
    ##  1     1     1 2014… 8.06e4 3.1.0     x86_64 ming… htmlto… 0.2.4   US          1
    ##  2     2     2 2014… 3.22e5 3.1.0     x86_64 ming… tseries 0.10-32 US          2
    ##  3     3     3 2014… 7.48e5 3.1.0     x86_64 linu… party   1.0-15  US          3
    ##  4     4     4 2014… 6.06e5 3.1.0     x86_64 linu… Hmisc   3.14-4  US          3
    ##  5     5     5 2014… 7.98e4 3.0.2     x86_64 linu… digest  0.6.4   CA          4
    ##  6     6     6 2014… 7.77e4 3.1.0     x86_64 linu… random… 4.6-7   US          3
    ##  7     7     7 2014… 3.94e5 3.1.0     x86_64 linu… plyr    1.8.1   US          3
    ##  8     8     8 2014… 2.82e4 3.0.2     x86_64 linu… whisker 0.3-2   US          5
    ##  9     9     9 2014… 5.93e3 <NA>      <NA>   <NA>  Rcpp    0.10.4  CN          6
    ## 10    10    10 2014… 2.21e6 3.0.2     x86_64 linu… hfligh… 0.1     US          7
    ## # … with 225,458 more rows

``` r
select(cran, -(X:size)) # quitar desde X hasta size
```

    ## # A tibble: 225,468 × 8
    ##      X.1 r_version r_arch r_os      package      version country ip_id
    ##    <int> <chr>     <chr>  <chr>     <chr>        <chr>   <chr>   <int>
    ##  1     1 3.1.0     x86_64 mingw32   htmltools    0.2.4   US          1
    ##  2     2 3.1.0     x86_64 mingw32   tseries      0.10-32 US          2
    ##  3     3 3.1.0     x86_64 linux-gnu party        1.0-15  US          3
    ##  4     4 3.1.0     x86_64 linux-gnu Hmisc        3.14-4  US          3
    ##  5     5 3.0.2     x86_64 linux-gnu digest       0.6.4   CA          4
    ##  6     6 3.1.0     x86_64 linux-gnu randomForest 4.6-7   US          3
    ##  7     7 3.1.0     x86_64 linux-gnu plyr         1.8.1   US          3
    ##  8     8 3.0.2     x86_64 linux-gnu whisker      0.3-2   US          5
    ##  9     9 <NA>      <NA>   <NA>      Rcpp         0.10.4  CN          6
    ## 10    10 3.0.2     x86_64 linux-gnu hflights     0.1     US          7
    ## # … with 225,458 more rows

## filter()

filter() lo vamos a utilizar para seleccionar las observaciones que
coincidan con alguna condición. Por ejemplo, aquellas en las que package
sea igual a “swirl”.

``` r
filter(cran, package == "swirl")
```

    ## # A tibble: 820 × 12
    ##      X.1     X date  time    size r_version r_arch r_os  package version country
    ##    <int> <int> <chr> <chr>  <int> <chr>     <chr>  <chr> <chr>   <chr>   <chr>  
    ##  1    27    27 2014… 00:1… 105350 3.0.2     x86_64 ming… swirl   2.2.9   US     
    ##  2   156   156 2014… 00:2…  41261 3.1.0     x86_64 linu… swirl   2.2.9   US     
    ##  3   358   358 2014… 00:1… 105335 2.15.2    x86_64 ming… swirl   2.2.9   CA     
    ##  4   593   593 2014… 00:5… 105465 3.1.0     x86_64 darw… swirl   2.2.9   MX     
    ##  5   831   831 2014… 00:5… 105335 3.0.3     x86_64 ming… swirl   2.2.9   US     
    ##  6   997   997 2014… 00:3…  41261 3.1.0     x86_64 ming… swirl   2.2.9   US     
    ##  7  1023  1023 2014… 00:3… 106393 3.1.0     x86_64 ming… swirl   2.2.9   BR     
    ##  8  1144  1144 2014… 00:0… 106534 3.0.2     x86_64 linu… swirl   2.2.9   US     
    ##  9  1402  1402 2014… 00:4…  41261 3.1.0     i386   ming… swirl   2.2.9   US     
    ## 10  1424  1424 2014… 00:4… 106393 3.1.0     x86_64 linu… swirl   2.2.9   US     
    ## # … with 810 more rows, and 1 more variable: ip_id <int>

Se puede incorporar más de una condición

``` r
filter(cran, r_version == "3.1.1", country == "US")
```

    ## # A tibble: 1,588 × 12
    ##      X.1     X date  time    size r_version r_arch r_os  package version country
    ##    <int> <int> <chr> <chr>  <int> <chr>     <chr>  <chr> <chr>   <chr>   <chr>  
    ##  1  2216  2216 2014… 00:4… 3.85e5 3.1.1     x86_64 darw… colors… 1.2-4   US     
    ##  2 17332 17332 2014… 03:3… 1.97e5 3.1.1     x86_64 darw… httr    0.3     US     
    ##  3 17465 17465 2014… 03:2… 2.33e4 3.1.1     x86_64 darw… snow    0.3-13  US     
    ##  4 18844 18844 2014… 03:5… 1.91e5 3.1.1     x86_64 darw… maxLik  1.2-0   US     
    ##  5 30182 30182 2014… 04:1… 7.77e4 3.1.1     i386   ming… random… 4.6-7   US     
    ##  6 30193 30193 2014… 04:0… 2.35e6 3.1.1     i386   ming… ggplot2 1.0.0   US     
    ##  7 30195 30195 2014… 04:0… 2.99e5 3.1.1     i386   ming… fExtre… 3010.81 US     
    ##  8 30217 30217 2014… 04:3… 5.68e5 3.1.1     i386   ming… rJava   0.9-6   US     
    ##  9 30245 30245 2014… 04:1… 5.27e5 3.1.1     i386   ming… LPCM    0.44-8  US     
    ## 10 30354 30354 2014… 04:3… 1.76e6 3.1.1     i386   ming… mgcv    1.8-1   US     
    ## # … with 1,578 more rows, and 1 more variable: ip_id <int>

``` r
filter(cran, country == "US" | country == "IN")
```

    ## # A tibble: 95,283 × 12
    ##      X.1     X date  time    size r_version r_arch r_os  package version country
    ##    <int> <int> <chr> <chr>  <int> <chr>     <chr>  <chr> <chr>   <chr>   <chr>  
    ##  1     1     1 2014… 00:5… 8.06e4 3.1.0     x86_64 ming… htmlto… 0.2.4   US     
    ##  2     2     2 2014… 00:5… 3.22e5 3.1.0     x86_64 ming… tseries 0.10-32 US     
    ##  3     3     3 2014… 00:4… 7.48e5 3.1.0     x86_64 linu… party   1.0-15  US     
    ##  4     4     4 2014… 00:4… 6.06e5 3.1.0     x86_64 linu… Hmisc   3.14-4  US     
    ##  5     6     6 2014… 00:4… 7.77e4 3.1.0     x86_64 linu… random… 4.6-7   US     
    ##  6     7     7 2014… 00:4… 3.94e5 3.1.0     x86_64 linu… plyr    1.8.1   US     
    ##  7     8     8 2014… 00:4… 2.82e4 3.0.2     x86_64 linu… whisker 0.3-2   US     
    ##  8    10    10 2014… 00:1… 2.21e6 3.0.2     x86_64 linu… hfligh… 0.1     US     
    ##  9    11    11 2014… 00:1… 5.27e5 3.0.2     x86_64 linu… LPCM    0.44-8  US     
    ## 10    12    12 2014… 00:1… 2.35e6 2.14.1    x86_64 linu… ggplot2 1.0.0   US     
    ## # … with 95,273 more rows, and 1 more variable: ip_id <int>

``` r
filter(cran, size > 100500, r_os == "linux-gnu")
```

    ## # A tibble: 33,683 × 12
    ##      X.1     X date  time    size r_version r_arch r_os  package version country
    ##    <int> <int> <chr> <chr>  <int> <chr>     <chr>  <chr> <chr>   <chr>   <chr>  
    ##  1     3     3 2014… 00:4… 7.48e5 3.1.0     x86_64 linu… party   1.0-15  US     
    ##  2     4     4 2014… 00:4… 6.06e5 3.1.0     x86_64 linu… Hmisc   3.14-4  US     
    ##  3     7     7 2014… 00:4… 3.94e5 3.1.0     x86_64 linu… plyr    1.8.1   US     
    ##  4    10    10 2014… 00:1… 2.21e6 3.0.2     x86_64 linu… hfligh… 0.1     US     
    ##  5    11    11 2014… 00:1… 5.27e5 3.0.2     x86_64 linu… LPCM    0.44-8  US     
    ##  6    12    12 2014… 00:1… 2.35e6 2.14.1    x86_64 linu… ggplot2 1.0.0   US     
    ##  7    14    14 2014… 00:1… 3.10e6 3.0.2     x86_64 linu… Rcpp    0.9.7   VE     
    ##  8    15    15 2014… 00:1… 5.68e5 3.1.0     x86_64 linu… rJava   0.9-6   US     
    ##  9    16    16 2014… 00:1… 1.60e6 3.1.0     x86_64 linu… RSQLite 0.11.4  US     
    ## 10    18    18 2014… 00:2… 1.87e5 3.1.0     x86_64 linu… ipred   0.9-3   DE     
    ## # … with 33,673 more rows, and 1 more variable: ip_id <int>

Con is.na() podemos dejar fuera de la selección los NA

``` r
filter(cran, !is.na(r_version))
```

    ## # A tibble: 207,205 × 12
    ##      X.1     X date  time    size r_version r_arch r_os  package version country
    ##    <int> <int> <chr> <chr>  <int> <chr>     <chr>  <chr> <chr>   <chr>   <chr>  
    ##  1     1     1 2014… 00:5… 8.06e4 3.1.0     x86_64 ming… htmlto… 0.2.4   US     
    ##  2     2     2 2014… 00:5… 3.22e5 3.1.0     x86_64 ming… tseries 0.10-32 US     
    ##  3     3     3 2014… 00:4… 7.48e5 3.1.0     x86_64 linu… party   1.0-15  US     
    ##  4     4     4 2014… 00:4… 6.06e5 3.1.0     x86_64 linu… Hmisc   3.14-4  US     
    ##  5     5     5 2014… 00:4… 7.98e4 3.0.2     x86_64 linu… digest  0.6.4   CA     
    ##  6     6     6 2014… 00:4… 7.77e4 3.1.0     x86_64 linu… random… 4.6-7   US     
    ##  7     7     7 2014… 00:4… 3.94e5 3.1.0     x86_64 linu… plyr    1.8.1   US     
    ##  8     8     8 2014… 00:4… 2.82e4 3.0.2     x86_64 linu… whisker 0.3-2   US     
    ##  9    10    10 2014… 00:1… 2.21e6 3.0.2     x86_64 linu… hfligh… 0.1     US     
    ## 10    11    11 2014… 00:1… 5.27e5 3.0.2     x86_64 linu… LPCM    0.44-8  US     
    ## # … with 207,195 more rows, and 1 more variable: ip_id <int>

## arrange()

arrange() nos va a servir para ordenar el dataset de acuerdo a los
valores de una variable particular.

Por ejemplo, vamos a ordenar por ip\_id en orden ascendente.

``` r
arrange(cran, ip_id)
```

    ## # A tibble: 225,468 × 12
    ##      X.1     X date  time    size r_version r_arch r_os  package version country
    ##    <int> <int> <chr> <chr>  <int> <chr>     <chr>  <chr> <chr>   <chr>   <chr>  
    ##  1     1     1 2014… 00:5…  80589 3.1.0     x86_64 ming… htmlto… 0.2.4   US     
    ##  2   437   437 2014… 00:5… 180562 3.0.2     x86_64 ming… yaml    2.1.13  US     
    ##  3  5995  5995 2014… 01:3… 190120 3.1.0     i386   ming… babel   0.2-6   US     
    ##  4     2     2 2014… 00:5… 321767 3.1.0     x86_64 ming… tseries 0.10-32 US     
    ##  5  2756  2756 2014… 00:5…  52281 3.0.3     x86_64 darw… quadpr… 1.5-5   US     
    ##  6  2757  2757 2014… 00:5… 876702 3.1.0     x86_64 linu… zoo     1.7-11  US     
    ##  7  2758  2758 2014… 00:5… 321764 3.0.2     x86_64 linu… tseries 0.10-32 US     
    ##  8  5772  5772 2014… 01:3… 876702 3.1.0     x86_64 linu… zoo     1.7-11  US     
    ##  9  6854  6854 2014… 01:1… 321768 3.1.0     x86_64 ming… tseries 0.10-32 US     
    ## 10  9150  9150 2014… 01:4… 784093 3.1.0     x86_64 linu… strucc… 1.5-0   US     
    ## # … with 225,458 more rows, and 1 more variable: ip_id <int>

Si lo queremos en orden descendente, aplicamos desc()

``` r
arrange(cran, desc(ip_id))
```

    ## # A tibble: 225,468 × 12
    ##       X.1      X date       time       size r_version r_arch r_os  package version
    ##     <int>  <int> <chr>      <chr>     <int> <chr>     <chr>  <chr> <chr>   <chr>  
    ##  1 225464 225464 2014-07-08 23:43:15 5.93e3 <NA>      <NA>   <NA>  CPE     1.4.2  
    ##  2 225424 225424 2014-07-08 23:40:17 5.69e5 3.1.0     x86_64 ming… multco… 0.1-5  
    ##  3 225371 225371 2014-07-08 23:25:46 2.28e5 3.1.0     x86_64 ming… tourr   0.5.3  
    ##  4 225368 225368 2014-07-08 23:20:35 3.09e5 3.1.0     x86_64 darw… ctv     0.7-9  
    ##  5 225359 225359 2014-07-08 23:13:38 9.51e5 3.0.3     i386   ming… knitr   1.6    
    ##  6 225360 225360 2014-07-08 23:13:41 8.02e4 3.0.3     i386   ming… htmlto… 0.2.4  
    ##  7 225361 225361 2014-07-08 23:13:44 1.43e6 3.0.3     i386   ming… shiny   0.10.0 
    ##  8 225349 225349 2014-07-08 23:40:35 2.19e6 3.1.0     x86_64 ming… RMySQL  0.9-3  
    ##  9 225290 225290 2014-07-08 23:50:44 4.82e6 3.1.0     i386   ming… igraph  0.7.1  
    ## 10 225220 225220 2014-07-08 23:04:41 1.97e5 3.1.0     x86_64 ming… coda    0.16-1 
    ## # … with 225,458 more rows, and 2 more variables: country <chr>, ip_id <int>

También podemos ordenar por más de una variable. Por ejemplo, si
queremos que se ordene primero por “country”, después en orden
descendente por “r\_version” y por último por ip\_id

``` r
arrange(cran, country, desc(r_version), ip_id)
```

    ## # A tibble: 225,468 × 12
    ##      X.1     X date  time    size r_version r_arch r_os  package version country
    ##    <int> <int> <chr> <chr>  <int> <chr>     <chr>  <chr> <chr>   <chr>   <chr>  
    ##  1 37969 37969 2014… 06:2… 1.56e6 3.1.1     i386   ming… RcppAr… 0.4.32… A1     
    ##  2 39858 39858 2014… 06:2… 1.82e6 3.1.0     x86_64 linu… mgcv    1.8-1   A1     
    ##  3 41807 41807 2014… 06:1… 1.57e4 3.1.0     i686   linu… grnn    0.1.0   A1     
    ##  4 45930 45930 2014… 07:3… 3.01e6 3.1.0     x86_64 ming… Rcpp    0.11.2  A1     
    ##  5 92589 92589 2014… 11:4… 6.60e5 3.1.0     i386   ming… xts     0.9-7   A1     
    ##  6 92590 92590 2014… 11:4… 5.22e5 3.1.0     i386   ming… FNN     1.1     A1     
    ##  7 92591 92591 2014… 11:4… 5.22e5 3.1.0     i386   ming… FNN     1.1     A1     
    ##  8 94598 94598 2014… 11:4… 1.68e6 3.1.0     x86_64 linu… rgeos   0.3-5   A1     
    ##  9 94599 94599 2014… 11:4… 2.12e6 3.1.0     x86_64 linu… spacet… 1.1-0   A1     
    ## 10 94600 94600 2014… 11:4… 2.22e6 3.1.0     x86_64 ming… gstat   1.0-19  A1     
    ## # … with 225,458 more rows, and 1 more variable: ip_id <int>

## mutate()

Si necesitamos crear una nueva variable basada en una o más variables,
podemos hacerlo con mutate().

En este caso si queremos calcular el tamaño en MB vamos a utilizar la
variable size que está en bytes.

``` r
mutate(cran, size_mb = size / 2^20)
```

    ## # A tibble: 225,468 × 13
    ##      X.1     X date  time    size r_version r_arch r_os  package version country
    ##    <int> <int> <chr> <chr>  <int> <chr>     <chr>  <chr> <chr>   <chr>   <chr>  
    ##  1     1     1 2014… 00:5… 8.06e4 3.1.0     x86_64 ming… htmlto… 0.2.4   US     
    ##  2     2     2 2014… 00:5… 3.22e5 3.1.0     x86_64 ming… tseries 0.10-32 US     
    ##  3     3     3 2014… 00:4… 7.48e5 3.1.0     x86_64 linu… party   1.0-15  US     
    ##  4     4     4 2014… 00:4… 6.06e5 3.1.0     x86_64 linu… Hmisc   3.14-4  US     
    ##  5     5     5 2014… 00:4… 7.98e4 3.0.2     x86_64 linu… digest  0.6.4   CA     
    ##  6     6     6 2014… 00:4… 7.77e4 3.1.0     x86_64 linu… random… 4.6-7   US     
    ##  7     7     7 2014… 00:4… 3.94e5 3.1.0     x86_64 linu… plyr    1.8.1   US     
    ##  8     8     8 2014… 00:4… 2.82e4 3.0.2     x86_64 linu… whisker 0.3-2   US     
    ##  9     9     9 2014… 00:5… 5.93e3 <NA>      <NA>   <NA>  Rcpp    0.10.4  CN     
    ## 10    10    10 2014… 00:1… 2.21e6 3.0.2     x86_64 linu… hfligh… 0.1     US     
    ## # … with 225,458 more rows, and 2 more variables: ip_id <int>, size_mb <dbl>

Con mutate se puede utilizar una variable calculada para calcular una
tercera.

``` r
mutate(cran, size_mb = size / 2^20, size_gb = size_mb / 2 ^10)
```

    ## # A tibble: 225,468 × 14
    ##      X.1     X date  time    size r_version r_arch r_os  package version country
    ##    <int> <int> <chr> <chr>  <int> <chr>     <chr>  <chr> <chr>   <chr>   <chr>  
    ##  1     1     1 2014… 00:5… 8.06e4 3.1.0     x86_64 ming… htmlto… 0.2.4   US     
    ##  2     2     2 2014… 00:5… 3.22e5 3.1.0     x86_64 ming… tseries 0.10-32 US     
    ##  3     3     3 2014… 00:4… 7.48e5 3.1.0     x86_64 linu… party   1.0-15  US     
    ##  4     4     4 2014… 00:4… 6.06e5 3.1.0     x86_64 linu… Hmisc   3.14-4  US     
    ##  5     5     5 2014… 00:4… 7.98e4 3.0.2     x86_64 linu… digest  0.6.4   CA     
    ##  6     6     6 2014… 00:4… 7.77e4 3.1.0     x86_64 linu… random… 4.6-7   US     
    ##  7     7     7 2014… 00:4… 3.94e5 3.1.0     x86_64 linu… plyr    1.8.1   US     
    ##  8     8     8 2014… 00:4… 2.82e4 3.0.2     x86_64 linu… whisker 0.3-2   US     
    ##  9     9     9 2014… 00:5… 5.93e3 <NA>      <NA>   <NA>  Rcpp    0.10.4  CN     
    ## 10    10    10 2014… 00:1… 2.21e6 3.0.2     x86_64 linu… hfligh… 0.1     US     
    ## # … with 225,458 more rows, and 3 more variables: ip_id <int>, size_mb <dbl>,
    ## #   size_gb <dbl>

## summarize()

summarize() reduce el dataset a una fila, por ejemplo, si estamos
interesados en conocer la media del tamaño de las descargas en cran

``` r
summarize(cran, avg_bytes = mean(size))
```

    ## # A tibble: 1 × 1
    ##   avg_bytes
    ##       <dbl>
    ## 1   844086.
