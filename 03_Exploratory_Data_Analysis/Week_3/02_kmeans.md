K-means Clustering
================

Vea un vídeo de esta lección:

-   [Parte 1](https://youtu.be/QGDuvVRUURA)
-   [Parte 2](https://youtu.be/XRlYz1jfCqs)

El algoritmo de clustering de K-means es otro algoritmo básico en el
análisis de datos de alta dimensión que se remonta a muchas décadas
atrás (para un examen exhaustivo de los algoritmos de clustering,
incluido el algoritmo de K-means, un texto clásico es el libro de John
Hartigan *Clustering Algorithms*).

El enfoque de K-means, como muchos métodos de clustering, es altamente
algorítmico (no se puede resumir en una fórmula) y es iterativo. La idea
básica es que se trata de encontrar los centroides de un número fijo de
clusters de puntos en un espacio de alta dimensión. En dos dimensiones,
se puede imaginar que hay un montón de nubes de puntos en el plano y se
quiere averiguar dónde están los centros de cada una de esas nubes.

Por supuesto, en dos dimensiones, probablemente se podrían mirar los
datos y averiguar con un alto grado de precisión dónde están los centros
de los clusters. ¿Pero qué pasa si los datos están en un espacio de 100
dimensiones? Ahí es donde necesitamos un algoritmo.

El enfoque de K-means es un enfoque de partición, por el que los datos
se dividen en grupos en cada iteración del algoritmo. Uno de los
requisitos es que hay que **pre-especificar cuántos clusters hay**. Por
supuesto, esto puede no saberse de antemano, pero se puede adivinar y
ejecutar el algoritmo de todos modos. Después, puedes cambiar el número
de clusters y ejecutar el algoritmo de nuevo para ver si algo cambia.

El esquema del algoritmo es

1.  Fijar el número de conglomerados en algún número entero mayor o
    igual a 2
2.  Empezar con los “centroides” de cada cluster; inicialmente se puede
    elegir un conjunto aleatorio de puntos como centroides
3.  Asignar los puntos a su centroide más cercano; la pertenencia a un
    cluster corresponde a la asignación del centroide
4.  Reclacule las posiciones de los centroides y repita la operación.

Este enfoque, al igual que la mayoría de los métodos de clustering,
requiere una métrica de distancia definida, un número fijo de clusters y
una estimación inicial de los centros de los clusters. No hay un enfoque
fijo para determinar la configuración inicial de los centroides, pero
muchos algoritmos simplemente seleccionan al azar puntos de datos de su
conjunto de datos como los centroides iniciales.

El algoritmo K-means produce

-   Una estimación final de los centroides de los clusters (es decir,
    sus coordenadas)
-   Una asignación de cada punto a su respectivo cluster

## Ilustración del algoritmo K-means

Utilizaremos un ejemplo con datos simulados para demostrar cómo funciona
el algoritmo K-means. Aquí simulamos algunos datos de tres clusters y
graficamos el conjunto de datos a continuación.

``` r
set.seed(1234)
x <- rnorm(12,mean=rep(1:3,each=4),sd=0.2)
y <- rnorm(12,mean=rep(c(1,2,1),each=4),sd=0.2)
plot(x,y,col="blue",pch=19,cex=2)
text(x+0.05,y+0.05,labels=as.character(1:12))
```

![Simulated dataset](02_kmeans_files/figure-gfm/unnamed-chunk-1-1.png)

Lo primero que tiene que hacer K-means es asignar un conjunto inicial de
centroides. Para este ejemplo, supondremos que hay tres clusters (que
también resulta ser la verdad). Elegiremos tres centroides de forma
arbitraria y los mostraremos en el siguiente gráfico.

``` r
plot(x,y,col="blue",pch=19,cex=2)
text(x+0.05,y+0.05,labels=as.character(1:12))
cx <- c(1,1.8,2.5)
cy <- c(2,1,1.5)
points(cx,cy,col=c("red","orange","purple"),pch=3,cex=2,lwd=2)
```

![Initialize
centroids](02_kmeans_files/figure-gfm/unnamed-chunk-2-1.png)

La siguiente etapa del algoritmo asigna cada punto del conjunto de datos
al centroide más cercano. En el siguiente gráfico, coloreamos cada punto
según el color de su centroide más cercano (rojo, morado o naranja).

``` r
plot(x,y,col="blue",pch=19,cex=2)
cols1 <- c("red","orange","purple")
text(x+0.05,y+0.05,labels=as.character(1:12))
cx <- c(1,1.8,2.5)
cy <- c(2,1,1.5)
points(cx,cy,col=cols1,pch=3,cex=2,lwd=2)
## Find the closest centroid
distTmp <- matrix(NA,nrow=3,ncol=12)
distTmp[1,] <- (x-cx[1])^2 + (y-cy[1])^2
distTmp[2,] <- (x-cx[2])^2 + (y-cy[2])^2
distTmp[3,] <- (x-cx[3])^2 + (y-cy[3])^2
newClust <- apply(distTmp,2,which.min)
points(x,y,pch=19,cex=2,col=cols1[newClust])
```

![Assign points to nearest
centroid](02_kmeans_files/figure-gfm/unnamed-chunk-3-1.png)

Se puede ver que esta agrupación inicial agrupa incorrectamente algunos
puntos que están realmente en el mismo clúster en clústeres separados.
La esperanza es que iterando el algoritmo más veces acabaremos por
converger en la solución correcta.

La siguiente etapa consiste en volver a calcular los centroides
basándose en las nuevas asignaciones de clusters de los puntos de datos.
Los nuevos centroides de los clusters se muestran en el siguiente
gráfico.

``` r
plot(x,y,col="blue",pch=19,cex=2)
cols1 <- c("red","orange","purple")
text(x+0.05,y+0.05,labels=as.character(1:12))
## Find the closest centroid
distTmp <- matrix(NA,nrow=3,ncol=12)
distTmp[1,] <- (x-cx[1])^2 + (y-cy[1])^2
distTmp[2,] <- (x-cx[2])^2 + (y-cy[2])^2
distTmp[3,] <- (x-cx[3])^2 + (y-cy[3])^2
newClust <- apply(distTmp,2,which.min)
points(x,y,pch=19,cex=2,col=cols1[newClust])
newCx <- tapply(x,newClust,mean)
newCy <- tapply(y,newClust,mean)
## Old centroids
cx <- c(1,1.8,2.5)
cy <- c(2,1,1.5)
points(newCx,newCy,col=cols1,pch=3,cex=2,lwd=2)
```

![Re-calculate cluster
centroids](02_kmeans_files/figure-gfm/unnamed-chunk-4-1.png)

Ahora que hemos completado un ciclo completo del algoritmo podemos
continuar y reasignar los puntos a su (nuevo) centroide de cluster más
cercano.

``` r
plot(x,y,col="blue",pch=19,cex=2)
cols1 <- c("red","orange","purple")
text(x+0.05,y+0.05,labels=as.character(1:12))
cx <- c(1,1.8,2.5)
cy <- c(2,1,1.5)
## Find the closest centroid
distTmp <- matrix(NA,nrow=3,ncol=12)
distTmp[1,] <- (x-cx[1])^2 + (y-cy[1])^2
distTmp[2,] <- (x-cx[2])^2 + (y-cy[2])^2
distTmp[3,] <- (x-cx[3])^2 + (y-cy[3])^2
newClust <- apply(distTmp,2,which.min)
newCx <- tapply(x,newClust,mean)
newCy <- tapply(y,newClust,mean)
## Old centroids
points(newCx,newCy,col=cols1,pch=3,cex=2,lwd=2)
## Iteration 2
distTmp <- matrix(NA,nrow=3,ncol=12)
distTmp[1,] <- (x-newCx[1])^2 + (y-newCy[1])^2
distTmp[2,] <- (x-newCx[2])^2 + (y-newCy[2])^2
distTmp[3,] <- (x-newCx[3])^2 + (y-newCy[3])^2
newClust2 <- apply(distTmp,2,which.min)
points(x,y,pch=19,cex=2,col=cols1[newClust2])
```

![Re-assign points to new cluster
centroids](02_kmeans_files/figure-gfm/unnamed-chunk-5-1.png)

Y podemos actualizar las posiciones del centroide una vez más en base a
los puntos reasignados.

``` r
plot(x,y,col="blue",pch=19,cex=2)
cols1 <- c("red","orange","purple")
text(x+0.05,y+0.05,labels=as.character(1:12))
cx <- c(1,1.8,2.5)
cy <- c(2,1,1.5)
## Find the closest centroid
distTmp <- matrix(NA,nrow=3,ncol=12)
distTmp[1,] <- (x-cx[1])^2 + (y-cy[1])^2
distTmp[2,] <- (x-cx[2])^2 + (y-cy[2])^2
distTmp[3,] <- (x-cx[3])^2 + (y-cy[3])^2
newClust <- apply(distTmp,2,which.min)
newCx <- tapply(x,newClust,mean)
newCy <- tapply(y,newClust,mean)
## Iteration 2
distTmp <- matrix(NA,nrow=3,ncol=12)
distTmp[1,] <- (x-newCx[1])^2 + (y-newCy[1])^2
distTmp[2,] <- (x-newCx[2])^2 + (y-newCy[2])^2
distTmp[3,] <- (x-newCx[3])^2 + (y-newCy[3])^2
finalClust <- apply(distTmp,2,which.min)
## Final centroids
finalCx <- tapply(x,finalClust,mean)
finalCy <- tapply(y,finalClust,mean)
points(finalCx,finalCy,col=cols1,pch=3,cex=2,lwd=2)
points(x,y,pch=19,cex=2,col=cols1[finalClust])
```

![Updated centroid
configuration](02_kmeans_files/figure-gfm/unnamed-chunk-6-1.png)

Podemos ver en este último gráfico que las cosas se acercan bastante a
lo que deberían ser. Sólo hay dos puntos púrpuras que han sido asignados
al cluster equivocado.

## Detener el algoritmo

En la práctica, no sabríamos dónde están los clusters reales, así que no
necesariamente sabríamos cuándo estamos cerca de la verdad. Pero en
algún momento nuestro algoritmo tiene que parar, así que ¿cómo decidimos
cuándo dejar de iterar?

En algún momento los centroides de los clusters se estabilizarán y
dejarán de moverse con cada iteración. Puede ver que desde la primera
iteración hasta la segunda, los centroides de los clusters se movieron
mucho. Pero después de la segunda iteración, se movieron menos. Entre
cada iteración podemos llevar la cuenta de la distancia que cada
centroide se mueve de una iteración a la siguiente. Una vez que esta
distancia es relativamente pequeña, podemos detener el algoritmo.

## Usando la función `kmeans()`.

La función `kmeans()` en R implementa el algoritmo K-means y se puede
encontrar en el paquete `stats`, que viene con R y normalmente ya está
cargado cuando se inicia R. Dos parámetros clave que hay que especificar
son `x`, que es una matriz o marco de datos, y `centers` que es un
entero que indica el número de clusters o una matriz que indica las
ubicaciones de los centroides iniciales de los clusters. Los datos deben
ser organizados de manera que cada fila es una observación y cada
columna es una variable o característica de esa observación.

``` r
dataFrame <- data.frame(x,y)
kmeansObj <- kmeans(dataFrame,centers=3)
names(kmeansObj)
```

    ## [1] "cluster"      "centers"      "totss"        "withinss"     "tot.withinss"
    ## [6] "betweenss"    "size"         "iter"         "ifault"

Puedes ver a qué clúster se asignó cada punto de datos mirando el
elemento `cluster` de la lista devuelta por la función `kmeans()`.

``` r
kmeansObj$cluster
```

    ##  [1] 3 1 1 3 2 2 2 2 2 2 2 2

Aquí está un gráfico de la solución de clustering K-means. No es
sorprendente que para este simple conjunto de datos, K-means fue capaz
de identificar la verdadera solución.

![Solución de clustering
K-means](02_kmeans_files/figure-gfm/unnamed-chunk-9-1.png)

## Construir mapas de calor a partir de soluciones K-means

Un mapa de calor o un gráfico de imagen es a veces una forma útil de
visualizar datos de matrices o arreglos. La idea es que cada celda de la
imagen se colorea de forma proporcional al valor del elemento de la
matriz correspondiente. Se necesita un poco de trabajo para conseguir
que esto se vea bien en R, pero el resultado puede ser muy útil,
especialmente para los conjuntos de datos de alta dimensión que se
pueden visualizar utilizando los gráficos simples que hemos utilizado
anteriormente.

En primer lugar, tenemos que encontrar la solución de K-means.

``` r
set.seed(1234)
dataMatrix <- as.matrix(dataFrame)[sample(1:12),]
kmeansObj <- kmeans(dataMatrix,centers=3)
```

A continuación podemos hacer un gráfico de la imagen utilizando los
clusters de K-means.

``` r
par(mfrow=c(1,2))
image(t(dataMatrix)[,nrow(dataMatrix):1],yaxt="n",main = "Datos originales")
image(t(dataMatrix)[,order(kmeansObj$cluster)],yaxt="n", main = "Datos agrupados")
```

![Mapa de calor de la solución de
K-means](02_kmeans_files/figure-gfm/unnamed-chunk-11-1.png)

El gráfico anterior ordena las filas de la matriz/imagen de forma que
todas las filas del mismo cluster se agrupan. Se puede ver esto con la
naturaleza más homogénea de la coloración en la versión agrupada de la
imagen.

## Notas y recursos adicionales

-   [Determinación del número de
    clusters](http://en.wikipedia.org/wiki/Determining_the_number_of_clusters_in_a_data_set)
-   [Video de distancias y clustering de Rafael
    Irizarry](http://www.youtube.com/watch?v=wQhVWUcXM0A)
-   [Elementos de aprendizaje
    estadístico](http://www-stat.stanford.edu/~tibs/ElemStatLearn/)
    Traducido con la versión gratuita del Traductor de DeepL.