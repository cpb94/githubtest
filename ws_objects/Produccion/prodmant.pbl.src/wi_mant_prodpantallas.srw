$PBExportHeader$wi_mant_prodpantallas.srw
forward
global type wi_mant_prodpantallas from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_prodpantallas
end type
end forward

global type wi_mant_prodpantallas from wi_mvent_con_empresa
integer x = 0
integer y = 0
integer width = 2217
integer height = 1164
pb_calculadora pb_calculadora
end type
global wi_mant_prodpantallas wi_mant_prodpantallas

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

istr_parametros.s_titulo_ventana  = "Mantenimiento de Pantallas"

This.title = istr_parametros.s_titulo_ventana

// Si recibo el codigo lo visualizo
//IF istr_parametros.i_nargumentos>1 THEN
//	sle_valor.text=istr_parametros.s_argumentos[2]
//	IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
//		dw_1.Retrieve(codigo_empresa,sle_valor.Text)
//	END IF
//END IF

	
end event

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

event ue_inserta_fila;call super::ue_inserta_fila; dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
 dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)

end event

event ue_recuperar;// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         =  "prodpantallas"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)

CALL Super::ue_recuperar
end event

on wi_mant_prodpantallas.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
end on

on wi_mant_prodpantallas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_prodpantallas
integer x = 32
integer y = 260
integer width = 1554
integer height = 612
string dataobject = "dw_mant_prodpantallas"
end type

event dw_1::rbuttondown;bus_filtro    = ""
valor_empresa = TRUE	
bus_titulo    = ""
bus_campo     = This.GetColumnName()
CHOOSE CASE bus_campo
	CASE "proveedor"
		bus_datawindow = "dw_ayuda_proveedores"
		bus_titulo     = "AYUDA SELECCION DE PROVEEDORES"
	CASE "juegopantallas"
		bus_datawindow = "dw_ayuda_juegospantallas"
		bus_titulo     = "AYUDA SELECCION DE JUEGOS DE PANTALLAS"
		
END CHOOSE

call super::rbuttondown
end event

event dw_1::key;call super::key;bus_filtro    = ""
valor_empresa = TRUE	
bus_titulo    = ""
bus_campo     = This.GetColumnName()
CHOOSE CASE bus_campo
	CASE "proveedor"
		bus_datawindow = "dw_ayuda_proveedores"
		bus_titulo     = "AYUDA SELECCION DE PROVEEDORES"
	CASE "juegopantallas"
		bus_datawindow = "dw_ayuda_juegospantallas"
		bus_titulo     = "AYUDA SELECCION JUEGOS DE PANTALLAS"
		
END CHOOSE

call super::key
end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_prodpantallas
integer x = 59
integer y = 168
integer width = 270
string text = "Código:"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_prodpantallas
integer x = 1618
integer y = 436
integer width = 393
end type

event cb_insertar::clicked;String descrip
if this.enabled then
	dw_1.accepttext()
	descrip = dw_1.GetItemString(dw_1.GetRow(),"descripcion")
	
	if IsNull(descrip) or Trim(descrip) = "" then
		f_mensaje("Atención","Ha de introducir la descripción de la pantalla")
		dw_1.SetFocus()
		return
	end if
end if
Call super::clicked
end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_prodpantallas
integer x = 1618
integer y = 532
integer width = 393
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_prodpantallas
integer x = 361
integer y = 160
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow  = "dw_ayuda_prodpantallas"
ue_titulo      = "AYUDA SELECCION DE PANTALLAS"
ue_filtro      = ""
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_prodpantallas
integer x = 1618
integer y = 624
integer width = 393
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_prodpantallas
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_prodpantallas
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_prodpantallas
integer width = 1966
end type

type pb_calculadora from u_calculadora within wi_mant_prodpantallas
integer x = 626
integer y = 156
integer width = 114
integer height = 100
integer taborder = 0
boolean originalsize = false
string picturename = "c:\bmp\calcula.bmp"
end type

event clicked;Integer registros

IF cb_insertar.enabled THEN Return

Select count(*) 
Into   :registros
From   prodpantallas
Where  prodpantallas.empresa = :codigo_empresa;

IF registros = 0 THEN
	sle_valor.text="1"
ELSE
	Select max(convert(int,prodpantallas.codigo)+1)
	Into   :sle_valor.text
	From   prodpantallas
	Where  prodpantallas.empresa = :codigo_empresa;
END IF
dw_1.triggerEvent("clicked")
  
end event

