Random Sampling
================
Carlos Guadián

-   [Sample Function](#sample-function)
-   [Muestras aleatorias de dataframes o
    listas](#muestras-aleatorias-de-dataframes-o-listas)

## Sample Function

La función sample() extrae aleatoriamente de un conjunto especificado de
objetos (escalares) permitiendo muestrear de distribuciones arbitrarias
de números.

Por ejemplo, podemos generar un vector aleatorio de 4 números de un
intervalo de 10.

``` r
set.seed(1)
sample(1:10, 4)
```

    ## [1] 9 4 7 1

No necesariamente se tiene que utilizar con números. En este caso
indicamos que queremos 5 letras aleatorias.

``` r
sample(letters, 5)
```

    ## [1] "b" "w" "k" "n" "r"

En el caso que no indiquemos el número que queremos aleatorio, lo que
conseguimos es una permutación aleatoria del rango indicado.

``` r
sample(1:10)
```

    ##  [1]  3  1  5  8  2  6 10  9  4  7

``` r
sample(1:10)
```

    ##  [1]  5  9  1  6 10  7  2  4  3  8

Si queremos que en la permuta del rango haya reemplazo, es decir, que se
repitan algunos números lo debemos indicar.

``` r
sample(1:10, replace = TRUE)
```

    ##  [1]  1  4  3  6 10 10  6  4  4 10

## Muestras aleatorias de dataframes o listas

No solo se pueden generar muestras aleatorias de vectores, también
podemos generarlas de un dataframe, por ejemplo, una muestra aleatoria
de filas.

``` r
library(datasets)
data("airquality")
set.seed(20)
idx <- seq_len(nrow(airquality)) # generamos un vector índice de las filas
samp <- sample(idx, 6) # utilizamos el índice para generar la muestra
airquality[samp, ]
```

    ##     Ozone Solar.R Wind Temp Month Day
    ## 107    NA      64 11.5   79     8  15
    ## 120    76     203  9.7   97     8  28
    ## 130    20     252 10.9   80     9   7
    ## 98     66      NA  4.6   87     8   6
    ## 29     45     252 14.9   81     5  29
    ## 45     NA     332 13.8   80     6  14
