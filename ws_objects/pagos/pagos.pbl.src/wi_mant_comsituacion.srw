$PBExportHeader$wi_mant_comsituacion.srw
forward
global type wi_mant_comsituacion from wi_mvent_con_empresa
end type
type pb_1 from upb_salir within wi_mant_comsituacion
end type
end forward

global type wi_mant_comsituacion from wi_mvent_con_empresa
integer width = 2715
integer height = 920
pb_1 pb_1
end type
global wi_mant_comsituacion wi_mant_comsituacion

type variables

end variables

event open;call super::open;   istr_parametros.s_titulo_ventana  = "Mantenimiento de Situaciones de Pagos"
	istr_parametros.s_listado         = "report_comsituacion"
   This.title = istr_parametros.s_titulo_ventana
   
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      sle_valor.text=istr_parametros.s_argumentos[2]
      IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
         dw_1.Retrieve(codigo_empresa,sle_valor.Text)
      END IF
   END IF

f_activar_campo(sle_valor)	
end event

event ue_inserta_fila;call super::ue_inserta_fila; dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
 dw_1.setitem(dw_1.getrow(),"situacion",sle_valor.text)

end event

event ue_recuperar;

// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         =  "comsituacion"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)

CALL Super::ue_recuperar
end event

on wi_mant_comsituacion.create
int iCurrent
call super::create
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
end on

on wi_mant_comsituacion.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_comsituacion
integer x = 105
integer y = 356
integer width = 1742
integer height = 276
string dataobject = "dw_comsituacion"
end type

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_comsituacion
integer x = 155
integer width = 270
string text = "Código"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_comsituacion
integer x = 1961
integer y = 336
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_comsituacion
integer x = 1961
integer y = 464
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_comsituacion
integer x = 457
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow  = "dw_ayuda_comsituacion"
ue_titulo      = "AYUDA SELECCION DE SITUACIONES DE PAGOS"
ue_filtro      = ""
isle_campo        = This
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_comsituacion
integer x = 1961
integer y = 580
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_comsituacion
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_comsituacion
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_comsituacion
integer width = 2624
end type

type pb_1 from upb_salir within wi_mant_comsituacion
integer x = 2450
integer y = 160
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

