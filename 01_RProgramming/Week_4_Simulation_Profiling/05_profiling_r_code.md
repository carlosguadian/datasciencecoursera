Profiling R Code
================
Carlos Guadián

## Porqué mi código va tan lento

R viene con un perfilador para ayudarte a optimizar tu código y mejorar
su rendimiento.

En general, es una mala idea centrarse en la optimización de su código
al principio del desarrollo. Más bien, al principio es mejor centrarse
en traducir tus ideas en código y escribir código que sea coherente y
legible.

El problema es que el código muy optimizado tiende a ser oscuro y
difícil de leer, lo que dificulta su depuración y revisión. Es mejor
eliminar primero todos los errores y luego centrarse en la optimización.

Los principios básicos de la optimización de su código son:

-   Diseñar primero y luego optimizar
-   Recuerde: La optimización prematura es la raíz de todos los males
-   Mide (recoge datos), no adivines.
-   Si vas a ser científico, ¡debes aplicar los mismos principios aquí!

## system.time()

La función system.time() toma una expresión R arbitraria como entrada
(puede estar envuelta en llaves) y devuelve el tiempo necesario para
evaluar la expresión.

La función system.time() calcula el tiempo (en segundos) necesario para
ejecutar una expresión y, si hay un error, da el tiempo transcurrido
hasta que se produjo el error.

La función devuelve un objeto de clase proc\_time que contiene dos
informaciones útiles:

-   tiempo del usuario: tiempo cargado a la(s) CPU(s) para esta
    expresión
-   tiempo transcurrido: tiempo del “reloj de pared”, la cantidad de
    tiempo que pasa para ti mientras estás sentado

Normalmente, el tiempo del usuario y el tiempo transcurrido son
relativamente cercanos, para tareas informáticas directas

El tiempo transcurrido puede ser mayor que el del usuario si la CPU pasa
mucho tiempo esperando.

El tiempo transcurrido puede ser menor que el tiempo del usuario si su
máquina tiene varios núcleos/procesadores (y es capaz de utilizarlos):

-   Las bibliotecas BLAS multihilo (vecLib/Accelerate, ATLAS, ACML, MKL)
    pueden acelerar enormemente los cálculos de álgebra lineal y se
    instalan comúnmente incluso en los sistemas de escritorio en estos
    días.
-   El procesamiento en paralelo realizado a través de algo como el
    paquete parallell puede hacer que el tiempo transcurrido sea menor
    que el del usuario

En este caso elapsed time es superior al del usuario ya que la mayor
parte del tiempo espera por la conexión y no por la ejecución.

``` r
# elapsed time > user time
system.time(readLines("http://www.jhsph.edu"))
```

    ##    user  system elapsed 
    ##   0.030   0.006   4.017

Este caso sería lo contrario, en teoría, con el siguiente ejemplo.
Teóricamente el ordenador debería tomar el cálculo y dividirlo entre
diferentes cores y hacer que el tiempo de usuario casi doble el elapsed
time. Con los resultados que podéis ver, no es así.

``` r
## Elapsed time < user time
hilbert <- function(n) { 
        i <- 1:n
        1 / outer(i - 1, i, "+")
}
x <- hilbert(100)
system.time(svd(x))
```

    ##    user  system elapsed 
    ##   0.003   0.000   0.004

## Timing longer expressions

Se puede calcular el tiempo de expresiones largas incluyéndolas entre
llaves rizadas, aunque si la expresión es muy larga es aconsejable
dividirla, ya que si no, no se sabrá qué parte es el cuello de botella.

``` r
system.time({
        n <- 1000
        r <- numeric(n)
        for(i in 1:n) {
                x <- rnorm(n)
                r[i] <- mean(x)
        }
}) 
```

    ##    user  system elapsed 
    ##   0.106   0.004   0.111

## Rprof()

-   La función Rprof() inicia el perfilador de R. Una vez llamada la
    función tal cual, no se necesitan argumentos, todo lo que se ejecute
    pasará por el perfilador.
-   Para desactivar Rprof() se pasa como argumento NULL &lt;-
    Rprof(NULL)
-   summaryRprof() resume la salida de Rprof(), si no, no es legible.
    Utiliza dos métodos para normalizar los datos:
    -   by.total: divide el tiempo total de ejecución entre cada
        función.
    -   by self: hace lo mismo que “by.total” pero primero resta el
        tiempo pasado en funciones por encima de la función actual en la
        pila de llamadas.
-   No utilizar system.time() y Rprof() juntos.
