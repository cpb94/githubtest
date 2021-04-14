$PBExportHeader$u_excel.sru
forward
global type u_excel from nonvisualobject
end type
end forward

global type u_excel from nonvisualobject
end type
global u_excel u_excel

forward prototypes
public function string f_tipo_columna (datawindow data, string columna)
public function string f_tipo_columna (datastore data, string columna)
public function boolean f_importar (datastore arg_data, string arg_fichero, integer arg_columnas)
public function boolean f_exportar (datawindow dw_a_excel, string arg_fichero)
public function boolean f_exportar (datastore dw_a_excel, string arg_fichero)
public function boolean f_importar (datawindow arg_data, string arg_fichero, integer arg_columnas, integer arg_fila_desde)
public function boolean f_importar_libreoffice (datawindow arg_data, string arg_fichero, integer arg_columnas, integer arg_fila_desde)
end prototypes

public function string f_tipo_columna (datawindow data, string columna);string tipo, lsRetorno
tipo = data.Describe(columna+".ColType")
tipo = Mid(tipo,1,4)
if isnull(tipo) then tipo = ""
CHOOSE CASE tipo
	CASE "char", "varc"
		lsRetorno = "char"
	CASE "numb", "long" 
		lsRetorno = "entero"
	CASE "deci"
		lsRetorno = "decimal"
	CASE "date", "time"
		lsRetorno = "fecha"
	CASE ELSE
		lsRetorno = "?"
END CHOOSE
return lsRetorno
end function

public function string f_tipo_columna (datastore data, string columna);string tipo, lsRetorno
tipo = data.Describe(columna+".ColType")
tipo = Mid(tipo,1,4)
if isnull(tipo) then tipo = ""
CHOOSE CASE tipo
	CASE "char", "varc"
		lsRetorno = "char"
	CASE "numb", "long" 
		lsRetorno = "entero"
	CASE "deci"
		lsRetorno = "decimal"
	CASE "date", "time"
		lsRetorno = "fecha"
	CASE ELSE
		lsRetorno = "?"
END CHOOSE
return lsRetorno
end function

public function boolean f_importar (datastore arg_data, string arg_fichero, integer arg_columnas);long ll_numcols , ll_numrows , ll_c, ll_r
OLEObject xlapp , xlsub
int li_ret, li_result
any lAvalor
string lsValor, el_campo

// Coloca el número de columnas y filas a copiar
ll_numcols = long(arg_data.Object.DataWindow.Column.Count)
if arg_columnas<>0 and arg_columnas <= ll_numcols then
	ll_numcols = arg_columnas
end if
ll_numrows = arg_data.RowCount()

// Crea el oleobject en la variable xlapp
xlApp = Create OLEObject

// Se conecta a Excel y verifica el código de retorno
li_ret = xlApp.ConnectToNewObject("excel.application")
IF li_ret <> 0 THEN
    MessageBox('Excel error','No puedo ejecutar EXCEL')
    DESTROY xlApp
    RETURN false
END IF
// Abre un archivo especifico de Excel 
xlApp.Workbooks.Open(arg_fichero) 

// Hace Excel visible
xlApp.Application.Visible = false
xlsub = xlapp.Application.Workbooks(1).Worksheets(1)

// El for/next loop copia todas las filas de cada columna
ll_c = 1
ll_r = 1
lavalor = xlsub.cells[ll_r,ll_c].value
if isnull(lavalor) then 
	lsValor = ""
else
	lsValor = string(laValor) 
end if
long fila
do while lsvalor <> "" 
	fila=arg_data.insertrow(0)
	For ll_c = 1 to ll_numcols
		lavalor = xlsub.cells[ll_r,ll_c].value
		if isnull(lavalor) then 
			lsvalor = ""
		else
			lsValor = string(laValor)
		end if
		if lsValor = "" then exit
//		// Averiguar el nombre del campo
		el_campo = arg_data.Describe("#" + string(ll_c) + ".Name")
//		// Y ahora el tipo		
		CHOOSE CASE f_tipo_columna(arg_data, el_campo)
			CASE "char"
				li_ret = arg_data.setitem(fila, ll_c, lsValor)
			CASE "entero"
				li_ret = arg_data.setitem(fila, ll_c, long(lsValor))
			CASE "decimal"
				li_ret = arg_data.setitem(fila, ll_c, dec(lsValor))				
			CASE "fecha"
				li_ret = arg_data.setitem(fila, ll_c, datetime(date(lsValor)))
			CASE else
				li_ret = 1
		END CHOOSE
		if li_ret <> 1 then
			f_mensaje("Error", "Error en asignacion de campos")
			arg_data.reset()
			return false
		end if
	next
	ll_c = 1
	ll_r++
	lavalor = xlsub.cells[ll_r,ll_c].value
	if isnull(lavalor) then 
		lsValor = ""
	else
		lsValor = string(laValor)
	end if
loop
// se desconecta de excel

//////////////////////////////////////////////////////////////////// Añadido para que cierre bien el proceso de Excel.
xlApp.workbooks.close()
xlApp.Application.Quit
////////////////////////////////////////////////////////////////////

xlApp.DisConnectObject()
Destroy xlapp
return true
end function

public function boolean f_exportar (datawindow dw_a_excel, string arg_fichero);// Codigo,--------
setpointer(hourglass!) 
oleobject luo_excel 


if dw_a_excel.saveas(arg_fichero,HTMLTable!,true) = 1 then 
	luo_excel = create oleobject 
	if luo_excel.connecttoobject(arg_fichero) = 0 then 
		luo_excel.application.displayalerts = false 
		luo_excel.application.workbooks(1).parent.windows(luo_excel.application.workbooks(1).name).visible = true 
		luo_excel.application.workbooks(1).saveas(arg_fichero,-4143)
		luo_excel.application.workbooks(1).close()
		luo_excel.disconnectobject() 
	else
		return false
	end if 
	destroy luo_excel 
else
	return false
end if 
setpointer(arrow!) 
return true
end function

public function boolean f_exportar (datastore dw_a_excel, string arg_fichero);// Codigo,--------
setpointer(hourglass!) 
oleobject luo_excel 


if dw_a_excel.saveas(arg_fichero,HTMLTable!,true) = 1 then 
	luo_excel = create oleobject 
	if luo_excel.connecttoobject(arg_fichero) = 0 then 
		luo_excel.application.displayalerts = false 
		luo_excel.application.workbooks(1).parent.windows(luo_excel.application.workbooks(1).name).visible = true 
		luo_excel.application.workbooks(1).saveas(arg_fichero,-4143)
		luo_excel.application.workbooks(1).close()
		luo_excel.disconnectobject() 
	else
		return false
	end if 
	destroy luo_excel 
else
	return false
end if 
setpointer(arrow!) 
return true
end function

public function boolean f_importar (datawindow arg_data, string arg_fichero, integer arg_columnas, integer arg_fila_desde);long ll_numcols , ll_numrows , ll_c, ll_r
OLEObject xlapp , xlsub
int li_ret, li_result
any lAvalor
string lsValor, el_campo

// Coloca el número de columnas y filas a copiar
ll_numcols = long(arg_data.Object.DataWindow.Column.Count)
if arg_columnas<>0 and arg_columnas <= ll_numcols then
	ll_numcols = arg_columnas
end if
ll_numrows = arg_data.RowCount()

// Crea el oleobject en la variable xlapp
xlApp = Create OLEObject

// Se conecta a Excel y verifica el código de retorno
li_ret = xlApp.ConnectToNewObject("excel.application")
IF li_ret <> 0 THEN
    MessageBox('Excel error','No puedo ejecutar EXCEL')
    DESTROY xlApp
    RETURN false
END IF
// Abre un archivo especifico de Excel 
xlApp.Workbooks.Open(arg_fichero) 

// Hace Excel visible
xlApp.Application.Visible = false
xlsub = xlapp.Application.Workbooks(1).Worksheets(1)

// El for/next loop copia todas las filas de cada columna
ll_c = 1

ll_r = arg_fila_desde //1
lavalor = xlsub.cells[ll_r,ll_c].value
if isnull(lavalor) then 
	lsValor = ""
else
	lsValor = string(laValor) 
end if
long fila
do while lsvalor <> "" 
	fila=arg_data.insertrow(0)
	For ll_c = 1 to ll_numcols
		lavalor = xlsub.cells[ll_r,ll_c].value
		if isnull(lavalor) then 
			lsvalor = ""
		else
			lsValor = string(laValor)
		end if
		
		if lsValor = "" then exit
//		// Averiguar el nombre del campo
		el_campo = arg_data.Describe("#" + string(ll_c) + ".Name")
//		// Y ahora el tipo		
		CHOOSE CASE f_tipo_columna(arg_data, el_campo)
			CASE "char"
				li_ret = arg_data.setitem(fila, ll_c, lsValor)
			CASE "entero"
				li_ret = arg_data.setitem(fila, ll_c, long(lsValor))
			CASE "decimal"
				li_ret = arg_data.setitem(fila, ll_c, dec(lsValor))				
			CASE "fecha"
				li_ret = arg_data.setitem(fila, ll_c, datetime(date(left(lsValor,10))))
			CASE else
				li_ret = 1
		END CHOOSE
		if li_ret <> 1 then
			f_mensaje("Error", "Error en asignacion de campos")
			arg_data.reset()
			return false
		end if
	next
	ll_c = 1
	ll_r++
	lavalor = xlsub.cells[ll_r,ll_c].value
	if isnull(lavalor) then 
		lsValor = ""
	else
		lsValor = string(laValor)
	end if
loop
// se desconecta de excel

//////////////////////////////////////////////////////////////////// Añadido para que cierre bien el proceso de Excel.
xlApp.workbooks.close()
xlApp.Application.Quit
////////////////////////////////////////////////////////////////////

xlApp.DisConnectObject()
Destroy xlapp
return true
end function

public function boolean f_importar_libreoffice (datawindow arg_data, string arg_fichero, integer arg_columnas, integer arg_fila_desde);long ll_numcols , ll_numrows , ll_fila, ll_columna
Oleobject iole_serviceManager
Oleobject iole_objDeskTop
Oleobject iole_propertyValue
Oleobject objCoreReflection
OleObject objTable
OleObject objRows
OleObject objRow
OleObject sheets
OleObject sheet
Oleobject hoja
Oleobject celda
OleObject controller
OleObject frame
OleObject window
OLEObject xlapp , xlsub
int  li_ret,li_result
any lAvalor
string lsValor, el_campo
string array []

// Coloca el número de columnas y filas a copiar
ll_numcols = long(arg_data.Object.DataWindow.Column.Count)
if arg_columnas<>0 and arg_columnas <= ll_numcols then
	ll_numcols = arg_columnas
end if
ll_numrows = arg_data.RowCount()

// Crea el oleobject en la variable xlapp
iole_serviceManager = Create OLEObject

// Se conecta a Excel y verifica el código de retorno
li_ret = iole_serviceManager.ConnecttoNewObject("com.sun.star.ServiceManager")

IF li_ret <> 0 THEN
	choose case li_ret
		case -1 
			MessageBox('Error','Invalid call: the argument is the Object property of a control')
		
		case -2 
			MessageBox('Error','Class name not found')
		
		case -3 
			MessageBox('Error','Object could not be created')
		
		case -4 
			MessageBox('Error','Could not connect to object')
			
		case -5 
			MessageBox('Error','Ca not connect to the currently active object')
			
		case -6 
			MessageBox('Error','Filename is not valid')
			
		case -7 
			MessageBox('Error','File not found or file could not be opened')
			
		case -8 
			MessageBox('Error','Load from file not supported by server')
			
		case -9 
			MessageBox('Error','Other error')
			
		case -15 
			MessageBox('Error','COM+ is not loaded on this computer')
			
		case -16 
			MessageBox('Error','Invalid Call: this function not applicable to OLETxnObject')
					
	end choose
	
	DESTROY xlApp
	RETURN false
END IF

// Abre un archivo especifico de Excel 

objCoreReflection=iole_serviceManager.createInstance("com.sun.star.reflection.CoreReflection")

iole_objDeskTop =iole_serviceManager.createInstance("com.sun.star.frame.Desktop")

//Para abrir con readonly
OLEObject objPropertyValue[]

objPropertyValue[1] = iole_serviceManager.Bridge_GetStruct("com.sun.star.beans.PropertyValue")
objPropertyValue[1].Name  = "ReadOnly"
objPropertyValue[1].Value = True

xlApp = iole_objDeskTop.loadComponentFromURL("file:///" + arg_fichero, "_blank", 0,objPropertyValue[])

//xlApp = iole_objDeskTop.loadComponentFromURL("file:///" + arg_fichero, "_blank", 0, array)

//Minimizo la ventana al operar para que no moleste, al finalizar la cierro

controller = xlApp.getCurrentController()

frame = controller.getFrame()

window = frame.ContainerWindow

window.isminimized = true

sheets = xlApp.getSheets()

/*

boolean existe

existe = sheets.hasByName("Sheet1")

messagebox("",string(sheets.getCount()))

messagebox("",existe)

*/

hoja = xlApp.CurrentController.ActiveSheet

//celda = hoja.GetCellRangeByName("A3")

//hoja.getCellByPosition(fila,columna) (Empiezan ambas por 0)

ll_fila = arg_fila_desde -1
ll_columna = 0

celda = hoja.getCellByPosition(ll_columna,ll_fila)

lsValor = celda.getString()
if isnull(lsValor) then 
	lsValor = ""
end if

long fila

do while lsvalor <> "" 
	fila = arg_data.insertrow(0)
	For ll_columna = 0 to (ll_numcols -1)
		celda = hoja.getCellByPosition(ll_columna,ll_fila)
		
		lsValor = celda.getString()
		if isnull(lsValor) then 
			lsValor = ""
		end if
		
		if lsValor = "" then exit
//		// Averiguar el nombre del campo
		el_campo = arg_data.Describe("#" + string(ll_columna+1) + ".Name")
//		// Y ahora el tipo		
		CHOOSE CASE f_tipo_columna(arg_data, el_campo)
			CASE "char"
				li_ret = arg_data.setitem(fila, (ll_columna+1), lsValor)
			CASE "entero"
				lsValor = string(celda.getvalue())
				li_ret = arg_data.setitem(fila, (ll_columna+1), long(lsValor))
			CASE "decimal"
				lsValor = string(celda.getvalue())
				li_ret = arg_data.setitem(fila, (ll_columna+1), dec(lsValor))				
			CASE "fecha"
				li_ret = arg_data.setitem(fila, (ll_columna+1), datetime(date(left(lsValor,10))))
			CASE else
				li_ret = 1
		END CHOOSE
		if li_ret <> 1 then
			f_mensaje("Error", "Error en asignacion de campos")
			arg_data.reset()
			return false
		end if
	next
	ll_columna = 0
	ll_fila++
	celda = hoja.getCellByPosition(ll_columna,ll_fila)
	
	lsValor = celda.getString()
	if isnull(lsValor) then 
		lsValor = ""
	end if
loop

//Cerramos el documento

xlApp.close(true)


/*

xlApp.Workbooks.Open(arg_fichero) 

// Hace Excel visible
xlApp.Application.Visible = false
xlsub = xlapp.Application.Workbooks(1).Worksheets(1)

// El for/next loop copia todas las filas de cada columna
ll_fila = 1

ll_columna = arg_fila_desde //1
lavalor = xlsub.cells[ll_columna,ll_fila].value
if isnull(lavalor) then 
	lsValor = ""
else
	lsValor = string(laValor) 
end if
long fila
do while lsvalor <> "" 
	fila=arg_data.insertrow(0)
	For ll_fila = 1 to ll_numcols
		lavalor = xlsub.cells[ll_columna,ll_fila].value
		if isnull(lavalor) then 
			lsvalor = ""
		else
			lsValor = string(laValor)
		end if
		
		if lsValor = "" then exit
//		// Averiguar el nombre del campo
		el_campo = arg_data.Describe("#" + string(ll_fila) + ".Name")
//		// Y ahora el tipo		
		CHOOSE CASE f_tipo_columna(arg_data, el_campo)
			CASE "char"
				li_ret = arg_data.setitem(fila, ll_fila, lsValor)
			CASE "entero"
				li_ret = arg_data.setitem(fila, ll_fila, long(lsValor))
			CASE "decimal"
				li_ret = arg_data.setitem(fila, ll_fila, dec(lsValor))				
			CASE "fecha"
				li_ret = arg_data.setitem(fila, ll_fila, datetime(date(left(lsValor,10))))
			CASE else
				li_ret = 1
		END CHOOSE
		if li_ret <> 1 then
			f_mensaje("Error", "Error en asignacion de campos")
			arg_data.reset()
			return false
		end if
	next
	ll_fila = 1
	ll_columna++
	lavalor = xlsub.cells[ll_columna,ll_fila].value
	if isnull(lavalor) then 
		lsValor = ""
	else
		lsValor = string(laValor)
	end if
loop
// se desconecta de excel

//////////////////////////////////////////////////////////////////// Añadido para que cierre bien el proceso de Excel.
xlApp.workbooks.close()
xlApp.Application.Quit
////////////////////////////////////////////////////////////////////

xlApp.DisConnectObject()
Destroy xlapp

*/

return true
end function

on u_excel.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_excel.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

