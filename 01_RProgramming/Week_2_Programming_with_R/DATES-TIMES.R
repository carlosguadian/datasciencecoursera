# DATES AND TIMES

# Con as.date podemos convertir una cadena de texto en formato fecha
x <- as.Date("1970-01-01")
x

x <- Sys.time()
x
# [1] "2021-09-11 11:55:10 CEST"
# 
# Sys.time devuelve la fecha y hora con la clase POSIXct, es decir el número de 
# segundos que han pasado desde 01-01-1970. Si miramos lo que hay en x
unclass(x)
# [1] 1631354902
# 
# Podemos utilizar la clase POSIXlt para trabajar con fechas y horas
# Con esa clase hay muchos datos que podemos utlizar
p <- as.POSIXlt(x)
names(unclass(p))
#  [1] "sec"    "min"    "hour"   "mday"   "mon"    "year"   "wday"   "yday"   "isdst"  "zone"  
# [11] "gmtoff"
# Podemos llamar un elemento por separado, por ejemplo los segundos
p$sec
# El día de la semana
p$wday

# También se puede utilizar strptime() para convertir una cadena en formato
# fecha y hora si están en diferente formato.
# Para el ejemplo tener en cuenta vueltro idioma local
datestring <- c("Enero 10, 2012 10:40", "Diciembre 9, 2011 9:10")
x <- strptime(datestring, "%b %d, %Y %H:%M")
x
# [1] "2012-01-10 10:40:00 EST" "2011-12-09 09:10:00 EST"
class(x)
# [1] "POSIXlt" "POSIXt"

# Se pueden hacer operaciones con las fechas y horas como ver la diferencia en días
# entre dos fechas
# 
x <- as.Date("2012-01-01")
y <- strptime("9 Enero 2011 11:34:21", "%d %b %Y %H:%M:%S") 
x-y
# Warning: Incompatible methods ("-.Date", "-.POSIXt") for "-"
# Error in x - y: non-numeric argument to binary operator
x <- as.POSIXlt(x) 
x-y
# Time difference of 356.3095 days