#Para averiguar la clase de cada variable en un archivo grande

#Hacer una lectura de unas pocas líneas, en este caso 100

initial <- read.table("datatable.txt", nrows=100)

# Leer la clase de cada variable y almacenarla

classes <- sapply(initial, class)

#ahora sí, leer el archivo entero aplicando las clases para ahorrar RAM

tabAll <- read.table("datatable.txt", colClasses = classes)