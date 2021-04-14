$PBExportHeader$wtc_consulta_stock_costes_promocion.srw
forward
global type wtc_consulta_stock_costes_promocion from wt_consultas_padre
end type
end forward

global type wtc_consulta_stock_costes_promocion from wt_consultas_padre
integer width = 5065
integer height = 3344
string title = "Consulta Stock Promoción con Costes"
end type
global wtc_consulta_stock_costes_promocion wtc_consulta_stock_costes_promocion

type variables
string sql_inicial, sql_final, sql_inicial_parte1, sql_inicial_parte2, sql_final_parte1, sql_final_parte2
end variables

forward prototypes
public function string f_montar_filtro (string consulta_inicial)
public function string f_montar_filtro_interior (string consulta_inicial)
end prototypes

public function string f_montar_filtro (string consulta_inicial);string montaje
int j


montaje = ''
for j = 1 to dw_montaje_filtro.rowcount()
	
	//Descartamos Filtros en SQL dentro del group by
	if pos(dw_montaje_filtro.object.linea[j], "Fecha Facturación") = 0 then
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

public function string f_montar_filtro_interior (string consulta_inicial);string montaje
int j


montaje = ''
for j = 1 to dw_montaje_filtro.rowcount()
	
	//Solo aplicamos filtros para el SQL dentro del group by
	if pos(dw_montaje_filtro.object.linea[j], "Fecha Facturación") > 0 then
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

on wtc_consulta_stock_costes_promocion.create
call super::create
end on

on wtc_consulta_stock_costes_promocion.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;dw_datos.SetTransObject(SQLCA)

sql_inicial = " SELECT articulos.codigo, articulos.descripcion , ISNULL(codigo_compras, '') CODIGO_COMPRAS, "+&
					" ISNULL(comartpro.precio, 0 ) PRECIO, ISNULL(coste_estimado, 0) COSTE_UNITARIO,  "+&
				   " sum(almacenmovimientos.cantidade -almacenmovimientos.cantidads) STOCK,  "+&
					" ISNULL(coste_estimado * sum(almacenmovimientos.cantidade -almacenmovimientos.cantidads), 0) COSTE "+&
					" FROM almacenmovimientos "+&
					" INNER JOIN articulos ON almacenmovimientos.empresa = articulos.empresa AND almacenmovimientos.articulo = articulos.codigo "+&
					" LEFT OUTER JOIN venmprima ON articulos.empresa = venmprima.empresa AND articulos.codigo_compras = venmprima.codigo "+&
					" LEFT OUTER JOIN comartpro ON venmprima.empresa = comartpro.empresa AND venmprima.codigo = comartpro.mprima  "+&
					" WHERE articulos.promocion = 'S' "+&
					" AND ( comartpro.precio = (SELECT TOP 1 P.precio  "+&
					" 						FROM comartpro P  "+&
					" 						WHERE p.empresa = comartpro.empresa  "+&
					" 						AND p.mprima = comartpro.mprima  "+&
					" 						ORDER BY P.precio ASC)  or comartpro.precio is null) "+&
					" AND ( comartpro.proveedor = (select top 1 comartpro.proveedor"+&
					"		from comartpro "+&
					"		where comartpro.mprima = venmprima.codigo "+&
					"		order by precio ASC ) OR comartpro.proveedor IS NULL ) "			


sql_final = " GROUP BY articulos.codigo, articulos.descripcion , codigo_compras, comartpro.precio, coste_estimado "+&
				" HAVING sum(almacenmovimientos.cantidade -almacenmovimientos.cantidads) > 0 "+&
				" ORDER BY COSTE DESC "


/*

dw_datos.SetTransObject(SQLCA)

sql_inicial = " SELECT articulos.codigo, articulos.descripcion , ISNULL(codigo_compras, '') CODIGO_COMPRAS, "+&
					" ISNULL(comartpro.precio, 0 ) PRECIO, ISNULL(coste_estimado, 0) COSTE_UNITARIO,  "+&
				   " sum(almacenmovimientos.cantidade -almacenmovimientos.cantidads) STOCK,  "+&
					" ISNULL(coste_estimado * sum(almacenmovimientos.cantidade -almacenmovimientos.cantidads), 0) COSTE "+&
					" FROM almacenmovimientos "+&
					" INNER JOIN articulos ON almacenmovimientos.empresa = articulos.empresa AND almacenmovimientos.articulo = articulos.codigo "+&
					" LEFT OUTER JOIN venmprima ON articulos.empresa = venmprima.empresa AND articulos.codigo_compras = venmprima.codigo "+&
					" LEFT OUTER JOIN comartpro ON venmprima.empresa = comartpro.empresa AND venmprima.codigo = comartpro.mprima  "+&
					" INNER JOIN ventarifas_precios ON articulos.empresa = ventarifas_precios.empresa and articulos.codigo = ventarifas_precios.articulos_codigo "+&
					" WHERE articulos.promocion = 'S' "+&
					" AND ( comartpro.precio = (SELECT TOP 1 P.precio  "+&
					" 						FROM comartpro P  "+&
					" 						WHERE p.empresa = comartpro.empresa  "+&
					" 						AND p.mprima = comartpro.mprima  "+&
					" 						ORDER BY P.precio ASC)  or comartpro.precio is null) "
					


sql_final = " GROUP BY articulos.codigo, articulos.descripcion , codigo_compras, comartpro.precio, coste_estimado "+&
				" HAVING sum(almacenmovimientos.cantidade -almacenmovimientos.cantidads) > 0 "+&
				" ORDER BY COSTE DESC "

*/

/*
SELECT articulos.codigo, articulos.descripcion , ISNULL(codigo_compras, '') CODIGO_COMPRAS, 
		ISNULL(comartpro.precio, 0 ) PRECIO, ISNULL(coste_estimado, 0) COSTE_UNITARIO, 
		sum(almacenmovimientos.cantidade -almacenmovimientos.cantidads) STOCK, 
ISNULL(coste_estimado * sum(almacenmovimientos.cantidade -almacenmovimientos.cantidads), 0) COSTE,
ISNULL(ventarifas_precios.precio * sum(almacenmovimientos.cantidade -almacenmovimientos.cantidads), 0) IMPORTE_VTA

FROM almacenmovimientos
INNER JOIN articulos ON almacenmovimientos.empresa = articulos.empresa AND almacenmovimientos.articulo = articulos.codigo
LEFT OUTER JOIN venmprima ON articulos.empresa = venmprima.empresa AND articulos.codigo_compras = venmprima.codigo
LEFT OUTER JOIN comartpro ON venmprima.empresa = comartpro.empresa AND venmprima.codigo = comartpro.mprima 
INNER JOIN ventarifas_precios ON articulos.empresa = ventarifas_precios.empresa and articulos.codigo = ventarifas_precios.articulos_codigo 
WHERE articulos.promocion = 'S'
AND ( comartpro.precio = (SELECT TOP 1 P.precio 
						FROM comartpro P 
						WHERE p.empresa = comartpro.empresa 
						AND p.mprima = comartpro.mprima 
						ORDER BY P.precio ASC)  or comartpro.precio is null)
and ventarifas_precios.ventarifas_codigo = (SELECT top 1 v.ventarifas_codigo 
														FROM ventarifas_precios v 
														WHERE v.empresa = almacenmovimientos.empresa 
															and v.articulos_codigo = almacenmovimientos.articulo 
															and v.calidades_codigo = almacenmovimientos.calidad 
															and v.ventarifas_codigo <> '5'
															order by v.precio asc)
GROUP BY articulos.codigo, articulos.descripcion , codigo_compras, comartpro.precio, coste_estimado, ventarifas_precios.precio
HAVING sum(almacenmovimientos.cantidade -almacenmovimientos.cantidads) > 0
ORDER BY COSTE DESC
*/
end event

type st_registros_padre from wt_consultas_padre`st_registros_padre within wtc_consulta_stock_costes_promocion
end type

type st_total_padre from wt_consultas_padre`st_total_padre within wtc_consulta_stock_costes_promocion
end type

type pb_imprimir from wt_consultas_padre`pb_imprimir within wtc_consulta_stock_costes_promocion
integer x = 4347
integer y = 124
integer taborder = 0
end type

event pb_imprimir::clicked;String new_sql
if dw_datos.rowcount() > 0 then
	f_imprimir_datawindow(dw_datos)
end if
end event

type pb_borrar from wt_consultas_padre`pb_borrar within wtc_consulta_stock_costes_promocion
integer x = 4503
integer y = 124
integer taborder = 0
end type

type dw_montaje_filtro from wt_consultas_padre`dw_montaje_filtro within wtc_consulta_stock_costes_promocion
integer width = 2985
integer height = 224
end type

type pb_1 from wt_consultas_padre`pb_1 within wtc_consulta_stock_costes_promocion
integer x = 3269
integer y = 124
integer taborder = 0
end type

event pb_1::clicked;call super::clicked;string new_sql, filtro_dw
long fila, j

fila = dw_montaje_filtro.getrow()
dw_montaje_filtro.deleterow(fila)

new_sql = sql_inicial + f_montar_filtro_interior(sql_inicial_parte1) + sql_final_parte1 + f_montar_filtro_interior(sql_inicial_parte2) + sql_final_parte2
new_sql = f_montar_filtro(new_sql)  + sql_final

dw_datos.SetSQLSelect ( new_sql )
dw_datos.retrieve()

//Filtros mediante Datawindow
/*
filtro_dw = "1 = 1"
For j = 1 To dw_montaje_filtro.rowcount()
	if pos(dw_montaje_filtro.object.linea[j] , "Existencias") <> 0 then
		filtro_dw = filtro_dw + " and " + dw_montaje_filtro.object.filtro[j]
	end if
Next
dw_datos.setfilter(filtro_dw)
dw_datos.filter()
*/

if dw_montaje_filtro.rowcount() > 3 then
	dw_montaje_filtro.height = dw_montaje_filtro.height -75
	dw_datos.y = dw_datos.y - 75
	dw_datos.height = dw_datos.height + 75
else
	dw_datos.y = 512
	dw_datos.height = 2192
	dw_montaje_filtro.height = 225
end if

if dw_datos.rowcount() > 0 then
	dw_datos.setrow(1)
	dw_datos.Event rowfocuschanged(1)
end if
end event

type pb_reset from wt_consultas_padre`pb_reset within wtc_consulta_stock_costes_promocion
integer x = 4658
integer y = 124
integer taborder = 0
end type

type pb_anyadir1 from wt_consultas_padre`pb_anyadir1 within wtc_consulta_stock_costes_promocion
integer x = 3118
integer y = 124
integer taborder = 0
end type

event pb_anyadir1::clicked;call super::clicked;int index, fila
long i, j, k
string cadena_or, cadena_or_visible
string new_sql, filtro, filtro_dw
boolean crear_filtro
string descripcion_extra

if ddlb_campo.text <> "" or dw_montaje_filtro.rowcount() = 0 then

	index = ddlb_campo.SelectItem ( ddlb_campo.text, 0 )
	
	choose case ddlb_campo.text
		case "Artículo (Descripción)"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " almacenmovimientos.articulo = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Articulo = "+dw_filtro.object.#1[i]+" "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR almacenmovimientos.articulo = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#1[i]//+" "+dw_filtro.object.#2[i]//Demasiado largo
					end if
				end if
			next 
		case "Artículo (Código)"
			if cadena_or = '' then
				descripcion_extra = ""
				SELECT descripcion INTO :descripcion_extra FROM articulos WHERE empresa = :codigo_empresa AND codigo = :sle_valor1.text;
				cadena_or = " almacenmovimientos.articulo "+ddlb_operador.text+" '"+sle_valor1.text+"' "
				cadena_or_visible = " Artículo "+ddlb_operador.text+" '"+sle_valor1.text+" "+descripcion_extra+"' "
			end if
		case "Fecha"
			if cadena_or = '' then
				cadena_or = " CONVERT(date, almacenmovimientos.fecha_mov) "+ddlb_operador.text+" '"+em_fecha1.text+"' "
				cadena_or_visible = " Fecha "+ddlb_operador.text+" "+em_fecha1.text
			end if
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
			
			new_sql = sql_inicial + f_montar_filtro_interior(sql_inicial_parte1) + sql_final_parte1 + f_montar_filtro_interior(sql_inicial_parte2) + sql_final_parte2
			new_sql = f_montar_filtro(new_sql) + sql_final
			
			ddlb_campo.text = ''
			dw_filtro.visible = false
			dw_filtro.height = 137
		else
			new_sql = sql_inicial + sql_inicial_parte1 + sql_final_parte1 + sql_inicial_parte2 + sql_final_parte2 + sql_final
		end if
	else
		new_sql = sql_inicial + sql_inicial_parte1 + sql_final_parte1 + sql_inicial_parte2 + sql_final_parte2 + sql_final
	end if
	
	dw_datos.SetSQLSelect ( new_sql )
	dw_datos.retrieve()
	
	//Filtros mediante Datawindow
	/*
	filtro_dw = "1 = 1"
	For j = 1 To dw_montaje_filtro.rowcount()
		if pos(dw_montaje_filtro.object.linea[j] , "Existencias") <> 0 then
			filtro_dw = filtro_dw + " and " + dw_montaje_filtro.object.filtro[j]	
		end if
	Next
	dw_datos.setfilter(filtro_dw)		
	dw_datos.filter()
	*/
	
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
	
	new_sql = sql_inicial + f_montar_filtro_interior(sql_inicial_parte1) + sql_final_parte1 + f_montar_filtro_interior(sql_inicial_parte2) + sql_final_parte2
	new_sql = f_montar_filtro(new_sql) + sql_final
	
	dw_datos.SetSQLSelect ( new_sql )
	dw_datos.retrieve()
	
	//Filtros mediante Datawindow
	/*
	filtro_dw = "1 = 1"
	For j = 1 To dw_montaje_filtro.rowcount()
		if pos(dw_montaje_filtro.object.linea[j] , "Existencias") <> 0 then
			filtro_dw = filtro_dw + " and " + dw_montaje_filtro.object.filtro[j]
		end if
	Next
	dw_datos.setfilter(filtro_dw)		
	dw_datos.filter()
	*/
	
	dw_datos.setfocus()
	if dw_datos.rowcount() > 0 then
		dw_datos.setrow(1)
		dw_datos.Event rowfocuschanged(1)
	end if
end if
end event

type ddlb_operador from wt_consultas_padre`ddlb_operador within wtc_consulta_stock_costes_promocion
integer x = 951
integer taborder = 20
integer weight = 700
long textcolor = 23016974
boolean sorted = false
string item[] = {"","",""}
end type

type ddlb_campo from wt_consultas_padre`ddlb_campo within wtc_consulta_stock_costes_promocion
integer width = 878
integer height = 1308
integer taborder = 10
integer weight = 700
long textcolor = 24076881
boolean sorted = false
string item[] = {"Fecha","Artículo (Código)","Artículo (Descripción)"}
end type

event ddlb_campo::selectionchanged;call super::selectionchanged;string consulta, new_syntax,  error_syntaxfromSQL, mensaje_error, error_create


ddlb_operador.Reset()
lb_lista.Reset()

CHOOSE CASE ddlb_campo.text
	CASE "Artículo (Descripción)"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select distinct almacenmovimientos.articulo as Código, CONVERT(char(60),articulos.descripcion) as Descripción, formatos.abreviado as Formato, art_ver_tipooperacion.descripcion_abr as Operación, almusos.descripcion AS Uso "+&
						"from almacenmovimientos LEFT OUTER JOIN articulos ON almacenmovimientos.empresa = articulos.empresa AND almacenmovimientos.articulo = articulos.codigo "+&
						"LEFT OUTER JOIN formatos ON articulos.empresa = formatos.empresa AND articulos.formato = formatos.codigo "+&
						"LEFT OUTER JOIN almusos ON articulos.empresa = almusos.empresa AND articulos.uso = almusos.codigo "+&
						"LEFT OUTER JOIN art_ver_tipooperacion ON articulos.empresa = art_ver_tipooperacion.empresa AND articulos.tipo_operacion = art_ver_tipooperacion.codigo "+&
						"where articulos.promocion = 'S' and almacenmovimientos.empresa = '"+codigo_empresa+"' order by CONVERT(char(60), articulos.descripcion)"
		
	CASE "Artículo (Código)"
		dw_filtro.visible = false
		pb_buscar.visible = false
		sle_texto.visible = false
		em_fecha1.visible = false
		sle_valor1.visible = true
		lb_lista.visible = false
		
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
	CASE "Fecha"
		dw_filtro.visible = false
		pb_buscar.visible = false
		sle_texto.visible = false
		em_fecha1.visible = true
		sle_valor1.visible = false
		lb_lista.visible = false
		
		ddlb_operador.AddItem ("=")
		ddlb_operador.AddItem (">")
		ddlb_operador.AddItem ("<")
		ddlb_operador.AddItem (">=")
		ddlb_operador.AddItem ("<=")
		ddlb_operador.AddItem ("=")
		
		ddlb_operador.text = "<="
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

type dw_datos from wt_consultas_padre`dw_datos within wtc_consulta_stock_costes_promocion
integer y = 512
integer width = 4896
integer height = 2616
integer taborder = 60
string dataobject = "dwtc_consulta_stock_costes_promocion"
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

event dw_datos::clicked;call super::clicked;string orden_seleccionado

if row = 0 then
	choose case dwo.name 
		case "t_articulo" 
			orden_seleccionado = "articulos_descripcion A"
		case "t_cod_comp" 
			orden_seleccionado = "codigo_compras D"
		case "t_precio" 
			orden_seleccionado = "precio D"
		case "t_coste_u" 
			orden_seleccionado = "coste_unitario D"
		case "t_coste" 
			orden_seleccionado = "coste D"
		case "t_stock" 
			orden_seleccionado = "stock D"
	end choose
	
	dw_datos.setsort(orden_seleccionado)
	dw_datos.sort()
end if
end event

type pb_salir from wt_consultas_padre`pb_salir within wtc_consulta_stock_costes_promocion
integer x = 4814
integer y = 124
integer taborder = 0
end type

type st_titulo from wt_consultas_padre`st_titulo within wtc_consulta_stock_costes_promocion
end type

type p_logo from wt_consultas_padre`p_logo within wtc_consulta_stock_costes_promocion
integer x = 4448
integer y = 16
end type

type dw_filtro from wt_consultas_padre`dw_filtro within wtc_consulta_stock_costes_promocion
integer x = 1317
integer y = 240
integer width = 1673
integer height = 260
integer taborder = 70
boolean vscrollbar = true
end type

type pb_buscar from wt_consultas_padre`pb_buscar within wtc_consulta_stock_costes_promocion
integer x = 2871
integer y = 132
integer taborder = 90
end type

type sle_valor1 from wt_consultas_padre`sle_valor1 within wtc_consulta_stock_costes_promocion
integer x = 1312
integer width = 398
integer height = 96
integer taborder = 30
end type

type em_fecha1 from wt_consultas_padre`em_fecha1 within wtc_consulta_stock_costes_promocion
integer x = 1307
integer height = 96
integer taborder = 110
string text = ""
end type

type sle_texto from wt_consultas_padre`sle_texto within wtc_consulta_stock_costes_promocion
integer x = 1312
integer y = 132
integer height = 96
integer taborder = 40
end type

type lb_lista from wt_consultas_padre`lb_lista within wtc_consulta_stock_costes_promocion
integer x = 1312
integer y = 132
integer width = 462
integer height = 356
integer taborder = 80
long textcolor = 24076881
end type

