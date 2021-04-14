$PBExportHeader$w_con_pedidos_entrefechas_valorado.srw
forward
global type w_con_pedidos_entrefechas_valorado from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_pedidos_entrefechas_valorado
end type
type pb_2 from upb_imprimir within w_con_pedidos_entrefechas_valorado
end type
type dw_detalle from datawindow within w_con_pedidos_entrefechas_valorado
end type
type dw_listado from datawindow within w_con_pedidos_entrefechas_valorado
end type
type st_9 from statictext within w_con_pedidos_entrefechas_valorado
end type
type em_fechadesde from u_em_campo within w_con_pedidos_entrefechas_valorado
end type
type st_8 from statictext within w_con_pedidos_entrefechas_valorado
end type
type em_fechahasta from u_em_campo within w_con_pedidos_entrefechas_valorado
end type
type cb_1 from commandbutton within w_con_pedidos_entrefechas_valorado
end type
type gb_1 from groupbox within w_con_pedidos_entrefechas_valorado
end type
type uo_serie from u_em_campo_2 within w_con_pedidos_entrefechas_valorado
end type
type gb_5 from groupbox within w_con_pedidos_entrefechas_valorado
end type
type uo_cliente from u_em_campo_2 within w_con_pedidos_entrefechas_valorado
end type
type gb_3 from groupbox within w_con_pedidos_entrefechas_valorado
end type
type cb_detalle from commandbutton within w_con_pedidos_entrefechas_valorado
end type
end forward

global type w_con_pedidos_entrefechas_valorado from w_int_con_empresa
integer width = 2935
integer height = 2068
pb_1 pb_1
pb_2 pb_2
dw_detalle dw_detalle
dw_listado dw_listado
st_9 st_9
em_fechadesde em_fechadesde
st_8 st_8
em_fechahasta em_fechahasta
cb_1 cb_1
gb_1 gb_1
uo_serie uo_serie
gb_5 gb_5
uo_cliente uo_cliente
gb_3 gb_3
cb_detalle cb_detalle
end type
global w_con_pedidos_entrefechas_valorado w_con_pedidos_entrefechas_valorado

type variables
string filtro
end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();dw_detalle.Reset()
Datetime fecha1,fecha2
String serie1,serie2
fecha1=Datetime(Date(String(em_fechadesde.Text)))
fecha2=Datetime(Date(String(em_fechahasta.Text)))

if uo_serie.em_codigo.text='' then
	serie1='1'
	serie2='9'
else
	serie1=uo_serie.em_codigo.text
	serie2=uo_serie.em_codigo.text
end if

dw_detalle.Retrieve(codigo_empresa,fecha1,fecha2,serie1,serie2)

end subroutine

on close;call w_int_con_empresa::close;dw_detalle.reset()
dw_listado.reset()
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
String serie1,serie2
fecha1=Datetime(Date(String(em_fechadesde.Text)))
fecha2=Datetime(Date(String(em_fechahasta.Text)))

if uo_serie.em_codigo.text='' then
	serie1='1'
	serie2='9'
else
	serie1=uo_serie.em_codigo.text
	serie2=uo_serie.em_codigo.text
end if


dw_report.Retrieve(codigo_empresa,fecha1,fecha2,serie1,serie2)

IF TRIM(filtro)<>"" THEN
 dw_report.SetFilter(filtro)
 dw_report.Filter()
END IF
CALL Super::ue_listar
end event

on w_con_pedidos_entrefechas_valorado.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.dw_detalle=create dw_detalle
this.dw_listado=create dw_listado
this.st_9=create st_9
this.em_fechadesde=create em_fechadesde
this.st_8=create st_8
this.em_fechahasta=create em_fechahasta
this.cb_1=create cb_1
this.gb_1=create gb_1
this.uo_serie=create uo_serie
this.gb_5=create gb_5
this.uo_cliente=create uo_cliente
this.gb_3=create gb_3
this.cb_detalle=create cb_detalle
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.dw_detalle
this.Control[iCurrent+4]=this.dw_listado
this.Control[iCurrent+5]=this.st_9
this.Control[iCurrent+6]=this.em_fechadesde
this.Control[iCurrent+7]=this.st_8
this.Control[iCurrent+8]=this.em_fechahasta
this.Control[iCurrent+9]=this.cb_1
this.Control[iCurrent+10]=this.gb_1
this.Control[iCurrent+11]=this.uo_serie
this.Control[iCurrent+12]=this.gb_5
this.Control[iCurrent+13]=this.uo_cliente
this.Control[iCurrent+14]=this.gb_3
this.Control[iCurrent+15]=this.cb_detalle
end on

on w_con_pedidos_entrefechas_valorado.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.dw_detalle)
destroy(this.dw_listado)
destroy(this.st_9)
destroy(this.em_fechadesde)
destroy(this.st_8)
destroy(this.em_fechahasta)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.uo_serie)
destroy(this.gb_5)
destroy(this.uo_cliente)
destroy(this.gb_3)
destroy(this.cb_detalle)
end on

event ue_f5;call super::ue_f5;f_control()
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_pedidos_entrefechas_valorado
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_pedidos_entrefechas_valorado
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_pedidos_entrefechas_valorado
integer x = 9
integer y = 8
integer width = 2427
integer height = 112
end type

type pb_1 from upb_salir within w_con_pedidos_entrefechas_valorado
integer x = 2711
integer y = 8
integer width = 110
integer height = 96
integer taborder = 0
string picturename = "exit!"
end type

type pb_2 from upb_imprimir within w_con_pedidos_entrefechas_valorado
integer x = 2711
integer y = 180
integer taborder = 0
string picturename = "print!"
end type

event clicked;call super::clicked;//w_con_pedidos_entrefechas.triggerEvent("ue_listar")
PArent.triggerEvent("ue_listar")

end event

type dw_detalle from datawindow within w_con_pedidos_entrefechas_valorado
integer x = 5
integer y = 296
integer width = 2834
integer height = 1528
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

type dw_listado from datawindow within w_con_pedidos_entrefechas_valorado
boolean visible = false
integer x = 507
integer width = 160
integer height = 96
integer taborder = 70
boolean bringtotop = true
string dataobject = "report_con_pedidos_entrefechas_formato"
boolean livescroll = true
end type

type st_9 from statictext within w_con_pedidos_entrefechas_valorado
integer x = 23
integer y = 176
integer width = 197
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
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

type em_fechadesde from u_em_campo within w_con_pedidos_entrefechas_valorado
integer x = 219
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

type st_8 from statictext within w_con_pedidos_entrefechas_valorado
integer x = 512
integer y = 176
integer width = 187
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
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

type em_fechahasta from u_em_campo within w_con_pedidos_entrefechas_valorado
integer x = 686
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

type cb_1 from commandbutton within w_con_pedidos_entrefechas_valorado
integer x = 2299
integer y = 200
integer width = 361
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

type gb_1 from groupbox within w_con_pedidos_entrefechas_valorado
integer x = 9
integer y = 108
integer width = 987
integer height = 164
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type uo_serie from u_em_campo_2 within w_con_pedidos_entrefechas_valorado
event destroy ( )
integer x = 1861
integer y = 168
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

type gb_5 from groupbox within w_con_pedidos_entrefechas_valorado
integer x = 1838
integer y = 108
integer width = 448
integer height = 164
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Serie"
end type

type uo_cliente from u_em_campo_2 within w_con_pedidos_entrefechas_valorado
event destroy ( )
integer x = 1010
integer y = 168
integer width = 800
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)
If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 


end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Clientes"
ue_datawindow ="dw_ayuda_clientes"
ue_filtro = ""
end event

type gb_3 from groupbox within w_con_pedidos_entrefechas_valorado
integer x = 997
integer y = 108
integer width = 837
integer height = 164
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cliente"
end type

type cb_detalle from commandbutton within w_con_pedidos_entrefechas_valorado
integer x = 2299
integer y = 132
integer width = 361
integer height = 68
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Resumen"
end type

