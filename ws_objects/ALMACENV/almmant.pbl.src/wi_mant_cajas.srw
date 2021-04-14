$PBExportHeader$wi_mant_cajas.srw
forward
global type wi_mant_cajas from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_cajas
end type
end forward

global type wi_mant_cajas from wi_mvent_con_empresa
integer width = 2930
integer height = 1132
pb_calculadora pb_calculadora
end type
global wi_mant_cajas wi_mant_cajas

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

event ue_inserta_fila;call super::ue_inserta_fila;   dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
   dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)

end event

event open;call super::open;   istr_parametros.s_titulo_ventana = "Mantenimiento de Cajas"
	istr_parametros.s_listado        = "report_cajas"
   This.title = istr_parametros.s_titulo_ventana
   
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      sle_valor.text=istr_parametros.s_argumentos[2]
      IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
       dw_1.Retrieve(codigo_empresa,sle_valor.Text)
      END IF
   END IF

	
end event

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE
end on

event ue_recuperar;// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         = "cajas"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)

CALL Super::ue_recuperar
end event

on wi_mant_cajas.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
end on

on wi_mant_cajas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
end on

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_cajas
integer x = 59
integer y = 340
integer width = 2199
integer height = 532
string dataobject = "dw_cajas"
end type

event dw_1::rbuttondown;bus_filtro=""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
CASE "codigo_compras"
	bus_titulo     = "AYUDA SELECCION DE MATERIAS"
	bus_datawindow = "dw_ayuda_venmprima"
CASE ELSE
	SetNull(bus_campo)
END CHOOSE
CALL Super::rbuttondown
end event

event dw_1::key;bus_filtro=""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
CASE "codigo_compras"
	bus_titulo     = "AYUDA SELECCION DE MATERIAS"
	bus_datawindow = "dw_ayuda_venmprima"
CASE ELSE
	SetNull(bus_campo)
END CHOOSE
CALL Super::key
end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_cajas
integer x = 302
integer width = 283
string text = "Caja "
alignment alignment = right!
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_cajas
integer x = 2327
integer y = 348
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_cajas
integer x = 2327
integer y = 468
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_cajas
integer x = 590
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow =  "dw_ayuda_cajas"
ue_titulo     =  "AYUDA SELECCION DE CAJAS"
ue_filtro     =  ""
isle_campo    = This
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_cajas
integer x = 2327
integer y = 588
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_cajas
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_cajas
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_cajas
integer width = 2149
end type

type pb_calculadora from u_calculadora within wi_mant_cajas
integer x = 855
integer y = 212
integer width = 119
integer height = 104
integer taborder = 0
string picturename = "c:\bmp\calcula.bmp"
end type

event clicked;IF cb_insertar.enabled=TRUE THEN Return
 Integer registros
 Select count(*) Into :registros From almcajas
 Where  almcajas.empresa = :codigo_empresa;
 IF registros=0  Then
  sle_valor.text="1"
 ELSE
  Select max(convert(int,almcajas.codigo)+1)
  Into   :sle_valor.text
  From   almcajas
  Where  almcajas.empresa = :codigo_empresa;
 END IF
 dw_1.TriggerEvent("Clicked")
end event

