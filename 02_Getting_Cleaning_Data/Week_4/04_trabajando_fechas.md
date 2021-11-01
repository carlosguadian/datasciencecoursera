Trabajando con fechas
================

**El sistema trabaja con el sistema de fechas que tengáis en local. Es
decir, si tenéis los meses y los días en español, no os funcionará con
fechas en inglés**

> Por lo tanto si tenemos que trabajar con fechas en inglés deberemos
> cambiar el `locale` al adecuado. Si como yo trabajáis en español,
> seguramente tendréis `es_ES.UTF-8`, así que para trabajar con fechass
> en inglés deberéis definir vuestro `locale`de la siguiente forma
> `Sys.setlocale(locale="en_US.UTF-8")`. Por si necesitáis algún
> `locale`específico con `system("locale -a", intern = TRUE)` tendréis
> la lista completa.

## Inicio sencillo

Vamos a mirar en primer lugar la función date(). Guardamos en d1 el
momento exacto (fehca y hora) y vemos que se guarda como character.

``` r
d1 = date()
d1
```

    ## [1] "Fri Oct 29 13:05:15 2021"

``` r
class(d1)
```

    ## [1] "character"

## Clase de datos “fecha”

Si pedimos Sys.Date() obtenemos la fecha actual del sistema, y en este
caso se guarda como clase de datos “fecha”.

``` r
d2 = Sys.Date()
d2
```

    ## [1] "2021-10-29"

``` r
class(d2)
```

    ## [1] "Date"

## Formateando fechas

-   `%d` = día como número (0-31),
-   `%a` = día de la semana abreviado,
-   `%A` = día de la semana no abreviado,
-   `%m` = mes (00-12),
-   `%b` = mes abreviado,
-   `%B` = mes no abreviado,
-   `%y` = año de dos dígitos,
-   `%Y` = año de cuatro dígitos

Teniendo en cuenta estos operadores con format podemos formatear la
fecha como más nos convenga.

``` r
format(d2,"%a %b %d")
```

    ## [1] "vie oct 29"

``` r
format(d2,"%d %b %Y") #una fecha menos anglosajona...
```

    ## [1] "29 oct 2021"

## Creando fechas

Si tenemos un vector con diferentes fechas como el siguiente, podemos
convertirlas en fecha con as.Date.

``` r
x <- c("1ene1960", "2ene1960", "31mar1960", "30jul1960")
z <- as.Date(x, "%d%b%Y")
z
```

    ## [1] "1960-01-01" "1960-01-02" "1960-03-31" "1960-07-30"

Lo intersante es que a partir de ese momento podemos operar con ellas
sin problemas, por ejemplo calcular la diferencia entre dos fechas.

``` r
z[4] - z[1]
```

    ## Time difference of 211 days

``` r
as.numeric(z[4]-z[1])
```

    ## [1] 211

## Converting to Julian

Podemos saber de la fecha proporcionada por el sistema qué día de la
semana es, qué mes, e incluso el número de días que han pasado desde el
1 de enero de 1970. Esto último es lo que se llama `julian date`.

``` r
weekdays(d2)
```

    ## [1] "viernes"

``` r
months(d2)
```

    ## [1] "octubre"

``` r
julian(d2)
```

    ## [1] 18929
    ## attr(,"origin")
    ## [1] "1970-01-01"

## lubridate()

lubridate() es un paquete específico para trabajar con fechas. Este
paquete nos va a proporcionar una manera muy sencilla de formatear y
convertir fechas.

``` r
library(lubridate)
```

    ## 
    ## Attaching package: 'lubridate'

    ## The following objects are masked from 'package:base':
    ## 
    ##     date, intersect, setdiff, union

``` r
ymd("20140108")
```

    ## [1] "2014-01-08"

``` r
mdy("08/04/2013")
```

    ## [1] "2013-08-04"

``` r
dmy("03-04-2013")
```

    ## [1] "2013-04-03"

<http://www.r-statistics.com/2012/03/do-more-with-dates-and-times-in-r-with-lubridate-1-1-0/>

## Peleando con las horas

Se puede hacer prácticamente lo mismo con las horas que con las fechas.
En este caso se puede definir la zona horaria si es necesario para
calcular diferencias horarias entre diferentes puntos del mundo.

``` r
ymd_hms("2011-08-03 10:15:03")
```

    ## [1] "2011-08-03 10:15:03 UTC"

``` r
ymd_hms("2011-08-03 10:15:03",tz="Europe/Madrid")
```

    ## [1] "2011-08-03 10:15:03 CEST"

``` r
?Sys.timezone
```

<http://www.r-statistics.com/2012/03/do-more-with-dates-and-times-in-r-with-lubridate-1-1-0/>

## Algunas funciones tienen una sintaxis ligeramente diferente

``` r
x = dmy(c("1jan2013", "2jan2013", "31mar2013", "30jul2013"))
wday(x[1])
```

    ## [1] 3

``` r
wday(x[1],label=TRUE)
```

    ## [1] mar
    ## Levels: dom < lun < mar < mié < jue < vie < sáb

## Notas y otros recursos

-   Más información en este bonito tutorial de lubridate
    <http://www.r-statistics.com/2012/03/do-more-with-dates-and-times-in-r-with-lubridate-1-1-0/>
-   La viñeta de lubridate es el mismo contenido
    <http://cran.r-project.org/web/packages/lubridate/vignettes/lubridate.html>
-   En última instancia, usted quiere sus fechas y horas como clase
    “Date” o las clases “POSIXct”, “POSIXlt”. Para más información,
    escriba `?POSIXlt`.
