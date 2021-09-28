Reading Data
================
Carlos Guadián

## Working Directory

Es importante definir el directorio de trabajo. En él es dónde vamos a
leer, y guardar por defecto los archivos que generemos o importemos.

Se utilizan habitualmente getwd() y setwd() para hacerlo y se puede
definir de manera absoluta o relativa.

-   Relativa: setwd(“./data”), setwd("../)
-   Absoluta: setwd(“/Users/usuario/data/”)

## Comprobar y crear directorios

Podemos comprobar si esxite un directorio con
file.exists(“nombreDirectorio”), y crearlo con
dir.create(“nombreDirectorio”).

Con el siguiente código podemos comprobar si existe, y si no, crearlo.

``` r
if (!file.exists("data")) {
  dir.create("data")
}
```

## download.file()

-   Esta función permite descargar archivos de internet
-   Aunque se pueda hacer “manualmente” es mejor hacerlo así pra
    reproducir el proceso.
-   Parámetros importantes: url (la dirección del archivo), destfile
    (nombre del archivo que creamos con la descarga) y method
-   Útil para descargar tsv, csv y otros archivos.

``` r
fileUrl <- "https://raw.githubusercontent.com/carlosguadian/datasciencecoursera/master/02_Getting_Cleaning_Data/Week_1/housing_2006.csv"
download.file(fileUrl, destfile = "./data/housing_2006.csv", method = "curl") # El método es "curl" porque la URL es https, si no, no funcionaría.
list.files("./data")
```

    ## [1] "data_gov.xlsx"                "getdata_data_restaurants.xml"
    ## [3] "housing_2006.csv"             "idaho_2006.csv"

Con objeto de detallar al máximo los datos con los que trabajamos, es
importante dejar constancia “cuando” se han obtenido. Para ello podemos
guardar en una variable la fecha de descarga.

``` r
dateDownloaded <- date()
dateDownloaded
```

    ## [1] "Tue Sep 28 09:17:41 2021"

-   Si la URL empieza por http no hay problema
-   Si empieza por https
    -   En Windows no hay problema
    -   En Mac hace falta utilizar method = “curl”
-   Si el archivo es grande, puede tardar un poco en descargar.
-   Asegurarse de grabar cuando se descargó.

## read.table() y read.csv() - Leer archivos en local

**La función más habitual es read.table()**

-   Es flexible y robusta pero requiere más parámetros
-   Carga los datos en la RAM, archivos grandes pueden causar problemas
-   Parámetros a tener en cuenta: file, header, sep, row.names, nrows
-   Relacionadas: read.csv() y read.csv2()

Por ejemplo si intentamos leer un csv con read.table sin ningún
parámetro nos va a dar un error porque el delimitador que tiene
read.table() por defecto es el espacio de tabulador y no la coma. Si
miramos su estructura con str() vemos que hay 14932 observaciones, pero
solo una variable.

``` r
housing_2006 <- read.table("./data/idaho_2006.csv")
str(housing_2006)
```

    ## 'data.frame':    14932 obs. of  1 variable:
    ##  $ V1: chr  "RT,SERIALNO,SPORDER,PUMA,ST,ADJUST,PWGTP,AGEP,CIT,COW,DDRS,DEYE,DOUT,DPHY,DREM,DWRK,ENG,FER,GCL,GCM,GCR,INTP,JW"| __truncated__ "P,186,1,00700,16,1015675,0089,43,1,7,2,2,2,2,2,2,,,2,,,000000,015,01,01,2,1,1,3,2,0,0,1,0,0,0,0,0,0,0,0,3,5,3,3"| __truncated__ "P,186,2,00700,16,1015675,0092,42,1,4,2,2,2,2,2,2,,2,2,,,000000,,,,2,1,1,5,,,,,,,,,,,,,2,5,2,2,3,000000,00000,01"| __truncated__ "P,186,3,00700,16,1015675,0107,16,1,1,2,2,2,2,2,2,,,,,,000000,005,01,01,2,5,1,,,,,,,,,,,,,,3,5,3,3,3,000000,0000"| __truncated__ ...

Para utilizarla correctamente debemos utilizar algunos parámetros extra.
Vamos a indicar que el separador sea una “coma” ya que es un csv, y le
vamos a decir que si que tiene cabecera, es decir que la primera línea
son los nombres de las variables.

``` r
housing_2006 <- read.table("./data/idaho_2006.csv", sep = ",", header = TRUE)
library(tibble)
as_tibble(housing_2006)
```

    ## # A tibble: 14,931 × 239
    ##    RT    SERIALNO SPORDER  PUMA    ST ADJUST PWGTP  AGEP   CIT   COW  DDRS  DEYE
    ##    <chr>    <int>   <int> <int> <int>  <int> <int> <int> <int> <int> <int> <int>
    ##  1 P          186       1   700    16 1.02e6    89    43     1     7     2     2
    ##  2 P          186       2   700    16 1.02e6    92    42     1     4     2     2
    ##  3 P          186       3   700    16 1.02e6   107    16     1     1     2     2
    ##  4 P          186       4   700    16 1.02e6    91    14     1    NA     2     2
    ##  5 P          306       1   700    16 1.02e6   309    29     1     5     2     2
    ##  6 P          395       1   100    16 1.02e6   108    40     1     8     2     2
    ##  7 P          395       2   100    16 1.02e6    90    15     1    NA     2     2
    ##  8 P          506       1   700    16 1.02e6   239    28     1     1     2     2
    ##  9 P          506       2   700    16 1.02e6   213    30     1     1     2     2
    ## 10 P          506       3   700    16 1.02e6   219     4     1    NA    NA    NA
    ## # … with 14,921 more rows, and 227 more variables: DOUT <int>, DPHY <int>,
    ## #   DREM <int>, DWRK <int>, ENG <int>, FER <int>, GCL <int>, GCM <int>,
    ## #   GCR <int>, INTP <int>, JWMNP <int>, JWRIP <int>, JWTR <int>, LANX <int>,
    ## #   MAR <int>, MIG <int>, MIL <int>, MILY <int>, MLPA <int>, MLPB <int>,
    ## #   MLPC <int>, MLPD <int>, MLPE <int>, MLPF <int>, MLPG <int>, MLPH <int>,
    ## #   MLPI <int>, MLPJ <int>, MLPK <int>, NWAB <int>, NWAV <int>, NWLA <int>,
    ## #   NWLK <int>, NWRE <int>, OIP <int>, PAP <int>, REL <int>, RETP <int>, …

Con read.csv() ya no tenemos que incorporar estos parámetros ya que por
defecto el separador es la “,” y las cabeceras están en TRUE.

``` r
housing_2006_2 <- read.csv("./data/idaho_2006.csv")
as_tibble(housing_2006_2)
```

    ## # A tibble: 14,931 × 239
    ##    RT    SERIALNO SPORDER  PUMA    ST ADJUST PWGTP  AGEP   CIT   COW  DDRS  DEYE
    ##    <chr>    <int>   <int> <int> <int>  <int> <int> <int> <int> <int> <int> <int>
    ##  1 P          186       1   700    16 1.02e6    89    43     1     7     2     2
    ##  2 P          186       2   700    16 1.02e6    92    42     1     4     2     2
    ##  3 P          186       3   700    16 1.02e6   107    16     1     1     2     2
    ##  4 P          186       4   700    16 1.02e6    91    14     1    NA     2     2
    ##  5 P          306       1   700    16 1.02e6   309    29     1     5     2     2
    ##  6 P          395       1   100    16 1.02e6   108    40     1     8     2     2
    ##  7 P          395       2   100    16 1.02e6    90    15     1    NA     2     2
    ##  8 P          506       1   700    16 1.02e6   239    28     1     1     2     2
    ##  9 P          506       2   700    16 1.02e6   213    30     1     1     2     2
    ## 10 P          506       3   700    16 1.02e6   219     4     1    NA    NA    NA
    ## # … with 14,921 more rows, and 227 more variables: DOUT <int>, DPHY <int>,
    ## #   DREM <int>, DWRK <int>, ENG <int>, FER <int>, GCL <int>, GCM <int>,
    ## #   GCR <int>, INTP <int>, JWMNP <int>, JWRIP <int>, JWTR <int>, LANX <int>,
    ## #   MAR <int>, MIG <int>, MIL <int>, MILY <int>, MLPA <int>, MLPB <int>,
    ## #   MLPC <int>, MLPD <int>, MLPE <int>, MLPF <int>, MLPG <int>, MLPH <int>,
    ## #   MLPI <int>, MLPJ <int>, MLPK <int>, NWAB <int>, NWAV <int>, NWLA <int>,
    ## #   NWLK <int>, NWRE <int>, OIP <int>, PAP <int>, REL <int>, RETP <int>, …

**Otros parámetros para tener en cuenta:**

-   quote: indicamos qué valores entrecomillados no significa,
    entrecomillados.
-   na.strings: se define el valor de valores no disponibles.
-   nrows: cuantas filas deben leerse.
-   skip: cuantas líneas debe saltarse antes de empezar a cargar datos.
