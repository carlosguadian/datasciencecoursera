lapply & sapply
================
Carlos Guadián

## Sustitutos de for, while, loops en línea de comandos

-   lapply(): Loop over a list and evaluate a function on each element
-   sapply(): Same as lapply but try to simplify the result
-   apply(): Apply a function over the margins of an array
-   tapply(): Apply a function over subsets of a vector
-   mapply(): Multivariate version of lapply”

## lapply

Esta función toma tres argumentos:

-   una lista X;
-   una función (o el nombre de una función) FUN;
-   otros argumentos a través de su argumento ….

Si X no es una lista, se convertirá en una lista utilizando as.list().

El cuerpo de la función lapply() puede verse aquí

``` r
lapply
```

    ## function (X, FUN, ...) 
    ## {
    ##     FUN <- match.fun(FUN)
    ##     if (!is.vector(X) || is.object(X)) 
    ##         X <- as.list(X)
    ##     .Internal(lapply(X, FUN))
    ## }
    ## <bytecode: 0x7f897a0359a0>
    ## <environment: namespace:base>

Una aplicación sencilla sería la siguiente. Calcular la media de todos
los elementos de una lista.

``` r
x <- list(a = 1:5, b = rnorm(10))
lapply(x, mean)
```

    ## $a
    ## [1] 3
    ## 
    ## $b
    ## [1] 0.102922

Otro ejemplo un poco más complicado también calculando la media de cada
elemento.

``` r
x <- list(a = 1:4, b = rnorm(10), c = rnorm(20, 1), d = rnorm(100, 5))
lapply(x, mean) 
```

    ## $a
    ## [1] 2.5
    ## 
    ## $b
    ## [1] 0.6270748
    ## 
    ## $c
    ## [1] 0.9552119
    ## 
    ## $d
    ## [1] 4.957464

Por lo tanto, se puede pasar a cada elemento de la lista una función. En
el siguiente ejemplo cada elemento de “x” es un argumento para runif
para generar un número aleatorio. Con 1, genera 1 ,con 2, dos…

``` r
x <- 1:4
lapply(x, runif) 
```

    ## [[1]]
    ## [1] 0.1157007
    ## 
    ## [[2]]
    ## [1] 0.8372790 0.8562957
    ## 
    ## [[3]]
    ## [1] 0.3667140 0.6691551 0.5840182
    ## 
    ## [[4]]
    ## [1] 0.80953989 0.68955359 0.15616158 0.02227876

También se puede definir una función fantasma, es decir, que no tiene
nombre dentro de lapply.

En el siguiente caso de una lista de dos matrices, extraemos el primer
elemento de cada una.

``` r
x <- list(a = matrix(1:4, 2, 2), b = matrix(1:6, 3, 2))
lapply(x, function(elt) { elt[,1] }) 
```

    ## $a
    ## [1] 1 2
    ## 
    ## $b
    ## [1] 1 2 3

Aunque si la función es complicada siempre se puede definir fuera y
llamarla en lapply.

``` r
f <- function(elt) {
       elt[, 1]
}
lapply(x, f)
```

    ## $a
    ## [1] 1 2
    ## 
    ## $b
    ## [1] 1 2 3

## sapply

-   Si el resultado es una lista donde cada elemento es de longitud 1,
    se devuelve un vector
-   Si el resultado es una lista donde cada elemento es un vector de la
    misma longitud (&gt; 1), se devuelve una matriz.
-   Si no se puede resolver, se devuelve una lista

Veamos la diferencia de aplicar lapply y sapply.

Si aplicamos lapply a la siguiente lista, obtendremos una lista.

``` r
x <- list(a = 1:4, b = rnorm(10), c = rnorm(20, 1), d = rnorm(100, 5))
lapply(x, mean)
```

    ## $a
    ## [1] 2.5
    ## 
    ## $b
    ## [1] 0.1412604
    ## 
    ## $c
    ## [1] 0.743454
    ## 
    ## $d
    ## [1] 5.04913

Pero si aplicamos sapply obtenemos un vector.

``` r
x <- list(a = 1:4, b = rnorm(10), c = rnorm(20, 1), d = rnorm(100, 5))
sapply(x, mean)
```

    ##         a         b         c         d 
    ## 2.5000000 0.4157798 0.6939231 4.9970558
