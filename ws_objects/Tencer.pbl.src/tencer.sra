$PBExportHeader$tencer.sra
forward
global type tencer from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
//   Version Modulo //
//--------------------------- //
STring version = "5.03-7"

// PARA EL EURO
dec cambio_euro = 166.386
string moneda_euro = "7"
string moneda_peseta = "1"

string   codigo_empresa,nombre_usuario,codigo_idioma,moneda_empresa_primaria,moneda_empresa_secundaria
string   gs_usuarios_v_grupo,gs_utigrupos_codigo_acceso_total = '12'
boolean valor_empresa
string   clave,parent_mensaje,control_tiempo_limite
DateTime fecha_conexion
Dec{0} tiempo_limite
Dec{0} empresa_decimal,ejercicio_activo
DateTime la_hora = datetime(Today(),Now())
String fichero_ini = "C:\TENCER\tencer.ini"
String logotipo ="\bmp\tencer.bmp"
String texto_logotipo = "TENCER"
//Window ventana_activa,ventana_padre
window ventana_padre
string nacional, tipo_vista,control_mensajes= "N", gs_formato_fecha_cursores = "dd/mm/yyyy", formato_fecha_cursores = "dd/mm/yyyy"
Integer n_aplicaciones = 0 // Numero de aplicaciones abiertas

Transaction trans_cursor
Transaction trans
Transaction trans2
Transaction trans_ts  //Transaccion Serializable (Máximo nivel de "Isolation")

string global_base_datos
string global_servidor

str_ventanas_activas ventanas_activas[25]
Long numero_ventanas_activas

Long traspaso_numero_nodos

//Gestion Documental
string directorio_gestion_documental = '\\Amazonas\usuarios\TODOS\ERP\GESTION DOCUMENTAL\'

//Menus usuarios
uo_menu_usuarios guo_menu_usuarios
uo_menu_utigrupos guo_menu_utigrupos

//Nueva Gestion de Reservas
boolean ib_nueva_gestion_de_reservas = true //false
end variables
global type tencer from application
string appname = "tencer"
string themepath = "C:\Program Files (x86)\Appeon\Shared\PowerBuilder\theme190"
string themename = "Do Not Use Themes"
boolean nativepdfvalid = false
boolean nativepdfincludecustomfont = false
string nativepdfappname = ""
long richtextedittype = 2
long richtexteditversion = 1
string richtexteditkey = ""
string appicon = "C:\bmp\tencer.ico"
end type
global tencer tencer

type prototypes
FUNCTION uint     FindWindowA (long classname, string windowname) LIBRARY "user32.dll" 
Function boolean  CloseHandle(ulong hfile) Library "kernel32.dll"
Function boolean  FileTimeToSystemTime(ref filetime lpcreate, ref systemtime lpsystem) Library "kernel32.dll" alias for "FileTimeToSystemTime;Ansi"
Function boolean  GetFileTime(ulong hfile, ref filetime lpcreate, ref filetime lpaccess, ref filetime lpwrite) Library "kernel32.dll" alias for "GetFileTime;Ansi"
Function ulong      OpenFile (ref string lpszFileName,  ref str_ofstruct ofstruct, uint fuMode) Library "kernel32.dll" alias for "OpenFile;Ansi"
Function boolean  CreateDirectoryA (ref string pathname, int sa) Library "kernel32.dll" alias for "CreateDirectoryA;Ansi"
Function boolean  CopyFileA(ref string lpExistingFileName, ref string lpNewFileName, boolean bIfExists) Library "kernel32.dll" alias for "CopyFileA;Ansi"
Function boolean	SetFileAttributes(string lpFileName, string dwFileAttributes) LIBRARY "Kernel32.dll" 
Function boolean GetUserName( ref string buffer, ref ulong buflen ) Library "advapi32.dll" Alias For "GetUserNameW"

FUNCTION boolean MoveFileA(ref string cfrom, ref string cto, boolean flag) LIBRARY "Kernel32.dll" alias for "MoveFileA;Ansi"

FUNCTION int gethostname ( ref string name, int namelen ) library "wsock32.dll" alias for "gethostname;Ansi"

FUNCTION long ExitWindowsEx (long uFlags, long dwReserved)  LIBRARY " USER32.DLL"
FUNCTION boolean SetCurrentDirectoryA(ref string cdir) LIBRARY "kernel32.dll" alias for "SetCurrentDirectoryA;Ansi"
FUNCTION ulong GetCurrentDirectoryA(ulong BufferLen, ref string currentdir) LIBRARY "Kernel32.dll" alias for "GetCurrentDirectoryA;Ansi"
FUNCTION long ShellExecuteA(long hwnd, string operation, string file, long params, long default, long mode) LIBRARY "shell32.dll" alias for "ShellExecuteA;Ansi"


FUNCTION long ShellExecute(ulong ihwnd,string lpszOp,string lpszFile,string lpszParams,string lpszDir,int wShowCmd ) LIBRARY "shell32.dll" ALIAS FOR "ShellExecuteW"
end prototypes

on tencer.create
appname="tencer"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on tencer.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event systemerror;//	llama a la funciones de visualizacion de errores

Open (w_errores_sistema)

end event

event open;// Para colocar en castellano los textos del la barra de herramientas

ToolBarSheetTitle  = "Ventana Menu"
Toolbarpopmenutext = "Izquierda,Arriba,Derecha,Abajo,Ventana,Mostrar texto"


IF Handle(This, TRUE) > 0 THEN

	MessageBox("Aplicación en Ejecución", &
					This.AppName + " ya esta ejecutandose." + &
					" No se puede ejecutar de nuevo.",StopSign!)
	HALT CLOSE

ELSE


f_inicio(FALSE)


END IF



end event

