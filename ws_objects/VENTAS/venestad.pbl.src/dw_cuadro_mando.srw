$PBExportHeader$dw_cuadro_mando.srw
$PBExportComments$Informe de Objetivos de Facturación
forward
global type dw_cuadro_mando from w_int_con_empresa
end type
type pb_1 from upb_salir within dw_cuadro_mando
end type
type pb_2 from upb_imprimir within dw_cuadro_mando
end type
type cb_1 from commandbutton within dw_cuadro_mando
end type
type gb_6 from groupbox within dw_cuadro_mando
end type
type dw_informe from datawindow within dw_cuadro_mando
end type
type ddlb_mes from dropdownlistbox within dw_cuadro_mando
end type
type ddlb_anyo from dropdownlistbox within dw_cuadro_mando
end type
type st_1 from statictext within dw_cuadro_mando
end type
type st_2 from statictext within dw_cuadro_mando
end type
type st_3 from statictext within dw_cuadro_mando
end type
type st_4 from statictext within dw_cuadro_mando
end type
end forward

global type dw_cuadro_mando from w_int_con_empresa
integer x = 5
integer y = 4
integer width = 3616
integer height = 2872
pb_1 pb_1
pb_2 pb_2
cb_1 cb_1
gb_6 gb_6
dw_informe dw_informe
ddlb_mes ddlb_mes
ddlb_anyo ddlb_anyo
st_1 st_1
st_2 st_2
st_3 st_3
st_4 st_4
end type
global dw_cuadro_mando dw_cuadro_mando

type variables

end variables

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);datastore datos, regs
Datetime  fecha1,fecha2
date f1,f2
string sel, mes
dec{2} v_Objetivos, prev_deposito, v_total_facturado, v_desviacion_objetivos, v_facturacion_diaria, v_facturacion_necesaria
dec{2} v_pedidos_pendientes, v_albaranes_pendientes, v_pendiente_facturar, v_facturacion_previsible, v_alb_mas_fac
long fila_actual, total_dias, i, total, total_dias_facturables, dia_actual, total_dias_facturables_restantes, total_dias_mes, dias_febrero
string ultimo_dia_mes_anterior, hoy
integer anyo_anterior
long fila, piezas
string articulo
dec coste_mp, coste_fab, coste, coste_total1, coste_total2
boolean con_mermas


data.SetTransObject(SQLCA)
data.Reset()
data.retrieve()

data.setredraw(false)

f1 = date("31-01-"+ddlb_anyo.text )
f2 = date("01-03-"+ddlb_anyo.text )

dias_febrero = DaysAfter ( f1, f2 ) - 1
anyo_anterior = integer(ddlb_anyo.text) -1

CHOOSE CASE ddlb_mes.text
CASE "Enero"; 				mes = "1"; 		total_dias = 31; 				ultimo_dia_mes_anterior = '31-12-'+string(anyo_anterior)
CASE "Febrero"; 			mes = "2";		total_dias = dias_febrero;	ultimo_dia_mes_anterior = '31-01-'+ddlb_anyo.text
CASE "Marzo";   			mes = "3";		total_dias = 31;				ultimo_dia_mes_anterior = string(dias_febrero)+'-02-'+ddlb_anyo.text
CASE "Abril";   			mes = "4";		total_dias = 30;				ultimo_dia_mes_anterior = '31-03-'+ddlb_anyo.text
CASE "Mayo";    			mes = "5";		total_dias = 31;				ultimo_dia_mes_anterior = '30-04-'+ddlb_anyo.text
CASE "Junio";   			mes = "6";		total_dias = 30;				ultimo_dia_mes_anterior = '31-05-'+ddlb_anyo.text
CASE "Julio"; 	 			mes = "7";		total_dias = 31;				ultimo_dia_mes_anterior = '30-06-'+ddlb_anyo.text
CASE "Agosto";   			mes = "8";		total_dias = 31;				ultimo_dia_mes_anterior = '31-07-'+ddlb_anyo.text
CASE "Septiembre";		mes = "9";		total_dias = 30;				ultimo_dia_mes_anterior = '31-08-'+ddlb_anyo.text
CASE "Octubre";			mes = "10";		total_dias = 31;				ultimo_dia_mes_anterior = '30-09-'+ddlb_anyo.text
CASE "Noviembre";			mes = "11";		total_dias = 30;				ultimo_dia_mes_anterior = '31-10-'+ddlb_anyo.text
CASE "Diciembre";			mes = "12";		total_dias = 31;				ultimo_dia_mes_anterior = '30-11-'+ddlb_anyo.text
END CHOOSE

fecha1 = Datetime(Date("1/"+mes+"/"+ddlb_anyo.text))
if Month(Today()) = integer(mes) and year(today()) = long(ddlb_anyo.text) then
	fecha2 = Datetime(Today())
else
	fecha2 = Datetime(Date ( long(ddlb_anyo.text), long(mes), total_dias ))
end if

select Prevision, deposito 
into :v_objetivos, :prev_deposito
from venfacprev 
Where ejercicio = :ddlb_anyo.text
and mes = :mes;

// Total facturado
select sum(total_neto / cambio)
into :v_total_facturado 
from venfac
where empresa = :codigo_empresa
and ffactura >= :fecha1
and ffactura <= :fecha2;

if isnull(v_total_facturado) then
	v_total_facturado = 0
end if

// Albaranes pendientes
select sum(venlialb.neto / monedas.euros)
into :v_albaranes_pendientes
from venlialb, monedas
where venlialb.empresa = :codigo_empresa
and venlialb.divisa = monedas.moneda
and venlialb.deposito <> 'S'
and venlialb.falbaran <= :fecha2;

if isnull(v_albaranes_pendientes) then
	v_albaranes_pendientes = 0
end if

v_alb_mas_fac = v_total_facturado + v_albaranes_pendientes

// Desviación sobre objetivos
v_desviacion_objetivos = v_total_facturado - v_objetivos 

dia_actual = day(today())
select count(*)
into :total_dias_facturables
from prodmeses
where empresa = :codigo_empresa
and  anyo = :ddlb_anyo.text
and mes = :mes
and dia <= :dia_actual
and calendario = '5'
and horas <> 0;

select count(*)
into :total_dias_facturables_restantes
from prodmeses
where empresa = :codigo_empresa
and  anyo = :ddlb_anyo.text
and mes = :mes
and dia > :dia_actual
and calendario = '5'
and horas <> 0;
	
select count(*)
into :total_dias_mes
from prodmeses
where empresa = :codigo_empresa
and  anyo = :ddlb_anyo.text
and mes = :mes
and calendario = '5'
and horas <> 0;

if (long(ddlb_anyo.text) < year (today())) or (long(mes) < month(today())) then
	total_dias_facturables = total_dias_mes
	total_dias_facturables_restantes = 0
end if

if total_dias_facturables <> 0 then
	v_facturacion_diaria = v_alb_mas_fac / total_dias_facturables
else
	v_facturacion_diaria = 0
end if
	
if total_dias_facturables_restantes <> 0 then
//	v_facturacion_necesaria = (v_desviacion_objetivos / total_dias_facturables_restantes)  * -1
	v_facturacion_necesaria = ((v_objetivos - v_alb_mas_fac) / total_dias_facturables_restantes) 
else
	v_facturacion_necesaria = 0
end if
v_facturacion_previsible = v_facturacion_diaria * total_dias_mes

// Total pedidos pendientes
select sum(total_neto/ cambio)
into:v_pedidos_pendientes 
from venped 
where empresa = :codigo_empresa 
and fpedido <= :fecha2;

if isnull(v_pedidos_pendientes) then
	v_pedidos_pendientes = 0
end if



v_pendiente_facturar = v_pedidos_pendientes + v_albaranes_pendientes

fila_actual = data.insertrow(0)
data.object.var_stock[fila_actual] = coste_total1 - coste_total2
data.object.objetivos[fila_actual] = v_objetivos
data.object.total_facturado[fila_actual] = v_total_facturado
data.object.desviacion_objetivos[fila_actual] = v_desviacion_objetivos
data.object.facturacion_diaria[fila_actual] = v_facturacion_diaria
data.object.facturacion_necesaria[fila_actual] = v_facturacion_necesaria
data.object.pedidos_pendientes[fila_actual] = v_pedidos_pendientes
data.object.albaranes_pendientes[fila_actual] = v_albaranes_pendientes
data.object.pendiente_facturar[fila_actual] = v_pendiente_facturar
data.object.facturacion_previsible[fila_actual] = v_facturacion_previsible
data.object.alb_mas_fac[fila_actual] = v_alb_mas_fac
data.object.periodo.text =  ddlb_mes.text+ " de "+ddlb_anyo.text
data.object.estimacion_dep[fila_actual] = prev_Deposito

data.object.prev_dep[fila_actual] = data.object.estimacion_dep[fila_actual] + v_facturacion_previsible
	

destroy datos

data.sort()
data.groupcalc()
data.setredraw(true)
end subroutine

event close;dw_informe.reset()

end event

event open;call super::open;string mes

istr_parametros.s_titulo_ventana="Informe de Objetivos de Facturación"
This.title=istr_parametros.s_titulo_ventana

CHOOSE CASE String(MOnth(Today()))
CASE "1"; 	ddlb_mes.text = "Enero"   		
CASE "2"; 	ddlb_mes.text = "Febrero"   		
CASE "3"; 	ddlb_mes.text = "Marzo"   		
CASE "4"; 	ddlb_mes.text = "Abril"   		
CASE "5"; 	ddlb_mes.text = "Mayo"   		
CASE "6"; 	ddlb_mes.text = "Junio"   		
CASE "7"; 	ddlb_mes.text = "Julio"   		
CASE "8"; 	ddlb_mes.text = "Agosto"   		
CASE "9"; 	ddlb_mes.text = "Septiembre"   		
CASE "10"; 	ddlb_mes.text = "Octubre"   		
CASE "11"; 	ddlb_mes.text = "Noviembre"   		
CASE "12"; 	ddlb_mes.text = "Diciembre"   		
END CHOOSE

ddlb_anyo.text = String(Year(Today()))




end event

on dw_cuadro_mando.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.cb_1=create cb_1
this.gb_6=create gb_6
this.dw_informe=create dw_informe
this.ddlb_mes=create ddlb_mes
this.ddlb_anyo=create ddlb_anyo
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.gb_6
this.Control[iCurrent+5]=this.dw_informe
this.Control[iCurrent+6]=this.ddlb_mes
this.Control[iCurrent+7]=this.ddlb_anyo
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.st_3
this.Control[iCurrent+11]=this.st_4
end on

on dw_cuadro_mando.destroy
call super::destroy
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.cb_1)
destroy(this.gb_6)
destroy(this.dw_informe)
destroy(this.ddlb_mes)
destroy(this.ddlb_anyo)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
end on

event ue_f5;f_control(dw_informe)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within dw_cuadro_mando
integer y = 612
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within dw_cuadro_mando
end type

type st_empresa from w_int_con_empresa`st_empresa within dw_cuadro_mando
integer y = 8
integer width = 3570
integer height = 76
end type

type pb_1 from upb_salir within dw_cuadro_mando
integer x = 3429
integer y = 156
integer width = 119
integer height = 100
integer taborder = 0
end type

type pb_2 from upb_imprimir within dw_cuadro_mando
integer x = 3264
integer y = 156
integer width = 128
integer height = 104
integer taborder = 0
boolean originalsize = false
end type

event clicked;//f_control(dw_informe)
f_imprimir_datawindow(dw_informe)

end event

type cb_1 from commandbutton within dw_cuadro_mando
integer x = 2967
integer y = 156
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

type gb_6 from groupbox within dw_cuadro_mando
integer x = 2949
integer y = 116
integer width = 462
integer height = 160
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type dw_informe from datawindow within dw_cuadro_mando
integer x = 9
integer y = 304
integer width = 3579
integer height = 2512
boolean bringtotop = true
string dataobject = "dw_informe_objetivos_facturacion"
boolean border = false
boolean livescroll = true
end type

type ddlb_mes from dropdownlistbox within dw_cuadro_mando
integer x = 187
integer y = 160
integer width = 389
integer height = 476
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"}
borderstyle borderstyle = stylelowered!
end type

type ddlb_anyo from dropdownlistbox within dw_cuadro_mando
integer x = 841
integer y = 160
integer width = 265
integer height = 476
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
string item[] = {"2000","2001","2002","2003","2004","2005","2006","2007","2008","2009","2010","2011","2012","2013"}
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within dw_cuadro_mando
integer x = 41
integer y = 172
integer width = 137
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
string text = "Mes:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within dw_cuadro_mando
integer x = 667
integer y = 168
integer width = 160
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
string text = "Año:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within dw_cuadro_mando
integer x = 1243
integer y = 144
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

type st_4 from statictext within dw_cuadro_mando
integer x = 1248
integer y = 200
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

