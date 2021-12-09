Resumiendo datos
================
Carlos Guadián

-   [Cargar los datos](#cargar-los-datos)
-   [Un primer vistazo](#un-primer-vistazo)
-   [Quartiles de variables
    cuantitativas](#quartiles-de-variables-cuantitativas)
-   [Tablas como resumen](#tablas-como-resumen)
-   [Comprobar valors perdidos](#comprobar-valors-perdidos)
-   [Encontrar valores con carateríticas
    especiales](#encontrar-valores-con-carateríticas-especiales)
-   [Tabulaciones cruzadas](#tabulaciones-cruzadas)
-   [Tamaño del dataset](#tamaño-del-dataset)

## Cargar los datos

Una vez cargados los datos en R necesitamos dar un primer vistazo para
averiguar si hay algo que no esté bien. Valores perdidos, inconsistencia
en los valores, que no sean del tipo adecuado…

Vamos a descargar el archivo CSV de restaurantes de la ciudad de
Baltimore de la siguiente URL
<https://data.baltimorecity.gov/datasets/restaurants/> . No se puede
hacer descarga directa, pero descargamos y lo llevamos al directorio
data.

Primero comprovamos si existe, si no se crea. Recordar ejecutarlo desde
el “working directory” correcto. Y entonces una vez cargado el CSV en el
directorio cargamos los datos.

``` r
if(!file.exists("./data")){dir.create("./data")}
restData <- read.csv("./data/Restaurants.csv")
```

Lo pasamos a tibble para visualizar mejor resultados

``` r
library(tibble)
restData <- as_tibble(restData)
```

## Un primer vistazo

Una vez cargados vamos a dar un primer vistazo.

``` r
head(restData, n = 3)
```

    ## # A tibble: 3 × 32
    ##           X      Y   fid gis_id srcid_t srcid_i edit_date ftype subtype loc_type
    ##       <dbl>  <dbl> <int> <chr>  <lgl>     <int> <chr>     <int> <lgl>   <chr>   
    ## 1 -8522867. 4.77e6     1 27_1   NA            0 2008/06/…    27 NA      ST      
    ## 2 -8525894. 4.76e6     2 27_2   NA            0 2008/06/…    27 NA      ST      
    ## 3 -8524408. 4.76e6     3 27_3   NA            0 2008/06/…    27 NA      ST      
    ## # … with 22 more variables: loc_meth <chr>, street_tag <dbl>, prcl_pin <chr>,
    ## #   address <chr>, city <chr>, state <chr>, zipcode <chr>, x_coord <dbl>,
    ## #   y_coord <dbl>, name <chr>, alias1 <lgl>, nghbrhd <chr>, cncldst <int>,
    ## #   stfid_blk <dbl>, plcdst_no <int>, plcdst <chr>, usng <chr>,
    ## #   cntct_nme <lgl>, cntct_phn <lgl>, cntct_dpt <lgl>, globalid <chr>,
    ## #   url <lgl>

``` r
tail(restData, n = 3)
```

    ## # A tibble: 3 × 32
    ##           X      Y   fid gis_id srcid_t srcid_i edit_date ftype subtype loc_type
    ##       <dbl>  <dbl> <int> <chr>  <lgl>     <int> <chr>     <int> <lgl>   <chr>   
    ## 1 -8523955. 4.77e6  1325 27_13… NA            0 2008/06/…    27 NA      ST      
    ## 2 -8530782. 4.77e6  1326 27_13… NA            0 2008/06/…    27 NA      ST      
    ## 3 -8522228. 4.76e6  1327 27_13… NA            0 2008/06/…    27 NA      ST      
    ## # … with 22 more variables: loc_meth <chr>, street_tag <dbl>, prcl_pin <chr>,
    ## #   address <chr>, city <chr>, state <chr>, zipcode <chr>, x_coord <dbl>,
    ## #   y_coord <dbl>, name <chr>, alias1 <lgl>, nghbrhd <chr>, cncldst <int>,
    ## #   stfid_blk <dbl>, plcdst_no <int>, plcdst <chr>, usng <chr>,
    ## #   cntct_nme <lgl>, cntct_phn <lgl>, cntct_dpt <lgl>, globalid <chr>,
    ## #   url <lgl>

Para tener una primera idea general también podemos utilizar summary()

``` r
summary(restData)
```

    ##        X                  Y                fid            gis_id         
    ##  Min.   :-8539412   Min.   :4750389   Min.   :   1.0   Length:1327       
    ##  1st Qu.:-8529242   1st Qu.:4762318   1st Qu.: 332.5   Class :character  
    ##  Median :-8528158   Median :4763186   Median : 664.0   Mode  :character  
    ##  Mean   :-8527823   Mean   :4764332   Mean   : 664.0                     
    ##  3rd Qu.:-8525719   3rd Qu.:4766022   3rd Qu.: 995.5                     
    ##  Max.   :-8519297   Max.   :4775096   Max.   :1327.0                     
    ##  srcid_t           srcid_i   edit_date             ftype    subtype       
    ##  Mode:logical   Min.   :0   Length:1327        Min.   :27   Mode:logical  
    ##  NA's:1327      1st Qu.:0   Class :character   1st Qu.:27   NA's:1327     
    ##                 Median :0   Mode  :character   Median :27                 
    ##                 Mean   :0                      Mean   :27                 
    ##                 3rd Qu.:0                      3rd Qu.:27                 
    ##                 Max.   :0                      Max.   :27                 
    ##    loc_type           loc_meth           street_tag        prcl_pin        
    ##  Length:1327        Length:1327        Min.   :9.3e+14   Length:1327       
    ##  Class :character   Class :character   1st Qu.:9.3e+14   Class :character  
    ##  Mode  :character   Mode  :character   Median :9.3e+14   Mode  :character  
    ##                                        Mean   :9.3e+14                     
    ##                                        3rd Qu.:9.3e+14                     
    ##                                        Max.   :9.3e+14                     
    ##    address              city              state             zipcode         
    ##  Length:1327        Length:1327        Length:1327        Length:1327       
    ##  Class :character   Class :character   Class :character   Class :character  
    ##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
    ##                                                                             
    ##                                                                             
    ##                                                                             
    ##     x_coord           y_coord           name            alias1       
    ##  Min.   :1394157   Min.   :558801   Length:1327        Mode:logical  
    ##  1st Qu.:1420033   1st Qu.:588972   Class :character   NA's:1327     
    ##  Median :1422781   Median :591169   Mode  :character                 
    ##  Mean   :1423632   Mean   :594064                                    
    ##  3rd Qu.:1429019   3rd Qu.:598304                                    
    ##  Max.   :1445374   Max.   :621387                                    
    ##    nghbrhd             cncldst         stfid_blk           plcdst_no    
    ##  Length:1327        Min.   : 1.000   Min.   :2.451e+13   Min.   :1.000  
    ##  Class :character   1st Qu.: 2.000   1st Qu.:2.451e+13   1st Qu.:2.000  
    ##  Mode  :character   Median : 9.000   Median :2.451e+14   Median :2.000  
    ##                     Mean   : 7.191   Mean   :1.671e+14   Mean   :3.969  
    ##                     3rd Qu.:11.000   3rd Qu.:2.451e+14   3rd Qu.:6.000  
    ##                     Max.   :14.000   Max.   :2.451e+14   Max.   :9.000  
    ##     plcdst              usng           cntct_nme      cntct_phn     
    ##  Length:1327        Length:1327        Mode:logical   Mode:logical  
    ##  Class :character   Class :character   NA's:1327      NA's:1327     
    ##  Mode  :character   Mode  :character                                
    ##                                                                     
    ##                                                                     
    ##                                                                     
    ##  cntct_dpt        globalid           url         
    ##  Mode:logical   Length:1327        Mode:logical  
    ##  NA's:1327      Class :character   NA's:1327     
    ##                 Mode  :character                 
    ##                                                  
    ##                                                  
    ## 

Con summary vemos un primer resumen y si algunas de las variables tienen
la clase correcta. Por ejemplo restData$name se ha considerado como
“character”, por lo que el sumario no es el adecuado ya que debería ser
considerado como factor, de esa manera obtendriamos el resumen correcto,
una tabla con el conteo de los resturantes.

``` r
restData$name <- as.factor(restData$name)
head(summary(restData$name))
```

    ##                   MCDONALD'S POPEYES FAMOUS FRIED CHICKEN 
    ##                            8                            7 
    ##                       SUBWAY       KENTUCKY FRIED CHICKEN 
    ##                            6                            5 
    ##                  BURGER KING                DUNKIN DONUTS 
    ##                            4                            4

Más allá de summary(), con str() tenemos una información mucho más
detallada del dataset

``` r
str(restData)
```

    ## tibble [1,327 × 32] (S3: tbl_df/tbl/data.frame)
    ##  $ X         : num [1:1327] -8522867 -8525894 -8524408 -8530754 -8533281 ...
    ##  $ Y         : num [1:1327] 4769142 4762539 4762175 4770074 4762363 ...
    ##  $ fid       : int [1:1327] 1 2 3 4 5 6 7 8 9 10 ...
    ##  $ gis_id    : chr [1:1327] "27_1" "27_2" "27_3" "27_4" ...
    ##  $ srcid_t   : logi [1:1327] NA NA NA NA NA NA ...
    ##  $ srcid_i   : int [1:1327] 0 0 0 0 0 0 0 0 0 0 ...
    ##  $ edit_date : chr [1:1327] "2008/06/22 00:00:00+00" "2008/06/22 00:00:00+00" "2008/06/22 00:00:00+00" "2008/06/22 00:00:00+00" ...
    ##  $ ftype     : int [1:1327] 27 27 27 27 27 27 27 27 27 27 ...
    ##  $ subtype   : logi [1:1327] NA NA NA NA NA NA ...
    ##  $ loc_type  : chr [1:1327] "ST" "ST" "ST" "ST" ...
    ##  $ loc_meth  : chr [1:1327] "GC_300" "GC_300" "GC_300" "GC_300" ...
    ##  $ street_tag: num [1:1327] 9.3e+14 9.3e+14 9.3e+14 9.3e+14 9.3e+14 ...
    ##  $ prcl_pin  : chr [1:1327] "5936A004" "1830009" "1878005" "3563006" ...
    ##  $ address   : chr [1:1327] "4509  BELAIR ROAD" "1919  FLEET ST" "2844  HUDSON ST" "3998  ROLAND AVE" ...
    ##  $ city      : chr [1:1327] "Baltimore" "Baltimore" "Baltimore" "Baltimore" ...
    ##  $ state     : chr [1:1327] "MD" "MD" "MD" "MD" ...
    ##  $ zipcode   : chr [1:1327] "21206" "21231" "21224" "21211" ...
    ##  $ x_coord   : num [1:1327] 1436170 1428555 1432338 1416120 1409774 ...
    ##  $ y_coord   : num [1:1327] 606299 589546 588642 608569 589022 ...
    ##  $ name      : Factor w/ 1277 levels "#1 CHINESE KITCHEN",..: 9 3 992 1 2 4 5 6 7 8 ...
    ##  $ alias1    : logi [1:1327] NA NA NA NA NA NA ...
    ##  $ nghbrhd   : chr [1:1327] "Frankford" "Fells Point" "Canton" "Hampden" ...
    ##  $ cncldst   : int [1:1327] 2 1 1 14 9 14 13 7 13 1 ...
    ##  $ stfid_blk : num [1:1327] 2.45e+14 2.45e+13 2.45e+13 2.45e+14 2.45e+14 ...
    ##  $ plcdst_no : int [1:1327] 4 2 2 5 8 4 2 5 2 2 ...
    ##  $ plcdst    : chr [1:1327] "NORTHEASTERN" "SOUTHEASTERN" "SOUTHEASTERN" "NORTHERN" ...
    ##  $ usng      : chr [1:1327] "18S UJ 65353 54630" "18S UJ 62920 49577" "18S UJ 64067 49276" "18S UJ 59260 55457" ...
    ##  $ cntct_nme : logi [1:1327] NA NA NA NA NA NA ...
    ##  $ cntct_phn : logi [1:1327] NA NA NA NA NA NA ...
    ##  $ cntct_dpt : logi [1:1327] NA NA NA NA NA NA ...
    ##  $ globalid  : chr [1:1327] "{B539CABF-622F-4C6E-9AE2-5C648EBBA530}" "{319B2500-6082-4DD9-A866-66308527E3B2}" "{57842273-D14B-4D28-A810-A645F018BED4}" "{2701DA61-1457-496D-8743-A80949B80232}" ...
    ##  $ url       : logi [1:1327] NA NA NA NA NA NA ...

Y como con la variable “name” podemos ver que hay que cambiar algunas
clases para poder trabajar correctamente con ellas. Por ejemplo zipcode
es characer y debería ser factor, como nghbrhd que es character y
debería ser factor, etc.

``` r
restData$nghbrhd <- as.factor(restData$nghbrhd)
head(summary(restData$nghbrhd))
```

    ##     Downtown  Fells Point Inner Harbor       Canton Federal Hill Mount Vernon 
    ##          128           91           89           81           42           33

``` r
restData$zipcode <- as.factor(restData$zipcode)
head(summary(restData$zipcode))
```

    ## 21201 21202 21205 21206 21207 21208 
    ##   136   201    27    30     4     1

## Quartiles de variables cuantitativas

Podemos utilizar quantiles para ver la variabilidad de las variables
cuantitativas.

``` r
quantile(restData$cncldst, na.rm = TRUE)
```

    ##   0%  25%  50%  75% 100% 
    ##    1    2    9   11   14

``` r
quantile(restData$cncldst, probs = c(0.5, 0.75, 0.9))
```

    ## 50% 75% 90% 
    ##   9  11  12

## Tablas como resumen

Un buen resumen de una variable, sobre todo si es un factor son las
tablas. Si usamos useNA nos devolverá una columna extra si hay algún
valor perdido como es el caso.

``` r
table(restData$zipcode, useNA = "ifany")
```

    ## 
    ##  21201  21202  21205  21206  21207  21208  21209  21210  21211  21212  21213 
    ##    136    201     27     30      4      1      8     23     41     28     31 
    ##  21214  21215  21216  21217  21218  21220  21222  21223  21224  21225  21226 
    ##     17     54     10     32     69      1      7     56    199     19     18 
    ## 21226-  21227  21229  21230  21231  21234  21237  21239  21251  21287 
    ##      1      4     13    156    127      7      1      3      2      1

También se pueden hacer tablas de dos dimensiones, es decir, de dos
variables. En este caso cruzamos council district y zipcode.

``` r
head(table(restData$cncldst, restData$zipcode))
```

    ##    
    ##     21201 21202 21205 21206 21207 21208 21209 21210 21211 21212 21213 21214
    ##   1     0    37     0     0     0     0     0     0     0     0     2     0
    ##   2     0     0     3    27     0     0     0     0     0     0     0     0
    ##   3     0     0     0     0     0     0     0     0     0     0     2    17
    ##   4     0     0     0     0     0     0     0     0     0    27     0     0
    ##   5     0     0     0     0     3     0     6     0     0     0     0     0
    ##   6     0     0     0     0     0     0     1    19     0     0     0     0
    ##    
    ##     21215 21216 21217 21218 21220 21222 21223 21224 21225 21226 21226- 21227
    ##   1     0     0     0     0     0     7     0   140     1     0      0     0
    ##   2     0     0     0     0     0     0     0    54     0     0      0     0
    ##   3     0     0     0     3     0     0     0     0     0     0      0     1
    ##   4     0     0     0     0     0     0     0     0     0     0      0     0
    ##   5    31     0     0     0     0     0     0     0     0     0      0     0
    ##   6    15     1     0     0     0     0     0     0     0     0      0     0
    ##    
    ##     21229 21230 21231 21234 21237 21239 21251 21287
    ##   1     0     1   124     0     0     0     0     0
    ##   2     0     0     0     0     1     0     0     0
    ##   3     0     0     0     7     0     0     2     0
    ##   4     0     0     0     0     0     3     0     0
    ##   5     0     0     0     0     0     0     0     0
    ##   6     0     0     0     0     0     0     0     0

## Comprobar valors perdidos

Utilizamos is.na() para comprobar el número de valores perdidos (NA) que
hay en una determinada variable.

En este caso lo utilizamos combinado con sum() y si el resultado es 0,
es que no hay.

``` r
sum(is.na(restData$cncldst))
```

    ## [1] 0

También lo podemos utilizar combinado con any(). Si nos devuelve FALSE
es que no hay ningún NA.

``` r
any(is.na(restData$cncldst))
```

    ## [1] FALSE

Otra aproximación es sumar las columnas buscando los NA. Podemos ver que
hay variables del dataset que están vacías como srcid\_t o url ya que
suman tantos NA como registros tiene el dataframe.

``` r
colSums(is.na(restData))
```

    ##          X          Y        fid     gis_id    srcid_t    srcid_i  edit_date 
    ##          0          0          0          0       1327          0          0 
    ##      ftype    subtype   loc_type   loc_meth street_tag   prcl_pin    address 
    ##          0       1327          0          0          0          0          0 
    ##       city      state    zipcode    x_coord    y_coord       name     alias1 
    ##          0          0          0          0          0          0       1327 
    ##    nghbrhd    cncldst  stfid_blk  plcdst_no     plcdst       usng  cntct_nme 
    ##          0          0          0          0          0          0       1327 
    ##  cntct_phn  cntct_dpt   globalid        url 
    ##       1327       1327          0       1327

Podemos pedir una comprobación de todo el dataset con all(), y si nos
devuelve como es este caso FALSE es que hay NA.

``` r
all(colSums(is.na(restData) == 0))
```

    ## [1] FALSE

## Encontrar valores con carateríticas especiales

Imaginar que queremos encontrar cuantos códigos postales pertenecen al
21212. Lo podemos hacer con %in%. Se puede combinar con más de una
condición, equivale a utilizar un OR. Nos devolverá los que sean iguales
al 21212 o al 21213.

``` r
table(restData$zipcode %in% c("21212"))
```

    ## 
    ## FALSE  TRUE 
    ##  1299    28

``` r
table(restData$zipcode %in% c("21212", "21213"))
```

    ## 
    ## FALSE  TRUE 
    ##  1268    59

Ahora bien, si lo que queremos son los valores y no la suma de cuantos
son, podemos hacer un subsetting utilizando %in%

``` r
restData[restData$zipcode %in% c("21212", "21213"), ]
```

    ## # A tibble: 59 × 32
    ##           X      Y   fid gis_id srcid_t srcid_i edit_date ftype subtype loc_type
    ##       <dbl>  <dbl> <int> <chr>  <lgl>     <int> <chr>     <int> <lgl>   <chr>   
    ##  1  -8.53e6 4.76e6    29 27_96  NA            0 2008/06/…    27 NA      ST      
    ##  2  -8.53e6 4.77e6    39 27_106 NA            0 2008/06/…    27 NA      ST      
    ##  3  -8.53e6 4.77e6    92 27_63  NA            0 2008/06/…    27 NA      ST      
    ##  4  -8.53e6 4.77e6   111 27_82  NA            0 2008/06/…    27 NA      ST      
    ##  5  -8.53e6 4.77e6   187 27_187 NA            0 2008/06/…    27 NA      ST      
    ##  6  -8.53e6 4.77e6   220 27_220 NA            0 2008/06/…    27 NA      ST      
    ##  7  -8.53e6 4.77e6   266 27_266 NA            0 2008/06/…    27 NA      ST      
    ##  8  -8.52e6 4.77e6   276 27_276 NA            0 2008/06/…    27 NA      ST      
    ##  9  -8.52e6 4.77e6   289 27_289 NA            0 2008/06/…    27 NA      ST      
    ## 10  -8.53e6 4.77e6   291 27_291 NA            0 2008/06/…    27 NA      ST      
    ## # … with 49 more rows, and 22 more variables: loc_meth <chr>, street_tag <dbl>,
    ## #   prcl_pin <chr>, address <chr>, city <chr>, state <chr>, zipcode <fct>,
    ## #   x_coord <dbl>, y_coord <dbl>, name <fct>, alias1 <lgl>, nghbrhd <fct>,
    ## #   cncldst <int>, stfid_blk <dbl>, plcdst_no <int>, plcdst <chr>, usng <chr>,
    ## #   cntct_nme <lgl>, cntct_phn <lgl>, cntct_dpt <lgl>, globalid <chr>,
    ## #   url <lgl>

## Tabulaciones cruzadas

La tabulación cruzada es una de las herramientas analíticas más útiles y
un pilar del sector de la investigación de mercados. El análisis de
tabulación cruzada, también conocido como análisis de tablas de
contingencia, se utiliza con mayor frecuencia para analizar datos
categóricos (escala de medición nominal).

Vamos a cargar UCBAdmissions, lo pasamos a dataframe y pedimos el
sumario. Podemos ver que hay 4 categorías: Admit, Gender, Dept y Freq

``` r
data("UCBAdmissions")
DF <- as.data.frame(UCBAdmissions)
summary(DF)
```

    ##       Admit       Gender   Dept       Freq      
    ##  Admitted:12   Male  :12   A:4   Min.   :  8.0  
    ##  Rejected:12   Female:12   B:4   1st Qu.: 80.0  
    ##                            C:4   Median :170.0  
    ##                            D:4   Mean   :188.6  
    ##                            E:4   3rd Qu.:302.5  
    ##                            F:4   Max.   :512.0

Podemos ir más allá con tabulaciones cruzadas para ver donde hay
relaciones entre las variables. Vamos a pedir el número de admitidos y
rechazados por género.

``` r
xt <- xtabs(Freq ~ Gender + Admit, data = DF)
xt
```

    ##         Admit
    ## Gender   Admitted Rejected
    ##   Male       1198     1493
    ##   Female      557     1278

Pero si queremos cruzar muchas variables es mejor utilizar Flat Tables.
Para el ejemplo utilizaremos el dataset warpbreaks, añdimos una variable
extra y volvemos a pedir xtabs() para cruzar en este caso todas las
variables. Pero puede ser complicado verlo ya que genera por cada cruce
una tabla de dos dimensiones.

``` r
data("warpbreaks")
warpbreaks$replicate <- rep(1:9, len = 54)
ft <- xtabs(breaks ~., data = warpbreaks)
ft
```

    ## , , replicate = 1
    ## 
    ##     tension
    ## wool  L  M  H
    ##    A 26 18 36
    ##    B 27 42 20
    ## 
    ## , , replicate = 2
    ## 
    ##     tension
    ## wool  L  M  H
    ##    A 30 21 21
    ##    B 14 26 21
    ## 
    ## , , replicate = 3
    ## 
    ##     tension
    ## wool  L  M  H
    ##    A 54 29 24
    ##    B 29 19 24
    ## 
    ## , , replicate = 4
    ## 
    ##     tension
    ## wool  L  M  H
    ##    A 25 17 18
    ##    B 19 16 17
    ## 
    ## , , replicate = 5
    ## 
    ##     tension
    ## wool  L  M  H
    ##    A 70 12 10
    ##    B 29 39 13
    ## 
    ## , , replicate = 6
    ## 
    ##     tension
    ## wool  L  M  H
    ##    A 52 18 43
    ##    B 31 28 15
    ## 
    ## , , replicate = 7
    ## 
    ##     tension
    ## wool  L  M  H
    ##    A 51 35 28
    ##    B 41 21 15
    ## 
    ## , , replicate = 8
    ## 
    ##     tension
    ## wool  L  M  H
    ##    A 26 30 15
    ##    B 20 39 16
    ## 
    ## , , replicate = 9
    ## 
    ##     tension
    ## wool  L  M  H
    ##    A 67 36 26
    ##    B 44 29 28

Pero podemos aplicar a ft ftable() para tener una única tabla con los
cruces

``` r
ftable(ft)
```

    ##              replicate  1  2  3  4  5  6  7  8  9
    ## wool tension                                     
    ## A    L                 26 30 54 25 70 52 51 26 67
    ##      M                 18 21 29 17 12 18 35 30 36
    ##      H                 36 21 24 18 10 43 28 15 26
    ## B    L                 27 14 29 19 29 31 41 20 44
    ##      M                 42 26 19 16 39 28 21 39 29
    ##      H                 20 21 24 17 13 15 15 16 28

## Tamaño del dataset

Dependiendo del tamaño del dataset es probable que podamos tener
problemas de procesamiento, por eso poder calcular su tamaño puede
ayudarnos.

``` r
fakeData <- rnorm(1e5)
object.size(fakeData)
```

    ## 800048 bytes

``` r
print(object.size(fakeData), units = "Mb")
```

    ## 0.8 Mb
