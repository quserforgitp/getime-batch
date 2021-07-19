@ECHO OFF


REM ---------------------------ACERCA DE ESTE PROGRAMA-------------------------------
REM |        NOMBRE: timer.bat                                                      |
REM |                                                                               |
REM |        VERSION DEL PROGRAMA : V 1.0                                           |
REM |                                                                               |
REM |        DESCRIPCION: EL PROGRAMA MIDE EL TIEMPO DE EJECUCION DE OTROS          |
REM |                     PROGRAMAS BASÁNDOSE EN EL VALOR DE LA PSEUDO VARIABLE     |
REM |                     %TIME% Y PINTA LA DURACION POR PANTALLA                   |
REM |                                                                               |
REM |        AUTOR: HELIOS BARRERA HERNÁNDEZ                                        |
REM |        CONTACTO: adealumnonegligas@gmail.com                                  |
REM |                                                                               |
REM |        NOTAS: 1.-ESTE PROGRAMA UTILIZA EL ESTÁNDAR "A1" EL CUAL DEFINE LO     |
REM |                  SIGUIENTE: 1. LA FORMA EN LA QUE SE NOMBRAN : LAS VARIABLES  |
REM |                                Y LAS FUNCIONES Y EL PROGRAMA                  |
REM |                             2. ESTRUCTURA DEL PROGRAMA                        |
REM |                             3. VALIDACION DE ARGUMENTOS                       |
REM |                             4. INSTRUCTIVO DE USO DEL PROGRMA                 |
REM |                                (ESTRUCTURA DE LA FUNCION "USAGE")             |
REM |                             5. FORMA DE DOCUMENTACION INTERNA Y EXTERNA       |
REM |                             6. ESTRUCTURA DEL DIAGRAMA DE FLUJO               |
REM |                                                                               |
REM |               2.-EL PROGRAMA USA SECUENCIAS DE ESCAPE ANSI PARA COLOREAR LOS  |
REM |                  MENSAJES RELEVANTES POR LO QUE REQUIERE QUE EL SO SEA        |
REM |                  WINDOWS 10 COMPILACION MAYOR A 1909                          |
REM |                                                                               |
REM ---------------------------------------------------------------------------------


TITLE GETIME 

:Function_getTiempoInicial
REM PROCESO_almacenar Tiempo inicial
SET _tInicial=%TIME%

TIMEOUT /T -1 >NUL

:Function_getTiempoFinal
REM PROCESO_almacenar Tiempo final
SET _tFinal=%TIME%

:Function_getUnidades
REM PROCESO_obtener unidades por separado y almacenando como valores numéricos (mediante substring)
::tiempo inicial luego tiempo final (3 y 3 ) 
::INICIALES
SET /A _centiSegInicial=%_tInicial:~9,2%
SET /A _segInicial=%_tInicial:~6,2%
SET /A _minInicial=%_tInicial:~3,2%
SET /A _horaInicial=%_tInicial:~0,2%

::FINALES
SET /A _centiSegFinal=%_tFinal:~9,2%
SET /A _segFinal=%_tFinal:~6,2%
SET /A _minFinal=%_tFinal:~3,2%
SET /A _horaFinal=%_tFinal:~0,2%



REM CONCICIONAL_unidadesTi>unidadesTf -> ALGORITMO DE CONVERSION de lo contrario APLICAR FORMULA

	

REM PROCESO_ALGORITMO DE CONVERSION



:EOF 
EXIT /B 0
REM REVISA LA DOCUMENTACION DE 
:: SET /A /? EL SIGUIENTE TEXTO ES MOSTRADO 
:: 08 y 09 no son números válidos porque 8 y 9 no son dígitos octales válidos.