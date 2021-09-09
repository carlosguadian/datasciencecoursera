# FUNCIONES

# Se define la función asignándole un nombre, se definen unos argumentos (datos
# de entrada) y lo que queremos que pase.

# La siguiente función toma dos argumentos (x, y) y los suma.
add2 <- function(x, y) {
  x + y
}

add2(4, 7)

# Esta nos devolverá los números por encima de 10 del vector
above10 <- function(x) {
  use <- x > 10
  x[use]
}

above10(c(11,5,6,7,20,44))

# Calcular la media de cada columna en un data frame
columnmean <- function(y) { # el argumento es el dataframe
  nc <- ncol(y) # calculamos el número de columnas del dataframe
  means <- numeric(nc) # creamos la variable means para inciarla en 0 con numeric
  for(i in 1:nc) { # generarmos un loop 
    means[i] <- mean(y[, i]) # para cada columna "i" calculamos la media y se almacena
  }
  means
}

columnmean(airquality)
