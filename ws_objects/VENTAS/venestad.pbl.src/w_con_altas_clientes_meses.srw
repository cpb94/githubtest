$PBExportHeader$w_con_altas_clientes_meses.srw
forward
global type w_con_altas_clientes_meses from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_altas_clientes_meses
end type
type pb_2 from upb_imprimir within w_con_altas_clientes_meses
end type
type cb_1 from commandbutton within w_con_altas_clientes_meses
end type
type gb_6 from groupbox within w_con_altas_clientes_meses
end type
type dw_resumen from datawindow within w_con_altas_clientes_meses
end type
type dw_detalle from datawindow within w_con_altas_clientes_meses
end type
type uo_cliente from u_em_campo_2 within w_con_altas_clientes_meses
end type
type em_fechadesde from u_em_campo within w_con_altas_clientes_meses
end type
type em_fechahasta from u_em_campo within w_con_altas_clientes_meses
end type
type st_2 from statictext within w_con_altas_clientes_meses
end type
type uo_agente from u_em_campo_2 within w_con_altas_clientes_meses
end type
type gb_4 from groupbox within w_con_altas_clientes_meses
end type
type gb_1 from groupbox within w_con_altas_clientes_meses
end type
type gb_2 from groupbox within w_con_altas_clientes_meses
end type
end forward

global type w_con_altas_clientes_meses from w_int_con_empresa
integer x = 46
integer y = 32
integer width = 3840
integer height = 2656
pb_1 pb_1
pb_2 pb_2
cb_1 cb_1
gb_6 gb_6
dw_resumen dw_resumen
dw_detalle dw_detalle
uo_cliente uo_cliente
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
st_2 st_2
uo_agente uo_agente
gb_4 gb_4
gb_1 gb_1
gb_2 gb_2
end type
global w_con_altas_clientes_meses w_con_altas_clientes_meses

type variables

end variables

forward prototypes
public subroutine f_control (datawindow data)
public subroutine f_piezas_metros_importe (ref decimal arg_piezas, ref decimal arg_metros, ref decimal arg_importe, date fecha1, date fecha2, string cliente)
end prototypes

public subroutine f_control (datawindow data);string v_cliente, agente

if uo_cliente.em_codigo.text = '' or isnull (uo_cliente.em_codigo.text) then
	v_cliente = '%'
else
	v_cliente = uo_cliente.em_codigo.text
end if

if uo_agente.em_codigo.text = '' or isnull (uo_agente.em_codigo.text) then
	agente = '%'
else
	agente = uo_agente.em_codigo.text
end if


data.SetTransObject(SQLCA)
data.Reset()

data.Retrieve(codigo_empresa, datetime (date(em_fechadesde.text)), datetime (date(em_fechahasta.text)), v_cliente, agente)

data.object.t_texto.text ="Altas desde "+em_fechadesde.text+" hasta "+em_fechahasta.text
data.object.t_texto2.text =uo_cliente.em_campo.text+" "+uo_agente.em_campo.text

end subroutine

public subroutine f_piezas_metros_importe (ref decimal arg_piezas, ref decimal arg_metros, ref decimal arg_importe, date fecha1, date fecha2, string cliente);decimal importe_ped = 0, importe_alb = 0, importe_fac = 0
decimal piezas_ped = 0, piezas_alb = 0, piezas_fac = 0
decimal metros_ped = 0, metros_alb = 0, metros_fac = 0

select 	venliped.cliente,
			sum(venliped.importe / venped.cambio),
			sum(venliped.cantidad),
			sum(formatos.ancho * formatos.largo * venliped.cantidad / 10000)
into :cliente, :importe_ped, :piezas_ped, :metros_ped
from venliped, articulos, formatos, venped
where venliped.empresa = :codigo_empresa
and articulos.empresa = :codigo_empresa
and formatos.empresa = :codigo_empresa
and venped.empresa = :codigo_empresa
and venped.anyo = venliped.anyo
and venped.pedido = venliped.pedido
and venliped.articulo = articulos.codigo
and articulos.formato = formatos.codigo
and venliped.fpedido >= :fecha1
and venliped.fpedido <= :fecha2
and venliped.cliente like :cliente
group by venliped.cliente;

select 	venlialb.cliente,
			sum(venlialb.importe / venalb.cambio), 
			sum(venlialb.cantidad),
			sum(formatos.ancho * formatos.largo * venlialb.cantidad / 10000)
into :cliente, :importe_alb, :piezas_alb, :metros_alb
from venlialb, articulos, formatos, venalb
where venlialb.empresa = :codigo_empresa
and articulos.empresa = :codigo_empresa
and formatos.empresa = :codigo_empresa
and venalb.empresa = :codigo_empresa
and venalb.anyo = venlialb.anyo
and venalb.albaran = venlialb.albaran
and venlialb.articulo = articulos.codigo
and articulos.formato = formatos.codigo
and venlialb.fpedido_origen >= :fecha1
and venlialb.fpedido_origen <= :fecha2
and venlialb.cliente like :cliente
group by venlialb.cliente;

select 	venlifac.cliente, 
			sum(venlifac.importe / venlifac.cambio), 
			sum(venlifac.cantidad),
			sum(formatos.ancho * formatos.largo * venlifac.cantidad / 10000)
into :cliente, :importe_fac, :piezas_fac, :metros_fac
from venlifac, articulos, formatos, venfac
where venlifac.empresa = :codigo_empresa
and articulos.empresa = :codigo_empresa
and formatos.empresa = :codigo_empresa
and venfac.empresa = :codigo_empresa
and venfac.anyo = venlifac.anyo
and venfac.factura = venlifac.factura
and venlifac.articulo = articulos.codigo
and articulos.formato = formatos.codigo
and venlifac.fpedido_origen >= :fecha1
and venlifac.fpedido_origen <= :fecha2
and venlifac.cliente like :cliente
group by venlifac.cliente;

arg_importe = importe_ped + importe_alb + importe_fac 
arg_piezas = piezas_ped + piezas_alb + piezas_fac 
arg_metros = metros_ped + metros_alb + metros_fac 


end subroutine

event close;call super::close;
dw_detalle.reset()

end event

event open;call super::open;istr_parametros.s_titulo_ventana="Informe Altas de Artículos Por Clientes y Meses"
This.title=istr_parametros.s_titulo_ventana

em_fechadesde.text = '01-01-'+string (year(today()))
em_fechahasta.text = string (today())
end event

on w_con_altas_clientes_meses.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.cb_1=create cb_1
this.gb_6=create gb_6
this.dw_resumen=create dw_resumen
this.dw_detalle=create dw_detalle
this.uo_cliente=create uo_cliente
this.em_fechadesde=create em_fechadesde
this.em_fechahasta=create em_fechahasta
this.st_2=create st_2
this.uo_agente=create uo_agente
this.gb_4=create gb_4
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.gb_6
this.Control[iCurrent+5]=this.dw_resumen
this.Control[iCurrent+6]=this.dw_detalle
this.Control[iCurrent+7]=this.uo_cliente
this.Control[iCurrent+8]=this.em_fechadesde
this.Control[iCurrent+9]=this.em_fechahasta
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.uo_agente
this.Control[iCurrent+12]=this.gb_4
this.Control[iCurrent+13]=this.gb_1
this.Control[iCurrent+14]=this.gb_2
end on

on w_con_altas_clientes_meses.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.cb_1)
destroy(this.gb_6)
destroy(this.dw_resumen)
destroy(this.dw_detalle)
destroy(this.uo_cliente)
destroy(this.em_fechadesde)
destroy(this.em_fechahasta)
destroy(this.st_2)
destroy(this.uo_agente)
destroy(this.gb_4)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event ue_f5;f_control(dw_detalle)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_altas_clientes_meses
integer y = 612
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_altas_clientes_meses
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_altas_clientes_meses
integer y = 8
integer width = 3579
integer height = 88
boolean italic = true
end type

type pb_1 from upb_salir within w_con_altas_clientes_meses
integer x = 3616
integer y = 8
integer width = 119
integer height = 100
integer taborder = 0
string text = "1"
end type

type pb_2 from upb_imprimir within w_con_altas_clientes_meses
integer x = 3589
integer y = 152
integer width = 128
integer height = 104
integer taborder = 0
boolean originalsize = false
end type

event clicked;f_imprimir_datawindow(dw_resumen)

end event

type cb_1 from commandbutton within w_con_altas_clientes_meses
integer x = 3291
integer y = 152
integer width = 288
integer height = 104
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

type gb_6 from groupbox within w_con_altas_clientes_meses
integer x = 3273
integer y = 112
integer width = 462
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

type dw_resumen from datawindow within w_con_altas_clientes_meses
integer x = 14
integer y = 284
integer width = 3726
integer height = 2124
string dataobject = "dw_con_altas_clientes_meses"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_detalle from datawindow within w_con_altas_clientes_meses
boolean visible = false
integer x = 23
integer y = 288
integer width = 2889
integer height = 1276
integer taborder = 50
string dataobject = "dw_con_ped_alb_fac_cliente_fechas_tencer"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

type uo_cliente from u_em_campo_2 within w_con_altas_clientes_meses
event destroy ( )
integer x = 827
integer y = 168
integer width = 1294
integer height = 80
integer taborder = 30
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

type em_fechadesde from u_em_campo within w_con_altas_clientes_meses
integer x = 114
integer y = 156
integer width = 302
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 33551858
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_fechahasta from u_em_campo within w_con_altas_clientes_meses
integer x = 485
integer y = 156
integer width = 279
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 33551858
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type st_2 from statictext within w_con_altas_clientes_meses
integer x = 430
integer y = 144
integer width = 46
integer height = 64
boolean bringtotop = true
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

type uo_agente from u_em_campo_2 within w_con_altas_clientes_meses
event destroy ( )
integer x = 2167
integer y = 168
integer width = 1088
integer height = 80
integer taborder = 40
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_agente.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;uo_agente.em_campo.text=f_nombre_venagentes(codigo_empresa,uo_agente.em_codigo.text)

If Trim(uo_agente.em_campo.text)="" then
	uo_agente.em_campo.text=""
	uo_agente.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;	ue_titulo = "Selección de Agente"
	ue_datawindow ="dw_ayuda_venagentes"
	ue_filtro = ""

end event

type gb_4 from groupbox within w_con_altas_clientes_meses
integer x = 809
integer y = 116
integer width = 1330
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

type gb_1 from groupbox within w_con_altas_clientes_meses
integer x = 96
integer y = 96
integer width = 690
integer height = 180
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fechas"
end type

type gb_2 from groupbox within w_con_altas_clientes_meses
integer x = 2144
integer y = 116
integer width = 1134
integer height = 160
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Agente"
end type

