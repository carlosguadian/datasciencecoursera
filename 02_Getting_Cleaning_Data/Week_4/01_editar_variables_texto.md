Editando Variables de Texto
================

## Example - Baltimore camera data

Los archivos originales utilizados en el vídeo de Coursera ya no están
disponibles.

Para utilizar los datos del vídeo se utilizan los archivos que Roger D.
Peng tiene en
<https://github.com/DataScienceSpecialization/courses/tree/master/03_GettingData/04_01_editingTextVariables/data>

## tolower(), toupper()

En ocasiones es conveniente que los nombres de variables tengan un
formato consistente. Ayuda a escribirlos, utilizarlos…

Una transformación interesante es tolower() que los convierte todos en
minúsculas. Y evidentemente la versión contraria, pasarlos a mayúsculas
es toupper()

``` r
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://raw.githubusercontent.com/DataScienceSpecialization/courses/master/03_GettingData/04_01_editingTextVariables/data/cameras.csv"
download.file(fileUrl,destfile="./data/cameras.csv",method="curl")
cameraData <- read.csv("./data/cameras.csv")
names(cameraData)
```

    ## [1] "address"      "direction"    "street"       "crossStreet"  "intersection"
    ## [6] "Location.1"

``` r
tolower(names(cameraData))
```

    ## [1] "address"      "direction"    "street"       "crossstreet"  "intersection"
    ## [6] "location.1"

``` r
toupper(names(cameraData))
```

    ## [1] "ADDRESS"      "DIRECTION"    "STREET"       "CROSSSTREET"  "INTERSECTION"
    ## [6] "LOCATION.1"

## strsplit()

-   Bueno para dividir automáticamente los nombres de las variables
-   Parámetros importantes: *x*, *split*

``` r
splitNames = strsplit(names(cameraData),"\\.")
splitNames[[5]]
```

    ## [1] "intersection"

``` r
splitNames[[6]]
```

    ## [1] "Location" "1"

## Quick aside - lists

``` r
mylist <- list(letters = c("A", "b", "c"), numbers = 1:3, matrix(1:25, ncol = 5))
head(mylist)
```

    ## $letters
    ## [1] "A" "b" "c"
    ## 
    ## $numbers
    ## [1] 1 2 3
    ## 
    ## [[3]]
    ##      [,1] [,2] [,3] [,4] [,5]
    ## [1,]    1    6   11   16   21
    ## [2,]    2    7   12   17   22
    ## [3,]    3    8   13   18   23
    ## [4,]    4    9   14   19   24
    ## [5,]    5   10   15   20   25

<http://www.biostat.jhsph.edu/~ajaffe/lec_winterR/Lecture%203.pdf>

``` r
mylist[1]
```

    ## $letters
    ## [1] "A" "b" "c"

``` r
mylist$letters
```

    ## [1] "A" "b" "c"

``` r
mylist[[1]]
```

    ## [1] "A" "b" "c"

<http://www.biostat.jhsph.edu/~ajaffe/lec_winterR/Lecture%203.pdf>

## sapply()

-   Aplica una función a cada elemento de un vector o lista
-   Parámetros importantes: *X*,*FUN*

``` r
splitNames[[6]][1]
```

    ## [1] "Location"

``` r
firstElement <- function(x){x[1]}
sapply(splitNames,firstElement)
```

    ## [1] "address"      "direction"    "street"       "crossStreet"  "intersection"
    ## [6] "Location"

------------------------------------------------------------------------

## Peer review experiment data

<http://www.plosone.org/article/info:doi/10.1371/journal.pone.0026895>

## Peer review data

``` r
fileUrl1 <- "https://raw.githubusercontent.com/DataScienceSpecialization/courses/master/03_GettingData/04_01_editingTextVariables/data/reviews.csv"
fileUrl2 <- "https://raw.githubusercontent.com/DataScienceSpecialization/courses/master/03_GettingData/04_01_editingTextVariables/data/solutions.csv"
download.file(fileUrl1,destfile="./data/reviews.csv",method="curl")
download.file(fileUrl2,destfile="./data/solutions.csv",method="curl")
reviews <- read.csv("./data/reviews.csv"); solutions <- read.csv("./data/solutions.csv")
head(reviews,2)
```

    ##   id solution_id reviewer_id      start       stop time_left accept
    ## 1  1           3          27 1304095698 1304095758      1754      1
    ## 2  2           4          22 1304095188 1304095206      2306      1

``` r
head(solutions,2)
```

    ##   id problem_id subject_id      start       stop time_left answer
    ## 1  1        156         29 1304095119 1304095169      2343      B
    ## 2  2        269         25 1304095119 1304095183      2329      C

## sub()

-   Parámetros importantes: *pattern*, *replacement*, *x*

``` r
names(reviews)
```

    ## [1] "id"          "solution_id" "reviewer_id" "start"       "stop"       
    ## [6] "time_left"   "accept"

``` r
sub("_","",names(reviews),)
```

    ## [1] "id"         "solutionid" "reviewerid" "start"      "stop"      
    ## [6] "timeleft"   "accept"

------------------------------------------------------------------------

## gsub()

``` r
testName <- "this_is_a_test"
sub("_","",testName)
```

    ## [1] "thisis_a_test"

``` r
gsub("_","",testName)
```

    ## [1] "thisisatest"

## Encontrar valores - grep(),grepl()

``` r
grep("Alameda",cameraData$intersection)
```

    ## [1]  4  5 36

``` r
table(grepl("Alameda",cameraData$intersection))
```

    ## 
    ## FALSE  TRUE 
    ##    77     3

``` r
cameraData2 <- cameraData[!grepl("Alameda",cameraData$intersection),]
```

## Más sobre grep()

``` r
grep("Alameda",cameraData$intersection,value=TRUE)
```

    ## [1] "The Alameda  & 33rd St"   "E 33rd  & The Alameda"   
    ## [3] "Harford \n & The Alameda"

``` r
grep("JeffStreet",cameraData$intersection)
```

    ## integer(0)

``` r
length(grep("JeffStreet",cameraData$intersection))
```

    ## [1] 0

<http://www.biostat.jhsph.edu/~ajaffe/lec_winterR/Lecture%203.pdf>

------------------------------------------------------------------------

## Más funciones de cadena útiles

``` r
library(stringr)
nchar("Jeffrey Leek")
```

    ## [1] 12

``` r
substr("Jeffrey Leek",1,7)
```

    ## [1] "Jeffrey"

``` r
paste("Jeffrey","Leek")
```

    ## [1] "Jeffrey Leek"

``` r
paste0("Jeffrey","Leek")
```

    ## [1] "JeffreyLeek"

``` r
str_trim("Jeff      ")
```

    ## [1] "Jeff"

## Puntos importantes sobre el texto en los conjuntos de datos

-   Los nombres de las variables deben ser
    -   Todos en minúsculas cuando sea posible
    -   Descriptivos (Diagnóstico frente a Dx)
    -   No estar duplicados
    -   No tener guiones bajos ni puntos ni espacios en blanco
-   Variables con valores de carácter
    -   Generalmente deben convertirse en variables factoriales (depende
        de la aplicación)
    -   Deben ser descriptivas (utilizar TRUE/FALSE en lugar de 0/1 y
        Male/Female frente a 0/1 o M/F)
