mapply
================
Carlos Guadián

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

    ## [1] -0.6574119 -0.1891392 -0.4544522  0.4807420  3.1029892

Ahora si pasamos como argumento dos vectores para generar diferentes
sets de números, no funciona correctamente:

``` r
noise(1:5, 1:5, 2)
```

    ## [1] -0.009854623  4.994963915  1.349268504  2.930382726  2.015622461

Con mapply podemos conseguir 5 sets de números aleatorios con diferente
longitud y media.

``` r
mapply(noise, 1:5, 1:5, 2)
```

    ## [[1]]
    ## [1] 3.067704
    ## 
    ## [[2]]
    ## [1] -0.07980842  4.49544698
    ## 
    ## [[3]]
    ## [1] 3.650693 3.132120 3.361452
    ## 
    ## [[4]]
    ## [1] 5.041321 1.975129 7.878148 1.186474
    ## 
    ## [[5]]
    ## [1] 2.925916 5.416812 2.520647 7.759544 6.154238

Lo que vendría a ser lo mismo que:

``` r
list(noise(1, 1, 2), noise(2, 2, 2),
+      noise(3, 3, 2), noise(4, 4, 2),
+      noise(5, 5, 2))
```

    ## [[1]]
    ## [1] -1.87174
    ## 
    ## [[2]]
    ## [1] 0.2737583 2.0294766
    ## 
    ## [[3]]
    ## [1] 3.294211 2.448161 5.300386
    ## 
    ## [[4]]
    ## [1] 2.490071 2.995841 3.788777 4.761762
    ## 
    ## [[5]]
    ## [1] 3.939941 2.912435 4.581517 4.981568 5.631014
