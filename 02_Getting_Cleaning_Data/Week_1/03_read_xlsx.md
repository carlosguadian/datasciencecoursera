read.xlsx()
================

## read.xlsx(), read.xlsx2() - Leer Archivos Excel

El proceso para descargar un archivo excel es exactamente igual que el
descrito anteriormente.

Para leer los archivos tipo excel utilizaremos el paquete “xlsx”, si no
lo tenéis instalado, proceder a ello primero y cargarlo.

En los parámetros indicaremos la hoja que queremos cargar con
“sheetIndex” y si hay cabeceras. En el siguiente ejemplo al visualizar
lo que hemos cargado nos damos cuenta que en la hoja cargada hay varias
tablas, por lo que para trabajar con un conjunto de datos determinado
deberemos hacer un subset de los mismos.

``` r
require(xlsx)
```

    ## Loading required package: xlsx

``` r
data_gov <- read.xlsx("./data/Data_gov.xlsx", sheetIndex = 1, header = TRUE)
head(data_gov)
```

    ##   Table.Name..Contract          NA.               NA..1     NA..2
    ## 1       ContractNumber ContractorId          ExpiryDate CFileName
    ## 2   GS-00P-02-BSC-0201           23 2004-09-30 00:00:00      <NA>
    ## 3   GS-00P-02-BSC-0204            5 2003-10-31 00:00:00      NULL
    ## 4   GS-00P-02-BSC-0206            6 2004-10-31 00:00:00      <NA>
    ## 5   GS-00P-02-BSC-0207            4 2006-10-31 00:00:00      <NA>
    ## 6   GS-00P-02-BSC-0209            7 2004-10-31 00:00:00      <NA>
    ##                 NA..3 NA..4 NA..5 NA..6 NA..7 NA..8 NA..9 NA..10 NA..11 NA..12
    ## 1      ReactivationDt  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>   <NA>   <NA>   <NA>
    ## 2 2004-09-30 00:00:00  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>   <NA>   <NA>   <NA>
    ## 3                NULL  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>   <NA>   <NA>   <NA>
    ## 4 2004-11-02 00:00:00  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>   <NA>   <NA>   <NA>
    ## 5 2004-11-01 00:00:00  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>   <NA>   <NA>   <NA>
    ## 6 2004-11-01 00:00:00  <NA>  <NA>  <NA>  <NA>  <NA>  <NA>   <NA>   <NA>   <NA>
    ##   NA..13 NA..14 NA..15 NA..16 NA..17 NA..18 NA..19 NA..20 NA..21 NA..22 NA..23
    ## 1   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>
    ## 2   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>
    ## 3   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>
    ## 4   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>
    ## 5   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>
    ## 6   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>
    ##   NA..24
    ## 1   <NA>
    ## 2   <NA>
    ## 3   <NA>
    ## 4   <NA>
    ## 5   <NA>
    ## 6   <NA>

Para ello, primero procederemos a hacer el subset de las líneas con las
que queramos trabajar, recordar que son varias tablas unas encima de
otras. Vamos a seleccionar los datos pertenecientes a la tabla
“contractor” que se encuentran entre las filas 17:22

``` r
library(tibble)
contractor <- data_gov[17:22, ] # seleccionamos las filas deseadas
names(contractor) <- contractor[1, ] # copiamos la primera fila como nombres de varible
contractor <- contractor[-1, ] # borramos la primera fila
contractor <- contractor[, 1:15] # seleccionamos sólo las columnas deseadas
row.names(contractor) <- c(1:5) # renombramos las filas
as_tibble(contractor) # comprobamos
```

    ## # A tibble: 5 × 15
    ##   StateAbbrev CName   Address1 Address2 Address3 City  Zip   CuCurrent PaCurrent
    ##   <chr>       <chr>   <chr>    <chr>    <chr>    <chr> <chr> <chr>     <chr>    
    ## 1 OK          Tiger … 1422 E … <NA>     <NA>     Tulsa 74136 0         1        
    ## 2 GA          PS Ene… 2987 Cl… Suite 5… <NA>     Atla… 30329 1         0        
    ## 3 OK          Geary … 7712 S … Suite 2… <NA>     Tulsa 74136 1         0        
    ## 4 CO          Utilit… 1700 Li… Suite 2… <NA>     Denv… 80203 0         1        
    ## 5 CO          Select… 8122 So… Suite 2… <NA>     Litt… 80120 1         0        
    ## # … with 6 more variables: PoCurrent <chr>, Contact <chr>, Ext <chr>,
    ## #   Fax <chr>, email <chr>, Status <chr>