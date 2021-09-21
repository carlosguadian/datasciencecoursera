#Subsetting Básico

#Para un vector de caracteres

x <- c("a","b","c","c","d","a")

#Se puede segmentar por el índice numérico
#Por ejemplo, obtener el primer elemento del vector
x[1]
#[1] "a"

#El segundo
x[2]
#[1] "b"

# Obtener un rango, por ejemplo, del elemento 1 al 4
x[1:4]
#[1] "a" "b" "c" "c"

# También se puede utilizar un índice lógico para obtener los elementos deseados
# Por ejemplo, obtener todos los elementos mayores de "a"
x[x > "a"]
#[1] "b" "c" "c" "d"

# En lugar de utilizarlo diréctamente se puede generar un vector lógico para utilizarlo
# posteriormente
u <- x > "a"
u
#[1] FALSE  TRUE  TRUE  TRUE  TRUE FALSE

#Ahora podemos segmentar utilizando el vector lógico
x[u]
#[1] "b" "c" "c" "d"

