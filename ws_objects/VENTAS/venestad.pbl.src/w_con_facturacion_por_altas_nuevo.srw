$PBExportHeader$w_con_facturacion_por_altas_nuevo.srw
forward
global type w_con_facturacion_por_altas_nuevo from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_facturacion_por_altas_nuevo
end type
type pb_2 from upb_imprimir within w_con_facturacion_por_altas_nuevo
end type
type cb_1 from commandbutton within w_con_facturacion_por_altas_nuevo
end type
type gb_6 from groupbox within w_con_facturacion_por_altas_nuevo
end type
type dw_resumen from datawindow within w_con_facturacion_por_altas_nuevo
end type
type uo_cliente from u_em_campo_2 within w_con_facturacion_por_altas_nuevo
end type
type st_3 from statictext within w_con_facturacion_por_altas_nuevo
end type
type st_4 from statictext within w_con_facturacion_por_altas_nuevo
end type
type st_1 from statictext within w_con_facturacion_por_altas_nuevo
end type
type st_2 from statictext within w_con_facturacion_por_altas_nuevo
end type
type sle_desde from singlelineedit within w_con_facturacion_por_altas_nuevo
end type
type sle_hasta from singlelineedit within w_con_facturacion_por_altas_nuevo
end type
type uo_familia from u_em_campo_2 within w_con_facturacion_por_altas_nuevo
end type
type gb_4 from groupbox within w_con_facturacion_por_altas_nuevo
end type
type gb_1 from groupbox within w_con_facturacion_por_altas_nuevo
end type
type gb_8 from groupbox within w_con_facturacion_por_altas_nuevo
end type
end forward

global type w_con_facturacion_por_altas_nuevo from w_int_con_empresa
integer x = 46
integer y = 32
integer width = 5344
integer height = 3140
pb_1 pb_1
pb_2 pb_2
cb_1 cb_1
gb_6 gb_6
dw_resumen dw_resumen
uo_cliente uo_cliente
st_3 st_3
st_4 st_4
st_1 st_1
st_2 st_2
sle_desde sle_desde
sle_hasta sle_hasta
uo_familia uo_familia
gb_4 gb_4
gb_1 gb_1
gb_8 gb_8
end type
global w_con_facturacion_por_altas_nuevo w_con_facturacion_por_altas_nuevo

type variables

end variables

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);string v_cliente, codestadistico, t_cliente, familia
string g1, g2, g3, g4, pt, nc, rect, av, pl, ct, tm, n
integer desde, hasta


if uo_cliente.em_codigo.text = '' or isnull (uo_cliente.em_codigo.text) then
	v_cliente = '%'
	t_cliente = ""
else
	v_cliente = uo_cliente.em_codigo.text
	t_cliente = uo_cliente.em_campo.text
end if

if uo_familia.em_codigo.text = '' or isnull (uo_familia.em_codigo.text) then
	familia = '%'
else
	familia = uo_familia.em_codigo.text
end if

data.SetTransObject(SQLCA)
data.Reset()

desde = integer(sle_desde.text)
hasta = integer(sle_hasta.text)

data.Retrieve(codigo_empresa, v_cliente,  desde, hasta, familia)
data.object.t_cliente.text = t_cliente


dw_resumen.object.t_cliente.text = uo_cliente.em_campo.text



end subroutine

event close;call super::close;
//dw_detalle.reset()

end event

event open;call super::open;istr_parametros.s_titulo_ventana="Informe de Facturación por años y fecha de alta del artículo."
This.title=istr_parametros.s_titulo_ventana

sle_desde.text = '2001'

sle_hasta.text = string (year(today()))
end event

on w_con_facturacion_por_altas_nuevo.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.cb_1=create cb_1
this.gb_6=create gb_6
this.dw_resumen=create dw_resumen
this.uo_cliente=create uo_cliente
this.st_3=create st_3
this.st_4=create st_4
this.st_1=create st_1
this.st_2=create st_2
this.sle_desde=create sle_desde
this.sle_hasta=create sle_hasta
this.uo_familia=create uo_familia
this.gb_4=create gb_4
this.gb_1=create gb_1
this.gb_8=create gb_8
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.gb_6
this.Control[iCurrent+5]=this.dw_resumen
this.Control[iCurrent+6]=this.uo_cliente
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.st_4
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.sle_desde
this.Control[iCurrent+12]=this.sle_hasta
this.Control[iCurrent+13]=this.uo_familia
this.Control[iCurrent+14]=this.gb_4
this.Control[iCurrent+15]=this.gb_1
this.Control[iCurrent+16]=this.gb_8
end on

on w_con_facturacion_por_altas_nuevo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.cb_1)
destroy(this.gb_6)
destroy(this.dw_resumen)
destroy(this.uo_cliente)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.sle_desde)
destroy(this.sle_hasta)
destroy(this.uo_familia)
destroy(this.gb_4)
destroy(this.gb_1)
destroy(this.gb_8)
end on

event ue_f5;//f_control(dw_detalle)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_facturacion_por_altas_nuevo
integer y = 612
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_facturacion_por_altas_nuevo
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_facturacion_por_altas_nuevo
integer x = 14
integer y = 8
integer width = 5253
integer height = 80
end type

type pb_1 from upb_salir within w_con_facturacion_por_altas_nuevo
integer x = 5120
integer y = 148
integer width = 110
integer height = 96
integer taborder = 0
string text = "1"
end type

type pb_2 from upb_imprimir within w_con_facturacion_por_altas_nuevo
integer x = 4965
integer y = 148
integer taborder = 0
end type

event clicked;f_imprimir_datawindow(dw_resumen)

end event

type cb_1 from commandbutton within w_con_facturacion_por_altas_nuevo
integer x = 4667
integer y = 148
integer width = 288
integer height = 96
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Continuar"
end type

event clicked;	
	f_control(dw_resumen)
	

/*
if rb_pm.checked then
	f_control_pm(dw_detalle)
else
	f_control(dw_detalle)
end if
*/
end event

type gb_6 from groupbox within w_con_facturacion_por_altas_nuevo
integer x = 4649
integer y = 108
integer width = 439
integer height = 148
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type dw_resumen from datawindow within w_con_facturacion_por_altas_nuevo
integer x = 27
integer y = 284
integer width = 5243
integer height = 2508
string dataobject = "dw_con_facturacion_por_altas_nuevo"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

type uo_cliente from u_em_campo_2 within w_con_facturacion_por_altas_nuevo
event destroy ( )
integer x = 37
integer y = 144
integer width = 1573
integer height = 88
integer taborder = 10
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event modificado;string des_cliente

select razon
into :des_cliente
from genter
where empresa = :codigo_empresa
and codigo = :uo_cliente.em_codigo.text
and tipoter = 'C';

uo_cliente.em_campo.text = des_cliente

If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 


end event

event getfocus;ue_titulo = "Selección de Clientes"
ue_datawindow  = "dw_ayuda_clientes"
ue_filtro = ""
end event

type st_3 from statictext within w_con_facturacion_por_altas_nuevo
integer x = 46
integer y = 2812
integer width = 1349
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388736
long backcolor = 12632256
string text = "No incluye facturas ajenas a la activdad."
boolean focusrectangle = false
end type

type st_4 from statictext within w_con_facturacion_por_altas_nuevo
integer x = 46
integer y = 2860
integer width = 1275
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388736
long backcolor = 12632256
string text = "Incluye todos los dtos excepto rappel y dtopp."
boolean focusrectangle = false
end type

type st_1 from statictext within w_con_facturacion_por_altas_nuevo
integer x = 2437
integer y = 152
integer width = 247
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Desde:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_con_facturacion_por_altas_nuevo
integer x = 2921
integer y = 156
integer width = 247
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Hasta:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_desde from singlelineedit within w_con_facturacion_por_altas_nuevo
integer x = 2697
integer y = 148
integer width = 206
integer height = 76
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean border = false
end type

type sle_hasta from singlelineedit within w_con_facturacion_por_altas_nuevo
integer x = 3182
integer y = 148
integer width = 206
integer height = 76
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean border = false
end type

type uo_familia from u_em_campo_2 within w_con_facturacion_por_altas_nuevo
event destroy ( )
integer x = 1691
integer y = 140
integer width = 544
integer height = 96
integer taborder = 100
boolean bringtotop = true
boolean border = true
long backcolor = 134217750
borderstyle borderstyle = stylelowered!
end type

on uo_familia.destroy
call u_em_campo_2::destroy
end on

event modificado;string descripcion

select descripcion
into :descripcion
from familias
where empresa = :codigo_empresa
and codigo = :uo_familia.em_codigo.text;

uo_familia.em_campo.text= descripcion
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

type gb_4 from groupbox within w_con_facturacion_por_altas_nuevo
integer x = 9
integer y = 92
integer width = 1641
integer height = 168
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Cliente"
end type

type gb_1 from groupbox within w_con_facturacion_por_altas_nuevo
integer x = 5097
integer y = 108
integer width = 160
integer height = 148
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_8 from groupbox within w_con_facturacion_por_altas_nuevo
integer x = 1669
integer y = 92
integer width = 599
integer height = 172
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 553648127
string text = "Familia"
end type

