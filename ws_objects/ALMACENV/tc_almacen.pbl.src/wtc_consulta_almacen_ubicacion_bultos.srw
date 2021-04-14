﻿$PBExportHeader$wtc_consulta_almacen_ubicacion_bultos.srw
forward
global type wtc_consulta_almacen_ubicacion_bultos from wt_consultas_padre
end type
type st_reservado from statictext within wtc_consulta_almacen_ubicacion_bultos
end type
type sle_observaciones from singlelineedit within wtc_consulta_almacen_ubicacion_bultos
end type
type pb_grabar_obs from picturebutton within wtc_consulta_almacen_ubicacion_bultos
end type
type st_1 from statictext within wtc_consulta_almacen_ubicacion_bultos
end type
type pb_imprimir_bultos from picturebutton within wtc_consulta_almacen_ubicacion_bultos
end type
type dw_etiquetas_bultos_100 from datawindow within wtc_consulta_almacen_ubicacion_bultos
end type
end forward

global type wtc_consulta_almacen_ubicacion_bultos from wt_consultas_padre
integer width = 6405
integer height = 3736
string title = "Consulta Material por Ubicación"
st_reservado st_reservado
sle_observaciones sle_observaciones
pb_grabar_obs pb_grabar_obs
st_1 st_1
pb_imprimir_bultos pb_imprimir_bultos
dw_etiquetas_bultos_100 dw_etiquetas_bultos_100
end type
global wtc_consulta_almacen_ubicacion_bultos wtc_consulta_almacen_ubicacion_bultos

type variables
string sql_inicial, sql_final, orden_seleccionado
end variables

forward prototypes
public function string f_montar_filtro (string consulta_inicial)
public function string f_construir_consulta ()
public function string f_construir_group_by ()
public subroutine f_cargar_datawindow (string new_sql)
end prototypes

public function string f_montar_filtro (string consulta_inicial);string montaje
int j


montaje = ''
for j = 1 to dw_montaje_filtro.rowcount()
	
	//Filtros mediante DW
	if pos(dw_montaje_filtro.object.linea[j], "Existencias") = 0 then
	
		if montaje = '' then
			montaje = dw_montaje_filtro.object.filtro[j]
		else
			montaje = montaje +' AND '+ dw_montaje_filtro.object.filtro[j]
		end if
	end if
next
if montaje <> '' then
	montaje = consulta_inicial + " AND " + montaje
else
	montaje = consulta_inicial
end if


return montaje


end function

public function string f_construir_consulta ();string cadena
datastore ds_datos

cadena = "SELECT  alm_bultos.id   "+&
" , almubimapa_codbar.almacen  "+&
" , almubimapa_codbar.zona  "+&
" , almubimapa_codbar.fila  "+&
" , almubimapa_codbar.altura  "+&
" , alm_bultos_lineas.articulo  "+&
" , articulos.descripcion  "+&
" , formatos.abreviado  "+&
" , genter.razon  "+&
" ,	alm_bultos_lineas.calidad  "+&
" , alm_bultos_lineas.tono  "+&
" , alm_bultos_lineas.calibre  "+&
" , alm_bultos_lineas.caja  "+&
" ,	sum (alm_bultos_lineas.cantidad) AS cantidad  "+&
" , alm_bultos.observaciones "+&
" , alm_bultos.anyo_orden_carga  "+&
" , alm_bultos.codigo_orden_carga  "+&
" , CASE articulos.unidad  "+&
" 		WHEN '1' THEN  sum ( ( alm_bultos_lineas.cantidad / almartcajas.piezascaja ) * almartcajas.metroscaja )  "+&
"	END AS cantidad_m2   "+&
" , CASE articulos.unidad  "+&
" 		WHEN '0' THEN  sum ( alm_bultos_lineas.cantidad * ( (formatos.ancho * formatos.largo ) / 10000 ) )  "+&
"	END AS cantidad_m2_nominal   "+&
" , articulos.tipo_abc as abc "+&
" FROM alm_bultos_lineas "+&
" INNER JOIN articulos ON alm_bultos_lineas.empresa = articulos.empresa AND alm_bultos_lineas.articulo = articulos.codigo "+&
" INNER  JOIN almartcajas ON alm_bultos_lineas.empresa = almartcajas.empresa AND alm_bultos_lineas.articulo = almartcajas.articulo AND alm_bultos_lineas.caja = almartcajas.caja "+&
" INNER JOIN formatos ON articulos.empresa = formatos.empresa AND articulos.formato = formatos.codigo "+&
" INNER JOIN alm_bultos ON alm_bultos_lineas.empresa = alm_bultos.empresa AND alm_bultos_lineas.id_alm_bultos = alm_bultos.id  "+&
" INNER JOIN almubimapa_codbar ON alm_bultos.empresa = almubimapa_codbar.empresa AND alm_bultos.id_ubicacion = almubimapa_codbar.id "+&
" LEFT OUTER JOIN orden_carga ON  orden_carga.empresa = alm_bultos.empresa AND orden_carga.anyo = alm_bultos.anyo_orden_carga  AND orden_carga.codigo = alm_bultos.codigo_orden_carga   "+&
" LEFT OUTER JOIN genter ON genter.empresa = articulos.empresa AND genter.codigo = articulos.cliente and genter.tipoter = 'C' "+&
" WHERE alm_bultos_lineas.empresa = '"+codigo_empresa+"' "


return cadena





end function

public function string f_construir_group_by ();string cadena

cadena = "GROUP BY alm_bultos.id "+&
" , genter.razon "+&
" , almubimapa_codbar.almacen "+&
" , almubimapa_codbar.zona "+&
" , almubimapa_codbar.fila "+&
" , almubimapa_codbar.altura "+&
" , alm_bultos_lineas.articulo "+&
" , articulos.descripcion "+&
" , formatos.abreviado "+&
" , genter.razon  "+&
" ,	alm_bultos_lineas.calidad "+&
" , alm_bultos_lineas.tono "+&
" , alm_bultos_lineas.calibre "+&
" , alm_bultos_lineas.caja "+&
" ,	alm_bultos.anyo_orden_carga "+&
" , alm_bultos.codigo_orden_carga "+&
" , alm_bultos.observaciones "+&
" , articulos.unidad  "+&
" , almartcajas.piezascaja "+&
" , almartcajas.metroscaja "+&
" , articulos.tipo_abc "+&
" ORDER BY almubimapa_codbar.almacen "+&
" , almubimapa_codbar.zona "+&
" , almubimapa_codbar.fila "+&
" , almubimapa_codbar.altura "

return cadena
end function

public subroutine f_cargar_datawindow (string new_sql);datastore registros

dw_datos.reset()

f_cargar_cursor_nuevo (new_sql, registros)

if registros.rowcount() > 0 then
	dw_datos.object.data = registros.object.data
end if

destroy registros

st_total_padre.text = string(dw_datos.rowcount(), "###,###,###")
end subroutine

on wtc_consulta_almacen_ubicacion_bultos.create
int iCurrent
call super::create
this.st_reservado=create st_reservado
this.sle_observaciones=create sle_observaciones
this.pb_grabar_obs=create pb_grabar_obs
this.st_1=create st_1
this.pb_imprimir_bultos=create pb_imprimir_bultos
this.dw_etiquetas_bultos_100=create dw_etiquetas_bultos_100
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_reservado
this.Control[iCurrent+2]=this.sle_observaciones
this.Control[iCurrent+3]=this.pb_grabar_obs
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.pb_imprimir_bultos
this.Control[iCurrent+6]=this.dw_etiquetas_bultos_100
end on

on wtc_consulta_almacen_ubicacion_bultos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_reservado)
destroy(this.sle_observaciones)
destroy(this.pb_grabar_obs)
destroy(this.st_1)
destroy(this.pb_imprimir_bultos)
destroy(this.dw_etiquetas_bultos_100)
end on

event open;call super::open;dw_datos.SetTransObject(SQLCA)








end event

type st_registros_padre from wt_consultas_padre`st_registros_padre within wtc_consulta_almacen_ubicacion_bultos
integer x = 5477
integer y = 144
end type

type st_total_padre from wt_consultas_padre`st_total_padre within wtc_consulta_almacen_ubicacion_bultos
integer x = 5719
integer y = 144
end type

type pb_imprimir from wt_consultas_padre`pb_imprimir within wtc_consulta_almacen_ubicacion_bultos
integer x = 3685
integer y = 56
integer width = 201
integer height = 176
integer taborder = 0
string powertiptext = "Imprimir Listado"
end type

event pb_imprimir::clicked;String new_sql
if dw_datos.rowcount() > 0 then
	f_imprimir_datawindow(dw_datos)
end if
end event

type pb_borrar from wt_consultas_padre`pb_borrar within wtc_consulta_almacen_ubicacion_bultos
integer x = 3890
integer y = 56
integer width = 201
integer height = 176
integer taborder = 0
end type

type dw_montaje_filtro from wt_consultas_padre`dw_montaje_filtro within wtc_consulta_almacen_ubicacion_bultos
integer width = 6245
integer height = 224
integer taborder = 30
end type

type pb_1 from wt_consultas_padre`pb_1 within wtc_consulta_almacen_ubicacion_bultos
integer x = 3383
integer y = 56
integer width = 201
integer height = 176
integer taborder = 0
end type

event pb_1::clicked;call super::clicked;string new_sql, filtro_dw
long fila, j

st_reservado.text = ''

fila = dw_montaje_filtro.getrow()
dw_montaje_filtro.deleterow(fila)
if dw_montaje_filtro.rowcount() > 0 then
	new_sql = f_montar_filtro(sql_inicial)  + sql_final
	f_cargar_datawindow (new_sql)
	dw_datos.retrieve()
else
	dw_datos.reset()
end if

//Filtros mediante Datawindow
filtro_dw = "1 = 1"
For j = 1 To dw_montaje_filtro.rowcount()
	if pos(dw_montaje_filtro.object.linea[j] , "Existencias") <> 0 then
		filtro_dw = filtro_dw + " and " + dw_montaje_filtro.object.filtro[j]
	end if
Next
dw_datos.setfilter(filtro_dw)
dw_datos.filter()

if dw_montaje_filtro.rowcount() > 3 then
	dw_montaje_filtro.height = dw_montaje_filtro.height -75
	dw_datos.y = dw_datos.y - 75
	dw_datos.height = dw_datos.height + 75
else
	dw_datos.y = 512
	dw_datos.height = 3008
	dw_montaje_filtro.height = 225
end if

if dw_datos.rowcount() > 0 then
	dw_datos.setrow(1)
	dw_datos.Event rowfocuschanged(1)
end if
end event

type pb_reset from wt_consultas_padre`pb_reset within wtc_consulta_almacen_ubicacion_bultos
integer x = 4101
integer y = 56
integer width = 201
integer height = 176
integer taborder = 0
end type

type pb_anyadir1 from wt_consultas_padre`pb_anyadir1 within wtc_consulta_almacen_ubicacion_bultos
integer x = 3150
integer y = 56
integer width = 201
integer height = 176
integer taborder = 0
end type

event pb_anyadir1::clicked;call super::clicked;int index, fila
long i, j, k, filas
string cadena_or, cadena_or_visible, descripcion_extra
string new_sql, filtro, filtro_dw
boolean crear_filtro

sql_inicial = f_construir_consulta ()
sql_final = f_construir_group_by ()
st_reservado.text = ''

if ddlb_campo.text <> "" or dw_montaje_filtro.rowcount() = 0 then

	index = ddlb_campo.SelectItem ( ddlb_campo.text, 0 )
	
	choose case ddlb_campo.text
		case "Almacen"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " almubimapa_codbar.almacen = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Almacen = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR almubimapa_codbar.almacen = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 			

		case "Artículo (Código)"
			if cadena_or = '' then
				descripcion_extra = ""
				SELECT descripcion INTO :descripcion_extra FROM articulos WHERE empresa = :codigo_empresa AND codigo = :sle_valor1.text;
				cadena_or = " alm_bultos_lineas.articulo "+ddlb_operador.text+" '"+sle_valor1.text+"' "
				cadena_or_visible = " Artículo "+ddlb_operador.text+" '"+sle_valor1.text+" "+descripcion_extra+"' "
			end if
		case "Articulo (Descripción)"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " alm_bultos_lineas.articulo = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Articulo = "+dw_filtro.object.#1[i]+" "+dw_filtro.object.#2[i]+" "
					else
						cadena_or = cadena_or+" OR alm_bultos_lineas.articulo = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#1[i]//+" "+dw_filtro.object.#2[i]+" "//Demasiado largo
					end if
				end if
			next 
		CASE "Formato"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " articulos.formato = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Formato = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR articulos.formato = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 
		case "Cliente"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " genter.codigo = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Cliente = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR genter.codigo = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 
		case "Cliente O.C."
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " orden_carga.cliente = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Cliente O.C. = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR orden_carga.cliente = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 			
		case "Zona"
			if cadena_or = '' then
				cadena_or = " almubimapa_codbar.zona "+ddlb_operador.text+" '"+sle_valor1.text+"' "
				cadena_or_visible = " Zona "+ddlb_operador.text+" '"+sle_valor1.text+"' "
			end if
		case "Fila"
			if cadena_or = '' then
				cadena_or = " almubimapa_codbar.fila "+ddlb_operador.text+" '"+sle_valor1.text+"' "
				cadena_or_visible = " Fila "+ddlb_operador.text+" '"+sle_valor1.text+"' "
			end if
		case "Altura"
			if cadena_or = '' then
				cadena_or = " almubimapa_codbar.altura "+ddlb_operador.text+" '"+sle_valor1.text+"' "
				cadena_or_visible = " Altura "+ddlb_operador.text+" '"+sle_valor1.text+"' "
			end if
		case "Existencias"
			if cadena_or = '' then
				cadena_or = " cantidad "+ddlb_operador.text+" "+sle_valor1.text+" "
				cadena_or_visible = " cantidad "+ddlb_operador.text+" "+sle_valor1.text
			end if
			
		case "Pendiente de Preparar"
			for k = 1 to lb_lista.totalitems()
				if lb_lista.state(k) = 1 then
					if cadena_or = '' then
						if UPPER(lb_lista.Text (k)) = 'S' then
							cadena_or = " (almubimapa_codbar.almacen = '1' AND almubimapa_codbar.zona = 'B' AND almubimapa_codbar.fila = 1 AND almubimapa_codbar.altura = 1) "
							cadena_or_visible = " Pendiente de Preparar "
						end if
					end if
				end if				
			next
			
		case "Ubicado Muelle"
			for k = 1 to lb_lista.totalitems()
				if lb_lista.state(k) = 1 then
					if cadena_or = '' then
						if UPPER(lb_lista.Text (k)) = 'S' then
							cadena_or = " (almubimapa_codbar.almacen = '1' AND almubimapa_codbar.zona = 'P' AND almubimapa_codbar.fila = 1 AND almubimapa_codbar.altura = 1) "
							cadena_or_visible = " Ubicado en Muelle "
						end if
					end if
				end if				
			next
		case "Ubicado M.Distribución"
			for k = 1 to lb_lista.totalitems()
				if lb_lista.state(k) = 1 then
					if cadena_or = '' then
						if UPPER(lb_lista.Text (k)) = 'S' then
							cadena_or = " (almubimapa_codbar.almacen = '1' AND almubimapa_codbar.zona = 'P' AND almubimapa_codbar.fila >= 10) "
							cadena_or_visible = " Ubicado en Muelle Distribución "
						end if
					end if
				end if				
			next
		case "Ubicado Anulaciones/Abonos"
			for k = 1 to lb_lista.totalitems()
				if lb_lista.state(k) = 1 then
					if cadena_or = '' then
						if UPPER(lb_lista.Text (k)) = 'S' then
							cadena_or = " (almubimapa_codbar.almacen = '1' AND almubimapa_codbar.zona = 'P' AND almubimapa_codbar.fila = 2) "
							cadena_or_visible = " Ubicado en Muelle "
						end if
					end if
				end if				
			next			
		case "Uso"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " articulos.uso = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Uso Artículo = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR articulos.uso = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 
		case "Familia"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " alm_bultos_lineas.articulo IN ( SELECT codigo FROM articulos WHERE familia = '"+dw_filtro.object.#1[i]+"' ) "
						cadena_or_visible = " Familia = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR alm_bultos_lineas.articulo IN ( SELECT codigo FROM articulos WHERE familia = '"+dw_filtro.object.#1[i]+"' ) "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 		
		case "Calidad"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " alm_bultos_lineas.calidad  = '"+dw_filtro.object.#1[i]+"'  "
						cadena_or_visible = " Calidad = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR alm_bultos_lineas.calidad  = '"+dw_filtro.object.#1[i]+"'  "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 
		case "Promoción"
			for k = 1 to lb_lista.totalitems()
				if lb_lista.state(k) = 1 then
					if cadena_or = '' then
						if UPPER(lb_lista.Text (k)) = 'S' then
							cadena_or = " articulos.promocion = 'S' "
							cadena_or_visible = " Solo Promoción "
						else
							cadena_or = " articulos.promocion = 'N' "
							cadena_or_visible = " Promoción = NO "
						end if
					end if
				end if				
			next
		case "Lote"
			if cadena_or = '' then
				cadena_or = " alm_bultos_lineas.tono "+ddlb_operador.text+" '"+sle_valor1.text+"' "
				cadena_or_visible = " Lote "+ddlb_operador.text+" '"+sle_valor1.text+"' "
			end if		
		case "A - B - C"
			if cadena_or = '' then
				cadena_or = " articulos.tipo_abc "+ddlb_operador.text+" '"+sle_valor1.text+"' "
				cadena_or_visible = " ABC "+ddlb_operador.text+" '"+sle_valor1.text+"' "
			end if
		case "Colección"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " alm_bultos_lineas.articulo IN ( SELECT codigo FROM articulos WHERE articulos.submarcas_codigo = '"+dw_filtro.object.#1[i]+"' ) "
						cadena_or_visible = " Colección = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR alm_bultos_lineas.articulo IN ( SELECT codigo FROM articulos WHERE articulos.submarcas_codigo = '"+dw_filtro.object.#1[i]+"' ) "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 					
	end choose
	
	
	// Comprobamos que rellene algo en los objetos de filtro
	crear_filtro = false
	if ddlb_campo.text <> '' and ddlb_operador.text <> '' then
		if dw_filtro.visible then
			if dw_filtro.GetSelectedRow(0) >0 then
				crear_filtro = true
			end if
		end if
		if em_fecha1.visible then
			if not isnull (em_fecha1) and em_fecha1.text <> '' then
				crear_filtro = true
			end if
		end if
		if sle_valor1.visible then
			if sle_valor1.text <> '' then
				crear_filtro = true
			end if
		end if
	
		if lb_lista.visible then
			if lb_lista.selectedindex() <> -1 then
				crear_filtro = true
			end if
		end if
		
	end if
	
	if crear_filtro then
		if cadena_or <> '' then
			cadena_or = " ( "+cadena_or+" ) "
			fila = dw_montaje_filtro.insertrow(0)
			dw_montaje_filtro.object.filtro[fila] = cadena_or
			dw_montaje_filtro.object.linea[fila] = cadena_or_visible
			
			new_sql = f_montar_filtro(sql_inicial) + sql_final
			
			ddlb_campo.text = ''
			dw_filtro.visible = false
			dw_filtro.height = 137
		else
			new_sql = sql_inicial + sql_final
		end if
	else
		new_sql = sql_inicial + sql_final
	end if
	
	f_cargar_datawindow (new_sql)
	
	filas = dw_datos.retrieve()
	
	if filas > 0 then
		dw_datos.setfocus()
	end if	
	
	//Filtros mediante Datawindow
	filtro_dw = "1 = 1"
	For j = 1 To dw_montaje_filtro.rowcount()
		if pos(dw_montaje_filtro.object.linea[j] , "Existencias") <> 0 then
			filtro_dw = filtro_dw + " and " + dw_montaje_filtro.object.filtro[j]	
		end if
	Next
	dw_datos.setfilter(filtro_dw)		
	dw_datos.filter()
	
	em_fecha1.visible = false
	sle_valor1.visible = false
	dw_filtro.visible = false
	pb_buscar.visible = false
	sle_texto.visible = false
	lb_lista.visible = false
	
	sle_texto.text = ''
	
	sle_valor1.text = ''
	dw_filtro.reset()
	ddlb_campo.selectitem(0) 
	ddlb_operador.selectitem(0) 
	
	//Para evitar solapamiento con otros datawindows
	dw_filtro.Height = 260
	
	if dw_montaje_filtro.rowcount() > 3 and dw_montaje_filtro.rowcount() < 10 then
		dw_montaje_filtro.height = 75 * dw_montaje_filtro.rowcount()
		dw_datos.y = dw_datos.y + 75
		dw_datos.height = dw_datos.height - 75
	end if
	
	dw_datos.setfocus()
	if dw_datos.rowcount() > 0 then
		dw_datos.setrow(1)
		dw_datos.Event rowfocuschanged(1)
	end if
else
	
	new_sql = f_montar_filtro(sql_inicial) + sql_final
	
	f_cargar_datawindow (new_sql)
	
	filas = dw_datos.retrieve()
	
	if filas > 0 then
		dw_datos.setfocus()
	end if
	
/*	
	//Filtros mediante Datawindow
	filtro_dw = "1 = 1"
	For j = 1 To dw_montaje_filtro.rowcount()
		if pos(dw_montaje_filtro.object.linea[j] , "Existencias") <> 0 then
			filtro_dw = filtro_dw + " and " + dw_montaje_filtro.object.filtro[j]
		end if
	Next
	dw_datos.setfilter(filtro_dw)		
	dw_datos.filter()
	
	dw_datos.setfocus()
	if dw_datos.rowcount() > 0 then
		dw_datos.setrow(1)
		dw_datos.Event rowfocuschanged(1)
	end if
	*/
end if


//Al hacer más quieren que se restablezca el orden
//orden_seleccionado = "articulos_descripcion A"
//dw_datos.setsort("integer(almacen) A, zona A, fila A, altura A")

sle_observaciones.text = ''
sle_observaciones.visible = false
pb_grabar_obs.visible = false

dw_datos.sort()


end event

type ddlb_operador from wt_consultas_padre`ddlb_operador within wtc_consulta_almacen_ubicacion_bultos
integer x = 1280
integer y = 128
integer width = 293
integer taborder = 0
integer textsize = -14
integer weight = 700
long textcolor = 23016974
boolean sorted = false
end type

type ddlb_campo from wt_consultas_padre`ddlb_campo within wtc_consulta_almacen_ubicacion_bultos
integer y = 128
integer width = 1211
integer height = 2220
integer taborder = 0
integer textsize = -14
integer weight = 700
long textcolor = 24076881
boolean sorted = false
integer limit = 1
string item[] = {"Almacen","Zona","Fila","Altura","Articulo (Descripción)","Artículo (Código)","Cliente","Formato","Existencias","Pendiente de Preparar","Ubicado Muelle","Ubicado M.Distribución","Ubicado Anulaciones/Abonos","Uso","Familia","Calidad","Promoción","Cliente O.C.","Lote","Colección","A - B - C"}
end type

event ddlb_campo::selectionchanged;call super::selectionchanged;string consulta, new_syntax,  error_syntaxfromSQL, mensaje_error, error_create

ddlb_operador.Reset()
lb_lista.Reset()

CHOOSE CASE ddlb_campo.text
	CASE "Almacen"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, descripcion as Descripción from almalmacen where empresa = '"+codigo_empresa+"' order by codigo ASC"

	CASE "Promoción"
		dw_filtro.visible = false
		pb_buscar.visible = false
		sle_texto.visible = false
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = true
		
		lb_lista.AddItem ("S")
		lb_lista.AddItem ("N")
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="	
		
	CASE "Articulo (Descripción)"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select distinct almacenmovimientos.articulo as Código, CONVERT(char(60),articulos.descripcion) as Descripción, formatos.abreviado as Formato, art_ver_tipooperacion.descripcion_abr as Operación, CONVERT(char(10),almusos.descripcion) AS Uso, genter.razon "+&
						"from almacenmovimientos LEFT OUTER JOIN articulos ON almacenmovimientos.empresa = articulos.empresa AND almacenmovimientos.articulo = articulos.codigo "+&
						"LEFT OUTER JOIN formatos ON articulos.empresa = formatos.empresa AND articulos.formato = formatos.codigo "+&
						"LEFT OUTER JOIN almusos ON articulos.empresa = almusos.empresa AND articulos.uso = almusos.codigo "+&
						"LEFT OUTER JOIN art_ver_tipooperacion ON articulos.empresa = art_ver_tipooperacion.empresa AND articulos.tipo_operacion = art_ver_tipooperacion.codigo "+&
						"LEFT OUTER JOIN genter ON articulos.empresa = genter.empresa AND articulos.cliente = genter.codigo AND genter.tipoter = 'C' "+&
						"where almacenmovimientos.empresa = '"+codigo_empresa+"' order by CONVERT(char(60), articulos.descripcion)"
	CASE "Artículo (Código)"
		dw_filtro.visible = false
		pb_buscar.visible = false
		sle_texto.visible = false
		em_fecha1.visible = false
		sle_valor1.visible = true
		lb_lista.visible = false
		
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="		
	CASE "Formato"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
//		consulta = "Select formatos.codigo as Código, formatos.abreviado as Descripción "+&
//						"from formatos "+&
//						"where formatos.empresa = '"+codigo_empresa+"' order by formatos.descripcion ASC"		
		consulta = "Select formatos.codigo as Código, CONVERT(char(10), formatos.descripcion) as Descripcion, CONVERT(decimal(5,2), formatos.ancho) as Ancho, CONVERT(decimal(5,2),formatos.largo) as Largo, formatos.abreviado as Comercial "+&
						"from formatos "+&
						"where formatos.empresa = '"+codigo_empresa+"' order by formatos.descripcion ASC"	
	CASE "Cliente"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, razon as Descripción from genter where empresa = '"+codigo_empresa+"' AND tipoter = 'C' order by razon ASC"
	CASE "Cliente O.C."
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, razon as Descripción from genter where empresa = '"+codigo_empresa+"' AND tipoter = 'C' order by razon ASC"		
	CASE "Zona"
		dw_filtro.visible = false
		pb_buscar.visible = false
		sle_texto.visible = false
		em_fecha1.visible = false
		sle_valor1.visible = true
		lb_lista.visible = false
		
		ddlb_operador.AddItem ("=")
		ddlb_operador.AddItem (">=")
		ddlb_operador.AddItem ("<=")
		ddlb_operador.AddItem ("<>")

		ddlb_operador.text = "="
		
	CASE "Existencias", "Fila", "Altura"
		dw_filtro.visible = false
		pb_buscar.visible = false
		sle_texto.visible = false
		em_fecha1.visible = false
		sle_valor1.visible = true
		lb_lista.visible = false
		
		ddlb_operador.AddItem ("=")
		ddlb_operador.AddItem (">")
		ddlb_operador.AddItem ("<")
		ddlb_operador.AddItem (">=")
		ddlb_operador.AddItem ("<=")
		ddlb_operador.AddItem ("=")
		
		ddlb_operador.text = "="
	CASE "Ubicado Muelle", "Ubicado M.Distribución", "Ubicado Anulaciones/Abonos", "Pendiente de Preparar"
		dw_filtro.visible = false
		pb_buscar.visible = false
		sle_texto.visible = false
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = true
		
		lb_lista.AddItem ("S")
		lb_lista.SetState ( 1, true)
		
		
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		pb_anyadir1.triggerevent("clicked")


	CASE "Uso"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, descripcion as Descripción from almusos WHERE empresa = '"+codigo_empresa+"' "
	CASE "Familia"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, descripcion as Descripción from familias where empresa = '"+codigo_empresa+"' order by codigo ASC"
	CASE "Calidad"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, descripcion as Descripción from calidades where empresa = '"+codigo_empresa+"' order by codigo ASC"
	CASE "Lote"
		dw_filtro.visible = false
		pb_buscar.visible = false
		sle_texto.visible = false
		em_fecha1.visible = false
		sle_valor1.visible = true
		lb_lista.visible = false
		
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="	
	CASE "A - B - C"
		dw_filtro.visible = false
		pb_buscar.visible = false
		sle_texto.visible = false
		em_fecha1.visible = false
		sle_valor1.visible = true
		lb_lista.visible = false
		
		ddlb_operador.AddItem ("=")		
		ddlb_operador.AddItem ("<>")
		ddlb_operador.text = "="			
	CASE "Colección"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, descripcion as Descripción from submarcas where empresa = '"+codigo_empresa+"' order by descripcion ASC"		
		
END CHOOSE


//Creación del data window de búsqueda
new_syntax = SQLCA.SyntaxFromSQL(consulta, 'Style(Type=Grid)', error_syntaxfromSQL)

IF Len(error_syntaxfromSQL) > 0 THEN
	// Display errors
	mensaje_error = "Error en la consulta de la búsqueda. Avise al administrador."+error_syntaxfromSQL
ELSE
	// Generate new DataWindow
	dw_filtro.Create(new_syntax, error_create)
	IF Len(error_create) > 0 THEN
		mensaje_error  = "Error en la creación del DW de búsqueda. Avise al administrador."+error_create
	END IF
END IF

//dw_filtro.visible = true

dw_filtro.SetTransObject(SQLCA)
dw_filtro.Retrieve(codigo_empresa)

end event

type dw_datos from wt_consultas_padre`dw_datos within wtc_consulta_almacen_ubicacion_bultos
integer y = 512
integer width = 6222
integer height = 3008
integer taborder = 40
string dataobject = "dwtc_consulta_almacen_ubicacion_bultos"
end type

event dw_datos::doubleclicked;call super::doubleclicked;/*
Long id_ventana
str_parametros lstr_param 

if row > 0 then	
	
	lstr_param.s_argumentos[1] = dw_datos.GetItemString(row,"modelo_pieza_codigo_lab")
	lstr_param.i_nargumentos = 1
	lstr_param.nombre_ventana = "wtc_consulta_disenyo"
	lstr_param.resultado = ''
	id_ventana = f_menu_ventana_esta_abierta("wtc_mant_pruebas")
	if id_ventana <> -1 then
		close(wtc_mant_pruebas)
		OpenWithParm(wtc_mant_pruebas, lstr_param)
	else
		OpenWithParm(wtc_mant_pruebas,lstr_param)
	end if
	
end if
*/
end event

event dw_datos::clicked;call super::clicked;String almacen, zona, articulo, calidad, tono, tipo_pallet, caja
Int  fila, altura, calibre, fila_actual

if row = 0 then
	choose case dwo.name 
		case "almacen_t" 
			orden_seleccionado = "almacen, zona, fila, altura A"
		case "zona_t" 
			orden_seleccionado = "almacen, zona, fila, altura A"
		case "fila_t" 
			orden_seleccionado = "almacen, zona, fila, altura A"
		case "altura_t" 
			orden_seleccionado = "almacen, zona, fila, altura A"
		case "articulo_t" 
			orden_seleccionado = "articulo_des A"
		case "formato_t" 
			orden_seleccionado = "formato A"
		case "ciente_t" 
			orden_seleccionado = "cliente A"
		case "calidad_t" 
			orden_seleccionado = "articulo_des, formato, calidad, tono, calibre A"
		case "tono_t" 
			orden_seleccionado = "articulo_des, formato, calidad, tono, calibre A"
		case "calibre_t" 
			orden_seleccionado = "articulo_des, formato, calidad, tono, calibre A"
		case "cantidad_t" 
			orden_seleccionado = "cantidad D"		
	end choose
		
	dw_datos.setsort(orden_seleccionado)
	dw_datos.sort()
end if

if dwo.name = "b_editar" then
	sle_observaciones.visible = true
	pb_grabar_obs.visible = true
	sle_observaciones.text = this.object.observaciones[row]
end if

/*		
else
	if dwo.name = "b_editar" then

		if permiso_ventana > 1 and row > 0 then
			almacen = this.object.almacen[row]
			zona = this.object.zona[row]
			fila = this.object.fila[row]
			altura = this.object.altura[row]
			articulo = this.object.articulo[row]
			calidad = this.object.calidad[row]
			tono = this.object.tono[row]
			calibre = this.object.calibre[row]
			tipo_pallet = this.object.almacenmovimientos_tipo_pallet[row]
			caja = this.object.almacenmovimientos_caja[row]
			
			if dw_observaciones.retrieve(codigo_empresa, almacen, zona, fila, altura, articulo, calidad, tono, calibre, tipo_pallet, caja) = 0 then
				fila_actual = dw_observaciones.insertrow(0)
				if fila_actual > 0 then
					dw_observaciones.object.empresa[fila_actual] = codigo_empresa
					dw_observaciones.object.almacen[fila_actual] = almacen
					dw_observaciones.object.zona[fila_actual] = zona
					dw_observaciones.object.fila[fila_actual] = fila
					dw_observaciones.object.altura[fila_actual] = altura
					dw_observaciones.object.articulo[fila_actual] = articulo
					dw_observaciones.object.calidad[fila_actual] = calidad
					dw_observaciones.object.tono[fila_actual] = tono
					dw_observaciones.object.calibre[fila_actual] = calibre
					dw_observaciones.object.tipo_pallet[fila_actual] = tipo_pallet
					dw_observaciones.object.caja[fila_actual] = caja
				end if
			end if
			dw_observaciones.visible = true
			dw_observaciones.setfocus()
			dw_observaciones.SetColumn("observaciones")
		end if
	end if
end if
*/
end event

event dw_datos::retrieveend;call super::retrieveend;/*
string articulo
dec{3} reservado
// Provisonal

if dw_datos.rowcount() > 0 then
	articulo = dw_datos.object.articulo[1]
	
	SELECT sum (	CASE WHEN venliped.tipo_unidad = '0' 
				THEN venliped.cantidad 
				ELSE (venliped.cantidad /av.metroscaja) * av.piezascaja 
			END) 
	INTO :reservado
	FROM venliped 
	INNER JOIN venped ON venliped.empresa = venped.empresa AND venliped.anyo = venped.anyo AND venliped.pedido = venped.pedido 
	LEFT OUTER JOIN almartcajas av ON venliped.empresa = av.empresa AND venliped.articulo = av.articulo AND venliped.caja = av.caja 
	WHERE av.piezascaja <> 0 
	AND venliped.empresa = :codigo_empresa
	AND venliped.articulo = :articulo
	AND venliped.calidad = '1'
	AND venliped.situacion in ('C','P')   
	AND venped.es_proforma <> 'S';

	
	st_reservado.text = 'Reservado: '+ string(reservado, "###,###,##0.000")
end if
// Fin Provisional
*/
end event

event dw_datos::rowfocuschanged;call super::rowfocuschanged;
string articulo
dec{0} reservado, total_piezas
// Provisonal

if dw_datos.rowcount() > 0 then
	articulo = dw_datos.object.articulo[currentrow]
	
	SELECT isnull (sum (	CASE WHEN venliped.tipo_unidad = '0' 
				THEN venliped.cantidad 
				ELSE (venliped.cantidad /av.metroscaja) * av.piezascaja 
			END) , 0)
	INTO :reservado
	FROM venliped 
	INNER JOIN venped ON venliped.empresa = venped.empresa AND venliped.anyo = venped.anyo AND venliped.pedido = venped.pedido 
	LEFT OUTER JOIN almartcajas av ON venliped.empresa = av.empresa AND venliped.articulo = av.articulo AND venliped.caja = av.caja 
	WHERE av.piezascaja <> 0 
	AND venliped.empresa = :codigo_empresa
	AND venliped.articulo = :articulo
	AND venliped.calidad = '1'
	AND venliped.situacion in ('C','P')   
	AND venped.es_proforma <> 'S';

	total_piezas = dec(dw_datos.object.total_piezas[1])
	
	st_reservado.text =  'Disponible :  '+ string(total_piezas - reservado, "###,###,##0")

end if

// Fin Provisional
end event

type pb_salir from wt_consultas_padre`pb_salir within wtc_consulta_almacen_ubicacion_bultos
integer x = 4311
integer y = 56
integer width = 201
integer height = 176
integer taborder = 0
end type

type st_titulo from wt_consultas_padre`st_titulo within wtc_consulta_almacen_ubicacion_bultos
end type

type p_logo from wt_consultas_padre`p_logo within wtc_consulta_almacen_ubicacion_bultos
integer x = 5806
integer y = 4
end type

type dw_filtro from wt_consultas_padre`dw_filtro within wtc_consulta_almacen_ubicacion_bultos
integer x = 1605
integer y = 240
integer width = 4247
integer height = 260
integer taborder = 50
boolean vscrollbar = true
end type

type pb_buscar from wt_consultas_padre`pb_buscar within wtc_consulta_almacen_ubicacion_bultos
integer x = 2939
integer y = 112
integer width = 128
integer height = 112
integer taborder = 80
end type

type sle_valor1 from wt_consultas_padre`sle_valor1 within wtc_consulta_almacen_ubicacion_bultos
integer x = 1591
integer y = 132
integer width = 421
integer height = 108
integer taborder = 10
integer textsize = -14
end type

type em_fecha1 from wt_consultas_padre`em_fecha1 within wtc_consulta_almacen_ubicacion_bultos
integer x = 1605
integer height = 96
integer taborder = 90
string text = ""
end type

type sle_texto from wt_consultas_padre`sle_texto within wtc_consulta_almacen_ubicacion_bultos
integer x = 1609
integer y = 132
integer width = 1321
integer height = 96
integer taborder = 20
end type

type lb_lista from wt_consultas_padre`lb_lista within wtc_consulta_almacen_ubicacion_bultos
integer x = 1609
integer y = 132
integer width = 462
integer height = 356
long textcolor = 24076881
end type

type st_reservado from statictext within wtc_consulta_almacen_ubicacion_bultos
integer x = 3406
integer y = 356
integer width = 1006
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 67108864
boolean focusrectangle = false
end type

type sle_observaciones from singlelineedit within wtc_consulta_almacen_ubicacion_bultos
boolean visible = false
integer x = 3707
integer y = 408
integer width = 2450
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
textcase textcase = upper!
end type

type pb_grabar_obs from picturebutton within wtc_consulta_almacen_ubicacion_bultos
boolean visible = false
integer x = 6167
integer y = 400
integer width = 110
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "Save!"
alignment htextalign = left!
end type

event clicked;long id


id = dw_datos.object.id_alm_bultos[dw_datos.GetRow()]

update alm_bultos
set observaciones = :sle_observaciones.text
where id = :id using SQLCA;

IF SQLCA.SQLCode = -1 	THEN   
	MessageBox("SQL error " + String(SQLCA.SQLDBCode),  SQLCA.SQLErrText )
	rollback using SQLCA;
ELSE
	commit using SQLCA;
	dw_datos.object.observaciones[dw_datos.GetRow()] = sle_observaciones.text
END IF


sle_observaciones.text = ''
sle_observaciones.visible = false
pb_grabar_obs.visible = false

end event

type st_1 from statictext within wtc_consulta_almacen_ubicacion_bultos
integer x = 4823
integer y = 32
integer width = 910
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type pb_imprimir_bultos from picturebutton within wtc_consulta_almacen_ubicacion_bultos
integer x = 6112
integer y = 120
integer width = 151
integer height = 128
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Print!"
alignment htextalign = left!
string powertiptext = "Imprimir Etiquetas de Bultos"
end type

event clicked;string ls_ean_13,ls_almacen,ls_zona,ls_sel,ls_descripcion_bulto
long ll_donde,ll_desde,ll_hasta,ll_indice,ll_total,ll_lineas_bulto
int  li_row_etiqueta,li_fila,li_altura
str_alm_bultos lstr_alm_bultos

ll_desde = 1
ll_hasta = dw_datos.rowcount()

dw_etiquetas_bultos_100.reset()

for ll_donde = 1 to ll_hasta		
	ls_almacen = dw_datos.object.almacen[ll_donde]
	ls_zona    = dw_datos.object.zona[ll_donde]
	li_fila    = dw_datos.object.fila[ll_donde]
	li_altura  = dw_datos.object.altura[ll_donde]
	lstr_alm_bultos.id = dw_datos.object.id_alm_bultos[ll_donde]
			
	if f_cargar_str_alm_bultos(lstr_alm_bultos.id,lstr_alm_bultos) then
		ls_descripcion_bulto = ''
		ll_lineas_bulto = 0
		
		select isnull(count(*),0)
		into   :ll_lineas_bulto
		from   alm_bultos_lineas
		where  alm_bultos_lineas.id_alm_bultos = :lstr_alm_bultos.id;
		
		if ll_lineas_bulto = 1 then
			select 'B '+ltrim(rtrim(isnull(articulos.descripcion,'')))+' '+ltrim(rtrim(isnull(formatos.descripcion,'')))+' '+ltrim(rtrim(convert(char(10),isnull(convert(dec(16,0),alm_bultos_lineas.cantidad),0))))+' UDS'
			into   :ls_descripcion_bulto 
			from   alm_bultos_lineas,
					 articulos,
					 formatos 
			where  alm_bultos_lineas.empresa  = articulos.empresa 
			and    alm_bultos_lineas.articulo = articulos.codigo 
			and    alm_bultos_lineas.empresa  = formatos.empresa 
			and    articulos.formato          = formatos.codigo 
			and    alm_bultos_lineas.id_alm_bultos = :lstr_alm_bultos.id;					
		else
			ls_descripcion_bulto = 'B MULTIREFERENCIA'
		end if
		
		ls_ean_13 = lstr_alm_bultos.ean13
		if isnull(ls_ean_13) then ls_ean_13 = ""
	
		if trim(ls_ean_13) = "" then
			ls_ean_13 = "25"+string(lstr_alm_bultos.id,"0000000000")
			ls_ean_13 = f_calcula_ean13(ls_ean_13)
		end if
		
		li_row_etiqueta = dw_etiquetas_bultos_100.insertrow(0)
	
		dw_etiquetas_bultos_100.object.codigo_barras[li_row_etiqueta] = f_imprimir_ean_13(ls_ean_13)
		dw_etiquetas_bultos_100.object.descripcion[li_row_etiqueta]   = ls_almacen+'-'+ls_zona+'-'+string(li_fila,"###0")+'-'+string(li_altura,"##0")+'   '+ls_ean_13//"B"+string(lstr_alm_bultos.id,"0000000000")
		dw_etiquetas_bultos_100.object.almacen[li_row_etiqueta]       = ls_descripcion_bulto
		dw_etiquetas_bultos_100.object.zona[li_row_etiqueta]          = ""
		dw_etiquetas_bultos_100.object.fila[li_row_etiqueta]          = ""
		dw_etiquetas_bultos_100.object.altura[li_row_etiqueta]        = ""
		dw_etiquetas_bultos_100.object.color_fondo[li_row_etiqueta]   = rgb(255,255,255)//dw_datos.object.color_fondo[ll_donde] //
		dw_etiquetas_bultos_100.object.color_texto[li_row_etiqueta]   = rgb(0,0,0)//dw_datos.object.color_texto[ll_donde] //
		dw_etiquetas_bultos_100.object.texto_control[li_row_etiqueta] = ls_almacen+'-'+ls_zona+'-'+string(li_fila,"###0")+'-'+string(li_altura,"##0")
	
		dw_etiquetas_bultos_100.object.flecha_abajo[li_row_etiqueta]  = 'N'
		dw_etiquetas_bultos_100.object.flecha_arriba[li_row_etiqueta] = 'N'												
	end if

next

if li_row_etiqueta > 0 then
	dw_etiquetas_bultos_100.setredraw(false)
	//dw_etiquetas_bultos_100.Object.DataWindow.Zoom = 100
	dw_etiquetas_bultos_100.groupcalc()
	f_imprimir_datawindow(dw_etiquetas_bultos_100)
	//dw_etiquetas_bultos_100.Object.DataWindow.Zoom = 50
	dw_etiquetas_bultos_100.setredraw(true)
	
	dw_etiquetas_bultos_100.reset()
end if
end event

type dw_etiquetas_bultos_100 from datawindow within wtc_consulta_almacen_ubicacion_bultos
boolean visible = false
integer x = 4334
integer y = 1136
integer width = 567
integer height = 756
integer taborder = 51
boolean bringtotop = true
string title = "none"
string dataobject = "dw_etiquetas_bultos_ubicaciones_100x60"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

