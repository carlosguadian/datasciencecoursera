Segmentar y ordenar
================
Carlos Guadián

## Segmentar

Para empezar vamos a generar un dataframe con tres variables y algunos
valores perdidos.

``` r
set.seed(13435)
X <- data.frame("var1" = sample(1:5), "var2" = sample(6:10), "var3" = sample(11:15))
X <- X[sample(1:5), ]
X$var2[c(1,3)] = NA
X
```

    ##   var1 var2 var3
    ## 5    2   NA   11
    ## 4    4   10   12
    ## 1    3   NA   14
    ## 2    1    7   15
    ## 3    5    6   13

Vamos a segmentar columnas, ya sea por el índice o por el nombre de la
variable

``` r
X[, 1]
```

    ## [1] 2 4 3 1 5

``` r
X[, "var1"]
```

    ## [1] 2 4 3 1 5

Podemos también segmentar una variable / columna especificando los
registros que queremos indicando un intervalo.

``` r
X[1:2, "var2"]
```

    ## [1] NA 10

También se puede segmentar utilizando **operadores lógicos**.

Por ejemplo podemos seleccionar aquellos valores del dataframe que sean
menores o iguales a 3 en var1 y mayores a 11.

``` r
X[(X$var1 <= 3 & X$var3 > 11), ]
```

    ##   var1 var2 var3
    ## 1    3   NA   14
    ## 2    1    7   15

En este caso no utilizamos un “Y” se usa un “O”, por lo que obtendremos
todos los registros que cumplan una u otra condición.

``` r
X[(X$var1 <= 3 | X$var3 > 11), ]
```

    ##   var1 var2 var3
    ## 5    2   NA   11
    ## 4    4   10   12
    ## 1    3   NA   14
    ## 2    1    7   15
    ## 3    5    6   13

Podemos utilizar el operador “which” para evitar los NA. Por ejemplo le
podemos pedir los mayores de 5 en var2, pero no nos devolverá los NA.

``` r
X[which(X$var2 > 5), ]
```

    ##   var1 var2 var3
    ## 4    4   10   12
    ## 2    1    7   15
    ## 3    5    6   13

## Ordenar

Podemos ordenar por una variable

``` r
sort(X$var1)
```

    ## [1] 1 2 3 4 5

Hacerlo en orden inverso.

``` r
sort(X$var1, decreasing = TRUE)
```

    ## [1] 5 4 3 2 1

O incluso indicando que queremos los NA al final.

``` r
sort(X$var2, na.last = TRUE)
```

    ## [1]  6  7 10 NA NA

También se puede ordenar el dataframe en base a una variable.

``` r
X[order(X$var1), ]
```

    ##   var1 var2 var3
    ## 2    1    7   15
    ## 5    2   NA   11
    ## 1    3   NA   14
    ## 4    4   10   12
    ## 3    5    6   13

Por supuesto se puede ordenar por más de una variable.

``` r
X[order(X$var1, X$var3), ]
```

    ##   var1 var2 var3
    ## 2    1    7   15
    ## 5    2   NA   11
    ## 1    3   NA   14
    ## 4    4   10   12
    ## 3    5    6   13

Para este tipo de operaciones se puede utilizar el paquete plyr()

``` r
library(plyr)
arrange(X, var1)
```

    ##   var1 var2 var3
    ## 1    1    7   15
    ## 2    2   NA   11
    ## 3    3   NA   14
    ## 4    4   10   12
    ## 5    5    6   13

Es bastante intuitivo, por ejemplo para ordenar en sentido descendente.

``` r
arrange(X, desc(var1))
```

    ##   var1 var2 var3
    ## 1    5    6   13
    ## 2    4   10   12
    ## 3    3   NA   14
    ## 4    2   NA   11
    ## 5    1    7   15

## Añadir filas y columnas

Si nos hiciera falta añadir una nueva columna (variable) podemos
añadirla definiendola a su valor. Por ejemplo, para añadir var4 a X lo
hacemos de la siguiente manera.

``` r
X$var4 <- rnorm(5)
X
```

    ##   var1 var2 var3       var4
    ## 5    2   NA   11 -0.4150458
    ## 4    4   10   12  2.5437602
    ## 1    3   NA   14  1.5545298
    ## 2    1    7   15 -0.6192328
    ## 3    5    6   13 -0.9261035

Otra manera de hacerlo es con cbind(), en este caso definimos var5 y con
cbind() lo añade a la derecha de X, ya que lo hemos puesto en ese orden.

``` r
var5 <- rnorm(5)
X <- cbind(X, var5)
X
```

    ##   var1 var2 var3       var4        var5
    ## 5    2   NA   11 -0.4150458 -0.66549949
    ## 4    4   10   12  2.5437602 -0.02166735
    ## 1    3   NA   14  1.5545298 -0.17411953
    ## 2    1    7   15 -0.6192328  0.23900438
    ## 3    5    6   13 -0.9261035 -1.83245959

Si quisieramos añadir una nueva variable a la izquierda del dataframe
solo tenemos que invertir el orden.

``` r
var6 <- rnorm(5)
X <- cbind(var6, X)
X
```

    ##          var6 var1 var2 var3       var4        var5
    ## 5 -0.03718739    2   NA   11 -0.4150458 -0.66549949
    ## 4 -0.44051699    4   10   12  2.5437602 -0.02166735
    ## 1 -1.44826359    3   NA   14  1.5545298 -0.17411953
    ## 2 -0.51824571    1    7   15 -0.6192328  0.23900438
    ## 3  0.75852718    5    6   13 -0.9261035 -1.83245959

Para añdir filas utilizamos rbind() de la misma manera. Si queremos
añadir una fila al principio.

``` r
r6 <- rnorm(6)
X <- rbind(r6, X)
X
```

    ##           var6     var1       var2       var3       var4        var5
    ## 1   0.28493532 -1.53784 -0.3652188 -0.4338298 -1.5774835 -1.34954882
    ## 5  -0.03718739  2.00000         NA 11.0000000 -0.4150458 -0.66549949
    ## 4  -0.44051699  4.00000 10.0000000 12.0000000  2.5437602 -0.02166735
    ## 11 -1.44826359  3.00000         NA 14.0000000  1.5545298 -0.17411953
    ## 2  -0.51824571  1.00000  7.0000000 15.0000000 -0.6192328  0.23900438
    ## 3   0.75852718  5.00000  6.0000000 13.0000000 -0.9261035 -1.83245959

Y si la queremos añadir al final

``` r
r7 <- rnorm(6)
X <- rbind(X, r7)
X
```

    ##           var6      var1        var2       var3       var4        var5
    ## 1   0.28493532 -1.537840 -0.36521877 -0.4338298 -1.5774835 -1.34954882
    ## 5  -0.03718739  2.000000          NA 11.0000000 -0.4150458 -0.66549949
    ## 4  -0.44051699  4.000000 10.00000000 12.0000000  2.5437602 -0.02166735
    ## 11 -1.44826359  3.000000          NA 14.0000000  1.5545298 -0.17411953
    ## 2  -0.51824571  1.000000  7.00000000 15.0000000 -0.6192328  0.23900438
    ## 3   0.75852718  5.000000  6.00000000 13.0000000 -0.9261035 -1.83245959
    ## 7  -0.38264785  1.635504  0.06177527 -0.5575033 -0.3659362  0.74585195

Más info en
<https://www.biostat.jhsph.edu/~ajaffe/lec_winterR/Lecture%202.pdf>
