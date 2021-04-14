$PBExportHeader$w_observaciones_almlinubica.srw
forward
global type w_observaciones_almlinubica from w_int_con_empresa
end type
type pb_2 from upb_salir within w_observaciones_almlinubica
end type
type dw_1 from u_datawindow_consultas within w_observaciones_almlinubica
end type
end forward

global type w_observaciones_almlinubica from w_int_con_empresa
integer x = 14
integer y = 292
integer width = 2949
integer height = 1664
string title = "Consulta de Movimientos"
pb_2 pb_2
dw_1 dw_1
end type
global w_observaciones_almlinubica w_observaciones_almlinubica

type variables
String referencia,tipo_pallet,caja
end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();dw_1.Retrieve(codigo_empresa,referencia,tipo_pallet,caja)


end subroutine

event open;call super::open;
dw_1.SetTransObject(sqlca)
This.title = " CONSULTA OBSERVACIONES POR REFERENCIA "
istr_parametros = Message.PowerObjectParm
referencia      = istr_parametros.s_argumentos[1]
tipo_pallet     = istr_parametros.s_argumentos[2]
caja            = istr_parametros.s_argumentos[3]
f_posicion_inicio(This)
f_control()

end event

on w_observaciones_almlinubica.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.dw_1
end on

on w_observaciones_almlinubica.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.dw_1)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_observaciones_almlinubica
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_observaciones_almlinubica
end type

type st_empresa from w_int_con_empresa`st_empresa within w_observaciones_almlinubica
integer y = 20
integer width = 2587
integer height = 112
end type

type pb_2 from upb_salir within w_observaciones_almlinubica
integer x = 2738
integer y = 16
integer width = 128
integer height = 112
integer taborder = 10
string picturename = "exit!"
end type

type dw_1 from u_datawindow_consultas within w_observaciones_almlinubica
integer x = 5
integer y = 168
integer width = 2871
integer height = 1276
integer taborder = 0
string dataobject = "dw_observaciones_almlinubica"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

