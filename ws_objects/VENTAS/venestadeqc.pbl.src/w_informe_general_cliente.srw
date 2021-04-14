$PBExportHeader$w_informe_general_cliente.srw
forward
global type w_informe_general_cliente from w_int_con_empresa
end type
type pb_1 from upb_salir within w_informe_general_cliente
end type
type pb_2 from upb_imprimir within w_informe_general_cliente
end type
type dw_listado from datawindow within w_informe_general_cliente
end type
type em_fechadesde from u_em_campo within w_informe_general_cliente
end type
type em_fechahasta from u_em_campo within w_informe_general_cliente
end type
type cb_1 from commandbutton within w_informe_general_cliente
end type
type gb_1 from groupbox within w_informe_general_cliente
end type
type st_1 from statictext within w_informe_general_cliente
end type
type dw_listado_resumen from datawindow within w_informe_general_cliente
end type
type dw_listado_resumen_pm from datawindow within w_informe_general_cliente
end type
type uo_cliente from u_em_campo_2 within w_informe_general_cliente
end type
type gb_2 from groupbox within w_informe_general_cliente
end type
type gb_3 from groupbox within w_informe_general_cliente
end type
type gb_4 from groupbox within w_informe_general_cliente
end type
type uo_series from u_marca_lista within w_informe_general_cliente
end type
type cbx_relieves from checkbox within w_informe_general_cliente
end type
type cbx_g4 from checkbox within w_informe_general_cliente
end type
type cbx_g2 from checkbox within w_informe_general_cliente
end type
type dw_detalle2 from datawindow within w_informe_general_cliente
end type
type dw_detalle from datawindow within w_informe_general_cliente
end type
type ddlb_pavrev from dropdownlistbox within w_informe_general_cliente
end type
type st_2 from statictext within w_informe_general_cliente
end type
type dw_detalle3 from datawindow within w_informe_general_cliente
end type
type dw_detalle4 from datawindow within w_informe_general_cliente
end type
type cbx_ocultar_precios from checkbox within w_informe_general_cliente
end type
type st_3 from statictext within w_informe_general_cliente
end type
type st_4 from statictext within w_informe_general_cliente
end type
type sle_inferior from singlelineedit within w_informe_general_cliente
end type
type sle_superior from singlelineedit within w_informe_general_cliente
end type
end forward

global type w_informe_general_cliente from w_int_con_empresa
integer x = 46
integer y = 32
integer width = 4658
integer height = 3736
pb_1 pb_1
pb_2 pb_2
dw_listado dw_listado
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
cb_1 cb_1
gb_1 gb_1
st_1 st_1
dw_listado_resumen dw_listado_resumen
dw_listado_resumen_pm dw_listado_resumen_pm
uo_cliente uo_cliente
gb_2 gb_2
gb_3 gb_3
gb_4 gb_4
uo_series uo_series
cbx_relieves cbx_relieves
cbx_g4 cbx_g4
cbx_g2 cbx_g2
dw_detalle2 dw_detalle2
dw_detalle dw_detalle
ddlb_pavrev ddlb_pavrev
st_2 st_2
dw_detalle3 dw_detalle3
dw_detalle4 dw_detalle4
cbx_ocultar_precios cbx_ocultar_precios
st_3 st_3
st_4 st_4
sle_inferior sle_inferior
sle_superior sle_superior
end type
global w_informe_general_cliente w_informe_general_cliente

type variables

end variables

forward prototypes
public subroutine f_control (datawindow data)
public subroutine f_piezas_metros_importe (ref decimal arg_piezas, ref decimal arg_metros, ref decimal arg_importe, date fecha1, date fecha2, string cliente)
public subroutine f_importe_cliente (ref decimal arg_piezas, ref decimal arg_metros, ref decimal arg_importe, date fecha1, date fecha2, string cliente)
end prototypes

public subroutine f_control (datawindow data);datastore ds_clientes, datos
long i, fila_Actual, indice
string sel1, cliente, v_empresa, v_g2, v_g4, v_rl, v_pavrev,  cal, v_pav_rev, v_cod_cliente
String    sel, tarifa, articulo
date fecha1, fecha2
integer dia1, mes1, anyo1, dia2, mes2, anyo2, v_anyo, v_pedido, v_linea
decimal v_ventas_a, v_piezas, v_metros, v_cantidad_a, v_cantidad_original
dec v_ancho, v_largo, v_m2, v_dias_entrega, total_muestras, importe_muestras, precio, cantidad
datetime v_falbaran, v_fpedido
dec       total_fac


dw_detalle.reset()
dw_detalle2.reset()

fecha1 = date(em_fechadesde.text)
fecha2 = date(em_fechahasta.text)

dia1 = day(fecha1)
mes1 = month(fecha1)
anyo1 = year(fecha1) - 1
dia2 = day(fecha2)
mes2 = month(fecha2) 
anyo2 = year(fecha2) - 1


fecha1 = Date ( anyo1, mes1, dia1)
fecha2 = Date ( anyo2, mes2, dia2)

if ddlb_pavrev.text = 'P' then
	v_pavrev = 'P'
elseif ddlb_pavrev.text = 'R' then
			v_pavrev = 'R'
elseif isnull(ddlb_pavrev.text) or ddlb_pavrev.text = 'Todo' or ddlb_pavrev.text = '' then
	v_pavrev = '%'
end if

	
///////////////  prueba david 27-04-2004	
if uo_cliente.em_codigo.text = '' or isnull(uo_cliente.em_codigo.text) then
	v_cod_cliente = '%'
else
	v_cod_cliente = uo_cliente.em_codigo.text 
end if	
/////////////// fin prueba

// Extraemos las ventas
sel1 = 	" SELECT venlifac.empresa, genter.codigo, genter.razon, (venlifac.importe / venlifac.cambio) as ventas_a, venlifac.cantidad, "+&
			" art_codestadistico.G2, art_codestadistico.G4, art_tipomoldura.descripcion_abr, art_grupo2.descripcion, art_grupo4.descripcion, "+&
			" art_tipomoldura.descripcion, formatos.ancho, formatos.largo, venlifac.cantidad, venlifac.fecha_linped, venlifac.falbaran, "+&
			" venlifac.articulo "+&
			" FROM   venfac, genter, venlifac, articulos, art_codestadistico, art_grupo2, art_grupo4, art_tipomoldura, formatos "+&
			" WHERE  venfac.empresa = '"+codigo_empresa+"' "+&
			" AND venfac.factura = venlifac.factura "+&
			" and venfac.anyo = venlifac.anyo "+&
			" AND venfac.cliente = genter.codigo  "+&
			" AND venfac.ffactura >= '"+em_fechadesde.text+"' "+&
			" AND venfac.ffactura <= '"+em_fechahasta.text+"' "+&
			" AND venfac.cliente like '"+v_cod_cliente+"' "+&
			" AND venlifac.empresa = '"+codigo_empresa+"' "+&
			" AND venlifac.articulo = art_codestadistico.codigo "+&
			" AND art_codestadistico.empresa = '"+codigo_empresa+"' "+&
			" AND venlifac.articulo = articulos.codigo "+&
			" AND articulos.empresa = '"+codigo_empresa+"' "+&
			" AND genter.tipoter = 'C' "+&
			" AND genter.empresa = '"+codigo_empresa+"' "+&
			" AND art_grupo2.empresa = '"+codigo_empresa+"' "+&
			" AND art_codestadistico.g2 = art_grupo2.descripcion_abr "+&
			" AND art_codestadistico.g1  like '"+v_pavrev+"' "+&
			" AND art_grupo4.empresa = '"+codigo_empresa+"' "+&
			" AND art_codestadistico.g4 = art_grupo4.descripcion_abr "+&
			" AND art_tipomoldura.empresa = '"+codigo_empresa+"' "+&
			" AND articulos.relieve = art_tipomoldura.codigo "+&
			" AND formatos.empresa = '"+codigo_empresa+"' "+&
			" AND venlifac.formato = formatos.codigo "+&
			" AND venlifac.articulo is not null "+&    
			" AND	venlifac.cantidad > 0 "+&
			" AND	venlifac.importe > 0 "+&
			" AND	venlifac.fecha_linped is not null "+&
			" AND	venlifac.fecha_linped <> '01/01/1900' "+&
			" ORDER BY genter.razon, art_codestadistico.g2, art_codestadistico.g4, art_tipomoldura.descripcion "
			

f_cargar_cursor_nuevo (sel1, ds_clientes)

dw_detalle.Setredraw(false)
dw_Detalle.object.actual.text =  em_fechadesde.text+" a "+em_fechahasta.text
dw_Detalle2.object.actual.text =  em_fechadesde.text+" a "+em_fechahasta.text
dw_Detalle3.object.actual.text =  em_fechadesde.text+" a "+em_fechahasta.text
dw_Detalle4.object.actual.text =  em_fechadesde.text+" a "+em_fechahasta.text

if ddlb_pavrev.text = 'P' then
	v_pav_rev = 'Pavimento'
elseif ddlb_pavrev.text = 'R' then
	v_pav_rev = 'Revestimiento'
else 
	v_pav_rev = 'Todo'
end if
dw_Detalle.object.pav_rev.text =  v_pav_rev
dw_Detalle2.object.pav_rev.text =  v_pav_rev
dw_Detalle3.object.pav_rev.text =  v_pav_rev
dw_Detalle4.object.pav_rev.text =  v_pav_rev

//dw_Detalle.object.Anterior.text = string(fecha1,"dd-mm-yy")+" a "+string(fecha2,"dd-mm-yy")

for i = 1 to ds_clientes.rowcount()
	cliente = ds_clientes.object.genter_razon[i]
	v_ventas_a = ds_clientes.object.ventas_a[i]
	v_cantidad_a = ds_clientes.object.venlifac_cantidad[i]
	v_g2 = ds_clientes.object.art_grupo2_descripcion[i]
	v_g4 = ds_clientes.object.art_grupo4_descripcion[i]
	v_rl = ds_clientes.object.art_tipomoldura_descripcion[i]
	v_ancho = ds_clientes.object.formatos_ancho[i]
	v_largo = ds_clientes.object.formatos_largo[i]
	v_cantidad_original = ds_clientes.object.venlifac_cantidad[i]
	v_falbaran = ds_clientes.object.venlifac_falbaran[i]
	v_fpedido = ds_clientes.object.venlifac_fecha_linped[i]
	v_dias_entrega = DaysAfter(date(v_fpedido), date(v_falbaran))
	
	if sle_inferior.text = '' or isnull(sle_inferior.text) then
		sle_inferior.text = '0'
	end if
	if sle_superior.text = '' or isnull(sle_superior.text) then
		sle_superior.text = '999'
	end if
	if v_dias_entrega > long(sle_inferior.text) and v_dias_entrega < long(sle_superior.text) then
		fila_actual = dw_detalle.insertrow(0)
	
		dw_detalle.object.cliente[fila_actual] = cliente
		dw_detalle.object.ventas_a[fila_actual] = v_ventas_a
		dw_detalle.object.cantidad_a[fila_actual] = v_cantidad_a
		dw_detalle.object.g2[fila_actual] = v_g2
		dw_detalle.object.g4[fila_actual] = v_g4
		dw_detalle.object.rl[fila_actual] = v_rl
		v_m2  = (v_ancho * v_largo / 10000) * v_cantidad_a
		dw_detalle.object.m2 [fila_actual] = v_m2 
		dw_detalle.object.cantidad_original [fila_actual] = v_cantidad_original
		dw_detalle.object.dias_entrega [fila_actual] = v_dias_entrega
		f_mensaje_proceso ("Clientes:", i, ds_clientes.rowcount())
	end if
next

/****************************************************************************************************************
**********************************************	detalle 2 *******************************************************
****************************************************************************************************************/

// Extraemos las ventas
sel1 = 	" SELECT venlifac.empresa, genter.codigo, genter.razon, (venlifac.importe / venlifac.cambio) as ventas_a, venlifac.cantidad, "+&
			" art_codestadistico.G2, art_codestadistico.G4, art_tipomoldura.descripcion_abr, art_grupo2.descripcion, art_grupo4.descripcion, "+&
			" art_tipomoldura.descripcion, formatos.ancho, formatos.largo, venlifac.cantidad, venlifac.fecha_linped, venlifac.falbaran, "+&
			" venlifac.articulo "+&
			" FROM   venfac, genter, venlifac, art_codestadistico, articulos, art_grupo2, art_grupo4, art_tipomoldura, formatos "+&
			" WHERE  venfac.empresa = '"+codigo_empresa+"' "+&
			" AND venfac.factura = venlifac.factura "+&
			" and venfac.anyo = venlifac.anyo "+&
			" AND venfac.cliente = genter.codigo  "+&
			" AND venfac.ffactura >= '"+em_fechadesde.text+"' "+&
			" AND venfac.ffactura <= '"+em_fechahasta.text+"' "+&
			" AND venfac.cliente like '"+v_cod_cliente+"' "+&
			" AND venlifac.empresa = '"+codigo_empresa+"' "+&
			" AND venlifac.articulo = art_codestadistico.codigo "+&
			" AND art_codestadistico.empresa = '"+codigo_empresa+"' "+&
			" AND venlifac.articulo = articulos.codigo "+&
			" AND articulos.empresa = '"+codigo_empresa+"' "+&
			" AND genter.tipoter = 'C' "+&
			" AND genter.empresa = '"+codigo_empresa+"' "+&
			" AND art_grupo2.empresa = '"+codigo_empresa+"' "+&
			" AND art_codestadistico.g2 = art_grupo2.descripcion_abr "+&
			" AND art_codestadistico.g1  like '"+v_pavrev+"' "+&
			" AND art_grupo4.empresa = '"+codigo_empresa+"' "+&
			" AND art_codestadistico.g4 = art_grupo4.descripcion_abr "+&
			" AND art_tipomoldura.empresa = '"+codigo_empresa+"' "+&
			" AND articulos.relieve = art_tipomoldura.codigo "+&
			" AND formatos.empresa = '"+codigo_empresa+"' "+&
			" AND venlifac.formato = formatos.codigo "+&
			" ORDER BY genter.razon, art_codestadistico.g2, art_codestadistico.g4, art_tipomoldura.descripcion "
			

f_cargar_cursor_nuevo (sel1, ds_clientes)

dw_detalle2.Setredraw(false)
dw_Detalle2.object.actual.text =  em_fechadesde.text+" a "+em_fechahasta.text
//dw_Detalle.object.Anterior.text = string(fecha1,"dd-mm-yy")+" a "+string(fecha2,"dd-mm-yy")

for i = 1 to ds_clientes.rowcount()
	fila_actual = dw_detalle2.insertrow(0)
	cliente = ds_clientes.object.genter_razon[i]
	v_ventas_a = ds_clientes.object.ventas_a[i]
	v_cantidad_a = ds_clientes.object.venlifac_cantidad[i]
	v_g2 = ds_clientes.object.art_grupo2_descripcion[i]
	v_g4 = ds_clientes.object.art_grupo4_descripcion[i]
	v_rl = ds_clientes.object.art_tipomoldura_descripcion[i]
	v_ancho = ds_clientes.object.formatos_ancho[i]
	v_largo = ds_clientes.object.formatos_largo[i]
	v_cantidad_original = ds_clientes.object.venlifac_cantidad[i]
	v_falbaran = ds_clientes.object.venlifac_falbaran[i]
	v_fpedido = ds_clientes.object.venlifac_fecha_linped[i]
	v_dias_entrega = DaysAfter(date(v_fpedido), date(v_falbaran))
		 
	dw_detalle2.object.cliente[fila_actual] = cliente
	dw_detalle2.object.ventas_a[fila_actual] = v_ventas_a
	dw_detalle2.object.cantidad_a[fila_actual] = v_cantidad_a
	dw_detalle2.object.g2[fila_actual] = v_g2
	dw_detalle2.object.g4[fila_actual] = v_g4
	dw_detalle2.object.rl[fila_actual] = v_rl
	v_m2  = (v_ancho * v_largo / 10000) * v_cantidad_a
	dw_detalle2.object.m2 [fila_actual] = v_m2 
	dw_detalle2.object.cantidad_original [fila_actual] = v_cantidad_original
	dw_detalle2.object.dias_entrega [fila_actual] = v_dias_entrega
	f_mensaje_proceso ("Clientes:", i, ds_clientes.rowcount())
next



/****************************************************************************************************************
********************************************	fin detalle 2 ******************************************************
****************************************************************************************************************/



dw_detalle.setsort("")
dw_detalle.sort()
dw_detalle.GroupCalc()

dw_detalle2.setsort("")
dw_detalle2.sort()
dw_detalle2.GroupCalc()

if cbx_relieves.checked then
	dw_detalle.Modify("DataWindow.Header.4.Height=0"  )
	dw_detalle2.Modify("DataWindow.Header.4.Height=0"  )
	dw_detalle3.Modify("DataWindow.Header.3.Height=0"  )
	dw_detalle4.Modify("DataWindow.Header.2.Height=0"  )

else	
	dw_detalle.Modify("DataWindow.Header.4.Height=68"  )
	dw_detalle2.Modify("DataWindow.Header.4.Height=68"  )
	dw_detalle3.Modify("DataWindow.Header.3.Height=68"  )
	dw_detalle4.Modify("DataWindow.Header.2.Height=68"  )
	
end if
if cbx_g4.checked then
	dw_detalle.Modify("DataWindow.Header.3.Height=0"  )
	dw_detalle2.Modify("DataWindow.Header.3.Height=0"  )
else	
	dw_detalle.Modify("DataWindow.Header.3.Height=68"  )
	dw_detalle2.Modify("DataWindow.Header.3.Height=68"  )
end if
if cbx_g2.checked then
	dw_detalle.Modify("DataWindow.Header.2.Height=0"  )
	dw_detalle2.Modify("DataWindow.Header.2.Height=0"  )
else	
	dw_detalle.Modify("DataWindow.Header.2.Height=68"  )
	dw_detalle2.Modify("DataWindow.Header.2.Height=68"  )
end if

dw_detalle.Setredraw(True)
dw_detalle2.Setredraw(True)




/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////   MUESTRAS   //////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


//Cargamos los datos de las facturas

sel = "select articulo, formato, cliente, cantidad, cambio, importe, calidad "+&
		"from   venlifac "+&
		"where  empresa = '"+codigo_empresa+"' "+&
		"and    cliente like '"+v_cod_cliente+"' "+&
		"and    ffactura between '"+string(date(em_fechadesde.text))+"' and '"+string(date(em_fechahasta.text))+"' "+&
		"and    clase = 'M' "
		
		
//datos = f_cargar_cursor(sel)		
f_Cargar_cursor_nuevo(sel, datos)

total_fac = 0
cantidad = 0
dw_detalle2.object.importe_muestras.text = '0'
dw_detalle2.object.piezas_muestras.text  = '0'
for indice = 1 to datos.RowCount()
	articulo  = datos.object.articulo[indice]
	cal  = datos.object.calidad[indice]
	string cliente_muestras
	cantidad = cantidad + datos.object.cantidad[indice]
	cliente_muestras = datos.object.cliente[indice]
	tarifa = f_tarifa_venclientes(codigo_empresa, cliente_muestras)
	precio = f_precio_articulo_venlintarifas_activa( codigo_empresa, tarifa, articulo, cal )
	
	total_fac = total_fac + ( datos.object.cantidad[indice] * precio / datos.object.cambio[indice])
	
	f_mensaje_proceso ("Total Registros: ",indice,datos.RowCount())

next
dw_detalle2.object.importe_muestras.text = string(total_fac,"###,###,##0.00")
dw_detalle2.object.piezas_muestras.text = string(cantidad,"###,###,##0")

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////// FIN MUESTRAS ///////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

dw_detalle3.retrieve (codigo_empresa, v_cod_cliente, datetime(date(em_fechadesde.text)), datetime(date(em_fechahasta.text)))
dw_detalle4.retrieve (codigo_empresa, v_cod_cliente, datetime(date(em_fechadesde.text)), datetime(date(em_fechahasta.text)))

destroy ds_clientes
destroy datos



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



/*
	select 	venliped.empresa,
				venliped.anyo,   
				venliped.pedido,   
				venliped.linea,  
				venliped.fpedido,
				venliped.importe / venped.cambio as importe_moneda,
				venliped.cantidad,
				formatos.ancho * formatos.largo * venliped.cantidad / 10000
	into :v_empresa, :v_anyo, :v_pedido, :v_linea, :v_fpedido, :arg_importe, :arg_piezas, :arg_metros
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
	union
	select venlialb.empresa,
			venlialb.anyo_pedido_origen, 
			venlialb.pedido_origen, 
			venlialb.linea_pedido_origen, 
			venlialb.fpedido_origen,
			venlialb.importe / venalb.cambio as importe_moneda, 
			venlialb.cantidad,
			formatos.ancho * formatos.largo * venlialb.cantidad / 10000
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
	union
	select venlifac.empresa, 
			venlifac.anyo_pedido_origen, 
			venlifac.pedido_origen, 
			venlifac.linea_pedido_origen, 
			venlifac.fpedido_origen,
			venlifac.importe / venlifac.cambio as importe_moneda, 
			venlifac.cantidad,
			formatos.ancho * formatos.largo * venlifac.cantidad / 10000
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
	and venlifac.cliente like :cliente;
	*/
end subroutine

public subroutine f_importe_cliente (ref decimal arg_piezas, ref decimal arg_metros, ref decimal arg_importe, date fecha1, date fecha2, string cliente);decimal importe_ped = 0, importe_alb = 0, importe_fac = 0
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



/*
	select 	venliped.empresa,
				venliped.anyo,   
				venliped.pedido,   
				venliped.linea,  
				venliped.fpedido,
				venliped.importe / venped.cambio as importe_moneda,
				venliped.cantidad,
				formatos.ancho * formatos.largo * venliped.cantidad / 10000
	into :v_empresa, :v_anyo, :v_pedido, :v_linea, :v_fpedido, :arg_importe, :arg_piezas, :arg_metros
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
	union
	select venlialb.empresa,
			venlialb.anyo_pedido_origen, 
			venlialb.pedido_origen, 
			venlialb.linea_pedido_origen, 
			venlialb.fpedido_origen,
			venlialb.importe / venalb.cambio as importe_moneda, 
			venlialb.cantidad,
			formatos.ancho * formatos.largo * venlialb.cantidad / 10000
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
	union
	select venlifac.empresa, 
			venlifac.anyo_pedido_origen, 
			venlifac.pedido_origen, 
			venlifac.linea_pedido_origen, 
			venlifac.fpedido_origen,
			venlifac.importe / venlifac.cambio as importe_moneda, 
			venlifac.cantidad,
			formatos.ancho * formatos.largo * venlifac.cantidad / 10000
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
	and venlifac.cliente like :cliente;
	*/
end subroutine

event close;call super::close;dw_detalle.reset()
dw_listado.reset()
dw_listado_resumen.reset()
end event

event open;call super::open;istr_parametros.s_titulo_ventana="Informe General Cliente"
This.title=istr_parametros.s_titulo_ventana
em_fechadesde.text = String(MDY(01,01,Year(Today())))
em_fechahasta.text = String(Today())
//uo_series.f_cargar_datos("dw_ayuda_venseries","","","Serie","Descripción")
//dw_detalle.DataObject = "dw_con_ped_alb_fac_cliente_fechas_tencer"
dw_detalle3.settransobject(SQLCA)
dw_detalle4.settransobject(SQLCA)

sle_inferior.text = '7'
sle_superior.text = '40'
end event

on w_informe_general_cliente.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.dw_listado=create dw_listado
this.em_fechadesde=create em_fechadesde
this.em_fechahasta=create em_fechahasta
this.cb_1=create cb_1
this.gb_1=create gb_1
this.st_1=create st_1
this.dw_listado_resumen=create dw_listado_resumen
this.dw_listado_resumen_pm=create dw_listado_resumen_pm
this.uo_cliente=create uo_cliente
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_4=create gb_4
this.uo_series=create uo_series
this.cbx_relieves=create cbx_relieves
this.cbx_g4=create cbx_g4
this.cbx_g2=create cbx_g2
this.dw_detalle2=create dw_detalle2
this.dw_detalle=create dw_detalle
this.ddlb_pavrev=create ddlb_pavrev
this.st_2=create st_2
this.dw_detalle3=create dw_detalle3
this.dw_detalle4=create dw_detalle4
this.cbx_ocultar_precios=create cbx_ocultar_precios
this.st_3=create st_3
this.st_4=create st_4
this.sle_inferior=create sle_inferior
this.sle_superior=create sle_superior
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.em_fechadesde
this.Control[iCurrent+5]=this.em_fechahasta
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.gb_1
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.dw_listado_resumen
this.Control[iCurrent+10]=this.dw_listado_resumen_pm
this.Control[iCurrent+11]=this.uo_cliente
this.Control[iCurrent+12]=this.gb_2
this.Control[iCurrent+13]=this.gb_3
this.Control[iCurrent+14]=this.gb_4
this.Control[iCurrent+15]=this.uo_series
this.Control[iCurrent+16]=this.cbx_relieves
this.Control[iCurrent+17]=this.cbx_g4
this.Control[iCurrent+18]=this.cbx_g2
this.Control[iCurrent+19]=this.dw_detalle2
this.Control[iCurrent+20]=this.dw_detalle
this.Control[iCurrent+21]=this.ddlb_pavrev
this.Control[iCurrent+22]=this.st_2
this.Control[iCurrent+23]=this.dw_detalle3
this.Control[iCurrent+24]=this.dw_detalle4
this.Control[iCurrent+25]=this.cbx_ocultar_precios
this.Control[iCurrent+26]=this.st_3
this.Control[iCurrent+27]=this.st_4
this.Control[iCurrent+28]=this.sle_inferior
this.Control[iCurrent+29]=this.sle_superior
end on

on w_informe_general_cliente.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.dw_listado)
destroy(this.em_fechadesde)
destroy(this.em_fechahasta)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.st_1)
destroy(this.dw_listado_resumen)
destroy(this.dw_listado_resumen_pm)
destroy(this.uo_cliente)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_4)
destroy(this.uo_series)
destroy(this.cbx_relieves)
destroy(this.cbx_g4)
destroy(this.cbx_g2)
destroy(this.dw_detalle2)
destroy(this.dw_detalle)
destroy(this.ddlb_pavrev)
destroy(this.st_2)
destroy(this.dw_detalle3)
destroy(this.dw_detalle4)
destroy(this.cbx_ocultar_precios)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.sle_inferior)
destroy(this.sle_superior)
end on

event ue_f5;f_control(dw_detalle)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_informe_general_cliente
integer y = 612
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_informe_general_cliente
end type

type st_empresa from w_int_con_empresa`st_empresa within w_informe_general_cliente
integer x = 9
integer y = 8
integer width = 2894
integer height = 76
integer textsize = -8
long textcolor = 8388608
end type

type pb_1 from upb_salir within w_informe_general_cliente
integer x = 4407
integer y = 8
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type pb_2 from upb_imprimir within w_informe_general_cliente
integer x = 3831
integer y = 176
integer width = 128
integer height = 104
integer taborder = 70
boolean originalsize = false
end type

event clicked;//if rb_pm.checked then
//	f_control_pm(dw_detalle)
//else
//	f_control(dw_detalle)
//end if
	f_imprimir_datawindow(dw_detalle)
	f_imprimir_datawindow(dw_detalle2)
	f_imprimir_datawindow(dw_detalle3)
	f_imprimir_datawindow(dw_detalle4)

end event

type dw_listado from datawindow within w_informe_general_cliente
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

type em_fechadesde from u_em_campo within w_informe_general_cliente
integer x = 27
integer y = 140
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

type em_fechahasta from u_em_campo within w_informe_general_cliente
integer x = 398
integer y = 140
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

type cb_1 from commandbutton within w_informe_general_cliente
integer x = 3483
integer y = 176
integer width = 334
integer height = 104
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Continuar"
end type

event clicked;f_control(dw_detalle)

if cbx_ocultar_precios.checked then
	dw_detalle.object.precio1.visible = false
	dw_detalle.object.precio2.visible = false
	dw_detalle.object.precio3.visible = false
	dw_detalle.object.precio4.visible = false
	dw_detalle.object.precio5.visible = false
	dw_detalle.object.precio6.visible = false
	dw_detalle.object.precio7.visible = false
	dw_detalle.object.precio8.visible = false
	dw_detalle.object.t_prec_pza.visible = false
	dw_detalle.object.t_prec_metro.visible = false
else	
	dw_detalle.object.precio1.visible = true
	dw_detalle.object.precio2.visible = true
	dw_detalle.object.precio3.visible = true
	dw_detalle.object.precio4.visible = true
	dw_detalle.object.precio5.visible = true
	dw_detalle.object.precio6.visible = true
	dw_detalle.object.precio7.visible = true
	dw_detalle.object.precio8.visible = true
	dw_detalle.object.t_prec_pza.visible = true
	dw_detalle.object.t_prec_metro.visible = true
	
end if
end event

type gb_1 from groupbox within w_informe_general_cliente
integer x = 9
integer y = 88
integer width = 690
integer height = 164
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha de Factura"
end type

type st_1 from statictext within w_informe_general_cliente
integer x = 343
integer y = 140
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

type dw_listado_resumen from datawindow within w_informe_general_cliente
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

type dw_listado_resumen_pm from datawindow within w_informe_general_cliente
boolean visible = false
integer x = 2898
integer y = 12
integer width = 160
integer height = 96
integer taborder = 80
boolean bringtotop = true
string dataobject = "report_con_ped_alb_fac_cliente_fechas3pm"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_cliente from u_em_campo_2 within w_informe_general_cliente
event destroy ( )
integer x = 745
integer y = 144
integer width = 1230
integer height = 92
integer taborder = 30
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

type gb_2 from groupbox within w_informe_general_cliente
integer x = 727
integer y = 88
integer width = 1266
integer height = 164
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

type gb_3 from groupbox within w_informe_general_cliente
integer x = 727
integer y = 88
integer width = 1266
integer height = 164
integer taborder = 100
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

type gb_4 from groupbox within w_informe_general_cliente
integer x = 727
integer y = 88
integer width = 1266
integer height = 164
integer taborder = 120
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

type uo_series from u_marca_lista within w_informe_general_cliente
event destroy ( )
boolean visible = false
integer x = 686
integer y = 240
boolean border = false
end type

on uo_series.destroy
call u_marca_lista::destroy
end on

type cbx_relieves from checkbox within w_informe_general_cliente
integer x = 4000
integer y = 144
integer width = 475
integer height = 72
integer taborder = 130
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
string text = "Ocultar Relieves"
borderstyle borderstyle = styleraised!
end type

type cbx_g4 from checkbox within w_informe_general_cliente
integer x = 4000
integer y = 84
integer width = 389
integer height = 76
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
string text = "Ocultar G4"
borderstyle borderstyle = styleraised!
end type

type cbx_g2 from checkbox within w_informe_general_cliente
integer x = 4000
integer y = 24
integer width = 389
integer height = 72
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
string text = "Ocultar G2"
borderstyle borderstyle = styleraised!
end type

type dw_detalle2 from datawindow within w_informe_general_cliente
integer x = 1696
integer y = 312
integer width = 1609
integer height = 3120
boolean bringtotop = true
string dataobject = "dw_informe_general_cliente2"
boolean vscrollbar = true
end type

type dw_detalle from datawindow within w_informe_general_cliente
integer x = 14
integer y = 312
integer width = 1664
integer height = 3116
string dataobject = "dw_informe_general_cliente"
boolean vscrollbar = true
end type

type ddlb_pavrev from dropdownlistbox within w_informe_general_cliente
integer x = 3195
integer y = 36
integer width = 265
integer height = 328
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string item[] = {"P","R","Todo"}
borderstyle borderstyle = styleraised!
end type

type st_2 from statictext within w_informe_general_cliente
integer x = 2917
integer y = 48
integer width = 274
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Pav / Rev:"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_detalle3 from datawindow within w_informe_general_cliente
integer x = 3323
integer y = 312
integer width = 1221
integer height = 1664
boolean bringtotop = true
string dataobject = "dw_informe_general_cliente3"
boolean vscrollbar = true
end type

type dw_detalle4 from datawindow within w_informe_general_cliente
integer x = 3323
integer y = 2008
integer width = 1221
integer height = 1424
integer taborder = 140
boolean bringtotop = true
string dataobject = "dw_informe_general_cliente4"
boolean vscrollbar = true
end type

type cbx_ocultar_precios from checkbox within w_informe_general_cliente
integer x = 4018
integer y = 216
integer width = 475
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ocultar Precios"
boolean lefttext = true
end type

type st_3 from statictext within w_informe_general_cliente
integer x = 2944
integer y = 156
integer width = 247
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Plazo >"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_4 from statictext within w_informe_general_cliente
integer x = 2944
integer y = 228
integer width = 247
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Plazo <"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_inferior from singlelineedit within w_informe_general_cliente
integer x = 3200
integer y = 148
integer width = 206
integer height = 68
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_superior from singlelineedit within w_informe_general_cliente
integer x = 3200
integer y = 220
integer width = 206
integer height = 68
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

