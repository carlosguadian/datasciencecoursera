# CONTROL STRUCTURES

# FOR LOOPS

# En R, los bucles for toman una variable interadora y le asignan valores 
# sucesivos de una secuencia o vector. Los bucles for se utilizan más comúnmente 
# para iterar sobre los elementos de un objeto (lista, vector, etc.)

# Este bucle toma la variable i y en cada iteración del bucle le da los valores 
# 1, 2, 3, ..., 10, ejecuta el código dentro de las llaves y luego el bucle sale

for(i in 1:10) {
print(i)
}

# Estos tres tienen un comportamiento similar, demuestra la flexibilidad de R

x <- c("a", "b", "c", "d")

for(i in 1:4) {
  ## Print out each element of 'x'
  print(x[i])  
}

## Generate a sequence based on length of 'x'
for(i in seq_along(x)) {   
  print(x[i])
}

# o sin usar una variable tipo índice
for(letter in x) {
  print(letter)
}

# Para una línea de FOF no son necesarios {}
for(i in 1:4) print(x[i])

# NESTED FOR LOOPS
# Los bucles anidados suelen ser necesarios para las estructuras de datos 
# multidimensionales o jerárquicas

x <- matrix(1:6, 2, 3)

for(i in seq_len(nrow(x))) {
  for(j in seq_len(ncol(x))) {
    print(x[i, j])
  }   
}