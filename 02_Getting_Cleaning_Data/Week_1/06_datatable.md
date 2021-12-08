data.table()
================

-   [data.table package](#datatable-package)

## data.table package

-   Acepta todas las funciones de data.frame
-   Es mucho más rápido, está escrito en C

``` r
library(data.table)
DF <- data.frame(x = rnorm(9), y = rep(c("a","b","c"), each = 3), z = rnorm(9))
head(DF,3)
```

    ##            x y           z
    ## 1 -0.2117071 a  0.02013243
    ## 2  1.2697285 a  0.09600248
    ## 3  0.1072064 a -0.31553149

De la misma manera que hemos creado un dataframe con data.frame, lo
podemos hacer con data.table

``` r
DT <- data.table(x = rnorm(9), y = rep(c("a","b","c"), each = 3), z = rnorm(9))
head(DF,3)
```

    ##            x y           z
    ## 1 -0.2117071 a  0.02013243
    ## 2  1.2697285 a  0.09600248
    ## 3  0.1072064 a -0.31553149

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

    ##             x y          z
    ## 1: -0.7445292 a -0.2427491

``` r
DT[DT$y == "a",] # filas en las que la variable "y" sea "a"
```

    ##             x y          z
    ## 1:  1.3460547 a  1.1278013
    ## 2: -0.7445292 a -0.2427491
    ## 3:  0.0298277 a -1.0551716

``` r
DT[c(2,3),] #segunda y tercera fila
```

    ##             x y          z
    ## 1: -0.7445292 a -0.2427491
    ## 2:  0.0298277 a -1.0551716

Pero el subset para las columnas no funciona igual

``` r
library(data.table)
DT[, 3] # podemos seleccionar una columna
```

    ##              z
    ## 1:  1.12780130
    ## 2: -0.24274906
    ## 3: -1.05517155
    ## 4: -0.02824116
    ## 5: -0.15519671
    ## 6:  0.28302584
    ## 7:  2.03823968
    ## 8: -0.01063209
    ## 9:  0.53211065

``` r
DT[, c(2,3)]
```

    ##    y           z
    ## 1: a  1.12780130
    ## 2: a -0.24274906
    ## 3: a -1.05517155
    ## 4: b -0.02824116
    ## 5: b -0.15519671
    ## 6: b  0.28302584
    ## 7: c  2.03823968
    ## 8: c -0.01063209
    ## 9: c  0.53211065

El argumento que se pasa después de la coma se considera una expresión.
Por lo tanto se pueden hacer cosas como pasar una lista de funciones o
incluso añadir una nueva columna como resultado de cálculos siempre y
cuando se pasen después de la coma.

``` r
DT[, list(mean(x), sum(z))]
```

    ##           V1       V2
    ## 1: 0.3522872 2.489187

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

    ##             x y           z           w
    ## 1:  1.3460547 a  1.12780130 1.271935775
    ## 2: -0.7445292 a -0.24274906 0.058927108
    ## 3:  0.0298277 a -1.05517155 1.113387000
    ## 4: -0.0159129 b -0.02824116 0.000797563
    ## 5:  0.6302362 b -0.15519671 0.024086019
    ## 6:  0.1054140 b  0.28302584 0.080103626

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

    ##    x            y
    ## 1: a -1.149878768
    ## 2: a  0.009498384
    ## 3: a  0.286802483
    ## 4: a  0.801437598
    ## 5: a -0.506619918
    ## 6: a -0.852628827

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
system.time(). Primero creamos un data.frame() y lo leemos con fread y
comprovamos los tiempos de ejecución.

``` r
big_df <- data.frame(x = rnorm(1E6), y = rnorm(1E6))
file <- tempfile()
write.table(big_df, file = file, row.names = FALSE, col.names = TRUE, sep = "\t", quote = FALSE)
system.time(fread(file))
```

    ##    user  system elapsed 
    ##   0.118   0.032   0.154

Ahora miramos lo que tarda en leer el mismo archivo con read.table.
Tarda casi 5 veces más. fread() actúa como si leyera data.table() por
eso la rapidez en su ejecución.

``` r
system.time(read.table(file, header = TRUE, sep = "\t"))
```

    ##    user  system elapsed 
    ##   9.874   0.402  10.428
