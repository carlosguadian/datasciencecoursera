Simulación de números aleatorios
================

## funciones para generar números aleatorios

A veces se quiere implementar un procedimiento estadístico que requiere
la generación de números aleatorios o el muestreo (es decir, Markov
chain Monte Carlo, el bootstrap, los bosques aleatorios, el bagging) y a
veces se quiere simular un sistema y los generadores de números
aleatorios pueden utilizarse para modelar entradas aleatorias.

R viene con un conjunto de generadores de números aleatorios que le
permiten simular a partir de distribuciones de probabilidad bien
conocidas como la Normal, Poisson y binomial. Algunos ejemplos de
funciones para distribuciones de probabilidad en R:

-   rnorm: genera variantes aleatorias de la Normal con una media y una
    desviación estándar dadas
-   dnorm: evalúa la densidad de probabilidad Normal (con una media y
    desviación estándar dadas) en un punto (o vector de puntos)
-   pnorm: evalúa la función de distribución acumulativa de una
    distribución Normal
-   rpois: generar variantes aleatorias de Poisson con una tasa
    determinada

Para cada distribución de probabilidad hay normalmente cuatro funciones
disponibles que empiezan por “r”, “d”, “p” y “q”. La función “r” es la
que realmente simula números aleatorios de esa distribución. Las otras
funciones llevan el prefijo:

-   d para la densidad
-   r para la generación de números aleatorios
-   p para la distribución acumulativa
-   q para la función cuantil (distribución acumulativa inversa)

Probablemente la distribución de probabilidad más común para trabajar es
la distribución Normal (también conocida como Gaussiana). Trabajar con
las distribuciones Normales requiere utilizar estas cuatro funciones:

-   dnorm(x, media = 0, sd = 1, log = FALSE)
-   pnorm(q, media = 0, sd = 1, lower.tail = TRUE, log.p = FALSE)
-   qnorm(p, media = 0, sd = 1, cola inferior = TRUE, log.p = FALSE)
-   rnorm(n, media = 0, sd = 1)

## Generando números aleatorios

Vamos a simular números aleatorios con una distribución estándar normal,
con media 0 y desviación estándar de 1.

``` r
x <- rnorm(10)
x
```

    ##  [1] -0.03064019  0.23510448  1.57024144  0.31851538 -0.19508756 -0.26883964
    ##  [7] -0.09362737  0.90515309 -2.07005970  1.13596261

``` r
summary(x)
```

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ## -2.0701 -0.1697  0.1022  0.1507  0.7585  1.5702

Vamos a modificar los parámetros y simular números con una media de 20 y
una desviación estándar de 2.

``` r
x <- rnorm(10, 20, 2)
x
```

    ##  [1] 13.57497 18.54758 19.70324 19.82933 20.02071 22.65565 18.00139 19.11442
    ##  [9] 18.29375 18.56418

``` r
summary(x)
```

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##   13.57   18.36   18.84   18.83   19.80   22.66

## Reproducir números aleatorios

Al simular cualquier número aleatorio es esencial establecer la semilla
de números aleatorios. Establecer la semilla de números aleatorios con
set.seed() asegura la reproducibilidad de la secuencia de números
aleatorios.

Por ejemplo, podemos generar 5 números aleatorios con distribución
normal con rnorm() y marcando el punto de inicio en 1 con set.seed()

``` r
set.seed(1)
rnorm(5)
```

    ## [1] -0.6264538  0.1836433 -0.8356286  1.5952808  0.3295078

Con set.seed nos aseguramos que vamos a poder generar los mismos números
y por lo tanto volver a simular el análisis realizado. Si no lo usamos,
cuando volviéramos a utilizar rnorm() obtendríamos números diferentes.

``` r
rnorm(5)
```

    ## [1] -0.8204684  0.4874291  0.7383247  0.5757814 -0.3053884

``` r
rnorm(5)
```

    ## [1]  1.5117812  0.3898432 -0.6212406 -2.2146999  1.1249309

Pero si volvemos a utilizar set.seed() obtendremos los mismos.

``` r
set.seed(1)
rnorm(5)
```

    ## [1] -0.6264538  0.1836433 -0.8356286  1.5952808  0.3295078

## Poisson Data

Es posible generar números aleatorios a partir de otras distribuciones
de probabilidad como la de Poisson. La distribución de Poisson se
utiliza habitualmente para modelar datos que vienen en forma de
recuentos.

``` r
rpois(10, 1)
```

    ##  [1] 0 0 1 1 2 1 1 4 1 2

``` r
rpois(10, 2)
```

    ##  [1] 4 1 2 0 1 1 0 1 4 1

``` r
rpois(10, 20)
```

    ##  [1] 19 19 24 23 22 24 23 20 11 22
