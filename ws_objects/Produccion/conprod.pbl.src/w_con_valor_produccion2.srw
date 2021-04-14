$PBExportHeader$w_con_valor_produccion2.srw
forward
global type w_con_valor_produccion2 from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_valor_produccion2
end type
type pb_2 from upb_imprimir within w_con_valor_produccion2
end type
type cb_1 from commandbutton within w_con_valor_produccion2
end type
type gb_1 from groupbox within w_con_valor_produccion2
end type
type gb_6 from groupbox within w_con_valor_produccion2
end type
type dw_informe from datawindow within w_con_valor_produccion2
end type
type em_fdesde from u_em_campo within w_con_valor_produccion2
end type
type em_fhasta from u_em_campo within w_con_valor_produccion2
end type
type sle_semanas from singlelineedit within w_con_valor_produccion2
end type
type st_1 from statictext within w_con_valor_produccion2
end type
type cb_2 from commandbutton within w_con_valor_produccion2
end type
type cbx_resumen from checkbox within w_con_valor_produccion2
end type
type st_contador from statictext within w_con_valor_produccion2
end type
type uo_familias from u_marca_lista within w_con_valor_produccion2
end type
type uo_marcas from u_marca_lista within w_con_valor_produccion2
end type
type uo_submarcas from u_marca_lista within w_con_valor_produccion2
end type
type cb_familias from commandbutton within w_con_valor_produccion2
end type
type cb_marcas from commandbutton within w_con_valor_produccion2
end type
type cb_submarcas from commandbutton within w_con_valor_produccion2
end type
end forward

global type w_con_valor_produccion2 from w_int_con_empresa
integer x = 5
integer y = 4
integer width = 3785
integer height = 2696
pb_1 pb_1
pb_2 pb_2
cb_1 cb_1
gb_1 gb_1
gb_6 gb_6
dw_informe dw_informe
em_fdesde em_fdesde
em_fhasta em_fhasta
sle_semanas sle_semanas
st_1 st_1
cb_2 cb_2
cbx_resumen cbx_resumen
st_contador st_contador
uo_familias uo_familias
uo_marcas uo_marcas
uo_submarcas uo_submarcas
cb_familias cb_familias
cb_marcas cb_marcas
cb_submarcas cb_submarcas
end type
global w_con_valor_produccion2 w_con_valor_produccion2

type variables

end variables

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);datastore datos 
Date  fecha1, fecha2
string sel, familia, familia_sql,ls_filtro,ls_filtro_familias,ls_filtro_marcas,ls_filtro_submarcas
long fila_actual, i, total_regs, j
int  li_opciones,li_opciones_marcadas,li_indice

data.SetTransObject(SQLCA)
data.Reset()
data.retrieve()
data.setredraw(false)		

uo_familias.visible = false
uo_marcas.visible = false
uo_submarcas.visible = false


//Filtro de familias
li_opciones = uo_familias.dw_marca.RowCount()
li_opciones_marcadas = 0
ls_filtro= ''

for li_indice = 1 to li_opciones
	if uo_familias.dw_marca.object.marca[li_indice]='S' then
		li_opciones_marcadas ++
		if li_opciones_marcadas > 1 then
			ls_filtro += ",'"+uo_familias.dw_marca.object.codigo[li_indice]+"'"
		else
			ls_filtro = "'"+uo_familias.dw_marca.object.codigo[li_indice]+"'"
		end if
	end if
next

if li_opciones_marcadas > 0 then
	if li_opciones_marcadas > 1 then
		ls_filtro_familias = " and articulos.familia in ("+ls_filtro+") "
	else
		ls_filtro_familias = " and articulos.familia = "+ls_filtro+" "
	end if
end if

//Fin de filtro de familias

//Filtro de marcas
li_opciones = uo_marcas.dw_marca.RowCount()
li_opciones_marcadas = 0
ls_filtro= ''

for li_indice = 1 to li_opciones
	if uo_marcas.dw_marca.object.marca[li_indice]='S' then
		li_opciones_marcadas ++
		if li_opciones_marcadas > 1 then
			ls_filtro += ",'"+uo_marcas.dw_marca.object.codigo[li_indice]+"'"
		else
			ls_filtro = "'"+uo_marcas.dw_marca.object.codigo[li_indice]+"'"
		end if
	end if
next

if li_opciones_marcadas > 0 then
	if li_opciones_marcadas > 1 then
		ls_filtro_marcas = " and articulos.marcas_codigo in ("+ls_filtro+") "
	else
		ls_filtro_marcas = " and articulos.marcas_codigo = "+ls_filtro+" "
	end if
end if

//Fin de filtro de marcas

//Filtro de submarcas
li_opciones = uo_submarcas.dw_marca.RowCount()
li_opciones_marcadas = 0
ls_filtro= ''
for li_indice = 1 to li_opciones
	if uo_submarcas.dw_marca.object.marca[li_indice]='S' then
		li_opciones_marcadas ++
		if li_opciones_marcadas > 1 then
			ls_filtro += ",'"+uo_submarcas.dw_marca.object.codigo[li_indice]+"'"
		else
			ls_filtro = "'"+uo_submarcas.dw_marca.object.codigo[li_indice]+"'"
		end if
	end if
next

if li_opciones_marcadas > 0 then
	if li_opciones_marcadas > 1 then
		ls_filtro_submarcas = " and articulos.submarcas_codigo in ("+ls_filtro+") "
	else
		ls_filtro_submarcas = " and articulos.submarcas_codigo = "+ls_filtro+" "
	end if
end if

//Fin de filtro de submarcas

fecha1 = date(em_fdesde.text)
fecha2 = date(em_fhasta.text)
data.object.periodo.text = "Desde "+em_fdesde.text+" al "+em_fhasta.text


sel = " select prodpartes_ot.seccion, "+&
		" prodsecciones.descripcion_abr, "+&
		" prodpartes_ot.buenas , "+&
		" prodpartes_ot.art_terminado , "+&
		" prodpartes_ot.articulo, "+&
		" articulos.descripcion, "+&
		" formatos.abreviado, "+&
		" prodpartes_ot.linea, "+&
		" prodlineas.resumido, "+&
		" prodpartes_ot.buenas * formatos.ancho  * formatos.largo / 10000 as metros, "+&
		" ( case when articulos.unidad  = 0 then prodpartes_ot.buenas * prodpartes_ot.factor "+& 
		" else ( ( prodpartes_ot.buenas  * prodpartes_ot.factor * ((formatos.ancho * formatos.largo) /10000) ) ) END ) * "+&
				"( CASE WHEN ( select min(ventarifas_precios_packs.precio) "+&
				"		 from ventarifas_precios_packs  "+&
				"		 where empresa = prodpartes_ot.empresa  "+&
				"		 and ventarifas_precios_packs.articulos_codigo = prodpartes_ot.art_encajado  "+&
				"		 and ventarifas_codigo <> '5')  <> 0 "+&
				"		 OR  "+&
				"		 ( select min(ventarifas_precios_packs.precio) "+&
				"		 from ventarifas_precios_packs  "+&
				"		 where empresa = prodpartes_ot.empresa  "+&
				"		 and ventarifas_precios_packs.articulos_codigo = prodpartes_ot.art_encajado  "+&
				"		 and ventarifas_codigo <> '5')  IS NOT NULL "+&
				"	THEN ( select min(ventarifas_precios_packs.precio) "+&
				"		 from ventarifas_precios_packs  "+&
				"		 where empresa = prodpartes_ot.empresa  "+&
				"		 and ventarifas_precios_packs.articulos_codigo = prodpartes_ot.art_encajado  "+&
				"		 and ventarifas_codigo <> '5') "+&
				"	ELSE   "+&
				"		( select min(ventarifas_precios.precio) "+&
				"		 from ventarifas_precios  "+&
				"		 where empresa = prodpartes_ot.empresa  "+&
				"		 and ventarifas_precios.articulos_codigo = prodpartes_ot.art_encajado  "+&
				"		 and ventarifas_codigo <> '5') "+&
				"	END "+&
				" ) AS IMPORTE2, "+&
" 		( case when articulos.unidad  = 0 then prodpartes_ot.buenas * prodpartes_ot.factor "+& 
" 		else ( ( prodpartes_ot.buenas  * prodpartes_ot.factor * ((formatos.ancho * formatos.largo) /10000) ) ) END ) * "+&
"				( CASE   "+&
"					WHEN ( select sum( ( (venlifac.neto - venlifac.impdtopp) / venlifac.cambio )) / NULLIF (sum (venlifac.cantidad), 0 )  "+&
"							 from venlifac  "+&
"							 inner join articulos on venlifac.empresa = articulos.empresa and venlifac.articulo = articulos.codigo  "+&
"							 where venlifac.empresa = '"+codigo_empresa+"'"+&
"							 and venlifac.articulo  =  prodpartes_ot.articulo  "+&
"							 and venlifac.tipo_unidad  =  articulos.unidad  "+&
"							 and venlifac.ffactura >= '01-04-2017' ) > 0  "+&
"					THEN ( select sum( ( (venlifac.neto - venlifac.impdtopp) / venlifac.cambio )) / NULLIF (sum (venlifac.cantidad), 0 )  "+&
"							 from venlifac  "+&
"							 inner join articulos on venlifac.empresa = articulos.empresa and venlifac.articulo = articulos.codigo  "+&
"							 where venlifac.empresa = '"+codigo_empresa+"' "+&
"							 and venlifac.articulo  =  prodpartes_ot.articulo   "+&
"							 and venlifac.tipo_unidad  =  articulos.unidad  "+&
"							 and venlifac.ffactura >= '01-04-2017' )  "+&
"					WHEN ( select min(ventarifas_precios_packs.precio)   "+&
"				 		from ventarifas_precios_packs    "+&
"				 		where empresa = prodpartes_ot.empresa    "+&
"				 		and ventarifas_precios_packs.articulos_codigo = prodpartes_ot.art_encajado    "+&
"				 		and ventarifas_codigo <> '5')  <> 0   "+&
"				 		OR    "+&
"				 		( select min(ventarifas_precios_packs.precio)   "+&
"						from ventarifas_precios_packs    "+&
"						where empresa = prodpartes_ot.empresa    "+&
"				 		and ventarifas_precios_packs.articulos_codigo = prodpartes_ot.art_encajado    "+&
"				 		and ventarifas_codigo <> '5')  IS NOT NULL   "+&
"					THEN ( select min(ventarifas_precios_packs.precio)   "+&
"						from ventarifas_precios_packs    "+&
"				 		where empresa = prodpartes_ot.empresa    "+&
"				 		and ventarifas_precios_packs.articulos_codigo = prodpartes_ot.art_encajado    "+&
"				 		and ventarifas_codigo <> '5')   "+&
"					ELSE     "+&
"						( select min(ventarifas_precios.precio)   "+&
"						from ventarifas_precios    "+&
"						where empresa = prodpartes_ot.empresa    "+&
"						and ventarifas_precios.articulos_codigo = prodpartes_ot.art_encajado    "+&
"				 		and ventarifas_codigo <> '5')   "+&
"				END   "+&
		" ) AS IMPORTE "+&
		" from prodpartes_ot , formatos, prodsecciones, prodlineas,  art_ver_operaciones, articulos "+&
		" where prodpartes_ot.empresa = '"+codigo_empresa+"'"+&
		" and formatos.empresa =  '"+codigo_empresa+"'"+&
		" and prodsecciones.empresa =  '"+codigo_empresa+"'"+&
		" and prodlineas.empresa =  '"+codigo_empresa+"'"+&
		" and art_ver_operaciones.empresa =  '"+codigo_empresa+"'"+&
		" and prodpartes_ot.empresa = articulos.empresa "+&
		" and prodpartes_ot.articulo = articulos.codigo "+&
		" and prodpartes_ot.articulo = art_ver_operaciones.articulo "+&
		" and prodpartes_ot.version = art_ver_operaciones.version "+&
		" and prodpartes_ot.ordenoperacion = art_ver_operaciones.orden "+&
		" and prodpartes_ot.fecha >='"+em_fdesde.text+"'"+&
		" and prodpartes_ot.fecha <= '"+em_fhasta.text+"'"+&
		" and prodpartes_ot.ajuste <> 'S' "+&
		" and prodpartes_ot.linea = prodlineas.codigo "+&
		" and prodpartes_ot.seccion = prodsecciones.codigo "+&
		" and prodpartes_ot.seccion = '9' "+&
		" and prodpartes_ot.formato = formatos.codigo "+&
		ls_filtro_familias+&
		ls_filtro_marcas+&
		ls_filtro_submarcas+&
		" order by prodsecciones.descripcion_abr, prodlineas.resumido"


f_cargar_cursor_nuevo (sel, datos)
st_contador.visible = true
total_regs = datos.rowcount() 

for i = 1 to total_regs
	fila_actual = data.insertrow(0)
	dw_informe.object.articulo[fila_actual] = datos.object.prodpartes_ot_articulo[i]
	dw_informe.object.seccion[fila_actual] = datos.object.prodsecciones_descripcion_abr[i]
	dw_informe.object.linea[fila_actual] = datos.object.prodlineas_resumido[i]
	dw_informe.object.piezas[fila_actual] = datos.object.prodpartes_ot_buenas[i]
	dw_informe.object.terminado[fila_actual] = datos.object.prodpartes_ot_art_terminado[i]
	dw_informe.object.metros[fila_actual] = datos.object.metros[i]
	dw_informe.object.importe[fila_actual] = datos.object.importe[i]
	dw_informe.object.importe2[fila_actual] = datos.object.importe2[i]
	dw_informe.object.descripcion[fila_actual] = datos.object.articulos_descripcion[i]
	dw_informe.object.formato[fila_actual] = datos.object.formatos_abreviado[i]
	dw_informe.object.importe[fila_actual] = datos.object.importe[i]
	if total_regs = 0 then
		st_contador.text = "Vacio"
	else
		st_contador.text =  "Cálculo 1/6 " +string(round( i * 100 / total_regs, 0 ) )+ " %"
	end if

next

destroy datos

//-------------------------------------------------------------------------
decimal importe_ped = 0, importe_alb = 0, importe_fac = 0, metros_lin_ped = 0
decimal piezas_ped = 0, piezas_alb = 0, piezas_fac = 0, metros_lin_fac = 0
decimal metros_ped = 0, metros_alb = 0, metros_fac = 0, metros_lin_alb = 0
decimal importe = 0, piezas = 0, metros = 0, metros_lin , precio_metro
datastore datos2
string sel2
long k

sel2 = &
" select venliped.empresa,   "+&
"        venliped.anyo,     "+&
"        venliped.pedido,     "+&
"        venliped.linea,    "+&
"			venliped.fpedido,  "+&
"			(venliped.cantidad * venliped.precio * ( 1 -  venliped.dtoesp / 100 ) * ( 1 -  venliped.dtoesp2 / 100 ) ) / venped.cambio as importe, "+&
"			(CASE WHEN venliped.tipo_unidad = '0' THEN venliped.cantidad ELSE round(((venliped.cantidad / round(av.metroscaja,2)) * av.piezascaja),0) END) * 1 as piezas, "+&
"			(CASE WHEN venliped.tipo_unidad = '1' THEN venliped.cantidad ELSE formatos.ancho * formatos.largo * venliped.cantidad / 10000 END) as metros, "+&
"			(CASE WHEN venliped.tipo_unidad = '1' THEN venliped.cantidad ELSE formatos.largo * venliped.cantidad / 100 END) as metros_lin "+&
" FROM venliped "+&
" INNER JOIN articulos ON venliped.articulo = articulos.codigo "+&
" INNER JOIN venped ON venped.anyo = venliped.anyo and venped.pedido = venliped.pedido "+&
" INNER JOIN formatos ON articulos.formato = formatos.codigo "+&
" LEFT OUTER JOIN almartcajas av ON venliped.empresa = av.empresa AND venliped.articulo = av.articulo AND venliped.caja = av.caja "+&
" where venliped.empresa = '"+codigo_empresa+  "' "+&
" and articulos.empresa = '"+codigo_empresa+  "' "+&
" and formatos.empresa = '"+codigo_empresa+  "' "+&
" and venped.empresa = '"+codigo_empresa+  "' "+&
" and venped.anyo = venliped.anyo "+&
" and venped.pedido = venliped.pedido "+&
" and venliped.articulo = articulos.codigo "+&
" and articulos.formato = formatos.codigo "+&
" and venped.es_proforma = 'N' "+&
" and av.metroscaja <> 0 "+&
" and venliped.fpedido >= '"+string(fecha1)+  "' "+&
" and venliped.fpedido <= '"+string(fecha2)+  "' "+&
		ls_filtro_familias+&
		ls_filtro_marcas+&
		ls_filtro_submarcas+&
" union "+&
" select venlialb.empresa, "+&
" 			venlialb.anyo_pedido_origen,  "+&
" 			venlialb.pedido_origen,  "+&
" 			venlialb.linea_pedido_origen,  "+&
" 			venlialb.fpedido_origen, "+&
"			( venlialb.cantidad * venlialb.precio * ( 1 -  venlialb.dtoesp / 100  )* ( 1 -  venlialb.dtoesp2 / 100  ) ) / venalb.cambio as importe,  "+&
" 			(CASE WHEN venlialb.tipo_unidad = '0' THEN venlialb.cantidad ELSE round(((venlialb.cantidad / round(av.metroscaja,2)) * av.piezascaja),0) END) * 1 as piezas,  "+&
" 			(CASE WHEN venlialb.tipo_unidad = '1' THEN venlialb.cantidad ELSE formatos.ancho * formatos.largo * venlialb.cantidad / 10000 END) as metros, "+&
" 			(CASE WHEN venlialb.tipo_unidad = '1' THEN venlialb.cantidad ELSE formatos.largo * venlialb.cantidad / 100 END) as metros_lin "+&
" from venlialb "+&
" INNER JOIN venalb ON venalb.anyo = venlialb.anyo and venalb.albaran = venlialb.albaran "+&
" INNER JOIN articulos ON venlialb.articulo = articulos.codigo "+&
" INNER JOIN formatos ON articulos.formato = formatos.codigo "+&
" LEFT OUTER JOIN almartcajas av ON venlialb.empresa = av.empresa AND venlialb.articulo = av.articulo AND venlialb.caja = av.caja "+&
" where venlialb.empresa = '"+codigo_empresa+  "' "+&
" and articulos.empresa = '"+codigo_empresa+  "' "+&
" and formatos.empresa = '"+codigo_empresa+  "' "+&
" and venalb.empresa = '"+codigo_empresa+  "' "+&
" and venalb.anyo = venlialb.anyo "+&
" and venalb.albaran = venlialb.albaran "+&
" and venlialb.articulo = articulos.codigo "+&
" and articulos.formato = formatos.codigo "+&
" and av.metroscaja <> 0 "+&
" and venlialb.fpedido_origen >= '"+string(fecha1)+  "' "+&
" and venlialb.fpedido_origen <= '"+string(fecha2)+  "' "+&
		ls_filtro_familias+&
		ls_filtro_marcas+&
		ls_filtro_submarcas+&
" union "+&
" select venlifac.empresa,  "+&
" 			venlifac.anyo_pedido_origen,  "+&
" 			venlifac.pedido_origen,  "+&
" 			venlifac.linea_pedido_origen,  "+&
" 			venlifac.fpedido_origen, "+&
" 			( venlifac.cantidad * venlifac.precio * ( 1 -  venlifac.dtoesp / 100  ) * ( 1 -  venlifac.dtoesp2 / 100 ) ) / venlifac.cambio as importe,  "+&
" 			(CASE WHEN venlifac.tipo_unidad = '0' THEN venlifac.cantidad ELSE round(((venlifac.cantidad / round(av.metroscaja,2)) * av.piezascaja),0) END)  * 1 as piezas, "+&
" 			(CASE WHEN venlifac.tipo_unidad = '1' THEN venlifac.cantidad ELSE formatos.ancho * formatos.largo * venlifac.cantidad / 10000 END) as metros, "+&
" 			(CASE WHEN venlifac.tipo_unidad = '1' THEN venlifac.cantidad ELSE formatos.largo * venlifac.cantidad / 100 END) as metros_lin "+&
" from venlifac "+&
" INNER JOIN articulos ON venlifac.articulo = articulos.codigo "+& 
" INNER JOIN formatos ON articulos.formato = formatos.codigo "+&
" INNER JOIN venfac  ON venfac.anyo = venlifac.anyo and venfac.factura = venlifac.factura "+&
" LEFT OUTER JOIN almartcajas av ON venlifac.empresa = av.empresa AND venlifac.articulo = av.articulo AND venlifac.caja = av.caja "+&
" where venlifac.empresa = '"+codigo_empresa+  "' "+&
" and articulos.empresa = '"+codigo_empresa+  "' "+&
" and formatos.empresa = '"+codigo_empresa+  "' "+&
" and venfac.empresa = '"+codigo_empresa+  "' "+&
" and venfac.anyo = venlifac.anyo "+&
" and venfac.factura = venlifac.factura "+&
" and ( venlifac.factura_deposito <> 'S' or venlifac.factura_deposito is null ) "+&
" and venlifac.articulo = articulos.codigo "+&
" and articulos.formato = formatos.codigo "+&
" and av.metroscaja <> 0 "+&
" and venlifac.fpedido_origen >= '"+string(fecha1)+  "' "+&
" and venlifac.fpedido_origen <= '"+string(fecha2)+  "' "+&
		ls_filtro_familias+&
		ls_filtro_marcas+&
		ls_filtro_submarcas


f_cargar_cursor_nuevo (sel2, datos )
if fila_actual > 0 then
	for k = 1 to datos.rowcount()
		importe = importe + datos.object.importe[k]	
		piezas = piezas + datos.object.piezas[k]	
		metros = metros + datos.object.metros[k]	
	next
	
	if metros <> 0 then
		precio_metro = importe / metros
	else 
		precio_metro = 0
	end if
	dw_informe.object.t_importe.text = String(importe,"###,###,###")
	dw_informe.object.t_piezas.text = String(piezas,"###,###,###")
	dw_informe.object.t_metros.text = String(metros,"###,###,###")
	dw_informe.object.t_precio_metro.text = String(precio_metro,"###,###,##0.0")
	
	dw_informe.object.dif_importe.text = String(dw_informe.object.total_importe[fila_actual] - importe,"###,###,###")
	dw_informe.object.dif_piezas.text = String(dw_informe.object.total_piezas[fila_actual] - piezas,"###,###,###")
	dw_informe.object.dif_metros.text = String(dw_informe.object.total_metros[fila_actual] - metros,"###,###,###")
	
	if dw_informe.object.total_importe[fila_actual] <> 0 then
		dw_informe.object.t_por_importe.text = String( ( (dw_informe.object.total_importe[fila_actual] - importe) * 100 ) / dw_informe.object.total_importe[fila_actual] ,"###,###,###")
	end if
	if dw_informe.object.total_piezas[fila_actual] <> 0 then
		dw_informe.object.t_por_piezas.text = String( ( (dw_informe.object.total_piezas[fila_actual] - piezas) * 100 ) / dw_informe.object.total_piezas[fila_actual] ,"###,###,###")
	end if
	if dw_informe.object.total_metros[fila_actual] <> 0 then
		dw_informe.object.t_por_metros.text = String( ( (dw_informe.object.total_metros[fila_actual] - metros) * 100 ) / dw_informe.object.total_metros[fila_actual] ,"###,###,###")
	end if
end if

destroy datos2

//-------------------------------------------------------------------------





st_contador.visible = false
data.sort()
data.groupcalc()
data.setredraw(true)


end subroutine

event close;call super::close;dw_informe.reset()

end event

event open;call super::open;string mes
integer permiso

istr_parametros.s_titulo_ventana="Informe Valor de la  Producción"
This.title=istr_parametros.s_titulo_ventana

em_fhasta.text = string(RelativeDate(today(), -1),"dd-mm-yy")
sle_semanas.text = '1'
em_fdesde.text = string(RelativeDate(date(em_fhasta.text), -6 * long(sle_semanas.text)),"dd-mm-yy")

uo_familias.f_cargar_datos("dw_ayuda_familias","%","","Familia","Descripción")
uo_marcas.f_cargar_datos("dw_ayuda_marcas","%","","Marca","Descripción")
uo_submarcas.f_cargar_datos("dw_ayuda_Submarcas","%","","Submarca","Descripción")

permiso = f_permiso_usuario(this.classname(), nombre_usuario)
choose case  permiso
	case 0
		MESSAGEBOX("Atención. Consulte con el Administrador",nombre_usuario+", No tienes Acceso a este programa")
		close(this)
		return
end choose
end event

on w_con_valor_produccion2.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.cb_1=create cb_1
this.gb_1=create gb_1
this.gb_6=create gb_6
this.dw_informe=create dw_informe
this.em_fdesde=create em_fdesde
this.em_fhasta=create em_fhasta
this.sle_semanas=create sle_semanas
this.st_1=create st_1
this.cb_2=create cb_2
this.cbx_resumen=create cbx_resumen
this.st_contador=create st_contador
this.uo_familias=create uo_familias
this.uo_marcas=create uo_marcas
this.uo_submarcas=create uo_submarcas
this.cb_familias=create cb_familias
this.cb_marcas=create cb_marcas
this.cb_submarcas=create cb_submarcas
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.gb_6
this.Control[iCurrent+6]=this.dw_informe
this.Control[iCurrent+7]=this.em_fdesde
this.Control[iCurrent+8]=this.em_fhasta
this.Control[iCurrent+9]=this.sle_semanas
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.cb_2
this.Control[iCurrent+12]=this.cbx_resumen
this.Control[iCurrent+13]=this.st_contador
this.Control[iCurrent+14]=this.uo_familias
this.Control[iCurrent+15]=this.uo_marcas
this.Control[iCurrent+16]=this.uo_submarcas
this.Control[iCurrent+17]=this.cb_familias
this.Control[iCurrent+18]=this.cb_marcas
this.Control[iCurrent+19]=this.cb_submarcas
end on

on w_con_valor_produccion2.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.gb_6)
destroy(this.dw_informe)
destroy(this.em_fdesde)
destroy(this.em_fhasta)
destroy(this.sle_semanas)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cbx_resumen)
destroy(this.st_contador)
destroy(this.uo_familias)
destroy(this.uo_marcas)
destroy(this.uo_submarcas)
destroy(this.cb_familias)
destroy(this.cb_marcas)
destroy(this.cb_submarcas)
end on

event ue_f5;f_control(dw_informe)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_valor_produccion2
integer y = 612
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_valor_produccion2
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_valor_produccion2
integer x = 5
integer y = 8
integer width = 3717
integer height = 84
end type

type pb_1 from upb_salir within w_con_valor_produccion2
integer x = 3616
integer y = 144
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type pb_2 from upb_imprimir within w_con_valor_produccion2
integer x = 3470
integer y = 144
integer taborder = 0
boolean originalsize = false
end type

event clicked;//f_control(dw_informe)
f_imprimir_datawindow(dw_informe)

end event

type cb_1 from commandbutton within w_con_valor_produccion2
integer x = 3173
integer y = 144
integer width = 288
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

event clicked; f_control(dw_informe)

end event

type gb_1 from groupbox within w_con_valor_produccion2
integer x = 14
integer y = 96
integer width = 2555
integer height = 160
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Fecha"
end type

type gb_6 from groupbox within w_con_valor_produccion2
integer x = 3150
integer y = 100
integer width = 599
integer height = 156
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type dw_informe from datawindow within w_con_valor_produccion2
integer y = 268
integer width = 3744
integer height = 2256
boolean bringtotop = true
string dataobject = "dw_con_valor_produccion2"
boolean vscrollbar = true
boolean livescroll = true
end type

type em_fdesde from u_em_campo within w_con_valor_produccion2
integer x = 46
integer y = 152
integer width = 357
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 79741120
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type em_fhasta from u_em_campo within w_con_valor_produccion2
integer x = 411
integer y = 152
integer width = 357
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 79741120
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type sle_semanas from singlelineedit within w_con_valor_produccion2
integer x = 1079
integer y = 148
integer width = 201
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event losefocus;if long(sle_semanas.text) = 1 then
	em_fdesde.text = string(RelativeDate(date(em_fhasta.text), -6 * long(sle_semanas.text)),"dd-mm-yy")
else
	em_fdesde.text = string(RelativeDate(date(em_fhasta.text), ( -7 * ( long( sle_semanas.text ) -1 ) ) - 6 ),"dd-mm-yy")
end if

end event

type st_1 from statictext within w_con_valor_produccion2
integer x = 782
integer y = 156
integer width = 302
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Semanas:"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_con_valor_produccion2
boolean visible = false
integer x = 2464
integer y = 2124
integer width = 709
integer height = 112
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Actualiza Factor"
end type

event clicked;string sel
string operario, linea, turno
long contador, i
decimal factor
datetime fecha
datastore partes
boolean  error_actualizando 

if MessageBox("Atencion", "¿Desea Continuar? ", Exclamation!, YesNo!, 2) = 1 then

	sel =  " select prodpartes_ot.empresa, prodpartes_ot.operario, prodpartes_ot.linea, prodpartes_ot.fecha, "+& 
					  " prodpartes_ot.turno, prodpartes_ot.contador, art_ver_operaciones.factor "+&
			 " from prodpartes_ot, art_ver_operaciones "+&
			 " where prodpartes_ot.empresa = '1' "+&
			 " and art_ver_operaciones.empresa = '1' "+&
			 " and prodpartes_ot.articulo = art_ver_operaciones.articulo " +&
			 " and prodpartes_ot.version = art_ver_operaciones.version "+&
			 " and prodpartes_ot.ordenoperacion = art_ver_operaciones.orden "
	
	f_cargar_cursor_nuevo (sel, partes)
	
	error_actualizando = false
	for i = 1 to partes.rowcount()
		operario = partes.object.prodpartes_ot_operario[i]
		linea = partes.object.prodpartes_ot_linea[i]
		fecha = partes.object.prodpartes_ot_fecha[i]
		turno = partes.object.prodpartes_ot_turno[i]
		contador = partes.object.prodpartes_ot_contador[i]
		factor = partes.object.art_ver_operaciones_factor[i]
		
		update prodpartes_ot set factor = :factor 
		where empresa =:codigo_empresa
		and operario = :operario
		and linea = :linea
		and fecha = :fecha
		and turno = :turno
		and contador = :contador
		using SQLCA;
		
		IF SQLCA.SQLCode = -1 THEN 
			  error_actualizando = true
			  MessageBox("SQL error", SQLCA.SQLErrText)
		END IF
	
		f_mensaje_proceso ("Partes:", i, partes.rowcount())
		
	next
	
	if error_actualizando then
		rollback using SQLCA;
	else
		commit using SQLCA;
	end if

end if
end event

type cbx_resumen from checkbox within w_con_valor_produccion2
integer x = 2798
integer y = 156
integer width = 343
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Resumen"
boolean checked = true
borderstyle borderstyle = styleraised!
end type

event clicked;if cbx_resumen.checked then
	dw_informe.Modify("DataWindow.Detail.Height=0")
else
	dw_informe.Modify("DataWindow.Detail.Height=170")
end if



end event

type st_contador from statictext within w_con_valor_produccion2
boolean visible = false
integer x = 2162
integer y = 156
integer width = 398
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 65535
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type uo_familias from u_marca_lista within w_con_valor_produccion2
event destroy ( )
boolean visible = false
integer x = 1285
integer y = 252
integer taborder = 110
boolean bringtotop = true
boolean border = false
end type

on uo_familias.destroy
call u_marca_lista::destroy
end on

event itemchanged;call super::itemchanged;//Aqui vamos a filtrar las marcas que debemos ver
long ll_indice,ll_total,ll_indice2,ll_total2
string ls_sel,ls_marcas_a_mostrar,ls_marca
datastore ds_datos

ll_total = this.dw_marca.RowCount()

for ll_indice = 1 to ll_total
	if (this.dw_marca.object.marca[ll_indice] = 'S' or (ll_indice = row and data = 'S')) and not(ll_indice = row and data = 'N') then
		ls_sel = "select marcas.codigo from marcas where empresa = '"+codigo_empresa+"' and familias_codigo = '"+this.dw_marca.object.codigo[ll_indice]+"'"
		
		ll_total2 = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)
		
		for ll_indice2 = 1 to ll_total2
			ls_marca = ds_datos.object.codigo[ll_indice2]
			
			if ls_marcas_a_mostrar = "" then
				ls_marcas_a_mostrar = "'"+ls_marca+"'"
			else
				ls_marcas_a_mostrar += ",'"+ls_marca+"'"
			end if
		next
		
		destroy ds_datos
		
	end if
next

if ls_marcas_a_mostrar <> "" then
	uo_marcas.dw_marca.setfilter("codigo in ("+ls_marcas_a_mostrar+")")
else
	uo_marcas.dw_marca.setfilter("0 = 1")
end if
uo_marcas.dw_marca.filter()
uo_marcas.event itemchanged(0,dwo,"")

end event

type uo_marcas from u_marca_lista within w_con_valor_produccion2
event destroy ( )
boolean visible = false
integer x = 1573
integer y = 252
integer taborder = 120
boolean bringtotop = true
boolean border = false
end type

on uo_marcas.destroy
call u_marca_lista::destroy
end on

event itemchanged;call super::itemchanged;//Aqui vamos a filtrar las submarcas que debemos ver
long ll_indice,ll_total,ll_indice2,ll_total2
string ls_sel,ls_submarcas_a_mostrar,ls_submarca
datastore ds_datos

ll_total = this.dw_marca.RowCount()

for ll_indice = 1 to ll_total
	if (this.dw_marca.object.marca[ll_indice] = 'S' or (ll_indice = row and data = 'S')) and not(ll_indice = row and data = 'N') then
		ls_sel = "select submarcas.codigo from submarcas where empresa = '"+codigo_empresa+"' and marcas_codigo = '"+this.dw_marca.object.codigo[ll_indice]+"'"
		
		ll_total2 = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)
		
		for ll_indice2 = 1 to ll_total2
			ls_submarca = ds_datos.object.codigo[ll_indice2]
			
			if ls_submarcas_a_mostrar = "" then
				ls_submarcas_a_mostrar = "'"+ls_submarca+"'"
			else
				ls_submarcas_a_mostrar += ",'"+ls_submarca+"'"
			end if
		next
		
		destroy ds_datos
		
	end if
next

if ls_submarcas_a_mostrar <> "" then
	uo_submarcas.dw_marca.setfilter("codigo in ("+ls_submarcas_a_mostrar+")")
else
	uo_submarcas.dw_marca.setfilter("0 = 1")
end if
uo_submarcas.dw_marca.filter()
uo_submarcas.event itemchanged(0,dwo,"")

end event

type uo_submarcas from u_marca_lista within w_con_valor_produccion2
event destroy ( )
boolean visible = false
integer x = 1861
integer y = 252
integer taborder = 130
boolean bringtotop = true
boolean border = false
end type

on uo_submarcas.destroy
call u_marca_lista::destroy
end on

type cb_familias from commandbutton within w_con_valor_produccion2
integer x = 1289
integer y = 152
integer width = 297
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Familias"
end type

event clicked;
uo_familias.visible = not(uo_familias.visible)

uo_marcas.visible = false

uo_submarcas.visible = false
end event

type cb_marcas from commandbutton within w_con_valor_produccion2
integer x = 1577
integer y = 152
integer width = 297
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Marcas"
end type

event clicked;
uo_familias.visible = false

uo_marcas.visible = not(uo_marcas.visible)

uo_submarcas.visible = false
end event

type cb_submarcas from commandbutton within w_con_valor_produccion2
integer x = 1865
integer y = 152
integer width = 297
integer height = 84
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "SubMarcas"
end type

event clicked;
uo_familias.visible = false

uo_marcas.visible = false

uo_submarcas.visible = not(uo_submarcas.visible)
end event

