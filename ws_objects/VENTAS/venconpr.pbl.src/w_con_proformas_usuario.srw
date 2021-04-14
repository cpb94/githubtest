$PBExportHeader$w_con_proformas_usuario.srw
forward
global type w_con_proformas_usuario from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_proformas_usuario
end type
type pb_2 from upb_imprimir within w_con_proformas_usuario
end type
type st_2 from statictext within w_con_proformas_usuario
end type
type em_refcli from u_em_campo within w_con_proformas_usuario
end type
type dw_detalle from datawindow within w_con_proformas_usuario
end type
type dw_listado from datawindow within w_con_proformas_usuario
end type
type uo_manejo from u_manejo_datawindow within w_con_proformas_usuario
end type
type st_9 from statictext within w_con_proformas_usuario
end type
type em_fechadesde from u_em_campo within w_con_proformas_usuario
end type
type st_8 from statictext within w_con_proformas_usuario
end type
type em_fechahasta from u_em_campo within w_con_proformas_usuario
end type
type gb_1 from groupbox within w_con_proformas_usuario
end type
type cb_1 from commandbutton within w_con_proformas_usuario
end type
end forward

global type w_con_proformas_usuario from w_int_con_empresa
integer width = 2926
integer height = 1644
pb_1 pb_1
pb_2 pb_2
st_2 st_2
em_refcli em_refcli
dw_detalle dw_detalle
dw_listado dw_listado
uo_manejo uo_manejo
st_9 st_9
em_fechadesde em_fechadesde
st_8 st_8
em_fechahasta em_fechahasta
gb_1 gb_1
cb_1 cb_1
end type
global w_con_proformas_usuario w_con_proformas_usuario

type variables
string filtro
end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();dw_detalle.Reset()
Datetime fecha1,fecha2
fecha1=Datetime(Date(String(em_fechadesde.Text)))
fecha2=Datetime(Date(String(em_fechahasta.Text)))

if len(em_refcli.text)=0 then em_refcli.text = "%"
dw_detalle.Retrieve(codigo_empresa,"%" + em_refcli.text + "%",fecha1,fecha2)

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

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta lineas de proformas por Usuario"
This.title=istr_parametros.s_titulo_ventana
em_fechadesde.text = String(MDY(01,01,Year(Today())))
em_fechahasta.text = String(Today())
dw_detalle.SetTransObject(SQLCA)

end event

event ue_listar;dw_report  = dw_listado
dw_report.SetTransObject(SQLCA)
Datetime fecha1,fecha2
fecha1=Datetime(Date(String(em_fechadesde.Text)))
fecha2=Datetime(Date(String(em_fechahasta.Text)))

dw_report.Retrieve(codigo_empresa,"%" + em_refcli.text + "%",fecha1,fecha2)

IF TRIM(filtro)<>"" THEN
 dw_report.SetFilter(filtro)
 dw_report.Filter()
END IF
CALL Super::ue_listar
end event

on w_con_proformas_usuario.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.st_2=create st_2
this.em_refcli=create em_refcli
this.dw_detalle=create dw_detalle
this.dw_listado=create dw_listado
this.uo_manejo=create uo_manejo
this.st_9=create st_9
this.em_fechadesde=create em_fechadesde
this.st_8=create st_8
this.em_fechahasta=create em_fechahasta
this.gb_1=create gb_1
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.em_refcli
this.Control[iCurrent+5]=this.dw_detalle
this.Control[iCurrent+6]=this.dw_listado
this.Control[iCurrent+7]=this.uo_manejo
this.Control[iCurrent+8]=this.st_9
this.Control[iCurrent+9]=this.em_fechadesde
this.Control[iCurrent+10]=this.st_8
this.Control[iCurrent+11]=this.em_fechahasta
this.Control[iCurrent+12]=this.gb_1
this.Control[iCurrent+13]=this.cb_1
end on

on w_con_proformas_usuario.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.st_2)
destroy(this.em_refcli)
destroy(this.dw_detalle)
destroy(this.dw_listado)
destroy(this.uo_manejo)
destroy(this.st_9)
destroy(this.em_fechadesde)
destroy(this.st_8)
destroy(this.em_fechahasta)
destroy(this.gb_1)
destroy(this.cb_1)
end on

on ue_cursor_abajo;call w_int_con_empresa::ue_cursor_abajo;uo_manejo.TriggerEvent("linea_abajo")
end on

event ue_f5;call super::ue_f5;f_control()
end event

event activate;call super::activate;w_con_proformas_usuario = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_proformas_usuario
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_proformas_usuario
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(em_refcli)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_proformas_usuario
integer x = 14
integer y = 8
integer width = 2427
integer height = 88
end type

type pb_1 from upb_salir within w_con_proformas_usuario
integer x = 2711
integer y = 8
integer width = 110
integer height = 96
integer taborder = 0
string picturename = "exit!"
end type

type pb_2 from upb_imprimir within w_con_proformas_usuario
integer x = 2711
integer y = 212
integer taborder = 0
string picturename = "print!"
end type

event clicked;call super::clicked;Parent.triggerEvent("ue_listar")

end event

type st_2 from statictext within w_con_proformas_usuario
integer x = 1266
integer y = 112
integer width = 471
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
string text = "Usuario"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_refcli from u_em_campo within w_con_proformas_usuario
integer x = 1266
integer y = 192
integer width = 471
integer taborder = 180
long backcolor = 16773367
end type

event rbuttondown;call super::rbuttondown;return 
end event

event tecla_enter;call super::tecla_enter;return 
end event

event tecla_tabulador;call super::tecla_tabulador;IF Len(This.text)=0  Then 
    return
END IF

end event

type dw_detalle from datawindow within w_con_proformas_usuario
integer x = 5
integer y = 312
integer width = 2834
integer height = 1100
string dataobject = "dw_con_proformas_usuario"
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

type dw_listado from datawindow within w_con_proformas_usuario
boolean visible = false
integer x = 507
integer width = 160
integer height = 96
integer taborder = 220
boolean bringtotop = true
string dataobject = "report_con_proformas_usuario"
boolean livescroll = true
end type

type uo_manejo from u_manejo_datawindow within w_con_proformas_usuario
integer x = 2235
integer y = 168
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

type st_9 from statictext within w_con_proformas_usuario
integer x = 78
integer y = 168
integer width = 233
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Desde"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_fechadesde from u_em_campo within w_con_proformas_usuario
integer x = 315
integer y = 168
integer width = 320
integer taborder = 10
boolean bringtotop = true
long backcolor = 33551093
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_8 from statictext within w_con_proformas_usuario
integer x = 645
integer y = 168
integer width = 233
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Hasta"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_fechahasta from u_em_campo within w_con_proformas_usuario
integer x = 869
integer y = 168
integer width = 320
integer taborder = 20
boolean bringtotop = true
long backcolor = 33551093
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type gb_1 from groupbox within w_con_proformas_usuario
integer x = 50
integer y = 108
integer width = 1184
integer height = 168
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type cb_1 from commandbutton within w_con_proformas_usuario
integer x = 1774
integer y = 196
integer width = 357
integer height = 80
integer taborder = 190
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "F5 Continuar"
end type

event clicked; f_control()

end event

