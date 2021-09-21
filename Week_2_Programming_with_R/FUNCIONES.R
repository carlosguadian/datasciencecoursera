#FUNCIONES

# Las funciones son objetos
# Pueden pasarse por argumentos de otras funciones
# Se pueden anidar

#######################

# Los ARGUMENTOS se pueden usar por nombre o posición

# Todas los siguientes usos del argumento en "sd" son iguales
#Para los datos
mydata <- rnorm(100)
# Para la función
str(sd)
# function (x, na.rm = FALSE)
# Uso similar de "sd"
sd(mydata)
sd(x = mydata)
sd(x = mydata, na.rm = FALSE)
sd(na.rm = FALSE, x = mydata)
sd(na.rm = FALSE, mydata)

# Se puede mezclar la concordancia posicional con la concordancia por nombre. 
# Cuando un argumento es comparado por nombre, es "sacado" de la lista de 
# argumentos y el resto de los argumentos sin nombre son comparados en el orden 
# en que están listados en la definición de la función.

# Si miramos los argumentos de "lm"
args(lm)
# function (formula, data, subset, weights, na.action, method = "qr", 
#           model = TRUE, x = FALSE, y = FALSE, qr = TRUE, singular.ok = TRUE, 
#           contrasts = NULL, offset, ...)

# Las siguientes dos llamadas son similares
lm(data = mydata, y ~ x, model = FALSE, 1:100)
lm(y ~ x, mydata, 1:100, model = FALSE)

# El orden de las operaciones cuando se da un argumento es:
#
# Comprobar la coincidencia exacta de un argumento con nombre
# Buscar una coincidencia parcial
# Buscar una coincidencia posicional

#######################

# DEFINIR una función
# En la siguiente función el argumento "a" no está definido, pero , b y c sí.
# Se pueden definir los argumentos o no.

f <- function(a, b = 1, c = 2, d = NULL) {
  
}

#######################

# EVALUACIÓN TARDÍA
# Los argumentos son evaluados sólo si se necesitan
# Por ejemplo en la siguiente función "b" no se utiliza, por lo tanto no se 
# necesita definir
f <- function(a, b) {
  a^2
}
# Al llamar la función con sólo un argumento, no da error
f(2)

# Otro ejemplo, aunque este da error
f <- function(a, b) {
    print(a)
    print(b)
}
# Al llamar la función sólo con "a". Imprime "a" y entonces al ir a evaluar "b"
# se encuentra que no está y da error.
f(45)

#######################

# EL ARGUMENTO "..."

# Existe un argumento especial en R conocido como argumento ..., que indica un 
# número variable de argumentos que se suelen pasar a otras funciones. El 
# argumento ... se suele utilizar cuando se extiende otra función y no se quiere 
# copiar toda la lista de argumentos de la función original

# Si queremos modificar la función "plot" y crear una propia que siempre utilice
# líneas lo haremos de la siguiente manera. Definimos "x", "y" y "type", el resto
# lo llamamos con "..." de la función original.

myplot <- function(x, y, type = "1", ...) {
  plot(x, y, type, ...)
}

# También se utiliza para pasar argumentos como métodos
mean
# function (x, ...) 
#   UseMethod("mean")
# <bytecode: 0x7fa0c6ea7a58>
#   <environment: namespace:base>

# O cuando los argumentos se desconocen de antemano. Por ejemplo con "paste" o 
# "cat" que imprimen caracteres desconocidos previamente.
args(paste)
# function (..., sep = " ", collapse = NULL, recycle0 = FALSE)
args(cat)
# function (..., file = "", sep = " ", fill = FALSE, labels = NULL, append = FALSE) 

#######################

# LOS ARGUMENTOS TRAS "..."

# Deben llamarse por completo, no por correspondencia parcial

# Para
args(paste)
# function (..., sep = " ", collapse = NULL, recycle0 = FALSE)

paste("a","b", sep = ":")

# Si no llamamos "sep" de manera completa, no actuará como tal
paste("a","b", se = ":")
