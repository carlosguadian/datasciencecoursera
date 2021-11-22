Reducción de la Dimensión
================

Vídeos de esta lección:

-   [Parte 1](https://youtu.be/ts6UQnE6E1U)
-   [Parte 2](https://youtu.be/BSfw0rpyC2g)
-   [Parte 3](https://youtu.be/drNwEvEx3LY)

## Datos matriciales

El aspecto clave de los datos matriciales es que cada elemento de la
matriz es del mismo tipo y representa el mismo tipo de medida. Esto
contrasta con un marco de datos, donde cada columna de un marco de datos
puede ser potencialmente de una clase diferente.

Los datos matriciales tienen algunos métodos estadísticos especiales que
pueden aplicarse a ellos. Una categoría de técnicas de reducción de la
dimensión estadística se llama comúnmente *análisis de componentes
principales* (PCA) o la *descomposición del valor singular* (SVD). Estas
técnicas se aplican generalmente en situaciones en las que las filas de
una matriz representan observaciones de algún tipo y las columnas de la
matriz representan características o variables (pero esto no es en
absoluto un requisito).

En un sentido abstracto, la SVD o el PCA pueden considerarse como una
forma de aproximar una matriz de alta dimensión (es decir, un gran
número de columnas) con unas pocas matrices de baja dimensión. Por lo
tanto, tiene un cierto ángulo de compresión de datos. Vamos a echar un
vistazo a lo que sucede en este capítulo.

Primero, podemos simular algunos datos matriciales. Aquí, simulamos
algunos datos normales al azar en una matriz que tiene 40 filas y 10
columnas.

``` r
set.seed(12345)
dataMatrix <- matrix(rnorm(400), nrow = 40)
image(1:10,1:40,t(dataMatrix)[,nrow(dataMatrix):1])
```

![](03_reduccion_dimension_files/figure-gfm/randomData-1.png)<!-- -->

Cuando nos enfrentamos a datos matriciales, algo rápido y sencillo para
organizar un poco los datos es aplicarles un algoritmo de clustering
jerárquico. Este clustering se puede visualizar con la función
`heatmap()`.

``` r
heatmap(dataMatrix) 
```

![Mapa de calor de los datos de la
matriz](03_reduccion_dimension_files/figure-gfm/unnamed-chunk-1-1.png)

No es sorprendente que no haya ningún patrón interesante, ya que sólo
hemos simulado el ruido aleatorio. Al menos es bueno saber que el
algoritmo de agrupación no va a detectar algo cuando no hay nada.

Pero, ¿y si hubiera un patrón en los datos? ¿Cómo lo descubriríamos?

Simulemos primero algunos datos que sí tienen un patrón. En el código
siguiente, recorremos todas las filas de la matriz y añadimos
aleatoriamente 3 a las últimas 5 columnas de la matriz.

``` r
set.seed(678910)
for(i in 1:40){
        coinFlip <- rbinom(1,size=1,prob=0.5)
        
        ## If coin is heads add a common pattern to that row
        if(coinFlip){
                dataMatrix[i,] <- dataMatrix[i,] + rep(c(0,3),each=5)
        }
}
```

Este es el aspecto de los nuevos datos.

``` r
image(1:10,1:40,t(dataMatrix)[,nrow(dataMatrix):1]) 
```

![Datos de la matriz con un
patrón](03_reduccion_dimension_files/figure-gfm/unnamed-chunk-3-1.png)

Puedes ver que algunas de las filas del lado derecho de la matriz tienen
valores más altos que en el lado izquierdo.

¿Qué ocurre ahora si agrupamos los datos?

``` r
heatmap(dataMatrix)
```

![Datos agrupados con
patrón](03_reduccion_dimension_files/figure-gfm/unnamed-chunk-4-1.png)

Podemos ver en el dendrograma de la parte superior de la matriz (para
las columnas) que las columnas se dividen claramente en dos clusters,
que es lo que esperábamos.

## Patrones en filas y columnas

En general, con los datos de la matriz, puede haber patrones que se
producen a través de las filas y columnas de la matriz. En el ejemplo
anterior, hemos desplazado la media de algunas de las observaciones en
las columnas 5 a 10. Podemos mostrar esto un poco más explícitamente
mirando las medias de las filas y columnas de los datos.

``` r
library(dplyr)
hh <- dist(dataMatrix) %>% hclust
dataMatrixOrdered <- dataMatrix[hh$order,]
par(mfrow=c(1,3))
## Datos completos
image(t(dataMatrixOrdered)[,nrow(dataMatrixOrdered):1])
## Mostrar las medias de las filas
plot(rowMeans(dataMatrixOrdered),40:1,,xlab="Media de fila",ylab="Fila",pch=19)
## Mostrar las medias de las columnas
plot(colMeans(dataMatrixOrdered),xlab="Columna",ylab="Media de la columna",pch=19)
```

![Patrón en filas y
columnas](03_reduccion_dimension_files/figure-gfm/unnamed-chunk-5-1.png)

Sin embargo, puede haber otros patrones más allá de un simple
desplazamiento de la media, por lo que se necesitarán métodos más
sofisticados. Además, puede haber múltiples patrones superpuestos, por
lo que necesitamos un método que pueda desentrañar estos patrones.

## Problema relacionado

He aquí otra forma de formular el problema que presentan los datos
matriciales. Supongamos que tenemos observaciones multivariantes

*X*<sub>1</sub>, …, *X*<sub>*n*</sub>

de modo que cada una de las *n* observaciones tiene *m* características,

*X*<sub>1</sub> = (*X*<sub>11</sub>, …, *X*<sub>1*m*</sub>)

Dada esta configuración, el objetivo es encontrar un nuevo conjunto de
variables/características que no estén correlacionadas y que expliquen
tanta varianza en los datos como sea posible. Dicho de otro modo, si se
pusieran todas estas observaciones multivariadas juntas en una matriz,
encontrar la *mejor* matriz creada con menos variables (menor rango) que
explique los datos originales.

El primer objetivo es de naturaleza *estadística* y el segundo objetivo
quizá se caracterice mejor como una *compresión de datos con pérdida*.

## SVD y PCA

Si *X* es una matriz con cada variable en una columna y cada observación
en una fila, entonces la SVD es una descomposición matricial que
representa *X* como un producto matricial de tres matrices:

*X* = *U**D**V*<sup>′</sup>

donde las columnas de *U* (vectores singulares izquierdos) son
ortogonales, las columnas de *V* (vectores singulares derechos) son
ortogonales y *D* es una matriz diagonal de valores singulares.

El análisis de componentes principales (ACP) es simplemente una
aplicación de la SVD. Los *componentes principales* son iguales a los
valores singulares derechos si primero se escalan los datos restando la
media de las columnas y dividiendo cada columna por su desviación
estándar (esto se puede hacer con la función `scale()`).

## Desempaquetando el SVD: *u* y *v*

La SVD se puede calcular en R utilizando la función `svd()`. Aquí,
escalamos nuestros datos de la matriz original con el patrón en ella y
aplicamos la SVD.

``` r
svd1 <- svd(scale(dataMatrixOrdered))
```

La función `svd()` devuelve una lista que contiene tres componentes
llamados `u`, `d` y `v`. Los componentes `u` y `v` corresponden a las
matrices de los vectores singulares izquierdo y derecho,
respectivamente, mientras que el componente `d` es un vector de valores
singulares, correspondiente a la diagonal de la matriz *D* descrita
anteriormente.

A continuación, trazamos los primeros vectores singulares izquierdo y
derecho junto con los datos originales.

``` r
par(mfrow=c(1,3))
image(t(dataMatrixOrdered)[,nrow(dataMatrixOrdered):1], main = "Original Data")
plot(svd1$u[,1],40:1,ylab="Row",xlab="First left singular vector",pch=19)
plot(svd1$v[,1],xlab="Column",ylab="First right singular vector",pch=19)
```

![Components of
SVD](03_reduccion_dimension_files/figure-gfm/unnamed-chunk-7-1.png)

Se puede ver cómo los primeros vectores singulares izquierdo y derecho
recogen el desplazamiento de la media tanto en las filas como en las
columnas de la matriz.

## SVD para la compresión de datos

Si creyéramos que los primeros vectores singulares izquierdo y derecho,
llamémoslos u1 y v1, captan toda la variación de los datos, entonces
podríamos aproximar la matriz de datos original con

*X* ≈ *u*<sub>1</sub>*v*<sub>1</sub><sup>′</sup>

Así, reduciríamos 400 números en la matriz original a 40 + 10 = 50
números en la matriz comprimida, una reducción de casi el 90% de la
información. Este es el aspecto que tendrían los datos originales y la
aproximación

``` r
## Aproximar los datos originales con el producto 
## producto de los primeros vectores singulares
approx <- with(svd1, outer(u[, 1], v[, 1]))
## Trazar los datos originales y los datos aproximados
par(mfrow = c(1, 2))
image(t(dataMatrixOrdered)[,nrow(dataMatrixOrdered):1], main = "Original Matrix")
image(t(approx)[,nrow(approx):1], main = "Matriz aproximada")
```

![Aproximando una
matriz](03_reduccion_dimension_files/figure-gfm/unnamed-chunk-8-1.png)

Obviamente, las dos matrices no son idénticas, pero la aproximación
parece razonable en este caso. Esto no es sorprendente dado que sólo
había una característica real en los datos originales.

## Componentes de la SVD - Varianza explicada

La interpretación estadística de los valores singulares es en forma de
varianza de los datos explicada por los distintos componentes. Los
valores singulares producidos por el `svd()` están en orden de mayor a
menor y cuando se eleva al cuadrado son proporcionales a la cantidad de
varianza explicada por un vector singular dado.

Para mostrar cómo funciona esto, he aquí un ejemplo muy sencillo.
Primero, simularemos un “conjunto de datos” que sólo toma dos valores, 0
y 1.

``` r
constantMatrix <- dataMatrixOrdered*0
for(i in 1:dim(dataMatrixOrdered)[1]) {
        constantMatrix[i,] <- rep(c(0,1),each=5)
}
```

Luego podemos tomar la SVD de esta matriz y mostrar los valores
singulares así como la proporción de varianza explicada.

``` r
svd1 <- svd(constantMatrix)
par(mfrow=c(1,3))
image(t(constantMatrix)[,nrow(constantMatrix):1],main="Original Data")
plot(svd1$d,xlab="Column",ylab="Singular value",pch=19)
plot(svd1$d^2/sum(svd1$d^2),xlab="Column",ylab="Prop. of variance explained",pch=19)
```

![Variance
explained](03_reduccion_dimension_files/figure-gfm/unnamed-chunk-10-1.png)

Como podemos ver en el gráfico de la derecha, el 100% de la variación en
este “conjunto de datos” puede ser explicado por el primer valor
singular. O bien, toda la variación de este conjunto de datos se produce
en una sola dimensión. Esto está claro porque toda la variación de los
datos se produce a medida que se avanza de izquierda a derecha por las
columnas. Por lo demás, los valores de los datos son constantes.

En el gráfico siguiente, trazamos los valores singulares (izquierda) y
la proporción de la varianza explicada para el conjunto de datos
ligeramente más complejo que habíamos utilizado anteriormente.

``` r
par(mfrow=c(1,2))
svd1 <- svd(scale(dataMatrixOrdered))
plot(svd1$d,xlab="Column",ylab="Singular value",pch=19)
plot(svd1$d^2/sum(svd1$d^2),xlab="Column",ylab="Prop. of variance explained",pch=19)
```

![Variance explained by singular
vectors](03_reduccion_dimension_files/figure-gfm/unnamed-chunk-11-1.png)

Podemos ver que el primer componente explica aproximadamente el 40% de
toda la variación de los datos. En otras palabras, aunque hay 10
dimensiones en los datos, el 40% de la variación de los datos puede
explicarse por una sola dimensión. Eso sugiere que los datos podrían
simplificarse bastante, un fenómeno que observamos en la última sección,
donde parecía que los datos podían aproximarse razonablemente mediante
los primeros vectores singulares izquierdo y derecho.

## Relación con los componentes principales

Como hemos mencionado anteriormente, la SVD tiene una estrecha relación
con el análisis de componentes principales (PCA). PCA se puede aplicar a
los datos llamando a la función `prcomp()` en R. Aquí, mostramos que el
primer vector singular derecho de la SVD es igual al primer vector de
componentes principales devuelto por PCA.

``` r
svd1 <- svd(scale(dataMatrixOrdered))
pca1 <- prcomp(dataMatrixOrdered,scale=TRUE)
plot(pca1$rotation[,1],svd1$v[,1],pch=19,xlab="Principal Component 1",ylab="Right Singular Vector 1")
abline(c(0,1))
```

![Singular vectors and principal
components](03_reduccion_dimension_files/figure-gfm/unnamed-chunk-12-1.png)

El hecho de que se llame a este procedimiento SVD o PCA depende de con
quién se hable. Los estadísticos y la gente con ese tipo de experiencia
normalmente lo llaman PCA, mientras que los ingenieros y los matemáticos
tienden a llamarlo SVD.

## ¿Y si añadimos un segundo patrón?

El seguimiento de un único patrón en una matriz es relativamente
sencillo, pero normalmente habrá múltiples patrones estratificados en
una matriz de datos. Aquí añadimos dos patrones a un conjunto de datos
simulado. Un patrón simplemente añade una constante a las últimas 5
columnas de datos, mientras que el otro patrón añade un patrón
alternativo (cada dos columnas).

``` r
set.seed(678910)
for(i in 1:40){
  coinFlip1 <- rbinom(1,size=1,prob=0.5)
  coinFlip2 <- rbinom(1,size=1,prob=0.5)
  if(coinFlip1) {  ## Pattern 1
    dataMatrix[i,] <- dataMatrix[i,] + rep(c(0,5),each=5)
  }
  if(coinFlip2) {  ## Pattern 2
    dataMatrix[i,] <- dataMatrix[i,] + rep(c(0,5),5)
  }
}
hh <- hclust(dist(dataMatrix))
dataMatrixOrdered <- dataMatrix[hh$order,]
```

Aquí está un gráfico de este nuevo conjunto de datos junto con los dos
patrones diferentes.

``` r
svd2 <- svd(scale(dataMatrixOrdered))
par(mfrow=c(1,3))
image(t(dataMatrixOrdered)[,nrow(dataMatrixOrdered):1], main = "Datos")
plot(rep(c(0,1),each=5),pch=19,xlab="Columna",ylab="Patrón 1", main = "Patrón de bloques")
plot(rep(c(0,1),5),pch=19,xlab="Columna",ylab="Patrón 2", main = "Patrón alterno")
```

![Conjunto de datos con dos
patrones](03_reduccion_dimension_files/figure-gfm/unnamed-chunk-14-1.png)

Ahora, por supuesto, el gráfico anterior muestra la verdad, que en
general no sabremos.

Podemos aplicar el SVD/PCA a esta matriz y ver lo bien que se recogen
los patrones.

``` r
svd2 <- svd(scale(dataMatrixOrdered))
par(mfrow=c(1,3))
image(t(dataMatrixOrdered)[,nrow(dataMatrixOrdered):1])
plot(svd2$v[,1],pch=19,xlab="Columna",ylab="Primer vector singular derecho")
plot(svd2$v[,2],pch=19,xlab="Columna",ylab="Segundo vector singular derecho")
```

![SVD con dos
patrones](03_reduccion_dimension_files/figure-gfm/unnamed-chunk-15-1.png)

Podemos ver que el primer vector singular derecho parece recoger tanto
el patrón de alternancia como el patrón de bloque/paso en los datos. El
segundo vector singular derecho parece recoger un patrón similar.

Cuando miramos la varianza explicada, podemos ver que el primer vector
singular recoge un poco más del 50% de la variación en los datos.

``` r
svd1 <- svd(scale(dataMatrixOrdered))
par(mfrow=c(1,2))
plot(svd1$d,xlab="Column",ylab="Singular value",pch=19)
plot(svd1$d^2/sum(svd1$d^2),xlab="Column",ylab="Percent of variance explained",pch=19)
```

![Variation explained by singular
vectors](03_reduccion_dimension_files/figure-gfm/unnamed-chunk-16-1.png)

## Tratamiento de los valores perdidos

Los valores perdidos son un problema que afecta a cualquier análisis de
datos y el análisis de datos matriciales no es una excepción. La mayoría
de las rutinas SVD y PCA simplemente no pueden aplicarse si hay valores
perdidos en el conjunto de datos. En el caso de que falten datos,
normalmente hay una serie de preguntas que deben hacerse:

-   Determine la razón de los datos que faltan; ¿cuál es el *proceso*
    que ha llevado a que falten los datos?
-   ¿La proporción de valores que faltan es tan alta que invalida
    cualquier tipo de análisis?
-   ¿Existe información en el conjunto de datos que permita
    predecir/inferir los valores de los datos que faltan?

En el siguiente ejemplo, tomamos nuestro conjunto de datos e insertamos
aleatoriamente algunos datos que faltan.

``` r
dataMatrix2 <- dataMatrixOrdered
## Insertar aleatoriamente algunos datos que faltan
dataMatrix2[sample(1:100,size=40,replace=FALSE)] <- NA
```

Si intentamos aplicar la SVD sobre esta matriz no funcionará.

``` r
svd1 <- svd(scale(dataMatrix2))
```

    ## Error in svd(scale(dataMatrix2)): infinite or missing values in 'x'

Como en este caso sabemos que los datos que faltan aparecieron de forma
completamente aleatoria en los datos, tendría sentido intentar imputar
los valores para poder ejecutar la SVD. En este caso, utilizamos el
paquete `impute` para realizar una imputación de k-cercanos de los datos
que faltan. El paquete `impute` está disponible en el [proyecto
Bioconductor](http://bioconductor.org).

[Ayuda para instalar paquetes de
Bioconductor](https://www.bioconductor.org/install/Ye)

``` r
library(impute)
dataMatrix2 <- impute.knn(dataMatrix2)$data
```

Ahora podemos comparar el rendimiento de la SVD en el conjunto de datos
original (sin datos perdidos) y el conjunto de datos imputados. Aquí,
trazamos el primer vector singular derecho.

``` r
svd1 <- svd(scale(dataMatrixOrdered))
svd2 <- svd(scale(dataMatrix2))
par(mfrow=c(1,2))
plot(svd1$v[,1],pch=19,main="Conjunto de datos original")
plot(svd2$v[,1],pch=19,main="Conjunto de datos imputados")
```

![SVD en datos originales e
imputados](03_reduccion_dimension_files/figure-gfm/unnamed-chunk-20-1.png)

Podemos ver que los resultados no son idénticos, pero se acercan
bastante. Evidentemente, el proceso de datos perdidos era bastante
sencillo en este caso y es probable que sea más complejo en otras
situaciones.

## Ejemplo: Datos de la cara

<!-- ## source("myplclust.R") -->

En este ejemplo, utilizamos algunos datos que componen una imagen de una
cara y mostramos cómo se puede utilizar la SVD para producir
aproximaciones variables a este “conjunto de datos”. Aquí están los
datos originales.

``` r
load("data/face.rda")
image(t(faceData)[,nrow(faceData):1])
```

![Datos de la
cara](03_reduccion_dimension_files/figure-gfm/unnamed-chunk-21-1.png)

Si tomamos el SVD y trazamos los valores singulares al cuadrado y
normalizados, podemos ver que los datos pueden ser explicados por sólo
unos pocos vectores singulares, tal vez 4 o 5.

``` r
svd1 <- svd(scale(faceData))
plot(svd1$d^2/sum(svd1$d^2),pch=19,xlab="Singular vector",ylab="Variance explained")
```

![Proportion of variance
explained](03_reduccion_dimension_files/figure-gfm/unnamed-chunk-22-1.png)

Ahora podemos empezar a construir aproximaciones a los datos utilizando
los vectores singulares izquierdo y derecho. Aquí creamos una usando
sólo los primeros vectores singulares izquierdo y derecho.

``` r
## Tenga en cuenta que %*% es la multiplicación de la matriz
# Aquí svd1$d[1] es una constante
approx1 <- svd1$u[,1] %*% t(svd1$v[,1]) * svd1$d[1]
```

También podemos crear unos utilizando 5 y 10 vectores singulares, que
presumiblemente serían mejores aproximaciones.

``` r
# En estos ejemplos necesitamos hacer la matriz diagonal de d
approx5 <- svd1$u[,1:5] %*% diag(svd1$d[1:5])%*% t(svd1$v[,1:5]) 
approx10 <- svd1$u[,1:10] %*% diag(svd1$d[1:10])%*% t(svd1$v[,1:10]) 
```

Ahora podemos trazar cada una de estas aproximaciones junto con los
datos originales.

``` r
par(mfrow=c(1,4))
image(t(approx1)[,nrow(approx1):1], main = "1 vector")
image(t(approx5)[,nrow(approx5):1], main = "5 vectores")
image(t(approx10)[,nrow(approx10):1], main = "10 vectores")
image(t(faceData)[,nrow(faceData):1], main = "Datos originales")
```

![](03_reduccion_dimension_files/figure-gfm/unnamed-chunk-25-1.png)<!-- -->

Aquí, la aproximación usando 1 vector singular es bastante pobre, pero
usando 5 nos acerca bastante a la verdad. El uso de 10 vectores no
parece añadir mucho a las características, tal vez sólo algunos puntos
destacados. Así que 5 vectores singulares es una aproximación razonable
en este caso.

## Notas y recursos adicionales

-   Para PCA/SVD, la escala/unidades de los datos es importante
-   PC’s/SV’s pueden mezclar patrones reales, como vimos en el ejemplo
    con dos patrones superpuestos
-   SVD puede ser computacionalmente intensivo para matrices muy grandes
-   [Análisis avanzado de datos desde un punto de vista
    elemental](http://www.stat.cmu.edu/~cshalizi/ADAfaEPoV/ADAfaEPoV.pdf)
-   [Elementos de aprendizaje
    estadístico](http://www-stat.stanford.edu/~tibs/ElemStatLearn/)
-   Alternativas y variaciones
    -   [Análisis
        factorial](http://en.wikipedia.org/wiki/Factor_analysis)
    -   [Análisis de componentes
        independientes](http://en.wikipedia.org/wiki/Independent_component_analysis)
    -   [Análisis semántico
        latente](http://en.wikipedia.org/wiki/Latent_semantic_analysis)