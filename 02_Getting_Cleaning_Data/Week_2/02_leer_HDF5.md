Leer HDF5
================

-   [HDF5](#hdf5)
-   [El paquete HDF5](#el-paquete-hdf5)

## HDF5

HDF5 es un modelo de datos, una biblioteca y un formato de archivo para
almacenar y gestionar datos. Admite una variedad ilimitada de tipos de
datos y está diseñado para una E/S flexible y eficiente y para datos
complejos y de gran volumen. HDF5 es portátil y extensible, lo que
permite que las aplicaciones evolucionen en su uso. La suite tecnológica
HDF5 incluye herramientas y aplicaciones para gestionar, manipular,
visualizar y analizar datos en formato HDF5.

## El paquete HDF5

Hay varios paquetes, utilizaremos rhdf5, para su instalación
utilizaremos el instalador de bioconductor.org

``` r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("rhdf5")
```

    ## Bioconductor version 3.13 (BiocManager 1.30.16), R 4.1.1 (2021-08-10)

    ## Warning: package(s) not installed when version(s) same as current; use `force = TRUE` to
    ##   re-install: 'rhdf5'

    ## Old packages: 'arrow', 'backports', 'brio', 'cpp11', 'digest', 'dtplyr', 'fs',
    ##   'glue', 'graphlayouts', 'hdf5r', 'igraph', 'irlba', 'memoise', 'pkgload',
    ##   'RcppArmadillo', 'readr', 'remotes', 'RSQLite', 'sessioninfo', 'slam', 'sp',
    ##   'stringi', 'testthat', 'tibble', 'udpipe', 'vitae', 'vroom', 'withr', 'xml2'

Cargamos el paquete y creamos un archivo tipo h5

``` r
library(rhdf5)
created = h5createFile("example.h5")
```

    ## file '/Users/carlosguadian/datasciencecoursera/02_Getting_Cleaning_Data/Week_2/example.h5' already exists.

``` r
created
```

    ## [1] FALSE

Vamos a crear unos grupos

``` r
created = h5createGroup("example.h5", "foo")
```

    ## Can not create group. Object with name 'foo' already exists.

``` r
created = h5createGroup("example.h5", "baa")
```

    ## Can not create group. Object with name 'baa' already exists.

``` r
created = h5createGroup("example.h5", "foo/foobaa")
```

    ## Can not create group. Object with name 'foo/foobaa' already exists.

``` r
h5ls("example.h5")
```

    ##         group   name       otype   dclass       dim
    ## 0           /    baa   H5I_GROUP                   
    ## 1           /     df H5I_DATASET COMPOUND         5
    ## 2           /    foo   H5I_GROUP                   
    ## 3        /foo      A H5I_DATASET  INTEGER     5 x 2
    ## 4        /foo foobaa   H5I_GROUP                   
    ## 5 /foo/foobaa      B H5I_DATASET    FLOAT 5 x 2 x 2

Escribiendo en los grupos

``` r
A = matrix(1:10, nr = 5, nc = 2)
h5write(A, "example.h5", "foo/A")
B = array(seq(0.1, 2.0, by = 0.1), dim = c(5,2,2))
attr(B, "scale") <- "liter"
h5write(B, "example.h5", "foo/foobaa/B")
h5ls("example.h5")
```

    ##         group   name       otype   dclass       dim
    ## 0           /    baa   H5I_GROUP                   
    ## 1           /     df H5I_DATASET COMPOUND         5
    ## 2           /    foo   H5I_GROUP                   
    ## 3        /foo      A H5I_DATASET  INTEGER     5 x 2
    ## 4        /foo foobaa   H5I_GROUP                   
    ## 5 /foo/foobaa      B H5I_DATASET    FLOAT 5 x 2 x 2

Escribir un dataset

``` r
df <- data.frame(1L:5L, seq(0,1, length.out = 5), c("ab", "cde", "fghi", "a", "s"), stringsAsFactors = FALSE)
h5write(df, "example.h5", "df")
h5ls("example.h5")
```

Leer datos de hdf5

``` r
readA <- h5read("example.h5", "foo/A")
readA
```

    ##      [,1] [,2]
    ## [1,]    1    6
    ## [2,]    2    7
    ## [3,]    3    8
    ## [4,]    4    9
    ## [5,]    5   10

``` r
readB <- h5read("example.h5", "foo/foobaa/B")
readB
```

    ## , , 1
    ## 
    ##      [,1] [,2]
    ## [1,]  0.1  0.6
    ## [2,]  0.2  0.7
    ## [3,]  0.3  0.8
    ## [4,]  0.4  0.9
    ## [5,]  0.5  1.0
    ## 
    ## , , 2
    ## 
    ##      [,1] [,2]
    ## [1,]  1.1  1.6
    ## [2,]  1.2  1.7
    ## [3,]  1.3  1.8
    ## [4,]  1.4  1.9
    ## [5,]  1.5  2.0

``` r
readdf <- h5read("example.h5", "df")
readdf
```

    ##   X1L.5L seq.0..1..length.out...5. c..ab....cde....fghi....a....s..
    ## 1      1                      0.00                               ab
    ## 2      2                      0.25                              cde
    ## 3      3                      0.50                             fghi
    ## 4      4                      0.75                                a
    ## 5      5                      1.00                                s

Escribir y leer chunks

``` r
h5write(c(12, 13, 14), "example.h5", "foo/A", index = list(1:3, 1))
h5read("example.h5", "foo/A")
```

    ##      [,1] [,2]
    ## [1,]   12    6
    ## [2,]   13    7
    ## [3,]   14    8
    ## [4,]    4    9
    ## [5,]    5   10
