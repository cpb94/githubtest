$PBExportHeader$w_con_rotacion_deposito.srw
forward
global type w_con_rotacion_deposito from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_rotacion_deposito
end type
type pb_2 from upb_imprimir within w_con_rotacion_deposito
end type
type cb_1 from commandbutton within w_con_rotacion_deposito
end type
type gb_6 from groupbox within w_con_rotacion_deposito
end type
type dw_resumen from datawindow within w_con_rotacion_deposito
end type
type uo_cliente from u_em_campo_2 within w_con_rotacion_deposito
end type
type st_2 from statictext within w_con_rotacion_deposito
end type
type em_anyo from editmask within w_con_rotacion_deposito
end type
type gb_4 from groupbox within w_con_rotacion_deposito
end type
end forward

global type w_con_rotacion_deposito from w_int_con_empresa
integer x = 46
integer y = 32
integer width = 4498
integer height = 2664
pb_1 pb_1
pb_2 pb_2
cb_1 cb_1
gb_6 gb_6
dw_resumen dw_resumen
uo_cliente uo_cliente
st_2 st_2
em_anyo em_anyo
gb_4 gb_4
end type
global w_con_rotacion_deposito w_con_rotacion_deposito

type variables

end variables

forward prototypes
public subroutine f_control (datawindow data)
public function long f_ventas (string cliente, integer mes, integer anyo)
public function long f_stock (string cliente, integer mes, integer anyo)
end prototypes

public subroutine f_control (datawindow data);string v_cliente, sel, v_cliente_actual
long  i, j, v_cantidad, v_stock, fila_actual
integer anyo, mes_actual
datastore datos
dec v_rotacion

if uo_cliente.em_codigo.text = '' or isnull (uo_cliente.em_codigo.text) then
	v_cliente = '%'
else
	v_cliente = uo_cliente.em_codigo.text
end if


data.SetTransObject(SQLCA)
data.Reset()

anyo = long( em_anyo.text)

sel = " select genter.codigo, genter.razon " +&
		" from genter, venclientes  " +&
		" where genter.empresa = '"+codigo_empresa+"' " +&
		" and genter.empresa = venclientes.empresa " +&
		" and genter.codigo = venclientes.codigo " +&
		" and genter.tipoter = 'C' " +&
		" and venclientes.deposito = 'S' " +&
      " and genter.codigo like '"+v_cliente+"'" 
		
f_cargar_cursor_nuevo(sel, datos)

for i = 1 to datos.rowcount()
	fila_actual = dw_resumen.InsertRow(0)
	mes_actual = month (date(today()))
//	mes_Actual = 12
	for j = 1 to mes_actual
		v_cantidad = f_ventas (datos.object.genter_codigo[i], j, anyo )
		v_stock = f_stock (datos.object.genter_codigo[i], j, anyo )		
		choose case j
			case	1 
				dw_resumen.object.ventas_1[i] = v_cantidad
				dw_resumen.object.stock_1[i] = v_stock
				if v_cantidad <> 0 then dw_resumen.object.rotacion_1[i] =  v_stock / v_cantidad else dw_resumen.object.rotacion_1[i] = 0
			case	2
				dw_resumen.object.ventas_2[i] = v_cantidad
				dw_resumen.object.stock_2[i] = v_stock
				if v_cantidad <> 0 then dw_resumen.object.rotacion_2[i] =  v_stock / v_cantidad else dw_resumen.object.rotacion_2[i] = 0
			case	3
				dw_resumen.object.ventas_3[i] = v_cantidad
				dw_resumen.object.stock_3[i] = v_stock
				if v_cantidad <> 0 then dw_resumen.object.rotacion_3[i] =  v_stock / v_cantidad else dw_resumen.object.rotacion_3[i] = 0
			case	4
				dw_resumen.object.ventas_4[i] = v_cantidad
				dw_resumen.object.stock_4[i] = v_stock
				if v_cantidad <> 0 then dw_resumen.object.rotacion_4[i] =  v_stock / v_cantidad else dw_resumen.object.rotacion_4[i] = 0
			case	5
				dw_resumen.object.ventas_5[i] = v_cantidad
				dw_resumen.object.stock_5[i] = v_stock
				if v_cantidad <> 0 then dw_resumen.object.rotacion_5[i] =  v_stock / v_cantidad else dw_resumen.object.rotacion_5[i] = 0
			case	6
				dw_resumen.object.ventas_6[i] = v_cantidad
				dw_resumen.object.stock_6[i] = v_stock
				if v_cantidad <> 0 then dw_resumen.object.rotacion_6[i] =  v_stock / v_cantidad else dw_resumen.object.rotacion_6[i] = 0
			case	7
				dw_resumen.object.ventas_7[i] = v_cantidad
				dw_resumen.object.stock_7[i] = v_stock
				if v_cantidad <> 0 then dw_resumen.object.rotacion_7[i] =  v_stock / v_cantidad else dw_resumen.object.rotacion_7[i] = 0
			case	8
				dw_resumen.object.ventas_8[i] = v_cantidad
				dw_resumen.object.stock_8[i] = v_stock
				if v_cantidad <> 0 then dw_resumen.object.rotacion_8[i] =  v_stock / v_cantidad else dw_resumen.object.rotacion_8[i] = 0
			case	9
				dw_resumen.object.ventas_9[i] = v_cantidad
				dw_resumen.object.stock_9[i] = v_stock
				if v_cantidad <> 0 then dw_resumen.object.rotacion_9[i] =  v_stock / v_cantidad else dw_resumen.object.rotacion_9[i] = 0
			case	10
				dw_resumen.object.ventas_10[i] = v_cantidad
				dw_resumen.object.stock_10[i] = v_stock
				if v_cantidad <> 0 then dw_resumen.object.rotacion_10[i] =  v_stock / v_cantidad else dw_resumen.object.rotacion_10[i] = 0
			case	11
				dw_resumen.object.ventas_11[i] = v_cantidad
				dw_resumen.object.stock_11[i] = v_stock
				if v_cantidad <> 0 then dw_resumen.object.rotacion_11[i] =  v_stock / v_cantidad else dw_resumen.object.rotacion_11[i] = 0
			case	12
				dw_resumen.object.ventas_12[i] = v_cantidad
				dw_resumen.object.stock_12[i] = v_stock
				if v_cantidad <> 0 then dw_resumen.object.rotacion_12[i] =  v_stock / v_cantidad else dw_resumen.object.rotacion_12[i] = 0
		end choose
			
		

		dw_resumen.object.anyo[fila_actual] = anyo
		dw_resumen.object.cliente[fila_actual] = datos.object.genter_razon[i]
	next
next


//data.Retrieve(codigo_empresa, v_cliente, anyo)



end subroutine

public function long f_ventas (string cliente, integer mes, integer anyo);long v_cantidad

select sum(cantidad)
into :v_cantidad
from venlifac 
where factura_deposito = 'S'
and cliente = :cliente
and month(ffactura) = :mes
and year(ffactura) = :anyo;
	
return v_cantidad
end function

public function long f_stock (string cliente, integer mes, integer anyo);long v_cantidad

select sum(depmovhis.cantidade - depmovhis.cantidads)
into :v_cantidad
from depmovhis , articulos
where depmovhis.empresa = :codigo_empresa
and depmovhis.empresa = articulos.empresa
and depmovhis.articulo = articulos.codigo
and articulos.cliente = :cliente
and (( month(fechmov) <= :mes and year(fechmov) <= :anyo ) or (year(fechmov) < :anyo) );
	
return v_cantidad
end function

event close;call super::close;
//dw_detalle.reset()

end event

event open;call super::open;istr_parametros.s_titulo_ventana="Informe de Facturación de Depósito por Clientes y Meses."
This.title=istr_parametros.s_titulo_ventana

//em_fdesde.text = string (RelativeDate (date(today()), -365), "dd-mm-yy")
//em_fhasta.text = string (date(today() ), "dd-mm-yy")
em_anyo.text = string(year (date(today())))
end event

on w_con_rotacion_deposito.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.cb_1=create cb_1
this.gb_6=create gb_6
this.dw_resumen=create dw_resumen
this.uo_cliente=create uo_cliente
this.st_2=create st_2
this.em_anyo=create em_anyo
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.gb_6
this.Control[iCurrent+5]=this.dw_resumen
this.Control[iCurrent+6]=this.uo_cliente
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.em_anyo
this.Control[iCurrent+9]=this.gb_4
end on

on w_con_rotacion_deposito.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.cb_1)
destroy(this.gb_6)
destroy(this.dw_resumen)
destroy(this.uo_cliente)
destroy(this.st_2)
destroy(this.em_anyo)
destroy(this.gb_4)
end on

event ue_f5;//f_control(dw_detalle)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_rotacion_deposito
integer y = 612
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_rotacion_deposito
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_rotacion_deposito
integer y = 8
integer width = 4201
integer height = 88
boolean italic = true
end type

type pb_1 from upb_salir within w_con_rotacion_deposito
integer x = 4261
integer y = 8
integer width = 119
integer height = 100
integer taborder = 0
string text = "1"
end type

type pb_2 from upb_imprimir within w_con_rotacion_deposito
integer x = 4247
integer y = 140
integer width = 128
integer height = 104
integer taborder = 0
boolean originalsize = false
end type

event clicked;f_imprimir_datawindow(dw_resumen)

end event

type cb_1 from commandbutton within w_con_rotacion_deposito
integer x = 3950
integer y = 140
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

type gb_6 from groupbox within w_con_rotacion_deposito
integer x = 3931
integer y = 100
integer width = 462
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
end type

type dw_resumen from datawindow within w_con_rotacion_deposito
integer x = 27
integer y = 284
integer width = 4389
integer height = 2124
string dataobject = "dw_con_rotacion_deposito_pzs"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_cliente from u_em_campo_2 within w_con_rotacion_deposito
event destroy ( )
integer x = 37
integer y = 144
integer width = 1573
integer height = 80
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

type st_2 from statictext within w_con_rotacion_deposito
integer x = 1760
integer y = 148
integer width = 224
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Año:"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_anyo from editmask within w_con_rotacion_deposito
integer x = 1989
integer y = 140
integer width = 210
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "0000"
end type

type gb_4 from groupbox within w_con_rotacion_deposito
integer x = 18
integer y = 100
integer width = 1614
integer height = 144
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

