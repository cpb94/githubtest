$PBExportHeader$w_con_uticonexiones.srw
forward
global type w_con_uticonexiones from w_int_con_empresa
end type
type dw_consulta from datawindow within w_con_uticonexiones
end type
type cb_1 from u_boton within w_con_uticonexiones
end type
type cb_2 from u_boton within w_con_uticonexiones
end type
type pb_1 from upb_salir within w_con_uticonexiones
end type
end forward

global type w_con_uticonexiones from w_int_con_empresa
integer width = 2889
integer height = 1660
dw_consulta dw_consulta
cb_1 cb_1
cb_2 cb_2
pb_1 pb_1
end type
global w_con_uticonexiones w_con_uticonexiones

type variables
string filtro
end variables

on open;call w_int_con_empresa::open;istr_parametros.s_titulo_ventana="Consulta usuarios conectados"
This.title=istr_parametros.s_titulo_ventana
dw_consulta.SetTransobject(SQLCA)
dw_consulta.Retrieve()


end on

on ue_listar;//dw_report  = dw_listado
//dw_report.SetTransObject(SQLCA)
//dw_report.retrieve()
//IF TRIM(filtro)<>"" THEN
// dw_report.SetFilter(filtro)
// dw_report.Filter()
//END IF
//CALL Super::ue_listar
end on

on w_con_uticonexiones.create
int iCurrent
call super::create
this.dw_consulta=create dw_consulta
this.cb_1=create cb_1
this.cb_2=create cb_2
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_consulta
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.pb_1
end on

on w_con_uticonexiones.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_consulta)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.pb_1)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_uticonexiones
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_uticonexiones
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_uticonexiones
integer x = 27
integer y = 8
integer width = 2427
end type

type dw_consulta from datawindow within w_con_uticonexiones
integer x = 14
integer y = 284
integer width = 2821
integer height = 1128
boolean bringtotop = true
string dataobject = "dw_con_uticonexiones"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF row = 0 Then Return


end event

type cb_1 from u_boton within w_con_uticonexiones
integer x = 448
integer y = 172
integer height = 92
integer taborder = 0
string text = "&Borrar"
end type

on clicked;call u_boton::clicked;Delete from uticonexiones;
COMMIT;
dw_consulta.Retrieve()
end on

type cb_2 from u_boton within w_con_uticonexiones
integer x = 32
integer y = 172
integer height = 92
integer taborder = 0
string text = "&Consultar"
end type

on clicked;call u_boton::clicked;dw_consulta.Retrieve()
end on

type pb_1 from upb_salir within w_con_uticonexiones
integer x = 2679
integer width = 110
integer height = 96
integer taborder = 20
boolean originalsize = true
string picturename = "exit!"
end type

