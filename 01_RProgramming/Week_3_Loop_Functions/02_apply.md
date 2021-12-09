apply
================
Carlos Guadián

-   [apply](#apply)
-   [Sumas y medias de columnas y
    filas](#sumas-y-medias-de-columnas-y-filas)
-   [Otros usos de apply](#otros-usos-de-apply)

## apply

Utilizaremos apply cuando queramos aplicar una función a un array como
una matriz.

Por ejemplo para la siguiente matriz de 20x10 con una distribución
aleatoria de números, vamos a calcular la *media de cada columna*.

``` r
x <- matrix(rnorm(200), 20, 10)
apply(x, 2, mean)
```

    ##  [1]  0.264830284 -0.205079420  0.227073591 -0.013758083  0.024268412
    ##  [6] -0.044801514  0.008555452 -0.328524110  0.035451815  0.294153618

Si lo que queremos es la *media de cada fila*.

``` r
apply(x, 1, mean)
```

    ##  [1]  0.295246671 -0.387461360 -0.303082095  0.365799627  0.359311510
    ##  [6] -0.087291007  0.175214538 -0.313441563 -0.021901462 -0.073488026
    ## [11]  0.699786149 -0.207259336  0.008659798  0.278509000 -0.116035538
    ## [16] -0.219188721 -0.268044198  0.247965531 -0.005238151  0.096278723

Por lo tanto los *argumentos* que utilizaremos en apply son:

``` r
str(apply)
```

    ## function (X, MARGIN, FUN, ..., simplify = TRUE)

-   Una array, por ejemplo la matriz sobre la que queremos ejecutar la
    función
-   El margen, que como hemos visto en el caso de la matriz indica si la
    función se ejecuta sobre las columnas (2), o sobre las filas (1).
-   La función a ejecutar.
-   … Argumentos a utilizar en la función

## Sumas y medias de columnas y filas

Para los casos específicos de sumas y medias de filas y columnas existen
los siguientes shortcuts mucho más optimizados, y por lo tanto, mucho
más rápidos:

-   rowSums = apply(x, 1, sum)
-   rowMeans = apply(x, 1, mean)
-   colSums = apply(x, 2, sum)
-   colMeans = apply(x, 2, mean)

## Otros usos de apply

Puede hacer más que tomar sumas y medias con la función apply().

Por ejemplo, puede calcular los cuantiles de las filas de una matriz
utilizando la función quantile().

``` r
x <- matrix(rnorm(200), 20, 10)
## Obtener los cuantiles de las filas
apply(x, 1, quantile, probs = c(0.25, 0.75)) 
```

    ##           [,1]       [,2]       [,3]       [,4]       [,5]       [,6]
    ## 25% -1.2570670 -0.8278277 -0.4411724 -1.2172721 -0.3650528 -0.2914602
    ## 75%  0.1474904 -0.1122547  1.1518899  0.2334792  0.3488452  0.1915090
    ##           [,7]       [,8]       [,9]      [,10]      [,11]      [,12]
    ## 25% -0.8185338 -0.6246398 -0.4475513 -1.2008931 -0.4546084 -0.4063080
    ## 75%  0.7351028  0.2473850  0.7015041  0.5786196  0.3409878  0.9944484
    ##          [,13]      [,14]       [,15]       [,16]      [,17]      [,18]
    ## 25% -0.8489764 -0.4867341 -0.98356431 -0.04786421 -0.2910886 -0.8582804
    ## 75%  1.0042819  0.6609365  0.09210597  0.65654929  1.0909898  0.3726174
    ##          [,19]        [,20]
    ## 25% -0.2078965 -0.006215202
    ## 75%  0.8465103  0.818560452

O realizar cálculos con estructuras más complicadas. Por ejemplo, con
una array que son 10 matrices de 2x2 como la siguiente:

``` r
a <- array(rnorm(2 * 2 * 10), c(2, 2, 10))
```

Podemos calcular la media de las matrices llamando en el margen a filas
y columnas.

``` r
apply(a, c(1, 2), mean)
```

    ##            [,1]         [,2]
    ## [1,] -0.1629366 -0.149827622
    ## [2,]  0.3634089 -0.004808462

``` r
# Vendría a ser lo mismo si utilizamos
rowMeans(a, dims = 2) 
```

    ##            [,1]         [,2]
    ## [1,] -0.1629366 -0.149827622
    ## [2,]  0.3634089 -0.004808462
