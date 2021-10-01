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

    ##             x y          z
    ## 1  0.07265521 a 1.17383775
    ## 2 -1.52623245 a 0.03605568
    ## 3 -0.49296184 a 0.07516594

De la misma manera que hemos creado un dataframe con data.frame, lo
podemos hacer con data.table

``` r
DT <- data.table(x = rnorm(9), y = rep(c("a","b","c"), each = 3), z = rnorm(9))
head(DF,3)
```

    ##             x y          z
    ## 1  0.07265521 a 1.17383775
    ## 2 -1.52623245 a 0.03605568
    ## 3 -0.49296184 a 0.07516594

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

    ##             x y        z
    ## 1: -0.6518689 a 1.380345

``` r
DT[DT$y == "a",] # filas en las que la variable "y" sea "a"
```

    ##             x y         z
    ## 1: -2.3270525 a 1.1605203
    ## 2: -0.6518689 a 1.3803450
    ## 3: -0.3496990 a 0.2218312

``` r
DT[c(2,3),] #segunda y tercera fila
```

    ##             x y         z
    ## 1: -0.6518689 a 1.3803450
    ## 2: -0.3496990 a 0.2218312

Pero el subset para las columnas no funciona igual

``` r
library(data.table)
DT[, 3] # podemos seleccionar una columna
```

    ##              z
    ## 1:  1.16052030
    ## 2:  1.38034496
    ## 3:  0.22183122
    ## 4: -1.06400036
    ## 5: -0.05929057
    ## 6: -1.03757227
    ## 7: -1.28665461
    ## 8: -1.29877189
    ## 9:  1.32218698

``` r
DT[, c(2,3)]
```

    ##    y           z
    ## 1: a  1.16052030
    ## 2: a  1.38034496
    ## 3: a  0.22183122
    ## 4: b -1.06400036
    ## 5: b -0.05929057
    ## 6: b -1.03757227
    ## 7: c -1.28665461
    ## 8: c -1.29877189
    ## 9: c  1.32218698

El argumento que se pasa después de la coma se considera una expresión.
Por lo tanto se pueden hacer cosas como pasar una lista de funciones o
incluso añadir una nueva columna como resultado de cálculos siempre y
cuando se pasen después de la coma.

``` r
DT[, list(mean(x), sum(z))]
```

    ##            V1         V2
    ## 1: -0.3008148 -0.6614062

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
    ## 1: -2.3270525 a  1.16052030 1.346807359
    ## 2: -0.6518689 a  1.38034496 1.905352205
    ## 3: -0.3496990 a  0.22183122 0.049209092
    ## 4: -0.1763705 b -1.06400036 1.132096767
    ## 5: -0.4315093 b -0.05929057 0.003515371
    ## 6:  0.1051358 b -1.03757227 1.076556214

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
    ## 1: a  0.49260394
    ## 2: a  0.05265016
    ## 3: a  0.52823592
    ## 4: a -0.91626748
    ## 5: a  0.07208600
    ## 6: a  1.53897885

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
    ##   0.091   0.017   0.107

Ahora miramos lo que tarda en leer el mismo archivo con read.table.
Tarda casi 5 veces más. fread() actúa como si leyera data.table() por
eso la rapidez en su ejecución.

``` r
system.time(read.table(file, header = TRUE, sep = "\t"))
```

    ##    user  system elapsed 
    ##   5.525   0.141   5.729
