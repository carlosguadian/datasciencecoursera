mapply
================
Carlos Guadián

-   [mapply](#mapply)
-   [Vectorización de una función](#vectorización-de-una-función)

## mapply

Aplica una función en paralalo con diferentes argumentos. En este caso
lo primero que introducimos en mapply es la función.

Imaginemos que queremos una lista con 4 unos, 2 treses, 3 doses y 1 4.
La podemos generar así:

``` r
list(rep(1, 4), rep(2, 3), rep(3, 2), rep(4, 1)) 
```

    ## [[1]]
    ## [1] 1 1 1 1
    ## 
    ## [[2]]
    ## [1] 2 2 2
    ## 
    ## [[3]]
    ## [1] 3 3
    ## 
    ## [[4]]
    ## [1] 4

O utilizando mapply:

``` r
mapply(rep, 1:4, 4:1)
```

    ## [[1]]
    ## [1] 1 1 1 1
    ## 
    ## [[2]]
    ## [1] 2 2 2
    ## 
    ## [[3]]
    ## [1] 3 3
    ## 
    ## [[4]]
    ## [1] 4

## Vectorización de una función

Otro ejemplo. Para la siguiente función que genera una distribución
normal en base al número de números a generar teniendo en cuenta la
media y la desviación estándar.

``` r
noise <- function(n, mean, sd) {
      rnorm(n, mean, sd)
}
## Simulate 5 randon numbers
noise(5, 1, 2)
```

    ## [1] -1.4405743  0.4980882 -1.0616328 -0.0249191  2.0546955

Ahora si pasamos como argumento dos vectores para generar diferentes
sets de números, no funciona correctamente:

``` r
noise(1:5, 1:5, 2)
```

    ## [1]  1.3019487 -0.5252570  1.6914773  0.4677374  5.0258228

Con mapply podemos conseguir 5 sets de números aleatorios con diferente
longitud y media.

``` r
mapply(noise, 1:5, 1:5, 2)
```

    ## [[1]]
    ## [1] -0.6325874
    ## 
    ## [[2]]
    ## [1]  0.941983 -2.357920
    ## 
    ## [[3]]
    ## [1] 5.766202 2.584786 3.445291
    ## 
    ## [[4]]
    ## [1] 2.4209983 4.2659158 4.6407976 0.9229391
    ## 
    ## [[5]]
    ## [1] 1.859317 8.495539 1.763094 4.405316 7.289652

Lo que vendría a ser lo mismo que:

``` r
list(noise(1, 1, 2), noise(2, 2, 2),
+      noise(3, 3, 2), noise(4, 4, 2),
+      noise(5, 5, 2))
```

    ## [[1]]
    ## [1] 0.9374053
    ## 
    ## [[2]]
    ## [1] 0.78027529 0.03129224
    ## 
    ## [[3]]
    ## [1] 3.387707 4.780890 0.334049
    ## 
    ## [[4]]
    ## [1] 3.5504140 0.9588104 3.3728849 2.5480895
    ## 
    ## [[5]]
    ## [1] 1.435491 4.562234 7.527314 5.264447 5.696525
