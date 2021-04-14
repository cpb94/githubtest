$PBExportHeader$w_cuadro_mando.srw
$PBExportComments$Informe de Objetivos de Facturación
forward
global type w_cuadro_mando from w_int_con_empresa
end type
type pb_1 from upb_salir within w_cuadro_mando
end type
type pb_2 from upb_imprimir within w_cuadro_mando
end type
type cb_1 from commandbutton within w_cuadro_mando
end type
type st_1 from statictext within w_cuadro_mando
end type
type cbx_ventas from checkbox within w_cuadro_mando
end type
type cbx_pedidos from checkbox within w_cuadro_mando
end type
type dw_resumen_pedidos_meses_anyos from datawindow within w_cuadro_mando
end type
type cbx_pedidos_meses from checkbox within w_cuadro_mando
end type
type st_2 from statictext within w_cuadro_mando
end type
type dw_precio_medio_por_anyos from datawindow within w_cuadro_mando
end type
type st_3 from statictext within w_cuadro_mando
end type
type cbx_precio_medio from checkbox within w_cuadro_mando
end type
type dw_seguimiento_objetivos_generales from datawindow within w_cuadro_mando
end type
type cbx_seguimiento_objetivos from checkbox within w_cuadro_mando
end type
type cbx_cta_resultados from checkbox within w_cuadro_mando
end type
type uo_familia from u_em_campo_2 within w_cuadro_mando
end type
type gb_8 from groupbox within w_cuadro_mando
end type
type dw_detalle2 from datawindow within w_cuadro_mando
end type
type dw_totales_ventas_por_familia from datawindow within w_cuadro_mando
end type
type dw_totales_pedidos_por_familia from datawindow within w_cuadro_mando
end type
type dw_pedidos_cliente_dos_anyos from datawindow within w_cuadro_mando
end type
type dw_pedidos_por_cliente_hoy from datawindow within w_cuadro_mando
end type
type r_1 from rectangle within w_cuadro_mando
end type
type dw_informe from datawindow within w_cuadro_mando
end type
type dw_pedidos_pendientes_familia from datawindow within w_cuadro_mando
end type
type st_4 from statictext within w_cuadro_mando
end type
type st_valor_stock_wow from statictext within w_cuadro_mando
end type
type st_5 from statictext within w_cuadro_mando
end type
type st_meses_stock_wow from statictext within w_cuadro_mando
end type
type st_6 from statictext within w_cuadro_mando
end type
type st_7 from statictext within w_cuadro_mando
end type
type dw_con_cuenta_resutlados_mini from datawindow within w_cuadro_mando
end type
type p_informacion from picture within w_cuadro_mando
end type
type st_8 from statictext within w_cuadro_mando
end type
type st_valor_stock_dna from statictext within w_cuadro_mando
end type
type st_10 from statictext within w_cuadro_mando
end type
type st_meses_stock_dna from statictext within w_cuadro_mando
end type
type st_12 from statictext within w_cuadro_mando
end type
type st_13 from statictext within w_cuadro_mando
end type
type r_2 from rectangle within w_cuadro_mando
end type
type r_3 from rectangle within w_cuadro_mando
end type
end forward

global type w_cuadro_mando from w_int_con_empresa
integer x = 5
integer y = 4
integer width = 6958
integer height = 3988
boolean resizable = true
long backcolor = 33554431
pb_1 pb_1
pb_2 pb_2
cb_1 cb_1
st_1 st_1
cbx_ventas cbx_ventas
cbx_pedidos cbx_pedidos
dw_resumen_pedidos_meses_anyos dw_resumen_pedidos_meses_anyos
cbx_pedidos_meses cbx_pedidos_meses
st_2 st_2
dw_precio_medio_por_anyos dw_precio_medio_por_anyos
st_3 st_3
cbx_precio_medio cbx_precio_medio
dw_seguimiento_objetivos_generales dw_seguimiento_objetivos_generales
cbx_seguimiento_objetivos cbx_seguimiento_objetivos
cbx_cta_resultados cbx_cta_resultados
uo_familia uo_familia
gb_8 gb_8
dw_detalle2 dw_detalle2
dw_totales_ventas_por_familia dw_totales_ventas_por_familia
dw_totales_pedidos_por_familia dw_totales_pedidos_por_familia
dw_pedidos_cliente_dos_anyos dw_pedidos_cliente_dos_anyos
dw_pedidos_por_cliente_hoy dw_pedidos_por_cliente_hoy
r_1 r_1
dw_informe dw_informe
dw_pedidos_pendientes_familia dw_pedidos_pendientes_familia
st_4 st_4
st_valor_stock_wow st_valor_stock_wow
st_5 st_5
st_meses_stock_wow st_meses_stock_wow
st_6 st_6
st_7 st_7
dw_con_cuenta_resutlados_mini dw_con_cuenta_resutlados_mini
p_informacion p_informacion
st_8 st_8
st_valor_stock_dna st_valor_stock_dna
st_10 st_10
st_meses_stock_dna st_meses_stock_dna
st_12 st_12
st_13 st_13
r_2 r_2
r_3 r_3
end type
global w_cuadro_mando w_cuadro_mando

type variables

end variables

forward prototypes
public subroutine f_control (datawindow data)
public subroutine f_objetivos_facturacion ()
public subroutine f_control3 (datawindow data)
public subroutine f_control4 ()
public subroutine f_control5 (datawindow datos)
protected subroutine f_control2 ()
public subroutine f_pedidos_por_cliente_hoy ()
public function decimal f_valor_planificado (string subcontratado)
public function decimal f_valor_stock_wow (string arg_familia)
public function decimal f_ventas_mensuales_wow (string arg_familia)
end prototypes

public subroutine f_control (datawindow data);datastore datos
Datetime  fecha1,fecha2
date f1,f2
string sel, mes
dec{2} v_Objetivos, prev_deposito, v_total_facturado, v_desviacion_objetivos, v_facturacion_diaria, v_facturacion_necesaria
dec{2} v_pedidos_pendientes, v_pedidos_disponibles, v_albaranes_pendientes, v_pendiente_facturar, v_facturacion_previsible, v_alb_mas_fac
long fila_actual, total_dias, i, total, dias_febrero
string ultimo_dia_mes_anterior, hoy
integer anyo_anterior, anyo
long fila
string articulo
integer total_dias_facturables, dia_actual, total_dias_facturables_restantes,  total_dias_mes
dec alb_pdtes_facturar, alb_facturados, v_facturacion_diaria_y_muelle , importe_muelle
string cod_cliente
long total_familias
string cod_familia, des_familia
dec pedidos_pendientes_familia

data.SetTransObject(SQLCA)
data.Reset()
data.retrieve()

data.setredraw(false)

anyo = year(today())
f1 = date("31-01-"+string(anyo))
f2 = date("01-03-"+string(anyo))

dias_febrero = DaysAfter ( f1, f2 ) - 1
anyo_anterior = anyo -1

mes = string(month(today()))

CHOOSE CASE mes
CASE "1"; 		total_dias = 31; 				ultimo_dia_mes_anterior = '31-12-'+string(anyo_anterior)
CASE "2";		total_dias = dias_febrero;	ultimo_dia_mes_anterior = '31-01-'+string(anyo)
CASE "3";		total_dias = 31;				ultimo_dia_mes_anterior = string(dias_febrero)+'-02-'+string(anyo)
CASE "4";		total_dias = 30;				ultimo_dia_mes_anterior = '31-03-'+string(anyo)
CASE "5";		total_dias = 31;				ultimo_dia_mes_anterior = '30-04-'+string(anyo)
CASE "6";		total_dias = 30;				ultimo_dia_mes_anterior = '31-05-'+string(anyo)
CASE "7";		total_dias = 31;				ultimo_dia_mes_anterior = '30-06-'+string(anyo)
CASE "8";		total_dias = 31;				ultimo_dia_mes_anterior = '31-07-'+string(anyo)
CASE "9";		total_dias = 30;				ultimo_dia_mes_anterior = '31-08-'+string(anyo)
CASE "10";		total_dias = 31;				ultimo_dia_mes_anterior = '30-09-'+string(anyo)
CASE "11";		total_dias = 30;				ultimo_dia_mes_anterior = '31-10-'+string(anyo)
CASE "12";		total_dias = 31;				ultimo_dia_mes_anterior = '30-11-'+string(anyo)
END CHOOSE

mes = string(month (today()))
anyo = year(today())
fecha1 = Datetime(Date("1/"+mes+"/"+string(anyo)))

fecha2 = Datetime(Today())
	
v_objetivos = f_objetivos_facturacion (anyo, integer(mes))
v_total_facturado = f_total_facturado_entre_fechas (codigo_empresa, fecha1, fecha2)
v_albaranes_pendientes = f_albaranes_pendientes (codigo_empresa, fecha2)
v_alb_mas_fac = v_total_facturado + v_albaranes_pendientes
v_desviacion_objetivos = v_total_facturado - v_objetivos 
f_dias_facturacion_calendario (codigo_empresa, total_dias_facturables, total_dias_facturables_restantes, total_dias_mes, anyo, integer( mes))

if total_dias_facturables <> 0 then
	v_facturacion_diaria = v_alb_mas_fac / total_dias_facturables
else
	v_facturacion_diaria = 0
end if
	
if total_dias_facturables_restantes <> 0 then
	v_facturacion_necesaria = ((v_objetivos - v_alb_mas_fac) / total_dias_facturables_restantes) 
else
	v_facturacion_necesaria = 0
end if

v_facturacion_previsible = v_facturacion_diaria * total_dias_mes
v_pedidos_pendientes = f_pedidos_pendientes_no_fabricados (codigo_empresa)
v_pedidos_disponibles = f_pedidos_disponibles_no_fabricados (codigo_empresa) 
v_pendiente_facturar = v_pedidos_pendientes + v_albaranes_pendientes

fila_actual = data.insertrow(0)

data.object.periodo.text =  								mes+ " de "+string(anyo)
data.object.objetivos[fila_actual] = 					v_objetivos
data.object.total_facturado[fila_actual] = 			v_total_facturado
data.object.albaranes_pendientes[fila_actual] = 	v_albaranes_pendientes
data.object.alb_mas_fac[fila_actual] = 				v_alb_mas_fac
data.object.desviacion_objetivos[fila_actual] = 	    v_desviacion_objetivos

data.object.facturacion_diaria[fila_actual] = 		    v_facturacion_diaria
data.object.facturacion_necesaria[fila_actual] = 	v_facturacion_necesaria
data.object.facturacion_previsible[fila_actual] = 	v_facturacion_previsible

data.object.pedidos_pendientes[fila_actual] = 		v_pedidos_pendientes
data.object.pedidos_disp[fila_actual] = 				v_pedidos_disponibles
data.object.pendiente_facturar[fila_actual] = 		v_pendiente_facturar


//Calculamos el valor de stock en el muelle
importe_muelle = f_valor_stock_p(codigo_empresa)

data.object.valor_stock_muelle[fila_actual] = importe_muelle

// Cálculo de Lo cargado Hoy
alb_pdtes_facturar = f_alb_pdtes_facturar_fechas (codigo_empresa, fecha2, fecha2)

alb_facturados = f_albaranes_facturados_fechas (codigo_empresa, fecha2, fecha2)

data.object.total_Cargado[fila_actual] = alb_pdtes_facturar + alb_facturados

// Comparativa pedidos a mes corrido
fecha1 = Datetime( RelativeDate ( today(), -30 ) )
fecha2 = Datetime(Today())
data.object.pedidos_mes_corrido[fila_actual] = f_pedidos_cliente_fechas ( codigo_empresa, '%', fecha1, fecha2, 1999, year(today()))

//SOLO LO DE TENCER
data.object.valor_planificado_tencer[fila_actual] = f_valor_planificado("N")

//SOLO LO SUBCONTRATADO
data.object.valor_planificado_sub[fila_actual] = f_valor_planificado("S")

//TODO LO PLANIFICADO
data.object.valor_planificado[fila_actual]  = data.object.valor_planificado_tencer[fila_actual] + data.object.valor_planificado_sub[fila_actual]

data.object.valor_planificado_a_stock[fila_actual]  = data.object.valor_planificado[fila_actual] - data.object.pedidos_disp[fila_actual]
data.sort()
data.groupcalc()
data.setredraw(true)

st_valor_stock_wow.text = string(f_valor_stock_wow('2'), "###,###,##0")
st_meses_stock_wow.text = 	string(   dec(st_valor_stock_wow.text)  /  f_ventas_mensuales_wow('2') , "###,###,##0.0")


//PETICION JORGE 05/08/20, FAMILIA DNA
st_valor_stock_dna.text = string(f_valor_stock_wow('6'), "###,###,##0")
st_meses_stock_dna.text = 	string(   dec(st_valor_stock_dna.text)  /  f_ventas_mensuales_wow('6') , "###,###,##0.0")


// Rellenamos el datawindows de pedidos pendientes por familia
sel = " select codigo, descripcion "+&
		" from familias "+&
		" where empresa =  '"+codigo_empresa+"' "+&
		" and codigo <>  '0' "+&
		" order by descripcion desc "
		
f_cargar_cursor_trans (SQLCA, sel, datos)
total_familias = datos.rowcount()

for i = 1 to total_familias
	cod_familia = datos.object.codigo[i]
	des_familia = datos.object.descripcion[i]
	pedidos_pendientes_familia = f_pedidos_pendientes_familia(codigo_empresa , cod_familia)
	dw_pedidos_pendientes_familia.object.familia[i] = des_familia
	dw_pedidos_pendientes_familia.object.pedidos_pdtes[i] = pedidos_pendientes_familia
next 

destroy datos
end subroutine

public subroutine f_objetivos_facturacion ();
end subroutine

public subroutine f_control3 (datawindow data);datastore ds_clientes, ds_familias
long i, fila_Actual
string sel1, cliente, v_empresa, agente1, cliente_codigo
date fecha1, fecha2, v_fpedido, fecha_ant1, fecha_ant2
integer dia1, mes1, anyo1, dia2, mes2, anyo2, v_anyo, v_pedido, v_linea
decimal v_importe, v_piezas, v_metros, v_importe2, v_piezas2, v_metros2
decimal importe1_wow = 0, importe2_wow = 0, porcentaje_wow = 0, porcentaje_total = 0
string familia
string pais = '%'

datetime fecha_fac1, fecha_fac2, fecha_fac_ant1, fecha_fac_ant2

if uo_familia.em_codigo.text = '' then
	familia = '%'
else
	familia = uo_familia.em_codigo.text
end if

data.settransobject(SQLCA)
data.reset()
data.retrieve(codigo_empresa, familia, pais)

dia1 = 01
mes1 = 01
anyo1 = year(today()) 

dia2 = day(today())
mes2 = month(today()) 
anyo2 = year(today()) 

fecha1 = Date ( anyo1, mes1, dia1)
//fecha1 = Date ( dia1, mes1, anyo1)
fecha2 = Date ( anyo2, mes2, dia2)
//fecha2 = Date ( dia2, mes2, anyo2)

dia1 = 01
mes1 = 01
anyo1 = year(today()) -1 

dia2 = day(today())
mes2 = month(today()) 
anyo2 = year(today()) - 1

fecha_ant1 = Date ( anyo1, mes1, dia1)
//fecha_ant1 = Date ( dia1, mes1, anyo1)

fecha_ant2 = Date ( anyo2, mes2, dia2)
//fecha_ant2 = Date ( dia2, mes2, anyo2)

data.object.ventas_actual_t.text =  string (year(today()))
data.object.ventas_anterior_t.text = string (year(today()) - 1)

/*
/*
sel1 = 	" SELECT venlifac.empresa, genter.codigo, genter.razon, Sum((venlifac.neto) / venlifac.cambio) as total, "+&
										" (SELECT Sum((b.neto) / b.cambio) "+&
										" FROM venlifac b , articulos ART"+&
										" WHERE  b.empresa = '"+codigo_empresa+"' "+&
										" AND b.cliente = genter.codigo "+&
										" AND b.empresa = ART.empresa"+&
										" AND b.articulo = ART.codigo "+&
										" AND ART.familia like '"+familia+"' "+&
										" AND b.ffactura >= '"+string(fecha_ant1)+"' "+&
										" AND b.ffactura <= '"+string(fecha_ant2)+"') as total2 "+&
			" FROM genter "+&
			" LEFT OUTER JOIN venlifac ON genter.codigo = venlifac.cliente and genter.empresa = venlifac.empresa "+&
			" LEFT OUTER JOIN articulos ON venlifac.empresa = articulos.empresa and venlifac.articulo = articulos.codigo "+&
			" WHERE  venlifac.empresa = '"+codigo_empresa+"' "+&
			" AND genter.tipoter = 'C' "+&
			" AND genter.empresa = '"+codigo_empresa+"' "+&
			" AND articulos.familia like '"+familia+"' "+&
			" AND venlifac.ffactura >= '"+string(fecha1)+"' "+&
			" AND venlifac.ffactura <= '"+string(fecha2)+"' "+&
			" GROUP BY venlifac.empresa, genter.codigo, genter.razon "+&
			" ORDER BY Sum((venlifac.neto) / venlifac.cambio) Desc "
			*/
sel1 = " select codigo, razon from genter where tipoter = 'C' and empresa = '"+codigo_empresa+"' "

f_cargar_cursor_nuevo (sel1, ds_clientes)

data.Setredraw(false)

for i = 1 to ds_clientes.rowcount()
	
	cliente = ds_clientes.object.razon[i]
	cliente_codigo = ds_clientes.object.codigo[i]
	
	fecha_fac1 = datetime (fecha1)
	fecha_fac2= datetime (fecha2)
	fecha_fac_ant1 = datetime (fecha_ant1)
	fecha_fac_ant2 = datetime (fecha_ant2)

	select Sum(venlifac.neto / venlifac.cambio) 
	into :v_importe
	from venlifac
	where venlifac.familia like :familia
	and cliente = :cliente_codigo
	AND venlifac.ffactura >= :fecha_fac1
	AND venlifac.ffactura <= :fecha_fac2;
	
	select Sum(venlifac.neto / venlifac.cambio) 
	into :v_importe2
	from venlifac
	where venlifac.familia like :familia
	and cliente = :cliente_codigo
	AND venlifac.ffactura >= :fecha_fac_ant1
	AND venlifac.ffactura <= :fecha_fac_ant2;
	
	if isnull(v_importe) then
		v_importe = 0
	end if
	
	if isnull(v_importe2) then
		v_importe2 = 0
	end if

	fila_actual = data.insertrow(0)
		
	data.object.cliente[fila_actual] = cliente
	data.object.importe[fila_actual] = v_importe
	data.object.importe2[fila_actual] = v_importe2
	
	f_mensaje_proceso ("Ventas Clientes:", i, ds_clientes.rowcount())
next

data.setsort("importe desc")
data.sort()
data.Setredraw(True)

destroy ds_clientes
*/

// Ahora calculamos los totales por familia en el otro datawindow
dw_totales_ventas_por_familia.reset()

sel1 = 	" SELECT venlifac.empresa, articulos.familia as familia, familias.descripcion, Sum((venlifac.neto) / venlifac.cambio) as total, "+&
										" (SELECT Sum((b.neto - b.impdtopp) / b.cambio) "+&
										" FROM venlifac b, articulos ART "+&
										" WHERE  b.empresa = '"+codigo_empresa+"' "+&
										" AND b.empresa = ART.empresa"+&
										" AND b.articulo = ART.codigo "+&
										" AND ART.familia = articulos.familia"+&
										" AND b.articulo <> ''"+&
										" and art.promocion <> 'S' "+&
										" AND b.ffactura >= '"+string(fecha_ant1)+"' "+&
										" AND b.ffactura <= '"+string(fecha_ant2)+"') as total2 "+&
			" FROM   venlifac "+&
			" LEFT OUTER JOIN articulos on venlifac.empresa = articulos.empresa  and venlifac.articulo = articulos.codigo  "+&
			" LEFT OUTER JOIN familias on articulos.empresa = familias.empresa and articulos.familia = familias.codigo "+&
			" WHERE  venlifac.empresa = '"+codigo_empresa+"' "+&
			" AND venlifac.ffactura >= '"+string(fecha1)+"' "+&
			" AND venlifac.ffactura <= '"+string(fecha2)+"' "+&
			" AND not (venlifac.articulo is null) "+&
			" AND venlifac.articulo <> ''"+&
			" and articulos.promocion <> 'S' "+&
			" GROUP BY venlifac.empresa, articulos.familia, familias.descripcion "+&
			" HAVING familias.descripcion <> '' " +&
			" ORDER BY Sum((venlifac.neto) / venlifac.cambio) Desc "

f_cargar_cursor_nuevo (sel1, ds_familias)

dw_totales_ventas_por_familia.Setredraw(false)

for i = 1 to ds_familias.rowcount()
	
	familia = ds_familias.object.familias_descripcion[i]
	v_importe = ds_familias.object.total[i]
	v_importe2 = ds_familias.object.total2[i]
	
	if isnull(v_importe) then
		v_importe = 0
	end if
	
	if isnull(v_importe2) then
		v_importe2 = 0
	end if

	fila_actual = dw_totales_ventas_por_familia.insertrow(0)
		
	dw_totales_ventas_por_familia.object.familia[fila_actual] = familia
	dw_totales_ventas_por_familia.object.importe1[fila_actual] = v_importe
	dw_totales_ventas_por_familia.object.importe2[fila_actual] = v_importe2
	
	f_mensaje_proceso ("Familia: ", i, ds_familias.rowcount())
	
next

//dw_totales_ventas_por_familia.setsort("Familia D")
dw_totales_ventas_por_familia.sort()

dw_totales_ventas_por_familia.Setredraw(True)
destroy ds_familias

end subroutine

public subroutine f_control4 ();datetime fecha1, fecha2, fecha3, fecha4
long anyo
string familia = '%', pais = '%' , cliente = '%'

//anyo = year(Today())
//fecha1 = datetime("01-01-"+string(anyo - 1) )
//fecha2 = datetime(Today())
//
//dw_resumen_pedidos_meses_anyos.Retrieve(codigo_empresa, '%', datetime(fecha1), datetime(fecha2), familia, pais)



anyo = year(Today())
fecha1 = datetime("01-01-"+string(anyo - 1) )
fecha2 = datetime(RelativeDate(Today(), -365))
fecha3 = datetime("01-01-"+string(anyo ) )
fecha4 = datetime(Today())

dw_resumen_pedidos_meses_anyos.Retrieve(codigo_empresa, cliente , datetime(fecha1), datetime(fecha2), datetime(fecha3), datetime(fecha4), familia, pais)
end subroutine

public subroutine f_control5 (datawindow datos);dec prev_rappel, porc_variable, fijos, personal, amortizaciones, resto_fijos, rai, cash, ventas, variable, valor_prod, margen_bruto, var_exist = 0

ventas = dw_informe.object.facturacion_previsible[1]

//dw_con_cuenta_resutlados_mini.reset()
datos.reset()
datos.insertrow(0)
datos.object.ventas[1] = ventas

select variable, prev_rappel, resto_fijos, personal, amortizaciones, valor_prod, margen_bruto
into :porc_variable, :prev_rappel, :resto_fijos, :personal, :amortizaciones, :valor_prod, :margen_bruto
from contamantctaresult
where empresa = :codigo_empresa
and rango = (select min(rango)
				from contamantctaresult
				where empresa = :codigo_empresa
				and rango >= :ventas);

if isnull(porc_variable) then porc_variable = 0
if isnull(prev_rappel) then prev_rappel = 0
if isnull(resto_fijos) then resto_fijos = 0
if isnull(personal) then personal = 0
if isnull(amortizaciones) then amortizaciones = 0

datos.object.prev_rappel[1] = prev_rappel
datos.object.personal[1] = personal
datos.object.amortizaciones[1] = amortizaciones
datos.object.resto_fijos[1] = resto_fijos
fijos =  resto_fijos + amortizaciones + personal
datos.object.fijos[1] = fijos

if margen_bruto <> 0 and not isnull(margen_bruto) then	
	var_exist = ((valor_prod - ventas) * (100 - margen_bruto)) / 100	
end if

datos.object.var_exist[1] = var_exist

if porc_variable <> 0 and not isnull(porc_variable) then
	variable = (( ventas + var_exist) * porc_variable) / 100
end if
datos.object.variable[1] = variable

rai = ventas + prev_rappel - variable - fijos + var_exist

datos.object.rai[1] = rai
datos.object.cash[1] = rai + amortizaciones


end subroutine

protected subroutine f_control2 ();string sel
datastore datos
long  fila, i
int anyo, anyo_anterior
string cod_familia
/*
long i, fila_Actual, m
string sel1, cliente, v_empresa, agente
date fecha1, fecha2, v_fpedido, fecha_ant1, fecha_ant2
integer dia1, mes1, anyo1, dia2, mes2, anyo2, v_anyo, v_pedido, v_linea
decimal v_importe, v_piezas, v_metros, v_importe2, v_piezas2, v_metros2, v_metros_lin, v_metros_lin2 
decimal importe1_wow = 0, importe2_wow = 0, porcentaje_wow = 0, porcentaje_total = 0
string cod_familia, des_familia, sel2
*/
/*
dia1 = 01
mes1 = 01
anyo1 = year(today()) 

dia2 = day(today())
mes2 = month(today()) 
anyo2 = year(today()) 

fecha1 = Date ( anyo1, mes1, dia1)
fecha2 = Date ( anyo2, mes2, dia2)

dia1 = 01
mes1 = 01
anyo1 = year(today()) -1 

dia2 = day(today())
mes2 = month(today()) 
anyo2 = year(today()) - 1

fecha_ant1 = Date ( anyo1, mes1, dia1)
fecha_ant2 = Date ( anyo2, mes2, dia2)
*/
//dw_pedidos_cliente_dos_anyos.object.actual.text =  string (year(today()))
//dw_pedidos_cliente_dos_anyos.object.Anterior.text = string (year(today()) - 1)

if uo_familia.em_codigo.text = '' then
	cod_familia = '%'
else
	cod_familia = uo_familia.em_codigo.text
end if

anyo = year(Today())
anyo_anterior = anyo - 1

sel = " select vista_venliped.cliente  "+&
 		" , genter.razon "+&
		"  , sum(case when vista_venliped.fpedido between  CONVERT (datetime, '01-01-'+CAST (year(getdate() )-1  AS VARCHAR(4)), 110) and dateadd ( year, -1, getdate())  "+&
		"  		then ( vista_venliped.neto - vista_venliped.impdtopp ) / vista_venliped.cambio "+&
		"  		else 0   "+&
		"  	end ) as pedidos_anterior  "+&
		"  , sum(case when vista_venliped.fpedido between  CONVERT (datetime, '01-01-'+CAST (year(getdate() )  AS VARCHAR(4)), 110) and  getdate()  "+&
		"  		then ( vista_venliped.neto - vista_venliped.impdtopp ) / vista_venliped.cambio "+&
		"  		else 0   "+&
		"  	end ) as pedidos_actual  "+&
		"  from (select cantidad, precio, dtoesp, dtoesp2, cambio, empresa, fpedido, articulo, familia, cliente, neto, impdtopp from vista_venliped where fpedido >= CONVERT (datetime, '01-01-'+CAST (year(getdate() )-1  AS VARCHAR(4)), 110)) as vista_venliped  "+&
		"  inner join (select empresa, codigo from articulos where familia like '"+cod_familia+"' and   articulos.promocion <> 'S' ) as articulos on vista_venliped.empresa = articulos.empresa and vista_venliped.articulo = articulos.codigo  "+&
		"  inner join genter on vista_venliped.cliente = genter.codigo and vista_venliped.empresa = genter.empresa  "+&
		"  where vista_venliped.empresa = '"+codigo_empresa+"' "+&
		"  and genter.tipoter = 'C' "+&
		"  group by vista_venliped.cliente, genter.razon "+&
		"  order by  pedidos_actual desc  "

f_cargar_cursor_trans (SQLCA, sel, datos)
dw_pedidos_cliente_dos_anyos.object.data = datos.object.data

destroy datos


sel = " select vista_venliped.familia "+&
 		" , familias.descripcion as fd"+&
		"  , sum(case when vista_venliped.fpedido between  CONVERT (datetime, '01-01-'+CAST (year(getdate() )-1  AS VARCHAR(4)), 110) and dateadd ( year, -1, getdate())  "+&
		"  		then (vista_venliped.cantidad * vista_venliped.precio * ( 1 -  vista_venliped.dtoesp / 100 ) * ( 1 -  vista_venliped.dtoesp2 / 100 ) ) / vista_venliped.cambio "+&
		"  		else 0   "+&
		"  	end ) as pedidos_anterior  "+&
		"  , sum(case when vista_venliped.fpedido between  CONVERT (datetime, '01-01-'+CAST (year(getdate() )  AS VARCHAR(4)), 110) and  getdate()  "+&
		"  		then (vista_venliped.cantidad * vista_venliped.precio * ( 1 -  vista_venliped.dtoesp / 100 ) * ( 1 -  vista_venliped.dtoesp2 / 100 ) ) / vista_venliped.cambio "+&
		"  		else 0   "+&
		"  	end ) as pedidos_actual  "+&
		"  from (select cantidad, precio, dtoesp, dtoesp2, cambio, empresa, fpedido, articulo, familia, cliente, neto, impdtopp from vista_venliped where fpedido >= CONVERT (datetime, '01-01-'+CAST (year(getdate() )-1  AS VARCHAR(4)), 110)) as vista_venliped  "+&
		"  inner join (select empresa, codigo from articulos where familia is not null   and   articulos.promocion <> 'S' ) as articulos on vista_venliped.empresa = articulos.empresa and vista_venliped.articulo = articulos.codigo  "+&
		"  inner join familias on vista_venliped.familia = familias.codigo and vista_venliped.empresa = familias.empresa  "+&
		"  group by vista_venliped.familia, familias.descripcion "+&
		"  order by  pedidos_actual desc "

f_cargar_cursor_trans (SQLCA, sel, datos)

for i = 1 to datos.rowcount()
	fila = dw_totales_pedidos_por_familia.insertrow(0)
	dw_totales_pedidos_por_familia.object.familia[fila] = datos.object.fd[i]
	dw_totales_pedidos_por_familia.object.importe2[fila] = datos.object.pedidos_anterior[i]
	dw_totales_pedidos_por_familia.object.importe1[fila] = datos.object.pedidos_actual[i]

next

destroy datos

//dw_totales_pedidos_por_familia.setsort("Familia D")
dw_totales_pedidos_por_familia.sort()
end subroutine

public subroutine f_pedidos_por_cliente_hoy ();string sel
datastore datos

dw_pedidos_por_cliente_hoy.Reset()

sel = " select  venliped.cliente  "+&
		"  		, genter.razon  "+&
		" 		, sum (( venliped.neto - venliped.impdtopp ) / venped.cambio ) as pedidos "+&
		" 	from venliped   "+&
		" 	inner join venped  "+&
		" 				on venliped.empresa = venped.empresa  "+&
		" 				and venliped.anyo = venped.anyo  "+&
		" 				and venliped.pedido = venped.pedido  "+& 
		" 	inner join articulos  "+&
		" 				on venliped.empresa = articulos.empresa  "+&
		" 				and venliped.articulo = articulos.codigo   "+&
		" 	inner join genter  "+&
		" 				on venliped.cliente = genter.codigo  "+&
		" 				and venliped.empresa = genter.empresa   "+&
		" 	where venliped.empresa = '1' "+&
		" 	and genter.tipoter = 'C'  "+&
		" 	and venped.es_proforma <> 'S' "+&
		" 	and venliped.bloqueado <> 'S' "+&
		" 	and venliped.articulo <> '' "+&
		" 	and venliped.articulo is not null "+&
		"  and articulos.promocion <> 'S' "+&
		" 	and CAST(venliped.fecha_intr AS date)= CAST(getdate() AS date) "+&
		" 	group by  venliped.cliente  "+&
		"				, genter.razon  "+&
		" 	order by pedidos desc "
		
//		" 	and articulos.promocion <> 'S' "+&

//select sum(venliped.importe/ venped.cambio)
//into :pedidos_hoy
//from venliped, venped 
//where venliped.empresa = :codigo_empresa 
//and venliped.empresa = venped.empresa
//and venliped.anyo = venped.anyo
//and venliped.pedido = venped.pedido 
//and venped.es_proforma = 'N' 
//and venliped.fecha_intr >= :hoy AND venliped.fecha_intr <= :ahora
//and venliped.bloqueado = '0'
//and venliped.articulo <> '' 
//and venliped.articulo is not null ;		

f_cargar_cursor_trans (SQLCA, sel, datos)

if datos.rowcount() > 0 then
	dw_pedidos_por_cliente_hoy.object.data = datos.object.data
end if

destroy datos


end subroutine

public function decimal f_valor_planificado (string subcontratado);dec {2} importe
datetime fecha_desde

fecha_desde = datetime (relativedate (today(), - 365))

select sum (importe) 
into :importe
from
 ( select planificacion.cantidad , 
		planificacion.cod_articulo, 
		articulos.descripcion, 
		 formatos.abreviado, 
		 ( case when articulos.unidad  = 0 then planificacion.cantidad 
		 else ( (cantidad * ((formatos.ancho * formatos.largo) /10000) ) ) END ) * 
				( CASE WHEN ( select min(ventarifas_precios_packs.precio) 
						 from ventarifas_precios_packs  
						 where empresa = planificacion.empresa  
						 and ventarifas_precios_packs.articulos_codigo = planificacion.art_encajado  
						 and ventarifas_codigo <> '5')  <> 0 
						 OR  
						 ( select min(ventarifas_precios_packs.precio) 
						 from ventarifas_precios_packs  
						 where empresa = planificacion.empresa  
						 and ventarifas_precios_packs.articulos_codigo = planificacion.art_encajado  
						 and ventarifas_codigo <> '5')  IS NOT NULL 
					THEN ( select min(ventarifas_precios_packs.precio) 
						 from ventarifas_precios_packs  
						 where empresa = planificacion.empresa  
						 and ventarifas_precios_packs.articulos_codigo = planificacion.art_encajado  
						 and ventarifas_codigo <> '5') 
					ELSE   
						( select min(ventarifas_precios.precio) 
						 from ventarifas_precios  
						 where empresa = planificacion.empresa  
						 and ventarifas_precios.articulos_codigo = planificacion.art_encajado  
						 and ventarifas_codigo <> '5') 
					END 
				 ) AS IMPORTE2, 
 		( case when articulos.unidad  = 0 then planificacion.cantidad
 		else ( ( planificacion.cantidad * ((formatos.ancho * formatos.largo) /10000) ) ) END ) * 
				( CASE   
					WHEN ( select sum( ( (venlifac.neto - venlifac.impdtopp) / venlifac.cambio )) / NULLIF (sum (venlifac.cantidad), 0 )  
							 from venlifac  
							 inner join articulos on venlifac.empresa = articulos.empresa and venlifac.articulo = articulos.codigo  
							 where venlifac.empresa = :codigo_empresa
							 and venlifac.articulo  =  planificacion.cod_articulo  
							 and venlifac.tipo_unidad  =  articulos.unidad  
							 and venlifac.ffactura >= :fecha_desde ) > 0  
					THEN ( select sum( ( (venlifac.neto - venlifac.impdtopp) / venlifac.cambio )) / NULLIF (sum (venlifac.cantidad), 0 )  
							 from venlifac  
							 inner join articulos on venlifac.empresa = articulos.empresa and venlifac.articulo = articulos.codigo  
							 where venlifac.empresa =:codigo_empresa
							 and venlifac.articulo  =  planificacion.cod_articulo   
							 and venlifac.tipo_unidad  =  articulos.unidad  
							 and venlifac.ffactura >= :fecha_desde )  
					WHEN ( select min(ventarifas_precios_packs.precio)   
				 		from ventarifas_precios_packs    
				 		where empresa = planificacion.empresa    
				 		and ventarifas_precios_packs.articulos_codigo = planificacion.art_encajado    
				 		and ventarifas_codigo <> '5')  <> 0   
				 		OR    
				 		( select min(ventarifas_precios_packs.precio)   
						from ventarifas_precios_packs    
						where empresa = planificacion.empresa    
				 		and ventarifas_precios_packs.articulos_codigo = planificacion.art_encajado    
				 		and ventarifas_codigo <> '5')  IS NOT NULL   
					THEN ( select min(ventarifas_precios_packs.precio)   
						from ventarifas_precios_packs    
				 		where empresa = planificacion.empresa    
				 		and ventarifas_precios_packs.articulos_codigo = planificacion.cod_articulo    
				 		and ventarifas_codigo <> '5')   
					ELSE     
						( select min(ventarifas_precios.precio)   
						from ventarifas_precios    
						where empresa = planificacion.empresa    
						and ventarifas_precios.articulos_codigo = planificacion.art_encajado    
				 		and ventarifas_codigo <> '5')   
				END   
		 ) AS IMPORTE 
		 from planificacion , formatos, prodlineas,  art_ver_operaciones, articulos 
		 where planificacion.empresa =:codigo_empresa
		 and formatos.empresa =  :codigo_empresa
		 and prodlineas.empresa = :codigo_empresa
		 and prodlineas.subcontratacion like :subcontratado
		 and art_ver_operaciones.empresa = :codigo_empresa
		 and planificacion.empresa = articulos.empresa 
		 and planificacion.cod_articulo = articulos.codigo 
		 and planificacion.cod_articulo = art_ver_operaciones.articulo 
		 and planificacion.version = art_ver_operaciones.version 
		 and planificacion.ordenoperacion = art_ver_operaciones.orden 
		 and planificacion.ajuste <> 'S' 
		 and planificacion.lineaprod = prodlineas.codigo 
		 and planificacion.formato = formatos.codigo 
//		 and articulos.familia  = '2'
		 and articulos.uso = '3' ) as valor_produccion;
		 
		 
return importe		 
end function

public function decimal f_valor_stock_wow (string arg_familia);dec {2} importe
datetime fecha_desde

fecha_desde = datetime (relativedate (today(), - 365))

select sum (importe) 
into :importe
from
 ( select vista_almacen.cantidad , 
			vista_almacen.articulo, 
			articulos.descripcion, 
		 formatos.abreviado, 
//		 ( case when articulos.unidad  = 0 then vista_almacen.cantidad 
//		 else ( (cantidad * ((formatos.ancho * formatos.largo) /10000) ) ) END ) * 
//				( CASE WHEN ( select min(ventarifas_precios_packs.precio) 
//						 from ventarifas_precios_packs  
//						 where empresa = vista_almacen.empresa  
//						 and ventarifas_precios_packs.articulos_codigo = vista_almacen.articulo  
//						 and ventarifas_codigo <> '5')  <> 0 
//						 OR  
//						 ( select min(ventarifas_precios_packs.precio) 
//						 from ventarifas_precios_packs  
//						 where empresa = vista_almacen.empresa  
//						 and ventarifas_precios_packs.articulos_codigo = vista_almacen.articulo  
//						 and ventarifas_codigo <> '5')  IS NOT NULL 
//					THEN ( select min(ventarifas_precios_packs.precio) 
//						 from ventarifas_precios_packs  
//						 where empresa = vista_almacen.empresa  
//						 and ventarifas_precios_packs.articulos_codigo = vista_almacen.articulo  
//						 and ventarifas_codigo <> '5') 
//					ELSE   
//						( select min(ventarifas_precios.precio) 
//						 from ventarifas_precios  
//						 where empresa = vista_almacen.empresa  
//						 and ventarifas_precios.articulos_codigo = vista_almacen.articulo  
//						 and ventarifas_codigo <> '5') 
//					END 
//				 ) AS IMPORTE2, 
 		( case when articulos.unidad  = 0 then vista_almacen.cantidad
 		else ( ( vista_almacen.cantidad * ((formatos.ancho * formatos.largo) /10000) ) ) END ) * 
				( CASE   
					WHEN ( select sum( ( (venlifac.neto - venlifac.impdtopp) / venlifac.cambio )) / NULLIF (sum (venlifac.cantidad), 0 )  
							 from venlifac  
							 inner join articulos on venlifac.empresa = articulos.empresa and venlifac.articulo = articulos.codigo  
							 where venlifac.empresa = '1'
							 and venlifac.articulo  =  vista_almacen.articulo  
							 and venlifac.tipo_unidad  =  articulos.unidad  
							 and venlifac.ffactura >= '08-11-2017' ) > 0  
					THEN ( select sum( ( (venlifac.neto - venlifac.impdtopp) / venlifac.cambio )) / NULLIF (sum (venlifac.cantidad), 0 )  
							 from venlifac  
							 inner join articulos on venlifac.empresa = articulos.empresa and venlifac.articulo = articulos.codigo  
							 where venlifac.empresa = '1'
							 and venlifac.articulo  =  vista_almacen.articulo   
							 and venlifac.tipo_unidad  =  articulos.unidad  
							 and venlifac.ffactura >= '08-11-2017' )  
					WHEN ( select min(ventarifas_precios_packs.precio)   
				 		from ventarifas_precios_packs    
				 		where empresa = vista_almacen.empresa    
				 		and ventarifas_precios_packs.articulos_codigo = vista_almacen.articulo    
				 		and ventarifas_codigo <> '5')  <> 0   
				 		OR    
				 		( select min(ventarifas_precios_packs.precio)   
						from ventarifas_precios_packs    
						where empresa = vista_almacen.empresa    
				 		and ventarifas_precios_packs.articulos_codigo = vista_almacen.articulo    
				 		and ventarifas_codigo <> '5')  IS NOT NULL   
					THEN ( select min(ventarifas_precios_packs.precio)   
						from ventarifas_precios_packs    
				 		where empresa = vista_almacen.empresa    
				 		and ventarifas_precios_packs.articulos_codigo = vista_almacen.articulo    
				 		and ventarifas_codigo <> '5')   
					ELSE     
						( select min(ventarifas_precios.precio)   
						from ventarifas_precios    
						where empresa = vista_almacen.empresa    
						and ventarifas_precios.articulos_codigo = vista_almacen.articulo    
				 		and ventarifas_codigo <> '5')   
				END   
		 ) AS IMPORTE 
		 from vista_almacen , formatos, articulos 
		 where vista_almacen.empresa = '1'
		 and formatos.empresa =  '1'
		 and vista_almacen.empresa = articulos.empresa 
		 and articulos.promocion <> 'S'
		 and articulos.familia = :arg_familia
		 and vista_almacen.articulo = articulos.codigo 
		 and articulos.formato = formatos.codigo 
		 and articulos.uso = '3' ) as valor_stock;
		 
		 
return importe		 
end function

public function decimal f_ventas_mensuales_wow (string arg_familia);dec {2} importe
datetime fecha_desde

fecha_desde = datetime (relativedate (today(), - 180))

 SELECT Sum((venlifac.neto) / venlifac.cambio) / 6 as total 
 into :importe
 FROM   venlifac 
 LEFT OUTER JOIN articulos on venlifac.empresa = articulos.empresa  and venlifac.articulo = articulos.codigo  
 WHERE  venlifac.empresa = :codigo_empresa
 AND venlifac.ffactura >= :fecha_desde
 and articulos.familia = :arg_familia;

	 
return importe		 
end function

event close;call super::close;dw_informe.reset()

end event

event open;call super::open;string mes

istr_parametros.s_titulo_ventana="Cuadro de Mando"
This.title=istr_parametros.s_titulo_ventana


dw_resumen_pedidos_meses_anyos.SetTransObject(SQLCA)
dw_precio_medio_por_anyos.SetTransObject(SQLCA)
dw_seguimiento_objetivos_generales.SetTransObject(SQLCA)
dw_totales_ventas_por_familia.SetTransObject(SQLCA)
dw_totales_pedidos_por_familia.SetTransObject(SQLCA)
dw_pedidos_cliente_dos_anyos.SetTransObject(SQLCA)
dw_pedidos_por_cliente_hoy.SetTransObject(SQLCA)


end event

on w_cuadro_mando.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.cb_1=create cb_1
this.st_1=create st_1
this.cbx_ventas=create cbx_ventas
this.cbx_pedidos=create cbx_pedidos
this.dw_resumen_pedidos_meses_anyos=create dw_resumen_pedidos_meses_anyos
this.cbx_pedidos_meses=create cbx_pedidos_meses
this.st_2=create st_2
this.dw_precio_medio_por_anyos=create dw_precio_medio_por_anyos
this.st_3=create st_3
this.cbx_precio_medio=create cbx_precio_medio
this.dw_seguimiento_objetivos_generales=create dw_seguimiento_objetivos_generales
this.cbx_seguimiento_objetivos=create cbx_seguimiento_objetivos
this.cbx_cta_resultados=create cbx_cta_resultados
this.uo_familia=create uo_familia
this.gb_8=create gb_8
this.dw_detalle2=create dw_detalle2
this.dw_totales_ventas_por_familia=create dw_totales_ventas_por_familia
this.dw_totales_pedidos_por_familia=create dw_totales_pedidos_por_familia
this.dw_pedidos_cliente_dos_anyos=create dw_pedidos_cliente_dos_anyos
this.dw_pedidos_por_cliente_hoy=create dw_pedidos_por_cliente_hoy
this.r_1=create r_1
this.dw_informe=create dw_informe
this.dw_pedidos_pendientes_familia=create dw_pedidos_pendientes_familia
this.st_4=create st_4
this.st_valor_stock_wow=create st_valor_stock_wow
this.st_5=create st_5
this.st_meses_stock_wow=create st_meses_stock_wow
this.st_6=create st_6
this.st_7=create st_7
this.dw_con_cuenta_resutlados_mini=create dw_con_cuenta_resutlados_mini
this.p_informacion=create p_informacion
this.st_8=create st_8
this.st_valor_stock_dna=create st_valor_stock_dna
this.st_10=create st_10
this.st_meses_stock_dna=create st_meses_stock_dna
this.st_12=create st_12
this.st_13=create st_13
this.r_2=create r_2
this.r_3=create r_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.cbx_ventas
this.Control[iCurrent+6]=this.cbx_pedidos
this.Control[iCurrent+7]=this.dw_resumen_pedidos_meses_anyos
this.Control[iCurrent+8]=this.cbx_pedidos_meses
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.dw_precio_medio_por_anyos
this.Control[iCurrent+11]=this.st_3
this.Control[iCurrent+12]=this.cbx_precio_medio
this.Control[iCurrent+13]=this.dw_seguimiento_objetivos_generales
this.Control[iCurrent+14]=this.cbx_seguimiento_objetivos
this.Control[iCurrent+15]=this.cbx_cta_resultados
this.Control[iCurrent+16]=this.uo_familia
this.Control[iCurrent+17]=this.gb_8
this.Control[iCurrent+18]=this.dw_detalle2
this.Control[iCurrent+19]=this.dw_totales_ventas_por_familia
this.Control[iCurrent+20]=this.dw_totales_pedidos_por_familia
this.Control[iCurrent+21]=this.dw_pedidos_cliente_dos_anyos
this.Control[iCurrent+22]=this.dw_pedidos_por_cliente_hoy
this.Control[iCurrent+23]=this.r_1
this.Control[iCurrent+24]=this.dw_informe
this.Control[iCurrent+25]=this.dw_pedidos_pendientes_familia
this.Control[iCurrent+26]=this.st_4
this.Control[iCurrent+27]=this.st_valor_stock_wow
this.Control[iCurrent+28]=this.st_5
this.Control[iCurrent+29]=this.st_meses_stock_wow
this.Control[iCurrent+30]=this.st_6
this.Control[iCurrent+31]=this.st_7
this.Control[iCurrent+32]=this.dw_con_cuenta_resutlados_mini
this.Control[iCurrent+33]=this.p_informacion
this.Control[iCurrent+34]=this.st_8
this.Control[iCurrent+35]=this.st_valor_stock_dna
this.Control[iCurrent+36]=this.st_10
this.Control[iCurrent+37]=this.st_meses_stock_dna
this.Control[iCurrent+38]=this.st_12
this.Control[iCurrent+39]=this.st_13
this.Control[iCurrent+40]=this.r_2
this.Control[iCurrent+41]=this.r_3
end on

on w_cuadro_mando.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.cbx_ventas)
destroy(this.cbx_pedidos)
destroy(this.dw_resumen_pedidos_meses_anyos)
destroy(this.cbx_pedidos_meses)
destroy(this.st_2)
destroy(this.dw_precio_medio_por_anyos)
destroy(this.st_3)
destroy(this.cbx_precio_medio)
destroy(this.dw_seguimiento_objetivos_generales)
destroy(this.cbx_seguimiento_objetivos)
destroy(this.cbx_cta_resultados)
destroy(this.uo_familia)
destroy(this.gb_8)
destroy(this.dw_detalle2)
destroy(this.dw_totales_ventas_por_familia)
destroy(this.dw_totales_pedidos_por_familia)
destroy(this.dw_pedidos_cliente_dos_anyos)
destroy(this.dw_pedidos_por_cliente_hoy)
destroy(this.r_1)
destroy(this.dw_informe)
destroy(this.dw_pedidos_pendientes_familia)
destroy(this.st_4)
destroy(this.st_valor_stock_wow)
destroy(this.st_5)
destroy(this.st_meses_stock_wow)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.dw_con_cuenta_resutlados_mini)
destroy(this.p_informacion)
destroy(this.st_8)
destroy(this.st_valor_stock_dna)
destroy(this.st_10)
destroy(this.st_meses_stock_dna)
destroy(this.st_12)
destroy(this.st_13)
destroy(this.r_2)
destroy(this.r_3)
end on

event ue_f5;f_control(dw_informe)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_cuadro_mando
integer y = 612
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_cuadro_mando
end type

type st_empresa from w_int_con_empresa`st_empresa within w_cuadro_mando
integer x = 14
integer y = 8
integer width = 4507
integer height = 76
end type

type pb_1 from upb_salir within w_cuadro_mando
integer x = 6395
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type pb_2 from upb_imprimir within w_cuadro_mando
integer x = 6272
integer taborder = 0
end type

event clicked;//f_control(dw_informe)
f_imprimir_datawindow(dw_informe)

end event

type cb_1 from commandbutton within w_cuadro_mando
integer x = 5952
integer width = 302
integer height = 96
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Continuar"
end type

event clicked;datetime fecha

dw_totales_pedidos_por_familia.Reset()
dw_pedidos_cliente_dos_anyos.Reset()

f_control(dw_informe)

if cbx_precio_medio.checked then	
	fecha = datetime("01-01-"+string(year(today()) - 10))
	dw_precio_medio_por_anyos.retrieve(codigo_empresa, '%', fecha, datetime(today()) )
end if

if cbx_pedidos_meses.checked then
	f_control4()
end if

if cbx_seguimiento_objetivos.checked then
	dw_seguimiento_objetivos_generales.retrieve(codigo_empresa, year(today()), month(today()))
end if

if cbx_ventas.checked then
	f_control3 (dw_detalle2)
end if

if cbx_pedidos.checked then
	f_control2 ()
end if

if cbx_cta_resultados.checked then
	f_control5 (dw_con_cuenta_resutlados_mini)
end if

f_pedidos_por_cliente_hoy()
end event

type st_1 from statictext within w_cuadro_mando
integer x = 14
integer y = 104
integer width = 882
integer height = 100
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Narrow"
long textcolor = 33554432
long backcolor = 553648127
string text = "Cuadro de Mando"
boolean focusrectangle = false
end type

type cbx_ventas from checkbox within w_cuadro_mando
integer x = 3145
integer y = 124
integer width = 686
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 24076881
long backcolor = 553648127
string text = "Comp. Ventas Clientes"
end type

type cbx_pedidos from checkbox within w_cuadro_mando
integer x = 3840
integer y = 124
integer width = 709
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 24076881
long backcolor = 553648127
string text = "Comp. Pedidos Clientes"
end type

type dw_resumen_pedidos_meses_anyos from datawindow within w_cuadro_mando
integer x = 2002
integer y = 3428
integer width = 4873
integer height = 368
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_resumen_pedidos_meses_anyos"
boolean livescroll = true
end type

type cbx_pedidos_meses from checkbox within w_cuadro_mando
integer x = 2546
integer y = 124
integer width = 603
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 24076881
long backcolor = 553648127
string text = "Pedidos por Meses"
boolean checked = true
end type

type st_2 from statictext within w_cuadro_mando
integer x = 2002
integer y = 3368
integer width = 4873
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 134217741
string text = "Comparativa de Pedidos por Meses"
boolean border = true
boolean focusrectangle = false
end type

type dw_precio_medio_por_anyos from datawindow within w_cuadro_mando
integer x = 2002
integer y = 3160
integer width = 2455
integer height = 192
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "dw_precio_medio_por_anyos"
boolean livescroll = true
end type

type st_3 from statictext within w_cuadro_mando
integer x = 2126
integer y = 3084
integer width = 2327
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 134217741
string text = "Precio Medio Por Año"
boolean border = true
boolean focusrectangle = false
end type

type cbx_precio_medio from checkbox within w_cuadro_mando
integer x = 2085
integer y = 124
integer width = 448
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 24076881
long backcolor = 553648127
string text = "Precio Medio"
end type

type dw_seguimiento_objetivos_generales from datawindow within w_cuadro_mando
integer x = 1966
integer y = 296
integer width = 1573
integer height = 1240
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "dw_seguimiento_objetivos_generales"
boolean border = false
boolean livescroll = true
end type

type cbx_seguimiento_objetivos from checkbox within w_cuadro_mando
integer x = 1417
integer y = 124
integer width = 654
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 24076881
long backcolor = 553648127
string text = "Seguimiento objetivos"
end type

type cbx_cta_resultados from checkbox within w_cuadro_mando
integer x = 914
integer y = 124
integer width = 494
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 24076881
long backcolor = 553648127
string text = "Cta Resultados"
end type

type uo_familia from u_em_campo_2 within w_cuadro_mando
event destroy ( )
integer x = 5938
integer y = 160
integer width = 571
integer height = 72
integer taborder = 90
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

type gb_8 from groupbox within w_cuadro_mando
integer x = 5925
integer y = 112
integer width = 613
integer height = 140
integer taborder = 260
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Familia"
end type

type dw_detalle2 from datawindow within w_cuadro_mando
integer x = 4475
integer y = 272
integer width = 2395
integer height = 1020
integer taborder = 40
string title = "none"
string dataobject = "dw_ventas_cliente_dos_anyos"
boolean vscrollbar = true
boolean livescroll = true
end type

type dw_totales_ventas_por_familia from datawindow within w_cuadro_mando
integer x = 4475
integer y = 1296
integer width = 2400
integer height = 428
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "dw_totales_ventas_por_familia"
boolean vscrollbar = true
boolean livescroll = true
end type

type dw_totales_pedidos_por_familia from datawindow within w_cuadro_mando
integer x = 4475
integer y = 2904
integer width = 2405
integer height = 452
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "dw_totales_pedidos_por_familia"
boolean vscrollbar = true
boolean livescroll = true
end type

type dw_pedidos_cliente_dos_anyos from datawindow within w_cuadro_mando
integer x = 4475
integer y = 1728
integer width = 2400
integer height = 1168
integer taborder = 140
boolean bringtotop = true
string title = "none"
string dataobject = "dw_pedidos_cliente_dos_anyos"
boolean vscrollbar = true
boolean livescroll = true
end type

type dw_pedidos_por_cliente_hoy from datawindow within w_cuadro_mando
integer x = 18
integer y = 2412
integer width = 1961
integer height = 1380
integer taborder = 130
boolean bringtotop = true
string title = "none"
string dataobject = "dw_pedidos_por_cliente_hoy"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type r_1 from rectangle within w_cuadro_mando
integer linethickness = 4
long fillcolor = 16777215
integer x = 1193
integer y = 272
integer width = 3259
integer height = 1296
end type

type dw_informe from datawindow within w_cuadro_mando
integer x = 23
integer y = 272
integer width = 1143
integer height = 2132
string dataobject = "dw_cuadro_mando"
boolean livescroll = true
end type

type dw_pedidos_pendientes_familia from datawindow within w_cuadro_mando
integer x = 2011
integer y = 1580
integer width = 2441
integer height = 476
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "dw_pedidos_pendientes_familia"
boolean vscrollbar = true
boolean livescroll = true
end type

type st_4 from statictext within w_cuadro_mando
integer x = 1285
integer y = 1620
integer width = 539
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 22563898
string text = "Valor Stock WOW"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_valor_stock_wow from statictext within w_cuadro_mando
integer x = 1344
integer y = 1716
integer width = 361
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 22563898
long backcolor = 16777215
alignment alignment = right!
boolean focusrectangle = false
end type

type st_5 from statictext within w_cuadro_mando
integer x = 1285
integer y = 1796
integer width = 539
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 22563898
string text = "Meses Stock WOW"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_meses_stock_wow from statictext within w_cuadro_mando
integer x = 1353
integer y = 1892
integer width = 210
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 22563898
long backcolor = 16777215
alignment alignment = right!
boolean focusrectangle = false
end type

type st_6 from statictext within w_cuadro_mando
integer x = 1719
integer y = 1716
integer width = 41
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 22563898
long backcolor = 16777215
string text = "€"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_7 from statictext within w_cuadro_mando
integer x = 1586
integer y = 1892
integer width = 187
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 22563898
long backcolor = 16777215
string text = "Meses"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_con_cuenta_resutlados_mini from datawindow within w_cuadro_mando
integer x = 2007
integer y = 2064
integer width = 2446
integer height = 1008
integer taborder = 30
string title = "none"
string dataobject = "dw_con_cuenta_resutlados_mini"
boolean livescroll = true
end type

type p_informacion from picture within w_cuadro_mando
integer x = 2016
integer y = 3080
integer width = 91
integer height = 72
boolean bringtotop = true
string picturename = "C:\Fuentes_tencer_PB12\Information_16x16.png"
boolean focusrectangle = false
string powertiptext = "Promoción excluída.  Incluye todos los dtos menos dto pronto pago.  Incluye los pedidos vendidos en piezas."
end type

type st_8 from statictext within w_cuadro_mando
integer x = 1285
integer y = 2036
integer width = 539
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 22563898
string text = "Valor Stock DNA"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_valor_stock_dna from statictext within w_cuadro_mando
integer x = 1344
integer y = 2132
integer width = 361
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 22563898
long backcolor = 16777215
alignment alignment = right!
boolean focusrectangle = false
end type

type st_10 from statictext within w_cuadro_mando
integer x = 1285
integer y = 2216
integer width = 539
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 22563898
string text = "Meses Stock DNA"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_meses_stock_dna from statictext within w_cuadro_mando
integer x = 1353
integer y = 2312
integer width = 210
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 22563898
long backcolor = 16777215
alignment alignment = right!
boolean focusrectangle = false
end type

type st_12 from statictext within w_cuadro_mando
integer x = 1719
integer y = 2132
integer width = 41
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 22563898
long backcolor = 16777215
string text = "€"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_13 from statictext within w_cuadro_mando
integer x = 1586
integer y = 2312
integer width = 187
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 22563898
long backcolor = 16777215
string text = "Meses"
alignment alignment = right!
boolean focusrectangle = false
end type

type r_2 from rectangle within w_cuadro_mando
integer linethickness = 4
long fillcolor = 16777215
integer x = 1198
integer y = 1580
integer width = 786
integer height = 396
end type

type r_3 from rectangle within w_cuadro_mando
integer linethickness = 4
long fillcolor = 16777215
integer x = 1198
integer y = 2000
integer width = 786
integer height = 404
end type

