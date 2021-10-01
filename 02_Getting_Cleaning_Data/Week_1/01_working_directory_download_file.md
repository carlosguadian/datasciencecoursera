Working Directory & download.file()
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
    ## [5] "restaurants.xml"

Con objeto de detallar al máximo los datos con los que trabajamos, es
importante dejar constancia “cuando” se han obtenido. Para ello podemos
guardar en una variable la fecha de descarga.

``` r
dateDownloaded <- date()
dateDownloaded
```

    ## [1] "Fri Oct  1 10:10:04 2021"

-   Si la URL empieza por http no hay problema
-   Si empieza por https
    -   En Windows no hay problema
    -   En Mac hace falta utilizar method = “curl”
-   Si el archivo es grande, puede tardar un poco en descargar.
-   Asegurarse de grabar cuando se descargó.
