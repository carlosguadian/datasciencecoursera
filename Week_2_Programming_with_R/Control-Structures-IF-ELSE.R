# CONTROL STRUCTURES

#IF / ELSE
#La estructura básica es la siguiente

# if(<condicion>) {
    ## haz algo
# } else {
    ## haz otra cosa
# }

#Aunque podemos complicarlo aún más con un "else if"

# if(<condicion1>) {
    ## haz algo
# } else if(<condicion2>) {
    ## haz otra cosa
# } else {
    ## haz otra cosa
# }

#Un ejemplo

## Generar un número aleatorio uniforme. El valor de y se establece dependiendo de 
# si x > 3 o no. Esta expresión también puede escribirse de forma diferente, pero 
# equivalente, en R.

x <- runif(1, 0, 10)  

if(x > 3) {
  y <- 10
} else {
  y <- 0
}

# Otra manera de escribirla en R y ser el "if/else" como lo que realmente es, una
# asignación de valor a "y"

y <- if(x > 3) {
  10
} else { 
  0
}
