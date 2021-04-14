$PBExportHeader$w_con_pedidos_entrefechas.srw
forward
global type w_con_pedidos_entrefechas from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_pedidos_entrefechas
end type
type pb_2 from upb_imprimir within w_con_pedidos_entrefechas
end type
type dw_detalle from datawindow within w_con_pedidos_entrefechas
end type
type dw_listado from datawindow within w_con_pedidos_entrefechas
end type
type uo_manejo from u_manejo_datawindow within w_con_pedidos_entrefechas
end type
type st_9 from statictext within w_con_pedidos_entrefechas
end type
type em_fechadesde from u_em_campo within w_con_pedidos_entrefechas
end type
type st_8 from statictext within w_con_pedidos_entrefechas
end type
type em_fechahasta from u_em_campo within w_con_pedidos_entrefechas
end type
type cb_1 from commandbutton within w_con_pedidos_entrefechas
end type
type uo_1 from u_em_campo_2 within w_con_pedidos_entrefechas
end type
type gb_1 from groupbox within w_con_pedidos_entrefechas
end type
type st_1 from statictext within w_con_pedidos_entrefechas
end type
type uo_serie from u_em_campo_2 within w_con_pedidos_entrefechas
end type
type gb_5 from groupbox within w_con_pedidos_entrefechas
end type
end forward

global type w_con_pedidos_entrefechas from w_int_con_empresa
integer width = 2894
integer height = 2068
pb_1 pb_1
pb_2 pb_2
dw_detalle dw_detalle
dw_listado dw_listado
uo_manejo uo_manejo
st_9 st_9
em_fechadesde em_fechadesde
st_8 st_8
em_fechahasta em_fechahasta
cb_1 cb_1
uo_1 uo_1
gb_1 gb_1
st_1 st_1
uo_serie uo_serie
gb_5 gb_5
end type
global w_con_pedidos_entrefechas w_con_pedidos_entrefechas

type variables
string filtro
end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();dw_detalle.Reset()
Datetime fecha1,fecha2
String serie1,serie2,var_formato
fecha1=Datetime(Date(String(em_fechadesde.Text)))
fecha2=Datetime(Date(String(em_fechahasta.Text)))

if uo_serie.em_codigo.text='' then
	serie1='1'
	serie2='9'
else
	serie1=uo_serie.em_codigo.text
	serie2=uo_serie.em_codigo.text
end if

if uo_1.em_codigo.text <> "" then
	var_formato = uo_1.em_codigo.text
else
	var_formato = "%"
end if

dw_detalle.Retrieve(codigo_empresa,fecha1,fecha2,serie1,serie2,var_formato)

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

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta lineas de pedido entre fechas"
This.title=istr_parametros.s_titulo_ventana
em_fechadesde.text = String(MDY(01,01,Year(Today())))
em_fechahasta.text = String(Today())
dw_detalle.SetTransObject(SQLCA)

end event

event ue_listar;dw_report  = dw_listado
dw_report.SetTransObject(SQLCA)
Datetime fecha1,fecha2
String serie1,serie2,var_formato
fecha1=Datetime(Date(String(em_fechadesde.Text)))
fecha2=Datetime(Date(String(em_fechahasta.Text)))

if uo_serie.em_codigo.text='' then
	serie1='1'
	serie2='9'
else
	serie1=uo_serie.em_codigo.text
	serie2=uo_serie.em_codigo.text
end if

if uo_1.em_codigo.text <> "" then
	var_formato = uo_1.em_codigo.text
else
	var_formato = "%"
end if
dw_report.Retrieve(codigo_empresa,fecha1,fecha2,serie1,serie2,var_formato)

IF TRIM(filtro)<>"" THEN
 dw_report.SetFilter(filtro)
 dw_report.Filter()
END IF
CALL Super::ue_listar
end event

on w_con_pedidos_entrefechas.create
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
this.cb_1=create cb_1
this.uo_1=create uo_1
this.gb_1=create gb_1
this.st_1=create st_1
this.uo_serie=create uo_serie
this.gb_5=create gb_5
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
this.Control[iCurrent+10]=this.cb_1
this.Control[iCurrent+11]=this.uo_1
this.Control[iCurrent+12]=this.gb_1
this.Control[iCurrent+13]=this.st_1
this.Control[iCurrent+14]=this.uo_serie
this.Control[iCurrent+15]=this.gb_5
end on

on w_con_pedidos_entrefechas.destroy
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
destroy(this.cb_1)
destroy(this.uo_1)
destroy(this.gb_1)
destroy(this.st_1)
destroy(this.uo_serie)
destroy(this.gb_5)
end on

on ue_cursor_abajo;call w_int_con_empresa::ue_cursor_abajo;uo_manejo.TriggerEvent("linea_abajo")
end on

event ue_f5;call super::ue_f5;f_control()
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_pedidos_entrefechas
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_pedidos_entrefechas
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_pedidos_entrefechas
integer x = 9
integer y = 8
integer width = 2427
integer height = 112
end type

type pb_1 from upb_salir within w_con_pedidos_entrefechas
integer x = 2715
integer y = 8
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type pb_2 from upb_imprimir within w_con_pedidos_entrefechas
integer x = 2711
integer y = 176
integer taborder = 0
string picturename = "print!"
end type

event clicked;call super::clicked;Parent.triggerEvent("ue_listar")

end event

type dw_detalle from datawindow within w_con_pedidos_entrefechas
integer x = 5
integer y = 296
integer width = 2834
integer height = 1536
string dataobject = "dw_con_pedidos_entrefechas"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;str_parametros lstr_param
IF Row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"pedido"))
  OpenWithParm(w_int_venped,lstr_param) 
End If
end event

type dw_listado from datawindow within w_con_pedidos_entrefechas
boolean visible = false
integer x = 507
integer width = 160
integer height = 96
integer taborder = 70
boolean bringtotop = true
string dataobject = "report_con_pedidos_entrefechas_formato"
boolean livescroll = true
end type

type uo_manejo from u_manejo_datawindow within w_con_pedidos_entrefechas
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

type st_9 from statictext within w_con_pedidos_entrefechas
integer x = 23
integer y = 168
integer width = 210
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Desde"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_fechadesde from u_em_campo within w_con_pedidos_entrefechas
integer x = 238
integer y = 168
integer width = 288
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 33551858
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_8 from statictext within w_con_pedidos_entrefechas
integer x = 526
integer y = 168
integer width = 201
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Hasta"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_fechahasta from u_em_campo within w_con_pedidos_entrefechas
integer x = 727
integer y = 168
integer width = 288
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 33551858
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type cb_1 from commandbutton within w_con_pedidos_entrefechas
integer x = 1422
integer y = 212
integer width = 361
integer height = 72
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

type uo_1 from u_em_campo_2 within w_con_pedidos_entrefechas
integer x = 1248
integer y = 140
integer width = 535
integer height = 68
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;uo_1.em_campo.text=f_nombre_formato(codigo_empresa,uo_1.em_codigo.text)
If Trim(uo_1.em_campo.text)="" then
	uo_1.em_campo.text=""
	uo_1.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Formatos"
ue_datawindow ="dw_ayuda_formatos"
ue_filtro = ""
end event

on uo_1.destroy
call u_em_campo_2::destroy
end on

type gb_1 from groupbox within w_con_pedidos_entrefechas
integer x = 9
integer y = 108
integer width = 1029
integer height = 168
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type st_1 from statictext within w_con_pedidos_entrefechas
integer x = 1042
integer y = 136
integer width = 197
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Form. :"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_serie from u_em_campo_2 within w_con_pedidos_entrefechas
event destroy ( )
integer x = 1815
integer y = 176
integer width = 402
integer taborder = 50
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_serie.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_serie.em_campo.text=f_nombre_venseries(codigo_empresa,uo_serie.em_codigo.text)

If Trim(uo_serie.em_campo.text)="" then
	uo_serie.em_campo.text=""
	uo_serie.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;
	ue_titulo = "Selección de Series"
	ue_datawindow ="dw_ayuda_venseries"
	ue_filtro = ""

end event

type gb_5 from groupbox within w_con_pedidos_entrefechas
integer x = 1792
integer y = 116
integer width = 448
integer height = 164
integer taborder = 80
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Serie"
end type

