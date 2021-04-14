$PBExportHeader$w_con_pedidos_pendientes_de_fabricar.srw
forward
global type w_con_pedidos_pendientes_de_fabricar from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_pedidos_pendientes_de_fabricar
end type
type pb_2 from upb_imprimir within w_con_pedidos_pendientes_de_fabricar
end type
type dw_listado from datawindow within w_con_pedidos_pendientes_de_fabricar
end type
type cb_1 from commandbutton within w_con_pedidos_pendientes_de_fabricar
end type
type gb_2 from groupbox within w_con_pedidos_pendientes_de_fabricar
end type
type uo_cliente from u_em_campo_2 within w_con_pedidos_pendientes_de_fabricar
end type
type gb_3 from groupbox within w_con_pedidos_pendientes_de_fabricar
end type
type gb_6 from groupbox within w_con_pedidos_pendientes_de_fabricar
end type
type rb_detalle from radiobutton within w_con_pedidos_pendientes_de_fabricar
end type
type rb_resumen from radiobutton within w_con_pedidos_pendientes_de_fabricar
end type
type dw_listado_resumen from datawindow within w_con_pedidos_pendientes_de_fabricar
end type
type rb_pm from radiobutton within w_con_pedidos_pendientes_de_fabricar
end type
type dw_listado_resumen_pm from datawindow within w_con_pedidos_pendientes_de_fabricar
end type
type uo_series from u_marca_lista within w_con_pedidos_pendientes_de_fabricar
end type
type uo_familia from u_em_campo_2 within w_con_pedidos_pendientes_de_fabricar
end type
type gb_5 from groupbox within w_con_pedidos_pendientes_de_fabricar
end type
type gb_4 from groupbox within w_con_pedidos_pendientes_de_fabricar
end type
type em_faltadesde from u_em_campo within w_con_pedidos_pendientes_de_fabricar
end type
type st_2 from statictext within w_con_pedidos_pendientes_de_fabricar
end type
type em_faltahasta from u_em_campo within w_con_pedidos_pendientes_de_fabricar
end type
type dw_resumen from datawindow within w_con_pedidos_pendientes_de_fabricar
end type
type dw_resumen_g2 from datawindow within w_con_pedidos_pendientes_de_fabricar
end type
type dw_detalle from datawindow within w_con_pedidos_pendientes_de_fabricar
end type
end forward

global type w_con_pedidos_pendientes_de_fabricar from w_int_con_empresa
integer x = 46
integer y = 32
integer width = 4462
integer height = 3320
pb_1 pb_1
pb_2 pb_2
dw_listado dw_listado
cb_1 cb_1
gb_2 gb_2
uo_cliente uo_cliente
gb_3 gb_3
gb_6 gb_6
rb_detalle rb_detalle
rb_resumen rb_resumen
dw_listado_resumen dw_listado_resumen
rb_pm rb_pm
dw_listado_resumen_pm dw_listado_resumen_pm
uo_series uo_series
uo_familia uo_familia
gb_5 gb_5
gb_4 gb_4
em_faltadesde em_faltadesde
st_2 st_2
em_faltahasta em_faltahasta
dw_resumen dw_resumen
dw_resumen_g2 dw_resumen_g2
dw_detalle dw_detalle
end type
global w_con_pedidos_pendientes_de_fabricar w_con_pedidos_pendientes_de_fabricar

type variables

end variables

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);string cliente, familia



dw_detalle.Reset()

if uo_cliente.em_codigo.text = '' or isnull (uo_cliente.em_codigo.text) then
	cliente = "%"
else
	cliente = uo_cliente.em_codigo.text
end if

if uo_familia.em_codigo.text = '' or isnull (uo_familia.em_codigo.text) then
	familia = "%"
else
	familia = uo_familia.em_codigo.text
end if


dw_detalle.retrieve (codigo_empresa, cliente, familia)
end subroutine

event close;call super::close;dw_detalle.reset()
dw_listado.reset()
dw_listado_resumen.reset()
end event

event open;call super::open;istr_parametros.s_titulo_ventana = "Pedidos Pendientes de Fabricar"
This.title=istr_parametros.s_titulo_ventana
dw_detalle.SetTransObject (SQLCA)

//em_fechadesde.text = String(MDY(01,01,Year(Today())))
//em_fechahasta.text = String(Today())
//em_faltadesde.text = String(MDY(01,01,2001))
//em_faltahasta.text = String(Today())
//uo_series.f_cargar_datos("dw_ayuda_venseries","","","Serie","Descripción")
//dw_detalle.DataObject = "dw_con_ped_alb_fac_cliente_fechas_tencer"
end event

on w_con_pedidos_pendientes_de_fabricar.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.dw_listado=create dw_listado
this.cb_1=create cb_1
this.gb_2=create gb_2
this.uo_cliente=create uo_cliente
this.gb_3=create gb_3
this.gb_6=create gb_6
this.rb_detalle=create rb_detalle
this.rb_resumen=create rb_resumen
this.dw_listado_resumen=create dw_listado_resumen
this.rb_pm=create rb_pm
this.dw_listado_resumen_pm=create dw_listado_resumen_pm
this.uo_series=create uo_series
this.uo_familia=create uo_familia
this.gb_5=create gb_5
this.gb_4=create gb_4
this.em_faltadesde=create em_faltadesde
this.st_2=create st_2
this.em_faltahasta=create em_faltahasta
this.dw_resumen=create dw_resumen
this.dw_resumen_g2=create dw_resumen_g2
this.dw_detalle=create dw_detalle
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.gb_2
this.Control[iCurrent+6]=this.uo_cliente
this.Control[iCurrent+7]=this.gb_3
this.Control[iCurrent+8]=this.gb_6
this.Control[iCurrent+9]=this.rb_detalle
this.Control[iCurrent+10]=this.rb_resumen
this.Control[iCurrent+11]=this.dw_listado_resumen
this.Control[iCurrent+12]=this.rb_pm
this.Control[iCurrent+13]=this.dw_listado_resumen_pm
this.Control[iCurrent+14]=this.uo_series
this.Control[iCurrent+15]=this.uo_familia
this.Control[iCurrent+16]=this.gb_5
this.Control[iCurrent+17]=this.gb_4
this.Control[iCurrent+18]=this.em_faltadesde
this.Control[iCurrent+19]=this.st_2
this.Control[iCurrent+20]=this.em_faltahasta
this.Control[iCurrent+21]=this.dw_resumen
this.Control[iCurrent+22]=this.dw_resumen_g2
this.Control[iCurrent+23]=this.dw_detalle
end on

on w_con_pedidos_pendientes_de_fabricar.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.dw_listado)
destroy(this.cb_1)
destroy(this.gb_2)
destroy(this.uo_cliente)
destroy(this.gb_3)
destroy(this.gb_6)
destroy(this.rb_detalle)
destroy(this.rb_resumen)
destroy(this.dw_listado_resumen)
destroy(this.rb_pm)
destroy(this.dw_listado_resumen_pm)
destroy(this.uo_series)
destroy(this.uo_familia)
destroy(this.gb_5)
destroy(this.gb_4)
destroy(this.em_faltadesde)
destroy(this.st_2)
destroy(this.em_faltahasta)
destroy(this.dw_resumen)
destroy(this.dw_resumen_g2)
destroy(this.dw_detalle)
end on

event ue_f5;f_control(dw_detalle)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_pedidos_pendientes_de_fabricar
integer y = 612
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_pedidos_pendientes_de_fabricar
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_pedidos_pendientes_de_fabricar
integer y = 8
integer width = 4201
integer height = 88
boolean italic = true
end type

type pb_1 from upb_salir within w_con_pedidos_pendientes_de_fabricar
integer x = 4261
integer width = 119
integer height = 100
integer taborder = 0
end type

type pb_2 from upb_imprimir within w_con_pedidos_pendientes_de_fabricar
integer x = 4238
integer y = 140
integer width = 128
integer height = 104
integer taborder = 0
boolean originalsize = false
end type

event clicked;//if rb_pm.checked then
//	f_control_pm(dw_detalle)
//else
//	f_control(dw_detalle)
//end if
if rb_detalle.checked then
	f_imprimir_datawindow(dw_detalle)
end if

if rb_resumen.checked then
	f_imprimir_datawindow(dw_resumen)
end if


end event

type dw_listado from datawindow within w_con_pedidos_pendientes_de_fabricar
boolean visible = false
integer x = 2523
integer y = 12
integer width = 160
integer height = 96
boolean bringtotop = true
string dataobject = "report_con_ped_alb_fac_cliente_fechas3"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_con_pedidos_pendientes_de_fabricar
integer x = 3941
integer y = 140
integer width = 288
integer height = 104
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Continuar"
end type

event clicked;	
	f_control(dw_detalle)

/*
if rb_pm.checked then
	f_control_pm(dw_detalle)
else
	f_control(dw_detalle)
end if
*/
end event

type gb_2 from groupbox within w_con_pedidos_pendientes_de_fabricar
integer x = 3191
integer y = 100
integer width = 731
integer height = 160
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type uo_cliente from u_em_campo_2 within w_con_pedidos_pendientes_de_fabricar
event destroy ( )
integer x = 37
integer y = 152
integer width = 1957
integer height = 80
integer taborder = 50
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

type gb_3 from groupbox within w_con_pedidos_pendientes_de_fabricar
integer x = 14
integer y = 100
integer width = 1993
integer height = 160
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cliente"
end type

type gb_6 from groupbox within w_con_pedidos_pendientes_de_fabricar
integer x = 3922
integer y = 104
integer width = 462
integer height = 156
integer taborder = 100
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type rb_detalle from radiobutton within w_con_pedidos_pendientes_de_fabricar
integer x = 3227
integer y = 168
integer width = 251
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Detalle"
boolean checked = true
end type

event clicked;if rb_detalle.checked = true then
	rb_resumen.checked = false
	rb_pm.checked = false
	dw_detalle.visible = True
	dw_resumen.visible = false
end if

end event

type rb_resumen from radiobutton within w_con_pedidos_pendientes_de_fabricar
integer x = 3529
integer y = 164
integer width = 315
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Resumen"
end type

event clicked;if rb_resumen.checked = true then
	rb_detalle.checked = false
	rb_pm.checked = false
	dw_detalle.visible = false
	dw_resumen.visible = true
end if

end event

type dw_listado_resumen from datawindow within w_con_pedidos_pendientes_de_fabricar
boolean visible = false
integer x = 2711
integer y = 12
integer width = 160
integer height = 96
boolean bringtotop = true
string dataobject = "report_con_ped_alb_fac_cliente_fechas3_r"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type rb_pm from radiobutton within w_con_pedidos_pendientes_de_fabricar
boolean visible = false
integer x = 1129
integer y = 288
integer width = 421
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Precio medio"
end type

event clicked;if rb_pm.checked = true then
	rb_detalle.checked = false
	rb_resumen.checked = false
	dw_detalle.DataObject = "report_con_ped_alb_fac_cliente_fechas3pm"
end if
end event

type dw_listado_resumen_pm from datawindow within w_con_pedidos_pendientes_de_fabricar
boolean visible = false
integer x = 2898
integer y = 12
integer width = 160
integer height = 96
integer taborder = 60
boolean bringtotop = true
string dataobject = "report_con_ped_alb_fac_cliente_fechas3pm"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_series from u_marca_lista within w_con_pedidos_pendientes_de_fabricar
event destroy ( )
boolean visible = false
integer x = 1211
integer y = 264
boolean border = false
end type

on uo_series.destroy
call u_marca_lista::destroy
end on

type uo_familia from u_em_campo_2 within w_con_pedidos_pendientes_de_fabricar
event destroy ( )
integer x = 2030
integer y = 152
integer width = 1051
integer height = 80
integer taborder = 50
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_familia.destroy
call u_em_campo_2::destroy
end on

event modificado;string familia

select descripcion
into :familia
from familias
where empresa = :codigo_empresa
and codigo = :uo_familia.em_codigo.text;

uo_familia.em_campo.text= familia
IF Trim(uo_familia.em_campo.text)="" THEN 
	IF Trim(uo_familia.em_codigo.text)<>"" Then uo_familia.em_campo.SetFocus()
	uo_familia.em_campo.text=""
	uo_familia.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Familias"
ue_datawindow = "dw_ayuda_familias"
ue_filtro     = ""

end event

type gb_5 from groupbox within w_con_pedidos_pendientes_de_fabricar
integer x = 2007
integer y = 100
integer width = 1184
integer height = 160
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Familia"
end type

type gb_4 from groupbox within w_con_pedidos_pendientes_de_fabricar
boolean visible = false
integer x = 603
integer y = 100
integer width = 594
integer height = 156
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha de Alta"
end type

type em_faltadesde from u_em_campo within w_con_pedidos_pendientes_de_fabricar
boolean visible = false
integer x = 622
integer y = 152
integer height = 76
integer taborder = 30
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 33551858
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_2 from statictext within w_con_pedidos_pendientes_de_fabricar
boolean visible = false
integer x = 869
integer y = 144
integer width = 46
integer height = 64
integer textsize = -15
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "-"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_faltahasta from u_em_campo within w_con_pedidos_pendientes_de_fabricar
boolean visible = false
integer x = 923
integer y = 152
integer height = 76
integer taborder = 40
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 33551858
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type dw_resumen from datawindow within w_con_pedidos_pendientes_de_fabricar
boolean visible = false
integer x = 23
integer y = 412
integer width = 4366
integer height = 2072
integer taborder = 70
string dataobject = "dw_resumen_pedidos_meses_anyos"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

type dw_resumen_g2 from datawindow within w_con_pedidos_pendientes_de_fabricar
boolean visible = false
integer x = 14
integer y = 416
integer width = 4366
integer height = 2072
integer taborder = 80
string dataobject = "dw_resumen_pedidos_meses_anyos_g2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

type dw_detalle from datawindow within w_con_pedidos_pendientes_de_fabricar
integer x = 18
integer y = 276
integer width = 4366
integer height = 2852
integer taborder = 80
string dataobject = "dw_con_pedidos_pendientes_de_fabricar"
boolean vscrollbar = true
boolean border = false
end type

event clicked;string orden

choose case dwo.name
	case "t_articulo"
		orden = " articulos_descripcion asc"
		
	case "t_importe"
		orden = " importe desc"

	case "t_cantidad"
		orden = " cantidad_calc desc"

	case "t_cliente"
		orden = " genter_razon asc"
	
end choose

	dw_detalle.SetSort(orden)
	dw_detalle.Sort()
end event

