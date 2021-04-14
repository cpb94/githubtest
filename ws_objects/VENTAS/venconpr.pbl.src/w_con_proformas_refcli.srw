$PBExportHeader$w_con_proformas_refcli.srw
forward
global type w_con_proformas_refcli from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_proformas_refcli
end type
type pb_2 from upb_imprimir within w_con_proformas_refcli
end type
type st_2 from statictext within w_con_proformas_refcli
end type
type em_refcli from u_em_campo within w_con_proformas_refcli
end type
type dw_detalle from datawindow within w_con_proformas_refcli
end type
type dw_listado from datawindow within w_con_proformas_refcli
end type
type uo_manejo from u_manejo_datawindow within w_con_proformas_refcli
end type
end forward

global type w_con_proformas_refcli from w_int_con_empresa
integer width = 2917
integer height = 1636
pb_1 pb_1
pb_2 pb_2
st_2 st_2
em_refcli em_refcli
dw_detalle dw_detalle
dw_listado dw_listado
uo_manejo uo_manejo
end type
global w_con_proformas_refcli w_con_proformas_refcli

type variables
string filtro
end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();dw_detalle.Reset()
dw_detalle.Retrieve(codigo_empresa,"%" + em_refcli.text + "%" )

end subroutine

on close;call w_int_con_empresa::close;dw_detalle.reset()
dw_listado.reset()
end on

on ue_pagina_arriba;call w_int_con_empresa::ue_pagina_arriba;uo_manejo.TriggerEvent("pagina_arriba")
end on

on ue_cursor_arriba;call w_int_con_empresa::ue_cursor_arriba;uo_manejo.TriggerEvent("linea_arriba")
end on

on ue_pagina_abajo;call w_int_con_empresa::ue_pagina_abajo;uo_manejo.TriggerEvent("pagina_abajo")
end on

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta lineas de proforma por Referencia"
This.title=istr_parametros.s_titulo_ventana

dw_detalle.SetTransObject(SQLCA)

end event

event ue_listar;dw_report  = dw_listado
dw_report.SetTransObject(SQLCA)
Datetime fecha
dw_report.retrieve(codigo_empresa,"%" + em_refcli.text + "%" )
IF TRIM(filtro)<>"" THEN
 dw_report.SetFilter(filtro)
 dw_report.Filter()
END IF
CALL Super::ue_listar
end event

on w_con_proformas_refcli.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.st_2=create st_2
this.em_refcli=create em_refcli
this.dw_detalle=create dw_detalle
this.dw_listado=create dw_listado
this.uo_manejo=create uo_manejo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.em_refcli
this.Control[iCurrent+5]=this.dw_detalle
this.Control[iCurrent+6]=this.dw_listado
this.Control[iCurrent+7]=this.uo_manejo
end on

on w_con_proformas_refcli.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.st_2)
destroy(this.em_refcli)
destroy(this.dw_detalle)
destroy(this.dw_listado)
destroy(this.uo_manejo)
end on

on ue_cursor_abajo;call w_int_con_empresa::ue_cursor_abajo;uo_manejo.TriggerEvent("linea_abajo")
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_proformas_refcli
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_proformas_refcli
integer taborder = 180
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(em_refcli)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_proformas_refcli
integer x = 14
integer y = 8
integer width = 2427
integer height = 96
end type

type pb_1 from upb_salir within w_con_proformas_refcli
integer x = 2711
integer y = 8
integer width = 110
integer height = 96
integer taborder = 0
string picturename = "exit!"
end type

type pb_2 from upb_imprimir within w_con_proformas_refcli
integer x = 2711
integer y = 140
integer taborder = 0
string picturename = "print!"
end type

event clicked;call super::clicked;Parent.triggerEvent("ue_listar")

end event

type st_2 from statictext within w_con_proformas_refcli
integer x = 50
integer y = 144
integer width = 334
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Referencia"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_refcli from u_em_campo within w_con_proformas_refcli
integer x = 411
integer y = 140
integer width = 425
integer taborder = 160
long backcolor = 16773367
end type

event modificado;call super::modificado; 
 f_control()


end event

event rbuttondown;call super::rbuttondown;return 
end event

event tecla_enter;call super::tecla_enter;return 
end event

event tecla_tabulador;call super::tecla_tabulador;IF Len(This.text)=0  Then 
    return
END IF

end event

type dw_detalle from datawindow within w_con_proformas_refcli
integer x = 18
integer y = 244
integer width = 2821
integer height = 1168
string dataobject = "dw_con_proformas_refcli"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;str_parametros lstr_param
IF Row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"proforma"))
  OpenWithParm(w_int_venproformas,lstr_param) 
End If
end event

type dw_listado from datawindow within w_con_proformas_refcli
boolean visible = false
integer x = 507
integer width = 160
integer height = 96
integer taborder = 200
boolean bringtotop = true
string dataobject = "report_con_proformas_refcli"
boolean livescroll = true
end type

type uo_manejo from u_manejo_datawindow within w_con_proformas_refcli
integer x = 2235
integer y = 96
integer width = 649
integer height = 144
end type

event valores;call super::valores;dw_data       = dw_detalle
dw_data.SetTransObject(SQLCA)
f_activar_campo(em_refcli)
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

