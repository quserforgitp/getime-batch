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

:GLOBAL
SET CONST_Rcolor=[0m
SET CONST_LVerdeClaro=[92m
SET CONST_LRojoOscuro=[31m
SET CONST_LAmarillas=[93m
SET CONST_LAzulOscuro=[36m
SET CONST_LAzulClaro=[96m
SET CONST_LGrisOscuro=[90m
SET CONST_LBlanco=[97m
SET CONST_FGrisClaro=[47m
SET CONST_FGrisOscuro=[100m
SET CONST_FVerde=[42m                  

:ARGS
SET _ARGS=%*
SET _ARGSexe=string
SET /A _ARGSnum=0
SET /A _ARGopBoolAnsi=10
SET /A _ARGopBoolDefault=10

rem debug_todos los argumentos
::ECHO LOS ARGUMENTOS SON -^> !_ARGS!

REM FOR_obtiene el numero de argumentos
FOR %%a IN (%*) DO (
	SET /A _ARGSnum += 1
	)

rem debug_numero de argumentos
::ECHO NUMERO DE ARGUMENTOS -^> !_ARGSnum! 

rem CONCICIONAL_no hay argumentos o el usuario solicita el manual de uso (USAGE)
IF !_ARGSnum! LSS 1 (
	GOTO USAGE
	)
	
REM FOR_asigna ultimo argumento a _ARGSexe	
FOR %%b IN (%*) DO (
	SET _ARGSexe=%%b
	)

REM CONDICIONAL_puso opcion en lugar de nombre de ejecutable
IF "!_ARGSexe!" EQU "-a" (
	GOTO ARGS_ErrorSintaxis
	) ELSE (
		IF "!_ARGSexe!" EQU "-A" (
			GOTO ARGS_ErrorSintaxis
			)
		)
	
rem debug_	argumento ejecutable
::ECHO ARGUMENTO EJECUTABLE -^> !_ARGSexe!

:ARGS_opcionesActivas
REM ansi activo (-a)
ECHO !_ARGS! | FIND /I "-a" >NUL
IF !ERRORLEVEL! NEQ 0 (
	SET /A _ARGopBoolAnsi=0	
	) ELSE (
		SET /A _ARGopBoolAnsi=1
		)

IF !_ARGopBoolAnsi! EQU 0 (
	ECHO ANSI DESACTIVADO
	) ELSE (
		ECHO ANSI ACTIVADO
		)

REM comportamiento predeterminado
ECHO !_ARGS! | FIND /I "-d" >NUL
IF !ERRORLEVEL! NEQ 0 (
	SET /A _ARGopBoolDefault=0	
	) ELSE (
		SET /A _ARGopBoolDefault=1
		)
REM CONDICIONAL_el usuario quiere el comportamiento predeterminado
IF !_ARGopBoolDefault! EQU 1 (
	GOTO DEFAULT
	) 
		
GOTO Function_setTiempoInicial
:ARGS_ErrorSintaxis
ECHO ERROR SINTACTICO 
TIMEOUT /T -1 >NUL
GOTO USAGE


:Function_setTiempoInicial
REM PROCESO_almacenar Tiempo inicial
SET _tInicial=%TIME%

IF !_ARGopBoolAnsi! EQU 1 (
	GOTO Function_setMensajeMidiendoEjecucionConAnsi
	) ELSE (
		GOTO Function_setMensajeMidiendoEjecucionSinAnsi)

:Function_setMensajeMidiendoEjecucionSinAnsi
::quitar timeout y añadir soporte para programa
ECHO MIDIENDO EL TIEMPO DE EJECUCION DE -^> !_ARGSexe!

CALL !_ARGSexe! 2>NUL
IF !ERRORLEVEL! NEQ 0 (
	IF !ERRORLEVEL! EQU 9009 (
		GOTO Function_setTiempoFinal
		) ELSE (
			ECHO NO SE ENCONTRO EL EJECUTABLE --^> !_ARGSexe!
			TIMEOUT /T -1 >NUL
			GOTO EOF
			)
	)

GOTO Function_setTiempoFinal
:Function_setMensajeMidiendoEjecucionConAnsi

ECHO %CONST_FGrisOscuro%MIDIENDO EL TIEMPO DE EJECUCION DE -^> %CONST_LVerdeClaro%!_ARGSexe!%CONST_Rcolor%

CALL !_ARGSexe! 2>NUL
IF !ERRORLEVEL! NEQ 0 (
	IF !ERRORLEVEL! EQU 9009 (
		GOTO Function_setTiempoFinal
		) ELSE (
			ECHO NO SE ENCONTRO EL EJECUTABLE --^> %CONST_LRojoOscuro%!_ARGSexe!%CONST_Rcolor%
			TIMEOUT /T -1 >NUL
			GOTO EOF
			)
	)
	
:Function_setTiempoFinal
REM PROCESO_almacenar Tiempo final
SET _tFinal=%TIME%

IF !_ARGopBoolAnsi! EQU 1 (
	GOTO Function_setMostrarTiemposConAnsi
	)
	
:Function_setMostrarTiemposSinAnsi
ECHO INICIO !_tInicial!
ECHO FINAL  !_tFinal!


GOTO Function_setUnidades
:Function_setMostrarTiemposConAnsi
ECHO %CONST_FGrisOscuro%%CONST_LAzulClaro%INICIO%CONST_Rcolor% %CONST_FGrisOscuro%%CONST_LBlanco%!_tInicial!%CONST_Rcolor%
ECHO %CONST_FGrisClaro%%CONST_LAzulOscuro%FINAL%CONST_Rcolor% %CONST_FGrisOscuro%%CONST_LBlanco%!_tFinal!%CONST_Rcolor%


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
IF [!_centiSegInicial!] EQU [08] (SET /A _centiSegInicial=8 2> NUL ) ELSE (SET /A _centiSegInicial=!_tInicial:~9,2! 2>NUL)
IF [!_centiSegInicial!] EQU [09] (SET /A _centiSegInicial=9 2> NUL ) ELSE (SET /A _centiSegInicial=!_tInicial:~9,2! 2>NUL)
IF [!_segInicial!] EQU [08] (SET /A _segInicial=8 2> NUL ) ELSE (SET /A _SegInicial=!_tInicial:~6,2! 2>NUL)
IF [!_segInicial!] EQU [09] (SET /A _segInicial=9 2> NUL ) ELSE (SET /A _SegInicial=!_tInicial:~6,2! 2>NUL)
IF [!_minInicial!] EQU [08] (SET /A _minInicial=8 2> NUL ) ELSE (SET /A _minInicial=!_tInicial:~3,2! 2>NUL)
IF [!_minInicial!] EQU [09] (SET /A _minInicial=9 2> NUL ) ELSE (SET /A _minInicial=!_tInicial:~3,2! 2>NUL)
IF [!_horaInicial!] EQU [08] (SET /A _horaInicial=8 2> NUL ) ELSE (SET /A _horaInicial=!_tInicial:~0,2! 2>NUL)
IF [!_horaInicial!] EQU [09] (SET /A _horaInicial=9 2> NUL ) ELSE (SET /A _horaInicial=!_tInicial:~0,2! 2>NUL)

:::FINALES
SET _centiSegFinal=!_tFinal:~9,2!
SET _segFinal=!_tFinal:~6,2!
SET _minFinal=!_tFinal:~3,2!
SET _horaFinal=!_tFinal:~0,2!

::CONDICIONALES BUG OCTALES
:::FINALES
IF [!_centiSegFinal!] EQU [08] (SET /A _centiSegFinal=8 2> NUL ) ELSE (SET /A _centiSegFinal=!_tFinal:~9,2! 2>NUL)
IF [!_centiSegFinal!] EQU [09] (SET /A _centiSegFinal=9 2> NUL ) ELSE (SET /A _centiSegFinal=!_tFinal:~9,2! 2>NUL)
IF [!_segFinal!] EQU [08] (SET /A _segFinal=8 2> NUL ) ELSE (SET /A _SegFinal=!_tFinal:~6,2! 2>NUL)
IF [!_segFinal!] EQU [09] (SET /A _segFinal=9 2> NUL ) ELSE (SET /A _SegFinal=!_tFinal:~6,2! 2>NUL)
IF [!_minFinal!] EQU [08] (SET /A _minFinal=8 2> NUL ) ELSE (SET /A _minFinal=!_tFinal:~3,2! 2>NUL)
IF [!_minFinal!] EQU [09] (SET /A _minFinal=9 2> NUL ) ELSE (SET /A _minFinal=!_tFinal:~3,2! 2>NUL)
IF [!_horaFinal!] EQU [08] (SET /A _horaFinal=8 2> NUL ) ELSE (SET /A _horaFinal=!_tFinal:~0,2! 2>NUL)
IF [!_horaFinal!] EQU [09] (SET /A _horaFinal=9 2> NUL ) ELSE (SET /A _horaFinal=!_tFinal:~0,2! 2>NUL)

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

REM CONDICIONAL_mostrar ansi o no mostrar ansi 
IF !_ARGopBoolAnsi! EQU 1 (
	GOTO Function_setMostrarDuracionConAnsi 
	)

:Function_setMostrarDuracionSinAnsi
ECHO DURACION:
ECHO !_horaDuracion!:!_minDuracion!:!_segDuracion!.!_centiSegDuracion!

GOTO EOF
:Function_setMostrarDuracionConAnsi
ECHO %CONST_LVerdeClaro%DURACION:%CONST_Rcolor%
ECHO %CONST_FGrisOscuro%%CONST_LAmarillas%!_horaDuracion!:!_minDuracion!:!_segDuracion!.!_centiSegDuracion!%CONST_Rcolor%

GOTO EOF
:USAGE
ECHO.
ECHO Uso: getime [-a] ^<executable_name^>
ECHO.
ECHO Opciones: 
ECHO -a                    Habilita el soporte para las secuencias de escape ANSI
ECHO                       (Muestra los mensajes coloreados). (El numero de compilacion
ECHO                       de tu sistema debe ser 1909 o mayor). Si puedes ver  
ECHO                              %CONST_LVerdeClaro%Este texto en verde.%CONST_Rcolor%
ECHO                       Tu sistema soporta las secuencias de escape ANSI.
ECHO -d                    Usa el comportamiento predeterminado.
ECHO                       No mide el tiempo de otro programa sino que mide el tiempo de
ECHO                       ejecucion de si mismo sin ansi.
ECHO                       Si se activa la opcion, no importa si haz especificado otro
ECHO                       argumento, se anulan todos los demas y se usa el comportamiento 
ECHO                       predeterminado.
ECHO.                  

GOTO EOF
:DEFAULT
:Function_DEFAULT_setTiempoInicial
REM PROCESO_almacenar Tiempo inicial
SET _tInicial=%TIME%

:Function_DEFAULT_setMensajeMidiendoEjecucionSinAnsi
ECHO MIDIENDO EL TIEMPO DE EJECUCION DEL PROPIO PROGRAMA
TIMEOUT /T -1 >NUL	
	
:Function_DEFAULT_setTiempoFinal
REM PROCESO_almacenar Tiempo final
SET _tFinal=%TIME%
	
	
:Function_DEFAULT_setMostrarTiemposSinAnsi
ECHO INICIO !_tInicial!
ECHO FINAL  !_tFinal!


:Function_DEFAULT_setUnidades
REM PROCESO_obtener unidades por separado y almacenando como valores numéricos (mediante substring)
::tiempo inicial luego tiempo final (3 y 3 ) 
:::INICIALES
SET _centiSegInicial=!_tInicial:~9,2!
SET _segInicial=!_tInicial:~6,2!
SET _minInicial=!_tInicial:~3,2!
SET _horaInicial=!_tInicial:~0,2!

::CONDICIONALES BUG OCTALES
:::INICIALES
IF [!_centiSegInicial!] EQU [08] (SET /A _centiSegInicial=8 2> NUL ) ELSE (SET /A _centiSegInicial=!_tInicial:~9,2! 2>NUL)
IF [!_centiSegInicial!] EQU [09] (SET /A _centiSegInicial=9 2> NUL ) ELSE (SET /A _centiSegInicial=!_tInicial:~9,2! 2>NUL)
IF [!_segInicial!] EQU [08] (SET /A _segInicial=8 2> NUL ) ELSE (SET /A _SegInicial=!_tInicial:~6,2! 2>NUL)
IF [!_segInicial!] EQU [09] (SET /A _segInicial=9 2> NUL ) ELSE (SET /A _SegInicial=!_tInicial:~6,2! 2>NUL)
IF [!_minInicial!] EQU [08] (SET /A _minInicial=8 2> NUL ) ELSE (SET /A _minInicial=!_tInicial:~3,2! 2>NUL)
IF [!_minInicial!] EQU [09] (SET /A _minInicial=9 2> NUL ) ELSE (SET /A _minInicial=!_tInicial:~3,2! 2>NUL)
IF [!_horaInicial!] EQU [08] (SET /A _horaInicial=8 2> NUL ) ELSE (SET /A _horaInicial=!_tInicial:~0,2! 2>NUL)
IF [!_horaInicial!] EQU [09] (SET /A _horaInicial=9 2> NUL ) ELSE (SET /A _horaInicial=!_tInicial:~0,2! 2>NUL)

:::FINALES
SET _centiSegFinal=!_tFinal:~9,2!
SET _segFinal=!_tFinal:~6,2!
SET _minFinal=!_tFinal:~3,2!
SET _horaFinal=!_tFinal:~0,2!

::CONDICIONALES BUG OCTALES
:::FINALES
IF [!_centiSegFinal!] EQU [08] (SET /A _centiSegFinal=8 2> NUL ) ELSE (SET /A _centiSegFinal=!_tFinal:~9,2! 2>NUL)
IF [!_centiSegFinal!] EQU [09] (SET /A _centiSegFinal=9 2> NUL ) ELSE (SET /A _centiSegFinal=!_tFinal:~9,2! 2>NUL)
IF [!_segFinal!] EQU [08] (SET /A _segFinal=8 2> NUL ) ELSE (SET /A _SegFinal=!_tFinal:~6,2! 2>NUL)
IF [!_segFinal!] EQU [09] (SET /A _segFinal=9 2> NUL ) ELSE (SET /A _SegFinal=!_tFinal:~6,2! 2>NUL)
IF [!_minFinal!] EQU [08] (SET /A _minFinal=8 2> NUL ) ELSE (SET /A _minFinal=!_tFinal:~3,2! 2>NUL)
IF [!_minFinal!] EQU [09] (SET /A _minFinal=9 2> NUL ) ELSE (SET /A _minFinal=!_tFinal:~3,2! 2>NUL)
IF [!_horaFinal!] EQU [08] (SET /A _horaFinal=8 2> NUL ) ELSE (SET /A _horaFinal=!_tFinal:~0,2! 2>NUL)
IF [!_horaFinal!] EQU [09] (SET /A _horaFinal=9 2> NUL ) ELSE (SET /A _horaFinal=!_tFinal:~0,2! 2>NUL)

REM CONCICIONAL_unidadesTi>unidadesTf -> ALGORITMO DE CONVERSION de lo contrario APLICAR FORMULA
IF !_centiSegInicial! GTR !_centiSegFinal! (
	GOTO Function_DEFAULT_setAlgoritmoConversionCentiSeg
	) 
IF !_segInicial! GTR !_segFinal! (
	GOTO Function_DEFAULT_setAlgoritmoConversionSeg
	)
IF !_minInicial! GTR !_minFinal! (
	GOTO Function_setAlgoritmoConversionMin
	) ELSE (
		GOTO Function_DEFAULT_setAplicarFormula
	)	

REM PROCESO_ALGORITMO DE CONVERSION
:Function_DEFAULT_setAlgoritmoConversionCentiSeg
SET /A _centiSegFinal += 100
SET /A _segFinal -= 1

REM CONCICIONAL_para determinar si es necesaria la conversion siguiente unidad
IF !_segInicial! GTR !_segFinal! (
	GOTO Function_DEFAULT_setAlgoritmoConversionSeg
	) ELSE (
		IF !_minInicial! GTR !_minFinal! (
			GOTO Function_DEFAULT_setAlgoritmoConversionMin
			) ELSE (
				GOTO Function_DEFAULT_setAplicarFormula
				)
		)

:Function_DEFAULT_setAlgoritmoConversionSeg
SET /A _SegFinal += 60
SET /A _minFinal -= 1

IF !_minInicial! GTR !_minFinal! (
	GOTO Function_DEFAULT_setAlgoritmoConversionMin
	) ELSE (
		GOTO Function_setAplicarFormula
		)

:Function_DEFAULT_setAlgoritmoConversionMin
SET /A _minFinal += 60
SET /A _horaFinal -= 1


:Function_DEFAULT_setAplicarFormula
REM FORMULA_ Duracion = TF - TI.
SET /A _horaDuracion = !_horaFinal! - !_horaInicial!
SET /A _minDuracion = !_minFinal! - !_minInicial!
SET /A _segDuracion = !_segFinal! - !_segInicial!
SET /A _centiSegDuracion = !_centiSegFinal! - !_centiSegInicial!


:Function_DEFAULT_setMostrarDuracionSinAnsi
ECHO DURACION:
ECHO !_horaDuracion!:!_minDuracion!:!_segDuracion!.!_centiSegDuracion!


:EOF 
EXIT /B 0
REM REVISA LA DOCUMENTACION DE 
:: SET /A /? EL SIGUIENTE TEXTO ES MOSTRADO 
:: 08 y 09 no son números válidos porque 8 y 9 no son dígitos octales válidos.