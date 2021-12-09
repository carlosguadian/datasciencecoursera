Debugging - Basic Tools
================
Carlos Guadián

-   [Basic Tools](#basic-tools)
-   [traceback()](#traceback)
-   [debug](#debug)
-   [recover](#recover)

## Basic Tools

Las herramientas básicas en R para identificar errores son:

-   traceback(): imprime la pila de llamadas de la función después de un
    error; no hace nada si no hay error
-   debug(): marca una función para el modo “debug” que permite recorrer
    la ejecución de una función línea por línea
-   browser(): suspende la ejecución de una función allí donde es
    llamada y pone la función en modo de depuración
-   trace(): permite insertar código de depuración en una función en
    lugares específicos
-   recover(): permite modificar el comportamiento del error para poder
    navegar por la pila de llamadas de la función

## traceback()

La función traceback() imprime la pila de llamadas a funciones después
de que se haya producido un error. La pila de llamadas a funciones es la
secuencia de funciones que fue llamada antes de que ocurriera el error.

Para el caso que no tengamos definida “x” si intentamos hacer la media…

mean(x) Error in mean(x) : objeto ‘x’ no encontrado

Si usamos traceback() para localizar el error, deber ser justo después,
ya que nos localizará el último error ocurrido.

traceback()

1: mean(x)

## debug

Con debug podemos marcar una función para analizarla línea por línea.

debug(lm)

lm(x \~ y)

# recover

Permite parar la ejecución justo cuando se produce un error para
modificarlo.
