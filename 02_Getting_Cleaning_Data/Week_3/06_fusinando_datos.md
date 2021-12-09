Merging Data
================

-   [Fusionando datos](#fusionando-datos)
-   [Revisión por pares de los datos del
    experimento](#revisión-por-pares-de-los-datos-del-experimento)
-   [Datos de la revisión por pares](#datos-de-la-revisión-por-pares)
-   [Fusión de datos - merge()](#fusión-de-datos---merge)
-   [Fusión de datos - merge()](#fusión-de-datos---merge-1)
-   [Por defecto: fusionar todos los nombres de columnas
    comunes](#por-defecto-fusionar-todos-los-nombres-de-columnas-comunes)
-   [Usando join en el paquete plyr](#usando-join-en-el-paquete-plyr)
-   [Si tienes múltiples dataframes](#si-tienes-múltiples-dataframes)
-   [Más sobre la fusión de datos](#más-sobre-la-fusión-de-datos)

## Fusionando datos

## Revisión por pares de los datos del experimento

<http://www.plosone.org/article/info:doi/10.1371/journal.pone.0026895>

------------------------------------------------------------------------

## Datos de la revisión por pares

``` r
if(!file.exists("./data")){dir.create("./data")}
fileUrl1 = "https://raw.githubusercontent.com/DataScienceSpecialization/courses/master/03_GettingData/03_05_mergingData/data/reviews.csv"
fileUrl2 = "https://raw.githubusercontent.com/DataScienceSpecialization/courses/master/03_GettingData/03_05_mergingData/data/solutions.csv"
download.file(fileUrl1,destfile="./data/reviews.csv",method="curl")
download.file(fileUrl2,destfile="./data/solutions.csv",method="curl")
reviews = read.csv("./data/reviews.csv"); solutions <- read.csv("./data/solutions.csv")
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

------------------------------------------------------------------------

## Fusión de datos - merge()

-   Fusiona marcos de datos
-   Parámetros importantes: *x*,*y*,*by*,*by.x*,*by.y*,*all*

``` r
names(reviews)
```

    ## [1] "id"          "solution_id" "reviewer_id" "start"       "stop"       
    ## [6] "time_left"   "accept"

``` r
names(solutions)
```

    ## [1] "id"         "problem_id" "subject_id" "start"      "stop"      
    ## [6] "time_left"  "answer"

------------------------------------------------------------------------

## Fusión de datos - merge()

``` r
mergedData = merge(reviews,solutions,by.x="solution_id",by.y="id",all=TRUE)
head(mergedData)
```

    ##   solution_id id reviewer_id    start.x     stop.x time_left.x accept
    ## 1           1  4          26 1304095267 1304095423        2089      1
    ## 2           2  6          29 1304095471 1304095513        1999      1
    ## 3           3  1          27 1304095698 1304095758        1754      1
    ## 4           4  2          22 1304095188 1304095206        2306      1
    ## 5           5  3          28 1304095276 1304095320        2192      1
    ## 6           6 16          22 1304095303 1304095471        2041      1
    ##   problem_id subject_id    start.y     stop.y time_left.y answer
    ## 1        156         29 1304095119 1304095169        2343      B
    ## 2        269         25 1304095119 1304095183        2329      C
    ## 3         34         22 1304095127 1304095146        2366      C
    ## 4         19         23 1304095127 1304095150        2362      D
    ## 5        605         26 1304095127 1304095167        2345      A
    ## 6        384         27 1304095131 1304095270        2242      C

------------------------------------------------------------------------

## Por defecto: fusionar todos los nombres de columnas comunes

``` r
intersect(names(solutions),names(reviews))
```

    ## [1] "id"        "start"     "stop"      "time_left"

``` r
mergedData2 = merge(reviews,solutions,all=TRUE)
head(mergedData2)
```

    ##   id      start       stop time_left solution_id reviewer_id accept problem_id
    ## 1  1 1304095119 1304095169      2343          NA          NA     NA        156
    ## 2  1 1304095698 1304095758      1754           3          27      1         NA
    ## 3  2 1304095119 1304095183      2329          NA          NA     NA        269
    ## 4  2 1304095188 1304095206      2306           4          22      1         NA
    ## 5  3 1304095127 1304095146      2366          NA          NA     NA         34
    ## 6  3 1304095276 1304095320      2192           5          28      1         NA
    ##   subject_id answer
    ## 1         29      B
    ## 2         NA   <NA>
    ## 3         25      C
    ## 4         NA   <NA>
    ## 5         22      C
    ## 6         NA   <NA>

------------------------------------------------------------------------

## Usando join en el paquete plyr

*Más rápido, pero menos completo - por defecto se usa la unión
izquierda, vea el archivo de ayuda para más*.

``` r
library(plyr)
df1 = data.frame(id=sample(1:10),x=rnorm(10))
df2 = data.frame(id=sample(1:10),y=rnorm(10))
arrange(join(df1,df2),id)
```

    ## Joining by: id

    ##    id           x           y
    ## 1   1 -0.01533938  1.20812837
    ## 2   2 -1.09613941 -0.01607775
    ## 3   3  1.87735245 -0.47711115
    ## 4   4  1.48268476 -0.85340137
    ## 5   5  0.19066455 -0.84425359
    ## 6   6  0.07857916  0.92464421
    ## 7   7  1.07880450  0.37655456
    ## 8   8  0.08658486  2.60126169
    ## 9   9 -0.54104507  0.72589895
    ## 10 10 -0.19925867 -0.11435853

------------------------------------------------------------------------

## Si tienes múltiples dataframes

``` r
df1 = data.frame(id=sample(1:10),x=rnorm(10))
df2 = data.frame(id=sample(1:10),y=rnorm(10))
df3 = data.frame(id=sample(1:10),z=rnorm(10))
dfList = list(df1,df2,df3)
join_all(dfList)
```

    ## Joining by: id
    ## Joining by: id

    ##    id           x          y          z
    ## 1   3 -0.11894127 -0.7752276  2.6814561
    ## 2   7  1.47879600 -0.3063724  1.1965471
    ## 3   8  2.08020491  0.3161859 -0.1746784
    ## 4   5 -0.44637412  0.5107962 -1.4814644
    ## 5   6 -1.77354575  1.3411100 -0.4584118
    ## 6   1  1.93708960 -0.1131740 -0.3623242
    ## 7  10  0.22590943 -1.4089806 -0.5368261
    ## 8   2 -0.24548723 -0.2218265 -0.3184267
    ## 9   9  0.06650861  1.0942559  0.4274586
    ## 10  4  2.64866411 -0.6426002  0.1372307

------------------------------------------------------------------------

## Más sobre la fusión de datos

-   La página rápida de fusión de datos en R -
    <http://www.statmethods.net/management/merging.html>
-   Información sobre plyr - <http://plyr.had.co.nz/>
-   Tipos de uniones - <http://en.wikipedia.org/wiki/Join_(SQL)>
