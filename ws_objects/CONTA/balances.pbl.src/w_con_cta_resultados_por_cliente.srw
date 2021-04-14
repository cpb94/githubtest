$PBExportHeader$w_con_cta_resultados_por_cliente.srw
forward
global type w_con_cta_resultados_por_cliente from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_cta_resultados_por_cliente
end type
type pb_2 from upb_imprimir within w_con_cta_resultados_por_cliente
end type
type cb_1 from commandbutton within w_con_cta_resultados_por_cliente
end type
type gb_6 from groupbox within w_con_cta_resultados_por_cliente
end type
type dw_resumen from datawindow within w_con_cta_resultados_por_cliente
end type
type uo_cliente from u_em_campo_2 within w_con_cta_resultados_por_cliente
end type
type em_fechadesde from u_em_campo within w_con_cta_resultados_por_cliente
end type
type em_fechahasta from u_em_campo within w_con_cta_resultados_por_cliente
end type
type cbx_mermas from checkbox within w_con_cta_resultados_por_cliente
end type
type uo_familia from u_em_campo_2 within w_con_cta_resultados_por_cliente
end type
type cb_paises from commandbutton within w_con_cta_resultados_por_cliente
end type
type uo_paises from u_marca_lista within w_con_cta_resultados_por_cliente
end type
type uo_articulo from u_em_campo_2 within w_con_cta_resultados_por_cliente
end type
type gb_4 from groupbox within w_con_cta_resultados_por_cliente
end type
type gb_1 from groupbox within w_con_cta_resultados_por_cliente
end type
type gb_8 from groupbox within w_con_cta_resultados_por_cliente
end type
type gb_2 from groupbox within w_con_cta_resultados_por_cliente
end type
type r_1 from rectangle within w_con_cta_resultados_por_cliente
end type
end forward

global type w_con_cta_resultados_por_cliente from w_int_con_empresa
integer x = 46
integer y = 32
integer width = 5253
integer height = 3180
pb_1 pb_1
pb_2 pb_2
cb_1 cb_1
gb_6 gb_6
dw_resumen dw_resumen
uo_cliente uo_cliente
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
cbx_mermas cbx_mermas
uo_familia uo_familia
cb_paises cb_paises
uo_paises uo_paises
uo_articulo uo_articulo
gb_4 gb_4
gb_1 gb_1
gb_8 gb_8
gb_2 gb_2
r_1 r_1
end type
global w_con_cta_resultados_por_cliente w_con_cta_resultados_por_cliente

type variables

end variables

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);string v_cliente, sel, v_cod_articulo, mensaje_fabricacion, mensaje_mp, v_articulo
long  i, j, fila_actual
datastore datos, datos2
dec {6} v_coste_fab_Art, v_coste_mp_art, v_coste_fab_tot, v_coste_mp_tot, v_cantidad,  importe_muestras
dec {6}  v_coste_packing_art, v_coste_compras_art, v_coste_packing_tot, v_coste_compras_tot, comision
dec {6} v_coste_estr, v_coste_estr_tot, v_coste_promo, v_coste_promo_tot, v_bruto_sin_familia
boolean con_mermas
string filtro
string tipoLinea, tipoLinea2, tipoLinea3, v_familia, v_pais
string v_promocion
integer li_indice,li_opciones,li_opciones_marcadas
string ls_filtro, ls_texto_seleccion, ls_filtro_paises

uo_paises.visible = false

tipoLinea = "3, 4, 5, '9', 11, 17, 20"
tipoLinea2 = "3, 5, 11, 17, 20"
tipoLinea3 = "4, 9"

dw_resumen.object.periodo.text = "Desde "+em_fechadesde.text+" al "+em_fechahasta.text

if uo_cliente.em_codigo.text = '' or isnull (uo_cliente.em_codigo.text) then
	v_cliente = '%'
else
	v_cliente = uo_cliente.em_codigo.text
end if

if uo_familia.em_codigo.text = '' or isnull (uo_familia.em_codigo.text) then
	v_familia = '%'
else
	v_familia = uo_familia.em_codigo.text
end if

if uo_articulo.em_codigo.text = '' or isnull (uo_articulo.em_codigo.text) then
	v_articulo = '%'
else
	v_articulo = uo_articulo.em_codigo.text
end if


	//Filtro de paises
li_opciones = uo_paises.dw_marca.RowCount()
li_opciones_marcadas = 0
ls_filtro= ''
ls_texto_seleccion = ''
for li_indice = 1 to li_opciones
	if uo_paises.dw_marca.object.marca[li_indice]='S' then
		li_opciones_marcadas ++
		if li_opciones_marcadas > 1 then
			ls_filtro += ",'"+uo_paises.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion += ","+uo_paises.dw_marca.object.texto[li_indice]
		else
			ls_filtro = "'"+uo_paises.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion = uo_paises.dw_marca.object.texto[li_indice]
		end if
	end if
next

//if li_opciones_marcadas > 0 then
	ls_filtro_paises = "("+ls_filtro+") "
//	if li_opciones_marcadas > 1 then
//		ls_filtro_paises = " and genter.pais in ("+ls_filtro+") "
//	else
//		ls_filtro_paises = " and genter.pais = "+ls_filtro+" "
//	end if
//end if

dw_resumen.object.t_familia.text = uo_familia.em_campo.text


data.SetTransObject(SQLCA)
data.Reset()

sel = " SELECT venlifac.cliente "+&
				" , genter.razon "+&
				" , venclientes.prev_rappel "+&
				" , venclientes.coste_pieza "+&
				" , venclientes.coste_anyo, venclientes.por_coste_transporte "+&
				" , (	SELECT sum( V4.bruto / v4.cambio ) "+&
				" 		FROM venlifac V4 "+&
				" 		INNER JOIN venfac ON V4.empresa = venfac.empresa AND V4.anyo = venfac.anyo AND V4.factura = venfac.factura "+&
				" 		INNER JOIN articulos A4 ON V4.empresa = A4.empresa AND V4.articulo = A4.codigo "+&
				" 		WHERE V4.tipolinea not in ("+tipolinea+") "+&				
				" 		AND V4.ffactura between  '"+em_fechadesde.text+"' AND '"+ em_fechahasta.text +"' " +&
		      	" 		AND V4.pais in "+ls_filtro_paises+&
		      	" 		AND A4.familia like '"+v_familia+"'" +&
					" 		AND V4.articulo like '"+v_articulo+"' " +&
				" 		AND V4.cliente = venlifac.cliente ) AS bruto "+&
				" , ( 	SELECT sum( V4.bruto / v4.cambio ) "+&
				" 		FROM venlifac V4 "+&
				" 		INNER JOIN venfac ON V4.empresa = venfac.empresa AND V4.anyo = venfac.anyo AND V4.factura = venfac.factura "+&
				" 		INNER JOIN articulos A4 ON V4.empresa = A4.empresa AND V4.articulo = A4.codigo "+&
				" 		WHERE V4.tipolinea not in ("+tipolinea+") "+&				
				" 		AND V4.ffactura between  '"+em_fechadesde.text+"' AND '"+ em_fechahasta.text +"' " +&
		      	" 		AND V4.pais in "+ls_filtro_paises+&
					" 		AND V4.articulo like '"+v_articulo+"' " +&
				" 		AND V4.cliente = venlifac.cliente ) AS bruto_sin_familia "+&
				" , ( 	SELECT sum( V5.importedto / v5.cambio ) "+&
				" 		FROM venlifac V5 "+&
				" 		INNER JOIN venfac ON V5.empresa = venfac.empresa AND V5.anyo = venfac.anyo AND V5.factura = venfac.factura "+&
				" 		INNER JOIN articulos A5 ON V5.empresa = A5.empresa AND V5.articulo = A5.codigo "+&
				" 		WHERE V5.tipolinea not in ("+tipolinea+") "+&				
				" 		AND V5.ffactura between  '"+em_fechadesde.text+"' AND '"+ em_fechahasta.text +"' " +&
		      	" 		AND A5.familia like '"+v_familia+"'" +&
		      	" 		AND V5.pais in "+ls_filtro_paises+&
					" 		AND V5.articulo like '"+v_articulo+"' " +&
				" 		AND V5.cliente = venlifac.cliente ) AS dtoesp1 "+&
				" , ( 	SELECT sum( V6.impdtopp / v6.cambio ) "+&
				" 		FROM venlifac V6 "+&
				" 		INNER JOIN venfac ON V6.empresa = venfac.empresa AND V6.anyo = venfac.anyo AND V6.factura = venfac.factura "+&
				" 		INNER JOIN articulos A6 ON V6.empresa = A6.empresa AND V6.articulo = A6.codigo "+&
				" 		WHERE V6.tipolinea not in ("+tipolinea+") "+&				
				" 		AND V6.ffactura between  '"+em_fechadesde.text+"' AND '"+ em_fechahasta.text +"' " +&
		      	"	 	AND A6.familia like '"+v_familia+"'" +&
		      	" 		AND V6.pais in "+ls_filtro_paises+&
					" 		AND V6.articulo like '"+v_articulo+"' " +&
				" 		AND V6.cliente = venlifac.cliente ) AS dtopp "+&
				" , sum ((venlifac.neto / venfac.cambio) * (	CASE WHEN isnull(venlifac.control_comisiones,'N') = 'N'  "+&
				"															THEN 0  "+&
				"															ELSE isnull(venfac.comision11,0)+isnull(venfac.comision12,0)+isnull(venfac.comision21,0)+isnull(venfac.comision22,0)+isnull(venfac.comision31,0)+isnull(venfac.comision32,0)  "+&
				"															END) / 100 )  comision  " +&
				" , ( 	SELECT sum( V2.cantidad "+&
				"	 								*	CASE WHEN ventarifas_precios_packs.precio is null or ventarifas_precios_packs.precio = 0 "+&
				" 										THEN isnull(ventarifas_precios.precio,0)  "+&
				" 										ELSE isnull(ventarifas_precios_packs.precio,0)  "+&
				" 										END ) "+&
				" 		FROM venlifac V2 "+&
				" 		INNER JOIN venfac ON V2.empresa = venfac.empresa AND V2.anyo = venfac.anyo AND V2.factura = venfac.factura "+&
				" 		LEFT OUTER JOIN ventarifas_precios ON V2.empresa = ventarifas_precios.empresa AND V2.articulo = ventarifas_precios.articulos_codigo AND venfac.tarifa = ventarifas_precios.ventarifas_codigo  "+&
				" 		LEFT OUTER JOIN ventarifas_precios_packs ON V2.empresa = ventarifas_precios_packs.empresa AND V2.articulo = ventarifas_precios_packs.articulos_codigo AND venfac.tarifa = ventarifas_precios_packs.ventarifas_codigo  "+&
				" 		INNER JOIN articulos A2 ON V2.empresa = A2.empresa AND V2.articulo = A2.codigo "+&
				" 		WHERE ( V2.clase = 'M' OR V2.clase = 'S'  )  "+&
				" 		AND V2.tipolinea not in ("+tipolinea+") "+&					
				" 		AND V2.ffactura between  '"+em_fechadesde.text+"' AND '"+ em_fechahasta.text +"' " +&
		      	" 		AND A2.familia like '"+v_familia+"'" +&
		      	" 		AND V2.pais in "+ls_filtro_paises+&
					" 		AND V2.articulo like '"+v_articulo+"' " +&
				" 		AND V2.cliente = venlifac.cliente ) AS muestras "+&
				" , ( 	SELECT sum( V3.neto / v3.cambio ) "+&
				" 		FROM venlifac V3 "+&
				" 		INNER JOIN venfac ON V3.empresa = venfac.empresa AND V3.anyo = venfac.anyo AND V3.factura = venfac.factura "+&
				" 		INNER JOIN articulos A3 ON V3.empresa = A3.empresa AND V3.articulo = A3.codigo "+&
				" 		WHERE V3.tipolinea IN ("+tipolinea3+") "+&					
				" 		AND V3.ffactura between  '"+em_fechadesde.text+"' and '"+ em_fechahasta.text +"' " +&
		      	" 		AND A3.familia like '"+v_familia+"'" +&
		      	" 		AND V3.pais in "+ls_filtro_paises+&
					" 		AND V3.articulo like '"+v_articulo+"' " +&
				" 		AND V3.cliente = venlifac.cliente ) AS ventas_promocion "+&
		" FROM venlifac, genter, venclientes, venfac, articulos  " +&
		" WHERE venlifac.empresa = '"+codigo_empresa+"' " +&
		" AND venlifac.empresa = venfac.empresa  "+&
		" AND venlifac.anyo = venfac.anyo  "+&
		" AND venlifac.factura = venfac.factura" +&
		" AND venlifac.empresa = genter.empresa " +&
		" AND genter.tipoter = 'C' " +&
		" AND venlifac.empresa = articulos.empresa " +&
		" AND venlifac.articulo = articulos.codigo " +&
		" AND articulos.familia like '"+v_familia+"'" +&
		" AND venlifac.empresa = venclientes.empresa " +&
		" AND venlifac.cliente = venclientes.codigo " +&
		" AND venlifac.cliente = genter.codigo " +&
		" AND venlifac.cliente like '"+v_cliente+"'" +&
		" AND venlifac.pais in "+ls_filtro_paises+&
		" AND venlifac.tipolinea NOT IN ("+tipolinea2+") "+&					
		" AND venlifac.ffactura between  '"+em_fechadesde.text+"' AND '"+ em_fechahasta.text +"' " +&
		" AND venlifac.articulo like '"+v_articulo+"' " +&
		" GROUP BY venlifac.cliente "+&
		" 			, genter.razon "+&
		"			, venclientes.prev_rappel "+&
		"			, venclientes.coste_pieza "+&
		"			, venclientes.coste_anyo "+&
		"			, venclientes.por_coste_transporte "+&
		" ORDER BY genter.razon  "

f_cargar_cursor_nuevo(sel, datos)

for i = 1 to datos.rowcount()
	fila_actual = dw_resumen.InsertRow(0)

	dw_resumen.object.cod_cliente[fila_actual] = datos.object.venlifac_cliente[i]

	v_cliente = datos.object.venlifac_cliente[i]
	dw_resumen.object.cliente[fila_actual] = datos.object.genter_razon[i]

	if isnull(datos.object.bruto[i]) then
		dw_resumen.object.ventas[i] = 0
	else
		dw_resumen.object.ventas[i] = datos.object.bruto[i]
	end if
	if isnull(datos.object.bruto_sin_familia[i]) then
		dw_resumen.object.bruto_sin_familia[i] = 0
	else
		dw_resumen.object.bruto_sin_familia[i] = datos.object.bruto_sin_familia[i]
	end if
	
	if isnull(datos.object.comision[i] )then
		dw_resumen.object.comision[i] = 0
	else		
		dw_resumen.object.comision[i] = datos.object.comision[i]
	end if
	if isnull (datos.object.ventas_promocion[i] ) then
		dw_resumen.object.ventas_promocion[i] = 0
	else
		dw_resumen.object.ventas_promocion[i] = datos.object.ventas_promocion[i]
	end if
	if isnull(datos.object.muestras[i] ) then
		dw_resumen.object.muestras[i] = 0
	else
		dw_resumen.object.muestras[i] = datos.object.muestras[i]
	end if
	if isnull(datos.object.dtopp[i]) then
		dw_resumen.object.dtopp[i] = 0
	else
		dw_resumen.object.dtopp[i] = datos.object.dtopp[i]
	end if
	if isnull(datos.object.dtoesp1[i]) then
		dw_resumen.object.dtoesp1[i] = 0
	else
		dw_resumen.object.dtoesp1[i] = datos.object.dtoesp1[i]
	end if
	if isnull (datos.object.venclientes_prev_rappel[i] )  then
		dw_resumen.object.rappel[fila_actual] = 0
	else
		dw_resumen.object.rappel[fila_actual] = datos.object.venclientes_prev_rappel[i]
	end if
	if isnull (datos.object.venclientes_por_coste_transporte[i] )  then
		dw_resumen.object.coste_transporte[fila_actual] = 0
		dw_resumen.object.por_coste_trans[fila_actual] = 0
		
	else
		dw_resumen.object.coste_transporte[fila_actual] = datos.object.bruto[i] * datos.object.venclientes_por_coste_transporte[i] / 100
		dw_resumen.object.por_coste_trans[fila_actual] = datos.object.venclientes_por_coste_transporte[i] / 100
	end if
	
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//														CÁLCULO COSTE MP Y COSTE FABRICACIÓN																//
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	mensaje_fabricacion = ''
	mensaje_mp = ''
	
	sel = " SELECT venlifac.articulo, articulos.promocion, isnull ( sum (CASE WHEN venlifac.tipo_unidad = '0' THEN venlifac.cantidad ELSE (venlifac.cantidad / av.metroscaja ) * av.piezascaja END), 0 )   cantidad, " +&
			" sum ( venlifac.cantidad * isnull (articulos.coste_Estimado, 0 )) coste_promo " +&	
			" from venlifac " +&
			" LEFT OUTER JOIN almartcajas av ON venlifac.empresa = av.empresa AND venlifac.articulo = av.articulo AND venlifac.caja = av.caja " +&
			" LEFT OUTER JOIN articulos ON venlifac.empresa = articulos.empresa AND venlifac.articulo = articulos.codigo " +&
			" where venlifac.empresa = '"+codigo_empresa+"' "+&
			" and venlifac.cliente = '"+v_cliente+"' "+&
			" and venlifac.pais in "+ls_filtro_paises+&
	      	" and articulos.familia like '"+v_familia+"'" +&
			" and venlifac.ffactura between  '"+em_fechadesde.text+"' and '"+ em_fechahasta.text +"' " +&
			" AND venlifac.articulo like '"+v_articulo+"' " +&
			" and venlifac.cantidad > 0 " +&
			" and venlifac.tipolinea <>  '19' " +&
			" group by venlifac.articulo, articulos.promocion "

			f_cargar_cursor_nuevo(sel, datos2)
			v_coste_fab_tot = 0
			v_coste_mp_tot = 0
			v_coste_packing_tot = 0
			v_coste_compras_tot = 0
			v_coste_promo_tot = 0

			for j = 1 to datos2.rowcount()
				
				v_cod_articulo = datos2.object.venlifac_articulo[j]
				v_promocion = datos2.object.articulos_promocion[j]
  				v_cantidad = datos2.object.cantidad[j]
			 	if isnull( datos2.object.coste_promo[j] ) then
					v_coste_promo = 0
				else
					v_coste_promo = datos2.object.coste_promo[j]
				end if
				
				v_coste_fab_art = 0
				v_coste_mp_art = 0
				v_coste_packing_art = 0
				v_coste_compras_art = 0
				
				if cbx_mermas.checked then
					con_mermas = true
				else
					con_mermas = false
				end if
			
				if v_promocion <> 'S' then		
					f_calculo_coste_articulo_mp_fab_packing_compras ( codigo_empresa, v_cod_articulo, v_coste_mp_art, v_coste_fab_art, con_mermas, v_coste_packing_art, v_coste_compras_art)
				end if
				
				v_coste_fab_art *= v_cantidad
				v_coste_mp_art *= v_cantidad
				v_coste_packing_art *= v_cantidad
				v_coste_compras_art *= v_cantidad

				if isnull (v_coste_fab_art) then
					v_coste_fab_art = 0
					mensaje_fabricacion = mensaje_fabricacion + v_cod_Articulo+", "
				end if
				if isnull (v_coste_mp_art) then
					v_coste_mp_art = 0
					mensaje_mp = mensaje_mp + v_cod_Articulo+", "
				end if
				if isnull (v_coste_packing_art) then
					v_coste_packing_art = 0
					mensaje_fabricacion = mensaje_fabricacion + v_cod_Articulo+", "
				end if
				if isnull (v_coste_compras_art) then
					v_coste_compras_art = 0
					mensaje_fabricacion = mensaje_fabricacion + v_cod_Articulo+", "
				end if
				
				v_coste_fab_tot += v_coste_fab_art
				v_coste_mp_tot += v_coste_mp_art
				v_coste_packing_tot += v_coste_packing_art
				v_coste_compras_tot += v_coste_compras_art
				v_coste_promo_tot += v_coste_promo
			next
			dw_resumen.object.coste_fab[i] = v_coste_fab_tot
			dw_resumen.object.coste_mp[i] = v_coste_mp_tot
			dw_resumen.object.coste_packing[i] = v_coste_packing_tot
			dw_resumen.object.coste_compras[i] = v_coste_compras_tot
			dw_resumen.object.coste_promo[i] = v_coste_promo_tot

			
			if isnull (dw_resumen.object.bruto_sin_familia[i])  or dw_resumen.object.bruto_sin_familia[i] = 0 then
				dw_resumen.object.coste_estr[i] =   datos.object.venclientes_coste_anyo[i] / 365  *  daysafter (date(em_fechadesde.text) , date(em_fechahasta.text) )
			else
				if not isnull (datos.object.venclientes_coste_anyo[i]) and datos.object.venclientes_coste_anyo[i] <> 0 then
					dw_resumen.object.coste_estr[i] = ( ( datos.object.venclientes_coste_anyo[i] / 365 ) * ( daysafter (date(em_fechadesde.text) , date(em_fechahasta.text) ) + 1)) * ( dw_resumen.object.ventas[i]  / dw_resumen.object.bruto_sin_familia[i] )
				else
					dw_resumen.object.coste_estr[i] = 0
				end if
			end if

			destroy datos2 

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
next


destroy datos
if mensaje_fabricacion <> '' or mensaje_mp <> '' then
	messagebox("Resumen ", "Falta coste de Fab a: "+mensaje_fabricacion+ "  Falta coste de MP a: "+mensaje_mp )
end if
end subroutine

event close;call super::close;
//dw_detalle.reset()

end event

event open;call super::open;istr_parametros.s_titulo_ventana="Informe de Facturación de Depósito por Clientes y Meses."
This.title=istr_parametros.s_titulo_ventana

em_fechadesde.text = string (RelativeDate (date(today()), -365), "dd-mm-yy")
em_fechahasta.text = string (date(today() ), "dd-mm-yy")
//em_anyo.text = string(year (date(today())))

valor_empresa = FALSE
uo_paises.f_cargar_datos("dw_ayuda_paises","%","","Pais","Descripción")
valor_empresa = TRUE
end event

on w_con_cta_resultados_por_cliente.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.cb_1=create cb_1
this.gb_6=create gb_6
this.dw_resumen=create dw_resumen
this.uo_cliente=create uo_cliente
this.em_fechadesde=create em_fechadesde
this.em_fechahasta=create em_fechahasta
this.cbx_mermas=create cbx_mermas
this.uo_familia=create uo_familia
this.cb_paises=create cb_paises
this.uo_paises=create uo_paises
this.uo_articulo=create uo_articulo
this.gb_4=create gb_4
this.gb_1=create gb_1
this.gb_8=create gb_8
this.gb_2=create gb_2
this.r_1=create r_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.gb_6
this.Control[iCurrent+5]=this.dw_resumen
this.Control[iCurrent+6]=this.uo_cliente
this.Control[iCurrent+7]=this.em_fechadesde
this.Control[iCurrent+8]=this.em_fechahasta
this.Control[iCurrent+9]=this.cbx_mermas
this.Control[iCurrent+10]=this.uo_familia
this.Control[iCurrent+11]=this.cb_paises
this.Control[iCurrent+12]=this.uo_paises
this.Control[iCurrent+13]=this.uo_articulo
this.Control[iCurrent+14]=this.gb_4
this.Control[iCurrent+15]=this.gb_1
this.Control[iCurrent+16]=this.gb_8
this.Control[iCurrent+17]=this.gb_2
this.Control[iCurrent+18]=this.r_1
end on

on w_con_cta_resultados_por_cliente.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.cb_1)
destroy(this.gb_6)
destroy(this.dw_resumen)
destroy(this.uo_cliente)
destroy(this.em_fechadesde)
destroy(this.em_fechahasta)
destroy(this.cbx_mermas)
destroy(this.uo_familia)
destroy(this.cb_paises)
destroy(this.uo_paises)
destroy(this.uo_articulo)
destroy(this.gb_4)
destroy(this.gb_1)
destroy(this.gb_8)
destroy(this.gb_2)
destroy(this.r_1)
end on

event ue_f5;//f_control(dw_detalle)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_cta_resultados_por_cliente
integer x = 951
integer y = 2060
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_cta_resultados_por_cliente
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_cta_resultados_por_cliente
integer y = 8
integer width = 5061
integer height = 80
boolean italic = true
end type

type pb_1 from upb_salir within w_con_cta_resultados_por_cliente
integer x = 5083
integer y = 8
integer width = 119
integer height = 100
integer taborder = 0
string text = "1"
end type

type pb_2 from upb_imprimir within w_con_cta_resultados_por_cliente
integer x = 5070
integer y = 140
integer width = 128
integer height = 104
integer taborder = 0
boolean originalsize = false
end type

event clicked;f_imprimir_datawindow(dw_resumen)

end event

type cb_1 from commandbutton within w_con_cta_resultados_por_cliente
integer x = 4773
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
	

end event

type gb_6 from groupbox within w_con_cta_resultados_por_cliente
integer x = 4754
integer y = 100
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

type dw_resumen from datawindow within w_con_cta_resultados_por_cliente
integer x = 27
integer y = 284
integer width = 5193
integer height = 2680
string dataobject = "dw_con_cta_resultados_por_cliente"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;
this.SetRedraw(false)

IF dwo.name= "t_cliente" Then
	this.SetSort("cliente D")
	this.Sort()
END IF

IF dwo.name= "t_ventas" Then
	this.SetSort("ventas D")
	this.Sort()
END IF

IF dwo.name= "t_dtopp" Then
	this.SetSort("dtopp D")
	this.Sort()
END IF

IF dwo.name= "t_muestras" Then
	this.SetSort("dtoesp1 D")
	this.Sort()
END IF

IF dwo.name= "t_rappel" Then
	this.SetSort("imp_rappel D")
	this.Sort()
END IF

IF dwo.name= "t_vtas_netas" Then
	this.SetSort("vtas_netas D")
	this.Sort()
END IF

IF dwo.name= "t_coste_mp" Then
	this.SetSort("coste_mp D")
	this.Sort()
END IF

IF dwo.name= "t_margen_contr" Then
	this.SetSort("margen_contr D")
	this.Sort()
END IF

IF dwo.name= "t_coste_fab" Then
	this.SetSort("coste_fab D")
	this.Sort()
END IF

IF dwo.name= "t_margen_bruto" Then
	this.SetSort("margen_bruto D")
	this.Sort()
END IF

IF dwo.name= "t_margen_comercial" Then
	this.SetSort("margen_comercial D")
	this.Sort()
END IF


IF dwo.name= "t_coste_estr" Then
	this.SetSort("coste_estr D")
	this.Sort()
END IF

IF dwo.name= "t_rdo_neto" Then
	this.SetSort("rdo_neto D")
	this.Sort()
END IF




this.SetRedraw(true)

end event

type uo_cliente from u_em_campo_2 within w_con_cta_resultados_por_cliente
event destroy ( )
integer x = 805
integer y = 156
integer width = 1170
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

type em_fechadesde from u_em_campo within w_con_cta_resultados_por_cliente
integer x = 78
integer y = 156
integer width = 297
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

event losefocus;call super::losefocus;//anyo=year(date(em_fechadesde.text))
//if anyo<year(today()) then em_fechahasta.text=string(date(anyo,12,31))
end event

type em_fechahasta from u_em_campo within w_con_cta_resultados_por_cliente
integer x = 453
integer y = 156
integer width = 293
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

event modificado;call super::modificado;//integer anyo2
//date fechah
//fechah=date(em_fechahasta.text)
//anyo2=year(fechah)
//
//if anyo2<>anyo then 
//	messagebox("Año Incorrecto","El año debe ser el mismo")
//	em_fechahasta.text=string(date(anyo,12,31))
//	f_activar_campo(em_fechahasta)
//	RETURN
//end if 
//
//if fechah<date(em_fechadesde.text) then 
//	messagebox("Fecha Incorrecta","La 2ª fecha debe ser mayor que la 1ª")
//	em_fechahasta.text=string(date(anyo,12,31))
//	f_activar_campo(em_fechahasta)
//	RETURN
//end if 
//
end event

type cbx_mermas from checkbox within w_con_cta_resultados_por_cliente
integer x = 3936
integer y = 156
integer width = 754
integer height = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tener en cuenta mermas"
boolean checked = true
end type

type uo_familia from u_em_campo_2 within w_con_cta_resultados_por_cliente
event destroy ( )
integer x = 2039
integer y = 156
integer width = 690
integer taborder = 40
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

type cb_paises from commandbutton within w_con_cta_resultados_por_cliente
integer x = 3607
integer y = 140
integer width = 297
integer height = 108
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Paises"
end type

event clicked;uo_paises.visible = not(uo_paises.visible)

end event

type uo_paises from u_marca_lista within w_con_cta_resultados_por_cliente
event destroy ( )
boolean visible = false
integer x = 2789
integer y = 256
integer taborder = 120
boolean bringtotop = true
boolean border = false
end type

on uo_paises.destroy
call u_marca_lista::destroy
end on

type uo_articulo from u_em_campo_2 within w_con_cta_resultados_por_cliente
event destroy ( )
integer x = 2802
integer y = 156
integer width = 690
integer taborder = 40
boolean bringtotop = true
boolean border = true
long backcolor = 134217750
borderstyle borderstyle = stylelowered!
end type

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

event modificado;string descripcion

select descripcion
into :descripcion
from articulos
where empresa = :codigo_empresa
and codigo = :uo_articulo.em_codigo.text;

uo_articulo.em_campo.text= descripcion
IF Trim(uo_articulo.em_campo.text)="" THEN 
	IF Trim(uo_articulo.em_codigo.text)<>"" Then uo_articulo.em_campo.SetFocus()
	uo_articulo.em_campo.text=""
	uo_articulo.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de articulos"
ue_datawindow = "dw_ayuda_articulos"
ue_filtro     = ""

end event

type gb_4 from groupbox within w_con_cta_resultados_por_cliente
integer x = 786
integer y = 104
integer width = 1211
integer height = 152
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Cliente"
end type

type gb_1 from groupbox within w_con_cta_resultados_por_cliente
integer x = 46
integer y = 100
integer width = 727
integer height = 156
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Fecha "
end type

type gb_8 from groupbox within w_con_cta_resultados_por_cliente
integer x = 2016
integer y = 104
integer width = 736
integer height = 152
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Familia"
end type

type gb_2 from groupbox within w_con_cta_resultados_por_cliente
integer x = 2779
integer y = 104
integer width = 736
integer height = 152
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Artículo"
end type

type r_1 from rectangle within w_con_cta_resultados_por_cliente
boolean visible = false
integer linethickness = 4
long fillcolor = 19474154
integer x = 4137
integer y = 144
integer width = 329
integer height = 100
end type

