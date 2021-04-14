$PBExportHeader$w_con_albaranes_entrefechas.srw
forward
global type w_con_albaranes_entrefechas from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_albaranes_entrefechas
end type
type pb_2 from upb_imprimir within w_con_albaranes_entrefechas
end type
type dw_detalle from datawindow within w_con_albaranes_entrefechas
end type
type dw_listado from datawindow within w_con_albaranes_entrefechas
end type
type uo_manejo from u_manejo_datawindow within w_con_albaranes_entrefechas
end type
type st_9 from statictext within w_con_albaranes_entrefechas
end type
type em_fechadesde from u_em_campo within w_con_albaranes_entrefechas
end type
type st_8 from statictext within w_con_albaranes_entrefechas
end type
type em_fechahasta from u_em_campo within w_con_albaranes_entrefechas
end type
type gb_1 from groupbox within w_con_albaranes_entrefechas
end type
type cb_1 from commandbutton within w_con_albaranes_entrefechas
end type
type uo_serie from u_em_campo_2 within w_con_albaranes_entrefechas
end type
type uo_cliente from u_em_campo_2 within w_con_albaranes_entrefechas
end type
type gb_4 from groupbox within w_con_albaranes_entrefechas
end type
type gb_2 from groupbox within w_con_albaranes_entrefechas
end type
end forward

global type w_con_albaranes_entrefechas from w_int_con_empresa
integer x = 14
integer y = 16
integer width = 3378
integer height = 2220
pb_1 pb_1
pb_2 pb_2
dw_detalle dw_detalle
dw_listado dw_listado
uo_manejo uo_manejo
st_9 st_9
em_fechadesde em_fechadesde
st_8 st_8
em_fechahasta em_fechahasta
gb_1 gb_1
cb_1 cb_1
uo_serie uo_serie
uo_cliente uo_cliente
gb_4 gb_4
gb_2 gb_2
end type
global w_con_albaranes_entrefechas w_con_albaranes_entrefechas

type variables
string filtro
end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();dw_detalle.Reset()
Datetime fecha1,fecha2

String serie1,serie2, cliente

if Trim(uo_serie.em_codigo.text) <> "" then 
	serie1 = uo_serie.em_codigo.text
	serie2 = uo_serie.em_codigo.text
else
	serie1 = "."
	serie2 = "Z"
end if


fecha1=Datetime(Date(String(em_fechadesde.Text)))
fecha2=Datetime(Date(String(em_fechahasta.Text)))

if uo_cliente.em_codigo.text = '' or isnull(uo_cliente.em_codigo.text) then
	cliente = '%'
else 
	cliente = uo_cliente.em_codigo.text
end if

dw_detalle.Retrieve(codigo_empresa,fecha1,fecha2,serie1,serie2, cliente)

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

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta lineas de albarán entre fechas"
This.title=istr_parametros.s_titulo_ventana
em_fechadesde.text = String(MDY(01,01,Year(Today())))
em_fechahasta.text = String(Today())
dw_detalle.SetTransObject(SQLCA)

end event

event ue_listar;dw_report  = dw_listado
dw_report.SetTransObject(SQLCA)
Datetime fecha1,fecha2

String serie1,serie2

if Trim(uo_serie.em_codigo.text) <> "" then 
	serie1 = uo_serie.em_codigo.text
	serie2 = uo_serie.em_codigo.text
else
	serie1 = "."
	serie2 = "Z"
end if


fecha1=Datetime(Date(String(em_fechadesde.Text)))
fecha2=Datetime(Date(String(em_fechahasta.Text)))

dw_report.Retrieve(codigo_empresa,fecha1,fecha2,serie1,serie2)

IF TRIM(filtro)<>"" THEN
 dw_report.SetFilter(filtro)
 dw_report.Filter()
END IF
CALL Super::ue_listar
end event

on w_con_albaranes_entrefechas.create
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
this.gb_1=create gb_1
this.cb_1=create cb_1
this.uo_serie=create uo_serie
this.uo_cliente=create uo_cliente
this.gb_4=create gb_4
this.gb_2=create gb_2
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
this.Control[iCurrent+10]=this.gb_1
this.Control[iCurrent+11]=this.cb_1
this.Control[iCurrent+12]=this.uo_serie
this.Control[iCurrent+13]=this.uo_cliente
this.Control[iCurrent+14]=this.gb_4
this.Control[iCurrent+15]=this.gb_2
end on

on w_con_albaranes_entrefechas.destroy
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
destroy(this.gb_1)
destroy(this.cb_1)
destroy(this.uo_serie)
destroy(this.uo_cliente)
destroy(this.gb_4)
destroy(this.gb_2)
end on

on ue_cursor_abajo;call w_int_con_empresa::ue_cursor_abajo;uo_manejo.TriggerEvent("linea_abajo")
end on

event ue_f5;call super::ue_f5;f_control()
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_albaranes_entrefechas
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_albaranes_entrefechas
integer y = 4
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_albaranes_entrefechas
integer x = 14
integer y = 8
integer height = 88
integer textsize = -12
end type

type pb_1 from upb_salir within w_con_albaranes_entrefechas
integer x = 3154
integer y = 8
integer width = 119
integer height = 100
integer taborder = 0
end type

type pb_2 from upb_imprimir within w_con_albaranes_entrefechas
integer x = 3154
integer y = 156
integer width = 105
integer height = 84
integer taborder = 0
boolean originalsize = false
end type

event clicked;call super::clicked;Parent.triggerEvent("ue_listar")

end event

type dw_detalle from datawindow within w_con_albaranes_entrefechas
integer x = 5
integer y = 288
integer width = 3287
integer height = 1676
string dataobject = "dw_con_albaranes_entrefechas"
boolean vscrollbar = true
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

type dw_listado from datawindow within w_con_albaranes_entrefechas
boolean visible = false
integer x = 507
integer width = 160
integer height = 96
boolean bringtotop = true
string dataobject = "report_con_albaranes_entrefechas"
boolean livescroll = true
end type

type uo_manejo from u_manejo_datawindow within w_con_albaranes_entrefechas
integer x = 2683
integer y = 108
integer width = 649
integer height = 144
end type

event valores;call super::valores;dw_data       = dw_detalle
dw_data.SetTransObject(SQLCA)

end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type st_9 from statictext within w_con_albaranes_entrefechas
integer x = 18
integer y = 156
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

type em_fechadesde from u_em_campo within w_con_albaranes_entrefechas
integer x = 233
integer y = 156
integer width = 283
integer taborder = 10
boolean bringtotop = true
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_8 from statictext within w_con_albaranes_entrefechas
integer x = 535
integer y = 156
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

type em_fechahasta from u_em_campo within w_con_albaranes_entrefechas
integer x = 736
integer y = 156
integer width = 283
integer taborder = 20
boolean bringtotop = true
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type gb_1 from groupbox within w_con_albaranes_entrefechas
integer x = 5
integer y = 96
integer width = 1038
integer height = 168
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type cb_1 from commandbutton within w_con_albaranes_entrefechas
integer x = 2327
integer y = 136
integer width = 352
integer height = 116
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

type uo_serie from u_em_campo_2 within w_con_albaranes_entrefechas
event destroy ( )
integer x = 1070
integer y = 156
integer width = 453
integer taborder = 30
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

type uo_cliente from u_em_campo_2 within w_con_albaranes_entrefechas
event destroy ( )
integer x = 1568
integer y = 156
integer width = 709
integer taborder = 40
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)

If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;
	ue_titulo = "Selección de Clientes"
	ue_datawindow ="dw_ayuda_venclientes"
	ue_filtro = ""

end event

type gb_4 from groupbox within w_con_albaranes_entrefechas
integer x = 1051
integer y = 96
integer width = 489
integer height = 176
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Serie"
end type

type gb_2 from groupbox within w_con_albaranes_entrefechas
integer x = 1550
integer y = 96
integer width = 745
integer height = 176
integer taborder = 50
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cliente"
end type

