apply
================
Carlos Guadián

## apply

Utilizaremos apply cuando queramos aplicar una función a un array como
una matriz.

Por ejemplo para la siguiente matriz de 20x10 con una distribución
aleatoria de números, vamos a calcular la *media de cada columna*.

``` r
x <- matrix(rnorm(200), 20, 10)
apply(x, 2, mean)
```

    ##  [1] -0.18833657  0.37361052 -0.28422459 -0.11683350 -0.38641027 -0.03978348
    ##  [7] -0.62565503 -0.15106305 -0.11915459 -0.25909239

Si lo que queremos es la *media de cada fila*.

``` r
apply(x, 1, mean)
```

    ##  [1] -0.4039401 -0.7114147 -0.2822361 -0.1163850  0.1307686  0.1181964
    ##  [7]  0.5216724  0.3148554 -0.7999079 -0.1962235 -0.3521674  0.2450374
    ## [13] -0.2220768  0.2815990 -0.4325052 -0.6150548 -0.5319912 -0.1301714
    ## [19]  0.3077863 -0.7197274

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

    ##           [,1]        [,2]       [,3]       [,4]       [,5]       [,6]
    ## 25% -0.2372455 -0.04635163 -0.2852042 -1.0316699 -0.4941235 -1.1528680
    ## 75%  0.4774907  0.14566948  0.3827987  0.3126199  0.3121191  0.5255752
    ##            [,7]       [,8]       [,9]      [,10]      [,11]      [,12]
    ## 25% -1.02206091 -0.8278978 -0.8939412 -0.7293638 -0.7451839 -0.7628246
    ## 75%  0.09657191 -0.1438086  0.9338916  0.3556450  0.7290125  0.5983523
    ##          [,13]      [,14]      [,15]      [,16]      [,17]      [,18]
    ## 25% -0.7035738 -0.9964428 -0.4146579 -0.6123519 -0.8824908 -0.7348756
    ## 75%  0.1099650  1.4842638  0.7990383  0.3520027  0.1406075  0.4726230
    ##          [,19]      [,20]
    ## 25% -0.5005729 -0.3829377
    ## 75%  0.4603428  0.7898646

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

    ##            [,1]      [,2]
    ## [1,]  0.1945607 0.1281529
    ## [2,] -0.2549827 0.3721448

``` r
# Vendría a ser lo mismo si utilizamos
rowMeans(a, dims = 2) 
```

    ##            [,1]      [,2]
    ## [1,]  0.1945607 0.1281529
    ## [2,] -0.2549827 0.3721448
