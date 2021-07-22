@ECHO OFF


REM ---------------------------ACERCA DE ESTE PROGRAMA-------------------------------
REM |        NOMBRE: timer.bat                                                      |
REM |                                                                               |
REM |        VERSION DEL PROGRAMA : V 1.0                                           |
REM |                                                                               |
REM |        DESCRIPCION: EL PROGRAMA MIDE EL TIEMPO DE EJECUCION DE OTROS          |
REM |                     PROGRAMAS BASÁNDOSE EN EL VALOR DE LA PSEUDO VARIABLE     |
REM |                     !TIME! Y PINTA LA DURACION POR PANTALLA                   |
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

SETLOCAL EnableDelayedExpansion

:Function_setTiempoInicial
REM PROCESO_almacenar Tiempo inicial
SET _tInicial=%TIME%
::quitar timeout y añadir soporte para programa
TIMEOUT /T -1 >NUL 

:Function_setTiempoFinal
REM PROCESO_almacenar Tiempo final
SET _tFinal=%TIME%

:Function_setMostrarTiempos
ECHO INICIO !_tInicial!
ECHO FINAL !_tFinal!


:Function_setUnidades
REM PROCESO_obtener unidades por separado y almacenando como valores numéricos (mediante substring)
::tiempo inicial luego tiempo final (3 y 3 ) 
:::INICIALES
SET _centiSegInicial=!_tInicial:~9,2!
SET _segInicial=!_tInicial:~6,2!
SET _minInicial=!_tInicial:~3,2!
SET _horaInicial=!_tInicial:~0,2!

::CONDICIONALES BUG OCTALES
:::INICIALES
IF [!_centiSegInicial!] EQU [08] (SET /A _centiSegInicial=8 2> NUL &&echo !_centiSegInicial!) ELSE (SET /A _centiSegInicial=!_tInicial:~9,2! 2>NUL)
IF [!_centiSegInicial!] EQU [09] (SET /A _centiSegInicial=9 2> NUL &&echo !_centiSegInicial!) ELSE (SET /A _centiSegInicial=!_tInicial:~9,2! 2>NUL)
IF [!_segInicial!] EQU [08] (SET /A _segInicial=8 2> NUL &&echo !_segInicial!) ELSE (SET /A _SegInicial=!_tInicial:~6,2! 2>NUL)
IF [!_segInicial!] EQU [09] (SET /A _segInicial=9 2> NUL &&echo !_segInicial!) ELSE (SET /A _SegInicial=!_tInicial:~6,2! 2>NUL)
IF [!_minInicial!] EQU [08] (SET /A _minInicial=8 2> NUL &&echo !_minInicial!) ELSE (SET /A _minInicial=!_tInicial:~3,2! 2>NUL)
IF [!_minInicial!] EQU [09] (SET /A _minInicial=9 2> NUL &&echo !_minInicial!) ELSE (SET /A _minInicial=!_tInicial:~3,2! 2>NUL)
IF [!_horaInicial!] EQU [08] (SET /A _horaInicial=8 2> NUL &&echo !_horaInicial!) ELSE (SET /A _horaInicial=!_tInicial:~0,2! 2>NUL)
IF [!_horaInicial!] EQU [09] (SET /A _horaInicial=9 2> NUL &&echo !_horaInicial!) ELSE (SET /A _horaInicial=!_tInicial:~0,2! 2>NUL)

:::FINALES
SET _centiSegFinal=!_tFinal:~9,2!
SET _segFinal=!_tFinal:~6,2!
SET _minFinal=!_tFinal:~3,2!
SET _horaFinal=!_tFinal:~0,2!

::CONDICIONALES BUG OCTALES
:::FINALES
IF [!_centiSegFinal!] EQU [08] (SET /A _centiSegFinal=8 2> NUL &&echo !_centiSegFinal!) ELSE (SET /A _centiSegFinal=!_tFinal:~9,2! 2>NUL)
IF [!_centiSegFinal!] EQU [09] (SET /A _centiSegFinal=9 2> NUL &&echo !_centiSegFinal!) ELSE (SET /A _centiSegFinal=!_tFinal:~9,2! 2>NUL)
IF [!_segFinal!] EQU [08] (SET /A _segFinal=8 2> NUL &&echo !_segFinal!) ELSE (SET /A _SegFinal=!_tFinal:~6,2! 2>NUL)
IF [!_segFinal!] EQU [09] (SET /A _segFinal=9 2> NUL &&echo !_segFinal!) ELSE (SET /A _SegFinal=!_tFinal:~6,2! 2>NUL)
IF [!_minFinal!] EQU [08] (SET /A _minFinal=8 2> NUL &&echo !_minFinal!) ELSE (SET /A _minFinal=!_tFinal:~3,2! 2>NUL)
IF [!_minFinal!] EQU [09] (SET /A _minFinal=9 2> NUL &&echo !_minFinal!) ELSE (SET /A _minFinal=!_tFinal:~3,2! 2>NUL)
IF [!_horaFinal!] EQU [08] (SET /A _horaFinal=8 2> NUL &&echo !_horaFinal!) ELSE (SET /A _horaFinal=!_tFinal:~0,2! 2>NUL)
IF [!_horaFinal!] EQU [09] (SET /A _horaFinal=9 2> NUL &&echo !_horaFinal!) ELSE (SET /A _horaFinal=!_tFinal:~0,2! 2>NUL)

REM CONCICIONAL_unidadesTi>unidadesTf -> ALGORITMO DE CONVERSION de lo contrario APLICAR FORMULA
IF !_centiSegInicial! GTR !_centiSegFinal! (
	GOTO Function_setAlgoritmoConversionCentiSeg
	) 
IF !_segInicial! GTR !_segFinal! (
	GOTO Function_setAlgoritmoConversionSeg
	)
IF !_minInicial! GTR !_minFinal! (
	GOTO Function_setAlgoritmoConversionMin
	) ELSE (
		GOTO Function_setAplicarFormula
	)	

REM PROCESO_ALGORITMO DE CONVERSION
:Function_setAlgoritmoConversionCentiSeg
SET /A _centiSegFinal += 100
SET /A _segFinal -= 1

REM CONCICIONAL_para determinar si es necesaria la conversion siguiente unidad
IF !_segInicial! GTR !_segFinal! (
	GOTO Function_setAlgoritmoConversionSeg
	) ELSE (
		IF !_minInicial! GTR !_minFinal! (
			GOTO Function_setAlgoritmoConversionMin
			) ELSE (
				GOTO Function_setAplicarFormula
				)
		)

:Function_setAlgoritmoConversionSeg
SET /A _SegFinal += 60
SET /A _minFinal -= 1

IF !_minInicial! GTR !_minFinal! (
	GOTO Function_setAlgoritmoConversionMin
	) ELSE (
		GOTO Function_setAplicarFormula
		)

:Function_setAlgoritmoConversionMin
SET /A _minFinal += 60
SET /A _horaFinal -= 1


:Function_setAplicarFormula
REM FORMULA_ Duracion = TF - TI.
SET /A _horaDuracion = !_horaFinal! - !_horaInicial!
SET /A _minDuracion = !_minFinal! - !_minInicial!
SET /A _segDuracion = !_segFinal! - !_segInicial!
SET /A _centiSegDuracion = !_centiSegFinal! - !_centiSegInicial!


:Function_setMostrarDuracion
ECHO DURACION:
ECHO !_horaDuracion!:!_minDuracion!:!_segDuracion!.!_centiSegDuracion!

:EOF 
EXIT /B 0
REM REVISA LA DOCUMENTACION DE 
:: SET /A /? EL SIGUIENTE TEXTO ES MOSTRADO 
:: 08 y 09 no son números válidos porque 8 y 9 no son dígitos octales válidos.