$PBExportHeader$w_cuadro_mando_familias.srw
$PBExportComments$Informe de Objetivos de Facturación
forward
global type w_cuadro_mando_familias from w_int_con_empresa
end type
type pb_1 from upb_salir within w_cuadro_mando_familias
end type
type pb_2 from upb_imprimir within w_cuadro_mando_familias
end type
type cb_1 from commandbutton within w_cuadro_mando_familias
end type
type dw_ventas_coleccion_familia from datawindow within w_cuadro_mando_familias
end type
type dw_ventas_paises_dos_periodos from datawindow within w_cuadro_mando_familias
end type
type dw_precio_medio_anyos_fac from datawindow within w_cuadro_mando_familias
end type
type st_2 from statictext within w_cuadro_mando_familias
end type
type dw_resumen_pedidos_meses_anyos from datawindow within w_cuadro_mando_familias
end type
type st_3 from statictext within w_cuadro_mando_familias
end type
type dw_pedidos_cliente_dos_anyos from datawindow within w_cuadro_mando_familias
end type
type uo_pais from u_em_campo_2 within w_cuadro_mando_familias
end type
type gb_1 from groupbox within w_cuadro_mando_familias
end type
type dw_ventas_cliente_dos_anyos from datawindow within w_cuadro_mando_familias
end type
type uo_cliente from u_em_campo_2 within w_cuadro_mando_familias
end type
type dw_porcentaje_promo_sobre_vtas from datawindow within w_cuadro_mando_familias
end type
type dw_pedidos_por_cliente_hoy from datawindow within w_cuadro_mando_familias
end type
type dw_clientes_activos_por_anyos from datawindow within w_cuadro_mando_familias
end type
type gb_3 from groupbox within w_cuadro_mando_familias
end type
type st_1 from statictext within w_cuadro_mando_familias
end type
type dw_seguimiento_objetivos_familias from datawindow within w_cuadro_mando_familias
end type
type uo_familia from u_em_campo_2 within w_cuadro_mando_familias
end type
type p_informacion from picture within w_cuadro_mando_familias
end type
type gb_8 from groupbox within w_cuadro_mando_familias
end type
end forward

global type w_cuadro_mando_familias from w_int_con_empresa
integer x = 5
integer y = 4
integer width = 7515
integer height = 3940
long backcolor = 33554431
pb_1 pb_1
pb_2 pb_2
cb_1 cb_1
dw_ventas_coleccion_familia dw_ventas_coleccion_familia
dw_ventas_paises_dos_periodos dw_ventas_paises_dos_periodos
dw_precio_medio_anyos_fac dw_precio_medio_anyos_fac
st_2 st_2
dw_resumen_pedidos_meses_anyos dw_resumen_pedidos_meses_anyos
st_3 st_3
dw_pedidos_cliente_dos_anyos dw_pedidos_cliente_dos_anyos
uo_pais uo_pais
gb_1 gb_1
dw_ventas_cliente_dos_anyos dw_ventas_cliente_dos_anyos
uo_cliente uo_cliente
dw_porcentaje_promo_sobre_vtas dw_porcentaje_promo_sobre_vtas
dw_pedidos_por_cliente_hoy dw_pedidos_por_cliente_hoy
dw_clientes_activos_por_anyos dw_clientes_activos_por_anyos
gb_3 gb_3
st_1 st_1
dw_seguimiento_objetivos_familias dw_seguimiento_objetivos_familias
uo_familia uo_familia
p_informacion p_informacion
gb_8 gb_8
end type
global w_cuadro_mando_familias w_cuadro_mando_familias

type variables

end variables

forward prototypes
public subroutine f_objetivos_facturacion ()
public subroutine f_ventas_paises (string familia)
public subroutine f_ventas_clientes_dos_anyos (string familia, string pais)
public subroutine f_pedidos_clientes_dos_anyos (string familia, string pais)
public subroutine f_ventas_coleccion_familia (string familia, string pais, string cliente)
public subroutine f_comparativa_pedidos_anyos (string familia, string pais, string cliente)
public subroutine f_promocion_sobre_ventas (string familia, string pais, string cliente)
public subroutine f_clientes_activos_por_anyos (string familia, string pais, string cliente)
public subroutine f_pedidos_por_cliente_hoy (string familia, string pais)
end prototypes

public subroutine f_objetivos_facturacion ();
end subroutine

public subroutine f_ventas_paises (string familia);string sel
datastore datos
int anyo, anyo_anterior

anyo = year(Today())
anyo_anterior = anyo - 1
	
sel = " select venlifac.pais "+&
" , paises.nombre "+&
" , sum(case when venlifac.ffactura between  CONVERT (datetime, '01-01-'+CAST (year(getdate() )-1  AS VARCHAR(4)), 110) and dateadd ( year, -1, getdate()) "+&
" 		then (venlifac.neto - venlifac.impdtopp) / venlifac.cambio "+&
" 		else 0  "+&
" 	end ) as ventas_anterior "+&
" , sum(case when venlifac.ffactura between  CONVERT (datetime, '01-01-'+CAST (year(getdate() )  AS VARCHAR(4)), 110) and  getdate() "+&
" 		then (venlifac.neto - venlifac.impdtopp) / venlifac.cambio "+&
" 		else 0  "+&
" 	end ) as ventas_actual "+&
" from venlifac "+&
" inner join articulos on venlifac.empresa = articulos.empresa and venlifac.articulo = articulos.codigo "+&
" inner join paises on venlifac.pais = paises.pais "+&
" where articulos.familia like '"+familia+"' "+&
"  and articulos.promocion <> 'S' "+&
" group by venlifac.pais, paises.nombre "+&
" order by  ventas_actual desc "

f_cargar_cursor_trans (SQLCA, sel, datos)

if datos.rowcount() > 0 then
	dw_ventas_paises_dos_periodos.object.data = datos.object.data
	dw_ventas_paises_dos_periodos.object.ventas_actual_t.text = string(anyo)
	dw_ventas_paises_dos_periodos.object.ventas_anterior_t.text = string(anyo_anterior)
end if


destroy datos
end subroutine

public subroutine f_ventas_clientes_dos_anyos (string familia, string pais);int anyo, anyo_anterior

anyo = year(Today())
anyo_anterior = anyo - 1

dw_ventas_cliente_dos_anyos.object.ventas_anterior_t.text = string(anyo_anterior)
dw_ventas_cliente_dos_anyos.object.ventas_actual_t.text = string(anyo)

dw_ventas_cliente_dos_anyos.Retrieve (codigo_empresa, familia, pais)




end subroutine

public subroutine f_pedidos_clientes_dos_anyos (string familia, string pais);string sel
datastore datos
int anyo, anyo_anterior

anyo = year(Today())
anyo_anterior = anyo - 1

sel = " select vista_venliped.cliente  "+&
 		" , genter.razon "+&
		"  , sum(case when vista_venliped.fpedido between  CONVERT (datetime, '01-01-'+CAST (year(getdate() )-1  AS VARCHAR(4)), 110) and dateadd ( year, -1, getdate())  "+&
		"  		then ( vista_venliped.neto - vista_venliped.impdtopp ) / vista_venliped.cambio  "+&
		"  		else 0   "+&
		"  	end ) as pedidos_anterior  "+&
		"  , sum(case when vista_venliped.fpedido between  CONVERT (datetime, '01-01-'+CAST (year(getdate() )  AS VARCHAR(4)), 110) and  getdate()  "+&
		"  		then( vista_venliped.neto - vista_venliped.impdtopp ) / vista_venliped.cambio  "+&
		"  		else 0   "+&
		"  	end ) as pedidos_actual  "+&
		"  from vista_venliped  "+&
		"  inner join articulos on vista_venliped.empresa = articulos.empresa and vista_venliped.articulo = articulos.codigo  "+&
		"  inner join genter on vista_venliped.cliente = genter.codigo and vista_venliped.empresa = genter.empresa  "+&
		"  where articulos.familia like '"+familia+"' "+&
		"  and vista_venliped.pais like '"+pais+"' "+&
		"  and vista_venliped.empresa = '"+codigo_empresa+"' "+&
		"  and genter.tipoter = 'C' "+&
		"  and articulos.promocion <> 'S' "+&
		"  group by vista_venliped.cliente, genter.razon "+&
		"  order by  pedidos_actual desc  "


f_cargar_cursor_trans (SQLCA, sel, datos)
if datos.rowcount() > 0 then
	dw_pedidos_cliente_dos_anyos.object.data = datos.object.data
	dw_pedidos_cliente_dos_anyos.object.pedidos_anterior_t.text = string(anyo_anterior)
	dw_pedidos_cliente_dos_anyos.object.pedidos_actual_t.text = string(anyo)
end if

destroy datos



end subroutine

public subroutine f_ventas_coleccion_familia (string familia, string pais, string cliente);string sel
datastore datos
long i, fila
int anyo, anyo_anterior

anyo = year(Today())
anyo_anterior = anyo - 1

sel = " select articulos.submarcas_codigo "+&
" , submarcas.descripcion  "+&
" , sum(case when venlifac.ffactura between  CONVERT (datetime, '01-01-'+CAST (year(getdate() )-1  AS VARCHAR(4)), 110) and dateadd ( year, -1, getdate())  "+&
" 		then (venlifac.neto - venlifac.impdtopp) / venlifac.cambio  "+&
" 		else 0   "+&
" 	end ) as ventas_anterior   "+&
" , sum(  case when venlifac.ffactura between  CONVERT (datetime, '01-01-'+CAST (year(getdate() )  AS VARCHAR(4)), 110) and  getdate()  "+&
" 		then (venlifac.neto - venlifac.impdtopp) / venlifac.cambio  "+&
" 		else 0   "+&
" 	end ) as ventas_actual  "+&
" , sum(	 "+&
"					case when venlifac.ffactura between  CONVERT (datetime, '01-01-'+CAST (year(getdate() )-1  AS VARCHAR(4)), 110) and dateadd ( year, -1, getdate())   "+&
" 					then 	case when venlifac.tipo_unidad = 1 then cantidad  "+&
" 							else  (venlifac.cantidad / almartcajas.piezascaja) * almartcajas.metroscaja  "+&
" 							end  "+&
" 					else 0   "+&
" 					end ) as m2_anterior  "+&
" , sum(  "+&
"				case when venlifac.ffactura between  CONVERT (datetime, '01-01-'+CAST (year(getdate() )  AS VARCHAR(4)), 110) and  getdate()  "+&
" 				then case when venlifac.tipo_unidad = 1 then cantidad  "+&
" 					  else (venlifac.cantidad / almartcajas.piezascaja) * almartcajas.metroscaja  "+&
"					  end   "+&
" 				else 0  "+&
" 				end ) as m2_actual  "+&
" from venlifac  "+&
" inner join articulos on venlifac.empresa = articulos.empresa and venlifac.articulo = articulos.codigo  "+&
" inner join submarcas on articulos.submarcas_codigo = submarcas.codigo  "+&
" left join almartcajas on venlifac.empresa = almartcajas.empresa AND venlifac.articulo = almartcajas.articulo AND venlifac.caja = almartcajas.caja   "+&
" WHERE submarcas.familias_codigo like '"+familia+"'  "+&
" and venlifac.pais like '"+pais+"'  "+&
" and venlifac.cliente like '"+cliente+"'  "+&
" and articulos.promocion <> 'S'  "+&
" group by submarcas_codigo  "+&
" 		, submarcas.descripcion  "+&
" order by  ventas_actual desc" 
	
	
f_cargar_cursor_trans (SQLCA, sel, datos)

for i = 1 to datos.rowcount()
	fila = dw_ventas_coleccion_familia.insertrow(0)
	dw_ventas_coleccion_familia.object.coleccion[fila] = datos.object.submarcas_descripcion[i]

	dw_ventas_coleccion_familia.object.ventas_anterior_t.text = string(anyo_anterior)
	dw_ventas_coleccion_familia.object.ventas_anterior[fila] = datos.object.ventas_anterior[i]
	dw_ventas_coleccion_familia.object.ventas_actual_t.text = string(anyo)
	dw_ventas_coleccion_familia.object.ventas_actual[fila] = datos.object.ventas_actual[i]
	dw_ventas_coleccion_familia.object.m2_actual[fila] = datos.object.m2_actual[i]
	dw_ventas_coleccion_familia.object.m2_anterior[fila] = datos.object.m2_anterior[i]
	
	// Variación ventas
	if datos.object.ventas_anterior[i] <> 0 and not isnull (datos.object.ventas_anterior[i]) then
		dw_ventas_coleccion_familia.object.variacion_vtas[fila] = ((datos.object.ventas_actual[i] - datos.object.ventas_anterior[i]) * 100 ) / datos.object.ventas_anterior[i]
	else
		dw_ventas_coleccion_familia.object.variacion_vtas[fila] = 0
	end if
	
	// Precio medio periodo anterior por m2
	dw_ventas_coleccion_familia.object.pm_anterior_m2_t.text = string(anyo_anterior)	
	if datos.object.m2_anterior[i] <> 0 and not isnull (datos.object.m2_anterior[i]) then
		dw_ventas_coleccion_familia.object.pm_anterior_m2[fila] =  datos.object.ventas_anterior[i] / datos.object.m2_anterior[i]
	else
		dw_ventas_coleccion_familia.object.pm_anterior_m2[fila] = 0
	end if

	// Precio medio periodo actual por m2
	dw_ventas_coleccion_familia.object.pm_actual_m2_t.text = string(anyo)	
	if datos.object.m2_actual[i] <> 0 and not isnull (datos.object.m2_actual[i]) then
		dw_ventas_coleccion_familia.object.pm_actual_m2[fila] =  datos.object.ventas_actual[i] / datos.object.m2_actual[i]
	else
		dw_ventas_coleccion_familia.object.pm_actual_m2[fila] = 0
	end if

	// Variación Precio medio por m2
	if dw_ventas_coleccion_familia.object.pm_anterior_m2[i] <> 0 and not isnull (dw_ventas_coleccion_familia.object.pm_anterior_m2[i]) then
		dw_ventas_coleccion_familia.object.variacion_pm_m2[fila] = ((dw_ventas_coleccion_familia.object.pm_actual_m2[i] - dw_ventas_coleccion_familia.object.pm_anterior_m2[i]) * 100 ) / dw_ventas_coleccion_familia.object.pm_anterior_m2[i]
	else
		dw_ventas_coleccion_familia.object.variacion_pm_m2[fila] = 0
	end if
	
next

destroy datos
/*
string sel
datastore datos
long i, fila
int anyo, anyo_anterior

anyo = year(Today())
anyo_anterior = anyo - 1
	

sel = " select articulos.submarcas_codigo "+&
" , submarcas.descripcion "+&
" , sum(case when venlifac.ffactura between  CONVERT (datetime, '01-01-'+CAST (year(getdate() )-1  AS VARCHAR(4)), 110) and dateadd ( year, -1, getdate()) "+&
" 		then (venlifac.neto - venlifac.impdtopp) / venlifac.cambio "+&
" 		else 0  "+&
" 	end ) as ventas_anterior "+&
" , sum(case when venlifac.ffactura between  CONVERT (datetime, '01-01-'+CAST (year(getdate() )-1  AS VARCHAR(4)), 110) and dateadd ( year, -1, getdate()) "+&
" 		then case when venlifac.tipo_unidad = 1 then (venlifac.neto - venlifac.impdtopp) / venlifac.cambio "+&
" 		else 0 "+&
" 		end "+&
" 		else 0  "+&
" 	end ) as ventas_Anterior_m2 "+&
" , sum(case when venlifac.ffactura between  CONVERT (datetime, '01-01-'+CAST (year(getdate() )-1  AS VARCHAR(4)), 110) and dateadd ( year, -1, getdate()) "+&
" 		then case when venlifac.tipo_unidad <> 1 then (venlifac.neto - venlifac.impdtopp) / venlifac.cambio "+&
" 		else 0 "+&
" 		end "+&
" 		else 0  "+&
" 	end ) as ventas_Anterior_pzs  "+&
" , sum(case when venlifac.ffactura between  CONVERT (datetime, '01-01-'+CAST (year(getdate() )  AS VARCHAR(4)), 110) and  getdate() "+&
" 		then case when venlifac.tipo_unidad = 1 then (venlifac.neto - venlifac.impdtopp) / venlifac.cambio "+&
" 		else 0 "+&
" 		end "+&
" 		else 0  "+&
" 	end ) as ventas_Actual_m2 "+&
" , sum(case when venlifac.ffactura between  CONVERT (datetime, '01-01-'+CAST (year(getdate() )  AS VARCHAR(4)), 110) and  getdate() "+&
" 		then case when venlifac.tipo_unidad <> 1 then (venlifac.neto - venlifac.impdtopp) / venlifac.cambio "+&
" 		else 0 "+&
" 		end "+&
" 		else 0  "+&
" 	end ) as ventas_Actual_pzs "+&
" , sum(case when venlifac.ffactura between  CONVERT (datetime, '01-01-'+CAST (year(getdate() )  AS VARCHAR(4)), 110) and  getdate() "+&
" 		then (venlifac.neto - venlifac.impdtopp) / venlifac.cambio "+&
" 		else 0  "+&
" 	end ) as ventas_actual "+&
" , sum(case when venlifac.ffactura between  CONVERT (datetime, '01-01-'+CAST (year(getdate() )-1  AS VARCHAR(4)), 110) and dateadd ( year, -1, getdate()) "+&
" 		then case when venlifac.tipo_unidad = 1 then cantidad "+&
" 		else 0 "+&
" 		end "+&
" 		else 0  "+&
" 	end ) as m2_anterior "+&
" , sum(case when venlifac.ffactura between  CONVERT (datetime, '01-01-'+CAST (year(getdate() )-1  AS VARCHAR(4)), 110) and dateadd ( year, -1, getdate())  "+&
" 		then case when venlifac.tipo_unidad <> 1 then cantidad "+&
" 		else 0 "+&
" 		end "+&
" 		else 0  "+&
" 	end ) as pzs_anterior "+&
" , sum(case when venlifac.ffactura between  CONVERT (datetime, '01-01-'+CAST (year(getdate() )  AS VARCHAR(4)), 110) and  getdate() "+&
" 		then case when venlifac.tipo_unidad = 1 then cantidad "+&
" 		else 0 "+&
" 		end "+&
" 		else 0  "+&
" 	end ) as m2_actual "+&
" , sum(case when venlifac.ffactura between  CONVERT (datetime, '01-01-'+CAST (year(getdate() )  AS VARCHAR(4)), 110) and  getdate() "+&
" 		then case when venlifac.tipo_unidad <> 1 then cantidad "+&
" 		else 0 "+&
" 		end "+&
" 		else 0  "+&
" 	end ) as pzs_actual	 "+&
" from venlifac "+&
" inner join articulos on venlifac.empresa = articulos.empresa and venlifac.articulo = articulos.codigo "+&
" inner join submarcas on articulos.submarcas_codigo = submarcas.codigo "+&
" WHERE submarcas.familias_codigo like '"+familia+"'"+&
" group by submarcas_codigo "+&
" 		, submarcas.descripcion "+&
"  order by  ventas_actual desc "

f_cargar_cursor_trans (SQLCA, sel, datos)

for i = 1 to datos.rowcount()
	fila = dw_ventas_coleccion_familia.insertrow(0)
	dw_ventas_coleccion_familia.object.coleccion[fila] = datos.object.submarcas_descripcion[i]

	dw_ventas_coleccion_familia.object.ventas_anterior_t.text = string(anyo_anterior)
	dw_ventas_coleccion_familia.object.ventas_anterior[fila] = datos.object.ventas_anterior[i]
	dw_ventas_coleccion_familia.object.ventas_actual_t.text = string(anyo)
	dw_ventas_coleccion_familia.object.ventas_actual[fila] = datos.object.ventas_actual[i]
	dw_ventas_coleccion_familia.object.ventas_anterior_m2[fila] = datos.object.ventas_anterior_m2[i]
	dw_ventas_coleccion_familia.object.ventas_anterior_pzs[fila] = datos.object.ventas_anterior_pzs[i]
	dw_ventas_coleccion_familia.object.ventas_actual_m2[fila] = datos.object.ventas_actual_m2[i]
	dw_ventas_coleccion_familia.object.ventas_actual_pzs[fila] = datos.object.ventas_actual_pzs[i]
	dw_ventas_coleccion_familia.object.m2_actual[fila] = datos.object.m2_actual[i]
	dw_ventas_coleccion_familia.object.m2_anterior[fila] = datos.object.m2_anterior[i]
	dw_ventas_coleccion_familia.object.pzs_actual[fila] = datos.object.pzs_actual[i]
	dw_ventas_coleccion_familia.object.pzs_anterior[fila] = datos.object.pzs_anterior[i]
	
	// Variación ventas
	if datos.object.ventas_anterior[i] <> 0 and not isnull (datos.object.ventas_anterior[i]) then
		dw_ventas_coleccion_familia.object.variacion_vtas[fila] = ((datos.object.ventas_actual[i] - datos.object.ventas_anterior[i]) * 100 ) / datos.object.ventas_anterior[i]
	else
		dw_ventas_coleccion_familia.object.variacion_vtas[fila] = 0
	end if
	
	// Precio medio periodo anterior por pieza
	dw_ventas_coleccion_familia.object.pm_anterior_pzs_t.text = string(anyo_anterior)
	if datos.object.pzs_anterior[i] <> 0 and not isnull (datos.object.pzs_anterior[i]) then
		dw_ventas_coleccion_familia.object.pm_anterior_pzs[fila] =  datos.object.ventas_anterior_pzs[i] / datos.object.pzs_anterior[i]
	else
		dw_ventas_coleccion_familia.object.pm_anterior_pzs[fila] = 0
	end if

	// Precio medio periodo actual por pieza
	dw_ventas_coleccion_familia.object.pm_actual_pzs_t.text = string(anyo)	
	if datos.object.pzs_actual[i] <> 0 and not isnull (datos.object.pzs_actual[i]) then
		dw_ventas_coleccion_familia.object.pm_actual_pzs[fila] =  datos.object.ventas_actual_pzs[i] / datos.object.pzs_actual[i]
	else
		dw_ventas_coleccion_familia.object.pm_actual_pzs[fila] = 0
	end if

	// Variación Precio medio por piezas
	if dw_ventas_coleccion_familia.object.pm_anterior_pzs[i] <> 0 and not isnull (dw_ventas_coleccion_familia.object.pm_anterior_pzs[i]) then
		dw_ventas_coleccion_familia.object.variacion_pm_pzs[fila] = ((dw_ventas_coleccion_familia.object.pm_actual_pzs[i] - dw_ventas_coleccion_familia.object.pm_anterior_pzs[i]) * 100 ) / dw_ventas_coleccion_familia.object.pm_anterior_pzs[i]
	else
		dw_ventas_coleccion_familia.object.variacion_pm_pzs[fila] = 0
	end if

	// Precio medio periodo anterior por m2
	dw_ventas_coleccion_familia.object.pm_anterior_m2_t.text = string(anyo_anterior)	
	if datos.object.m2_anterior[i] <> 0 and not isnull (datos.object.m2_anterior[i]) then
		dw_ventas_coleccion_familia.object.pm_anterior_m2[fila] =  datos.object.ventas_anterior_m2[i] / datos.object.m2_anterior[i]
	else
		dw_ventas_coleccion_familia.object.pm_anterior_m2[fila] = 0
	end if

	// Precio medio periodo actual por m2
	dw_ventas_coleccion_familia.object.pm_actual_m2_t.text = string(anyo)	
	if datos.object.m2_actual[i] <> 0 and not isnull (datos.object.m2_actual[i]) then
		dw_ventas_coleccion_familia.object.pm_actual_m2[fila] =  datos.object.ventas_actual_m2[i] / datos.object.m2_actual[i]
	else
		dw_ventas_coleccion_familia.object.pm_actual_m2[fila] = 0
	end if

	// Variación Precio medio por m2
	if dw_ventas_coleccion_familia.object.pm_anterior_m2[i] <> 0 and not isnull (dw_ventas_coleccion_familia.object.pm_anterior_m2[i]) then
		dw_ventas_coleccion_familia.object.variacion_pm_m2[fila] = ((dw_ventas_coleccion_familia.object.pm_actual_m2[i] - dw_ventas_coleccion_familia.object.pm_anterior_m2[i]) * 100 ) / dw_ventas_coleccion_familia.object.pm_anterior_m2[i]
	else
		dw_ventas_coleccion_familia.object.variacion_pm_m2[fila] = 0
	end if
	
next

destroy datos
*/
end subroutine

public subroutine f_comparativa_pedidos_anyos (string familia, string pais, string cliente);datetime fecha1, fecha2, fecha3, fecha4
long anyo, mes, dia

anyo = year(Today())
mes = month (today())
dia = day (today())

fecha1 = datetime("01-01-"+string(anyo - 1) )
fecha2 = datetime(RelativeDate(Today(), -365))
fecha3 = datetime("01-01-"+string(anyo ) )
fecha4 = datetime(Today())

dw_resumen_pedidos_meses_anyos.Retrieve(codigo_empresa, cliente, datetime(fecha1), datetime(fecha2), datetime(fecha3), datetime(fecha4), familia, pais)


//dateadd ( year, -1, getdate())
end subroutine

public subroutine f_promocion_sobre_ventas (string familia, string pais, string cliente);string sel
datastore datos

sel = " select year (ffactura) Año "+&
		" , (( sum(CASE WHEN articulos.promocion = 'S' "+&
		" 	THEN venlifac.cantidad * articulos.coste_estimado "+&
		" 	ELSE 0  "+&
		" 	END)  "+&
		" - sum(CASE WHEN articulos.promocion = 'S' "+&
		" 	THEN neto / cambio "+&
		" 	ELSE 0 "+&
		" 	END ) ) "+&
		" / ( sum ((neto / cambio)  "+&
		" - CASE WHEN articulos.promocion = 'S' "+&
		" 	THEN neto / cambio "+&
		" 	ELSE 0 "+&
		" 	END )) ) * 100 as Porcentaje "+&
"  from venlifac "+&
" inner join articulos on venlifac.empresa = articulos.empresa and venlifac.articulo = articulos.codigo "+&
" and articulos.familia like '"+familia+"' "+&
" and venlifac.pais like '"+pais+"' "+&
" and venlifac.cliente like '"+cliente+"' "+&
" group by year (ffactura) "+&
" order by year (ffactura) desc "

f_cargar_cursor_trans (SQLCA, sel, datos)

if datos.rowcount() > 0 then
	dw_porcentaje_promo_sobre_vtas.object.data = datos.object.data
end if

destroy datos
end subroutine

public subroutine f_clientes_activos_por_anyos (string familia, string pais, string cliente);string sel
datastore datos

sel = " select year(venlifac.ffactura) anyo, count(distinct venlifac.cliente) clientes_activos "+&
		" from venlifac "+&
		" where venlifac.familia like '"+familia+"' "+&
		" and venlifac.pais  like '"+pais+"' "+&
		" and venlifac.cliente like '"+cliente+"' "+&
		" group by year(venlifac.ffactura) "+&
		" order by year(venlifac.ffactura) desc "

f_cargar_cursor_trans (SQLCA, sel, datos)

if datos.rowcount() > 0 then
	dw_clientes_activos_por_anyos.object.data = datos.object.data
end if


destroy datos

//dw_clientes_activos_por_anyos
end subroutine

public subroutine f_pedidos_por_cliente_hoy (string familia, string pais);string sel
datastore datos

sel = " select  venliped.cliente  "+&
		"  		, genter.razon  "+&
		" 		, sum ((venliped.cantidad * venliped.precio * ( 1 -  venliped.dtoesp / 100 ) * ( 1 -  venliped.dtoesp2 / 100 ) ) / venped.cambio ) as pedidos "+&
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
		" 	where articulos.familia like '"+familia+"' "+&
		" 	and venliped.pais like '"+pais+"' "+&
		" 	and venliped.bloqueado <> 'S' "+&
		" 	and venliped.articulo <> '' "+&
		" 	and venliped.articulo is not null "+&
		" 	and venliped.empresa = '1' "+&
		" 	and genter.tipoter = 'C'  "+&
		" 	and venped.es_proforma <> 'S' "+&
		" 	and CAST(venliped.fecha_intr AS date)= CAST(getdate() AS date) "+&
		" 	group by  venliped.cliente  "+&
		"				, genter.razon  "+&
		" 	order by pedidos desc "




f_cargar_cursor_trans (SQLCA, sel, datos)
if datos.rowcount() > 0 then
	dw_pedidos_por_cliente_hoy.object.data = datos.object.data
end if

destroy datos



end subroutine

event open;call super::open;string mes

istr_parametros.s_titulo_ventana="Cuadro de Mando por Familia"
This.title=istr_parametros.s_titulo_ventana

dw_ventas_coleccion_familia.SetTransObject(SQLCA)
dw_ventas_paises_dos_periodos.SetTransObject(SQLCA)
dw_precio_medio_anyos_fac.SetTransObject(SQLCA)
dw_resumen_pedidos_meses_anyos.SetTransObject(SQLCA)
dw_ventas_cliente_dos_anyos.SetTransObject(SQLCA)
dw_pedidos_cliente_dos_anyos.SetTransObject(SQLCA)
dw_porcentaje_promo_sobre_vtas.SetTransObject(SQLCA)
dw_pedidos_por_cliente_hoy.SetTransObject(SQLCA)
dw_clientes_activos_por_anyos.SetTransObject(SQLCA)
dw_seguimiento_objetivos_familias.SetTransObject(SQLCA)
end event

on w_cuadro_mando_familias.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.cb_1=create cb_1
this.dw_ventas_coleccion_familia=create dw_ventas_coleccion_familia
this.dw_ventas_paises_dos_periodos=create dw_ventas_paises_dos_periodos
this.dw_precio_medio_anyos_fac=create dw_precio_medio_anyos_fac
this.st_2=create st_2
this.dw_resumen_pedidos_meses_anyos=create dw_resumen_pedidos_meses_anyos
this.st_3=create st_3
this.dw_pedidos_cliente_dos_anyos=create dw_pedidos_cliente_dos_anyos
this.uo_pais=create uo_pais
this.gb_1=create gb_1
this.dw_ventas_cliente_dos_anyos=create dw_ventas_cliente_dos_anyos
this.uo_cliente=create uo_cliente
this.dw_porcentaje_promo_sobre_vtas=create dw_porcentaje_promo_sobre_vtas
this.dw_pedidos_por_cliente_hoy=create dw_pedidos_por_cliente_hoy
this.dw_clientes_activos_por_anyos=create dw_clientes_activos_por_anyos
this.gb_3=create gb_3
this.st_1=create st_1
this.dw_seguimiento_objetivos_familias=create dw_seguimiento_objetivos_familias
this.uo_familia=create uo_familia
this.p_informacion=create p_informacion
this.gb_8=create gb_8
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.dw_ventas_coleccion_familia
this.Control[iCurrent+5]=this.dw_ventas_paises_dos_periodos
this.Control[iCurrent+6]=this.dw_precio_medio_anyos_fac
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.dw_resumen_pedidos_meses_anyos
this.Control[iCurrent+9]=this.st_3
this.Control[iCurrent+10]=this.dw_pedidos_cliente_dos_anyos
this.Control[iCurrent+11]=this.uo_pais
this.Control[iCurrent+12]=this.gb_1
this.Control[iCurrent+13]=this.dw_ventas_cliente_dos_anyos
this.Control[iCurrent+14]=this.uo_cliente
this.Control[iCurrent+15]=this.dw_porcentaje_promo_sobre_vtas
this.Control[iCurrent+16]=this.dw_pedidos_por_cliente_hoy
this.Control[iCurrent+17]=this.dw_clientes_activos_por_anyos
this.Control[iCurrent+18]=this.gb_3
this.Control[iCurrent+19]=this.st_1
this.Control[iCurrent+20]=this.dw_seguimiento_objetivos_familias
this.Control[iCurrent+21]=this.uo_familia
this.Control[iCurrent+22]=this.p_informacion
this.Control[iCurrent+23]=this.gb_8
end on

on w_cuadro_mando_familias.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.cb_1)
destroy(this.dw_ventas_coleccion_familia)
destroy(this.dw_ventas_paises_dos_periodos)
destroy(this.dw_precio_medio_anyos_fac)
destroy(this.st_2)
destroy(this.dw_resumen_pedidos_meses_anyos)
destroy(this.st_3)
destroy(this.dw_pedidos_cliente_dos_anyos)
destroy(this.uo_pais)
destroy(this.gb_1)
destroy(this.dw_ventas_cliente_dos_anyos)
destroy(this.uo_cliente)
destroy(this.dw_porcentaje_promo_sobre_vtas)
destroy(this.dw_pedidos_por_cliente_hoy)
destroy(this.dw_clientes_activos_por_anyos)
destroy(this.gb_3)
destroy(this.st_1)
destroy(this.dw_seguimiento_objetivos_familias)
destroy(this.uo_familia)
destroy(this.p_informacion)
destroy(this.gb_8)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_cuadro_mando_familias
integer y = 612
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_cuadro_mando_familias
end type

type st_empresa from w_int_con_empresa`st_empresa within w_cuadro_mando_familias
integer x = 14
integer y = 16
integer width = 2222
integer height = 76
end type

type pb_1 from upb_salir within w_cuadro_mando_familias
integer x = 7351
integer y = 108
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type pb_2 from upb_imprimir within w_cuadro_mando_familias
integer x = 7227
integer y = 108
integer taborder = 0
end type

event clicked;
//f_imprimir_datawindow(dw_informe)

end event

type cb_1 from commandbutton within w_cuadro_mando_familias
integer x = 6880
integer y = 108
integer width = 334
integer height = 96
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Continuar"
end type

event clicked;string familia, pais, cliente

if uo_familia.em_codigo.text = '' then
	familia = '%'
else
	familia = uo_familia.em_codigo.text
end if



if uo_pais.em_codigo.text <> '' and not isnull(uo_pais.em_codigo.text) then
	pais = uo_pais.em_codigo.text
else
	pais = '%'
end if

if uo_cliente.em_codigo.text <> '' and not isnull(uo_cliente.em_codigo.text) then
	cliente = uo_cliente.em_codigo.text
else
	cliente = '%'
end if

dw_ventas_coleccion_familia.Reset()
dw_ventas_paises_dos_periodos.Reset()
dw_precio_medio_anyos_fac.Reset()
dw_resumen_pedidos_meses_anyos.Reset()
dw_ventas_cliente_dos_anyos.Reset()
dw_pedidos_cliente_dos_anyos.Reset()
dw_porcentaje_promo_sobre_vtas.Reset()

dw_clientes_activos_por_anyos.Reset()
dw_seguimiento_objetivos_familias.Reset()


dw_precio_medio_anyos_fac.retrieve(codigo_empresa, familia, pais, cliente)

f_ventas_coleccion_familia(familia, pais, cliente)
f_ventas_paises(familia)
f_comparativa_pedidos_anyos(familia, pais, cliente)
f_promocion_sobre_ventas(familia, pais, cliente)
f_ventas_clientes_dos_anyos(familia, pais)
f_pedidos_clientes_dos_anyos(familia, pais)
f_pedidos_por_cliente_hoy(familia, pais)
f_clientes_activos_por_anyos(familia, pais, cliente)

dw_seguimiento_objetivos_familias.retrieve(codigo_empresa, year(today()), month(today()), familia)


end event

type dw_ventas_coleccion_familia from datawindow within w_cuadro_mando_familias
integer x = 14
integer y = 264
integer width = 2944
integer height = 1548
integer taborder = 100
boolean bringtotop = true
string title = "none"
string dataobject = "dw_ventas_coleccion_familia"
boolean vscrollbar = true
boolean livescroll = true
end type

type dw_ventas_paises_dos_periodos from datawindow within w_cuadro_mando_familias
integer x = 2981
integer y = 264
integer width = 1851
integer height = 1548
integer taborder = 110
boolean bringtotop = true
string title = "none"
string dataobject = "dw_ventas_paises_dos_periodos"
boolean vscrollbar = true
boolean livescroll = true
end type

type dw_precio_medio_anyos_fac from datawindow within w_cuadro_mando_familias
integer x = 4850
integer y = 1924
integer width = 1975
integer height = 368
integer taborder = 110
boolean bringtotop = true
string title = "none"
string dataobject = "dw_precio_medio_anyos_fac"
boolean hscrollbar = true
boolean livescroll = true
end type

type st_2 from statictext within w_cuadro_mando_familias
integer x = 4951
integer y = 1844
integer width = 1870
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 19136731
string text = "Precio Medio por Años"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type dw_resumen_pedidos_meses_anyos from datawindow within w_cuadro_mando_familias
integer x = 14
integer y = 1924
integer width = 4823
integer height = 368
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_resumen_pedidos_meses_anyos"
boolean livescroll = true
end type

type st_3 from statictext within w_cuadro_mando_familias
integer x = 14
integer y = 1844
integer width = 4823
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 19136731
string text = "Comparativa de Pedidos"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type dw_pedidos_cliente_dos_anyos from datawindow within w_cuadro_mando_familias
integer x = 2446
integer y = 2324
integer width = 2395
integer height = 1436
integer taborder = 130
boolean bringtotop = true
string title = "none"
string dataobject = "dw_pedidos_cliente_dos_anyos"
boolean vscrollbar = true
boolean livescroll = true
end type

type uo_pais from u_em_campo_2 within w_cuadro_mando_familias
event destroy ( )
integer x = 4983
integer y = 128
integer width = 690
integer taborder = 60
boolean bringtotop = true
end type

on uo_pais.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;uo_pais.em_campo.text=f_nombre_pais(uo_pais.em_codigo.text)

If Trim(uo_pais.em_campo.text)="" then
	uo_pais.em_campo.text=""
	uo_pais.em_codigo.text=""
	Return
end if 

end event

event losefocus;call super::losefocus;valor_empresa = TRUE
end event

event getfocus;call super::getfocus;valor_empresa = FALSE
	ue_titulo = "Selección de Paises"
	ue_datawindow ="dw_ayuda_paises"
	ue_filtro = ""

end event

type gb_1 from groupbox within w_cuadro_mando_familias
integer x = 4960
integer y = 68
integer width = 736
integer height = 168
integer taborder = 130
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 22563898
long backcolor = 134217748
string text = "País"
end type

type dw_ventas_cliente_dos_anyos from datawindow within w_cuadro_mando_familias
integer x = 14
integer y = 2324
integer width = 2395
integer height = 1436
integer taborder = 120
string title = "none"
string dataobject = "dw_ventas_cliente_dos_anyos"
boolean vscrollbar = true
boolean livescroll = true
end type

type uo_cliente from u_em_campo_2 within w_cuadro_mando_familias
event destroy ( )
integer x = 3977
integer y = 128
integer width = 951
integer taborder = 40
boolean bringtotop = true
end type

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;
uo_cliente.em_campo.text = f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)

If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 

//dw_detalle.Retrieve(codigo_empresa,uo_cliente.em_codigo.text,datetime(date(em_fechadesde.text)),datetime(date(em_fechahasta.text)))
end event

event getfocus;call super::getfocus;
	ue_titulo = "Selección de Clientes"
	ue_datawindow ="dw_ayuda_clientes"
	ue_filtro = ""

end event

type dw_porcentaje_promo_sobre_vtas from datawindow within w_cuadro_mando_familias
integer x = 6853
integer y = 1840
integer width = 613
integer height = 1920
integer taborder = 120
boolean bringtotop = true
string title = "none"
string dataobject = "dw_porcentaje_promo_sobre_vtas"
boolean vscrollbar = true
boolean livescroll = true
end type

type dw_pedidos_por_cliente_hoy from datawindow within w_cuadro_mando_familias
integer x = 4850
integer y = 264
integer width = 1975
integer height = 1552
integer taborder = 120
boolean bringtotop = true
string title = "none"
string dataobject = "dw_pedidos_por_cliente_hoy"
boolean vscrollbar = true
boolean livescroll = true
end type

type dw_clientes_activos_por_anyos from datawindow within w_cuadro_mando_familias
integer x = 6853
integer y = 264
integer width = 613
integer height = 1552
integer taborder = 130
boolean bringtotop = true
string title = "none"
string dataobject = "dw_clientes_activos_por_anyos"
boolean vscrollbar = true
boolean livescroll = true
end type

type gb_3 from groupbox within w_cuadro_mando_familias
integer x = 3945
integer y = 68
integer width = 1006
integer height = 168
integer taborder = 120
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 22563898
long backcolor = 134217748
string text = "Cliente"
end type

type st_1 from statictext within w_cuadro_mando_familias
integer x = 27
integer y = 96
integer width = 2482
integer height = 140
integer textsize = -20
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial Narrow"
long textcolor = 22563898
long backcolor = 134217748
string text = "Cuadro de Mando Por Familias"
boolean focusrectangle = false
end type

type dw_seguimiento_objetivos_familias from datawindow within w_cuadro_mando_familias
integer x = 4859
integer y = 2324
integer width = 1952
integer height = 1436
integer taborder = 140
boolean bringtotop = true
string title = "none"
string dataobject = "dw_seguimiento_objetivos_familias"
boolean livescroll = true
end type

type uo_familia from u_em_campo_2 within w_cuadro_mando_familias
event destroy ( )
integer x = 5760
integer y = 128
integer width = 951
integer taborder = 100
boolean bringtotop = true
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

type p_informacion from picture within w_cuadro_mando_familias
integer x = 4855
integer y = 1848
integer width = 91
integer height = 72
boolean bringtotop = true
string picturename = "C:\Fuentes_tencer_PB12\Information_16x16.png"
boolean focusrectangle = false
string powertiptext = "Promoción excluída.  Incluye todos los dtos menos dto pronto pago.  Incluye los pedidos vendidos en piezas."
end type

type gb_8 from groupbox within w_cuadro_mando_familias
integer x = 5728
integer y = 68
integer width = 1006
integer height = 168
integer taborder = 270
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

