Remodelando datos
================
Carlos Guadián

## Tidy Data

-   Cada variable en una columna
-   Cada observación en una fila
-   Cada tabla / archivo almacena información de un tipo de observación.

## Melting (fusión) dataframes

Vamos a empezar trabajando con el dataset mtcars, en el cual podemos ver
que hay muchos coches diferentes en sus filas y unas cuantas variables
para cada una de ellas.

``` r
library(reshape2)
head(mtcars)
```

    ##                    mpg cyl disp  hp drat    wt  qsec vs am gear carb
    ## Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
    ## Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
    ## Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
    ## Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
    ## Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
    ## Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1

La fusión en la programación de R se realiza para organizar los datos.
Se realiza mediante la función melt() que toma los valores del conjunto
de datos y de las columnas que deben mantenerse constantes. Usando
melt(), el marco de datos se convierte en formato largo y estira el
marco de datos.

``` r
mtcars$carname <- rownames(mtcars)
carMelt <- melt(mtcars, id = c("carname", "gear", "cyl"), measure.vars = c("mpg", "hp"))
head(carMelt, n = 3)
```

    ##         carname gear cyl variable value
    ## 1     Mazda RX4    4   6      mpg  21.0
    ## 2 Mazda RX4 Wag    4   6      mpg  21.0
    ## 3    Datsun 710    4   4      mpg  22.8

``` r
tail(carMelt, n = 3)
```

    ##          carname gear cyl variable value
    ## 62  Ferrari Dino    5   6       hp   175
    ## 63 Maserati Bora    5   8       hp   335
    ## 64    Volvo 142E    4   4       hp   109

## Casting dataframes

El casting en la programación de R se utiliza para remodelar los datos
fundidos utilizando la función cast() que toma la función agregada y la
fórmula para agregar los datos en consecuencia.

Esta función se utiliza para convertir los datos de formato largo de
nuevo en alguna forma agregada de datos basada en la fórmula de la
función cast().

**Es como hacer una pivot table**

En este caso si aplicamos la función dcast() al dataframe que hemos
“fundido” antes (carMelt) le podemos pedir que nos diga para cada valor
de cyl, el conteo que hay para variable, es decir, para mpg y hp.

``` r
cylData <- dcast(carMelt, cyl ~ variable)
```

    ## Aggregation function missing: defaulting to length

``` r
cylData
```

    ##   cyl mpg hp
    ## 1   4  11 11
    ## 2   6   7  7
    ## 3   8  14 14

O bien podemos indicarle que nos muestre algún valor como la media.

``` r
cylData <- dcast(carMelt, cyl ~ variable, mean)
cylData
```

    ##   cyl      mpg        hp
    ## 1   4 26.66364  82.63636
    ## 2   6 19.74286 122.28571
    ## 3   8 15.10000 209.21429

## Valores promedios

Con tapply() podemos realizar cálculos a un dataset entero para cada uno
de los factores de una variable.

``` r
head(InsectSprays)
```

    ##   count spray
    ## 1    10     A
    ## 2     7     A
    ## 3    20     A
    ## 4    14     A
    ## 5    14     A
    ## 6    12     A

``` r
tapply(InsectSprays$count, InsectSprays$spray, sum)
```

    ##   A   B   C   D   E   F 
    ## 174 184  25  59  42 200

Otra manera es mediante split(). De esta manera obtenemos una lista de
valores para cada nivel del factor.

``` r
spIns <- split(InsectSprays$count, InsectSprays$spray)
spIns
```

    ## $A
    ##  [1] 10  7 20 14 14 12 10 23 17 20 14 13
    ## 
    ## $B
    ##  [1] 11 17 21 11 16 14 17 17 19 21  7 13
    ## 
    ## $C
    ##  [1] 0 1 7 2 3 1 2 1 3 0 1 4
    ## 
    ## $D
    ##  [1]  3  5 12  6  4  3  5  5  5  5  2  4
    ## 
    ## $E
    ##  [1] 3 5 3 5 3 6 1 1 3 2 6 4
    ## 
    ## $F
    ##  [1] 11  9 15 22 15 16 13 10 26 26 24 13

Entonces podemos aplicar apply() para tener la suma de cada lista de
valores.

``` r
sprCount <- lapply(spIns, sum)
unlist(sprCount)
```

    ##   A   B   C   D   E   F 
    ## 174 184  25  59  42 200

O con sapply() ya obtenemos directamente el resultado simplificado sin
necesidad de pasar por unlist()

``` r
sapply(spIns, sum)
```

    ##   A   B   C   D   E   F 
    ## 174 184  25  59  42 200

Con el paquete plyr() también tenemos una manera directa de hacerlo.

``` r
library(plyr)
ddply(InsectSprays, .(spray), summarize, sum = sum(count))
```

    ##   spray sum
    ## 1     A 174
    ## 2     B 184
    ## 3     C  25
    ## 4     D  59
    ## 5     E  42
    ## 6     F 200

Esta forma puede ser interesante para calcular los valores de cada nivel
de un factor y aplicarlos a una variable.

``` r
spraySums <- ddply(InsectSprays, .(spray), summarize, sum = ave(count, FUN = sum))
dim(spraySums)
```

    ## [1] 72  2

``` r
head(spraySums)
```

    ##   spray sum
    ## 1     A 174
    ## 2     A 174
    ## 3     A 174
    ## 4     A 174
    ## 5     A 174
    ## 6     A 174
