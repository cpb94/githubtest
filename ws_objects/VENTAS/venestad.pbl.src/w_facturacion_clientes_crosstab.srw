$PBExportHeader$w_facturacion_clientes_crosstab.srw
forward
global type w_facturacion_clientes_crosstab from w_int_con_empresa
end type
type pb_2 from upb_imprimir within w_facturacion_clientes_crosstab
end type
type cb_1 from commandbutton within w_facturacion_clientes_crosstab
end type
type gb_1 from groupbox within w_facturacion_clientes_crosstab
end type
type gb_6 from groupbox within w_facturacion_clientes_crosstab
end type
type dw_informe from datawindow within w_facturacion_clientes_crosstab
end type
type sle_anyo from singlelineedit within w_facturacion_clientes_crosstab
end type
type uo_cliente from u_em_campo_2 within w_facturacion_clientes_crosstab
end type
type st_1 from statictext within w_facturacion_clientes_crosstab
end type
type st_2 from statictext within w_facturacion_clientes_crosstab
end type
type pb_1 from upb_salir within w_facturacion_clientes_crosstab
end type
type gb_4 from groupbox within w_facturacion_clientes_crosstab
end type
end forward

global type w_facturacion_clientes_crosstab from w_int_con_empresa
integer width = 5143
integer height = 3164
pb_2 pb_2
cb_1 cb_1
gb_1 gb_1
gb_6 gb_6
dw_informe dw_informe
sle_anyo sle_anyo
uo_cliente uo_cliente
st_1 st_1
st_2 st_2
pb_1 pb_1
gb_4 gb_4
end type
global w_facturacion_clientes_crosstab w_facturacion_clientes_crosstab

type variables

end variables

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);Date  fecha1,fecha2
string mes, cliente, familia
long fila_actual
dec{2} v_t_metros_ventas, v_t_metros_rev

data.SetTransObject(SQLCA)
data.Reset()

data.setredraw(false)		
fila_actual = data.insertrow(0)
if uo_cliente.em_codigo.text = '' or isnull (uo_cliente.em_codigo.text) then
	cliente = '%'
else
	cliente = uo_cliente.em_codigo.text
end if


familia = '%'


data.object.titulo2.text = string (sle_anyo.text)
if long(sle_anyo.text) < long(year(today())) then
	data.retrieve(long(sle_anyo.text), 13, cliente, familia)
else
	data.retrieve(long(sle_anyo.text), month(today()) + 1, cliente, familia)
end if

data.sort()
data.groupcalc()
data.setredraw(true)
end subroutine

event close;call super::close;dw_informe.reset()

end event

event open;call super::open;string mes

istr_parametros.s_titulo_ventana="Cuadro de Ventas por Grupos y Precio Medio"
This.title=istr_parametros.s_titulo_ventana

//em_fdesde.text = "01-01-01"
//em_fhasta.text = string(today(),"dd-mm-yy")
sle_anyo.text = string(year(today()))


end event

on w_facturacion_clientes_crosstab.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.cb_1=create cb_1
this.gb_1=create gb_1
this.gb_6=create gb_6
this.dw_informe=create dw_informe
this.sle_anyo=create sle_anyo
this.uo_cliente=create uo_cliente
this.st_1=create st_1
this.st_2=create st_2
this.pb_1=create pb_1
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.gb_1
this.Control[iCurrent+4]=this.gb_6
this.Control[iCurrent+5]=this.dw_informe
this.Control[iCurrent+6]=this.sle_anyo
this.Control[iCurrent+7]=this.uo_cliente
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.pb_1
this.Control[iCurrent+11]=this.gb_4
end on

on w_facturacion_clientes_crosstab.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.gb_6)
destroy(this.dw_informe)
destroy(this.sle_anyo)
destroy(this.uo_cliente)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.pb_1)
destroy(this.gb_4)
end on

event ue_f5;f_control(dw_informe)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_facturacion_clientes_crosstab
integer y = 612
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_facturacion_clientes_crosstab
end type

type st_empresa from w_int_con_empresa`st_empresa within w_facturacion_clientes_crosstab
integer x = 27
integer y = 4
integer width = 5001
integer height = 92
end type

type pb_2 from upb_imprimir within w_facturacion_clientes_crosstab
integer x = 4882
integer y = 128
integer width = 128
integer height = 104
integer taborder = 0
boolean originalsize = false
end type

event clicked;f_control(dw_informe)
f_imprimir_datawindow(dw_informe)

end event

type cb_1 from commandbutton within w_facturacion_clientes_crosstab
integer x = 4585
integer y = 128
integer width = 288
integer height = 104
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Continuar"
end type

event clicked; f_control(dw_informe)

end event

type gb_1 from groupbox within w_facturacion_clientes_crosstab
integer x = 18
integer y = 108
integer width = 311
integer height = 160
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Año"
end type

type gb_6 from groupbox within w_facturacion_clientes_crosstab
integer x = 4567
integer y = 88
integer width = 462
integer height = 160
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type dw_informe from datawindow within w_facturacion_clientes_crosstab
integer x = 46
integer y = 280
integer width = 5015
integer height = 2652
boolean bringtotop = true
string dataobject = "dw_facturacion_clientes"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type sle_anyo from singlelineedit within w_facturacion_clientes_crosstab
integer x = 46
integer y = 164
integer width = 256
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type uo_cliente from u_em_campo_2 within w_facturacion_clientes_crosstab
event destroy ( )
integer x = 370
integer y = 168
integer width = 1344
integer height = 80
integer taborder = 40
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

type st_1 from statictext within w_facturacion_clientes_crosstab
integer x = 3026
integer y = 136
integer width = 1472
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 12632256
string text = "Tiene en cuenta Rappels (en dic.) y todos los dtos. excepto dtopp."
boolean focusrectangle = false
end type

type st_2 from statictext within w_facturacion_clientes_crosstab
integer x = 3031
integer y = 192
integer width = 1275
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 12632256
string text = "Incluye la facturación ajena a la actividad."
boolean focusrectangle = false
end type

type pb_1 from upb_salir within w_facturacion_clientes_crosstab
integer x = 4891
integer y = 4
integer width = 110
integer height = 96
integer taborder = 30
boolean bringtotop = true
boolean originalsize = true
string picturename = "exit!"
end type

type gb_4 from groupbox within w_facturacion_clientes_crosstab
integer x = 352
integer y = 116
integer width = 1381
integer height = 160
integer taborder = 40
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

