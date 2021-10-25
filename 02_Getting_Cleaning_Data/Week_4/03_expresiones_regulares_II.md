Expresiones regulares II
================

## Más Metacaracteres

“.” se utiliza para referirse a cualquier carácter (es un comodín). Así,

``` markdown
9.11
```

Coincidirá con las siguientes líneas:

``` markdown
its stupid the post 9-11 rules
if any 1 of us did 9/11 we would have been caught in days.
NetBios: scanning ip 203.169.114.66
Front Door 9:11:46 AM
Sings: 0118999881999119725...3 !
```

## Alternativas - \|

Esto no significa “pipe” en el contexto de las expresiones regulares,
sino que se traduce en “o”; podemos utilizarlo para combinar dos
expresiones, las subexpresiones se llaman alternativas

``` markdown
flood|fire
```

coincidirá con las líneas

``` markdown
is firewire like usb on none macs?
the global flood makes sense within the context of the bible
yeah ive had the fire on tonight
... and the floods, hurricanes, killer heatwaves, rednecks, gun nuts, etc.
```

Podemos incluir cualquier número de alternativas…

``` markdown
flood|earthquake|hurricane|coldfire
```

Coincidirá con:

``` markdown
Not a whole lot of hurricanes in the Arctic.
We do have earthquakes nearly every day somewhere in our State
hurricanes swirl in the other direction
coldfire is STRAIGHT!
’cause we keep getting earthquakes
```

Las alternativas pueden ser expresiones y no sólo literales

``` markdown
^[Gg]ood|[Bb]ad
```

Coincidirá con:

``` markdown
good to hear some good knews from someone here
Good afternoon fellow american infidels!
good on you-what do you drive?
Katie... guess they had bad experiences...
my middle name is trouble, Miss Bad News
```

## ( )

Las subexpresiones suelen ir entre paréntesis para restringir las
alternativas. En la siguiente expresión buscamos good o bad con
mayúscula o minúscula al principio de línea.

``` markdown
^([Gg]ood|[Bb]ad)
```

Por lo tanto coincidirá con:

``` markdown
bad habbit
bad coordination today
good, becuase there is nothing worse than a man in kinky underwear
Badcop, its because people want to use drugs
Good Monday Holiday
Good riddance to Limey
```

## ?

El signo de interrogación indica que la expresión indicada es opcional.
En la siguiente expresión buscamos por George Bush pero puede llevar o
no W. en medio de las dos palabras.

``` markdown
[Gg]eorge( [Ww]\.)? [Bb]ush
```

Coincidirá con:

``` markdown
i bet i can spell better than you and george bush combined
BBC reported that President George W. Bush claimed God told him to invade I
a bird in the hand is worth two george bushes
```

Un apunte sobre la expresión anterior:

``` markdown
[Gg]eorge( [Ww]\.)? [Bb]ush
```

Queríamos que un “.” coincidiera con un punto literal; para ello,
teníamos que “escapar” el metacarácter, precediéndolo de una barra
invertida. Recordemos, mirar el inicio de este apunte, que el “.” se
utiliza como comodín.

En general, tenemos que hacer esto para cualquier metacarácter que
queramos incluir en nuestra coincidencia

## \* and +

Los signos \* y + son metacaracteres utilizados para indicar la
repetición; \* significa “cualquier número, incluso ninguno, del
elemento” y + significa “al menos uno del elemento”.

Por lo tanto la siguiente expresión buscará por () con nada o con
algunos caracteres, los que sean dentro.

``` r
(.*)
```

Coincidirá con:

``` markdown
anyone wanna chat? (24, m, germany)
hello, 20.m here... ( east area + drives + webcam )
(he means older men)
()
```

La siguiente expresión buscará un númro seguido por una serie de
caracteres seguidos por otro número.

``` markdown
[0-9]+ (.*)[0-9]+
```

Coincidirá con:

``` markdown
working as MP here 720 MP battallion, 42nd birgade
so say 2 or 3 years at colleage and 4 at uni makes us 23 when and if we fin
it went down on several occasions for like, 3 or 4 *days*
Mmmm its time 4 me 2 go 2 bed
```

## 

{ } se denominan cuantificadores de intervalo; nos permiten especificar
el número mínimo y máximo de coincidencias de una expresión.

La siguiente expresión buscará por la palabra Bush seguida entre 1 y 5
veces de un espacio en blanco, más un no espacio en blanco, más otro
espacio en blanco, para acabar con la palabra debate. Es decir, buscará
“Bush” y “debate” con 1 y 5 palabras enmedio de ellas.

``` markdown
[Bb]ush( +[^ ]+ +){1,5} debate
```

Coindicirá con:

``` markdown
Bush has historically won all major debates he’s done.
in my view, Bush doesn’t need these debates..
bush doesn’t need the debates? maybe you are right
That’s what Bush supporters are doing about the debate.
Felix, I don’t disagree that Bush was poorly prepared for the debate.
indeed, but still, Bush should have taken the debate more seriously.
Keep repeating that Bush smirked and scowled during the debate
```

## Más sobre repeticiones

-   m,n significa al menos m pero no más de n coincidencias
-   m significa exactamente m coincidencias
-   m, significa al menos m coincidencias

## Un poco más sobre ( )

-   En la mayoría de las implementaciones de expresiones regulares, los
    paréntesis no sólo limitan el alcance de las alternativas divididas
    por un “\|”, sino que también pueden utilizarse para “recordar” el
    texto coincidente con la subexpresión encerrada
-   Nos referimos al texto coincidente con \\1, \\2, etc.

Por lo tanto la expresión buscará cualquier palabra seguida de ella
misma.

``` markdown
+([a-zA-Z]+) +\1 +
```

Coincidirá con:

``` markdown
time for bed, night night twitter!
blah blah blah blah
my tattoo is so so itchy today
i was standing all all alone against the world outside...
hi anybody anybody at home
estudiando css css css css.... que desastritooooo
```

El \* es “codicioso”, por lo que siempre coincide con la cadena *más
larga* posible que satisfaga la expresión regular. Así que si buscamos
al inicio de línea una “s”, seguida de cualquier caracter, acabada en
“s”

``` markdown
^s(.*)s
```

Coincidirá con:

``` markdown
sitting at starbucks
setting up mysql and rails
studying stuff for the exams
spaghetti with marshmallows
stop fighting with crackers
sore shoulders, stupid ergonomics
```

La avidez de \* se puede desactivar con la tecla ?, como en, que ya no
buscará la cadena máxima que satisfaga la condición, con una cadena
menor ya se conforma.

``` markdown
^s(.*?)s$
```

## Resumen

-   Las expresiones regulares se utilizan en muchos lenguajes
    diferentes; no son exclusivas de R.
-   Las expresiones regulares se componen de literales y metacaracteres
    que representan conjuntos o clases de caracteres/palabras
-   El procesamiento de texto a través de expresiones regulares es una
    forma muy poderosa de extraer datos de fuentes “poco amigables” (no
    todos los datos vienen como un archivo CSV)
-   Se utiliza con las funciones `grep`, `grepl`, `sub`, `gsub` y otras
    que implican la búsqueda de cadenas de texto.