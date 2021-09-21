# CONTROL STRUCTURES

# WHILE LOOPS

# Los bucles while comienzan probando una condición. Si es verdadera, entonces 
# ejecutan el cuerpo del bucle. Una vez que el cuerpo del bucle se ejecuta, la 
# condición se prueba de nuevo, y así sucesivamente, hasta que la condición es 
# falsa, después de lo cual el bucle sale.

#Por ejemplo, asignamos a count el valor 0 y definimos que mientaras sea menor 
# de 10 se siga ejecutando. Sumará 1 en cada vuelta a count y lo imprimirá.

count <- 0
while(count < 10) {
    print(count)
   count <- count + 1
}

# Si no se escriben bien se pueden generar loops infinitos. Cuidado.

# Se puede poner más de una condición en el test inicial. Siempre se evalúan
# de izquierda a derecha.

z <- 8
set.seed(1)

while(z >= 3 && z <= 10) {
  coin <- rbinom(1, 1, 0.5)
  
  if(coin == 1) {  ## random walk
    z <- z+1
  } else {
    z <- z-1
  } 
}
print(z)
