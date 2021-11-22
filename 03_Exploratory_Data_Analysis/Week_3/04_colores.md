Trazado y color en R
================

Vídeos de esta lección:

-   [Parte 1](https://youtu.be/7QaR91TCc3k)
-   [Parte 2](https://youtu.be/3Q1ormd5oMA)
-   [Parte 3](https://youtu.be/4JJfGpVHTq4)
-   [Parte 4](https://youtu.be/9-cn0auNV58)

Los esquemas de color por defecto para la mayoría de los gráficos en R
son horribles. Soy tan culpable como cualquiera de usar estos horrendos
esquemas de color, pero estoy tratando activamente de trabajar para
mejorar mis hábitos.

R tiene formas mucho mejores de manejar la especificación de los colores
en los diagramas y gráficos y usted debe hacer uso de ellos cuando sea
posible. Pero, para hacer eso, es importante saber un poco sobre cómo
funcionan los colores en R.

## Colores 1, 2 y 3

Muy a menudo, con los gráficos hechos en R, verás algo como el siguiente
gráfico de temática navideña.

``` r
set.seed(19)
x <- rnorm(30)
y <- rnorm(30)
plot(x, y, col = rep(1:3, each = 10), pch = 19)
legend("bottomright", legend = paste("Group", 1:3), col = 1:3, pch = 19, bty = "n")
```

![Colores por defecto en
R](04_colores_files/figure-gfm/unnamed-chunk-1-1.png)

La razón es sencilla. En R, el color negro se denota por `col = 1` en la
mayoría de las funciones de trazado, el rojo se denota por `col = 2`, y
el verde se denota por `col = 3`. Así que si estás trazando múltiples
grupos de cosas, es natural trazarlos usando los colores 1, 2 y 3.

Aquí hay otro conjunto de esquemas de color comunes utilizados en R,
esta vez a través de la función `image()`.

``` r
par(mfrow = c(1, 2))
image(volcano, col = heat.colors(10), main = "heat.colors()")
image(volcano, col = topo.colors(10), main = "topo.colors()")
```

![Gráficos de imagen en
R](04_colores_files/figure-gfm/unnamed-chunk-2-1.png)

## Conectar los colores con los datos

Normalmente añadimos color a un gráfico, no para mejorar su valor
artístico, sino para añadir otra dimensión a la visualización (por
ejemplo, para [“escapar de la tierra
plana”](http://www.edwardtufte.com/tufte/books_vdqi)).

> Tiene sentido que *la gama y la paleta de colores que utilices
> dependan del tipo de datos que estés representando*.

Mientras que puede ser común elegir los colores al azar, la elección de
los colores para su gráfico debe requerir una consideración cuidadosa.
Porque **la elección cuidadosa del color de los gráficos puede tener un
impacto en cómo la gente interpreta sus datos y saca conclusiones de
ellos**.

## Utilidades de color en R

R tiene un número de utilidades para tratar con colores y paletas de
colores en sus gráficos. Para empezar, el paquete `grDevices` tiene dos
funciones

-   `colorRamp`: Toma una paleta de colores y devuelve una función que
    toma valores entre 0 y 1, indicando los extremos de la paleta de
    colores (por ejemplo, ver la función `gray()`)
-   `colorRampPalette`: Toma una paleta de colores y devuelve una
    función que toma argumentos enteros y devuelve un vector de colores
    interpolando la paleta (como `heat.colors()` o `topo.colors()`)

Ambas funciones toman paletas de colores y ayudan a interpolar entre los
colores de la paleta. Sólo se diferencian en el tipo de objeto que
devuelven.

Por último, la función `colors()` enumera los nombres de los colores que
se pueden utilizar en cualquier función de trazado. Típicamente, usted
especificaría el color en una función de trazado (base) a través del
argumento `col`.

## `colorRamp()`

Tanto para `colorRamp()` como para `colorRampPalette()`, imagina que
eres un pintor y tienes tu paleta en la mano. En tu paleta hay un
conjunto de colores, digamos rojo y azul. Ahora, entre el rojo y el azul
puedes imaginar todo un espectro de colores que se pueden crear
mezclando diferentes cantidades de rojo y azul. Tanto `colorRamp()` como
`colorRampPalette()` se encargan de ese proceso de “mezcla” por ti.

Empecemos con una simple paleta de colores “rojo” y “azul” y pasémosla a
`colorRamp()`.

``` r
pal <- colorRamp(c("red", "blue"))
pal(0)
```

    ##      [,1] [,2] [,3]
    ## [1,]  255    0    0

Fíjate que `pal` es en realidad una función devuelta por `colorRamp()`.
Cuando llamamos a `pal(0)` obtenemos una matriz de 1 por 3. Los números
de la matriz irán de 0 a 255 e indican las cantidades de rojo, verde y
azul (RGB) en las columnas 1, 2 y 3 respectivamente. La matemática
simple nos dice que hay más de 16 millones de colores que pueden ser
expresados de esta manera. Llamar a `pal(0)` nos da el valor máximo
(255) en el rojo y 0 en los otros colores. Así que esto es sólo el color
rojo.

Podemos pasar cualquier valor entre 0 y 1 a la función `pal()`.

``` r
## azul
pal(1)
```

    ##      [,1] [,2] [,3]
    ## [1,]    0    0  255

``` r
## púrpura
pal(0.5)
```

    ##       [,1] [,2]  [,3]
    ## [1,] 127.5    0 127.5

También puedes pasar una secuencia de números a la función `pal()`.

``` r
pal(seq(0, 1, len = 10))
```

    ##            [,1] [,2]      [,3]
    ##  [1,] 255.00000    0   0.00000
    ##  [2,] 226.66667    0  28.33333
    ##  [3,] 198.33333    0  56.66667
    ##  [4,] 170.00000    0  85.00000
    ##  [5,] 141.66667    0 113.33333
    ##  [6,] 113.33333    0 141.66667
    ##  [7,]  85.00000    0 170.00000
    ##  [8,]  56.66667    0 198.33333
    ##  [9,]  28.33333    0 226.66667
    ## [10,]   0.00000    0 255.00000

La idea aquí es que `colorRamp()` te da una función que te permite
interpolar entre los dos colores rojo y azul. No tiene que proporcionar
sólo dos colores en su paleta de colores inicial; puede empezar con
múltiples colores y `colorRamp()` interpolará entre todos ellos.

## `colorRampPalette()`

La función `colorRampPalette()` es similar a `colorRamp(()`, sin embargo
la función que devuelve te da un número fijo de colores que interpolan
la paleta.

``` r
pal <- colorRampPalette(c("red", "yellow"))
```

De nuevo tenemos una función `pal()` que fue devuelta por
`colorRampPalette()`, esta vez interpolando una paleta que contiene los
colores rojo y amarillo. Pero ahora, la función `pal()` toma un
argumento entero que especifica el número de colores interpolados a
devolver.

``` r
## Sólo devuelve el rojo y el amarillo
pal(2)
```

    ## [1] "#FF0000" "#FFFF00"

Tenga en cuenta que los colores se representan como cadenas
hexadecimales. Después del símbolo \#, los dos primeros caracteres
indican la cantidad de rojo, los dos segundos la cantidad de verde y los
dos últimos la cantidad de azul. Como cada posición puede tener 16
valores posibles (0-9 y A-F), las dos posiciones juntas permiten 256
posibilidades por color. En este ejemplo, como sólo pedimos dos colores,
nos dio el rojo y el amarillo, los dos extremos de la paleta.

Sin embargo, podemos pedir más colores.

``` r
## Devuelve 10 colores entre el rojo y el amarillo
pal(10)
```

    ##  [1] "#FF0000" "#FF1C00" "#FF3800" "#FF5500" "#FF7100" "#FF8D00" "#FFAA00"
    ##  [8] "#FFC600" "#FFE200" "#FFFF00"

Verás que el primer color sigue siendo el rojo (“FF” en la posición
roja) y el último color sigue siendo el amarillo (“FF” en las posiciones
roja y verde). Pero ahora hay 8 colores más en medio. Estos valores, en
formato hexadecimal, también pueden ser especificados a las funciones de
trazado base a través del argumento `col`.

Tenga en cuenta que la función `rgb()` se puede utilizar para producir
cualquier color a través de las proporciones de rojo, verde, azul y
devolver una representación hexadecimal.

``` r
rgb(0, 0, 234, maxColorValue = 255)
```

    ## [1] "#0000EA"

## Paquete RColorBrewer

Parte del arte de crear buenos esquemas de color en los gráficos de
datos es comenzar con una paleta de colores apropiada que luego se puede
interpolar con una función como `colorRamp()` o `colorRampPalette()`.

> Un paquete en CRAN que contiene interesantes y útiles paletas de
> colores es el paquete
> [`RColorBrewer`](http://cran.r-project.org/package=RColorBrewer).

El paquete `RColorBrewer` ofrece tres tipos de paletas:

-   **Secuencial**: para datos numéricos que están ordenados
-   **Divergente**: para datos numéricos que pueden ser positivos o
    negativos, a menudo representando desviaciones de alguna norma o
    línea de base
-   **Cualitativa**: para datos cualitativos no ordenados

Todas estas paletas pueden utilizarse junto con `colorRamp()` y
`colorRampPalette()`.

A continuación se muestran todas las paletas de colores disponibles en
el paquete `RColorBrewer`.

``` r
library(RColorBrewer)
display.brewer.all()
```

![RColorBrewer
palettes](04_colores_files/figure-gfm/unnamed-chunk-10-1.png)

## Uso de las paletas de RColorBrewer

La única función real del paquete `RColorBrewer` es la función
`brewer.pal()` que tiene dos argumentos

-   `name`: el nombre de la paleta de colores que quieres usar
-   `n`: el número de colores que quieres de la paleta (entero)

A continuación elegimos utilizar 3 colores de la paleta “BuGn”, que es
una paleta secuencial.

``` r
library(RColorBrewer)
cols <- brewer.pal(3, "BuGn")
cols
```

    ## [1] "#E5F5F9" "#99D8C9" "#2CA25F"

Esos tres colores conforman mi paleta inicial. Entonces puedo pasarlos a
`colorRampPalette()` para crear mi función de interpolación.

``` r
pal <- colorRampPalette(cols)
```

Ahora puedo trazar los datos del `volcán` utilizando esta rampa de
color. Ten en cuenta que el conjunto de datos del `volcán` contiene las
elevaciones de un volcán, que son datos numéricos continuos y ordenados,
para los que una paleta secuencial es apropiada.

``` r
image(volcano, col = pal(20))
```

![Datos del volcán con paleta de rampa de
colores](04_colores_files/figure-gfm/unnamed-chunk-13-1.png)

## La función `smoothScatter()`

Una función que aprovecha las paletas de colores de `RColorBrewer` es la
función `smoothScatter()`, que es muy útil para hacer gráficos de
dispersión de conjuntos de datos muy grandes. La función
`smoothScatter()` esencialmente le da un histograma 2-D de los datos
utilizando una paleta secuencial (aquí “Blues”).

``` r
set.seed(1)
x <- rnorm(10000)
y <- rnorm(10000)
smoothScatter(x, y)
```

![función
smoothScatter](04_colores_files/figure-gfm/unnamed-chunk-14-1.png)

## Añadir transparencia

La transparencia del color se puede añadir a través del parámetro
`alpha` a `rgb()` para producir especificaciones de color con diferentes
niveles de transparencia. Cuando se utiliza la transparencia, notará que
se añaden dos caracteres extra a la derecha de la representación
hexadecimal (habrá 8 posiciones en lugar de 6).

Por ejemplo, si quisiera el color rojo con un alto nivel de
transparencia, podría especificar

``` r
rgb(1, 0, 0, 0.1)
```

    ## [1] "#FF00001A"

La transparencia puede ser útil cuando se tienen gráficos con una alta
densidad de puntos o líneas. Por ejemplo, el gráfico de dispersión de
abajo tiene un montón de puntos sobrepuestos y es difícil ver lo que
está sucediendo en el centro de la región del gráfico.

``` r
set.seed(2)
x <- rnorm(2000)
y <- rnorm(2000)
plot(x, y, pch = 19)
```

![Diagrama de dispersión sin
transparencia](04_colores_files/figure-gfm/unnamed-chunk-16-1.png)

Si añadimos algo de transparencia a los círculos negros, podemos obtener
una mejor sensación de la densidad variable de los puntos en el gráfico.

``` r
plot(x, y, pch = 19, col = rgb(0, 0, 0, 0.15))
```

![Diagrama de dispersión con
transparencia](04_colores_files/figure-gfm/unnamed-chunk-17-1.png)

**Mejor, ¿verdad?**

## Resumen

-   El uso cuidadoso de los colores en los gráficos, imágenes, mapas y
    otros gráficos de datos puede facilitar al lector la comprensión de
    lo que está tratando de decir (¿por qué hacerlo más difícil?).
-   El paquete `RColorBrewer` es un paquete de R que proporciona paletas
    de colores para datos secuenciales, categóricos y divergentes.
-   Las funciones `colorRamp` y `colorRampPalette` se pueden utilizar
    junto con las paletas de colores para conectar los datos con los
    colores
-   La transparencia puede utilizarse a veces para aclarar los gráficos
    con muchos puntos.