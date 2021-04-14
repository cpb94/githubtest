$PBExportHeader$wi_mant_prodplatos.srw
forward
global type wi_mant_prodplatos from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_prodplatos
end type
end forward

global type wi_mant_prodplatos from wi_mvent_con_empresa
integer x = 0
integer y = 0
integer width = 2510
integer height = 1004
pb_calculadora pb_calculadora
end type
global wi_mant_prodplatos wi_mant_prodplatos

type variables

end variables

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

istr_parametros.s_titulo_ventana  = "Mantenimiento de Platos"

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
 dw_1.setitem(dw_1.getrow(),"activo","S")

end event

event ue_recuperar;

// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         =  "prodplatos"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)


CALL Super::ue_recuperar
end event

on wi_mant_prodplatos.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
end on

on wi_mant_prodplatos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_prodplatos
integer y = 340
integer width = 2299
integer height = 444
string dataobject = "dw_mant_prodplatos"
end type

event dw_1::rbuttondown;valor_empresa = TRUE	
bus_filtro=""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
CASE "molde"
	bus_titulo     = "VENTANA SELECCION MOLDES "
	bus_datawindow = "dw_ayuda_prodmoldes"
	bus_filtro = "activo = 'S'"
CASE "marco"
	bus_titulo     = "VENTANA SELECCION MARCOS "
	bus_datawindow = "dw_ayuda_prodmarcos"
	bus_filtro = "activo = 'S'"
	
CASE ELSE
	SetNull(bus_campo)
END CHOOSE
CALL Super::rbuttondown
end event

event dw_1::key;valor_empresa = TRUE	
bus_filtro=""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
CASE "molde"
	bus_titulo     = "VENTANA SELECCION MOLDES "
	bus_datawindow = "dw_ayuda_prodmoldes"
	bus_filtro = "activo = 'S'"

CASE "marco"
	bus_titulo     = "VENTANA SELECCION MARCOS "
	bus_datawindow = "dw_ayuda_prodmarcos"
	bus_filtro = "activo = 'S'"
	
CASE ELSE
	SetNull(bus_campo)
END CHOOSE
CALL Super::Key


end event

event dw_1::clicked;call super::clicked;datawindow var_datawindow
str_parametros lstr_param
// Devuelve el objeto al que apunta seguido del tabulador (~t) y 
// el numero de fila en la Datawindow

lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "wi_mant_prodplatos"
CHOOSE CASE f_objeto_datawindow(this)
CASE 'pb_molde'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"molde")
   OpenWithParm(wi_mant_prodmoldes,lstr_param)  

CASE 'pb_marco'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"marco")
   OpenWithParm(wtc_mant_marcos,lstr_param)  
	
END CHOOSE
end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_prodplatos
integer x = 59
integer y = 196
integer width = 270
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_prodplatos
integer x = 1143
integer y = 160
end type

event cb_insertar::clicked;String descrip

//if this.enabled then
//	descrip = dw_1.object.descripcion[dw_1.GetRow()]
//	if IsNull(descrip) or Trim(descrip) = "" then
//		f_mensaje("Guardar datos de la Aplicación","Ha de introducir la descripción del plato")
//		dw_1.SetFocus()
//		return
//	end if
//end if
Call super::clicked



end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_prodplatos
integer x = 1563
integer y = 160
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_prodplatos
integer x = 361
integer y = 192
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow  = "dw_ayuda_prodplatos"
ue_titulo               = "AYUDA SELECCION DE PLATOS"
ue_filtro               =""
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_prodplatos
integer x = 1984
integer y = 160
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_prodplatos
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_prodplatos
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_prodplatos
integer x = 9
integer y = 4
integer width = 2437
end type

type pb_calculadora from u_calculadora within wi_mant_prodplatos
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
 Into       :registros
 From     prodplatos
 Where  prodplatos.empresa = :codigo_empresa;
 IF registros=0 THEN
   sle_valor.text="1"
 ELSE
  Select max(convert(int,prodplatos.codigo)+1)
  Into     :sle_valor.text
  From   prodplatos
  Where  prodplatos.empresa = :codigo_empresa;
END IF
dw_1.triggerEvent("clicked")
  
end event

