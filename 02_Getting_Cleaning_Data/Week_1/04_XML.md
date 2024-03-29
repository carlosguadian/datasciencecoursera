Leer XML
================

-   [Leer archivos XML](#leer-archivos-xml)

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
