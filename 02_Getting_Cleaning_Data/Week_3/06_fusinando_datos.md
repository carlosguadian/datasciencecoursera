Merging Data
================

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

    ##    id          x           y
    ## 1   1  0.3641890 -0.39138222
    ## 2   2 -0.4088833  2.08921580
    ## 3   3 -0.4757344 -1.17539617
    ## 4   4  1.3801100  0.44529774
    ## 5   5  1.1754359  1.66522258
    ## 6   6 -0.5533974  0.41875117
    ## 7   7 -0.7164030 -1.23533229
    ## 8   8 -1.7369986  0.52821354
    ## 9   9 -1.1662075 -0.16553933
    ## 10 10 -0.2524802  0.05614801

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

    ##    id            x           y           z
    ## 1   3  0.323857794  1.33819826  0.02915999
    ## 2   2 -0.090831487 -0.71843727  0.51764479
    ## 3   8 -0.558043147 -0.13468630  0.42812739
    ## 4   5  0.199359133 -1.00071737  0.57326301
    ## 5  10  1.205614114 -0.70778391 -1.27174914
    ## 6   6 -1.826669256  0.63123598  1.55864032
    ## 7   1  0.005014392 -0.06390949  1.23646752
    ## 8   9 -0.406066104  2.67873501  0.59954380
    ## 9   4  0.389166958 -0.84029188  0.93897502
    ## 10  7  0.657084824 -0.01099920 -0.24433524

------------------------------------------------------------------------

## Más sobre la fusión de datos

-   La página rápida de fusión de datos en R -
    <http://www.statmethods.net/management/merging.html>
-   Información sobre plyr - <http://plyr.had.co.nz/>
-   Tipos de uniones - <http://en.wikipedia.org/wiki/Join_(SQL)>
