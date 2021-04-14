$PBExportHeader$wt_busquedas.srw
$PBExportComments$Ventana de ayuda.
forward
global type wt_busquedas from window
end type
type pb_quitar_filtro from picturebutton within wt_busquedas
end type
type pb_nuevo_filtro from picturebutton within wt_busquedas
end type
type ddlb_filtro from dropdownlistbox within wt_busquedas
end type
type criterios_extra from singlelineedit within wt_busquedas
end type
type sle_resultado from singlelineedit within wt_busquedas
end type
type st_4 from statictext within wt_busquedas
end type
type st_3 from statictext within wt_busquedas
end type
type st_1 from statictext within wt_busquedas
end type
type pb_ordenar from picturebutton within wt_busquedas
end type
type pb_salir from upb_salir within wt_busquedas
end type
type criterio from singlelineedit within wt_busquedas
end type
type st_2 from statictext within wt_busquedas
end type
type gb_1 from groupbox within wt_busquedas
end type
type borde_busqueda from groupbox within wt_busquedas
end type
type gb_3 from groupbox within wt_busquedas
end type
type gb_2 from groupbox within wt_busquedas
end type
type em_1 from editmask within wt_busquedas
end type
type cb_buscar from picturebutton within wt_busquedas
end type
type dw_seleccion from datawindow within wt_busquedas
end type
type gb_6 from groupbox within wt_busquedas
end type
type gb_5 from groupbox within wt_busquedas
end type
type ws_busquedas from structure within wt_busquedas
end type
end forward

type ws_busquedas from structure
    string str_nom_datawindow
    string str_valor_busqueda
end type

global type wt_busquedas from window
integer x = 608
integer y = 384
integer width = 5001
integer height = 2580
boolean titlebar = true
string title = "Búsqueda"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
boolean center = true
pb_quitar_filtro pb_quitar_filtro
pb_nuevo_filtro pb_nuevo_filtro
ddlb_filtro ddlb_filtro
criterios_extra criterios_extra
sle_resultado sle_resultado
st_4 st_4
st_3 st_3
st_1 st_1
pb_ordenar pb_ordenar
pb_salir pb_salir
criterio criterio
st_2 st_2
gb_1 gb_1
borde_busqueda borde_busqueda
gb_3 gb_3
gb_2 gb_2
em_1 em_1
cb_buscar cb_buscar
dw_seleccion dw_seleccion
gb_6 gb_6
gb_5 gb_5
end type
global wt_busquedas wt_busquedas

type variables
String variables_cabecera[]
int numero_filtros
string filtros[]
String ordenacion
str_wt_busquedas_entrada busqueda
str_wt_busquedas_salida resultado
end variables

event open;string error_syntaxfromSQL, error_create, new_syntax, tipo
String consulta, tmp_sql, variable_cabecera, campo, valor
int i, total, p1, p2, p3

// Lectura parámetros de entrada y validación
busqueda = Message.PowerObjectParm
setnull(Message.PowerObjectParm)

if not isnull(busqueda.titulo_ventana) and busqueda.titulo_ventana <> "" then
	this.title = busqueda.titulo_ventana
end if

resultado.error = ''
resultado.resultado = 0
ddlb_filtro.sorted = false
ordenacion = "D"

if IsNull(busqueda) Then 
	resultado.resultado = -1
	resultado.error = "No se ha especificado una estructura con los datos de búsqueda. Avise al administrador."
    CloseWithReturn(This, resultado)
	return
end if

//Creación del data window de búsqueda
consulta = busqueda.consulta
new_syntax = SQLCA.SyntaxFromSQL(consulta, 'Style(Type=Grid)', error_syntaxfromSQL)

IF Len(error_syntaxfromSQL) > 0 THEN
   // Display errors
	resultado.resultado = -1
	resultado.error = "Error en la consulta de la búsqueda. Avise al administrador."+error_syntaxfromSQL
	CloseWithReturn(this, resultado)
	return
ELSE
   // Generate new DataWindow
   dw_seleccion.Create(new_syntax, error_create)
   IF Len(error_create) > 0 THEN
		resultado.resultado = -1
		resultado.error = "Error en la creación del DW de búsqueda. Avise al administrador."+error_create
   		CloseWithReturn(this, resultado)
		return
   END IF
END IF

dw_seleccion.SetTransObject(SQLCA)
if dw_seleccion.Retrieve() <= 0 then
	CloseWithReturn(this, resultado)
	return
end if

dw_seleccion.Object.DataWindow.Detail.height = 70
dw_seleccion.Object.DataWindow.Header.Color = rgb(81, 98, 111) //rgb(243, 71, 84) //rgb(252, 141, 156)
dw_seleccion.Object.DataWindow.Detail.Color = rgb(209,209,209) //rgb(239, 239, 239)
total = integer(dw_seleccion.object.DataWindow.Column.Count)
if total < 2 then
	resultado.resultado = -1
	resultado.error = "La consulta no tiene al menos 2 parámetros para realizar el filtro. Avise al administrador."
   CloseWithReturn(this, resultado)
	return
end if

//rgb(252, 17, 48)
tmp_sql = Mid(consulta,7)
for i = 1 to total
	//Extracción variables cabeceras
	p1 = 1
	p2 = pos(tmp_sql,".") - 1
	if i <> total then
		p3 = pos(tmp_sql,",") - 1
	else
		p3 = pos(lower(tmp_sql),"from") - 1
	end if
	if p2 = 0 then
		variable_cabecera = trim(Mid(tmp_sql,p1,p3)) + "_t"
	else
		variable_cabecera = Replace(trim(Mid(tmp_sql,p1,p3)),p2,1,"_") + "_t"
	end if
	variables_cabecera[i] = variable_cabecera
	ddlb_filtro.AddItem(busqueda.titulos[i])
	tmp_sql = mid(tmp_sql,p3+2)
	if i = 1 then
		//Modificación columnas y títulos
		dw_seleccion.Modify(variables_cabecera[i]+".Text = '"+busqueda.titulos[i]+"'")
		
		dw_seleccion.Modify("#"+string(i)+".Width.Autosize = 'yes'")	
		dw_seleccion.Modify("#"+string(i)+".font.Weight = '700'")
		dw_seleccion.Modify("#"+string(i)+".alignment = 2")
	else
		//Modificación columnas y títulos
		dw_seleccion.Modify(variables_cabecera[i]+".Text = '"+busqueda.titulos[i]+"'")
		dw_seleccion.Modify("#"+string(i)+".Width.Autosize = 'yes'")	
	end if
	dw_seleccion.Modify("#"+string(i)+".font.heigth = 50")
next

if upperbound(busqueda.titulos) > 4 then
	this.width = this.width + 1500 
	dw_seleccion.width = dw_seleccion.width + 1500 
	borde_busqueda.width = borde_busqueda.width + 1500
	sle_resultado.width = sle_resultado.width + 1500
	pb_salir.x = pb_salir.x + 1500
	
end if

//Filtros
numero_filtros = 1
//Criterio principal
if not isnull(busqueda.filtro) and busqueda.filtro <> "" then
	criterio.text = busqueda.filtro
	cb_buscar.triggerevent(Clicked!)
end if

criterio.setfocus()

//Importante tener en cuenta el orden de ejecución!!!! Y los eventos que se llaman

if dw_seleccion.rowcount() = 1 then
	//Un solo resultado encontrado... devolver
	total = integer(dw_seleccion.object.DataWindow.Column.Count)
	For i = 1 to total 
		campo = dw_seleccion.Describe("#"+String(i)+".Name")
		tipo = dw_seleccion.Describe("#"+String(i)+".Coltype")
		if tipo = "long" or tipo = "number" or tipo = "int" then
			valor = String(dw_seleccion.GetItemNumber(dw_seleccion.GetRow(),i))
		else
			valor = dw_seleccion.GetItemString(1,i)
		end if
		//valor = f_valor_columna(dw_seleccion,dw_seleccion.GetRow(),campo)
		resultado.valores[i] = valor
	Next
	resultado.resultado = i
	CloseWithReturn(this, resultado)
	return
end if

if not isnull(busqueda.filtro_es_codigo) and busqueda.filtro_es_codigo = true then
	if dw_seleccion.rowcount() = 1 then
		//Un solo resultado encontrado... devolver
		total = integer(dw_seleccion.object.DataWindow.Column.Count)
		For i = 1 to total 
			campo = dw_seleccion.Describe("#"+String(i)+".Name")
			tipo = dw_seleccion.Describe("#"+String(i)+".Coltype")
			if tipo = "long" or tipo = "number" or tipo = "int" then
				valor = String(dw_seleccion.GetItemNumber(dw_seleccion.GetRow(),i))
			else
				valor = dw_seleccion.GetItemString(1,i)
			end if
			//valor = f_valor_columna(dw_seleccion,dw_seleccion.GetRow(),campo)
			resultado.valores[i] = valor
		Next
		resultado.resultado = i
		CloseWithReturn(this, resultado)
		return
	end if
end if




end event

on wt_busquedas.create
this.pb_quitar_filtro=create pb_quitar_filtro
this.pb_nuevo_filtro=create pb_nuevo_filtro
this.ddlb_filtro=create ddlb_filtro
this.criterios_extra=create criterios_extra
this.sle_resultado=create sle_resultado
this.st_4=create st_4
this.st_3=create st_3
this.st_1=create st_1
this.pb_ordenar=create pb_ordenar
this.pb_salir=create pb_salir
this.criterio=create criterio
this.st_2=create st_2
this.gb_1=create gb_1
this.borde_busqueda=create borde_busqueda
this.gb_3=create gb_3
this.gb_2=create gb_2
this.em_1=create em_1
this.cb_buscar=create cb_buscar
this.dw_seleccion=create dw_seleccion
this.gb_6=create gb_6
this.gb_5=create gb_5
this.Control[]={this.pb_quitar_filtro,&
this.pb_nuevo_filtro,&
this.ddlb_filtro,&
this.criterios_extra,&
this.sle_resultado,&
this.st_4,&
this.st_3,&
this.st_1,&
this.pb_ordenar,&
this.pb_salir,&
this.criterio,&
this.st_2,&
this.gb_1,&
this.borde_busqueda,&
this.gb_3,&
this.gb_2,&
this.em_1,&
this.cb_buscar,&
this.dw_seleccion,&
this.gb_6,&
this.gb_5}
end on

on wt_busquedas.destroy
destroy(this.pb_quitar_filtro)
destroy(this.pb_nuevo_filtro)
destroy(this.ddlb_filtro)
destroy(this.criterios_extra)
destroy(this.sle_resultado)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_1)
destroy(this.pb_ordenar)
destroy(this.pb_salir)
destroy(this.criterio)
destroy(this.st_2)
destroy(this.gb_1)
destroy(this.borde_busqueda)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.em_1)
destroy(this.cb_buscar)
destroy(this.dw_seleccion)
destroy(this.gb_6)
destroy(this.gb_5)
end on

event key;string campo, valor, tipo
int total, i

if keyflags = 2 then
	if key = Keyenter! then
		cb_buscar.triggerevent(clicked!)
	end if
else
	IF key = KeyUpArrow!    Then 
		f_cursor_arriba(dw_seleccion)
		//dw_seleccion.setfocus()
		//NO HAY QUE PONER EL FOCO EN EL DATAWINDOW O NO FUNCIONA ENTER
	END IF
	IF key = KeyDownArrow!  Then 
		f_cursor_abajo(dw_seleccion)
		//dw_seleccion.setfocus()
	END IF
	IF key = KeyPageUp!     Then 
		f_pagina_arriba(dw_seleccion)
		//dw_seleccion.setfocus()
	END IF
	IF key = KeyPageDown!   Then 
		f_pagina_abajo(dw_seleccion)
		//dw_seleccion.setfocus()
	END IF
	IF Key = KeyEnter! Then
		IF dw_seleccion.RowCount() = 0 THEN Return
		total = integer(dw_seleccion.object.DataWindow.Column.Count)
		For i = 1 to total 
			campo = dw_seleccion.Describe("#"+String(i)+".Name")
			tipo = dw_seleccion.Describe("#"+String(i)+".Coltype")
			if tipo = "long" or tipo = "number" or tipo = "int" or pos(tipo,"decimal") <> 0 then
				valor = String(dw_seleccion.GetItemNumber(dw_seleccion.GetRow(),i))
			else
				valor = dw_seleccion.GetItemString(dw_seleccion.GetRow(),i)
			end if
			resultado.valores[i] = valor
		Next
		resultado.resultado = i
		CloseWithReturn(this, resultado)
	END IF
end if



end event

event close;CloseWithReturn(this,resultado)
end event

type pb_quitar_filtro from picturebutton within wt_busquedas
integer x = 3410
integer y = 140
integer width = 110
integer height = 96
integer taborder = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\TENCER_PB12\navigate_minus.png"
string powertiptext = "Quitar filtro de búsqueda"
end type

event clicked;Int i, posicion, p1, p2
String filtro_total

if numero_filtros > 1 then	
	filtros[numero_filtros] = ""
	numero_filtros --
	p1 = LastPos(sle_resultado.text, "&&")
	p2 = LastPos(sle_resultado.text, "||")
	if p2 > p1 then
		p1 = p2
	end if
	sle_resultado.text = Left(sle_resultado.text, p1 - 1)
	criterios_extra.text = ""
	cb_buscar.triggerevent(clicked!)
end if
end event

type pb_nuevo_filtro from picturebutton within wt_busquedas
integer x = 3296
integer y = 140
integer width = 110
integer height = 96
integer taborder = 50
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\TENCER_PB12\navigate_plus.png"
string powertiptext = "Añadir filtro de búsqueda"
end type

event clicked;String seleccionado, filtro_total 
Long posicion,i

if criterios_extra.text <> "" then
	seleccionado = ddlb_filtro.Text
	posicion = ddlb_filtro.FindItem(seleccionado,0)
	if posicion < 1 then
		return
	end if
	numero_filtros++
	filtros[numero_filtros] = "(#"+String(posicion)+" like '%"+criterios_extra.text+"%')"
	if numero_filtros = 1 then
		sle_resultado.text = busqueda.titulos[posicion] + " = " + criterios_extra.text
	else
		sle_resultado.text = sle_resultado.text + " && " + busqueda.titulos[posicion] + " = " + criterios_extra.text
	end if
	criterios_extra.text = ""
	cb_buscar.triggerevent(clicked!)
end if
end event

type ddlb_filtro from dropdownlistbox within wt_busquedas
integer x = 41
integer y = 144
integer width = 590
integer height = 500
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 134217728
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type criterios_extra from singlelineedit within wt_busquedas
integer x = 640
integer y = 144
integer width = 2647
integer height = 88
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
textcase textcase = upper!
end type

type sle_resultado from singlelineedit within wt_busquedas
integer x = 41
integer y = 240
integer width = 3474
integer height = 72
integer taborder = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within wt_busquedas
integer x = 2414
integer y = 2420
integer width = 686
integer height = 60
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
boolean enabled = false
string text = "Enter o Click selecciona."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within wt_busquedas
integer x = 1179
integer y = 2412
integer width = 210
integer height = 64
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
boolean enabled = false
string text = "Orden"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within wt_busquedas
integer x = 37
integer y = 2412
integer width = 466
integer height = 64
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
boolean enabled = false
string text = "Total registros : "
alignment alignment = center!
long bordercolor = 12632256
boolean focusrectangle = false
end type

type pb_ordenar from picturebutton within wt_busquedas
integer x = 1408
integer y = 2404
integer width = 96
integer height = 80
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "C:\FUENTES_TENCER_PB12\Refresh_16x16.png"
end type

on clicked;string ls_null
SetNull(ls_null)

dw_seleccion.SetSort(ls_null)
dw_seleccion.Sort( )
dw_seleccion.SetFocus()
end on

type pb_salir from upb_salir within wt_busquedas
integer x = 4827
integer y = 64
integer width = 110
integer height = 96
integer taborder = 70
string picturename = "C:\TENCER_PB12\Log Out_24x24Gris.png"
string powertiptext = "Salir"
end type

event clicked;// Cancelar la busqueda.
CloseWithReturn(parent,resultado)

end event

type criterio from singlelineedit within wt_busquedas
integer x = 640
integer y = 44
integer width = 2647
integer height = 88
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
textcase textcase = upper!
boolean hideselection = false
end type

event getfocus;// Cambiamos el boton por defecto a Buscar
/*
IF Parent.visible = FALSE Then Return
selecttext(1,100)
*/

end event

event losefocus;// Cambiamos el boton por defecto a Aceptar
//cb_buscar.Default  = FALSE

end event

event modified;cb_buscar.Triggerevent(clicked!)
end event

type st_2 from statictext within wt_busquedas
integer x = 41
integer y = 44
integer width = 590
integer height = 88
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 24076881
boolean enabled = false
string text = "Criterio de Busqueda"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type gb_1 from groupbox within wt_busquedas
integer x = 23
integer y = 2368
integer width = 722
integer height = 128
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type borde_busqueda from groupbox within wt_busquedas
integer x = 23
integer width = 4946
integer height = 328
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_3 from groupbox within wt_busquedas
integer x = 1915
integer y = 2368
integer width = 3054
integer height = 128
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_2 from groupbox within wt_busquedas
integer x = 1152
integer y = 2368
integer width = 384
integer height = 128
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type em_1 from editmask within wt_busquedas
integer x = 517
integer y = 2408
integer width = 206
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
boolean border = false
alignment alignment = center!
string mask = "###,###"
end type

type cb_buscar from picturebutton within wt_busquedas
integer x = 3296
integer y = 40
integer width = 110
integer height = 96
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string picturename = "C:\TENCER_PB12\Search_24x24.png"
string powertiptext = "Buscar (Tecla rápida TAB)"
end type

event clicked;String filtro_total, parte_filtro, campo, valor, tipo
Int i, p1, p2, total

if isnull(busqueda.filtro_es_codigo) or busqueda.filtro_es_codigo = false then
	if criterio.text = '' or isnull(criterio.text) then
		filtros[1] = "(1 = 1)"
	else
		filtros[1] = "(#2 LIKE '%"+criterio.text+"%')"
	end if
else
	tipo = dw_seleccion.Describe("#1.Coltype")
	if tipo = "long" or tipo = "number" or tipo = "int" then
		filtros[1] = "(#1 = "+criterio.text+")"
	else
		if criterio.text = '' or isnull(criterio.text) then
			filtros[1] = "(1 = 1)"
		else
			filtros[1] = "(#1 = '"+criterio.text+"')"
		end if
	end if
end if

filtro_total = ""
For i = 1 to numero_filtros - 1
	filtro_total = filtro_total + filtros[i] + " AND " 
Next
filtro_total = filtro_total + filtros[numero_filtros]


if numero_filtros > 1 then
	p1 = Pos(sle_resultado.text, "&&")
	p2 = Pos(sle_resultado.text, "||")
	if p2 < p1 and p2 <> 0 then
		p1 = p2
	elseif p1 = 0 then
		p1 = p2
	end if
	parte_filtro = Mid(sle_resultado.text, p1 - 1)
	sle_resultado.text = busqueda.titulos[2] + "=" + criterio.text + parte_filtro
else
	sle_resultado.text = busqueda.titulos[2] + "=" + criterio.text
end if


dw_seleccion.setFilter(filtro_total)
dw_seleccion.Filter()
if dw_seleccion.rowcount() > 0 then
	dw_seleccion.SetRedraw(false)
	dw_seleccion.SetSort("#2 "+ordenacion)
	dw_seleccion.Sort()
	dw_seleccion.SetRedraw(true)
	dw_seleccion.SelectRow(0, FALSE)
	dw_seleccion.SetRow(1)
	dw_seleccion.SelectRow(1, TRUE)
end if
em_1.Text = String(dw_seleccion.rowcount())

end event

type dw_seleccion from datawindow within wt_busquedas
integer x = 23
integer y = 332
integer width = 4946
integer height = 2036
string title = "none"
boolean vscrollbar = true
boolean livescroll = true
end type

event rowfocuschanged;if currentrow <> 0 then
	This.SelectRow(0, false)	
	This.SelectRow (currentrow, True)
	This.SetRow (currentrow)
end if
end event

event clicked;string banda, campo, valor, tipo
Int i, total


if not isnull(dwo) and dwo.Type = "text" then
	banda = dwo.Band
	campo = dwo.Name
	if pos(banda,"header") <> 0 then 
		if ordenacion = "D" then
			ordenacion = "A"
		else
			ordenacion = "D"
		end if
		dw_seleccion.SetRedraw(false)
		dw_seleccion.SetSort(Left(campo, Len(campo) - 2)+" "+ordenacion)
		dw_seleccion.Sort()
		dw_seleccion.SetRedraw(true)
	end if
end if

IF row = 0 THEN Return

IF dw_seleccion.RowCount() = 0 THEN Return

SetRow(row)

total = integer(dw_seleccion.object.DataWindow.Column.Count)
For i = 1 to total 
	campo = dw_seleccion.Describe("#"+String(i)+".Name")
	tipo = dw_seleccion.Describe("#"+String(i)+".Coltype")
	if tipo = "long" or tipo = "number" or tipo = "int" or pos(tipo,"decimal") <> 0 then
		valor = String(dw_seleccion.GetItemNumber(dw_seleccion.GetRow(),i))
	else
		valor = dw_seleccion.GetItemString(dw_seleccion.GetRow(),i)
	end if
	resultado.valores[i] = valor
Next
resultado.resultado = i
CloseWithReturn(Parent, resultado)



end event

type gb_6 from groupbox within wt_busquedas
integer x = 1536
integer y = 2368
integer width = 375
integer height = 128
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_5 from groupbox within wt_busquedas
integer x = 745
integer y = 2368
integer width = 407
integer height = 128
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

