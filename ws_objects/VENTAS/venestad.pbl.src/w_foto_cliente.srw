$PBExportHeader$w_foto_cliente.srw
forward
global type w_foto_cliente from w_int_con_empresa
end type
type uo_cliente from u_em_campo_2 within w_foto_cliente
end type
type gb_3 from groupbox within w_foto_cliente
end type
type gb_2 from groupbox within w_foto_cliente
end type
type gb_1 from groupbox within w_foto_cliente
end type
type pb_1 from upb_salir within w_foto_cliente
end type
type tab_1 from tab within w_foto_cliente
end type
type pag_1 from userobject within tab_1
end type
type dw_1 from datawindow within pag_1
end type
type pag_1 from userobject within tab_1
dw_1 dw_1
end type
type pag_2 from userobject within tab_1
end type
type pb_2 from picturebutton within pag_2
end type
type dw_2 from datawindow within pag_2
end type
type pag_2 from userobject within tab_1
pb_2 pb_2
dw_2 dw_2
end type
type pag_3 from userobject within tab_1
end type
type pb_3 from picturebutton within pag_3
end type
type dw_3 from datawindow within pag_3
end type
type pag_3 from userobject within tab_1
pb_3 pb_3
dw_3 dw_3
end type
type pag_4 from userobject within tab_1
end type
type pb_4 from picturebutton within pag_4
end type
type dw_4 from datawindow within pag_4
end type
type pag_4 from userobject within tab_1
pb_4 pb_4
dw_4 dw_4
end type
type pag_5 from userobject within tab_1
end type
type pb_5 from picturebutton within pag_5
end type
type dw_5 from datawindow within pag_5
end type
type pag_5 from userobject within tab_1
pb_5 pb_5
dw_5 dw_5
end type
type pag_6 from userobject within tab_1
end type
type pb_6 from picturebutton within pag_6
end type
type dw_6 from datawindow within pag_6
end type
type pag_6 from userobject within tab_1
pb_6 pb_6
dw_6 dw_6
end type
type pag_7 from userobject within tab_1
end type
type pb_7 from picturebutton within pag_7
end type
type dw_7 from datawindow within pag_7
end type
type pag_7 from userobject within tab_1
pb_7 pb_7
dw_7 dw_7
end type
type pag_8 from userobject within tab_1
end type
type pb_8 from picturebutton within pag_8
end type
type dw_8 from datawindow within pag_8
end type
type pag_8 from userobject within tab_1
pb_8 pb_8
dw_8 dw_8
end type
type tab_1 from tab within w_foto_cliente
pag_1 pag_1
pag_2 pag_2
pag_3 pag_3
pag_4 pag_4
pag_5 pag_5
pag_6 pag_6
pag_7 pag_7
pag_8 pag_8
end type
type st_1 from statictext within w_foto_cliente
end type
type pb_9 from picturebutton within w_foto_cliente
end type
type dw_list from datawindow within w_foto_cliente
end type
type st_2 from statictext within w_foto_cliente
end type
type st_concedido from statictext within w_foto_cliente
end type
end forward

global type w_foto_cliente from w_int_con_empresa
integer x = 5
integer y = 248
integer width = 2935
integer height = 1620
string title = "Foto Cliente"
uo_cliente uo_cliente
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
pb_1 pb_1
tab_1 tab_1
st_1 st_1
pb_9 pb_9
dw_list dw_list
st_2 st_2
st_concedido st_concedido
end type
global w_foto_cliente w_foto_cliente

type variables
datawindow dw_res
datawindow dw_alb
datawindow dw_fac
datawindow dw_cobro
datawindow dw_negociado
datawindow dw_vencido
datawindow dw_devuelto
datawindow dw_gasto
string  moneda_cliente

end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();string cliente
cliente=uo_cliente.em_codigo.text
long donde

dec alb,fac,cobro,nego,devo,gasto
tipo_array vencido

alb=f_alb_pdtes_facturar(codigo_empresa,cliente)
if alb<>0 then
	donde=dw_res.insertrow(0)
	dw_res.setitem(donde,"empresa",codigo_empresa)
	dw_res.setitem(donde,"concepto","Albaranes Pendientes de Facturar")
	dw_res.setitem(donde,"cantidad",alb)
end if

fac=f_fac_pdtes_actualizar(codigo_empresa,cliente)
if fac<>0 then
	donde=dw_res.insertrow(0)
	dw_res.setitem(donde,"empresa",codigo_empresa)
	dw_res.setitem(donde,"concepto","Facturas Pendientes de Actualizar")
	dw_res.setitem(donde,"cantidad",fac)
end if

cobro=f_fac_pdtes_cobro(codigo_empresa,cliente)
if cobro<>0 then
	donde=dw_res.insertrow(0)
	dw_res.setitem(donde,"empresa",codigo_empresa)
	dw_res.setitem(donde,"concepto","Recibos Pendientes de Cobro")
	dw_res.setitem(donde,"cantidad",cobro)
end if

nego=f_negociado_pdtes_cobro(codigo_empresa,cliente)
if nego<>0 then
	donde=dw_res.insertrow(0)
	dw_res.setitem(donde,"empresa",codigo_empresa)
	dw_res.setitem(donde,"concepto","Negociado Pendiente de Cobro")
	dw_res.setitem(donde,"cantidad",nego)
end if

vencido=f_fac_vencidas(codigo_empresa,cliente)

if dec(vencido.valor[1])<>0 then
	donde=dw_res.insertrow(0)
	dw_res.setitem(donde,"empresa",codigo_empresa)
	dw_res.setitem(donde,"concepto","Recibos Vencidos entre 1 y 30 días")
	dw_res.setitem(donde,"cantidad",dec(vencido.valor[1]))
end if
if dec(vencido.valor[2])<>0 then
	donde=dw_res.insertrow(0)
	dw_res.setitem(donde,"empresa",codigo_empresa)
	dw_res.setitem(donde,"concepto","Recibos Vencidos entre 30 y 60 días")
	dw_res.setitem(donde,"cantidad",dec(vencido.valor[2]))
end if
if dec(vencido.valor[3])<>0 then
	donde=dw_res.insertrow(0)
	dw_res.setitem(donde,"empresa",codigo_empresa)
	dw_res.setitem(donde,"concepto","Recibos Vencidos entre 60 y 90 días")
	dw_res.setitem(donde,"cantidad",dec(vencido.valor[3]))
end if
if dec(vencido.valor[4])<>0 then
	donde=dw_res.insertrow(0)
	dw_res.setitem(donde,"empresa",codigo_empresa)
	dw_res.setitem(donde,"concepto","Recibos Vencidos mas de 90 días")
	dw_res.setitem(donde,"cantidad",dec(vencido.valor[4]))
end if

devo=f_fac_devuelto(codigo_empresa,cliente)
if devo<>0 then
	donde=dw_res.insertrow(0)
	dw_res.setitem(donde,"empresa",codigo_empresa)
	dw_res.setitem(donde,"concepto","Devoluciones")
	dw_res.setitem(donde,"cantidad",devo)
end if

gasto=f_fac_gasto(codigo_empresa,cliente)
if gasto<>0 then
	donde=dw_res.insertrow(0)
	dw_res.setitem(donde,"empresa",codigo_empresa)
	dw_res.setitem(donde,"concepto","Gastos")
	dw_res.setitem(donde,"cantidad",gasto)
end if
end subroutine

on w_foto_cliente.create
int iCurrent
call super::create
this.uo_cliente=create uo_cliente
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.pb_1=create pb_1
this.tab_1=create tab_1
this.st_1=create st_1
this.pb_9=create pb_9
this.dw_list=create dw_list
this.st_2=create st_2
this.st_concedido=create st_concedido
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_cliente
this.Control[iCurrent+2]=this.gb_3
this.Control[iCurrent+3]=this.gb_2
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.pb_1
this.Control[iCurrent+6]=this.tab_1
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.pb_9
this.Control[iCurrent+9]=this.dw_list
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.st_concedido
end on

on w_foto_cliente.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_cliente)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.pb_1)
destroy(this.tab_1)
destroy(this.st_1)
destroy(this.pb_9)
destroy(this.dw_list)
destroy(this.st_2)
destroy(this.st_concedido)
end on

event open;call super::open;

dw_res=tab_1.pag_1.dw_1
dw_alb=tab_1.pag_2.dw_2
dw_fac=tab_1.pag_3.dw_3
dw_cobro=tab_1.pag_4.dw_4
dw_negociado=tab_1.pag_5.dw_5
dw_vencido=tab_1.pag_6.dw_6
dw_devuelto=tab_1.pag_7.dw_7
dw_gasto=tab_1.pag_8.dw_8

dw_res.settransObject(sqlca)
dw_alb.settransObject(sqlca)
dw_fac.settransObject(sqlca)
dw_cobro.settransObject(sqlca)
dw_negociado.settransObject(sqlca)
dw_vencido.settransObject(sqlca)
dw_devuelto.settransObject(sqlca)
dw_gasto.settransObject(sqlca)

f_activar_campo(uo_cliente.em_campo)

this.title = "Foto Cliente"

end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_foto_cliente
integer taborder = 20
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_foto_cliente
integer taborder = 30
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_cliente.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_foto_cliente
integer x = 18
integer y = 4
integer width = 2624
end type

type uo_cliente from u_em_campo_2 within w_foto_cliente
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 325
integer y = 176
integer width = 1079
integer height = 88
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;uo_cliente.em_campo.text = f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)
If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 

tab_1.SelectedTab = 1
moneda_cliente=f_moneda_genter(codigo_empresa,"C",uo_cliente.em_codigo.text)
st_concedido.text=string(f_riesgo_concedido(codigo_empresa,f_cuenta_genter(codigo_empresa,'C',uo_cliente.em_codigo.text)),f_mascara_moneda(moneda_cliente))
dw_res.retrieve(codigo_empresa,moneda_cliente)
f_control()
end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Clientes"
ue_datawindow ="dw_ayuda_clientes"
ue_filtro = ""
end event

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

type gb_3 from groupbox within w_foto_cliente
integer x = 1650
integer y = 96
integer width = 814
integer height = 208
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_2 from groupbox within w_foto_cliente
integer x = 1458
integer y = 96
integer width = 201
integer height = 208
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_1 from groupbox within w_foto_cliente
integer x = 23
integer y = 96
integer width = 1431
integer height = 208
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type pb_1 from upb_salir within w_foto_cliente
integer x = 2747
integer y = 4
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type tab_1 from tab within w_foto_cliente
event create ( )
event destroy ( )
integer x = 23
integer y = 312
integer width = 2834
integer height = 1100
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean perpendiculartext = true
tabposition tabposition = tabsonleft!
alignment alignment = center!
integer selectedtab = 1
pag_1 pag_1
pag_2 pag_2
pag_3 pag_3
pag_4 pag_4
pag_5 pag_5
pag_6 pag_6
pag_7 pag_7
pag_8 pag_8
end type

on tab_1.create
this.pag_1=create pag_1
this.pag_2=create pag_2
this.pag_3=create pag_3
this.pag_4=create pag_4
this.pag_5=create pag_5
this.pag_6=create pag_6
this.pag_7=create pag_7
this.pag_8=create pag_8
this.Control[]={this.pag_1,&
this.pag_2,&
this.pag_3,&
this.pag_4,&
this.pag_5,&
this.pag_6,&
this.pag_7,&
this.pag_8}
end on

on tab_1.destroy
destroy(this.pag_1)
destroy(this.pag_2)
destroy(this.pag_3)
destroy(this.pag_4)
destroy(this.pag_5)
destroy(this.pag_6)
destroy(this.pag_7)
destroy(this.pag_8)
end on

event selectionchanged;choose case newindex
	case 2  
		dw_alb.retrieve(codigo_empresa,uo_cliente.em_codigo.text)
	case 3	
		dw_fac.retrieve(codigo_empresa,uo_cliente.em_codigo.text)
	case 4	
		dw_cobro.retrieve(codigo_empresa,uo_cliente.em_codigo.text)
	case 5
		dw_negociado.retrieve(codigo_empresa,uo_cliente.em_codigo.text)
	case 6
		dw_vencido.retrieve(codigo_empresa,uo_cliente.em_codigo.text)
	case 7
		dw_devuelto.retrieve(codigo_empresa,uo_cliente.em_codigo.text)
	case 8
		dw_gasto.retrieve(codigo_empresa,uo_cliente.em_codigo.text)
end choose
end event

type pag_1 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 850
integer y = 16
integer width = 1966
integer height = 1068
long backcolor = 79741120
string text = "Resumen"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_1 dw_1
end type

on pag_1.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on pag_1.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within pag_1
integer y = 144
integer width = 1966
integer height = 924
integer taborder = 71
boolean bringtotop = true
string dataobject = "dw_foto_cliente_1"
boolean border = false
boolean livescroll = true
end type

type pag_2 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 850
integer y = 16
integer width = 1966
integer height = 1068
long backcolor = 79741120
string text = "Albaranes Pendiente Facturar"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
pb_2 pb_2
dw_2 dw_2
end type

on pag_2.create
this.pb_2=create pb_2
this.dw_2=create dw_2
this.Control[]={this.pb_2,&
this.dw_2}
end on

on pag_2.destroy
destroy(this.pb_2)
destroy(this.dw_2)
end on

type pb_2 from picturebutton within pag_2
integer x = 229
integer width = 123
integer height = 104
integer taborder = 11
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "c:\bmp\print.bmp"
end type

event clicked;dw_list.dataobject="report_alb_pdtes_facturar"
dw_list.settransObject(sqlca)
dw_list.retrieve(codigo_empresa,uo_cliente.em_codigo.text)
OpenWithParm(w_impresoras_v2,dw_list)
end event

type dw_2 from datawindow within pag_2
integer width = 1966
integer height = 1068
integer taborder = 31
string dataobject = "dw_alb_pdtes_facturar"
boolean vscrollbar = true
boolean border = false
end type

type pag_3 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 850
integer y = 16
integer width = 1966
integer height = 1068
long backcolor = 79741120
string text = "Facturas Pendientes Actualizar"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
pb_3 pb_3
dw_3 dw_3
end type

on pag_3.create
this.pb_3=create pb_3
this.dw_3=create dw_3
this.Control[]={this.pb_3,&
this.dw_3}
end on

on pag_3.destroy
destroy(this.pb_3)
destroy(this.dw_3)
end on

type pb_3 from picturebutton within pag_3
integer x = 229
integer width = 123
integer height = 104
integer taborder = 32
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "c:\bmp\print.bmp"
end type

event clicked;dw_list.dataobject="report_fac_pdtes_actualizar"
dw_list.settransObject(sqlca)
dw_list.retrieve(codigo_empresa,uo_cliente.em_codigo.text)
OpenWithParm(w_impresoras_v2,dw_list)
end event

type dw_3 from datawindow within pag_3
integer x = 5
integer width = 1966
integer height = 1068
integer taborder = 32
string dataobject = "dw_fac_pdtes_actualizar"
boolean vscrollbar = true
boolean border = false
end type

type pag_4 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 850
integer y = 16
integer width = 1966
integer height = 1068
long backcolor = 79741120
string text = "Recibos Pendientes Cobro"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
pb_4 pb_4
dw_4 dw_4
end type

on pag_4.create
this.pb_4=create pb_4
this.dw_4=create dw_4
this.Control[]={this.pb_4,&
this.dw_4}
end on

on pag_4.destroy
destroy(this.pb_4)
destroy(this.dw_4)
end on

type pb_4 from picturebutton within pag_4
integer x = 23
integer width = 123
integer height = 104
integer taborder = 32
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "c:\bmp\print.bmp"
end type

event clicked;dw_list.dataobject="report_fac_pdtes_cobro"
dw_list.settransObject(sqlca)
dw_list.retrieve(codigo_empresa,uo_cliente.em_codigo.text)
OpenWithParm(w_impresoras_v2,dw_list)
end event

type dw_4 from datawindow within pag_4
integer width = 1966
integer height = 1068
integer taborder = 32
string dataobject = "dw_fac_pdtes_cobro"
boolean vscrollbar = true
boolean border = false
end type

type pag_5 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 850
integer y = 16
integer width = 1966
integer height = 1068
long backcolor = 79741120
string text = "Negociado Pendiente Cobro"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
pb_5 pb_5
dw_5 dw_5
end type

on pag_5.create
this.pb_5=create pb_5
this.dw_5=create dw_5
this.Control[]={this.pb_5,&
this.dw_5}
end on

on pag_5.destroy
destroy(this.pb_5)
destroy(this.dw_5)
end on

type pb_5 from picturebutton within pag_5
integer x = 23
integer width = 123
integer height = 104
integer taborder = 32
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "c:\bmp\print.bmp"
end type

event clicked;dw_list.dataobject="report_negociado_pdtes_cobro"
dw_list.settransObject(sqlca)
dw_list.retrieve(codigo_empresa,uo_cliente.em_codigo.text)
OpenWithParm(w_impresoras_v2,dw_list)
end event

type dw_5 from datawindow within pag_5
integer x = 18
integer width = 1966
integer height = 1068
integer taborder = 32
string dataobject = "dw_negociado_pdtes_cobro"
boolean vscrollbar = true
boolean border = false
end type

type pag_6 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 850
integer y = 16
integer width = 1966
integer height = 1068
long backcolor = 79741120
string text = "Recibos Vencidos"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
pb_6 pb_6
dw_6 dw_6
end type

on pag_6.create
this.pb_6=create pb_6
this.dw_6=create dw_6
this.Control[]={this.pb_6,&
this.dw_6}
end on

on pag_6.destroy
destroy(this.pb_6)
destroy(this.dw_6)
end on

type pb_6 from picturebutton within pag_6
integer x = 18
integer width = 123
integer height = 104
integer taborder = 32
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "c:\bmp\print.bmp"
end type

event clicked;dw_list.dataobject="report_fac_vencidas"
dw_list.settransObject(sqlca)
dw_list.retrieve(codigo_empresa,uo_cliente.em_codigo.text)
OpenWithParm(w_impresoras_v2,dw_list)
end event

type dw_6 from datawindow within pag_6
integer width = 1966
integer height = 1068
integer taborder = 32
string dataobject = "dw_fac_vencidas"
boolean vscrollbar = true
boolean border = false
end type

type pag_7 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 850
integer y = 16
integer width = 1966
integer height = 1068
long backcolor = 79741120
string text = "Devoluciones"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
pb_7 pb_7
dw_7 dw_7
end type

on pag_7.create
this.pb_7=create pb_7
this.dw_7=create dw_7
this.Control[]={this.pb_7,&
this.dw_7}
end on

on pag_7.destroy
destroy(this.pb_7)
destroy(this.dw_7)
end on

type pb_7 from picturebutton within pag_7
integer x = 23
integer width = 123
integer height = 104
integer taborder = 32
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "c:\bmp\print.bmp"
end type

type dw_7 from datawindow within pag_7
integer width = 1966
integer height = 1068
integer taborder = 32
string dataobject = "dw_fac_devuelto"
boolean vscrollbar = true
boolean border = false
end type

type pag_8 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 850
integer y = 16
integer width = 1966
integer height = 1068
long backcolor = 79741120
string text = "Gastos"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
pb_8 pb_8
dw_8 dw_8
end type

on pag_8.create
this.pb_8=create pb_8
this.dw_8=create dw_8
this.Control[]={this.pb_8,&
this.dw_8}
end on

on pag_8.destroy
destroy(this.pb_8)
destroy(this.dw_8)
end on

type pb_8 from picturebutton within pag_8
integer x = 23
integer width = 123
integer height = 104
integer taborder = 32
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "c:\bmp\print.bmp"
end type

type dw_8 from datawindow within pag_8
integer width = 1966
integer height = 1068
integer taborder = 32
string dataobject = "dw_fac_gasto"
boolean vscrollbar = true
boolean border = false
end type

type st_1 from statictext within w_foto_cliente
integer x = 55
integer y = 188
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Cliente:"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_9 from picturebutton within w_foto_cliente
integer x = 1472
integer y = 140
integer width = 169
integer height = 156
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "print!"
end type

event clicked;dw_list.dataobject="report_foto_cliente_1"
dw_list.settransObject(sqlca)
dw_res.RowsCopy( 1, dw_res.rowcount(),Primary!, dw_list, 1, Primary!)
dw_list.Object.cliente.text=" Riesgo del cliente "+uo_cliente.em_campo.text
dw_list.groupcalc()
OpenWithParm(w_impresoras_v2,dw_list)
end event

type dw_list from datawindow within w_foto_cliente
boolean visible = false
integer x = 1979
integer y = 156
integer width = 494
integer height = 360
integer taborder = 40
boolean bringtotop = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_foto_cliente
integer x = 1673
integer y = 184
integer width = 343
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Concedido:"
boolean focusrectangle = false
end type

type st_concedido from statictext within w_foto_cliente
integer x = 2011
integer y = 172
integer width = 430
integer height = 88
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "0"
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

