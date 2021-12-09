tapply
================
Carlos Guadián

-   [tapply](#tapply)

## tapply

Se utiliza para aplicar una función sobre subconjuntos de un vector.
Puede considerarse como una combinación de split() y sapply() sólo para
vectores.

Por lo tanto, para usar tapply tendremos los siguientes argumentos:

``` r
str(tapply)
```

    ## function (X, INDEX, FUN = NULL, ..., default = NA, simplify = TRUE)

-   X es un vector
-   INDEX es un factor o lista de factores.
-   FUN es la función
-   … argumentos para la función
-   simplify si queremos un resultado simplificado

Vamos a generar un vector con diferentes factores.

``` r
x <- c(rnorm(10), runif(10), rnorm(10, 1))
f <- gl(3, 10)
```

Y ahora vamos a calcular la media de cada grupo de x.

``` r
tapply(x, f, mean)
```

    ##           1           2           3 
    ## -0.01591843  0.46781326  0.66678346

Si obligamos a no simplificar el resultado tenemos una lista.

``` r
tapply(x, f, mean, simplify = FALSE)
```

    ## $`1`
    ## [1] -0.01591843
    ## 
    ## $`2`
    ## [1] 0.4678133
    ## 
    ## $`3`
    ## [1] 0.6667835
