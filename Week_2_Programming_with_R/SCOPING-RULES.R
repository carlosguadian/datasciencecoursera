# SCOPING RULES (Reglas de alcance)

# SYMBOL BINDING (Vinculación de símbolos)

#Podemos definir una función que se llame igual que una existente, al 
# almacenarse en el entorno global que es al primer sitio dónde va R a buscar
# encontrará la que hemos definido y la utilizará en lugar de la definida en 
# un paquete.

# Es lo que pasa si definimos "lm"

lm <- function(x) { x * x }

# al llamarla tomará la nuestra en lugar de la que hay en "stats"
lm
# function(x) { x * x }”

# Si vemos el orden de búsqueda de los entornos, vemos que GlobalEnv, está antes
# que package:stats
search()
# [1] ".GlobalEnv"        "tools:rstudio"     "package:stats"     "package:graphics" 
# [5] "package:grDevices" "package:utils"     "package:datasets"  "package:methods"  
# [9] "Autoloads"         "package:base"

# si la borramos
rm(lm)

# y la llamamos vemos que trae la función definida en stats yq que no hay otra antes
lm

####################

# LEXICAL SCOPING
# Sin en una función utilizamos para definirla una variable libre, es decir, una
# variable que no se corresponde con un argumento, la buscará en el entorno en el 
# que se ha definido la función.

# Para la siguiente función, "z" sería una variable libre, que habrá que definir 
# fuera de la función para que esta funcione
f <- function(x, y) {
  x^2 + y / z
}

# Si la llamamos si definir "z"
f(3,4)
# Error in f(3, 4) : objeto 'z' no encontrado

# Definimos "z"
z <- 10
# y ahora sí que funciona
f(3, 4)
#  [1] 9.4