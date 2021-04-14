$PBExportHeader$wtc_int_stock_sugerido.srw
forward
global type wtc_int_stock_sugerido from wt_consultas_padre
end type
end forward

global type wtc_int_stock_sugerido from wt_consultas_padre
integer width = 5609
integer height = 3840
string title = "Introducción Stock Mínimo / Stock Sugerido"
end type
global wtc_int_stock_sugerido wtc_int_stock_sugerido

type variables
string sql_inicial
end variables

forward prototypes
public function string f_montar_filtro (string consulta_inicial)
end prototypes

public function string f_montar_filtro (string consulta_inicial);string montaje
int j


montaje = ''


for j = 1 to dw_montaje_filtro.rowcount()
	if montaje = '' then
		montaje = dw_montaje_filtro.object.filtro[j]
	else
		montaje = montaje +' AND '+ dw_montaje_filtro.object.filtro[j]
	end if
next
if montaje <> '' then
	montaje = consulta_inicial + " AND " + montaje
else
	montaje = consulta_inicial
end if


return montaje


end function

on wtc_int_stock_sugerido.create
call super::create
end on

on wtc_int_stock_sugerido.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;dw_datos.SetTransObject(SQLCA)

sql_inicial = "  SELECT DISTINCT articulos.empresa,   "+&
"         articulos.codigo,   "+&
"         articulos.descripcion,   "+&
"         articulos.cliente,   "+&
"         articulos.familia,   "+&
"		 m2_sugeridos, "+&
"         articulos.lote_minimo,   "+&
"         articulos.stock_min,   "+&
"         articulos.stocksugerido,  "+& 
"         familias.descripcion,   "+&
"         genter.razon , "+&
"         formatos.abreviado "+&
"    FROM articulos LEFT OUTER JOIN familias ON articulos.empresa = familias.empresa AND articulos.familia = familias.codigo LEFT OUTER JOIN genter ON articulos.empresa = genter.empresa AND articulos.codigo = genter.codigo AND genter.tipoter = 'C' "+&
"							INNER JOIN	formatos ON articulos.empresa = formatos.empresa AND  articulos.formato = formatos.codigo "+&
"WHERE articulos.empresa = '"+codigo_empresa+"' "
			  

end event

type st_registros_padre from wt_consultas_padre`st_registros_padre within wtc_int_stock_sugerido
integer x = 3913
integer y = 144
end type

type st_total_padre from wt_consultas_padre`st_total_padre within wtc_int_stock_sugerido
integer x = 4155
integer y = 144
end type

type pb_imprimir from wt_consultas_padre`pb_imprimir within wtc_int_stock_sugerido
integer x = 4923
end type

event pb_imprimir::clicked;if dw_datos.rowcount() > 0 then
	f_imprimir_datawindow(dw_datos)
end if

end event

type pb_borrar from wt_consultas_padre`pb_borrar within wtc_int_stock_sugerido
integer x = 5079
end type

type dw_montaje_filtro from wt_consultas_padre`dw_montaje_filtro within wtc_int_stock_sugerido
integer width = 5477
integer height = 224
end type

type pb_1 from wt_consultas_padre`pb_1 within wtc_int_stock_sugerido
integer x = 4663
integer taborder = 0
end type

event pb_1::clicked;call super::clicked;string new_sql
long fila

fila = dw_montaje_filtro.getrow()
dw_montaje_filtro.deleterow(fila)
new_sql = f_montar_filtro(sql_inicial)

//if cbx_finalizadas.checked = false then
//	new_sql = new_sql + " and modelo_pieza_ticket.fecha_fin IS NULL "
//end if

dw_datos.SetSQLSelect ( new_sql )
dw_datos.retrieve()

if dw_montaje_filtro.rowcount() > 3 then
	dw_montaje_filtro.height = dw_montaje_filtro.height -75
	dw_datos.y = dw_datos.y - 75
	dw_datos.height = dw_datos.height + 75
else
	dw_datos.y = 512
	dw_datos.height = 3108
	dw_montaje_filtro.height = 225
end if

dw_datos.setfocus()
end event

type pb_reset from wt_consultas_padre`pb_reset within wtc_int_stock_sugerido
integer x = 5234
integer taborder = 0
end type

type pb_anyadir1 from wt_consultas_padre`pb_anyadir1 within wtc_int_stock_sugerido
integer x = 4512
integer taborder = 0
end type

event pb_anyadir1::clicked;call super::clicked;int index, fila
long i, j, k, filas
string cadena_or, cadena_or_visible
string new_sql, filtro
boolean crear_filtro

if ddlb_campo.text <> "" or dw_montaje_filtro.rowcount() = 0 then

	index = ddlb_campo.SelectItem ( ddlb_campo.text, 0 )
	
	choose case ddlb_campo.text
		case "Artículo"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " articulos.codigo = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Artículo = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR articulos.codigo = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 
		
		case "Familia"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " articulos.familia = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Familia = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR articulos.familia = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 
			
		case "Uso"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " articulos.uso = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Uso = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR articulos.uso = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 
			
		case "Cliente"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " articulos.cliente = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Cliente = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR articulos.cliente = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 
			
		case "Artículo (Código)"
			if cadena_or = '' then
				cadena_or = " articulos.codigo "+ddlb_operador.text+" '"+sle_valor1.text+"' "
				cadena_or_visible = " Artículo (Código) "+ddlb_operador.text+" '"+sle_valor1.text+"' "
			end if
			
		case "Largo"
			if cadena_or = '' then
				cadena_or = " formatos.largo "+ddlb_operador.text+" "+sle_valor1.text+" "
				cadena_or_visible = " Largo "+ddlb_operador.text+" "+sle_valor1.text
			end if
			
		case "Ancho"
			if cadena_or = '' then
				cadena_or = " formatos.ancho "+ddlb_operador.text+" "+sle_valor1.text+" "
				cadena_or_visible = " Ancho "+ddlb_operador.text+" "+sle_valor1.text
			end if
			
		case "Promoción"
			for k = 1 to lb_lista.totalitems()
				if lb_lista.state(k) = 1 then
					if cadena_or = '' then
						cadena_or = " articulos.promocion = '"+UPPER(lb_lista.Text (k))+"' "
						cadena_or_visible = "Promoción = " + lb_lista.Text (k)
					else
						cadena_or = cadena_or+" OR articulos.promocion = '"+UPPER(lb_lista.Text (k))+"' "
						cadena_or_visible = cadena_or_visible+", Promoción = "+lb_lista.Text (k)
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
			
			new_sql = f_montar_filtro(sql_inicial)
			
			ddlb_campo.text = ''
			dw_filtro.visible = false
			dw_filtro.height = 137
		end if
	else
		new_sql = sql_inicial
	end if
	
//	if cbx_finalizadas.checked = false then
//		new_sql = new_sql + " and modelo_pieza_ticket.fecha_fin IS NULL "
//	end if
	
	dw_datos.SetSQLSelect ( new_sql )
	filas = dw_datos.retrieve()
	
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
	
	if dw_montaje_filtro.rowcount() > 3 and dw_montaje_filtro.rowcount() < 10 then
		dw_montaje_filtro.height = 75 * dw_montaje_filtro.rowcount()
		dw_datos.y = dw_datos.y + 75
		dw_datos.height = dw_datos.height - 75
	end if
	
	if filas > 0 then
		dw_datos.setfocus()
	end if
	
else
	
	//Filtros especiales (Fuera del padre) 
	
//	if cbx_finalizadas.checked = false then
//		new_sql =  f_montar_filtro(sql_inicial) + " and modelo_pieza_ticket.fecha_fin IS NULL "
//	else
//		new_sql =  f_montar_filtro(sql_inicial)
//	end if
	
	new_sql =  f_montar_filtro(sql_inicial)
	
	//Fin filtros especiales
	
	dw_datos.SetSQLSelect (new_sql)
	filas = dw_datos.retrieve()
	
	if filas > 0 then
		dw_datos.setfocus()
	end if
end if





end event

type ddlb_operador from wt_consultas_padre`ddlb_operador within wtc_int_stock_sugerido
integer x = 951
integer taborder = 20
integer weight = 700
long textcolor = 23016974
boolean sorted = false
end type

type ddlb_campo from wt_consultas_padre`ddlb_campo within wtc_int_stock_sugerido
integer width = 878
integer height = 904
integer taborder = 10
integer weight = 700
long textcolor = 24076881
boolean sorted = false
string item[] = {"Uso","Artículo","Artículo (Código)","Cliente","Familia","Ancho","Largo","Promoción"}
end type

event ddlb_campo::selectionchanged;call super::selectionchanged;string consulta, new_syntax,  error_syntaxfromSQL, mensaje_error, error_create


ddlb_operador.Reset()
lb_lista.Reset()

CHOOSE CASE ddlb_campo.text
	CASE "Artículo"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, descripcion as Descripción from articulos where empresa = '"+codigo_empresa+"' AND uso = '3' "
		
	CASE "Cliente"
		
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, razon as Descripción from genter where empresa = '"+codigo_empresa+"' AND tipoter = 'C' "
		
	CASE "Familia"
		
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, descripcion as Descripción from familias where empresa = '"+codigo_empresa+"' "
		
	CASE "Uso"
		
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, descripcion as Descripción from almusos where empresa = '"+codigo_empresa+"' "
		
		
	CASE "Artículo (Código)"
		dw_filtro.visible = false
		pb_buscar.visible = false
		sle_texto.visible = false
		em_fecha1.visible = false
		sle_valor1.visible = true
		lb_lista.visible = false
		
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		
	CASE "Largo", "Ancho"
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
		ddlb_operador.text = ">="
	
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

type dw_datos from wt_consultas_padre`dw_datos within wtc_int_stock_sugerido
integer y = 524
integer width = 5472
integer height = 3108
integer taborder = 60
string dataobject = "dwtc_mant_stock_sugerido"
end type

event dw_datos::itemchanged;call super::itemchanged;String articulo
Dec stock_min, stocksugerido, m2_sugeridos, lote_minimo
dec ancho, largo, piezas

if row > 0 then
	articulo = this.object.codigo[row]

	select formatos.ancho, formatos.largo
	into :ancho, :largo
	from formatos, articulos
	where articulos.empresa = :codigo_empresa
	and articulos.codigo = :articulo
	and articulos.formato = formatos.codigo;
	
	if dwo.name = "m2_sugeridos" then
		if ancho > 0 and largo > 0 then
			piezas = dec(data) / ( ancho * largo / 10000 )
			
			// Esto es para que la cantidad de piezas sea múltiplo de 250 (250, 500, 750, .......) redondeando al alza.
			if mod (piezas , 250) <> 0 then
				piezas = (truncate ( (piezas / 250 ), 0 ) + 1 ) * 250
			end if
				
			//this.object.stock_min[row] = 	piezas
			this.object.articulos_lote_minimo[row] = 	piezas
		end if
		this.accepttext()
		m2_sugeridos = this.object.m2_sugeridos[row] 
	end if

//	if dwo.name = "stock_min"   then
//		stock_min = Dec(data)
//		m2_sugeridos = stock_min  * ancho * largo / 10000
//		this.object.m2_sugeridos[row] = m2_sugeridos
//	else
//		stock_min = this.object.stock_min[row]
//	
//	end if

	if dwo.name = "stock_min"   then
		stock_min = Dec(data)
	else
		stock_min = this.object.stock_min[row]
	
	end if

	if dwo.name = "stocksugerido" then
		stocksugerido = Dec(data)
	else
		stocksugerido = this.object.stocksugerido[row]
	end if

	if dwo.name = "articulos_lote_minimo" then
		lote_minimo = Dec(data)
		m2_sugeridos = lote_minimo  * ancho * largo / 10000
		this.object.m2_sugeridos[row] = m2_sugeridos
	else
		lote_minimo = this.object.articulos_lote_minimo[row]
	end if

end if


UPDATE articulos SET stock_min = :stock_min, stocksugerido = :stocksugerido , m2_sugeridos = :m2_sugeridos, lote_minimo = :lote_minimo
WHERE empresa = :codigo_empresa AND codigo = :articulo using sqlca;
if sqlca.sqlcode = 0 then
	commit using sqlca;
else
	rollback using sqlca;
end if




end event

event dw_datos::clicked;call super::clicked;if dwo.name = 't_articulo' then
	this.SetSort("articulos_descripcion A")
	this.Sort()
end if	             

if dwo.name = 't_formato' then
	this.SetSort("formatos_abreviado A")
	this.Sort()
end if	             

if dwo.name = 't_m2' then
	this.SetSort("m2_sugeridos D")
	this.Sort()
end if	             

if dwo.name = 't_stock_min' then
	this.SetSort("stock_min D")
	this.Sort()
end if	             

if dwo.name = 't_stock_sugerido' then
	this.SetSort("stocksugerido A")
	this.Sort()
end if	             



end event

type pb_salir from wt_consultas_padre`pb_salir within wtc_int_stock_sugerido
integer x = 5390
integer taborder = 0
end type

type st_titulo from wt_consultas_padre`st_titulo within wtc_int_stock_sugerido
integer width = 1243
end type

type p_logo from wt_consultas_padre`p_logo within wtc_int_stock_sugerido
integer x = 5015
end type

type dw_filtro from wt_consultas_padre`dw_filtro within wtc_int_stock_sugerido
integer x = 1298
integer y = 232
integer width = 1673
integer height = 132
integer taborder = 70
boolean vscrollbar = true
end type

type pb_buscar from wt_consultas_padre`pb_buscar within wtc_int_stock_sugerido
integer x = 2871
integer y = 132
integer taborder = 80
end type

type sle_valor1 from wt_consultas_padre`sle_valor1 within wtc_int_stock_sugerido
integer x = 1312
integer width = 398
integer height = 96
integer taborder = 30
end type

type em_fecha1 from wt_consultas_padre`em_fecha1 within wtc_int_stock_sugerido
integer x = 1307
integer height = 96
integer taborder = 90
string text = ""
end type

type sle_texto from wt_consultas_padre`sle_texto within wtc_int_stock_sugerido
integer x = 1312
integer y = 132
integer height = 96
integer taborder = 40
end type

type lb_lista from wt_consultas_padre`lb_lista within wtc_int_stock_sugerido
integer x = 1312
integer y = 132
integer width = 462
integer height = 252
long textcolor = 24076881
end type

