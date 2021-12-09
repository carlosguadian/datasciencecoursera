split
================
Carlos Guadián

-   [split](#split)
-   [Splitting un Data Frame](#splitting-un-data-frame)
-   [Dividiendo en más de un nivel](#dividiendo-en-más-de-un-nivel)

## split

La función split() toma un vector u otros objetos y los divide en grupos
determinados por un factor o lista de factores.

Los argumentos de split() son

``` r
str(split)
```

    ## function (x, f, drop = FALSE, ...)

Donde:

-   x es un vector (o lista) o marco de datos
-   f es un factor (o coaccionado a uno) o una lista de factores
-   drop indica si los niveles de los factores vacíos deben ser
    descartados

La combinación de split() y una función como lapply() o sapply() es un
paradigma común en R.

La idea básica es que se puede tomar una estructura de datos, dividirla
en subconjuntos definidos por otra variable, y aplicar una función sobre
esos subconjuntos. Los resultados de la aplicación de la función sobre
los subconjuntos se cotejan y se devuelven como un objeto. Esta
secuencia de operaciones se denomina a veces “map-reduce” en otros
contextos.

Generamos, como en tapply un vector con diferentes factores:

``` r
x <- c(rnorm(10), runif(10), rnorm(10, 1))
f <- gl(3, 10)
```

Y procedemos a dividirlo por cada uno de ellos:

``` r
split(x, f)
```

    ## $`1`
    ##  [1]  0.9120373 -0.7953606  0.1659478  0.2709763 -2.4307901 -0.8371195
    ##  [7]  0.8136823 -0.8679216 -1.3583392  0.5558807
    ## 
    ## $`2`
    ##  [1] 0.32828388 0.02996490 0.38426598 0.55637211 0.11888339 0.01635115
    ##  [7] 0.24265582 0.74126901 0.25493172 0.32482759
    ## 
    ## $`3`
    ##  [1]  1.0546537  1.5297842 -0.1247892  0.2530700 -0.1958915  0.6987131
    ##  [7]  0.4109511  0.9309217  0.2777163  1.2220156

Ahora si queremos aplicar a cada uno de esos grupos algún cálculo
deberíamos utilizar lapply() o sapply(). Es algo bastante común
utilizarlas conjuntamente con split().

``` r
lapply(split(x, f), mean)
```

    ## $`1`
    ## [1] -0.3571007
    ## 
    ## $`2`
    ## [1] 0.2997806
    ## 
    ## $`3`
    ## [1] 0.6057145

Obtenemos el mismo resultado con tapply()

``` r
tapply(x, f, mean, simplify = FALSE)
```

    ## $`1`
    ## [1] -0.3571007
    ## 
    ## $`2`
    ## [1] 0.2997806
    ## 
    ## $`3`
    ## [1] 0.6057145

## Splitting un Data Frame

split() se puede utilizar para dividir objetos más complicados como un
data frame.

Vamos a cargar airquality para hacer unas pruebas.

``` r
library(datasets)
head(airquality)
```

    ##   Ozone Solar.R Wind Temp Month Day
    ## 1    41     190  7.4   67     5   1
    ## 2    36     118  8.0   72     5   2
    ## 3    12     149 12.6   74     5   3
    ## 4    18     313 11.5   62     5   4
    ## 5    NA      NA 14.3   56     5   5
    ## 6    28      NA 14.9   66     5   6

Primero vamos a dividirlo en meses. Obtenemos 5 dataframes, uno por mes.

``` r
s <- split(airquality, airquality$Month)
```

Ahora podemos calcular la medias por columna de Ozone, Solar.R y Wind de
cada dataframe.

``` r
lapply(s, function(x) {
      colMeans(x[, c("Ozone", "Solar.R", "Wind")])
}) 
```

    ## $`5`
    ##    Ozone  Solar.R     Wind 
    ##       NA       NA 11.62258 
    ## 
    ## $`6`
    ##     Ozone   Solar.R      Wind 
    ##        NA 190.16667  10.26667 
    ## 
    ## $`7`
    ##      Ozone    Solar.R       Wind 
    ##         NA 216.483871   8.941935 
    ## 
    ## $`8`
    ##    Ozone  Solar.R     Wind 
    ##       NA       NA 8.793548 
    ## 
    ## $`9`
    ##    Ozone  Solar.R     Wind 
    ##       NA 167.4333  10.1800

Aunque para una lectura más simplificada podemos utilizar sapply() y ya
podemos forzar también dejar fuera los NA

``` r
sapply(s, function(x) {
        colMeans(x[, c("Ozone", "Solar.R", "Wind")], 
                 na.rm = TRUE)
})
```

    ##                 5         6          7          8         9
    ## Ozone    23.61538  29.44444  59.115385  59.961538  31.44828
    ## Solar.R 181.29630 190.16667 216.483871 171.857143 167.43333
    ## Wind     11.62258  10.26667   8.941935   8.793548  10.18000

## Dividiendo en más de un nivel

Puede que queramos dividir un objeto de acuerdo a los niveles definidos
en más de una variable. Esto lo podemos hacer con interaction()

``` r
x <- rnorm(10)
f1 <- gl(2, 5)
f2 <- gl(5, 2)
f1
```

    ##  [1] 1 1 1 1 1 2 2 2 2 2
    ## Levels: 1 2

``` r
f2
```

    ##  [1] 1 1 2 2 3 3 4 4 5 5
    ## Levels: 1 2 3 4 5

``` r
## Create interaction of two factors
interaction(f1, f2)
```

    ##  [1] 1.1 1.1 1.2 1.2 1.3 2.3 2.4 2.4 2.5 2.5
    ## Levels: 1.1 2.1 1.2 2.2 1.3 2.3 1.4 2.4 1.5 2.5

Con múltiples factores y muchos niveles, la creación de una interacción
puede dar lugar a niveles vacíos.

``` r
str(split(x, list(f1, f2)))
```

    ## List of 10
    ##  $ 1.1: num [1:2] 0.837 -0.486
    ##  $ 2.1: num(0) 
    ##  $ 1.2: num [1:2] 0.909 -0.145
    ##  $ 2.2: num(0) 
    ##  $ 1.3: num 1.62
    ##  $ 2.3: num 0.0211
    ##  $ 1.4: num(0) 
    ##  $ 2.4: num [1:2] -0.953 0.801
    ##  $ 1.5: num(0) 
    ##  $ 2.5: num [1:2] -0.2282 -0.0527

Podemos evitar estos niveles vacíos con DROP

``` r
str(split(x, list(f1, f2), drop = TRUE))
```

    ## List of 6
    ##  $ 1.1: num [1:2] 0.837 -0.486
    ##  $ 1.2: num [1:2] 0.909 -0.145
    ##  $ 1.3: num 1.62
    ##  $ 2.3: num 0.0211
    ##  $ 2.4: num [1:2] -0.953 0.801
    ##  $ 2.5: num [1:2] -0.2282 -0.0527
