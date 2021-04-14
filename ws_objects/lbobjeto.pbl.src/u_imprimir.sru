$PBExportHeader$u_imprimir.sru
forward
global type u_imprimir from nonvisualobject
end type
end forward

global type u_imprimir from nonvisualobject
event type boolean ue_imprimir ( datawindow dwdata )
end type
global u_imprimir u_imprimir

type variables
datawindow report
str_parametros istr_parametros
string isTitulo = "", isSubTitulo = ""
boolean ibCabecera = true
boolean ibLandscape = false
end variables

forward prototypes
public function string f_get_token (ref string source, string separator)
end prototypes

event type boolean ue_imprimir(datawindow dwdata);string lsModify, lsTotalPaginas
string lsResultado
string lsAltoHeaderOriginal = "580", lsAltoHeader//lsAltoHeaderOriginal = "650", lsAltoHeader
string lsalto, campo, lsY, lsX
long llalto, i, llY, llX, llIncrLandScape=700
string lsStringObjetos, lsObjeto
string lsBanda, lsBanda6
blob datos
long ld_zoom
// Recepciono los datos de la datawindow
ld_zoom = dec(dwdata.Object.DataWindow.Zoom)

dwdata.getfullstate(datos)
report.settransobject(sqlca)
report.setfullstate(datos)

//ld_zoom = dec(report.Object.DataWindow.Zoom)

// El alto del report es 650 + el alto de la cabecera de la dw ( dwdata )
lsAltoHeader = lsAltoHeaderOriginal
lsAltoHeader = string(long(lsAltoHeader) + long(dwdata.describe("datawindow.header.height")))

//Paso 1.- Poner el fondo dw a blanco
report.modify("datawindow.color=16777215")
report.modify("datawindow.summary.height=70")
report.modify("datawindow.footer.height=80" )

//Paso 2.- Todos los objetos de la datawindow 

lsStringObjetos = report.Describe ("datawindow.objects")
Do 
	lsObjeto = f_get_token (lsStringObjetos, "~t")
	
	// Quitar la leyenda DOBLE CLICK ( Es necesario que el objeto empiece por "t_pie..."
	if left(lsObjeto, 5) = "t_pie" then
		report.modify(lsObjeto+".visible=0")
	end if
	// Todos los objetos
//	lsResultado=report.modify(lsObjeto+".color=0")
//	lsResultado=report.modify(lsObjeto+".background.mode=2")
//	lsResultado=report.modify(lsObjeto+".background.color=16777215")	

	// Especificacion por banda	
	lsBanda = report.Describe(lsobjeto+".band")
	lsBanda6 = left(lsBanda, 6)
	CHOOSE CASE lsBanda6
		CASE "detail"
		CASE "footer"
			report.setposition(lsObjeto, "summary", true)
//			lsResultado=report.modify(lsObjeto+".border=2")
		CASE "header"
			// Es un grupo
			if pos(lsBanda, ".") > 0 then
				lsResultado=report.modify(lsObjeto+".font.weight=~"700~"")
			else
			// Es la cabecera
				lsResultado=report.modify(lsObjeto+".border=2")
//				lsResultado=report.modify(lsObjeto+".background.color=12632256")				
				lsAlto = report.describe(lsObjeto+".height")
				lsY = report.describe(lsObjeto+".Y")
	
				llalto = long(lsalto)
				llY = long(lsY)
				//llalto = integer(lsAltoHeader) - llalto + llY - 20
				llAlto = integer(lsAltoHeaderOriginal) - 20 + llY
				lsResultado=report.modify(lsObjeto+".Y="+string(llalto))
			end if
		CASE "summar"
		CASE "traile"
			// Es un pie de grupo
			if pos(lsBanda, ".") > 0 then
				lsResultado=report.modify(lsObjeto+".font.weight=~"700~"")
			// Es el pie
			else
			end if
		CASE "foregr"
		CASE "backgr"
	END CHOOSE
Loop Until lsStringObjetos = ""
//Paso 2.- Poner la cabecera y titulos
if ibCabecera then
	// Cambiar el alto de la banda HEADER
	lsModify = "datawindow.header.height="+lsAltoHeader
	lsResultado=report.modify(lsModify)
	lsModify = "datawindow.header.color='536870912'"
	lsResultado=report.modify(lsModify)

	// Crear el bitmap con el logo de la empresa
	string fichero
	fichero = f_imagen_cabecera_empresa(codigo_empresa)
   lsModify="create compute(band=Header alignment='0' border='0'" + &
			   " height.autosize=No moveable=0 resizeable=0 x='14' y='4' height='308' width='571' " + &
				" name=logo expression='bitmap(~""+fichero+"~")' background.mode='0')"
	lsResultado = report.Modify(lsModify)

	// Crear el nombre de la empresa
	lsModify = "create text(band=header alignment=~"1~" text=~""+f_nombre_empresa(codigo_empresa)+"~" border=~"0~" color=~"0~" x=~"869~" y=~"18~" height=~"116~" width=~"2418~" html.valueishtml=~"0~"  name=t_nombre visible=~"1~"  font.face=~"Arial~" font.height=~"-18~" font.weight=~"700~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" background.mode=~"2~" background.color=~"16777215~" )"
	lsResultado=report.modify(lsModify)	

	// Crear la fecha del listado
	lsModify = "create compute(band=header alignment=~"1~" expression='~"Fecha : ~" + string( today(), ~"dd-mm-yyyy~" )' border=~"0~" color=~"0~" x=~"2231~" y=~"156~" height=~"64~" width=~"1056~" format=~"[general]~" html.valueishtml=~"0~"  name=t_fecha visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" background.mode=~"2~" background.color=~"16777215~" )"
	lsResultado=report.modify(lsModify)	
	
	// Crear la hora del listado
	lsModify = "create compute(band=header alignment=~"1~" expression='~"Hora   :     ~" + String(now(), ~"hh:mm:ss~")' border=~"0~" color=~"0~" x=~"2231~" y=~"216~" height=~"68~" width=~"1056~" format=~"[general]~" html.valueishtml=~"0~"  name=t_hora visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" background.mode=~"2~" background.color=~"16777215~" )"
	lsResultado=report.modify(lsModify)	
	
end if
if isTitulo <> "" then	
	lsModify = "create text(band=header alignment=~"2~" text=~""+isTitulo+"~" border=~"2~" color=~"0~" x=~"20~" y=~"368~" height=~"80~" width=~"3346~" html.valueishtml=~"0~"  name=t_titulo visible=~"1~"  font.face=~"Arial~" font.height=~"-12~" font.weight=~"700~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" background.mode=~"2~" background.color=~"16777215~" )"
	lsResultado=report.modify(lsModify)	
end if
if isSubTitulo <> "" then
	lsModify = "create text(band=header alignment=~"2~" text=~""+isSubTitulo+"~" border=~"0~" color=~"0~" x=~"20~" y=~"484~" height=~"60~" width=~"3346~" html.valueishtml=~"0~"  name=t_subtitulo visible=~"1~"  resizeable=1  font.face=~"Arial~" font.height=~"-9~" font.weight=~"700~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" background.mode=~"2~" background.color=~"16777215~" )"
	lsResultado=report.modify(lsModify)	
end if

// Añadir el campo compute total_paginas
lsModify = "create compute(band=header alignment='0' expression='pageCount()' visible=~"0~" border='0' color='16777215' x='19' y='288' height='57' width='563' format='[general]'  name=total_paginas  font.face='Arial' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='16777215' )"
lsResultado=report.modify(lsModify)

// Añadir el campo compute pie_pagina
if ibLandScape then
	lsModify = "create compute(band=footer alignment=~"2~" expression=~"'Página ' + page() + ' de ' + pageCount()~"border=~"2~" color=~"0~" x=~"50~" y=~"4~" height=~"56~" width=~"4500~" format=~"[general]~" html.valueishtml=~"0~"  name=pie_pagina visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" background.mode=~"2~" background.color=~"16777215~" )"	
else
	lsModify = "create compute(band=footer alignment=~"2~" expression=~"'Página ' + page() + ' de ' + pageCount()~"border=~"2~" color=~"0~" x=~"20~" y=~"4~" height=~"56~" width=~"3346~" format=~"[general]~" html.valueishtml=~"0~"  name=pie_pagina visible=~"1~"  font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~"  font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" background.mode=~"2~" background.color=~"16777215~" )"
end if
lsResultado=report.modify(lsModify)

// Landscape
if ibLandscape = true then
	// Nombre de empresa
	lsY = report.describe("t_nombre.X")
	llY = long(lsY)
	llY = llY + llIncrLandScape
	report.modify("t_nombre.X="+string(llY))

	// Titulo
	lsY = report.describe("t_titulo.X")
	llY = long(lsY)
	llY = llY + llIncrLandScape
	report.modify("t_titulo.X="+string(llY))

	// Subtitulo
	lsY = report.describe("t_subtitulo.X")
	llY = long(lsY)
	llY = llY + llIncrLandScape
	report.modify("t_subtitulo.X="+string(llY))

	// Fecha
	lsY = report.describe("t_fecha.X")
	llY = long(lsY)
	llY = llY + llIncrLandScape
	report.modify("t_fecha.X="+string(llY))

	// Hora
	lsY = report.describe("t_hora.X")
	llY = long(lsY)
	llY = llY + llIncrLandScape
	report.modify("t_hora.X="+string(llY))

	// Logo
	lsY = report.describe("logo.X")
	llY = long(lsY)
	llY = llY + llIncrLandScape
	report.modify("logo.X="+string(llY))
	
	// Landscape
	report.modify("datawindow.print.orientation=1")
	
end if
IF report.rowcount() = 0 then
	return false
else
	report.groupcalc()
	report.Object.DataWindow.Zoom = ld_zoom 
	f_imprimir_datawindow(report)
	return true
end if
end event

public function string f_get_token (ref string source, string separator);
// String Function GET_TOKEN (ref string Source, string Separator)

// The function Get_Token receive, as arguments, the string from which
// the token is to be stripped off, from the left, and the separator
// character.  If the separator character does not appear in the string,
// it returns the entire string.  Otherwise, it returns the token, not
// including the separator character.  In either case, the source string
// is truncated on the left, by the length of the token and separator
// character, if any.


int 		p
string 	ret

p = Pos(source, separator)	// Get the position of the separator

if p = 0 then					// if no separator, 
	ret = source				// return the whole source string and
	source = ""					// make the original source of zero length
else
	ret = Mid(source, 1, p - 1)	// otherwise, return just the token and
	source = Right(source, Len(source) - p)	// strip it & the separator
end if

return ret
end function

on u_imprimir.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_imprimir.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;istr_parametros = message.powerobjectparm

end event

