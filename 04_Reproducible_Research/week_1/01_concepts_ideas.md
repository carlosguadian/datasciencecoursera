Investigación reproducible. Conceptos e ideas
================

-   [Replicación](#replicación)
-   [¿Qué hay de malo en la
    replicación?](#qué-hay-de-malo-en-la-replicación)
-   [¿Cómo podemos salvar la brecha?](#cómo-podemos-salvar-la-brecha)
-   [¿Por qué necesitamos una investigación
    reproducible?](#por-qué-necesitamos-una-investigación-reproducible)
-   [Ejemplo: Investigación reproducible sobre contaminación atmosférica
    y
    salud](#ejemplo-investigación-reproducible-sobre-contaminación-atmosférica-y-salud)
-   [Research Pipeline](#research-pipeline)
-   [El informe del IOM](#el-informe-del-iom)
-   [¿Qué necesitamos?](#qué-necesitamos)
-   [¿Quiénes son los actores?](#quiénes-son-los-actores)
-   [Desafíos](#desafíos)
-   [En realidad…](#en-realidad)
-   [Programación (estadística)
    alfabetizada](#programación-estadística-alfabetizada)
-   [Limitaciones de Sweave](#limitaciones-de-sweave)
-   [Programación (estadística)
    alfabetizada](#programación-estadística-alfabetizada-1)
-   [Resumen](#resumen)

## Replicación

La norma definitiva para reforzar la evidencia científica es la
replicación de los hallazgos y la realización de estudios con

-   investigadores independientes.  
-   Datos
-   Métodos analíticos
-   Laboratorios
-   Instrumentos

La replicación es especialmente importante en los estudios que pueden
influir en las decisiones políticas o normativas generales

## ¿Qué hay de malo en la replicación?

Algunos estudios no se pueden replicar

-   No hay tiempo, es oportunista
-   No hay dinero
-   Único

Investigación reproducible: Poner a disposición los datos analíticos y
el código para que otros puedan reproducir los resultados

## ¿Cómo podemos salvar la brecha?

Entre la **replicación** y la **nada** tenemos la **reproducibilidad**

## ¿Por qué necesitamos una investigación reproducible?

Las nuevas tecnologías aumentan el rendimiento de la recopilación de
datos; los datos son más complejos y extremadamente dimensionales

Las bases de datos existentes pueden fusionarse en nuevas “megabases de
datos” La potencia de cálculo es mucho mayor, lo que permite realizar
análisis más sofisticados

Para cada campo “X” hay un campo “X computacional”

## Ejemplo: Investigación reproducible sobre contaminación atmosférica y salud

Estimación de pequeños (pero importantes) efectos sobre la salud en
presencia de señales mucho más fuertes

Los resultados informan de decisiones políticas importantes, afectan a
muchas partes interesadas

> La normativa de la EPA puede costar miles de millones de dólares

Se necesitan métodos estadísticos complejos y se someten a un intenso
escrutinio

## Research Pipeline

![Research
Pipeline](https://raw.githubusercontent.com/carlosguadian/datasciencecoursera/master/04_Reproducible_Research/week_1/research_pipeline.png)

## El informe del IOM

En la etapa de descubrimiento/validación de pruebas basadas en la ómica:

-   Los datos/metadatos utilizados para desarrollar la prueba deben
    ponerse a disposición del público
-   El código informático y los procedimientos computacionales
    plenamente especificados utilizados para el desarrollo de la prueba
    candidata basada en la ómica deben estar disponibles de forma
    sostenible
-   “Lo ideal es que el código informático que se publique abarque todos
    los pasos del análisis computacional, incluidos todos los pasos de
    preprocesamiento de datos, que se han descrito en este capítulo.
    Todos los aspectos del análisis deben ser comunicados de forma
    transparente”.

## ¿Qué necesitamos?

-   Los datos analíticos están disponibles
-   El código analítico está disponible
-   Documentación del código y los datos
-   Medios de distribución estándar

## ¿Quiénes son los actores?

Autores

-   Quieren que su investigación sea reproducible
-   Quieren que las herramientas de RR les faciliten la vida (o al menos
    no se la compliquen mucho)

Lectores

-   Quieren reproducir (y quizás ampliar) los resultados interesantes
-   Quieren que las herramientas de RR les faciliten la vida

## Desafíos

-   Los autores deben realizar un esfuerzo considerable para poner los
    datos/resultados en la web (pueden no tener recursos como un
    servidor web)
-   Los lectores deben descargar los datos/resultados de forma
    individual y reunir qué datos van con qué secciones de código, etc.
-   Los lectores pueden no tener los mismos recursos que los autores.
    Pocas herramientas para ayudar a los autores/lectores (¡aunque la
    caja de herramientas está creciendo!)

## En realidad…

Autores

-   Sólo ponen cosas en la web
-   Materiales complementarios de las revistas (infames)
-   Hay algunas bases de datos centrales para varios campos (por
    ejemplo, biología, ICPSR)

Lectores

-   Sólo hay que descargar los datos y (tratar de) entenderlos
-   Armar el software y ejecutarlo

## Programación (estadística) alfabetizada

-   Un artículo es un flujo de texto y código
-   El código de análisis se divide en “trozos” de texto y código
-   Cada trozo de código carga los datos y calcula los resultados
-   El código de presentación da formato a los resultados (tablas,
    figuras, etc.)
-   El texto del artículo explica lo que ocurre
-   Los programas literarios pueden tejerse para producir documentos
    legibles para el ser humano y enredarse para producir documentos
    legibles para la máquina
-   La programación literaria es un concepto general que requiere
    -   Un lenguaje de documentación (legible para el ser humano)
    -   Un lenguaje de programación (legible por la máquina)
-   Sweave utiliza LATEX y R como lenguajes de documentación y
    programación
-   Sweave fue desarrollado por Friedrich Leisch (miembro del núcleo
    de R) y es mantenido por el núcleo de R
-   Sitio web principal: <http://www.statistik.lmu.de/~leisch/Sweave>

## Limitaciones de Sweave

-   Sweave tiene muchas limitaciones
-   Se centra principalmente en LaTeX, un lenguaje de marcado difícil de
    aprender que sólo utilizan los bichos raros
-   Carece de características como el almacenamiento en caché, múltiples
    gráficos por trozo, mezcla de lenguajes de programación y muchos
    otros elementos técnicos
-   No se actualiza con frecuencia ni se desarrolla muy activamente

## Programación (estadística) alfabetizada

-   knitr es un paquete alternativo (más reciente)
-   Reúne muchas características añadidas a Sweave para solucionar las
    limitaciones
-   knitr utiliza R como lenguaje de programación (aunque se permiten
    otros) y una variedad de lenguajes de documentación
    -   LaTeX, Markdown, HTML
-   knitr fue desarrollado por Yihui Xie (mientras era estudiante de
    posgrado en estadística en Iowa State)
-   Ver <http://yihui.name/knitr/>

## Resumen

-   La investigación reproducible es importante como norma mínima, sobre
    todo para los estudios que son difíciles de replicar
-   Se necesita una infraestructura para crear y distribuir documentos
    reproducibles, más allá de lo que está disponible actualmente
-   Hay un número creciente de herramientas para crear documentos
    reproducibles
