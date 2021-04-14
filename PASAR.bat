cls

xcopy "c:\fuentes_actualizar_PB12\*.*" 			"\\AMAZONAS\fuentes_actualizar_PB12" /S /y
xcopy "c:\fuentes_tencer_PB12\*.*"              	"\\AMAZONAS\fuentes_tencer_PB12"  /S /y
xcopy "c:\fuentes_actualizar_PB12\actualizar\*.EXE"	"\\AMAZONAS\tencer_PB12\actualizar"  /S /y
xcopy "c:\fuentes_actualizar_PB12\actualizar\*.DLL"	"\\AMAZONAS\tencer_PB12\actualizar"  /S /y
xcopy "c:\fuentes_actualizar_PB12\actualizar\*.PBD"	"\\AMAZONAS\tencer_PB12\actualizar"  /S /y

xcopy "c:\fuentes_tencer_PB12\*.BAT" /E			"\\AMAZONAS\tencer_PB12\" /S /y
xcopy "c:\fuentes_tencer_PB12\*.ini" /E			"\\AMAZONAS\tencer_PB12\" /S /y
xcopy "c:\fuentes_tencer_PB12\*.pbl"              	"\\AMAZONAS\fuentes_tencer_PB12"  /S /y
xcopy "c:\fuentes_tencer_PB12\*.*"           		"\\AMAZONAS\tencer_PB12" /y
xcopy "c:\fuentes_tencer_PB12\almacenv\*.pbd"	  	"\\AMAZONAS\tencer_PB12" /S /y
xcopy "c:\fuentes_tencer_PB12\cursores\*.pbd"  		"\\AMAZONAS\tencer_PB12"/S /y
xcopy "c:\fuentes_tencer_PB12\cartera\*.pbd"  		"\\AMAZONAS\tencer_PB12" /S /y
xcopy "c:\fuentes_tencer_PB12\conta\*.pbd"     		"\\AMAZONAS\tencer_PB12" /S /y
xcopy "c:\fuentes_tencer_PB12\general\*.pbd"   		"\\AMAZONAS\tencer_PB12" /S /y
xcopy "c:\fuentes_tencer_PB12\mailing\*.pbd"  	 	"\\AMAZONAS\tencer_PB12" /S /y 
xcopy "c:\fuentes_tencer_PB12\ventas\*.pbd"    		"\\AMAZONAS\tencer_PB12" /S /y
xcopy "c:\fuentes_tencer_PB12\decorado\*.pbd" 	 	"\\AMAZONAS\tencer_PB12" /S /y
xcopy "c:\fuentes_tencer_PB12\promocio\*.pbd" 	 	"\\AMAZONAS\tencer_PB12" /S /y
xcopy "c:\fuentes_tencer_PB12\nominas\*.pbd"   		"\\AMAZONAS\tencer_PB12" /S /y
xcopy "c:\fuentes_tencer_PB12\socios\*.pbd"   	 	"\\AMAZONAS\tencer_PB12" /S /y
xcopy "c:\fuentes_tencer_PB12\seguros\*.pbd"  	 	"\\AMAZONAS\tencer_PB12" /S /y
xcopy "c:\fuentes_tencer_PB12\deposito\*.pbd"  		"\\AMAZONAS\tencer_PB12" /S /y
xcopy "c:\fuentes_tencer_PB12\excel\*.pbd"  		"\\AMAZONAS\tencer_PB12" /S /y
xcopy "c:\fuentes_tencer_PB12\excel\*.dll"  		"\\AMAZONAS\tencer_PB12" /S /y
xcopy "c:\fuentes_tencer_PB12\pagos\*.pbd"     		"\\AMAZONAS\tencer_PB12" /S /y
xcopy "c:\fuentes_tencer_PB12\compras\*.pbd" 		"\\AMAZONAS\tencer_PB12" /S /y
xcopy "c:\fuentes_tencer_PB12\produccion\*.pbd"   	"\\AMAZONAS\tencer_PB12" /S /y
xcopy "c:\fuentes_tencer_PB12\planificacion\*.pbd" 	"\\AMAZONAS\tencer_PB12" /S /y
xcopy "c:\fuentes_tencer_PB12\activos\*.pbd"   		"\\AMAZONAS\tencer_PB12" /S /y
xcopy "c:\fuentes_tencer_PB12\RF\*.pbd"   		"\\AMAZONAS\tencer_PB12" /S /y

ECHO "FIN DE LA ACTUALIZACION"
ECHO "NO SE HA ACTUALIZADO ACTUALIZAR DE POWER BUILDER"
ECHO "NO SE PUEDE HACER ROBOCOPY CON MIRROR PUES SE BORRARIAN LAS LIBRERIAS DLL DE POWERBUILDER DE AMAZONAS\Tencer_pb12"

PAUSE
