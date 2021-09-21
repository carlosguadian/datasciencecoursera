#Subsetting utilizando coincidencia parcial de los literales

#Es útil cuando los nombres de las variables pueden ser complicados y largos
#Se debe utilizar con cuidado para no entrar en errores

x <- list(aardvark = 1:5)
x$a
#[1] 1 2 3 4 5

#De todas maneras si se utiliza RStudio al escribir la "a" ya sugiere "aardvark" y sólo
#hay que hacer enter para seleccionarlo

#Quitar valores NA

x <- c(1,2, NA,4,NA,5)

#Genereamos un vector lógico con los NA
bad <- is.na(x)
bad
#[1] FALSE FALSE  TRUE FALSE  TRUE FALSE

#Aplicamos el subsetting exluyendo los NA
x[!bad]
#[1] 1 2 4 5

#Si lo que tenemos son diferentes objetos con NA y los queremos límpios podemos
#utilizar complete.cases

x <- c(1,2,NA,4,NA,5)
y <- c("a","b",NA,"d",NA,"f")

#Generamos un vector lógico qu enos dirá que casos de ambos objetos no tienen NA
good <- complete.cases(x,y)
good
#[1]  TRUE  TRUE FALSE  TRUE FALSE  TRUE

#Si aplicamos el subsetting 
x[good]
#[1]  TRUE  TRUE FALSE  TRUE FALSE  TRUE
y[good]
#[1] "a" "b" "d" "f"

#Para quitar NA de data frames también podemos utilizar complete cases
#Por ejemplo para airquality vemos que hay NA en la variable Ozone y Solar.R
airquality[1:6, ]
# Ozone Solar.R Wind Temp Month Day
# 1    41     190  7.4   67     5   1
# 2    36     118  8.0   72     5   2
# 3    12     149 12.6   74     5   3
# 4    18     313 11.5   62     5   4
# 5    NA      NA 14.3   56     5   5
# 6    28      NA 14.9   66     5   6

#Generamos el vector lógico
good <- complete.cases(airquality)
airquality[good, ][1:6, ]
# Ozone Solar.R Wind Temp Month Day
# 1    41     190  7.4   67     5   1
# 2    36     118  8.0   72     5   2
# 3    12     149 12.6   74     5   3
# 4    18     313 11.5   62     5   4
# 7    23     299  8.6   65     5   7
# 8    19      99 13.8   59     5   8