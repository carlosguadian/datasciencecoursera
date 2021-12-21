Introducción a la inferencia estadística
================

## Definición de la inferencia estadística

La inferencia estadística es el proceso de sacar conclusiones formales a
partir de los datos.

Definiremos la **inferencia estadística** formal como los entornos en
los que se desea inferir hechos sobre una población utilizando datos
estadísticos ruidosos en los que debe tenerse en cuenta la
incertidumbre.

## Ejemplo: ¿quién va a ganar las elecciones?

En todas las elecciones importantes, los encuestadores quieren saber,
antes de las elecciones, quién va a ganar. En este caso, el objetivo de
estimación (el estimando) es claro, el porcentaje de personas en un
grupo concreto (ciudad, estado, condado, país u otra agrupación
electoral) que votarán a cada candidato.

No podemos encuestar a todo el mundo. Incluso si pudiéramos, algunos
encuestados pueden cambiar su voto en el momento de las elecciones.
¿Cómo podemos recoger un subconjunto razonable de datos y cuantificar la
incertidumbre en el proceso para obtener una buena estimación de quién
ganará?

## Ejemplo: ¿es eficaz la terapia de sustitución hormonal?

Un gran ensayo clínico (la Iniciativa para la Salud de la Mujer) publicó
en 2002 resultados que contradecían las pruebas anteriores sobre la
eficacia de la terapia hormonal sustitutiva para las mujeres
posmenopáusicas y sugerían un impacto negativo de la TRH en varios
resultados clave para la salud. **Basado en un protocolo estadístico, el
estudio se detuvo antes de tiempo debido a un número excesivo de eventos
negativos.**

Aquí hay dos problemas de inferencia.

1.  ¿Es efectiva la THS?
2.  ¿Cuánto tiempo debemos continuar el ensayo en presencia de evidencia
    contraria?

Ver el documento del grupo de redacción del WHI JAMA 2002, Vol 288:321 -
333. para el documento y Steinkellner et al. Menopause 2012, Vol 19:616
621 para adiscutir los impactos a largo plazo

## Ejemplo: Activación cerebral

![estudio fMRI del
salmón](https://raw.githubusercontent.com/bcaffo/courses/master/06_StatisticalInference/01_Introduction/fig/fmri-salmon.jpg)

[Scanning Dead Salmon in fMRI Machine Highlights Risk of Red
Herrings](http://www.wired.com/2009/09/fmrisalmon/)

## Resumen

-   Estos ejemplos ilustran muchas de las dificultades de intentar
    utilizar los datos para crear conclusiones generales sobre una
    población.
-   Las principales preocupaciones son:
    -   ¿Es la muestra representativa de la población sobre la que
        queremos hacer inferencias?
    -   ¿Hay variables conocidas y observadas, conocidas y no observadas
        o desconocidas y no observadas que contaminen nuestras
        conclusiones?
    -   ¿Existe un sesgo sistemático creado por los datos que faltan o
        por el diseño o la realización del estudio?
    -   ¿Qué aleatoriedad existe en los datos y cómo la utilizamos o
        ajustamos? Aquí la aleatoriedad puede ser explícita a través de
        la aleatorización o el muestreo aleatorio, o implícita como la
        agregación de muchos procesos complejos desconocidos.
    -   ¿Intentamos estimar un modelo mecanicista subyacente de los
        fenómenos en estudio?
-   La inferencia estadística requiere navegar por el conjunto de
    supuestos y herramientas y, posteriormente, pensar en cómo extraer
    conclusiones de los datos.

## Ejemplos de objetivos de la inferencia

1.  Estimar y cuantificar la incertidumbre de una estimación de una
    cantidad de población (la proporción de personas que votan a un
    candidato).
2.  Determinar si una cantidad de población es un valor de referencia
    (“¿es eficaz el tratamiento?”).
3.  Inferir una relación mecánica cuando las cantidades se miden con
    ruido (“¿Cuál es la pendiente de la ley de Hooke?”).
4.  Determinar el impacto de una política. (“Si reducimos los niveles de
    contaminación ¿disminuirán las tasas de asma?”)
5.  Hablar de la probabilidad de que algo ocurra.

## Ejemplo de técnicas utilizadas

1.  Aleatorización: se ocupa de equilibrar las variables no observadas
    que pueden confundir las inferencias de interés
2.  Muestreo aleatorio: tiene por objeto obtener datos representativos
    de la de la población de interés
3.  Modelos de muestreo: se trata de crear un modelo para el proceso de
    muestreo, el más común es el llamado “iid”.
4.  Pruebas de hipótesis: se ocupan de la toma de decisiones en
    presencia de incertidumbre
5.  Intervalos de confianza: tratan de cuantificar la incertidumbre en
    estimación
6.  Modelos de probabilidad: conexión formal entre los datos y una
    población de interés. A menudo, los modelos de probabilidad se
    asumen o se aproximados.
7.  Diseño del estudio: proceso de diseño de un experimento para
    minimizar los sesgos y la variabilidad.
8.  Bootstrap no paramétrico: el proceso de utilizar los datos para, con
    un mínimo de supuestos del modelo de probabilidad, crear
    inferencias, con supuestos mínimos del modelo de probabilidad, crear
    inferencias.
9.  Pruebas de permutación, aleatorización e intercambiabilidad: el
    proceso de utilizar permutaciones de datos para realizar
    inferencias.

## Un pensamiento diferente sobre la probabilidad conduce a diferentes estilos de inferencia

No vamos a dedicar mucho tiempo a hablar de esto, pero hay varios
estilos diferentes estilos de inferencia. Dos grandes categorías que se
discuten mucho son:

1.  La probabilidad de frecuencia: es la proporción a largo plazo de
    veces que ocurre un evento en repeticiones independientes e
    idénticamente distribuidas. independientes e idénticas.
2.  Inferencia frecuencial: utiliza interpretaciones frecuenciales de
    las probabilidades para controlar las tasas de error. Responde a
    preguntas como “¿Qué debo decidir dados mis datos controlar la
    proporción de errores a largo plazo que cometo en un nivel
    tolerable”.
3.  Probabilidad bayesiana: es el cálculo de la probabilidad de las
    creencias, dado que las creencias siguen ciertas reglas.
4.  Inferencia bayesiana: es el uso de la representación probabilística
    bayesiana de las creencias para realizar la inferencia. Responde a
    preguntas como “Dadas mis creencias subjetivas y la información
    objetiva de los datos, ¿qué debería creer ahora?”.

Los científicos de datos tienden a situarse dentro de los matices de
estas y otras escuelas de inferencia.

## En este curso

-   En este curso, nos centraremos principalmente en los modelos básicos
    de muestreo, modelos básicos de probabilidad y análisis de estilo de
    frecuencia para crear inferencias estándar.
-   Al ser científicos de datos, también consideraremos algunas
    estrategias inferenciales que dependen en gran medida de los datos
    observados, como las pruebas de permutación y el bootstrapping.
-   Como la modelización de la probabilidad será nuestro punto de
    partida, primero construiremos la probabilidad básica.

## Dónde aprender más sobre los temas no cubiertos

-   Uso explícito del muestreo aleatorio en las inferencias: busque en
    las referencias sobre “estadística de poblaciones finitas”. Se
    utiliza mucho en los sondeos y encuestas por muestreo.
-   Uso explícito de la aleatoriedad en las inferencias: busque en las
    referencias sobre “inferencia causal”, especialmente en los ensayos
    clínicos.
-   Probabilidad bayesiana y estadística bayesiana: busque libros
    introductorios básicos (hay muchos).
-   Datos ausentes: bien tratados en las referencias de bioestadística y
    econometría referencias de bioestadística y econometría; busque
    referencias a la “imputación múltiple”, una herramienta popular para
    tratar los datos que faltan.
-   Diseño de estudios: considere la posibilidad de buscar en el área
    temática que algunos ejemplos con una rica historia de diseño:
    -   La literatura epidemiológica está muy centrada en el uso del
        diseño de estudios para investigar la salud pública.
    -   El desarrollo clásico del diseño de estudios en la agricultura
        abarca ampliamente el diseño y los principios de diseño.
    -   La bibliografía sobre el control de calidad industrial abarca el
        diseño en profundidad.
