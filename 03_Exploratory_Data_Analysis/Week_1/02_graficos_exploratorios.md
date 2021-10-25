Gráficos exploratorios
================

# Gráficos exploratorios

Vídeo de esta lección: [Part 1](https://youtu.be/ma6-0PSNLHo) [Part
2](https://youtu.be/UyopqXQ8TTM)

Hay muchas razones para utilizar gráficos o diagramas en el análisis
exploratorio de datos. Si sólo tiene unos pocos puntos de datos, puede
simplemente imprimirlos en la pantalla o en una hoja de papel y
escanearlos rápidamente antes de hacer cualquier análisis real (técnica
que suelo utilizar para pequeños conjuntos o subconjuntos de datos). Si
tiene un conjunto de datos con más de unos pocos puntos de datos,
normalmente necesitará ayuda para visualizar los datos.

La visualización de los datos a través de gráficos puede ser importante
en las primeras etapas del análisis de datos para entender las
propiedades básicas de los datos, para encontrar patrones simples en los
datos y para sugerir posibles estrategias de modelado. En etapas
posteriores de un análisis, los gráficos pueden utilizarse para
“depurar” un análisis, si se produce un resultado inesperado (pero no
necesariamente erróneo) o, en última instancia, para comunicar sus
conclusiones a otras personas.

## Características de los gráficos exploratorios

A efectos de este capítulo (y del resto del libro), distinguiremos entre
gráficos *exploratorios* y gráficos *finales*. Esta distinción no es muy
formal, pero sirve para resaltar el hecho de que los gráficos se
utilizan para muchos propósitos diferentes. Los gráficos exploratorios
suelen hacerse muy rápidamente y muchos de ellos se hacen en el proceso
de comprobación de los datos.

El objetivo de hacer gráficos exploratorios suele ser desarrollar una
comprensión personal de los datos y priorizar las tareas de seguimiento.
Los detalles como la orientación de los ejes o las leyendas, aunque
están presentes, suelen limpiarse y embellecerse si el gráfico se va a
utilizar posteriormente para la comunicación. A menudo se utilizan el
color y el tamaño del símbolo del gráfico para transmitir varias
dimensiones de la información.

## Contaminación del aire en Estados Unidos

En este capítulo, utilizaremos un sencillo estudio de caso para
demostrar los tipos de gráficos simples que pueden ser útiles en los
análisis exploratorios. Los datos que utilizaremos proceden de la
Agencia de Protección del Medio Ambiente de Estados Unidos (EPA), que es
la agencia gubernamental estadounidense que establece [las normas
nacionales de calidad del aire para la contaminación del aire
exterior](http://www.epa.gov/air/criteria.html). Una de las normas
nacionales de calidad del aire ambiente en Estados Unidos se refiere al
nivel medio a largo plazo de contaminación por partículas finas, también
denominado PM2,5. En este caso, la norma dice que la “media anual,
promediada durante 3 años” no puede superar los 12 microgramos por metro
cúbico. Los datos sobre las PM2,5 diarias están disponibles en la página
web de la EPA de EE.UU., o concretamente, en la página web del [Sistema
de Calidad del Aire de la
EPA](http://www.epa.gov/ttn/airs/airsaqs/detaildata/downloadaqsdata.htm).

Una pregunta clave que nos interesa es: \*\*Esta pregunta tiene
consecuencias importantes porque los condados que incumplen las normas
nacionales pueden sufrir graves consecuencias legales. En particular,
los estados que tienen condados que infringen las normas están obligados
a crear un Plan Estatal de Aplicación (SIP) que muestre cómo esos
condados se ajustarán a las normas nacionales dentro de un período de
tiempo determinado.

## Obtención de los datos

En primer lugar, podemos leer los datos en R con `read.csv()`. Este
conjunto de datos contiene la media anual de PM2.5 promediada durante el
período 2008 a 2010

``` r
class <- c("numeric", "character", "factor", "numeric", "numeric")
pollution <- read.csv("data/avgpm25.csv", colClasses = class)
```

Aquí están las primeras filas del marco de datos.

``` r
head(pollution)
```

    ##        pm25  fips region longitude latitude
    ## 1  9.771185 01003   east -87.74826 30.59278
    ## 2  9.993817 01027   east -85.84286 33.26581
    ## 3 10.688618 01033   east -87.72596 34.73148
    ## 4 11.337424 01049   east -85.79892 34.45913
    ## 5 12.119764 01055   east -86.03212 34.01860
    ## 6 10.827805 01069   east -85.35039 31.18973

Cada fila contiene el código de 5 dígitos que indica el condado
(`fips`), la región del país en la que reside el condado, la longitud y
latitud del centroide de ese condado y el nivel medio de PM2,5.

Aquí hay un poco más de información sobre el conjunto de datos, tal y
como la proporciona `str()`.

``` r
str(pollution)
```

    ## 'data.frame':    576 obs. of  5 variables:
    ##  $ pm25     : num  9.77 9.99 10.69 11.34 12.12 ...
    ##  $ fips     : chr  "01003" "01027" "01033" "01049" ...
    ##  $ region   : Factor w/ 2 levels "east","west": 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ longitude: num  -87.7 -85.8 -87.7 -85.8 -86 ...
    ##  $ latitude : num  30.6 33.3 34.7 34.5 34 ...

Pero volvamos a la pregunta. ¿Cómo podemos ver si algún condado supera
la norma de 12 microgramos por metro cúbico?

## Resúmenes sencillos: Una dimensión

Para resumir en una dimensión, hay varias opciones en R.

-   **Resumen de cinco números**: Esto da el mínimo, el percentil 25, la
    mediana, el percentil 75, el máximo de los datos y es una
    comprobación rápida de la distribución de los datos (ver el
    `fivenum()`)

**Boxplots**: Los boxplots son una representación visual del resumen de
cinco números más un poco más de información. En particular, los
boxplots suelen representar los valores atípicos que van más allá del
grueso de los datos. Esto se implementa a través de la función
`boxplot()`.

**Barplot**: Los gráficos de barras son útiles para visualizar datos
categóricos, con el número de entradas para cada categoría siendo
proporcional a la altura de la barra. Piensa en un “gráfico de tarta”
pero realmente útil. El gráfico de barras se puede hacer con la función
`barplot()`.

**Histogramas**: Los histogramas muestran la distribución empírica
completa de los datos, más allá de los cinco puntos de datos mostrados
por los boxplots. Aquí puede comprobar fácilmente la asimetría de los
datos, la simetría, la multimodalidad y otras características. La
función `hist()` hace un histograma, y una función útil para acompañarlo
a veces es la función `rug()`.

**Gráfico de densidad**: La función `density()` calcula una estimación
no paramétrica de la distribución de una variable

## Resumen de cinco números

Se puede calcular un resumen de cinco números con la función
`fivenum()`, que toma un vector de números como entrada. Aquí,
calculamos un resumen de cinco números de los datos de PM2.5 en el
conjunto de datos de contaminación.

``` r
fivenum(pollution$pm25)
```

    ## [1]  3.382626  8.547590 10.046697 11.356829 18.440731

Podemos ver que la mediana de todos los condados del conjunto de datos
es de unos 10 microgramos por metro cúbico.

Para el trabajo interactivo, a menudo es un poco agradable utilizar la
función `summary()`, que tiene un método por defecto para los vectores
numéricos.

``` r
summary(pollution$pm25)
```

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##   3.383   8.549  10.047   9.836  11.356  18.441

Observará que, además del resumen de cinco números, la función
`summary()` también añade la media de los datos, que puede compararse
con la mediana para identificar cualquier asimetría en los datos. Dado
que la media está bastante cerca de la mediana, no parece haber una
cantidad dramática de asimetría en la distribución de PM2.5 en este
conjunto de datos.

## Boxplot

Aquí hay un boxplot rápido de los datos de PM2.5. Ten en cuenta que en
un boxplot, los “bigotes” que sobresalen por encima y por debajo de la
caja tienen una longitud de 1,5 veces el *rango intercuartil*, o IQR,
que es simplemente la distancia desde la parte inferior de la caja hasta
la parte superior de la caja. Todo lo que está más allá de los bigotes
se marca como un “valor atípico” y se traza por separado como un punto
individual.

``` r
boxplot(pollution$pm25, col = "blue")
```

![Boxplot of PM2.5
data](02_graficos_exploratorios_files/figure-gfm/unnamed-chunk-5-1.png)

En el diagrama de caja, podemos ver que hay algunos puntos, tanto en el
extremo superior como en el inferior, que parecen ser valores atípicos
según el algoritmo `boxplot()`. Merece la pena examinar estos puntos
individualmente.

Según el gráfico, parece que los puntos altos están todos por encima del
nivel 15, por lo que podemos examinar esos puntos de datos directamente.
Tenga en cuenta que, aunque la norma nacional de calidad del aire
ambiente actual es de 12 microgramos por metro cúbico, antes era de 15.

``` r
library(dplyr)
filter(pollution, pm25 > 15)
```

    ##       pm25  fips region longitude latitude
    ## 1 16.19452 06019   west -119.9035 36.63837
    ## 2 15.80378 06029   west -118.6833 35.29602
    ## 3 18.44073 06031   west -119.8113 36.15514
    ## 4 16.66180 06037   west -118.2342 34.08851
    ## 5 15.01573 06047   west -120.6741 37.24578
    ## 6 17.42905 06065   west -116.8036 33.78331
    ## 7 16.25190 06099   west -120.9588 37.61380
    ## 8 16.18358 06107   west -119.1661 36.23465

Estos condados están todos en el oeste de EE.UU. (`región == oeste`) y
de hecho están todos en California porque los dos primeros dígitos del
código `fips` son `06`.

Podemos hacer un mapa rápido de estos condados para tener una idea de
dónde están en California.

``` r
library(maps)
map("county", "california")
with(filter(pollution, pm25 > 15), points(longitude, latitude))
```

![Map of California
counties](02_graficos_exploratorios_files/figure-gfm/unnamed-chunk-7-1.png)

En este punto, puede decidir hacer un seguimiento de estos condados, o
ignorarlos si está interesado en otras características. Dado que estos
condados parecen tener niveles muy altos, en relación con la
distribución de los niveles en los otros condados en los EE.UU., puede
valer la pena el seguimiento en si usted está interesado en la
descripción de los condados que son potencialmente en violación de las
normas.

Tenga en cuenta que el gráfico/mapa de arriba no es muy bonito, pero se
hizo rápidamente y nos dio una idea de dónde se encontraban estos
condados periféricos y transmitió suficiente información para ayudar a
decidir si debemos hacer un seguimiento o no.

## Histograma

Un histograma es útil para mirar cuando queremos ver más detalles sobre
la distribución completa de los datos. El boxplot es rápido y práctico,
pero fundamentalmente sólo nos da un poco de información.

Aquí tenemos un histograma de los datos de la media anual de PM2,5.

``` r
hist(pollution$pm25, col = "green")
```

![Histogram of PM2.5
data](02_graficos_exploratorios_files/figure-gfm/unnamed-chunk-8-1.png)

Esta distribución es interesante porque parece haber una alta
concentración de condados en el entorno de los 9 a 12 microgramos por
metro cúbico. Podemos obtener un poco más de detalle si utilizamos la
función `rug()` para mostrarnos los puntos de datos reales.

``` r
hist(pollution$pm25, col = "green")
rug(pollution$pm25)
```

![Histogram of PM2.5 data with
rug](02_graficos_exploratorios_files/figure-gfm/unnamed-chunk-9-1.png)

El gran grupo de puntos de datos en el rango de 9 a 12 no es
sorprendente en este contexto. No es raro observar este comportamiento
en situaciones en las que se impone un límite estricto a un determinado
nivel. Tenga en cuenta que todavía hay bastantes comarcas por encima del
nivel de 12, lo que puede merecer la pena investigar.

La función `hist()` tiene un algoritmo por defecto para determinar el
número de barras a utilizar en el histograma basado en la densidad de
los datos (ver `?nclass.Sturges`). Sin embargo, puede anular la opción
por defecto estableciendo el argumento `breaks` a algo diferente. Aquí,
utilizamos más barras para intentar obtener más detalles.

``` r
hist(pollution$pm25, col = "green", breaks = 100)
rug(pollution$pm25)
```

![Histogram of PM2.5 data with more
breaks](02_graficos_exploratorios_files/figure-gfm/unnamed-chunk-10-1.png)

Ahora vemos que hay un pico bastante grande de 9 microgramos por metro
cúbico. No está inmediatamente claro por qué, pero de nuevo, podría
valer la pena el seguimiento.

## Superposición de características

Una vez que empezamos a ver características interesantes en nuestros
datos, a menudo es útil poner anotaciones en nuestros gráficos como
puntos de referencia. Por ejemplo, en nuestro gráfico de caja anterior,
podríamos dibujar una línea horizontal en el punto 12, donde se
encuentra la norma nacional.

``` r
boxplot(pollution$pm25, col = "blue")
abline(h = 12)
```

![Boxplot of PM2.5 data with added
line](02_graficos_exploratorios_files/figure-gfm/unnamed-chunk-11-1.png)

Podemos ver que una parte razonable de la distribución, tal y como se
muestra en el boxplot, está por encima de la línea (es decir,
potencialmente en violación de la norma).

Aunque el boxplot da una idea, el histograma podría ser más adecuado
para visualizar los datos aquí. En el gráfico siguiente, vemos el
histograma y trazamos dos líneas, una en la mediana de los datos y otra
en 12, el nivel de la norma.

``` r
hist(pollution$pm25, col = "green")
abline(v = 12, lwd = 2)
abline(v = median(pollution$pm25), col = "magenta", lwd = 4)
```

![Histogram of PM2.5 data with
annotation](02_graficos_exploratorios_files/figure-gfm/unnamed-chunk-12-1.png)

Tenga en cuenta que para las líneas verticales, podemos utilizar tanto
el color (`col`) como el ancho de la línea (`lwd`) para indicar
diferentes componentes de la información.

## Diagrama de barras

El gráfico de barras es útil para resumir datos categóricos. Aquí
tenemos una variable categórica, la región en la que reside un condado
(este u oeste). Podemos ver cuántos condados occidentales y orientales
hay con `barplot()`. Usamos la función `table()` para hacer la
tabulación real de cuántos condados hay en cada región.

``` r
library(dplyr)
table(pollution$region) %>% barplot(col = "wheat")
```

![](02_graficos_exploratorios_files/figure-gfm/unnamed-chunk-13-1.png)<!-- -->

Podemos ver claramente que hay muchos más condados en el este de EE.UU.
en este conjunto de datos que en el oeste.

## Resúmenes simples: Dos dimensiones y más allá

Hasta ahora hemos cubierto algunas de las principales herramientas
utilizadas para resumir datos unidimensionales. Para investigar los
datos en dos dimensiones y más allá, existe una serie de herramientas
adicionales. Algunos de los enfoques clave son

**Participaciones múltiples o superpuestas en una dimensión**
(Lattice/ggplot2): El uso de múltiples boxplots o múltiples histogramas
puede ser útil para ver la relación entre dos variables, especialmente
cuando una es naturalmente categórica.

**Los gráficos de dispersión**: Los gráficos de dispersión son la
herramienta natural para visualizar dos variables continuas. Las
transformaciones de las variables (por ejemplo, la transformación
logarítmica o la raíz cuadrada) pueden ser necesarias para una
visualización eficaz.

**Los gráficos de dispersión suaves**: El concepto es similar al de los
gráficos de dispersión, pero se traza un histograma bidimensional de los
datos. Puede ser útil para gráficos de dispersión que pueden contener
muchos puntos de datos.

Para visualizar los datos en más de 2 dimensiones, sin recurrir a las
animaciones 3D (¡o a las gafas!), a menudo podemos combinar las
herramientas que ya hemos aprendido:

-   **Parcelas bidimensionales superpuestas o múltiples; parcelas
    condicionantes (coplots)**: Un gráfico condicionado, o coplot,
    muestra la relación entre dos variables a medida que cambia una
    tercera (o más) variable. Por ejemplo, podría querer ver cómo la
    relación entre los niveles de contaminación del aire y la mortalidad
    cambia con la estación del año. Aquí, la contaminación del aire y la
    mortalidad son las dos variables principales y la estación es la
    tercera variable que varía en el fondo.

-   **Usa el color, el tamaño y la forma para añadir dimensiones**:
    Trazar puntos con diferentes colores o formas es útil para indicar
    una tercera dimensión, donde diferentes colores pueden indicar
    diferentes categorías o rangos de algo. Trazar símbolos con
    diferentes tamaños también puede lograr el mismo efecto cuando la
    tercera dimensión es continua.

**Los gráficos giratorios/interactivos**: Los gráficos giratorios pueden
utilizarse para simular gráficos tridimensionales permitiendo al usuario
pasar rápidamente por diferentes proyecciones bidimensionales para que
el gráfico parezca tridimensional. A veces son útiles para capturar una
estructura inusual en los datos, pero rara vez los utilizo.

**Participaciones reales en 3D (no son tan útiles)**: Los gráficos
reales en 3D (por ejemplo, los que requieren gafas 3D) son relativamente
escasos y poco prácticos para comunicarlos a una gran audiencia. Por
supuesto, esto puede cambiar en el futuro con las mejoras en la
tecnología….

## Boxplots múltiples

Una de las formas más sencillas de mostrar la relación entre dos
variables (en este caso, una categórica y otra continua) es mostrar
gráficos de caja uno al lado del otro. Utilizando los datos de
contaminación descritos anteriormente, podemos mostrar la diferencia en
los niveles de PM2.5 entre las partes oriental y occidental de los
EE.UU. con la función `boxplot()`.

``` r
boxplot(pm25 ~ region, data = pollution, col = "red")
```

![Boxplot of PM2.5 by
region](02_graficos_exploratorios_files/figure-gfm/unnamed-chunk-14-1.png)

La función `boxplot()` puede tomar una *fórmula*, con el lado izquierdo
indicando la variable para la que queremos crear el boxplot (continua) y
el lado derecho indicando la variable que estratifica el lado izquierdo
en categorías. Dado que la variable “región” sólo tiene dos categorías,
acabamos con dos boxplots. Los boxplots de lado a lado son útiles porque
a menudo pueden caber muchos en una página para obtener un sentido rico
de cualquier tendencia o cambio en una variable. Su formato compacto
permite visualizar muchos datos en un espacio reducido.

En el gráfico anterior, podemos ver claramente que los niveles de los
condados del este son, en promedio, más altos que los de los condados
del oeste.

## Histogramas múltiples

A veces puede ser útil trazar múltiples histogramas, al igual que con
los boxplots, para ver los cambios en la forma de la distribución de una
variable en diferentes categorías. Sin embargo, el número de histogramas
que se pueden incluir en una página es limitado.

Esta es la distribución de PM2.5 en las regiones del este y del oeste de
los Estados Unidos.

``` r
par(mfrow = c(2, 1), mar = c(4, 4, 2, 1))
hist(subset(pollution, region == "east")$pm25, col = "green")
hist(subset(pollution, region == "west")$pm25, col = "green")
```

![Histogram of PM2.5 by
region](02_graficos_exploratorios_files/figure-gfm/unnamed-chunk-15-1.png)

Se puede ver aquí que las PM2.5 en el oeste de los Estados Unidos
tienden a ser sesgadas a la derecha con algunos condados periféricos con
niveles muy altos. El PM2.5 en el este tiende a ser sesgado a la
izquierda con algunos condados que tienen niveles muy bajos.

## Gráficos de dispersión

Para las variables continuas, la técnica de visualización más común es
el gráfico de dispersión, que simplemente asigna cada variable a una
coordenada del eje x o y. Aquí se muestra un gráfico de dispersión de la
latitud y las PM2.5, que se puede hacer con la función `plot()`.

``` r
with(pollution, plot(latitude, pm25))
abline(h = 12, lwd = 2, lty = 2)
```

![Scatterplot of PM2.5 and
latitude](02_graficos_exploratorios_files/figure-gfm/unnamed-chunk-16-1.png)

A medida que se avanza de sur a norte en los Estados Unidos, podemos ver
que los niveles más altos de PM2,5 tienden a estar en la región central
del país.

## Gráfico de dispersión - Uso del color

Si quisiéramos añadir una tercera dimensión al gráfico de dispersión
anterior, por ejemplo la variable “región” que indica el este y el
oeste, podríamos utilizar el color para resaltar esa dimensión. Aquí
coloreamos los círculos del gráfico para indicar el este (negro) o el
oeste (rojo).

``` r
with(pollution, plot(latitude, pm25, col = region))
abline(h = 12, lwd = 2, lty = 2)
```

![Scatterplot of PM2.5 and latitude by
region](02_graficos_exploratorios_files/figure-gfm/unnamed-chunk-17-1.png)

Al principio puede resultar confuso averiguar qué color se asigna a cada
región. Podemos averiguarlo mirando directamente los niveles de la
variable `region`.

``` r
levels(pollution$region)
```

    ## [1] "east" "west"

Aquí vemos que el primer nivel es “este” y el segundo nivel es “oeste”.
Así que el color para el “este” se asignará a 1 y el color para el
“oeste” se asignará a 2. Para las funciones de trazado, `col = 1` es
negro (el color por defecto) y `col = 2` es rojo.

## Múltiples gráficos de dispersión

El uso de múltiples gráficos de dispersión puede ser necesario cuando la
superposición de puntos con diferentes colores o formas es confusa (a
veces debido al volumen de datos). Separar los gráficos a veces puede
facilitar la visualización.

``` r
par(mfrow = c(1, 2), mar = c(5, 4, 2, 1))
with(subset(pollution, region == "west"), plot(latitude, pm25, main = "West"))
with(subset(pollution, region == "east"), plot(latitude, pm25, main = "East"))
```

![Multiple Scatterplots of PM2.5 and latitude by
region](02_graficos_exploratorios_files/figure-gfm/unnamed-chunk-19-1.png)

Este tipo de gráficos, a veces llamados gráficos de panel, son
generalmente más fáciles de hacer con el sistema `lattice` o `ggplot2`,
que conoceremos con más detalle en capítulos posteriores..

``` r
## Lattice
library(lattice)
xyplot(pm25 ~ latitude | region, data = pollution)
## ggplot2
library(ggplot2)
qplot(latitude, pm25, data = pollution, facets = . ~ region)
```

## Resumen

Los gráficos exploratorios son “rápidos y sucios” y su propósito es
permitirle resumir los datos y destacar cualquier característica
general. También son útiles para explorar preguntas básicas sobre los
datos y para juzgar la evidencia a favor o en contra de ciertas
hipótesis. En última instancia, pueden ser útiles para sugerir
estrategias de modelización que pueden emplearse en el “siguiente paso”
del proceso de análisis de datos.