Debugging - Diagnosing
================
Carlos Guadián

## Algo va mal

En R hay cuatro elementos que nos van a avisar que algo no funciona
bien:

-   mensaje": Un mensaje genérico de notificación/diagnóstico producido
    por la función message(); la ejecución de la función continúa
-   advertencia: Una indicación de que algo está mal pero no
    necesariamente fatal; la ejecución de la función continúa. Las
    advertencias son generadas por la función warning()
-   error: Una indicación de que se ha producido un problema fatal y la
    ejecución de la función se detiene. Los errores son producidos por
    la función stop().
-   condición: Un concepto genérico para indicar que ha ocurrido algo
    inesperado; los programadores pueden crear sus propias condiciones
    personalizadas si lo desean.

Un ejemplo de *advertencia*. Nos avisa que que se ha producido un NaN ya
que no se puede obtener un log() de un número negativo. Pero se ejecuta
igualmente ya que igual puede ser intencionado.

``` r
log(-1)
```

    ## Warning in log(-1): Se han producido NaNs

    ## [1] NaN

``` r
printmessage <- function(x) {
        if(x > 0)
                print(paste(x, " is greater than zero"))
        else
                print(paste(x, " is less than or equal to zero"))
        invisible(x)        
}
```

En principio la función está OK. Podemos probar con varios valores y
comprobar que devuelve lo esperado.

``` r
printmessage(4)
```

    ## [1] "4  is greater than zero"

``` r
printmessage(-3)
```

    ## [1] "-3  is less than or equal to zero"

Pero si introducimos un NA como R no sabe que hacer en este caso nos da
un error.

``` r
# printmessage(NA)
# Error in if (x > 0) print(paste(x, " is greater than zero")) else print(paste(x,  : 
#   valor ausente donde TRUE/FALSE es necesario
```

Podemos anticiparnos comprobando si es un NA

``` r
printmessage2 <- function(x) {
        if(is.na(x > 0))
                print(paste(x,"is a missing value"))
        else if(x > 0)
                print(paste(x,"is greater than zero"))
        else
                print(paste(x,"is less than or equal to zero"))
        invisible(x)        
}
```

Si introducimos ahora un NA, por ejemplo el de log(-1) con el que
tenemos una advertencia, ya nos devuelve el mensaje correcto, sin
errores al pasarlo por printmessage2().

``` r
x <- log(-1)
```

    ## Warning in log(-1): Se han producido NaNs

``` r
printmessage2(x)
```

    ## [1] "NaN is a missing value"

Pero si intentamos pasar un vector como argumento, nos volverá a dar un
aviso.

``` r
x <- log(c(-1, 2))
```

    ## Warning in log(c(-1, 2)): Se han producido NaNs

``` r
printmessage2(x)
```

    ## Warning in if (is.na(x > 0)) print(paste(x, "is a missing value")) else if (x
    ## > : la condición tiene longitud > 1 y sólo el primer elemento será usado

    ## [1] "NaN is a missing value"              
    ## [2] "0.693147180559945 is a missing value"

En este caso lo podemos evitar vectorizando la función.

``` r
printmessage3 <- Vectorize(printmessage2)
out <- printmessage3(c(-1, 2))
```

    ## [1] "-1 is less than or equal to zero"
    ## [1] "2 is greater than zero"

## Entender qué ha ido mal

Algunas de las preguntas básicas que hay que hacerse son:

-   ¿Cuál fue su entrada? ¿Cómo llamó a la función?
-   ¿Qué esperaba? ¿Salida, mensajes, otros resultados?
-   ¿Qué has obtenido?
-   ¿En qué se diferencia lo que obtienes de lo que esperabas?
-   ¿Eran correctas tus expectativas en primer lugar?
-   ¿Puedes reproducir el problema (exactamente)?