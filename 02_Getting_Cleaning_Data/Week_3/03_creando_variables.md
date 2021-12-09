Creando nuevas variables
================
Carlos Guadián

-   [Porqué crear nuevas variables?](#porqué-crear-nuevas-variables)
-   [Creando secuencias](#creando-secuencias)
-   [Segmentando variables](#segmentando-variables)
-   [Creando variables binarias](#creando-variables-binarias)
-   [Creando variables categóricas](#creando-variables-categóricas)
-   [Creando factores](#creando-factores)
-   [Transformaciones más comunes](#transformaciones-más-comunes)

## Porqué crear nuevas variables?

-   En la mayoría de ocasiones los datos originales no tienen el
    indicador que estamos buscando.
-   Por lo que habitualmente tendremos que transformar los datos de los
    que disponemos para obtener los valores deseados.
-   Normalmente añadiremos estos nuevos indicadores al dataframe con el
    que estemos trabajando.
-   Variables más comunes para crear:
    -   Indicadores perdidos
    -   Variables cuantitativas
    -   Aplicando transformaciones

Vamos a volver a utilizar el dataset de los restaurantes de Baltimore,
como en la anterior unidad.

``` r
restData <- read.csv("./data/Restaurants.csv")
library(tibble)
restData <- as_tibble(restData)
```

## Creando secuencias

A veces necesitamos un índice para el dataset. Vamos a crear uno. Veamos
tres maneras de crearlo con seq()

``` r
s1 <- seq(1, 10, by =2)
s1
```

    ## [1] 1 3 5 7 9

``` r
s2 <- seq(1, 10, length = 3)
s2
```

    ## [1]  1.0  5.5 10.0

``` r
x <- c(1, 3, 8, 25, 100)
seq(along = x)
```

    ## [1] 1 2 3 4 5

## Segmentando variables

Podemos crear una nueva variable segmentando una existente. Por ejemplo,
creamos “nearMe” para los restaurantes que coincidan con “Roland Park” o
“Homeland”. La nueva variable contendrá TRUE o FALSE dependiendo si
cumple la condición.

``` r
restData$nearMe <- restData$nghbrhd %in% c("Roland Park", "Homeland")
table(restData$nearMe)
```

    ## 
    ## FALSE  TRUE 
    ##  1314    13

## Creando variables binarias

Podemos comprobar si el zipcode es correcto asignandolo a una nueva
variable, en este caso todos son correctos.

Utilizamos ifelse() para decirle que si es mayor de 0, entonces es TRUE,
sinó FALSE.

``` r
restData$zipWrong <- ifelse(as.numeric(restData$zipcode) < 0, TRUE, FALSE)
table(restData$zipWrong, restData$zipcode < 0)
```

    ##        
    ##         FALSE
    ##   FALSE  1326

## Creando variables categóricas

Puede que necesitemos crear una variable categórica en base a una
cuantitativa. En este caso vamos a utilizar zipcode, que lo trataremos
como “numérico” para poder generar la variable categórica en base a sus
cuantiles.

``` r
restData$zipGroups <- cut(as.numeric(restData$zipcode), breaks = quantile(as.numeric(restData$zipcode), na.rm = TRUE))
table(restData$zipGroups)
```

    ## 
    ## (21201,21202] (21202,21218] (21218,21226] (21226,21287] 
    ##           201           375           282           332

Así la podemos utilizar para ver cuantos restaurantes hay por cada grupo
y por su código postal.

``` r
table(restData$zipGroups, restData$zipcode)
```

    ##                
    ##                 21201 21202 21205 21206 21207 21208 21209 21210 21211 21212
    ##   (21201,21202]     0   201     0     0     0     0     0     0     0     0
    ##   (21202,21218]     0     0    27    30     4     1     8    23    41    28
    ##   (21218,21226]     0     0     0     0     0     0     0     0     0     0
    ##   (21226,21287]     0     0     0     0     0     0     0     0     0     0
    ##                
    ##                 21213 21214 21215 21216 21217 21218 21220 21222 21223 21224
    ##   (21201,21202]     0     0     0     0     0     0     0     0     0     0
    ##   (21202,21218]    31    17    54    10    32    69     0     0     0     0
    ##   (21218,21226]     0     0     0     0     0     0     1     7    56   199
    ##   (21226,21287]     0     0     0     0     0     0     0     0     0     0
    ##                
    ##                 21225 21226 21226- 21227 21229 21230 21231 21234 21237 21239
    ##   (21201,21202]     0     0      0     0     0     0     0     0     0     0
    ##   (21202,21218]     0     0      0     0     0     0     0     0     0     0
    ##   (21218,21226]    19     0      0     0     0     0     0     0     0     0
    ##   (21226,21287]     0    18      0     4    13   156   127     7     1     3
    ##                
    ##                 21251 21287
    ##   (21201,21202]     0     0
    ##   (21202,21218]     0     0
    ##   (21218,21226]     0     0
    ##   (21226,21287]     2     1

Otra manera fácil de especificar los puntos de “corte” para generar una
variable categórica es con Hmisc() aplicando cut2() y en “g” indicamos
el número de grupos que queremos.

``` r
library(Hmisc)
```

    ## Loading required package: lattice

    ## Loading required package: survival

    ## Loading required package: Formula

    ## Loading required package: ggplot2

    ## 
    ## Attaching package: 'Hmisc'

    ## The following objects are masked from 'package:base':
    ## 
    ##     format.pval, units

``` r
restData$zipGroups <- cut2(as.numeric(restData$zipcode), g = 4)
table(restData$zipGroups)
```

    ## 
    ## [21201,21205) [21205,21220) [21220,21227) [21227,21287] 
    ##           337           375           300           314

## Creando factores

Respecto de los códigos postales, podemos tratarlos como si fueran
factores, podemos hacer un tratamiento más adecuado que si es un valor
numérico. Para ello utilizamos factor()

``` r
restData$zcf <- factor(restData$zipcode)
restData$zcf[1:10]
```

    ##  [1] 21206 21231 21224 21211 21223 21218 21205 21211 21205 21231
    ## 32 Levels: 21201 21202 21205 21206 21207 21208 21209 21210 21211 ... 21287

``` r
class(restData$zcf)
```

    ## [1] "factor"

Respecto de los niveles de una variable factor, los niveles se generan
por orden alfabético a no ser que indiquemos lo contrario. En este caso
queremos que “yes” sea el valor más alto. Para ello utilizarmos
relevel(), así si queremos utilizar la variable como número “yes” será 1
y “no” el 2.

``` r
yesno <- sample(c("yes", "no"), size = 10, replace = TRUE)
yesnofac <- factor(yesno, levels = c("yes", "no"))
relevel(yesnofac, ref = "yes")
```

    ##  [1] no  no  yes no  yes yes yes no  no  no 
    ## Levels: yes no

``` r
as.numeric(yesnofac)
```

    ##  [1] 2 2 1 2 1 1 1 2 2 2

De la misma manera que antes hemos “cortado” una variable para hacer
categorías.

``` r
library(Hmisc)
restData$zipGroups <- cut2(as.numeric(restData$zipcode), g = 4)
table(restData$zipGroups)
```

    ## 
    ## [21201,21205) [21205,21220) [21220,21227) [21227,21287] 
    ##           337           375           300           314

Con la función mutate() de la librería plyr() podemos añadir una nueva
variable como factor.

``` r
library(Hmisc)
library(plyr)
```

    ## 
    ## Attaching package: 'plyr'

    ## The following objects are masked from 'package:Hmisc':
    ## 
    ##     is.discrete, summarize

``` r
restData2 <- mutate(restData, zipGroups = cut2(as.numeric(zipcode), g = 4))
table(restData2$zipGroups)
```

    ## 
    ## [21201,21205) [21205,21220) [21220,21227) [21227,21287] 
    ##           337           375           300           314

## Transformaciones más comunes

-   abs(x) -&gt; valor absoluto
-   sqrt(x) -&gt; raíz cuadrada
-   ceiling(x) -&gt; redondeo de números hacia arriba
-   floor(x) -&gt; redondeo de números hacia abajo
-   round(x, digits = n) -&gt; redondeo de digitos
-   signif(x, digits = n) -&gt; redondeo de digitos
-   cos(x), sin(x), etc…
-   log(x) -&gt; logaritmo natural
-   log2(x), log10(x) -&gt; otros logaritmos habituales
-   exp(x) -&gt; exponenciales

Más info en -
<https://www.biostat.jhsph.edu/~ajaffe/lec_winterR/Lecture%202.pdf> -
<http://statmethods.net/management/functions.html>
