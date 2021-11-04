ggplot2()
================

El paquete `ggplot2` en R es una implementación de *La Gramática de los
Gráficos* tal y como la describe Leland Wilkinson en su libro. El
paquete fue escrito originalmente por Hadley Wickham mientras era
estudiante de posgrado en la Universidad Estatal de Iowa (todavía
mantiene activamente el paquete). El paquete implementa lo que podría
considerarse un tercer sistema de gráficos para R (junto con los
gráficos `base` y `lattice`). El paquete está disponible en
[CRAN](http://cran.r-project.org/package=ggplot2) a través de
`install.packages()`; la última versión del código fuente puede
encontrarse en el \[Repositorio GitHub\] del paquete
(<https://github.com/hadley/ggplot2>). La documentación del paquete
puede encontrarse en [http://docs.ggplot2.org/current/]()

-   Una aplicación de *La gramática de los gráficos* de Leland Wilkinson
-   Escrito por Hadley Wickham (mientras era estudiante de posgrado en
    Iowa State)
-   Un “tercer” sistema de gráficos para R (junto con **base** y
    **lattice**)
-   Disponible en CRAN mediante `install.packages()`.
-   Sitio web: <http://ggplot2.org> (mejor documentación)

La gramática de los gráficos representa una abstracción de las ideas y
objetos gráficos. Se puede pensar en esto como el desarrollo de los
verbos, sustantivos y adjetivos para los gráficos de datos. El
desarrollo de esta gramática permite una “teoría” de los gráficos sobre
la que construir nuevos gráficos y objetos gráficos. Citando el libro de
Hadley Wickham sobre `ggplot2`, queremos “acortar la distancia de la
mente a la página”. En resumen,

> “…la gramática nos dice que un gráfico estadístico es un **mapping**
> de datos a atributos **estéticos** (color, forma, tamaño) de objetos
> **geométricos** (puntos, líneas, barras). El gráfico también puede
> contener transformaciones estadísticas de los datos y se dibuja en un
> sistema de coordenadas específico” – del libro \_ggplot2

-   La gramática de los gráficos representa una abstracción de las
    ideas/objetos gráficos
-   Piensa en “verbo”, “sustantivo” y “adjetivo” para los gráficos
-   Permite una “teoría” de los gráficos sobre la que construir nuevos
    gráficos y objetos gráficos
-   “Acortar la distancia de la mente a la página”

Te preguntarás “¿Por qué necesitamos una gramática de los gráficos?”.
Pues por las mismas razones que tener una gramática es útil para las
lenguas habladas. La gramática permite un resumen más compacto de los
componentes base de un lenguaje, y nos permite extender el lenguaje y
manejar situaciones que no hemos visto antes.

Si pensamos en hacer un gráfico con el sistema gráfico base, el gráfico
se construye llamando a una serie de funciones que crean o anotan un
gráfico. No hay una manera conveniente de describir el gráfico, excepto
recitar la serie de funciones de R que fueron llamadas para crear la
cosa en primer lugar. En un capítulo anterior, describimos el sistema de
trazado básico como una especie de modelo de “paleta de artista”, donde
se comienza con un “lienzo” en blanco y se construye a partir de ahí.

-   Modelo "Paleta del artista
-   Comienza con un lienzo en blanco y construye a partir de ahí
-   Empezar con la función `plot` (o similar)
-   Utilice las funciones de anotación para añadir/modificar (`text`,
    `lines`, `points`, `axis`)

Por ejemplo, considere el siguiente trazado realizado con gráficos base.

``` r
with(airquality, { 
        plot(Temp, Ozone)
        lines(loess.smooth(Temp, Ozone))
})
```

![Gráfico de dispersión de la temperatura y el ozono en Nueva York
(gráficos base)](02_ggplot2_files/figure-gfm/unnamed-chunk-1-1.png)

¿Cómo describiríamos la creación de este gráfico? Bien, podríamos decir
que llamamos a la función `plot()` y luego añadimos un suavizador de
loess llamando a la función `lines()` sobre la salida de
`loess.smooth()`.

El sistema de trazado básico es conveniente y a menudo refleja la forma
en que pensamos en la construcción de gráficos y el análisis de datos.
Pero un inconveniente clave es que no se puede volver atrás una vez que
se ha iniciado el trazado (por ejemplo, para ajustar los márgenes), por
lo que, de hecho, es necesario planificar de antemano. Además, es
difícil “traducir” un gráfico a otros porque no hay un lenguaje gráfico
formal; cada gráfico es sólo una serie de comandos de R.

Aquí está el mismo gráfico hecho con `ggplot2`.

``` r
library(ggplot2)
ggplot(airquality, aes(Temp, Ozone)) + 
        geom_point() + 
        geom_smooth(method = "loess", se = FALSE)
```

    ## `geom_smooth()` using formula 'y ~ x'

![](02_ggplot2_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

Obsérvese que la salida es aproximadamente equivalente, y la cantidad de
código es similar, pero `ggplot2` permite una forma más elegante de
expresar los componentes del gráfico. En este caso, el gráfico es un
*conjunto de datos* (`calidad del aire`) con *mapas estéticos* derivadas
de las variables `Temp` y `Ozone`, un conjunto de *puntos*, y un
*smoother*. En cierto sentido, el sistema `ggplot2` toma muchas de las
señales del sistema de trazado base y las formaliza un poco.

El sistema `ggplot2` también toma algunas señales de `lattice`. Con el
sistema `lattice`, los gráficos se crean con una sola llamada a la
función (`xyplot`, `bwplot`, etc.). Cosas como los márgenes y el
espaciado se establecen automáticamente porque todo el gráfico se
especifica a la vez. El sistema `lattice` es más útil para condicionar
tipos de gráficos y es bueno para poner muchos gráficos en una pantalla.
Dicho esto, a veces es incómodo especificar un gráfico completo en una
sola llamada a la función porque hay que especificar muchas opciones
diferentes a la vez. Además, la anotación en los gráficos no es
intuitiva y el uso de funciones de panel y subíndices es difícil de
manejar y requiere una intensa preparación.

El sistema `ggplot2` esencialmente toma las partes buenas del sistema de
gráficos base y del sistema de gráficos lattice. Maneja automáticamente
cosas como los márgenes y el espaciado, y también tiene el concepto de
“temas” que proporcionan un conjunto predeterminado de símbolos de
trazado y colores. Aunque `ggplot2` tiene una similitud superficial con
`lattice`, `ggplot2` es generalmente más fácil y más intuitivo de usar.
Los temas por defecto hacen muchas elecciones por ti, pero puedes
personalizar la presentación si lo deseas.

## Básicos: `qplot()`

La función `qplot()` en `ggplot2` está pensada para que te pongas en
marcha *r*ápidamente. Funciona de forma muy parecida a la función
`plot()` del sistema gráfico base. Busca variables para graficar dentro
de un marco de datos, similar a lattice. En general, es bueno
acostumbrarse a poner los datos en un marco de datos y luego pasarlos a
`qplot()`.

Los gráficos se componen de *aesthetics* (tamaño, forma, color) y
*geoms* (puntos, líneas). Los factores juegan un papel importante para
indicar subconjuntos de los datos (si van a tener propiedades
diferentes) por lo que deben ser **etiquetados** adecuadamente. La
función `qplot()` oculta mucho de lo que pasa por debajo, lo cual está
bien para la mayoría de las operaciones, `ggplot()` es la función
principal y es muy flexible para hacer cosas que `qplot()` no puede
hacer.

## Antes de empezar: Etiquetar los datos

Algo que siempre es cierto, pero que es particularmente útil cuando se
usa `ggplot2`, es que siempre debe usar etiquetas informativas y
descriptivas en sus datos. Más generalmente, sus datos deberían tener
*metadatos* apropiados para que pueda mirar rápidamente un conjunto de
datos y saber

-   qué son las variables
-   qué significan los valores de cada variable

Esto significa que cada columna de un marco de datos debe tener un
nombre de variable significativo (pero conciso) que refleje con
precisión los datos almacenados en esa columna. Además, las variables no
numéricas o categóricas deben codificarse como variables factoriales y
tener etiquetas significativas para cada nivel del factor. Por ejemplo,
es habitual codificar una variable binaria como un “0” o un “1”, pero el
problema es que al mirar rápidamente los datos, es imposible saber qué
nivel de esa variable está representado por un “0” o un “1”. Es mucho
mejor etiquetar simplemente cada observación como lo que es. Si una
variable representa categorías de temperatura, sería mejor utilizar
“frío”, “suave” y “caliente” en lugar de “1”, “2” y “3”.

Aunque a veces es una molestia asegurarse de que todos los datos están
correctamente etiquetados, esta inversión de tiempo puede reportar
beneficios en el futuro cuando se intente averiguar qué se estaba
trazando. En otras palabras, incluir los metadatos adecuados puede hacer
que los gráficos exploratorios sean esencialmente auto-documentados.

## ggplot2 “¡Hola, mundo!”

Este conjunto de datos de ejemplo viene con el paquete `ggplot2` y
contiene datos sobre la economía de combustible de 38 modelos populares
de coche desde 1999 hasta 2008.

``` r
str(mpg)
```

    ## tibble [234 × 11] (S3: tbl_df/tbl/data.frame)
    ##  $ manufacturer: chr [1:234] "audi" "audi" "audi" "audi" ...
    ##  $ model       : chr [1:234] "a4" "a4" "a4" "a4" ...
    ##  $ displ       : num [1:234] 1.8 1.8 2 2 2.8 2.8 3.1 1.8 1.8 2 ...
    ##  $ year        : int [1:234] 1999 1999 2008 2008 1999 1999 2008 1999 1999 2008 ...
    ##  $ cyl         : int [1:234] 4 4 4 4 6 6 6 4 4 4 ...
    ##  $ trans       : chr [1:234] "auto(l5)" "manual(m5)" "manual(m6)" "auto(av)" ...
    ##  $ drv         : chr [1:234] "f" "f" "f" "f" ...
    ##  $ cty         : int [1:234] 18 21 20 21 16 18 18 18 16 20 ...
    ##  $ hwy         : int [1:234] 29 29 31 30 26 26 27 26 25 28 ...
    ##  $ fl          : chr [1:234] "p" "p" "p" "p" ...
    ##  $ class       : chr [1:234] "compact" "compact" "compact" "compact" ...

Puedes ver en la salida de `str()` que todas las variables del factor
están codificadas adecuadamente con etiquetas significativas. Esto será
muy útil cuando `qplot()` tenga que etiquetar diferentes aspectos de un
gráfico.

Observe también que todas las columnas/variables tienen nombres
significativos (aunque a veces abreviados), en lugar de nombres como
“X1”, y “X2”, etc.

Podemos hacer un rápido gráfico de dispersión del desplazamiento del
motor (`displ`) y las millas por galón en carretera (`hwy`).

``` r
qplot(displ, hwy, data = mpg)
```

![Gráfico de la cilindrada del motor y el kilometraje en
carretera](02_ggplot2_files/figure-gfm/unnamed-chunk-4-1.png)

Ten en cuenta que en la llamada a `qplot()` debes especificar el
argumento `data` para que `qplot()` sepa dónde buscar las variables.

## Modificar la estética

Podemos introducir una tercera variable en el gráfico modificando el
color de los puntos en función del valor de esa tercera variable. El
color es una estética y el color de cada punto puede ser mapeado a una
variable. Tenga en cuenta que las coordenadas `x` e `y` también son
`aesthetics`, y se han mapeado a las variables `displ` y `hwy`,
respectivamente. En este caso vamos a asignar el color a la variable
`drv` que indica si un coche es de tracción delantera, tracción trasera,
o 4 ruedas motrices.

``` r
qplot(displ, hwy, data = mpg, color = drv)
```

![Cilindrada del motor y kilometraje en carretera por clase de
tracción](02_ggplot2_files/figure-gfm/unnamed-chunk-5-1.png)

Ahora podemos ver que los coches de tracción delantera tienden a tener
una menor cilindrada en relación con los coches de tracción 4 o trasera.
Además, está claro que los coches con tracción a las 4 ruedas tienen el
menor kilometraje de gasolina en carretera.

## Añadir un geom

A veces es bueno añadir un suavizador a un gráfico de dispersión para
resaltar cualquier tendencia. Las tendencias pueden ser difíciles de ver
si los datos tienen mucho ruido o hay muchos puntos de datos que
oscurecen la vista. Un suavizador es un “geom” que se puede añadir junto
con los puntos de datos.

``` r
qplot(displ, hwy, data = mpg, geom = c("point", "smooth"))
```

    ## `geom_smooth()` using method = 'loess' and formula 'y ~ x'

![Desplazamiento del motor y kilometraje en carretera con
suavizado](02_ggplot2_files/figure-gfm/unnamed-chunk-6-1.png)

Tenga en cuenta que antes no teníamos que especificar `geom = "punto"`
porque se hacía automáticamente. Pero si quieres que el suavizado se
superponga a los puntos, entonces tienes que especificar ambos
explícitamente.

Aquí parece que el desplazamiento del motor y el kilometraje en
carretera tienen una relación no lineal en forma de U, pero desde el
gráfico anterior sabemos que esto se debe en gran medida a la confusión
por la clase de conducción del coche.

## Histogramas

La función `qplot()` también puede utilizarse para trazar datos
unidimensionales. Especificando una sola variable, `qplot()` hará por
defecto un histograma.

Aquí hacemos un histograma si los datos del kilometraje de la carretera
y estratificamos en la clase de conducción. Así que técnicamente se
trata de tres histogramas superpuestos.

``` r
qplot(hwy, data = mpg, fill = drv, binwidth = 2)
```

![Histograma del kilometraje en carretera por clase de
conducción](02_ggplot2_files/figure-gfm/unnamed-chunk-7-1.png)

Tener los diferentes colores para cada clase de conducción es agradable,
pero los tres histogramas pueden ser un poco difíciles de separar. Una
solución a este problema es colocar los gráficos de caja uno al lado del
otro.

``` r
qplot(drv, hwy, data = mpg, geom = "boxplot")
```

![Boxplots del kilometraje de la carretera por clase de
conducción](02_ggplot2_files/figure-gfm/unnamed-chunk-8-1.png)

Otra solución es trazar los histogramas en paneles separados utilizando
`facets.`

## Facets

Los facets son una forma de crear múltiples paneles de gráficos basados
en los niveles de la variable categórica. En este caso, queremos ver un
histograma de los kilometrajes de las carreteras y la variable
categórica es la variable de clase de conducción. Podemos hacerlo
utilizando el argumento `facets` de `qplot()`.

El argumento `facets` espera una entrada de tipo fórmula, con un `~`
separando la variable del lado izquierdo y la variable del lado derecho.
La variable del lado izquierdo indica cómo deben dividirse las filas de
los paneles y la variable del lado derecho indica cómo deben dividirse
las columnas de los paneles.

Aquí, sólo queremos tres filas de histogramas (y sólo una columna), uno
para cada clase de unidad, por lo que especificamos `drv` en el lado
izquierdo y `.` en el lado derecho indicando que no hay ninguna variable
allí (está vacío).

``` r
qplot(hwy, data = mpg, facets = drv ~ ., binwidth = 2)
```

![Histograma del kilometraje de las carreteras por clase de
conducción](02_ggplot2_files/figure-gfm/unnamed-chunk-9-1.png)

También podríamos ver más datos utilizando facets, así que en lugar de
histogramas podríamos ver gráficos de dispersión del desplazamiento del
motor y el kilometraje en carretera por clase de conducción. Aquí
ponemos la variable `drv` en el lado derecho para indicar que queremos
una columna para cada clase de conducción (en lugar de dividir por filas
como hicimos anteriormente).

``` r
qplot(displ, hwy, data = mpg, facets = . ~ drv)
```

![Desplazamiento del motor y kilometraje en carretera por clase de
conducción](02_ggplot2_files/figure-gfm/unnamed-chunk-10-1.png)

¿Y si quieres añadir un suavizador a cada uno de esos paneles? Simple,
usted, literalmente, sólo tiene que añadir el suavizador como otro geom.

``` r
qplot(displ, hwy, data = mpg, facets = . ~ drv) + geom_smooth()
```

    ## `geom_smooth()` using method = 'loess' and formula 'y ~ x'

![Desplazamiento del motor y kilometraje en carretera por clase de
conducción
w/smoother](02_ggplot2_files/figure-gfm/unnamed-chunk-11-1.png)

También podrías haber utilizado el argumento “geom” de `qplot()`, como
en

``` r
qplot(displ, hwy, data = mpg, facets = . ~ drv, geom = c("point", "smooth"))
```

Hay más de una forma de hacerlo.

## Estudio de caso: Cohorte MAACS

Este estudio de caso utilizará datos basados en el Estudio de Cohorte de
Alérgenos y Asma en Ratones (MAACS). Este estudio tenía como objetivo
caracterizar el ambiente interior (del hogar) y su relación con la
morbilidad del asma entre los niños de 5 a 17 años que viven en
Baltimore, MD. Todos los niños tenían asma persistente, definida como si
hubieran tenido una exacerbación en el último año. Una publicación
representativa de los resultados de este estudio puede encontrarse en
este documento de [Lu, et al.](http://goo.gl/WqE9j8)

> NOTA: Debido a que los datos a nivel individual para este estudio
> están protegidos por varias leyes de privacidad de los Estados Unidos,
> no podemos hacer que esos datos estén disponibles. Para los fines de
> este capítulo, hemos simulado datos que comparten muchas de las
> características de los datos originales, pero no contienen ninguna de
> las medidas o valores reales contenidos en el conjunto de datos
> original.

    ## 'data.frame':    750 obs. of  5 variables:
    ##  $ id       : int  1 2 3 4 5 6 7 8 9 10 ...
    ##  $ eno      : num  141 124 126 164 99 68 41 50 12 30 ...
    ##  $ duBedMusM: num  2423 2793 3055 775 1634 ...
    ##  $ pm25     : num  15.6 34.4 39 33.2 27.1 ...
    ##  $ mopos    : Factor w/ 2 levels "no","yes": 2 2 2 2 2 2 2 2 2 2 ...

Las variables clave son:

-   `mopos`: un indicador de si el sujeto es alérgico al alérgeno del
    ratón (sí/no).
-   PM25: nivel medio de PM2.5 en el transcurso de 7 días (microgramos
    por metro cúbico)
-   óxido nítrico exhalado

El resultado de interés para este análisis será el óxido nítrico
exhalado (eNO), que es una medida de la inflamación pulmonar. Podemos
hacernos una idea de cómo se distribuye el eNO en esta población
haciendo un rápido histograma de la variable. En este caso, tomamos el
logaritmo del eNO, ya que los datos presentan cierta desviación a la
derecha.

``` r
qplot(log(eno), data = maacs)
```

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

    ## Warning: Removed 108 rows containing non-finite values (stat_bin).

![Histograma de log
eNO](02_ggplot2_files/figure-gfm/unnamed-chunk-13-1.png)

Un vistazo rápido sugiere que el histograma es un poco “gordo”, lo que
sugiere que podría haber varios grupos de personas que se agrupan.
Podemos estratificar el histograma según si son alérgicos al ratón.

``` r
qplot(log(eno), data = maacs, fill = mopos)
```

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

    ## Warning: Removed 108 rows containing non-finite values (stat_bin).

![Histograma de log eNO por estado de alergia al
ratón](02_ggplot2_files/figure-gfm/unnamed-chunk-14-1.png)

Podemos ver en este gráfico que los sujetos no alérgicos se desplazan
ligeramente hacia la izquierda, lo que indica un eNO más bajo y una
menor inflamación pulmonar. Dicho esto, existe un solapamiento
significativo entre los dos grupos.

Una alternativa a los histogramas es un suavizador de densidad, que a
veces puede ser más fácil de visualizar cuando hay múltiples grupos. He
aquí un suavizador de densidad de toda la población del estudio.

``` r
qplot(log(eno), data = maacs, geom = "density")
```

    ## Warning: Removed 108 rows containing non-finite values (stat_density).

![Densidad suave del log
eNO](02_ggplot2_files/figure-gfm/unnamed-chunk-15-1.png)

Y aquí están las densidades estratificadas por estado alérgico. Podemos
mapear la estética del color a la variable `mopos`.

``` r
qplot(log(eno), data = maacs, geom = "density", color = mopos)
```

    ## Warning: Removed 108 rows containing non-finite values (stat_density).

![Densidad suavizada de log eNO por estado alérgico del
ratón](02_ggplot2_files/figure-gfm/unnamed-chunk-16-1.png)

Estos resultados son idénticos a los de los histogramas estratificados,
lo que no debería sorprender.

Ahora podemos examinar el ambiente interior y su relación con el eNO. En
este caso, utilizamos el nivel de PM2,5 en el interior como medida de la
calidad del aire del ambiente interior. Podemos hacer un simple gráfico
de dispersión de PM2,5 y eNO.

``` r
qplot(log(pm25), log(eno), data = maacs, geom = c("point", "smooth"))
```

    ## `geom_smooth()` using method = 'loess' and formula 'y ~ x'

    ## Warning: Removed 184 rows containing non-finite values (stat_smooth).

    ## Warning: Removed 184 rows containing missing values (geom_point).

![eNO y PM2.5](02_ggplot2_files/figure-gfm/unnamed-chunk-17-1.png)

La relación parece modesta en el mejor de los casos, ya que hay mucho
ruido en los datos. Sin embargo, una cuestión que podría interesarnos es
si los individuos alérgicos son quizá más sensibles a la inhalación de
PM2,5 que los no alérgicos. Para examinar esta cuestión, podemos
estratificar los datos en dos grupos.

Este primer gráfico utiliza diferentes símbolos para los dos grupos y
los superpone en un único lienzo. Podemos hacer esto mediante la
asignación de la variable `mopos` a la estética `shape`.

``` r
qplot(log(pm25), log(eno), data = maacs, shape = mopos)
```

    ## Warning: Removed 184 rows containing missing values (geom_point).

![eNO y PM2.5 por estado alérgico al
ratón](02_ggplot2_files/figure-gfm/unnamed-chunk-18-1.png)

Dado que los datos se solapan considerablemente, es un poco difícil
distinguir los círculos de los triángulos. Parte de la razón podría ser
que todos los símbolos son del mismo color (negro).

Podemos trazar cada grupo de un color diferente para ver si eso ayuda.

``` r
qplot(log(pm25), log(eno), data = maacs, color = mopos)
```

    ## Warning: Removed 184 rows containing missing values (geom_point).

![eNO y PM2.5 por estado alérgico al
ratón](02_ggplot2_files/figure-gfm/unnamed-chunk-19-1.png)

Esto es ligeramente mejor, pero el considerable solapamiento hace
difícil discernir cualquier tendencia en los datos. Para ello tenemos
que añadir un suavizador de algún tipo. Aquí añadimos una línea de
regresión lineal (un tipo de suavizador) a cada grupo para ver si hay
alguna diferencia.

``` r
qplot(log(pm25), log(eno), data = maacs, color = mopos) + geom_smooth(method = "lm")
```

    ## `geom_smooth()` using formula 'y ~ x'

    ## Warning: Removed 184 rows containing non-finite values (stat_smooth).

    ## Warning: Removed 184 rows containing missing values (geom_point).

![](02_ggplot2_files/figure-gfm/unnamed-chunk-20-1.png)<!-- -->

Aquí vemos claramente que el grupo rojo y el grupo verde muestran
relaciones bastante diferentes entre las PM2.5 y el eNO. Para los
individuos no alérgicos, parece haber una relación ligeramente negativa
entre las PM2.5 y el eNO y para los individuos alérgicos, hay una
relación positiva. Esto sugiere una fuerte interacción entre las PM2,5 y
el estado alérgico, una hipótesis que quizá merezca la pena seguir con
más detalle que este breve análisis exploratorio.

Otra forma, quizás más clara, de visualizar esta interacción es utilizar
paneles separados para los individuos no alérgicos y alérgicos
utilizando el argumento `facets` de `qplot()`.

``` r
qplot(log(pm25), log(eno), data = maacs, facets = . ~ mopos) + geom_smooth(method = "lm")
```

    ## `geom_smooth()` using formula 'y ~ x'

    ## Warning: Removed 184 rows containing non-finite values (stat_smooth).

    ## Warning: Removed 184 rows containing missing values (geom_point).

![](02_ggplot2_files/figure-gfm/unnamed-chunk-21-1.png)<!-- -->

## Resumen de qplot()

La función `qplot()` en `ggplot2` es el análogo de `plot()` en los
gráficos base pero con muchas características incorporadas que el
tradicional `plot()` no proporciona. La sintaxis está en algún lugar
entre el sistema de gráficos base y el lattice. La función `qplot()` es
útil para poner rápidamente los datos en la página/pantalla, pero para
la personalización final, puede tener más sentido utilizar algunas de
las funciones de nivel inferior que discutimos más adelante en el
próximo capítulo.

# El sistema de ploteo ggplot2: Parte 2

En este capítulo nos adentraremos un poco más en los detalles de cómo
`ggplot2` construye gráficos y cómo puede personalizar varios aspectos
de cualquier gráfico. En el capítulo anterior usamos la función
`qplot()` para poner rápidamente puntos en una página. La sintaxis de la
función `qplot()` es muy similar a la de la función `plot()` de los
gráficos base, por lo que para aquellos que se cambien, es una
transición fácil. Pero vale la pena conocer los detalles subyacentes de
cómo funciona `ggplot2` para poder explotar realmente su poder.

## Componentes básicos de un gráfico ggplot2

Un gráfico `ggplot2` consiste en un número de componentes clave. Aquí
están algunos de los más utilizados.

-   Un *dataframe*: almacena todos los datos que se mostrarán en el
    gráfico
-   *Aesthetics mappings*: describen cómo se asignan los datos al color,
    el tamaño, la forma y la ubicación.
-   *geoms*: objetos geométricos como puntos, líneas, formas.
-   *facets*: describe cómo deben construirse los gráficos
    condicionales/de panel
-   *stats*: transformaciones estadísticas como binning, quantiles,
    smoothing.
-   *scales*: qué escala utiliza un mapa estético (ejemplo: hombre =
    rojo, mujer = azul).
-   *sistema de coordenadas*: describe el sistema en el que se dibujarán
    las ubicaciones de los geomas.

Es esencial que organices adecuadamente tus datos en un marco de datos
antes de empezar con `ggplot2`. En particular, es importante que
proporcione todos los metadatos apropiados para que su marco de datos
sea auto-descriptivo y sus gráficos sean auto-documentados.

Cuando se construyen gráficos en ggplot2 (en lugar de usar `qplot()`) el
modelo de la “paleta del artista” puede ser la analogía más cercana.
Esencialmente, se comienza con algunos datos en bruto, y luego se añaden
gradualmente trozos para crear un gráfico. Los gráficos se construyen en
capas, con el orden típico de

1.  Trazar los datos
2.  Superponer un resumen
3.  Añadir metadatos y anotaciones

Para los gráficos exploratorios rápidos, es posible que no pase del paso
1.

## Ejemplo: IMC, PM2.5, Asma

Para demostrar las diversas piezas de `ggplot2` utilizaremos un ejemplo
de ejecución del Estudio de Cohorte de Alérgenos y Asma en Ratones
(MAACS), que fue descrito en el capítulo anterior. Aquí, la pregunta que
nos interesa es

> “¿Son los individuos con sobrepeso, medido por el índice de masa
> corporal (IMC), más susceptibles que los individuos de peso normal a
> los efectos nocivos de las PM2,5 sobre los síntomas del asma?”

Existe la sugerencia de que los individuos con sobrepeso pueden ser más
susceptibles a los efectos negativos de la inhalación de PM2,5. Esto
sugeriría que el aumento de la exposición a las PM2,5 en el hogar de un
niño con sobrepeso sería más perjudicial para sus síntomas de asma que
en el hogar de un niño de peso normal. Queremos ver si podemos ver esa
diferencia en los datos de MAACS.

NOTA: Debido a que los datos a nivel individual para este estudio están
protegidos por varias leyes de privacidad de los Estados Unidos, no
podemos hacer que esos datos estén disponibles. Para los fines de este
capítulo, hemos simulado datos que comparten muchas de las
características de los datos originales, pero no contienen ninguna de
las mediciones o valores reales contenidos en el conjunto de datos
original.

Podemos ver los datos rápidamente con `str()`.

``` r
file <-  ("https://raw.githubusercontent.com/rdpeng/artofdatascience/master/manuscript/data/bmi_pm25_no2_sim.csv")
download.file(file, "./data/bmi_pm25_no2_sim.csv")
maacs <- read.csv("./data/bmi_pm25_no2_sim.csv")
str(maacs)
```

    ## 'data.frame':    517 obs. of  4 variables:
    ##  $ logpm25       : num  1.248 1.122 1.93 1.368 0.775 ...
    ##  $ logno2_new    : num  1.184 1.552 1.432 1.774 0.765 ...
    ##  $ bmicat        : chr  "normal weight" "overweight" "normal weight" "overweight" ...
    ##  $ NocturnalSympt: int  1 0 0 2 0 0 0 0 0 3 ...

El resultado que veremos aquí, `NocturnalSymp`, es el número de días en
las últimas 2 semanas en que el niño experimentó síntomas de asma (por
ejemplo, tos, sibilancias) mientras dormía.

## Construyendo en capas

Primero podemos crear un objeto `ggplot` que almacena el conjunto de
datos y la estética básica para mapear las coordenadas x e y para el
gráfico. Aquí vamos a trazar el registro de PM2.5 y la variable
`NocturnalSymp`.

``` r
head(maacs)
```

    ##     logpm25 logno2_new        bmicat NocturnalSympt
    ## 1 1.2476997  1.1837987 normal weight              1
    ## 2 1.1216476  1.5515362    overweight              0
    ## 3 1.9300429  1.4323519 normal weight              0
    ## 4 1.3679246  1.7736804    overweight              2
    ## 5 0.7753367  0.7654826 normal weight              0
    ## 6 1.4872785  1.1127378 normal weight              0

``` r
g <- ggplot(maacs, aes(logpm25, NocturnalSympt))
summary(g)
```

    ## data: logpm25, logno2_new, bmicat, NocturnalSympt [517x4]
    ## mapping:  x = ~logpm25, y = ~NocturnalSympt
    ## faceting: <ggproto object: Class FacetNull, Facet, gg>
    ##     compute_layout: function
    ##     draw_back: function
    ##     draw_front: function
    ##     draw_labels: function
    ##     draw_panels: function
    ##     finish_data: function
    ##     init_scales: function
    ##     map_data: function
    ##     params: list
    ##     setup_data: function
    ##     setup_params: function
    ##     shrink: TRUE
    ##     train_scales: function
    ##     vars: function
    ##     super:  <ggproto object: Class FacetNull, Facet, gg>

``` r
class(g)
```

    ## [1] "gg"     "ggplot"

Puedes ver arriba que el objeto `g` contiene el conjunto de datos
`maacs` y los mapeos.

Ahora, normalmente si se imprime un objeto `ggplot`, aparecerá un
gráfico en el dispositivo, sin embargo, nuestro objeto `g` no contiene
suficiente información para hacer un gráfico.

``` r
g <- ggplot(maacs, aes(logpm25, NocturnalSympt))
summary(g)
```

    ## data: logpm25, logno2_new, bmicat, NocturnalSympt [517x4]
    ## mapping:  x = ~logpm25, y = ~NocturnalSympt
    ## faceting: <ggproto object: Class FacetNull, Facet, gg>
    ##     compute_layout: function
    ##     draw_back: function
    ##     draw_front: function
    ##     draw_labels: function
    ##     draw_panels: function
    ##     finish_data: function
    ##     init_scales: function
    ##     map_data: function
    ##     params: list
    ##     setup_data: function
    ##     setup_params: function
    ##     shrink: TRUE
    ##     train_scales: function
    ##     vars: function
    ##     super:  <ggproto object: Class FacetNull, Facet, gg>

``` r
print(g)
```

![](02_ggplot2_files/figure-gfm/unnamed-chunk-24-1.png)<!-- -->

## Primer gráfico con capa de puntos

Para hacer un scatterplot necesitamos añadir al menos un *geom*, como
los puntos. Aquí añadimos la función `geom_point()` para crear un
scatterplot tradicional.

``` r
g <- ggplot(maacs, aes(logpm25, NocturnalSympt)) 
g + geom_point() # autoimpresión
```

![](02_ggplot2_files/figure-gfm/Scatterplot%20de%20PM2.5%20y%20días%20con%20síntomas%20nocturnos-1.png)<!-- -->

## Añadir más capas: Smooth

Debido a que los datos parecen bastante ruidosos, podría ser mejor si
añadimos un suavizador en la parte superior de los puntos para ver si
hay una tendencia en los datos con PM2.5.

``` r
g + geom_point() + geom_smooth() 
```

    ## `geom_smooth()` using method = 'loess' and formula 'y ~ x'

![Gráfico de dispersión con
suavizador](02_ggplot2_files/figure-gfm/unnamed-chunk-25-1.png)

El suavizador por defecto es un suavizador de loess, que es flexible y
no paramétrico, pero podría ser demasiado flexible para nuestros
propósitos. Quizás prefiramos una simple línea de regresión lineal para
resaltar cualquier tendencia de primer orden. Podemos hacerlo
especificando `method = "lm"` a `geom_smooth()`.

``` r
g + geom_point() + geom_smooth(method = "lm") 
```

    ## `geom_smooth()` using formula 'y ~ x'

![Gráfico de dispersión con línea de regresión
lineal](02_ggplot2_files/figure-gfm/unnamed-chunk-26-1.png)

Aquí podemos ver que parece haber una ligera tendencia al alza, lo que
sugiere que los niveles más altos de PM2,5 se asocian con un aumento de
los días con síntomas nocturnos.

## Añadir más capas: facets

Dado que nuestra pregunta principal consiste en comparar individuos con
sobrepeso con individuos de peso normal, podemos estratificar el gráfico
de dispersión de las PM2.5 y los síntomas nocturnos mediante la variable
de categoría de IMC (`bmicat`), que indica si un individuo tiene
sobrepeso o no. Para visualizar esto podemos añadir un `facet_grid()`,
que toma un argumento de fórmula. Aquí queremos una fila y dos columnas,
una columna para cada categoría de peso. Así que especificamos `bmicat`
en la parte derecha de la fórmula pasada a `facet_grid()`.

``` r
g + geom_point() + 
        geom_smooth(method = "lm") + 
        facet_grid(. ~ bmicat) 
```

    ## `geom_smooth()` using formula 'y ~ x'

![Diagrama de dispersión de PM2.5 y síntomas nocturnos por categoría de
IMC](02_ggplot2_files/figure-gfm/unnamed-chunk-27-1.png)

Ahora parece claro que la relación entre las PM2.5 y los síntomas
nocturnos es relativamente plana entre los individuos de peso normal,
mientras que la relación aumenta entre los individuos con sobrepeso.
Este gráfico sugiere que los individuos con sobrepeso pueden ser más
susceptibles a los efectos de las PM2.5.

Hay una variedad de anotaciones que puede añadir a un gráfico,
incluyendo diferentes tipos de etiquetas. Puede utilizar `xlab()` para
las etiquetas del eje x, `ylab()` para las etiquetas del eje y, y
`ggtitle()` para especificar los títulos de los gráficos. La función
`labs()` es genérica y puede utilizarse para modificar varios tipos de
etiquetas a la vez.

Para cosas que sólo tienen sentido a nivel global, utilice `theme()`, es
decir, `theme(legend.position = "none")`. Se incluyen dos temas de
apariencia estándar

-   `theme_gray()`: El tema por defecto (fondo gris)
-   `theme_bw()`: Más crudo/plano

## Modificación de las propiedades de los geom

Puedes modificar las propiedades de los geom especificando opciones a
sus respectivas funciones `geom_*`. Por ejemplo, aquí modificamos los
puntos del gráfico de dispersión para que el color sea “azul acero”, el
tamaño sea mayor y la transparencia alfa sea mayor.

``` r
g + geom_point(color = "steelblue", size = 4, alpha = 1/2) 
```

![Modificar el color de los puntos con una
constante](02_ggplot2_files/figure-gfm/unnamed-chunk-28-1.png)

Además de establecer atributos geom específicos a constantes, podemos
mapear la estética a variables. Así, aquí, mapeamos la estética de color
`color` a la variable `bmicat`, por lo que los puntos se colorearán
según los niveles de `bmicat`. Utilizamos la función `aes()` para
indicar esta diferencia con respecto al gráfico anterior.

``` r
g + geom_point(aes(color = bmicat), size = 4, alpha = 1/2)
```

![Mapear el color a una
variable](02_ggplot2_files/figure-gfm/unnamed-chunk-29-1.png)

## Modificación de etiquetas

He aquí un ejemplo de modificación del título y las etiquetas x e y para
hacer el gráfico un poco más informativo.

``` r
g + geom_point(aes(color = bmicat)) + 
        labs(title = "Cohorte MAACS") +  
        labs(x = expression("log " * PM[2.5]), y = "Síntomas nocturnos")
```

![Modificando las etiquetas del
gráfico](02_ggplot2_files/figure-gfm/unnamed-chunk-30-1.png)

## Personalización del Smooth

También podemos personalizar aspectos del suavizado que superponemos a
los puntos con `geom_smooth()`. Aquí cambiamos el tipo de línea y
aumentamos el tamaño respecto al predeterminado. También eliminamos el
error estándar sombreado de la línea.

``` r
g + geom_point(aes(color = bmicat), size = 2, alpha = 1/2) +  
  geom_smooth(size = 4, linetype = 3, method = "lm", se = FALSE)
```

    ## `geom_smooth()` using formula 'y ~ x'

![Personalizar un
suavizador](02_ggplot2_files/figure-gfm/unnamed-chunk-31-1.png)

## Cambiar el tema

El tema por defecto para `ggplot2` utiliza el fondo gris con líneas de
cuadrícula blancas. Si no le parece adecuado, puede utilizar el tema en
blanco y negro usando la función `theme_bw()`. La función `theme_bw()`
también te permite establecer el tipo de letra para el gráfico, en caso
de que no quieras la Helvética por defecto. Aquí cambiamos el tipo de
letra a Times.

``` r
g + geom_point(aes(color = bmicat)) + theme_bw(base_family = "Times")
```

![Modificando el tema de un
gráfico](02_ggplot2_files/figure-gfm/unnamed-chunk-32-1.png)

## Ejemplo más complejo

Ahora tiene la sensación de que los gráficos en el sistema `ggplot2` se
construyen añadiendo sucesivamente componentes al gráfico, empezando por
el conjunto de datos base y quizás un gráfico de dispersión. En esta
sección mostraremos un ejemplo un poco más complicado con una variable
adicional. Ahora, nos plantearemos la siguiente pregunta

> ¿Cómo varía la relación entre las PM2,5 y los síntomas nocturnos según
> la categoría del IMC y el dióxido de nitrógeno (NO2)?

A diferencia de nuestra anterior variable de IMC, el NO2 es continuo,
por lo que necesitamos hacer que el NO2 sea categórico para poder
condicionarlo en el trazado. Para ello podemos utilizar la función
`cut()`. Dividiremos la variable NO2 en terciles.

Primero tenemos que calcular los tertiles con la función `quantile()`.

``` r
cutpoints <- quantile(maacs$logno2_new, seq(0, 1, length = 4), na.rm = TRUE)
```

A continuación, tenemos que dividir la variable original `logno2_new` en
los rangos definidos por los puntos de corte calculados anteriormente.

``` r
maacs$no2tert <- cut(maacs$logno2_new, cutpoints)
```

La variable `not2tert` es ahora una variable factorial categórica que
contiene 3 niveles, indicando los rangos de NO2 (en la escala
logarítmica).

``` r
## Ver los niveles de la variable factorial recién creada
levels(maacs$no2tert)
```

    ## [1] "(0.342,1.23]" "(1.23,1.47]"  "(1.47,2.17]"

El gráfico final muestra la relación entre las PM2.5 y los síntomas
nocturnos por categoría de IMC y tertil de NO2.

``` r
## Configurar ggplot con marco de datos
g <- ggplot(maacs, aes(logpm25, NocturnalSympt))
## Añadir capas
g + geom_point(alpha = 1/3) + 
  facet_wrap(bmicat ~ no2tert, nrow = 2, ncol = 4) + 
  geom_smooth(method="lm", se=FALSE, col="steelblue") + 
  theme_bw(base_family = "Avenir", base_size = 10) + 
  labs(x = expression("log " * PM[2.5])) + 
  labs(y = "Síntomas nocturnos") + 
  labs(title = "Cohorte MAACS")
```

    ## `geom_smooth()` using formula 'y ~ x'

![PM2.5 y síntomas nocturnos por categoría de IMC y tertil de
NO2](02_ggplot2_files/figure-gfm/unnamed-chunk-36-1.png)

## Un breve comentario sobre los límites de los ejes

Una peculiaridad rápida sobre `ggplot2` que me sorprendió cuando empecé
a usar el paquete puede mostrarse en el siguiente ejemplo. Hago muchos
gráficos de series de tiempo y a menudo quiero restringir el rango del
eje Y mientras se siguen trazando todos los datos. En el sistema de
gráficos de base se puede hacer de la siguiente manera.

``` r
testdat <- data.frame(x = 1:100, y = rnorm(100))
testdat[50,2] <- 100 ## ¡Fuera de serie!
plot(testdat$x, testdat$y, type = "l", ylim = c(-3,3))
```

![Gráfico de series temporales con gráficos
base](02_ggplot2_files/figure-gfm/unnamed-chunk-37-1.png)

Aquí he restringido el rango del eje Y para que esté entre -3 y 3,
aunque hay un claro valor atípico en los datos.

Con `ggplot2` la configuración por defecto le dará esto.

``` r
g <- ggplot(testdat, aes(x = x, y = y))
g + geom_line()
```

![Gráfico de series temporales con la configuración por
defecto](02_ggplot2_files/figure-gfm/unnamed-chunk-38-1.png)

Modificando el atributo `ylim()` parecería que se obtiene lo mismo que
con el plot base, pero no es así.

``` r
g + geom_line() + ylim(-3, 3)
```

![Gráfico de series temporales con ylim
modificado](02_ggplot2_files/figure-gfm/unnamed-chunk-39-1.png)

Efectivamente, lo que esto hace es subconjuntar los datos para que sólo
se incluyan las observaciones entre -3 y 3, y luego trazar los datos.

Para graficar los datos sin sub-conjuntarlos primero y aún así obtener
el rango restringido, tienes que hacer lo siguiente.

``` r
g + geom_line() + coord_cartesian(ylim = c(-3, 3))
```

![Gráfico de series temporales con rango restringido en el eje
Y](02_ggplot2_files/figure-gfm/unnamed-chunk-40-1.png)

## Recursos

-   El libro *ggplot2* de Hadley Wickham
-   The *R Graphics Cookbook* por Winston Chang (ejemplos en base plots
    y en ggplot2)
-   Sitio web de ggplot2 (<http://ggplot2.org>)
-   Lista de correo de ggplot2 (<http://goo.gl/OdW3uB>), principalmente
    para desarrolladores