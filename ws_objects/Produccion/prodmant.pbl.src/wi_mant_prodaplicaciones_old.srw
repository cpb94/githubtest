$PBExportHeader$wi_mant_prodaplicaciones_old.srw
forward
global type wi_mant_prodaplicaciones_old from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_prodaplicaciones_old
end type
type dw_caracteristicas from u_datawindow within wi_mant_prodaplicaciones_old
end type
type gb_1 from groupbox within wi_mant_prodaplicaciones_old
end type
type gb_2 from groupbox within wi_mant_prodaplicaciones_old
end type
type gb_3 from groupbox within wi_mant_prodaplicaciones_old
end type
end forward

global type wi_mant_prodaplicaciones_old from wi_mvent_con_empresa
integer x = 0
integer y = 0
integer width = 3365
integer height = 1616
pb_calculadora pb_calculadora
dw_caracteristicas dw_caracteristicas
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
end type
global wi_mant_prodaplicaciones_old wi_mant_prodaplicaciones_old

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

event open;call super::open;integer permiso

permiso = f_permiso_usuario(this.classname(), nombre_usuario)
choose case  permiso
	case 1
		This.cb_insertar.visible = false;
		This.cb_borrar.visible = false;
		This.pb_calculadora.visible = false;		
end choose

istr_parametros.s_titulo_ventana  = "Mantenimiento de Aplicaciones"

This.title = istr_parametros.s_titulo_ventana

dw_caracteristicas.settransobject(sqlca)
// Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
	sle_valor.text=istr_parametros.s_argumentos[2]
	IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
		dw_1.Retrieve(codigo_empresa,sle_valor.Text)
		dw_caracteristicas.Retrieve(codigo_empresa,sle_valor.Text)
	END IF
END IF



	
end event

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE
end on

event ue_inserta_fila;call super::ue_inserta_fila; dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
 dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
end event

event ue_recuperar;

// Valores Para Funcion de bloqueo
titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         =  "prodaplicaciones"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)
dw_caracteristicas.Retrieve(codigo_empresa,sle_valor.Text)

CALL Super::ue_recuperar
end event

on wi_mant_prodaplicaciones_old.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.dw_caracteristicas=create dw_caracteristicas
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.dw_caracteristicas
this.Control[iCurrent+3]=this.gb_1
this.Control[iCurrent+4]=this.gb_2
this.Control[iCurrent+5]=this.gb_3
end on

on wi_mant_prodaplicaciones_old.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.dw_caracteristicas)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
end on

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

event ue_actualiza_dw;call super::ue_actualiza_dw;if dw_caracteristicas.update() = -1 then
	rollback;
	messagebox("Atención","Se ha producido un error al actualizar las caracteristicas")
else
	commit;
end if
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_prodaplicaciones_old
integer x = 64
integer width = 2057
integer height = 1032
integer taborder = 20
string dataobject = "dw_prodaplicaciones"
end type

event dw_1::key;bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE
CHOOSE CASE bus_campo
	CASE "formato_gramaje"
		bus_titulo     = "AYUDA SELECCION FORMATOS"
		bus_datawindow = "dw_ayuda_formatos"
		bus_filtro     = "" 	
	CASE "familia_relacionada"
		bus_titulo     = "AYUDA SELECCION DE FAMILIAS"
		bus_datawindow = "dw_ayuda_familias"
		bus_filtro     = "" 		
	CASE "operacion"
		bus_titulo     = "AYUDA SELECCION DE OPERACIONES"
		bus_datawindow = "dw_ayuda_art_ver_tipooperacion"
		bus_filtro     = "" 		
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::key


end event

event dw_1::rbuttondown;bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE
CHOOSE CASE bus_campo
	CASE "formato_gramaje"
		bus_titulo     = "AYUDA SELECCION FORMATOS"
		bus_datawindow = "dw_ayuda_formatos"
		bus_filtro     = "" 	
	CASE "familia_relacionada"
		bus_titulo     = "AYUDA SELECCION DE FAMILIAS"
		bus_datawindow = "dw_ayuda_familias"
		bus_filtro     = "" 	
	CASE "operacion"
		bus_titulo     = "AYUDA SELECCION DE OPERACIONES"
		bus_datawindow = "dw_ayuda_art_ver_tipooperacion"
		bus_filtro     = "" 		
		
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::rbuttondown
end event

event dw_1::clicked;call super::clicked;str_parametros lstr_param
IF GetRow() <> 0  Then 	
	CHOOSE CASE f_objeto_datawindow(This)
		CASE "pb_formatos"
			lstr_param.s_argumentos[1]  = "wi_mant_formatos"
			lstr_param.s_argumentos[2]  = dw_1.object.formato_gramaje[dw_1.getrow()]
			lstr_param.i_nargumentos    = 2
			OpenWithParm(wi_mant_formatos, lstr_param)
	END CHOOSE
end if
end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_prodaplicaciones_old
integer x = 50
integer width = 251
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_prodaplicaciones_old
integer x = 837
integer y = 212
integer width = 411
end type

event cb_insertar::clicked;dec incremento
string tipo_incremento
boolean actualizar

actualizar = true

if dw_1.rowcount() > 0 then
	dw_1.accepttext()
	incremento = dw_1.object.incremento_base[dw_1.getrow()]
	if incremento = 0 or isnull(incremento) then
		//Si no introducimos el incremento lo hacemos nulo
		setnull(incremento)
		setnull(tipo_incremento)
		dw_1.object.incremento_base[dw_1.getrow()] = incremento
		dw_1.object.tipo_incremento[dw_1.getrow()] = tipo_incremento
	else
		tipo_incremento = dw_1.object.tipo_incremento[dw_1.getrow()]
		if isnull(tipo_incremento) or trim(tipo_incremento) = "" then
			messagebox("Atención","Debe indicar el tipo de incremento")
 			actualizar = false
		end if
	end if
end if
dw_caracteristicas.accepttext()
if actualizar then
	CALL Super::clicked
else
	dw_1.setfocus()
end if
end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_prodaplicaciones_old
integer x = 1266
integer y = 212
integer width = 411
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_prodaplicaciones_old
integer x = 311
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow  = "dw_ayuda_prodaplicaciones"
ue_titulo      = "AYUDA SELECCION DE APLICACIONES"
ue_filtro      = ""
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_prodaplicaciones_old
integer x = 1696
integer y = 212
integer width = 411
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_prodaplicaciones_old
integer taborder = 0
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_prodaplicaciones_old
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_prodaplicaciones_old
integer width = 3250
end type

type pb_calculadora from u_calculadora within wi_mant_prodaplicaciones_old
integer x = 576
integer y = 208
integer taborder = 0
end type

event clicked;IF cb_insertar.enabled=TRUE THEN Return
 Integer registros
 Select count(*) Into :registros
 From   prodaplicaciones
 Where  prodaplicaciones.empresa = :codigo_empresa;
 IF registros=0 THEN
   sle_valor.text="1"
 ELSE
  Select max(convert(int,prodaplicaciones.codigo)+1)
  Into   :sle_valor.text
  From   prodaplicaciones
  Where  prodaplicaciones.empresa = :codigo_empresa;
END IF
dw_1.triggerEvent("clicked")
  
end event

type dw_caracteristicas from u_datawindow within wi_mant_prodaplicaciones_old
integer x = 2135
integer y = 344
integer width = 1129
integer height = 1032
integer taborder = 30
boolean titlebar = true
string title = "Caracteristicas"
string dataobject = "dw_mant_prodcaracteristicasapli"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;call super::clicked;long donde,indice,contador,total

choose case f_objeto_datawindow(this)
	case "insertar"
		if cb_insertar.enabled then	
			total    = this.rowcount()
			for indice = 1 to total
				if this.object.orden[indice] > contador then
					contador = this.object.orden[indice]
				end if
			NEXT
			donde = this.insertrow(total +1)
			this.object.empresa[donde] = codigo_empresa
			this.object.aplicacion[donde] = sle_valor.text
			this.object.orden[donde] = contador + 1
			this.setrow(donde)
			this.scrolltorow(donde)
			this.setcolumn("caracteristica")
		else
			if not(cb_insertar.enabled) then
				dw_1.triggerevent(clicked!)				
			end if
		end if
	case "borrar"
		if cb_insertar.enabled then		
			this.deleterow(this.getrow())
		else
			if not(cb_insertar.enabled) then
				dw_1.triggerevent(clicked!)
			end if			
		end if
	case else
		if not(cb_insertar.enabled) then
			dw_1.triggerevent(clicked!)
		end if
end choose
end event

event itemchanged;long     indice
string   columna,mensaje_error,caracteristica_inserto,caracteristica
boolean  no_valido = false 
columna = this.GetColumnName( )

if columna = "caracteristica" then	
	caracteristica_inserto = data	
	if trim(caracteristica_inserto) <> "" then
		if trim(f_nombre_caracteristica(codigo_empresa,caracteristica_inserto)) = "" then
			no_valido     = true
			mensaje_error = "caracteristica inexistente"				
		else
			this.object.nombre_caracteristica[row] = f_nombre_caracteristica(codigo_empresa,caracteristica_inserto)
		end if
	end if
	if not(no_valido) and this.rowcount() > 1 then	
		for indice = 1 to this.rowcount()
			if indice <> row then
				caracteristica = this.object.caracteristica[indice]				
				if caracteristica_inserto = caracteristica then
					no_valido = true
					mensaje_error = "caracteristica ya introducida."
				end if
			end if
		next
	end if
end if


if no_valido then
	messagebox("Atención",mensaje_error)		
	return 2
	this.setrow(row)
	this.setcolumn("caracteristica")
else
	return 0
end if
end event

event rbuttondown;bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE
CHOOSE CASE bus_campo
	CASE "caracteristica"
		bus_filtro =""
		bus_datawindow = "dw_ayuda_prodcaracteristicas"
		bus_titulo = "VENTANA SELECCION DE CARACTERISTICAS"
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::rbuttondown
end event

event retrieveend;long indice,total
string caracteristica
total = this.rowcount()

if total > 0 then
	for indice = 1 to total
		caracteristica = this.object.caracteristica[indice]
		this.object.nombre_caracteristica[indice] = f_nombre_caracteristica(codigo_empresa,caracteristica)
	next
	this.sort()
end if
end event

event key;IF  KeyDown(KeyEscape!) Then Parent.TriggerEvent("ue_esc")
IF  KeyDown(KeyF5!)Then Parent.TriggerEvent("ue_f5")
IF  KeyDown(KeyF2!)Then Parent.TriggerEvent("ue_f2")
IF  KeyDown(KeyF3!)Then Parent.TriggerEvent("ue_f3")

bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE
CHOOSE CASE bus_campo
	CASE "caracteristica"
		bus_filtro =""
		bus_datawindow = "dw_ayuda_prodcaracteristicas"
		bus_titulo = "VENTANA SELECCION DE CARACTERISTICAS"
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::key
end event

type gb_1 from groupbox within wi_mant_prodaplicaciones_old
integer x = 827
integer y = 180
integer width = 430
integer height = 132
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within wi_mant_prodaplicaciones_old
integer x = 1257
integer y = 180
integer width = 430
integer height = 132
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type gb_3 from groupbox within wi_mant_prodaplicaciones_old
integer x = 1687
integer y = 180
integer width = 430
integer height = 132
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

