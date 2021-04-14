$PBExportHeader$w_con_ubicaciones_incompletas.srw
forward
global type w_con_ubicaciones_incompletas from w_int_con_empresa
end type
type pb_2 from upb_imprimir within w_con_ubicaciones_incompletas
end type
type uo_1 from u_manejo_datawindow within w_con_ubicaciones_incompletas
end type
type dw_listado from datawindow within w_con_ubicaciones_incompletas
end type
type cb_2 from u_boton within w_con_ubicaciones_incompletas
end type
type dw_1 from datawindow within w_con_ubicaciones_incompletas
end type
type pb_1 from upb_salir within w_con_ubicaciones_incompletas
end type
end forward

global type w_con_ubicaciones_incompletas from w_int_con_empresa
integer width = 2917
integer height = 1628
pb_2 pb_2
uo_1 uo_1
dw_listado dw_listado
cb_2 cb_2
dw_1 dw_1
pb_1 pb_1
end type
global w_con_ubicaciones_incompletas w_con_ubicaciones_incompletas

type variables
String filtro

end variables

forward prototypes
public subroutine f_proceso (datawindow data)
end prototypes

public subroutine f_proceso (datawindow data);data.retrieve()
end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta diferencias almacen"
This.title=istr_parametros.s_titulo_ventana
dw_1.settransobject(SQLCA)
dw_listado.settransobject(SQLCA)

end event

on w_con_ubicaciones_incompletas.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.uo_1=create uo_1
this.dw_listado=create dw_listado
this.cb_2=create cb_2
this.dw_1=create dw_1
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.pb_1
end on

on w_con_ubicaciones_incompletas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.uo_1)
destroy(this.dw_listado)
destroy(this.cb_2)
destroy(this.dw_1)
destroy(this.pb_1)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_ubicaciones_incompletas
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_ubicaciones_incompletas
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_ubicaciones_incompletas
integer x = 5
end type

type pb_2 from upb_imprimir within w_con_ubicaciones_incompletas
integer x = 2011
integer y = 144
integer width = 101
integer height = 84
boolean originalsize = false
string picturename = "c:\bmp\print.bmp"
end type

event clicked;call super::clicked;f_proceso(dw_listado)
f_imprimir_datawindow(dw_listado)
end event

type uo_1 from u_manejo_datawindow within w_con_ubicaciones_incompletas
integer x = 1536
integer y = 100
integer width = 599
end type

on valores;call u_manejo_datawindow::valores;dw_data = dw_1
end on

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

type dw_listado from datawindow within w_con_ubicaciones_incompletas
boolean visible = false
integer x = 622
integer y = 96
integer width = 494
integer height = 164
integer taborder = 30
string dataobject = "report_ubicaciones_incompletas"
boolean livescroll = true
end type

type cb_2 from u_boton within w_con_ubicaciones_incompletas
integer x = 41
integer y = 152
integer width = 526
integer height = 92
integer taborder = 10
string text = "&Consultar"
end type

event clicked;call super::clicked;f_proceso(dw_1)
end event

type dw_1 from datawindow within w_con_ubicaciones_incompletas
event key pbm_dwnkey
integer y = 260
integer width = 2848
integer height = 1144
integer taborder = 20
string dataobject = "dw_con_ubicaciones_incompletas"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type pb_1 from upb_salir within w_con_ubicaciones_incompletas
integer x = 2670
integer y = 32
integer width = 133
integer height = 116
integer taborder = 0
boolean bringtotop = true
string picturename = "exit!"
end type

