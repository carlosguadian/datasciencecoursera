#Subsetting Lists

#Para obtener elementos de una lista podemos utilizar diferentes métodos
#Se puede utilizar [] utilizando el índice numérico y obtener el elemento de la lista
#un elemento que será de la misma clase, por lo tanto tambien será una lista

# Para la lista
x <- list(foo = 1:4, bar = 0.6)

#Si queremos el primer elemento de la lista
x[1]
#$foo
#[1] 1 2 3 4

#También se acepta el literal
x["foo"]
#$foo
#[1] 1 2 3 4

#También podemos utilizar el [[]] para acceder directamente al contenido del elemento
x[[1]]
#[1] 1 2 3 4

#En el primer ejemplo se obtiene el elemento completo, con su nombre, mientras que en 
#el segundo sólo el contenido de la lista.

#También se puede acceder mediante el símbolo $ y el literal del elemento
x$bar
#[1] 0.6

#Sería un equivalente al [[]]
#Por el literal
x[["bar"]]
#[1] 0.6

#Por el índice numérico
x[[2]]
#[1] 0.6

#Acceder por el literal evita tener que recordar en qué posición del índice está el 
#elemento que queremos obtener.

#Podemos obtener varios elementos de una lista
x <- list(foo = 1:4, bar = 0.6, baz = "hello")

#Tenemos que indicar los elementos que queremos concatenando la elección
x[c(1,3)]
# $foo
# [1] 1 2 3 4
# $baz
# [1] "hello"

#El operador [[]] sólo se puede utilizar con el índice numérico y el $ sólo con literales

#Para extraer elementos anidados en una lista utilizaremos [[]]
x <- list(a=list(10,12,14), b=c(3.14, 2.81))

#Si queremos el número 14, que es el tercer elemento de la primera lista
x[[c(1,3)]]
#[1] 14
x[[1]][[3]]
#[1] 14

