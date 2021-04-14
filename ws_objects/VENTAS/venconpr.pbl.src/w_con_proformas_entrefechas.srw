$PBExportHeader$w_con_proformas_entrefechas.srw
forward
global type w_con_proformas_entrefechas from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_proformas_entrefechas
end type
type pb_2 from upb_imprimir within w_con_proformas_entrefechas
end type
type dw_detalle from datawindow within w_con_proformas_entrefechas
end type
type dw_listado from datawindow within w_con_proformas_entrefechas
end type
type uo_manejo from u_manejo_datawindow within w_con_proformas_entrefechas
end type
type st_9 from statictext within w_con_proformas_entrefechas
end type
type em_fechadesde from u_em_campo within w_con_proformas_entrefechas
end type
type st_8 from statictext within w_con_proformas_entrefechas
end type
type em_fechahasta from u_em_campo within w_con_proformas_entrefechas
end type
type gb_boton from groupbox within w_con_proformas_entrefechas
end type
type gb_1 from groupbox within w_con_proformas_entrefechas
end type
type cb_1 from commandbutton within w_con_proformas_entrefechas
end type
type cb_2 from commandbutton within w_con_proformas_entrefechas
end type
type cb_3 from commandbutton within w_con_proformas_entrefechas
end type
end forward

global type w_con_proformas_entrefechas from w_int_con_empresa
integer width = 2930
integer height = 1660
pb_1 pb_1
pb_2 pb_2
dw_detalle dw_detalle
dw_listado dw_listado
uo_manejo uo_manejo
st_9 st_9
em_fechadesde em_fechadesde
st_8 st_8
em_fechahasta em_fechahasta
gb_boton gb_boton
gb_1 gb_1
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
end type
global w_con_proformas_entrefechas w_con_proformas_entrefechas

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

dw_detalle.Retrieve(codigo_empresa,fecha1,fecha2)

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

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta de Proformas entre Fechas"
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

dw_report.Retrieve(codigo_empresa,fecha1,fecha2)

IF TRIM(filtro)<>"" THEN
 dw_report.SetFilter(filtro)
 dw_report.Filter()
END IF
CALL Super::ue_listar
end event

on w_con_proformas_entrefechas.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.dw_detalle=create dw_detalle
this.dw_listado=create dw_listado
this.uo_manejo=create uo_manejo
this.st_9=create st_9
this.em_fechadesde=create em_fechadesde
this.st_8=create st_8
this.em_fechahasta=create em_fechahasta
this.gb_boton=create gb_boton
this.gb_1=create gb_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.dw_detalle
this.Control[iCurrent+4]=this.dw_listado
this.Control[iCurrent+5]=this.uo_manejo
this.Control[iCurrent+6]=this.st_9
this.Control[iCurrent+7]=this.em_fechadesde
this.Control[iCurrent+8]=this.st_8
this.Control[iCurrent+9]=this.em_fechahasta
this.Control[iCurrent+10]=this.gb_boton
this.Control[iCurrent+11]=this.gb_1
this.Control[iCurrent+12]=this.cb_1
this.Control[iCurrent+13]=this.cb_2
this.Control[iCurrent+14]=this.cb_3
end on

on w_con_proformas_entrefechas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.dw_detalle)
destroy(this.dw_listado)
destroy(this.uo_manejo)
destroy(this.st_9)
destroy(this.em_fechadesde)
destroy(this.st_8)
destroy(this.em_fechahasta)
destroy(this.gb_boton)
destroy(this.gb_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
end on

on ue_cursor_abajo;call w_int_con_empresa::ue_cursor_abajo;uo_manejo.TriggerEvent("linea_abajo")
end on

event ue_f5;call super::ue_f5;f_control()
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_proformas_entrefechas
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_proformas_entrefechas
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_proformas_entrefechas
integer x = 14
integer y = 8
integer width = 2427
integer height = 104
end type

type pb_1 from upb_salir within w_con_proformas_entrefechas
integer x = 2711
integer y = 8
integer width = 110
integer height = 96
integer taborder = 0
string picturename = "exit!"
end type

type pb_2 from upb_imprimir within w_con_proformas_entrefechas
integer x = 2711
integer y = 176
integer taborder = 0
string picturename = "print!"
end type

event clicked;call super::clicked;//w_con_proformas_usuario.triggerEvent("ue_listar")
Parent.triggerEvent("ue_listar")

end event

type dw_detalle from datawindow within w_con_proformas_entrefechas
integer y = 284
integer width = 2834
integer height = 1132
string dataobject = "dw_con_proformas_entrefechas"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;  if Row=0 then return
  
  str_parametros lstr_param
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"proforma"))
  OpenWithParm(w_int_venproformas,lstr_param) 

end event

type dw_listado from datawindow within w_con_proformas_entrefechas
boolean visible = false
integer x = 507
integer width = 160
integer height = 96
integer taborder = 70
boolean bringtotop = true
string dataobject = "report_con_proformas_entrefechas"
boolean livescroll = true
end type

type uo_manejo from u_manejo_datawindow within w_con_proformas_entrefechas
integer x = 2235
integer y = 132
integer width = 649
integer height = 144
end type

event valores;call super::valores;dw_data       = dw_detalle
dw_data.SetTransObject(SQLCA)

end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type st_9 from statictext within w_con_proformas_entrefechas
integer x = 18
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

type em_fechadesde from u_em_campo within w_con_proformas_entrefechas
integer x = 256
integer y = 168
integer width = 320
integer taborder = 20
boolean bringtotop = true
long backcolor = 33551093
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_8 from statictext within w_con_proformas_entrefechas
integer x = 585
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

type em_fechahasta from u_em_campo within w_con_proformas_entrefechas
integer x = 809
integer y = 168
integer width = 320
integer taborder = 30
boolean bringtotop = true
long backcolor = 33551093
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type gb_boton from groupbox within w_con_proformas_entrefechas
integer x = 1166
integer y = 136
integer width = 1042
integer height = 128
integer taborder = 80
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_1 from groupbox within w_con_proformas_entrefechas
integer x = 5
integer y = 108
integer width = 1147
integer height = 168
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type cb_1 from commandbutton within w_con_proformas_entrefechas
integer x = 1838
integer y = 176
integer width = 357
integer height = 76
integer taborder = 60
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

type cb_2 from commandbutton within w_con_proformas_entrefechas
event clicked pbm_bnclicked
integer x = 1179
integer y = 176
integer width = 329
integer height = 76
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Detalle"
end type

event clicked;dw_detalle.Modify("DataWindow.header.1.Height=161")
dw_detalle.Modify("DataWindow.detail.Height=73")
end event

type cb_3 from commandbutton within w_con_proformas_entrefechas
event clicked pbm_bnclicked
integer x = 1509
integer y = 176
integer width = 329
integer height = 76
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Resumen"
end type

event clicked;dw_detalle.Modify("DataWindow.detail.Height=0")
dw_detalle.Modify("DataWindow.header.1.Height=81")

end event

