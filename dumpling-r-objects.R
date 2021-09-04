#Dumping R Objects

#Es un proceso similar a dput y dget pero dump se aplica a varios objetos

#Creamos dos objetos x, y
x <- "foo"
y <- data.frame(a=1, b="a")


#Obtenemos la estructura de ambos y la guardamos en data.R
dump(c("x","y"), file="data.R")

#Para comprobar borramos x,y de environment
rm(x,y)

#Los volvemos a cargar mediante source del archivo generado antes
source("data.R")

#llamamos a y para comprobar que es el mismo
y

#   a b
# 1 1 a

#llamamos a x para comprobar que es el mismo
x
# [1] "foo"