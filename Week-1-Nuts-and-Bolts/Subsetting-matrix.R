#Subsetting a Matrix
#Se puede hace subsetting en una matriz utilizando los índices (i,j)
x <- matrix(1:6, 2,3)
x
# [,1] [,2] [,3]
# [1,]    1    3    5
# [2,]    2    4    6

#Por lo tanto si queremos el segundo elemento de la primera fila
x[1,2]
#[1] 3

#O el primer elemento de la segunda fila
x[2,1]
#[1] 2

#Para obtener una fila o una columna completa, podemos omitir un índice
#Obtener la primera fila
x[1, ]
#[1] 1 3 5

#Obtener la segunda fila
x[ ,2]
#[1] 3 4

#Por defecto al obtener un elemento de una matriz se obtiene un vector de longitud 1
#Si se quiere obtener una matriz hay que añadir drop=FALSE
#Obtener el vector de longitud 1
X[1,2]
#[1] 3

#Obtener la matriz
x[1,2, drop=FALSE]
#      [,1]
# [1,]    3

#Pasa exactamente lo mismo al querer una fila o columna
#Vector
x[1, ]
#[1] 1 3 5

#Matriz
x[1, , drop=FALSE]
#     [,1] [,2] [,3]
# [1,]    1    3    5