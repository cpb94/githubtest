$PBExportHeader$w_con_pedido_medio.srw
forward
global type w_con_pedido_medio from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_pedido_medio
end type
type pb_2 from upb_imprimir within w_con_pedido_medio
end type
type cb_1 from commandbutton within w_con_pedido_medio
end type
type gb_4 from groupbox within w_con_pedido_medio
end type
type gb_1 from groupbox within w_con_pedido_medio
end type
type gb_6 from groupbox within w_con_pedido_medio
end type
type dw_informe from datawindow within w_con_pedido_medio
end type
type em_fdesde from u_em_campo within w_con_pedido_medio
end type
type em_fhasta from u_em_campo within w_con_pedido_medio
end type
type uo_cliente from u_em_campo_2 within w_con_pedido_medio
end type
end forward

global type w_con_pedido_medio from w_int_con_empresa
integer width = 3712
integer height = 2292
pb_1 pb_1
pb_2 pb_2
cb_1 cb_1
gb_4 gb_4
gb_1 gb_1
gb_6 gb_6
dw_informe dw_informe
em_fdesde em_fdesde
em_fhasta em_fhasta
uo_cliente uo_cliente
end type
global w_con_pedido_medio w_con_pedido_medio

type variables

end variables

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);Date  fecha1,fecha2
string mes, cliente
dec{0} total_cenefas, total_bico, total_3f, total_4f, total_mold3f, total_mold4f, total_pedidos
dec{0} total_dec, total_esq, total_tacos
long fila_actual

data.SetTransObject(SQLCA)
data.Reset()
data.retrieve()
data.setredraw(false)		
fila_actual = data.insertrow(0)
fecha1 = date(em_fdesde.text)
fecha2 = date(em_fhasta.text)
data.object.periodo.text = uo_cliente.em_campo.text+"  Desde "+em_fdesde.text+" al "+em_fhasta.text
if uo_cliente.em_codigo.text = "" or isnull(uo_cliente.em_codigo.text) then
	cliente = "%"
else 
	cliente = uo_cliente.em_codigo.text	
end if
	
// Cenefas
select avg(cantidad)
into :total_cenefas
from venfac, venlifac, art_codestadistico
where venlifac.empresa = :codigo_empresa
and art_codestadistico.empresa = :codigo_empresa
and venfac.empresa = :codigo_empresa
and venlifac.articulo = art_codestadistico.codigo
and venfac.anyo = venlifac.anyo
and venfac.factura = venlifac.factura
and venlifac.clase <> 'M'
and ( art_codestadistico.g2 = 'P' or art_codestadistico.g2 = 'M' or art_codestadistico.g2 = 'C' )
and venlifac.cantidad > 0
and 	venlifac.fpedido_origen >= :fecha1
and 	venlifac.fpedido_origen <= :fecha2
and venfac.cliente like :cliente;

data.object.pm_cenefas[fila_actual] = total_cenefas 


// Bicoccion
select avg(cantidad)
into :total_bico
from venfac, venlifac, art_codestadistico
where venlifac.empresa = :codigo_empresa
and art_codestadistico.empresa = :codigo_empresa
and venfac.empresa = :codigo_empresa
and venlifac.articulo = art_codestadistico.codigo
and venfac.anyo = venlifac.anyo
and venfac.factura = venlifac.factura
and venlifac.clase <> 'M'
and ( art_codestadistico.g2 = 'M' or art_codestadistico.g2 = 'C')
and ( art_codestadistico.g4 = 'AP' or art_codestadistico.g4 = 'EM')
and venlifac.cantidad > 0
and 	venlifac.fpedido_origen >= :fecha1
and 	venlifac.fpedido_origen <= :fecha2
and venfac.cliente like :cliente;

data.object.pm_bico[fila_actual]  = total_bico

// Tercer Fuego
select avg(cantidad)
into :total_3f
from venfac, venlifac, art_codestadistico
where venlifac.empresa = :codigo_empresa
and art_codestadistico.empresa = :codigo_empresa
and venfac.empresa = :codigo_empresa
and venlifac.articulo = art_codestadistico.codigo
and venfac.anyo = venlifac.anyo
and venfac.factura = venlifac.factura
and venlifac.clase <> 'M'
and ( art_codestadistico.g2 = 'C' or art_codestadistico.g2 = 'P')
and ( art_codestadistico.g4 = '3F' ) 
and venlifac.cantidad > 0
and 	venlifac.fpedido_origen >= :fecha1
and 	venlifac.fpedido_origen <= :fecha2
and venfac.cliente like :cliente;

data.object.pm_3f[fila_actual] = total_3f 

// Cuarto Fuego
select avg(cantidad)
into :total_4f
from venfac, venlifac, art_codestadistico
where venlifac.empresa = :codigo_empresa
and art_codestadistico.empresa = :codigo_empresa
and venfac.empresa = :codigo_empresa
and venlifac.articulo = art_codestadistico.codigo
and venfac.anyo = venlifac.anyo
and venfac.factura = venlifac.factura
and venlifac.clase <> 'M'
and ( art_codestadistico.g2 = 'C' or art_codestadistico.g2 = 'P')
and ( art_codestadistico.g4 = '4F')
and venlifac.cantidad > 0
and 	venlifac.fpedido_origen >= :fecha1
and 	venlifac.fpedido_origen <= :fecha2
and venfac.cliente like :cliente;

data.object.pm_4f[fila_actual] = total_4f 

// Molduras Tercer Fuego
select avg(cantidad)
into :total_mold3f
from venfac, venlifac, art_codestadistico
where venlifac.empresa = :codigo_empresa
and art_codestadistico.empresa = :codigo_empresa
and venfac.empresa = :codigo_empresa
and venlifac.articulo = art_codestadistico.codigo
and venfac.anyo = venlifac.anyo
and venfac.factura = venlifac.factura
and venlifac.clase <> 'M'
and art_codestadistico.g2 = 'M' 
and art_codestadistico.g4 = '3F'
and venlifac.cantidad > 0
and 	venlifac.fpedido_origen >= :fecha1
and 	venlifac.fpedido_origen <= :fecha2
and venfac.cliente like :cliente;

data.object.pm_mold3f[fila_actual] = total_mold3f 

// Molduras Cuarto Fuego
select avg(cantidad)
into :total_mold4f
from venfac, venlifac, art_codestadistico
where venlifac.empresa = :codigo_empresa
and art_codestadistico.empresa = :codigo_empresa
and venfac.empresa = :codigo_empresa
and venlifac.articulo = art_codestadistico.codigo
and venfac.anyo = venlifac.anyo
and venfac.factura = venlifac.factura
and venlifac.clase <> 'M'
and art_codestadistico.g2 = 'M' 
and art_codestadistico.g4 = '4F'
and venlifac.cantidad > 0
and 	venlifac.fpedido_origen >= :fecha1
and 	venlifac.fpedido_origen <= :fecha2
and venfac.cliente like :cliente;

data.object.pm_mold4f[fila_actual] = total_mold4f 

// Decorados / Encastres
select avg(cantidad)
into :total_dec
from venfac, venlifac, art_codestadistico
where venlifac.empresa = :codigo_empresa
and art_codestadistico.empresa = :codigo_empresa
and venfac.empresa = :codigo_empresa
and venlifac.articulo = art_codestadistico.codigo
and venfac.anyo = venlifac.anyo
and venfac.factura = venlifac.factura
and venlifac.clase <> 'M'
and (art_codestadistico.g2 = 'E' or art_codestadistico.g2 = 'D' )
and venlifac.cantidad > 0
and 	venlifac.fpedido_origen >= :fecha1
and 	venlifac.fpedido_origen <= :fecha2
and venfac.cliente like :cliente;

data.object.pm_dec[fila_actual] = total_dec 

// Tacos
select avg(cantidad)
into :total_tacos
from venfac, venlifac, art_codestadistico
where venlifac.empresa = :codigo_empresa
and art_codestadistico.empresa = :codigo_empresa
and venfac.empresa = :codigo_empresa
and venlifac.articulo = art_codestadistico.codigo
and venfac.anyo = venlifac.anyo
and venfac.factura = venlifac.factura
and venlifac.clase <> 'M'
and art_codestadistico.g2 = 'T'
and venlifac.cantidad > 0
and 	venlifac.fpedido_origen >= :fecha1
and 	venlifac.fpedido_origen <= :fecha2
and venfac.cliente like :cliente;

data.object.pm_tacos[fila_actual] = total_tacos 

// esquinas
select avg(cantidad)
into :total_esq
from venfac, venlifac, art_codestadistico
where venlifac.empresa = :codigo_empresa
and art_codestadistico.empresa = :codigo_empresa
and venfac.empresa = :codigo_empresa
and venlifac.articulo = art_codestadistico.codigo
and venfac.anyo = venlifac.anyo
and venfac.factura = venlifac.factura
and venlifac.clase <> 'M'
and art_codestadistico.g2 = 'Q'
and venlifac.cantidad > 0
and 	venlifac.fpedido_origen >= :fecha1
and 	venlifac.fpedido_origen <= :fecha2
and venfac.cliente like :cliente;

data.object.pm_esq[fila_actual] = total_esq 

data.sort()
data.groupcalc()
data.setredraw(true)


end subroutine

event close;call super::close;dw_informe.reset()

end event

event open;call super::open;string mes

istr_parametros.s_titulo_ventana="Informe Pedido Medio"
This.title=istr_parametros.s_titulo_ventana

em_fdesde.text = "01-01-01"
em_fhasta.text = string(today(),"dd-mm-yy")


end event

on w_con_pedido_medio.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.cb_1=create cb_1
this.gb_4=create gb_4
this.gb_1=create gb_1
this.gb_6=create gb_6
this.dw_informe=create dw_informe
this.em_fdesde=create em_fdesde
this.em_fhasta=create em_fhasta
this.uo_cliente=create uo_cliente
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.gb_4
this.Control[iCurrent+5]=this.gb_1
this.Control[iCurrent+6]=this.gb_6
this.Control[iCurrent+7]=this.dw_informe
this.Control[iCurrent+8]=this.em_fdesde
this.Control[iCurrent+9]=this.em_fhasta
this.Control[iCurrent+10]=this.uo_cliente
end on

on w_con_pedido_medio.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.cb_1)
destroy(this.gb_4)
destroy(this.gb_1)
destroy(this.gb_6)
destroy(this.dw_informe)
destroy(this.em_fdesde)
destroy(this.em_fhasta)
destroy(this.uo_cliente)
end on

event ue_f5;f_control(dw_informe)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_pedido_medio
integer y = 612
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_pedido_medio
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_pedido_medio
integer y = 8
integer width = 3401
integer height = 84
end type

type pb_1 from upb_salir within w_con_pedido_medio
integer x = 3461
integer width = 119
integer height = 100
integer taborder = 0
end type

type pb_2 from upb_imprimir within w_con_pedido_medio
integer x = 3447
integer y = 160
integer width = 128
integer height = 104
integer taborder = 0
boolean originalsize = false
end type

event clicked;f_control(dw_informe)
f_imprimir_datawindow(dw_informe)

end event

type cb_1 from commandbutton within w_con_pedido_medio
integer x = 3150
integer y = 160
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

type gb_4 from groupbox within w_con_pedido_medio
integer x = 722
integer y = 132
integer width = 1678
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
string text = "Cliente"
end type

type gb_1 from groupbox within w_con_pedido_medio
integer x = 82
integer y = 128
integer width = 617
integer height = 160
integer taborder = 50
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha"
end type

type gb_6 from groupbox within w_con_pedido_medio
integer x = 3131
integer y = 120
integer width = 462
integer height = 160
integer taborder = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type dw_informe from datawindow within w_con_pedido_medio
integer x = 9
integer y = 304
integer width = 3607
integer height = 1728
boolean bringtotop = true
string dataobject = "dw_con_pedido_medio"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type em_fdesde from u_em_campo within w_con_pedido_medio
integer x = 96
integer y = 192
integer width = 288
integer height = 76
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 79741120
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_fhasta from u_em_campo within w_con_pedido_medio
integer x = 393
integer y = 192
integer width = 288
integer height = 76
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 79741120
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type uo_cliente from u_em_campo_2 within w_con_pedido_medio
event destroy ( )
integer x = 745
integer y = 192
integer width = 1632
integer height = 76
integer taborder = 60
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event modificado;
uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)

IF Trim(uo_cliente.em_campo.text)="" THEN 
 	IF Trim(uo_cliente.em_codigo.text)<>"" Then 
		uo_cliente.em_campo.SetFocus()
	END IF
 	uo_cliente.em_campo.text=""
 	uo_cliente.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Clientes"
ue_datawindow = "dw_ayuda_clientes"
ue_filtro     = ""

end event

