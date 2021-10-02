Agrupar y encadenar con dplyr()
================

## Agrupar

Una de las cosas que nos puede interesar a la hora de manipular datos es
agruparlos en base a alguna de sus variables. dplyr() proporciona la
función group\_by()

Cargamos dplyr

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

-   abrir archivo
-   convertir a tibble tbl\_df()

``` r
cran <- read.csv("./data/cran.csv", header = TRUE)
cran <- tbl_df(cran)
```

    ## Warning: `tbl_df()` was deprecated in dplyr 1.0.0.
    ## Please use `tibble::as_tibble()` instead.

-   agrupar por una variable group\_by(package)
-   print tibble
-   calcular media por grupos summarize(data, mean(variable))

``` r
by_package <- group_by(cran, package)
by_package
```

    ## # A tibble: 225,468 × 12
    ## # Groups:   package [6,023]
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

``` r
summarize(by_package, mean(size))
```

    ## # A tibble: 6,023 × 2
    ##    package     `mean(size)`
    ##    <chr>              <dbl>
    ##  1 A3                62195.
    ##  2 abc             4826665 
    ##  3 abcdeFBA         455980.
    ##  4 ABCExtremes       22904.
    ##  5 ABCoptim          17807.
    ##  6 ABCp2             30473.
    ##  7 abctools        2589394 
    ##  8 abd              453631.
    ##  9 abf2              35693.
    ## 10 abind             32939.
    ## # … with 6,013 more rows

Se pueden calcular varias operaciones simultáneamente

``` r
pack_sum <- summarize(by_package,
                      count = n(),
                      unique = n_distinct(ip_id),
                      countries = n_distinct(country),
                      avg_bytes = mean(size))
```

Si no queremos repetir una orden tras otra, podemos insertar las
funciones unas dentro de otras

``` r
result2 <-
  arrange(
    filter(
      summarize(
        group_by(cran,
                 package
        ),
        count = n(),
        unique = n_distinct(ip_id),
        countries = n_distinct(country),
        avg_bytes = mean(size)
      ),
      countries > 60
    ),
    desc(countries),
    avg_bytes
  )

print(result2)
```

    ## # A tibble: 46 × 5
    ##    package      count unique countries avg_bytes
    ##    <chr>        <int>  <int>     <int>     <dbl>
    ##  1 Rcpp          3195   2044        84  2512100.
    ##  2 digest        2210   1894        83   120549.
    ##  3 stringr       2267   1948        82    65277.
    ##  4 plyr          2908   1754        81   799123.
    ##  5 ggplot2       4602   1680        81  2427716.
    ##  6 colorspace    1683   1433        80   357411.
    ##  7 RColorBrewer  1890   1584        79    22764.
    ##  8 scales        1726   1408        77   126819.
    ##  9 bitops        1549   1408        76    28715.
    ## 10 reshape2      2032   1652        76   330128.
    ## # … with 36 more rows

Utilizando pipes %&gt;% lo podemos hacer de una manera mucho más
sencilla

``` r
result3 <-
  cran %>%
  group_by(package) %>%
  summarize(count = n(),
            unique = n_distinct(ip_id),
            countries = n_distinct(country),
            avg_bytes = mean(size)
  ) %>%
  filter(countries > 60) %>%
  arrange(desc(countries), avg_bytes)

# Print result to console
print(result3)
```

    ## # A tibble: 46 × 5
    ##    package      count unique countries avg_bytes
    ##    <chr>        <int>  <int>     <int>     <dbl>
    ##  1 Rcpp          3195   2044        84  2512100.
    ##  2 digest        2210   1894        83   120549.
    ##  3 stringr       2267   1948        82    65277.
    ##  4 plyr          2908   1754        81   799123.
    ##  5 ggplot2       4602   1680        81  2427716.
    ##  6 colorspace    1683   1433        80   357411.
    ##  7 RColorBrewer  1890   1584        79    22764.
    ##  8 scales        1726   1408        77   126819.
    ##  9 bitops        1549   1408        76    28715.
    ## 10 reshape2      2032   1652        76   330128.
    ## # … with 36 more rows

Utilizando pipes sólo hay que ir añadiendo una acción tras otra. Primero
señalar la fuente de datos y en este caso seleccionar las variables que
queremos, la nueva que calculamos, el subset que queremos (qué selección
de filas) y como lo queremos ordenado.

``` r
cran %>%
  select(ip_id, country, package, size) %>%
  mutate(size_mb = size / 2^20) %>%
  filter(size_mb <= 0.5) %>%
  arrange(desc(size_mb))
```

    ## # A tibble: 142,021 × 5
    ##    ip_id country package                 size size_mb
    ##    <int> <chr>   <chr>                  <int>   <dbl>
    ##  1 11034 DE      phia                  524232   0.500
    ##  2  9643 US      tis                   524152   0.500
    ##  3  1542 IN      RcppSMC               524060   0.500
    ##  4 12354 US      lessR                 523916   0.500
    ##  5 12072 US      colorspace            523880   0.500
    ##  6  2514 KR      depmixS4              523863   0.500
    ##  7  1111 US      depmixS4              523858   0.500
    ##  8  8865 CR      depmixS4              523858   0.500
    ##  9  5908 CN      RcmdrPlugin.KMggplot2 523852   0.500
    ## 10 12354 US      RcmdrPlugin.KMggplot2 523852   0.500
    ## # … with 142,011 more rows
