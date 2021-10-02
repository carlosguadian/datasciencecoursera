Tidying data con tidyr
================

## Tidy data

Tidy data facilita la exploración de los datos. Para que así sea debe
satisfacer tres condiciones:

-   Cada variable conforma una columna
-   Cada observación forma una fila
-   Cada tipo de unidad observacional forma una tabla

Para facilitar “arreglar” los datos vamos a trabajar con tidyr()

``` r
library(tidyr)
```

Supongamos que tenemos el siguiente dataset

``` r
students <- read.csv("./data/students.csv")
students
```

    ##   X grade male female
    ## 1 1     A    5      3
    ## 2 2     B    4      1
    ## 3 3     C    8      6
    ## 4 4     D    4      5
    ## 5 5     E    5      5

## gather()

Como se puede ver en students tenemos tres columnas, grade, male y
female. Pero no debería ser así. Deberíamos tener grade, sex y count
para estar estructurado de una manera correcta.

Para ordenarlo vamos a utilizar gather() para unificar male y female,
bajo sex y cada una de sus observaciones bajo, count. El -grade indica
que es la columna que no queremos tocar.

``` r
gather(students, sex, count, -grade)
```

    ##    grade    sex count
    ## 1      A      X     1
    ## 2      B      X     2
    ## 3      C      X     3
    ## 4      D      X     4
    ## 5      E      X     5
    ## 6      A   male     5
    ## 7      B   male     4
    ## 8      C   male     8
    ## 9      D   male     4
    ## 10     E   male     5
    ## 11     A female     3
    ## 12     B female     1
    ## 13     C female     6
    ## 14     D female     5
    ## 15     E female     5

## separate()

Vamos a ver otro dataset que está desordenado. Students2

``` r
students2 <- read.csv("./data/students2.csv")
students2
```

    ##   X grade male_1 female_1 male_2 female_2
    ## 1 1     A      7        0      5        8
    ## 2 2     B      4        0      5        8
    ## 3 3     C      7        4      5        6
    ## 4 4     D      8        2      8        1
    ## 5 5     E      8        4      1        0

Como se puede ver hay 5 columnas. Está “grade” que es correcta, pero
tenemos dos males y dos females. Cada uno pertenece a una clase
diferente. Para ordenar este dataset lo haremos en dos pasos.

El primero con gather para unificar columnas. Lo guardamos en una nueva
variable

``` r
res <- gather(students2, sex_class, count, -grade)
res
```

    ##    grade sex_class count
    ## 1      A         X     1
    ## 2      B         X     2
    ## 3      C         X     3
    ## 4      D         X     4
    ## 5      E         X     5
    ## 6      A    male_1     7
    ## 7      B    male_1     4
    ## 8      C    male_1     7
    ## 9      D    male_1     8
    ## 10     E    male_1     8
    ## 11     A  female_1     0
    ## 12     B  female_1     0
    ## 13     C  female_1     4
    ## 14     D  female_1     2
    ## 15     E  female_1     4
    ## 16     A    male_2     5
    ## 17     B    male_2     5
    ## 18     C    male_2     5
    ## 19     D    male_2     8
    ## 20     E    male_2     1
    ## 21     A  female_2     8
    ## 22     B  female_2     8
    ## 23     C  female_2     6
    ## 24     D  female_2     1
    ## 25     E  female_2     0

El segundo con separate() para separar sex\_class en sex y class.

``` r
separate(res, sex_class, into = c("sex", "class"))
```

    ## Warning: Expected 2 pieces. Missing pieces filled with `NA` in 5 rows [1, 2, 3,
    ## 4, 5].

    ##    grade    sex class count
    ## 1      A      X  <NA>     1
    ## 2      B      X  <NA>     2
    ## 3      C      X  <NA>     3
    ## 4      D      X  <NA>     4
    ## 5      E      X  <NA>     5
    ## 6      A   male     1     7
    ## 7      B   male     1     4
    ## 8      C   male     1     7
    ## 9      D   male     1     8
    ## 10     E   male     1     8
    ## 11     A female     1     0
    ## 12     B female     1     0
    ## 13     C female     1     4
    ## 14     D female     1     2
    ## 15     E female     1     4
    ## 16     A   male     2     5
    ## 17     B   male     2     5
    ## 18     C   male     2     5
    ## 19     D   male     2     8
    ## 20     E   male     2     1
    ## 21     A female     2     8
    ## 22     B female     2     8
    ## 23     C female     2     6
    ## 24     D female     2     1
    ## 25     E female     2     0

Con pipes se podría hacer en un paso

``` r
students2 %>%
  gather( sex_class, count, -grade) %>%
  separate( sex_class, c("sex", "class")) %>%
  print
```

    ## Warning: Expected 2 pieces. Missing pieces filled with `NA` in 5 rows [1, 2, 3,
    ## 4, 5].

    ##    grade    sex class count
    ## 1      A      X  <NA>     1
    ## 2      B      X  <NA>     2
    ## 3      C      X  <NA>     3
    ## 4      D      X  <NA>     4
    ## 5      E      X  <NA>     5
    ## 6      A   male     1     7
    ## 7      B   male     1     4
    ## 8      C   male     1     7
    ## 9      D   male     1     8
    ## 10     E   male     1     8
    ## 11     A female     1     0
    ## 12     B female     1     0
    ## 13     C female     1     4
    ## 14     D female     1     2
    ## 15     E female     1     4
    ## 16     A   male     2     5
    ## 17     B   male     2     5
    ## 18     C   male     2     5
    ## 19     D   male     2     8
    ## 20     E   male     2     1
    ## 21     A female     2     8
    ## 22     B female     2     8
    ## 23     C female     2     6
    ## 24     D female     2     1
    ## 25     E female     2     0

Vamos a trabajar ahora con otro escenario, con students3

``` r
students3 <- read.csv("./data/students3.csv")
students3
```

    ##     X  name    test class1 class2 class3 class4 class5
    ## 1   1 Sally midterm      A   <NA>      B   <NA>   <NA>
    ## 2   2 Sally   final      C   <NA>      C   <NA>   <NA>
    ## 3   3  Jeff midterm   <NA>      D   <NA>      A   <NA>
    ## 4   4  Jeff   final   <NA>      E   <NA>      C   <NA>
    ## 5   5 Roger midterm   <NA>      C   <NA>   <NA>      B
    ## 6   6 Roger   final   <NA>      A   <NA>   <NA>      A
    ## 7   7 Karen midterm   <NA>   <NA>      C      A   <NA>
    ## 8   8 Karen   final   <NA>   <NA>      C      A   <NA>
    ## 9   9 Brian midterm      B   <NA>   <NA>   <NA>      A
    ## 10 10 Brian   final      B   <NA>   <NA>   <NA>      C

Vamos a llamar a gather() para reunir las columnas class1 hasta class5
en una nueva variable llamada class. La ‘clave’ debe ser class, y el
‘valor’ debe ser grado.

tidyr facilita la referencia a múltiples columnas adyacentes columnas
adyacentes con class1:class5, al igual que con las secuencias de
números.

Dado que cada estudiante sólo está inscrito en dos de las cinco clases
posibles, hay muchos valores que faltan valores perdidos (es decir,
NAs). Utilizamos el argumento na.rm = TRUE para omitir estos valores del
resultado final.

``` r
students3 %>%
  gather( class, grade, class1:class5, -name , na.rm = TRUE) %>%
  print
```

    ##     X  name    test  class grade
    ## 1   1 Sally midterm class1     A
    ## 2   2 Sally   final class1     C
    ## 9   9 Brian midterm class1     B
    ## 10 10 Brian   final class1     B
    ## 13  3  Jeff midterm class2     D
    ## 14  4  Jeff   final class2     E
    ## 15  5 Roger midterm class2     C
    ## 16  6 Roger   final class2     A
    ## 21  1 Sally midterm class3     B
    ## 22  2 Sally   final class3     C
    ## 27  7 Karen midterm class3     C
    ## 28  8 Karen   final class3     C
    ## 33  3  Jeff midterm class4     A
    ## 34  4  Jeff   final class4     C
    ## 37  7 Karen midterm class4     A
    ## 38  8 Karen   final class4     A
    ## 45  5 Roger midterm class5     B
    ## 46  6 Roger   final class5     A
    ## 49  9 Brian midterm class5     A
    ## 50 10 Brian   final class5     C

Este script se basa en el anterior añadiendo una llamada a spread(), que
nos permitirá convertir los valores de la columna de prueba, intermedia
y final, en cabeceras de columna (es decir, variables).

Sólo necesitamos especificar dos argumentos a spread().

``` r
students3 %>%
  gather(class, grade, class1:class5, na.rm = TRUE) %>%
  spread( test, grade) %>%
  print
```

    ##     X  name  class final midterm
    ## 1   1 Sally class1  <NA>       A
    ## 2   1 Sally class3  <NA>       B
    ## 3   2 Sally class1     C    <NA>
    ## 4   2 Sally class3     C    <NA>
    ## 5   3  Jeff class2  <NA>       D
    ## 6   3  Jeff class4  <NA>       A
    ## 7   4  Jeff class2     E    <NA>
    ## 8   4  Jeff class4     C    <NA>
    ## 9   5 Roger class2  <NA>       C
    ## 10  5 Roger class5  <NA>       B
    ## 11  6 Roger class2     A    <NA>
    ## 12  6 Roger class5     A    <NA>
    ## 13  7 Karen class3  <NA>       C
    ## 14  7 Karen class4  <NA>       A
    ## 15  8 Karen class3     C    <NA>
    ## 16  8 Karen class4     A    <NA>
    ## 17  9 Brian class1  <NA>       B
    ## 18  9 Brian class5  <NA>       A
    ## 19 10 Brian class1     B    <NA>
    ## 20 10 Brian class5     C    <NA>

Queremos que los valores de las columnas de clase sean 1, 2, …, 5 y no
class1, class2, …, class5.

Usamos la función mutate() de dplyr junto con parse\_number().

Cargamos primero dplyr() para utilizar mutate(), y readr() para
parse\_number()

``` r
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
library(readr)
```

Ahora ejecutamos para extraer los números de la columna class.

``` r
students3 %>%
  gather(class, grade, class1:class5, na.rm = TRUE) %>%
  spread(test, grade) %>%
  mutate(class = parse_number(class)) %>%
  print
```

    ##     X  name class final midterm
    ## 1   1 Sally     1  <NA>       A
    ## 2   1 Sally     3  <NA>       B
    ## 3   2 Sally     1     C    <NA>
    ## 4   2 Sally     3     C    <NA>
    ## 5   3  Jeff     2  <NA>       D
    ## 6   3  Jeff     4  <NA>       A
    ## 7   4  Jeff     2     E    <NA>
    ## 8   4  Jeff     4     C    <NA>
    ## 9   5 Roger     2  <NA>       C
    ## 10  5 Roger     5  <NA>       B
    ## 11  6 Roger     2     A    <NA>
    ## 12  6 Roger     5     A    <NA>
    ## 13  7 Karen     3  <NA>       C
    ## 14  7 Karen     4  <NA>       A
    ## 15  8 Karen     3     C    <NA>
    ## 16  8 Karen     4     A    <NA>
    ## 17  9 Brian     1  <NA>       B
    ## 18  9 Brian     5  <NA>       A
    ## 19 10 Brian     1     B    <NA>
    ## 20 10 Brian     5     C    <NA>

Vamos a trabajar con otro escenario de messy data en el que tenemos
diferentes unidades observacionales en la misma tabla.

``` r
students4 <- read.csv("./data/students4.csv")
students4
```

    ##     X  id  name sex class midterm final
    ## 1   1 168 Brian   F     1       B     B
    ## 2   2 168 Brian   F     5       A     C
    ## 3   3 588 Sally   M     1       A     C
    ## 4   4 588 Sally   M     3       B     C
    ## 5   5 710  Jeff   M     2       D     E
    ## 6   6 710  Jeff   M     4       A     C
    ## 7   7 731 Roger   F     2       C     A
    ## 8   8 731 Roger   F     5       B     A
    ## 9   9 908 Karen   M     3       C     C
    ## 10 10 908 Karen   M     4       A     A

Como se puede ver en students4 hay observaciones de los mismos
estudiantes para diferentes clases, vamos a separar la información de
los estudiantes por un lado y las notas por otro.

Primero la información de los estudiantes, vamos a utilizar unique()
para evitar duplicidades.

``` r
student_info <- students4 %>%
  select(id, name, sex) %>%
  unique %>%
  print
```

    ##    id  name sex
    ## 1 168 Brian   F
    ## 3 588 Sally   M
    ## 5 710  Jeff   M
    ## 7 731 Roger   F
    ## 9 908 Karen   M

Por otro lado vamos a generar el libro de notas y listo, ya lo tenemos
separado.

``` r
gradebook <- students4 %>%
  select(id, class, midterm, final) %>%
  print
```

    ##     id class midterm final
    ## 1  168     1       B     B
    ## 2  168     5       A     C
    ## 3  588     1       A     C
    ## 4  588     3       B     C
    ## 5  710     2       D     E
    ## 6  710     4       A     C
    ## 7  731     2       C     A
    ## 8  731     5       B     A
    ## 9  908     3       C     C
    ## 10 908     4       A     A
