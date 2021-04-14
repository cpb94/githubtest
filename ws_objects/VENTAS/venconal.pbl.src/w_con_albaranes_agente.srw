$PBExportHeader$w_con_albaranes_agente.srw
forward
global type w_con_albaranes_agente from w_int_con_empresa
end type
type gb_1 from groupbox within w_con_albaranes_agente
end type
type pb_1 from upb_salir within w_con_albaranes_agente
end type
type pb_2 from upb_imprimir within w_con_albaranes_agente
end type
type dw_detalle from datawindow within w_con_albaranes_agente
end type
type dw_listado from datawindow within w_con_albaranes_agente
end type
type uo_manejo from u_manejo_datawindow within w_con_albaranes_agente
end type
type em_desde from u_em_campo within w_con_albaranes_agente
end type
type st_4 from statictext within w_con_albaranes_agente
end type
type em_hasta from u_em_campo within w_con_albaranes_agente
end type
type cb_1 from commandbutton within w_con_albaranes_agente
end type
type uo_agente from u_em_campo_2 within w_con_albaranes_agente
end type
type st_2 from statictext within w_con_albaranes_agente
end type
type st_3 from statictext within w_con_albaranes_agente
end type
end forward

global type w_con_albaranes_agente from w_int_con_empresa
integer width = 2912
integer height = 1684
gb_1 gb_1
pb_1 pb_1
pb_2 pb_2
dw_detalle dw_detalle
dw_listado dw_listado
uo_manejo uo_manejo
em_desde em_desde
st_4 st_4
em_hasta em_hasta
cb_1 cb_1
uo_agente uo_agente
st_2 st_2
st_3 st_3
end type
global w_con_albaranes_agente w_con_albaranes_agente

type variables
string filtro
end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();dw_detalle.Reset()

Datetime fecha1,fecha2
fecha1=Datetime(Date(String(em_desde.Text)))
fecha2=Datetime(Date(String(em_hasta.Text)))


dw_detalle.Retrieve(codigo_empresa,uo_agente.em_codigo.text,fecha1,fecha2)

f_activar_campo(uo_agente.em_campo)
end subroutine

event close;call super::close;dw_detalle.reset()
dw_listado.reset()
end event

on ue_pagina_arriba;call w_int_con_empresa::ue_pagina_arriba;uo_manejo.TriggerEvent("pagina_arriba")
end on

on ue_cursor_arriba;call w_int_con_empresa::ue_cursor_arriba;uo_manejo.TriggerEvent("linea_arriba")
end on

on ue_pagina_abajo;call w_int_con_empresa::ue_pagina_abajo;uo_manejo.TriggerEvent("pagina_abajo")
end on

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta lineas de albarán por agente"
This.title=istr_parametros.s_titulo_ventana


em_desde.text = String(MDY(01,01,Year(Today())))
em_hasta.text = String(Today())

dw_detalle.SetTransObject(SQLCA)

f_activar_campo(uo_agente.em_campo)

end event

event ue_listar;dw_report  = dw_listado
dw_report.SetTransObject(SQLCA)

Datetime fecha1,fecha2
fecha1=Datetime(Date(String(em_desde.Text)))
fecha2=Datetime(Date(String(em_hasta.Text)))


dw_report.Retrieve(codigo_empresa,uo_agente.em_codigo.text,fecha1,fecha2)

IF TRIM(filtro)<>"" THEN
 dw_report.SetFilter(filtro)
 dw_report.Filter()
END IF
CALL Super::ue_listar

f_activar_campo(uo_agente.em_campo)
end event

on w_con_albaranes_agente.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.pb_1=create pb_1
this.pb_2=create pb_2
this.dw_detalle=create dw_detalle
this.dw_listado=create dw_listado
this.uo_manejo=create uo_manejo
this.em_desde=create em_desde
this.st_4=create st_4
this.em_hasta=create em_hasta
this.cb_1=create cb_1
this.uo_agente=create uo_agente
this.st_2=create st_2
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.pb_1
this.Control[iCurrent+3]=this.pb_2
this.Control[iCurrent+4]=this.dw_detalle
this.Control[iCurrent+5]=this.dw_listado
this.Control[iCurrent+6]=this.uo_manejo
this.Control[iCurrent+7]=this.em_desde
this.Control[iCurrent+8]=this.st_4
this.Control[iCurrent+9]=this.em_hasta
this.Control[iCurrent+10]=this.cb_1
this.Control[iCurrent+11]=this.uo_agente
this.Control[iCurrent+12]=this.st_2
this.Control[iCurrent+13]=this.st_3
end on

on w_con_albaranes_agente.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_1)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.dw_detalle)
destroy(this.dw_listado)
destroy(this.uo_manejo)
destroy(this.em_desde)
destroy(this.st_4)
destroy(this.em_hasta)
destroy(this.cb_1)
destroy(this.uo_agente)
destroy(this.st_2)
destroy(this.st_3)
end on

on ue_cursor_abajo;call w_int_con_empresa::ue_cursor_abajo;uo_manejo.TriggerEvent("linea_abajo")
end on

event ue_f5;call super::ue_f5;cb_1.TriggerEvent(Clicked!)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_albaranes_agente
integer taborder = 50
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_albaranes_agente
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_albaranes_agente
integer x = 5
integer y = 4
integer width = 2427
integer height = 96
end type

type gb_1 from groupbox within w_con_albaranes_agente
integer x = 9
integer y = 80
integer width = 1682
integer height = 244
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type pb_1 from upb_salir within w_con_albaranes_agente
integer x = 2702
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type pb_2 from upb_imprimir within w_con_albaranes_agente
integer x = 2702
integer y = 220
integer taborder = 0
string picturename = "print!"
end type

event clicked;call super::clicked;Parent.triggerEvent("ue_listar")

end event

type dw_detalle from datawindow within w_con_albaranes_agente
integer x = 5
integer y = 332
integer width = 2830
integer height = 1092
string dataobject = "dw_con_albaranes_agente"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;str_parametros lstr_param
IF Row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"albaran"))
  OpenWithParm(w_int_venalb,lstr_param) 
End If
  
end event

type dw_listado from datawindow within w_con_albaranes_agente
boolean visible = false
integer x = 507
integer width = 160
integer height = 96
integer taborder = 60
boolean bringtotop = true
string dataobject = "report_con_albaranes_agente"
boolean livescroll = true
end type

type uo_manejo from u_manejo_datawindow within w_con_albaranes_agente
integer x = 2226
integer y = 176
integer width = 649
integer height = 144
end type

event valores;call super::valores;dw_data       = dw_detalle
dw_data.SetTransObject(SQLCA)
f_activar_campo(uo_agente.em_campo)
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type em_desde from u_em_campo within w_con_albaranes_agente
integer x = 425
integer y = 224
integer width = 288
integer height = 80
integer taborder = 20
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_4 from statictext within w_con_albaranes_agente
integer x = 745
integer y = 224
integer width = 183
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
string text = "hasta"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_hasta from u_em_campo within w_con_albaranes_agente
integer x = 965
integer y = 224
integer width = 288
integer taborder = 30
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type cb_1 from commandbutton within w_con_albaranes_agente
event clicked pbm_bnclicked
integer x = 1289
integer y = 224
integer width = 379
integer height = 80
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "F5 Continuar"
end type

event clicked;f_control()
end event

type uo_agente from u_em_campo_2 within w_con_albaranes_agente
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 279
integer y = 124
integer width = 1390
integer taborder = 10
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_agente.em_campo.text=f_nombre_venagentes(codigo_empresa,uo_agente.em_codigo.text)
If Trim(uo_agente.em_campo.text)="" or IsNull(uo_agente.em_campo.text) then
	uo_agente.em_campo.text=""
	uo_agente.em_codigo.text=""
	Return 
end if 

end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Representantes"
ue_datawindow ="dw_ayuda_venagentes"
ue_filtro = ""
valor_empresa = TRUE
end event

on uo_agente.destroy
call u_em_campo_2::destroy
end on

type st_2 from statictext within w_con_albaranes_agente
integer x = 18
integer y = 124
integer width = 238
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
string text = "Agente"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within w_con_albaranes_agente
integer x = 23
integer y = 224
integer width = 370
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
string text = "Desde fecha"
alignment alignment = right!
boolean focusrectangle = false
end type

