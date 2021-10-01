data.table()
================

## data.table package

-   Acepta todas las funciones de data.frame
-   Es mucho más rápido, está escrito en C

``` r
library(data.table)
DF <- data.frame(x = rnorm(9), y = rep(c("a","b","c"), each = 3), z = rnorm(9))
head(DF,3)
```

    ##            x y          z
    ## 1 0.09562346 a -0.6024490
    ## 2 0.35792970 a -1.5549512
    ## 3 0.45989554 a -0.6225723

De la misma manera que hemos creado un dataframe con data.frame, lo
podemos hacer con data.table

``` r
DT <- data.table(x = rnorm(9), y = rep(c("a","b","c"), each = 3), z = rnorm(9))
head(DF,3)
```

    ##            x y          z
    ## 1 0.09562346 a -0.6024490
    ## 2 0.35792970 a -1.5549512
    ## 3 0.45989554 a -0.6225723

Con tables() podemos listar los data.frame que tenemos y obtener
información relativo a ellas

``` r
tables()
```

    ##    NAME NROW NCOL MB  COLS KEY
    ## 1:   DT    9    3  0 x,y,z    
    ## Total: 0MB

Evidentemente se puede hacer subsetting mediante índices

``` r
DT[2,] # segunda fila
```

    ##           x y       z
    ## 1: 1.673872 a 1.42381

``` r
DT[DT$y == "a",] # filas en las que la variable "y" sea "a"
```

    ##             x y          z
    ## 1: -0.9852441 a 1.87586440
    ## 2:  1.6738724 a 1.42381005
    ## 3: -1.8536623 a 0.08256366

``` r
DT[c(2,3),] #segunda y tercera fila
```

    ##            x y          z
    ## 1:  1.673872 a 1.42381005
    ## 2: -1.853662 a 0.08256366

Pero el subset para las columnas no funciona igual

``` r
library(data.table)
DT[, 3] # podemos seleccionar una columna
```

    ##              z
    ## 1:  1.87586440
    ## 2:  1.42381005
    ## 3:  0.08256366
    ## 4:  0.52376567
    ## 5:  0.67716236
    ## 6:  0.28912612
    ## 7:  1.20360840
    ## 8: -1.45602889
    ## 9:  1.01416690

``` r
DT[, c(2,3)]
```

    ##    y           z
    ## 1: a  1.87586440
    ## 2: a  1.42381005
    ## 3: a  0.08256366
    ## 4: b  0.52376567
    ## 5: b  0.67716236
    ## 6: b  0.28912612
    ## 7: c  1.20360840
    ## 8: c -1.45602889
    ## 9: c  1.01416690

El argumento que se pasa después de la coma se considera una expresión.
Por lo tanto se pueden hacer cosas como pasar una lista de funciones o
incluso añadir una nueva columna como resultado de cálculos siempre y
cuando se pasen después de la coma.

``` r
DT[, list(mean(x), sum(z))]
```

    ##            V1       V2
    ## 1: -0.2755701 5.634039

``` r
DT[,table(y)]
```

    ## y
    ## a b c 
    ## 3 3 3

``` r
DT[, w := z ^ 2]
head(DT)
```

    ##              x y          z           w
    ## 1: -0.98524415 a 1.87586440 3.518867252
    ## 2:  1.67387237 a 1.42381005 2.027235050
    ## 3: -1.85366234 a 0.08256366 0.006816757
    ## 4:  0.05811979 b 0.52376567 0.274330480
    ## 5:  0.93948819 b 0.67716236 0.458548857
    ## 6:  0.49826425 b 0.28912612 0.083593912

El proceso es muy rápido pero lo carga todo en memoria, por lo que con
conjuntos de datos muy grandes puede causar problemas. El caso es que si
asignamos DT a una nueva variable, DT2, cuando hagamos un cambio en DT,
también cambiará DT2.

``` r
DT2 <- DT
DT[, y := 2]
```

Se pueden pasar incluso la definición de una función como argumento al
crear una nueva columna.

``` r
DT[, m := {tmp <- (x+z); log2(tmp + 5)}]
```

O calcular una columna lógica

``` r
DT[, a := x > 0]
```

O agrupar por los resultados de la columna lógica

``` r
DT[, b := mean(x + w), by = a]
```

Se puede definir un índice con setkey para realizar diferentes
operaciones, por ejemplo en el siguiente data.table definimos la
variable “x” como índice y nos permite de una manera fácil hacer un
subset para todos los registros en los que “x” sea igual a “a”.

``` r
DT <- data.table(x = rep(c("a","b","c"), each = 100), y = rnorm(100))
setkey(DT, x)
head(DT['a'])
```

    ##    x           y
    ## 1: a -0.58559887
    ## 2: a -1.01521652
    ## 3: a  0.56280582
    ## 4: a -0.02212941
    ## 5: a -0.28282361
    ## 6: a  0.24274447

Estos índices o claves también se pueden utilizar para faciliar las
uniones entre tablas.

``` r
DT1 <- data.table(x = c("a","a","b","dt1"), y = 1:4)
DT2 <- data.table(x = c("a", "b","dt2"), z = 5:7)
setkey(DT1, x)
setkey(DT2, x)
merge(DT1, DT2)
```

    ##    x y z
    ## 1: a 1 5
    ## 2: a 2 5
    ## 3: b 3 6

Por último, como ya se ha comentado, una de las grandes ventajas de
data.table es su rapidez. Vamos a hacer unas comprobaciones con
system.time()

``` r
DT1 <- data.table(x = c("a","a","b","dt1"), y = 1:4)
DT2 <- data.table(x = c("a", "b","dt2"), z = 5:7)
setkey(DT1, x)
setkey(DT2, x)
merge(DT1, DT2)
```

    ##    x y z
    ## 1: a 1 5
    ## 2: a 2 5
    ## 3: b 3 6
