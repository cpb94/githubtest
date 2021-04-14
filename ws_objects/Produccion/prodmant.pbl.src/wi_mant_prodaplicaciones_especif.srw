$PBExportHeader$wi_mant_prodaplicaciones_especif.srw
forward
global type wi_mant_prodaplicaciones_especif from wi_mvent_con_empresa
end type
type gb_2 from groupbox within wi_mant_prodaplicaciones_especif
end type
type gb_1 from groupbox within wi_mant_prodaplicaciones_especif
end type
type st_nombre_molde from statictext within wi_mant_prodaplicaciones_especif
end type
type dw_2 from datawindow within wi_mant_prodaplicaciones_especif
end type
type cb_insertar_linea from commandbutton within wi_mant_prodaplicaciones_especif
end type
type cb_anyadir_linea from commandbutton within wi_mant_prodaplicaciones_especif
end type
type cb_borrar_linea from commandbutton within wi_mant_prodaplicaciones_especif
end type
type dw_3 from u_datawindow within wi_mant_prodaplicaciones_especif
end type
end forward

global type wi_mant_prodaplicaciones_especif from wi_mvent_con_empresa
integer x = 0
integer y = 0
integer width = 3657
integer height = 1584
gb_2 gb_2
gb_1 gb_1
st_nombre_molde st_nombre_molde
dw_2 dw_2
cb_insertar_linea cb_insertar_linea
cb_anyadir_linea cb_anyadir_linea
cb_borrar_linea cb_borrar_linea
dw_3 dw_3
end type
global wi_mant_prodaplicaciones_especif wi_mant_prodaplicaciones_especif

type variables

end variables

event open;call super::open;istr_parametros.s_titulo_ventana  = "Mantenimiento de Aplicaciones segun Boquilla,Rodillo y Molde"
istr_parametros.s_listado         = ""
This.title = istr_parametros.s_titulo_ventana
dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)
// Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
	sle_valor.text=istr_parametros.s_argumentos[2]
	IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
		dw_1.Retrieve(codigo_empresa,sle_valor.Text)
	END IF
END IF

	
end event

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"familia",sle_valor.text)
dw_1.setitem(dw_1.getrow(),"contador",1)

end event

event ue_recuperar;

// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         =  "prodaplicaciones_especif"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)
dw_2.Retrieve(codigo_empresa,sle_valor.Text)
dw_3.Retrieve(codigo_empresa,sle_valor.Text)
CALL Super::ue_recuperar
end event

on wi_mant_prodaplicaciones_especif.create
int iCurrent
call super::create
this.gb_2=create gb_2
this.gb_1=create gb_1
this.st_nombre_molde=create st_nombre_molde
this.dw_2=create dw_2
this.cb_insertar_linea=create cb_insertar_linea
this.cb_anyadir_linea=create cb_anyadir_linea
this.cb_borrar_linea=create cb_borrar_linea
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.st_nombre_molde
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.cb_insertar_linea
this.Control[iCurrent+6]=this.cb_anyadir_linea
this.Control[iCurrent+7]=this.cb_borrar_linea
this.Control[iCurrent+8]=this.dw_3
end on

on wi_mant_prodaplicaciones_especif.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.st_nombre_molde)
destroy(this.dw_2)
destroy(this.cb_insertar_linea)
destroy(this.cb_anyadir_linea)
destroy(this.cb_borrar_linea)
destroy(this.dw_3)
end on

event ue_desactiva_claves;call super::ue_desactiva_claves;
cb_anyadir_linea.enabled  = true
cb_borrar_linea.enabled   = true
cb_insertar_linea.enabled = true
end event

event ue_activa_claves;call super::ue_activa_claves;cb_anyadir_linea.enabled  = false
cb_borrar_linea.enabled   = false
cb_insertar_linea.enabled = false
end event

event ue_actualiza_dw;call super::ue_actualiza_dw;dw_2.setfilter("")
dw_2.filter()
dw_3.setfilter("")
dw_3.filter()

if dw_2.update() = 1 then
	if dw_3.update() = 1 then
		call super::ue_actualiza_dw
	else
		rollback;
		messagebox("Atención","Se ha producido un error al actualizar los datos")
	end if
else
	rollback;
	messagebox("Atención","Se ha producido un error al actualizar los datos")
end if
end event

event ue_borra_fila;string familia

familia = sle_valor.text

delete from prodaplicaciones_especif
where  empresa  = :codigo_empresa
and    familia  = :familia;

if sqlca.sqlcode = 0 then
	delete from prodcaracteristicasapli_especif
	where  empresa  = :codigo_empresa
	and    familia  = :familia;	
	
	if sqlca.sqlcode = 0 then
		delete from prodformulacionesapli_especif
		where  empresa  = :codigo_empresa
		and    familia  = :familia;	
		
		if sqlca.sqlcode = 0 then
			commit;
		else
			rollback;
			messagebox("Atención","Se ha producido un error al borrar los registros")
		end if
	else
		rollback;
		messagebox("Atención","Se ha producido un error al borrar los registros")
	end if
	
else
	rollback;
	messagebox("Atención","Se ha producido un error al borrar los registros")
end if

end event

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_prodaplicaciones_especif
integer x = 9
integer y = 280
integer width = 2085
integer height = 632
string dataobject = "dw_mant_prodaplicaciones_especif"
boolean vscrollbar = true
end type

event dw_1::rbuttondown;call super::rbuttondown;bus_filtro    = ""
bus_titulo    = ""
bus_campo     = This.GetColumnName()
valor_empresa = TRUE	

CHOOSE CASE bus_campo
	CASE "aplicacion"
		bus_datawindow = "dw_ayuda_prodaplicaciones"
		bus_titulo     = "VENTANA SELECCION DE APLICACIONES"
	CASE ELSE
		setnull(bus_campo)
END CHOOSE

CALL SUPER::rbuttondown
end event

event dw_1::key;bus_filtro    = ""
bus_titulo    = ""
bus_campo     = This.GetColumnName()
valor_empresa = TRUE	

CHOOSE CASE bus_campo
	CASE "aplicacion"
		bus_datawindow = "dw_ayuda_prodaplicaciones"
		bus_titulo     = "VENTANA SELECCION DE APLICACIONES"
	CASE ELSE
		setnull(bus_campo)
END CHOOSE

CALL SUPER::key
end event

event dw_1::scrollvertical;//dw_2.event scrollvertical(scrollpos)
end event

event dw_1::itemchanged;dwitemstatus estado
string campo,sel,caracteristica,familia,aplicacion,filtro
long   indice,total,orden,contador,donde
datastore caracteristicas

campo = dwo.name

if campo = "aplicacion" then		
	if trim(data) <> "" then
		if trim(f_nombre_aplicacion(codigo_empresa,data)) = "" then
			return 2
		end if
	end if	
	dw_2.setfilter("")
	aplicacion = this.object.aplicacion[row]
	if isnull(aplicacion) then aplicacion = ""
	contador   = this.object.contador[row]
	if isnull(contador) then contador = 0
	filtro     = "aplicacion = '"+aplicacion+"' and contador = "+string(contador)
	dw_2.setfilter(filtro)
	dw_2.filter()			
	total = dw_2.rowcount()
	for indice = 1 to total
		dw_2.deleterow(1)
	next			
	dw_3.setfilter(filtro)
	dw_3.filter()			
	total = dw_3.rowcount()
	for indice = 1 to total
		dw_3.deleterow(1)
	next				
	if trim(data) <> "" then
		sel = "select caracteristica,orden "+&
				"from   prodcaracteristicasapli "+&
				"where  empresa = '"+codigo_empresa+"' "+&
				"and    aplicacion = '"+data+"' "+&
				"order  by orden"
		//caracteristicas = f_cargar_cursor(sel)	
		f_cargar_cursor_nuevo(sel, caracteristicas)
		
		total = caracteristicas.rowcount()
		familia = this.object.familia[row]
		aplicacion = data
		contador   = this.object.contador[row]
		dw_2.setfilter("")
		filtro     = "aplicacion = '"+data+"' and contador = "+string(contador)
		dw_2.setfilter(filtro)
		for indice = 1 to total
			caracteristica = caracteristicas.object.caracteristica[indice]
			orden          = caracteristicas.object.orden[indice]
			donde          = dw_2.insertrow(dw_2.rowcount()+1)
			dw_2.object.empresa[donde]        = codigo_empresa
			dw_2.object.familia[donde]        = familia
			dw_2.object.aplicacion[donde]     = aplicacion
			dw_2.object.contador[donde]       = contador
			dw_2.object.caracteristica[donde] = caracteristica
			dw_2.object.orden[donde]          = orden				
		next
		dw_2.filter()
		
		dw_3.setfilter("")
		dw_3.setfilter(filtro)
		if f_requiere_formulacion_aplicacion(codigo_empresa,aplicacion) = "S" then
			donde          = dw_3.insertrow(dw_3.rowcount()+1)
			dw_3.object.empresa[donde]        = codigo_empresa
			dw_3.object.familia[donde]        = familia
			dw_3.object.aplicacion[donde]     = aplicacion
			dw_3.object.contador[donde]       = contador
		end if
		dw_3.filter()		
	end if
end if

destroy caracteristicas
end event

event dw_1::rowfocuschanged;string  filtro,aplicacion
integer contador
ue_marca_linea = TRUE
if currentrow > 0 then
	dw_2.setfilter("")	
	aplicacion = this.object.aplicacion[currentrow]
	if isnull(aplicacion) then aplicacion = ""
	contador   = this.object.contador[currentrow]
	if isnull(contador) then contador = 0
	filtro     = "aplicacion = '"+aplicacion+"' and contador = "+string(contador)	
	dw_2.setfilter(filtro)
	dw_2.filter()
	
end if

call super::rowfocuschanged
end event

event dw_1::retrieveend;string  filtro,aplicacion
integer contador

if rowcount > 0 then
	this.setrow(1)
	this.selectrow(0,false)
	this.selectrow(1,true)
	aplicacion = this.object.aplicacion[1]
	contador   = this.object.contador[1]
	filtro     = "aplicacion = '"+aplicacion+"' and contador = "+string(contador)
	dw_2.setfilter("")
	dw_2.setfilter(filtro)
	dw_2.filter()
end if
end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_prodaplicaciones_especif
integer x = 27
integer y = 168
integer width = 251
string text = "Familia:"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_prodaplicaciones_especif
integer x = 2267
integer y = 164
end type

event cb_insertar::clicked;//String descrip
//
//descrip = dw_1.GetItemString(dw_1.GetRow(),"descripcion")
//
//if IsNull(descrip) or Trim(descrip) = "" then
//	f_mensaje("Guardar datos de la Aplicación","Ha de introducir la descripción de la aplicación")
//	dw_1.SetFocus()
//	return
//end if

Call super::clicked
end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_prodaplicaciones_especif
integer x = 2679
integer y = 164
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_prodaplicaciones_especif
integer x = 279
integer y = 164
integer width = 192
end type

event sle_valor::getfocus;call super::getfocus;ue_titulo     = "AYUDA SELECCION DE FAMILIAS"
ue_datawindow = "dw_ayuda_familias"
ue_filtro     = "" 

end event

event sle_valor::modificado;call super::modificado;st_nombre_molde.text = f_nombre_familia(codigo_empresa,this.text)

IF Trim(st_nombre_molde.text) = "" THEN 
	this.text = ""
	this.setfocus()
END IF

end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_prodaplicaciones_especif
integer x = 3090
integer y = 164
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_prodaplicaciones_especif
integer taborder = 60
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_prodaplicaciones_especif
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_prodaplicaciones_especif
integer width = 2437
end type

type gb_2 from groupbox within wi_mant_prodaplicaciones_especif
integer x = 2254
integer y = 120
integer width = 1257
integer height = 148
integer taborder = 70
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_1 from groupbox within wi_mant_prodaplicaciones_especif
integer x = 9
integer y = 120
integer width = 2085
integer height = 140
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type st_nombre_molde from statictext within wi_mant_prodaplicaciones_especif
integer x = 475
integer y = 168
integer width = 1591
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 79741120
boolean enabled = false
boolean focusrectangle = false
end type

type dw_2 from datawindow within wi_mant_prodaplicaciones_especif
integer x = 2094
integer y = 276
integer width = 1413
integer height = 632
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_mant_prodcaracteristicasapli_especif"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;if not(cb_insertar.enabled) then
	dw_1.triggerevent(clicked!)
end if			
end event

type cb_insertar_linea from commandbutton within wi_mant_prodaplicaciones_especif
integer x = 9
integer y = 912
integer width = 329
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Insertar"
end type

type cb_anyadir_linea from commandbutton within wi_mant_prodaplicaciones_especif
integer x = 338
integer y = 912
integer width = 329
integer height = 80
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Añadir"
end type

event clicked;long donde,contador,indice,total

contador = 0
total    = dw_1.rowcount()

for indice = 1 to total
	if dw_1.object.contador[indice] > contador then
		contador = dw_1.object.contador[indice]
	end if
next

donde = dw_1.insertrow(total+1)
dw_1.setrow(donde)
dw_1.setitem(donde,"empresa",codigo_empresa)
dw_1.setitem(donde,"familia",sle_valor.text)
dw_1.setitem(donde,"contador",contador +1)

end event

type cb_borrar_linea from commandbutton within wi_mant_prodaplicaciones_especif
integer x = 672
integer y = 912
integer width = 329
integer height = 80
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Borrar"
end type

event clicked;long indice,total

if dw_1.getrow() > 0 then
	total = dw_2.rowcount()
	for indice = 1 to total
		dw_2.deleterow(1)
	next		
	dw_1.deleterow(dw_1.getrow())
end if
end event

type dw_3 from u_datawindow within wi_mant_prodaplicaciones_especif
integer x = 2098
integer y = 920
integer width = 1339
integer height = 268
integer taborder = 11
boolean bringtotop = true
string dataobject = "dw_prodformulacionesapli_especif"
end type

event key;bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE
CHOOSE CASE bus_campo
	CASE "formula"
		bus_titulo     = "AYUDA SELECCION FORMULACIONES"
		bus_datawindow = "dw_ayuda_prodformulaciones_produccion"
		bus_filtro     = "" 			
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::key
end event

event rbuttondown;bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE
CHOOSE CASE bus_campo
	CASE "formula"
		bus_titulo     = "AYUDA SELECCION FORMULACIONES"
		bus_datawindow = "dw_ayuda_prodformulaciones_produccion"
		bus_filtro     = "" 			
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::RbuttonDown
end event

event clicked;call super::clicked;if not(cb_insertar.enabled) then
	dw_1.triggerevent(clicked!)
end if			
end event

