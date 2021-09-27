# dput-ting R Objects

y <- data.frame(a=1,b="a")

# Utilizando dput obtenemos la estructura del objeto y la podemos guardar para 
# utilizarla posteriormente si lo queremos reconstruir

dput(y)

## structure(list(a = 1, b = structure(1L, .Label = "a", class = "factor")), 
# class = "data.frame", row.names = c(NA, -1L))

# Obtenemos la estructura de y y la guardamos en un archivo R

dput(y, file="y.R")

#Reproducimos de nuevo y en new.y obteniendo con dget la estructura de y.R
new.y <- dget("y.R")

#Comprobamos que new.y es igual que y
new.y
