$PBExportHeader$w_mant_venenvases.srw
$PBExportComments$Mantenimiento de envases
forward
global type w_mant_venenvases from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within w_mant_venenvases
end type
end forward

global type w_mant_venenvases from wi_mvent_con_empresa
integer width = 2720
integer height = 1204
string icon = "\bmp\RINO.ICO"
pb_calculadora pb_calculadora
end type
global w_mant_venenvases w_mant_venenvases

on w_mant_venenvases.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
end on

on w_mant_venenvases.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
end on

event open;call super::open;  istr_parametros.s_titulo_ventana = "Mantenimiento de Envases"
	istr_parametros.s_listado        = "report_venenvases"
   This.title = istr_parametros.s_titulo_ventana
   
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      sle_valor.text=istr_parametros.s_argumentos[2]
      IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
       dw_1.Retrieve(codigo_empresa,sle_valor.Text)
      END IF
   END IF
end event

event ue_inserta_fila;call super::ue_inserta_fila; dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
 dw_1.setitem(dw_1.getrow(),"envase",sle_valor.text)
end event

event ue_recuperar;// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         =  "venenvases"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)

CALL Super::ue_recuperar
end event

event ue_activa_claves;call super::ue_activa_claves;pb_calculadora.visible = TRUE
end event

event ue_desactiva_claves;call super::ue_desactiva_claves;pb_calculadora.visible = FALSE
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within w_mant_venenvases
integer x = 46
integer y = 340
integer width = 2578
integer height = 640
string dataobject = "dw_venenvases"
end type

event dw_1::key;bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 valor_empresa = false
 CHOOSE CASE bus_campo
 	CASE "unidad"
 		bus_datawindow = "dw_ayuda_comunimedida"
		bus_titulo = "VENTANA SELECCION DE UNIDADES"
 	CASE "producto"
 		bus_datawindow = "dw_ayuda_venmprima"
		bus_titulo = "VENTANA SELECCION DE ARTÍCULOS"
		valor_empresa = TRUE
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::key
end event

event dw_1::rbuttondown; bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 valor_empresa = false
 CHOOSE CASE bus_campo
 	CASE "unidad"
 		bus_datawindow = "dw_ayuda_comunimedida"
		bus_titulo = "VENTANA SELECCION DE UNIDADES"
 	CASE "producto"
 		bus_datawindow = "dw_ayuda_venmprima"
		bus_titulo = "VENTANA SELECCION DE ARTÍCULOS"
		valor_empresa = TRUE
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

type st_1 from wi_mvent_con_empresa`st_1 within w_mant_venenvases
integer x = 183
integer width = 297
string text = "Codigo:"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within w_mant_venenvases
integer x = 1157
integer y = 216
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within w_mant_venenvases
integer x = 1659
integer y = 216
string text = "&Borrar  "
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within w_mant_venenvases
integer width = 389
integer taborder = 20
end type

event sle_valor::getfocus;call super::getfocus;ue_titulo ="AYUDA SELECCION DE FAMILIAS"
ue_datawindow ="dw_ayuda_venenvases"
ue_filtro =""
isle_campo =this
valor_empresa = TRUE
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within w_mant_venenvases
integer x = 2162
integer y = 216
fontcharset fontcharset = defaultcharset!
string text = "&Salir    "
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within w_mant_venenvases
integer taborder = 40
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within w_mant_venenvases
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within w_mant_venenvases
integer x = 23
integer y = 40
integer height = 100
integer textsize = -14
fontcharset fontcharset = defaultcharset!
long textcolor = 128
end type

type pb_calculadora from u_calculadora within w_mant_venenvases
integer x = 891
integer y = 208
integer taborder = 0
end type

event clicked;call super::clicked;IF cb_insertar.enabled=TRUE THEN Return
 Integer registros
 Select count(*) Into :registros From venenvases
 Where venenvases.empresa = :codigo_empresa;
 IF registros=0  Then
  sle_valor.text="1"
 ELSE
  Select max(convert(int,venenvases.envase)+1)
  Into   :sle_valor.text
  From   venenvases
  Where venenvases.empresa = :codigo_empresa;
 END IF
 dw_1.TriggerEvent("Clicked")
end event

