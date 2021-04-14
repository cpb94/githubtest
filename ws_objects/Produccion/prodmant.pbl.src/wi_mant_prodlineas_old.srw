$PBExportHeader$wi_mant_prodlineas_old.srw
forward
global type wi_mant_prodlineas_old from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_prodlineas_old
end type
type gb_1 from groupbox within wi_mant_prodlineas_old
end type
type gb_2 from groupbox within wi_mant_prodlineas_old
end type
type gb_3 from groupbox within wi_mant_prodlineas_old
end type
end forward

global type wi_mant_prodlineas_old from wi_mvent_con_empresa
integer x = 361
integer y = 112
integer width = 2683
integer height = 1268
pb_calculadora pb_calculadora
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
end type
global wi_mant_prodlineas_old wi_mant_prodlineas_old

type variables
datawindow dw_activa
end variables

forward prototypes
public subroutine f_salir ()
public subroutine f_confirmar ()
public subroutine f_borrar_linea ()
public subroutine f_insertar_linea ()
end prototypes

public subroutine f_salir ();

end subroutine

public subroutine f_confirmar ();
end subroutine

public subroutine f_borrar_linea ();if dw_activa.getrow() > 0 then
	dw_activa.deleterow(dw_activa.getrow())
end if
end subroutine

public subroutine f_insertar_linea ();
long donde
donde = dw_activa.insertrow(dw_activa.rowcount() +1)
dw_activa.object.empresa[donde] = codigo_empresa
dw_activa.object.linea[donde] = sle_valor.text
dw_activa.setrow(donde)
dw_activa.scrolltorow(donde)
dw_activa.setcolumn("formato")


end subroutine

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE
end on

event open;call super::open;integer permiso

permiso = f_permiso_usuario(this.classname(), nombre_usuario)
choose case  permiso
	case 1
		This.cb_insertar.visible = false;
		This.cb_borrar.visible = false;
		This.pb_calculadora.visible = false;	
end choose

istr_parametros.s_titulo_ventana  = "Mantenimiento de Lineas de producción"
This.title = istr_parametros.s_titulo_ventana

// Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
	sle_valor.text=istr_parametros.s_argumentos[2]
	IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
		dw_1.Retrieve(codigo_empresa,sle_valor.Text)
	END IF
END IF

	
end event

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
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
tabla         =  "prodlineas"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)
CALL Super::ue_recuperar
end event

on wi_mant_prodlineas_old.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.gb_2
this.Control[iCurrent+4]=this.gb_3
end on

on wi_mant_prodlineas_old.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event ue_f5;f_confirmar()
end event

event ue_f2;call super::ue_f2;f_insertar_linea()
end event

event ue_f3;f_borrar_linea()
end event

event ue_esc;f_salir()
end event

event ue_actualiza_dw;call super::ue_actualiza_dw;f_confirmar()
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_prodlineas_old
integer x = 69
integer y = 340
integer width = 2523
integer height = 680
integer taborder = 20
string dataobject = "dw_mant_prodlineas"
end type

event dw_1::clicked;call super::clicked;datawindow var_datawindow
str_parametros lstr_param
// Devuelve el objeto al que apunta seguido del tabulador (~t) y 
// el numero de fila en la Datawindow

lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "w_mant_secciones"
CHOOSE CASE f_objeto_datawindow(this)
CASE 'pb_seccion'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"seccion")
   OpenWithParm(w_mant_secciones,lstr_param)
CASE 'pb_calendario'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"calendario")
   OpenWithParm(w_mant_calendarios,lstr_param)
END CHOOSE






end event

event dw_1::key;String consulta_busqueda
str_wt_busquedas_entrada busqueda
str_wt_busquedas_salida resultado
Int numero_valores

valor_empresa = TRUE	
bus_filtro=""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
CASE "seccion"
	bus_titulo     = "AYUDA SELECCION DE SECCIONES"
	bus_datawindow = "dw_ayuda_secciones"
	bus_filtro     = "" 
CASE "calendario"
	valor_empresa = FALSE
	bus_titulo     = "AYUDA SELECCION DE CALENDARIOS"
	bus_datawindow = "dw_ayuda_calendarios"
	bus_filtro     = "" 

CASE "prodlineas_tipomaquina_disenyo"
	
	busqueda.consulta =  "   SELECT tipomaquina_disenyo.codigo, tipomaquina_disenyo.descripcion, tipomaquina_disenyo.prefijo "+&
								"   FROM   tipomaquina_disenyo "+&
								"   WHERE  tipomaquina_disenyo.empresa = '"+codigo_empresa+"' "+&
								"   ORDER BY tipomaquina_disenyo.codigo ASC  "
	busqueda.titulos[1] = "Código"
	busqueda.titulos[2] = "Descripción"
	busqueda.titulos[3] = "Prefijo"
	This.accepttext()
	bus_cadena= f_valor_columna(This,This.GetRow(),This.GetColumnName())
	if KeyDown(KeyTab!) then
		if not isnull(bus_cadena) and bus_cadena <> "" then
			busqueda.filtro = bus_cadena
			if Long(busqueda.filtro) = 0 then
				busqueda.filtro_es_codigo = false
			else
				busqueda.filtro_es_codigo = true
			end if
		end if
	end if
	
	IF KeyDown(KeyEnter!) or KeyDown(KeyTab!) THEN  
		OpenWithParm(wt_busquedas, busqueda)
		resultado = Message.PowerObjectParm
		if resultado.resultado = -1 then
			MessageBox("Error en la creación de la búsqueda",resultado.error)
			SetColumn(This.GetColumn())
			This.SetRow(This.getrow())
			This.Setfocus()
			SetText(bus_cadena)
			AcceptText()
		elseif resultado.resultado > 0 then				
			SetColumn(This.GetColumn())
			This.SetRow(This.getrow())
			This.Setfocus()
			SetText(resultado.valores[1])
			AcceptText()
			This.object.tipomaquina_disenyo_descripcion[This.getrow()] = resultado.valores[2]
		else
			SetColumn(This.GetColumn())
			This.SetRow(This.getrow())
			This.Setfocus()
			SetText(bus_cadena)
			AcceptText()
		end if
	END IF
	Return
END CHOOSE
CALL Super::Key


end event

event dw_1::rbuttondown;valor_empresa = TRUE	
bus_filtro=""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
CASE "seccion"
	bus_titulo     = "AYUDA SELECCION DE SECCIONES"
	bus_datawindow = "dw_ayuda_secciones"
	bus_filtro     = "" 
CASE "calendario"
	valor_empresa = FALSE
	bus_titulo     = "AYUDA SELECCION DE CALENDARIOS"
	bus_datawindow = "dw_ayuda_calendarios"
	bus_filtro     = "" 
case else
	setnull( bus_campo)
	
END CHOOSE
CALL Super::rbuttondown


end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_prodlineas_old
integer x = 59
integer y = 196
integer width = 270
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_prodlineas_old
integer x = 1193
integer y = 188
integer width = 411
end type

event cb_insertar::clicked;String descrip,formato,nombre_formato

if dw_1.GetRow() > 0 then
	descrip = dw_1.GetItemString(dw_1.GetRow(),"descripcion")
	
	if IsNull(descrip) or Trim(descrip) = "" then
		f_mensaje("Guardar datos","Ha de introducir la descripción de la linea")
		dw_1.SetFocus()
		return
	end if
end if

long indice,total
boolean mal = false



//if not(mal) then
//	total  = dw_metroshora.rowcount()
//	indice = 1
//	if total > 0 then
//		DO while indice <= total and not(mal)
//			formato = dw_metroshora.object.formato[indice]
//			if isnull(formato) then formato = ""
//			nombre_formato = f_nombre_formato(codigo_empresa,formato)			
//			if trim(nombre_formato) = "" then
//				mal = true
//				messagebox("Atención","Campo obligatorio : Formato")
//				dw_metroshora.selectrow(0,false)
//				dw_metroshora.selectrow(indice,true)
//				dw_metroshora.setrow(indice)
//				dw_metroshora.scrolltorow(indice)
//				dw_metroshora.setcolumn("formato")			
//			else
//				if isnull(dw_metroshora.object.metroshora[indice]) or dw_metroshora.object.metroshora[indice] <= 0 then
//					mal = true	
//					messagebox("Atención","Campo obligatorio : Metros Hora")
//					dw_metroshora.selectrow(0,false)
//					dw_metroshora.selectrow(indice,true)				
//					dw_metroshora.setrow(indice)
//					dw_metroshora.scrolltorow(indice)
//					dw_metroshora.setcolumn("metroshora")
//				end if			
//			end if
//			indice ++
//		LOOP
//	end if
//end if

if not mal then
	Call super::clicked
end if
end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_prodlineas_old
integer x = 1659
integer y = 188
integer width = 411
end type

event cb_borrar::clicked;String v_linea


// Comprobación de integridad referencial. Miramos que el cliente
// no tenga pedidos, albaranes, facturas, ni apuntes contables
v_linea = sle_valor.text

CALL Super::Clicked
//if not cb_borrar.enabled then
//	MessageBox("Borrado del Velocidades","Se han borrado todos las velocidades de la linea. ¿ Continuar ?", &
//					Question!,OK!,1)
//					
//	DELETE FROM prodmetroshoralinea
//	WHERE empresa = :codigo_empresa
//	and linea = :v_linea;
//end if
//

end event

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_prodlineas_old
integer x = 361
integer y = 192
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow  = "dw_ayuda_prodlineas"
ue_titulo      = "AYUDA SELECCION DE LINEAS DE PRODUCCIÓN"
ue_filtro      = ""
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_prodlineas_old
integer x = 2117
integer y = 188
integer width = 411
end type

event cb_salir::clicked;f_salir()
Call super::clicked


end event

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_prodlineas_old
integer taborder = 60
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_prodlineas_old
integer x = 795
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_prodlineas_old
integer width = 2775
end type

type pb_calculadora from u_calculadora within wi_mant_prodlineas_old
integer x = 626
integer y = 188
integer width = 114
integer height = 100
integer taborder = 0
boolean originalsize = false
end type

event clicked;IF cb_insertar.enabled=TRUE THEN Return
 Integer registros
 Select   count(*) 
 Into     :registros
 From     prodlineas
 Where  prodlineas.empresa = :codigo_empresa;
 IF registros=0 THEN
   sle_valor.text="1"
 ELSE
  Select max(convert(int,prodlineas.codigo)+1)
  Into   :sle_valor.text
  From   prodlineas
  Where  prodlineas.empresa = :codigo_empresa;
END IF


dw_1.triggerEvent("clicked")
 
 

end event

type gb_1 from groupbox within wi_mant_prodlineas_old
integer x = 1184
integer y = 156
integer width = 430
integer height = 132
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within wi_mant_prodlineas_old
integer x = 1650
integer y = 156
integer width = 430
integer height = 132
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_3 from groupbox within wi_mant_prodlineas_old
integer x = 2107
integer y = 156
integer width = 430
integer height = 132
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

