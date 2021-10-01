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
    ## [5] "restaurants.xml"

Con objeto de detallar al máximo los datos con los que trabajamos, es
importante dejar constancia “cuando” se han obtenido. Para ello podemos
guardar en una variable la fecha de descarga.

``` r
dateDownloaded <- date()
dateDownloaded
```

    ## [1] "Thu Sep 30 10:41:55 2021"

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
view(data_gov)
```

Para ello, primero procederemos a hacer el subset de las líneas con las
que queramos trabajar, recordar que son varias tablas unas encima de
otras. Vamos a seleccionar los datos pertenecientes a la tabla
“contractor” que se encuentran entre las filas 17:22

``` r
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

## Leer archivos XML

Se han de tener en cuenta las etiquetas que definen los bloques del
contenido. Por ejemplo las que definen una sección \*\*
<section>
</section>

\*\*

Tenemos que utilizar la librería “Rcurl” para poder acceder a una
dirección https con getURL(). Con rootNode accedemos al nombre de la
unidad de información del documento.

``` r
library(XML)
library(RCurl)
fileUrl <- "https://www.w3schools.com/xml/simple.xml"
fileUrl <- getURL(fileUrl)
doc <- xmlTreeParse(fileUrl, useInternalNodes = TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)
```

    ## [1] "breakfast_menu"

También podemos acceder a los diferentes elementos que están dentro del
rootNode para saber lo que contiene.

``` r
names(rootNode)
```

    ##   food   food   food   food   food 
    ## "food" "food" "food" "food" "food"

Se puede acceder directamente a partes del XML como si se tratara de una
lista. Por ejemplo al primer elemento sería.

``` r
rootNode[[1]]
```

    ## <food>
    ##   <name>Belgian Waffles</name>
    ##   <price>$5.95</price>
    ##   <description>Two of our famous Belgian Waffles with plenty of real maple syrup</description>
    ##   <calories>650</calories>
    ## </food>

Y si queremos acceder al primer elemento, del primer elemento. Es decir,
en este caso al nombre de la primera comida.

``` r
rootNode[[1]][[1]]
```

    ## <name>Belgian Waffles</name>

Si queremos extraer partes del archivo utilizaremos xmlSApply()

``` r
xmlSApply(rootNode, xmlValue)
```

    ##                                                                                                                     food 
    ##                               "Belgian Waffles$5.95Two of our famous Belgian Waffles with plenty of real maple syrup650" 
    ##                                                                                                                     food 
    ##                    "Strawberry Belgian Waffles$7.95Light Belgian waffles covered with strawberries and whipped cream900" 
    ##                                                                                                                     food 
    ## "Berry-Berry Belgian Waffles$8.95Light Belgian waffles covered with an assortment of fresh berries and whipped cream900" 
    ##                                                                                                                     food 
    ##                                                "French Toast$4.50Thick slices made from our homemade sourdough bread600" 
    ##                                                                                                                     food 
    ##                         "Homestyle Breakfast$6.95Two eggs, bacon or sausage, toast, and our ever-popular hash browns950"

Para hacer una extracción correcta es conveniente conocer xPath y sus
elementos:

-   /node Top level nodo
-   //node Un nodo a cualquier nivel
-   node\[@attr-name\] Nodo con un nombre de atributo
-   node\[@attr-name='bob'\] Nodo con bob de atributo

Más info en el siguiente
[PDF](https://www.stat.berkeley.edu/~statcur/Workshop2/Presentations/XML.pdf)

Sabiendo esto podemos obtener, del fichero de menús, cada uno de los
ítems

``` r
xpathSApply(rootNode, "//name", xmlValue)
```

    ## [1] "Belgian Waffles"             "Strawberry Belgian Waffles" 
    ## [3] "Berry-Berry Belgian Waffles" "French Toast"               
    ## [5] "Homestyle Breakfast"

O cada uno de los precios

``` r
xpathSApply(rootNode, "//price", xmlValue)
```

    ## [1] "$5.95" "$7.95" "$8.95" "$4.50" "$6.95"

Otro ejemplo con descarga de XML para obtener el número de restaurantes
de un determinado código postal. En este caso descargamos archivo y
utilizamos el paquete xml2 ya que con xml tenemos problemas al leer los
nodos y nos permite acceder de manera más fácil a la información.

``` r
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml", destfile = "./data/restaurants.xml", method = "curl")
library(xml2)
doc <- read_xml("./data/restaurants.xml")
# conseguir los zipcodes
zipcodes <- xml_find_all(doc, "//zipcode") 
# extraer y limpiar columnas
vals <- trimws(xml_text(zipcodes))
# convertimos el vector en numérico
vals <- as.numeric(vals)
# sacamos la tabla y la guardamos en una variable
a <- table(vals)
# Si queremos el número de restaurantes para el código postal 21231
a[names(a)==21231]
```

    ## 21231 
    ##   127

## Leer JSON

Para leer archivos JSON utilizaremos el paquete jsonlite.

Podemos leer directamente de un archivo que esté en Internet, por
ejemplo, el que contiene la información de Github de los repositorios
que tengo y participo.

``` r
library(jsonlite)
jsondata <- fromJSON("https://api.github.com/users/carlosguadian/repos")
names(jsondata) # acceso a los diferentes elementos que conformarían el dataframe
```

    ##  [1] "id"                "node_id"           "name"             
    ##  [4] "full_name"         "private"           "owner"            
    ##  [7] "html_url"          "description"       "fork"             
    ## [10] "url"               "forks_url"         "keys_url"         
    ## [13] "collaborators_url" "teams_url"         "hooks_url"        
    ## [16] "issue_events_url"  "events_url"        "assignees_url"    
    ## [19] "branches_url"      "tags_url"          "blobs_url"        
    ## [22] "git_tags_url"      "git_refs_url"      "trees_url"        
    ## [25] "statuses_url"      "languages_url"     "stargazers_url"   
    ## [28] "contributors_url"  "subscribers_url"   "subscription_url" 
    ## [31] "commits_url"       "git_commits_url"   "comments_url"     
    ## [34] "issue_comment_url" "contents_url"      "compare_url"      
    ## [37] "merges_url"        "archive_url"       "downloads_url"    
    ## [40] "issues_url"        "pulls_url"         "milestones_url"   
    ## [43] "notifications_url" "labels_url"        "releases_url"     
    ## [46] "deployments_url"   "created_at"        "updated_at"       
    ## [49] "pushed_at"         "git_url"           "ssh_url"          
    ## [52] "clone_url"         "svn_url"           "homepage"         
    ## [55] "size"              "stargazers_count"  "watchers_count"   
    ## [58] "language"          "has_issues"        "has_projects"     
    ## [61] "has_downloads"     "has_wiki"          "has_pages"        
    ## [64] "forks_count"       "mirror_url"        "archived"         
    ## [67] "disabled"          "open_issues_count" "license"          
    ## [70] "allow_forking"     "forks"             "open_issues"      
    ## [73] "watchers"          "default_branch"

``` r
names(jsondata$owner) # se puede acceder a uno específico
```

    ##  [1] "login"               "id"                  "node_id"            
    ##  [4] "avatar_url"          "gravatar_id"         "url"                
    ##  [7] "html_url"            "followers_url"       "following_url"      
    ## [10] "gists_url"           "starred_url"         "subscriptions_url"  
    ## [13] "organizations_url"   "repos_url"           "events_url"         
    ## [16] "received_events_url" "type"                "site_admin"

``` r
jsondata$owner$login # incluso bajar un nivel más
```

    ##  [1] "carlosguadian" "carlosguadian" "carlosguadian" "carlosguadian"
    ##  [5] "carlosguadian" "carlosguadian" "carlosguadian" "carlosguadian"
    ##  [9] "carlosguadian" "carlosguadian" "carlosguadian" "carlosguadian"
    ## [13] "carlosguadian" "carlosguadian" "carlosguadian"

Con este paquete también se puede convertir un dataframe en json.
Probemos con Iris data.

``` r
myjson <- toJSON(iris, pretty = TRUE)
# cat(myjson)
```

Y lo podemos volver a dataframe con fromJSON

``` r
iris2 <- fromJSON(myjson)
head(iris2)
```

    ##   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
    ## 1          5.1         3.5          1.4         0.2  setosa
    ## 2          4.9         3.0          1.4         0.2  setosa
    ## 3          4.7         3.2          1.3         0.2  setosa
    ## 4          4.6         3.1          1.5         0.2  setosa
    ## 5          5.0         3.6          1.4         0.2  setosa
    ## 6          5.4         3.9          1.7         0.4  setosa
