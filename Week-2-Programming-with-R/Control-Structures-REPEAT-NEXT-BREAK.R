# CONTROL STRUCTURES

# REPEAT, NEXT, BREAK

# REPEAT
#En ocasiones se necesita iterar un loop "n" veces, aunque no es muy común, 
# para esto se utiliza repeat {}

# No funcionará sin definir computeEstimate()
x0 <- 1
tol <- 1e-8

repeat {
  x1 <- computeEstimate()
  
  if(abs(x1 - x0) < tol) {  ## Close enough?
    break
  } else {
    x0 <- x1
  } 
}

# NEXT
# NEXT se utiliza para escapar de una iteración en un loop
for(i in 1:100) {
  if(i <= 20) {
    ## Skip the first 20 iterations
    next                 
  }
  ## Do something here
}

#BREAK
# Break se utiliza para salir de un loop inmediatamente

for(i in 1:100) {
  print(i)
  
  if(i > 20) {
    ## Stop loop after 20 iterations
    break  
  }		
}