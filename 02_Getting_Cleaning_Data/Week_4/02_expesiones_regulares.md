Expresiones regulares
================

-   [Expresiones regulares](#expresiones-regulares)
-   [Literales](#literales)
-   [Expresiones regulares](#expresiones-regulares-1)
-   [Metacaracteres](#metacaracteres)
-   [Clases de caracteres con \[\]](#clases-de-caracteres-con-)

## Expresiones regulares

-   Las expresiones regulares pueden considerarse una combinación de
    literales y *metacaracteres*.
-   Para establecer una analogía con el lenguaje natural, piense que el
    texto literal forma las palabras de este lenguaje, y los
    metacaracteres definen su gramática
-   Las expresiones regulares tienen un rico conjunto de metacaracteres

## Literales

El patrón más simple consiste sólo en literales. El literal “nucleares”
coincidiría con alguna de las siguientes líneas:

``` markdown
Ooh. Acabo de aprender que para mantenerme vivo después de varias ¡explosiones *nucleares*! Todo lo que tengo que hacer es ordeñar algunas ratas y luego beber la leche. Fantástico. :}

Laozi dice que las armas *nucleares* son mas macho

El caos en un país que tiene armas *nucleares*... no es bueno.

Mi sobrino está tratando de enseñarme la física de las *nucleares*, o posiblemente sólo intenta mostrarme lo inteligente que es para que esté orgulloso de él [que lo estoy].

LOL si alguna vez dices *nucleares* la gente piensa inmediatamente
Muerte por radiación LOL
```

El literal “Obama” también coincidiría con algunas de las siguientes
líneas:

``` markdown
La política es tonta. No hace mucho tiempo Clinton decía que Obama
era una mierda y ahora dice que hay que votar por él y unirse. ¿WTF?
Que se jodan los dos + Mcain. ¡Vamos Ron Paul!

Clinton concibe a Obama, pero ¿sus seguidores la escucharán?

¿Estamos seguros de que Chelsea no votó por Obama?

pensando ... ¡Michelle Obama es estupenda!

jetlag...sin dormir...temprano en la mañana para starbux..la Sra. Obama
se movía
```

## Expresiones regulares

-   El patrón más simple consiste sólo en literales; se produce una
    coincidencia si la secuencia de literales aparece en cualquier parte
    del texto que se está comprobando

-   ¿Y si sólo queremos la palabra “Obama”? o frases que terminen en la
    palabra “Clinton”, o “clinton” o “clinto”?

Necesitamos una forma de expresar:

-   límites de palabras con espacios en blanco
-   conjuntos de literales
-   el principio y el final de una línea
-   alternativas (“guerra” o “paz”) ¡**Metacaracteres** al rescate!

## Metacaracteres

**^** representa el inicio de una línea. La siguiente expresión:

``` markdown
^i creo
```

Coincidirá con las siguientes líneas:

``` markdown
creo que todos gobernamos por participación
creo que me han descubierto
creo que esto será bastante divertido en realidad
creo que tengo que ir a trabajar
creo que vi por primera vez a zombo en 1999
```

**$** representa el final de una línea. Por lo tanto, la siguiente
expresión:

``` markdown
mañana$
```

Coincidirá con las siguientes líneas:

``` markdown
tuvieron algo esta mañana
tuvieron que coger un tranvía para volver a casa por la mañana
Escuela de obediencia canina por la mañana.
Y sí, feliz cumpleaños, me olvidé de decirlo esta mañana.
Caminé bajo la lluvia esta mañana.
```

## Clases de caracteres con \[\]

Podemos listar un conjunto de caracteres que aceptaremos en nuestra
comprovación.

``` markdown
[Bb][Uu][Ss][Hh]
```

Coincidirá con las líneas en las que encontremos Bush o bush ya sea como
palabra sola, o como parte de otra (bushwalking).

``` markdown
The democrats are playing, "Name the worst thing about Bush!"
I smelled the desert creosote bush, brownies, BBQ chicken
BBQ and bushwalking at Molonglo Gorge
Bush TOLD you that North Korea is part of the Axis of Evil
I’m listening to Bush - Hurricane (Album Version)
```

Evidentemente se pueden combinar para obtener el resultado deseado.

``` markdown
^[Ii] am
```

Coincidirá con:

``` markdown
I am so angry at my boyfriend...
i am boycotting the apple store.
I am twittering from iPhone.
```

De forma similar, puedes especificar un rango de letras \[a-z\] o
\[a-zA-Z\]; observa que el orden no importa. La siguiente expresión
buscará en el inicio de línea un número, seguido por alguna letra.

``` markdown
^[0-9][a-zA-Z]
```

coincidirá con las líneas

``` markdown
7th inning stretch
2nd half soon to begin. OSU did just win something
3am - cant sleep - too hot still.. :(
5ft 7 sent from heaven
1st sign of starvagtion
```

Cuando se utiliza al principio de una clase de caracteres, el “^” es
también un metacarácter e indica los caracteres que NO están en la clase
indicada.

Por ejemplo en la siguiente expresión ^ no indica inicio de línea, sino
que buscamos finales de línea que no tengan un contrainterrogante o un
punto como final.

``` markdown
[^?.]$
```

Coincidirá con las líneas

``` markdown
me gusta el baloncesto
6 y 9
no te preocupes... ¡todos morimos!
No en Bagdad
¿helicóptero bajo el agua? hmmm
```
