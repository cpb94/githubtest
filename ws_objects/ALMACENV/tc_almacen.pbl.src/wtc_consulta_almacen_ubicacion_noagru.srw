$PBExportHeader$wtc_consulta_almacen_ubicacion_noagru.srw
forward
global type wtc_consulta_almacen_ubicacion_noagru from wt_consultas_padre
end type
type dw_observaciones from datawindow within wtc_consulta_almacen_ubicacion_noagru
end type
end forward

global type wtc_consulta_almacen_ubicacion_noagru from wt_consultas_padre
integer width = 5179
integer height = 3152
string title = "Consulta Material por Ubicación"
dw_observaciones dw_observaciones
end type
global wtc_consulta_almacen_ubicacion_noagru wtc_consulta_almacen_ubicacion_noagru

type variables
string sql_inicial, sql_final, orden_seleccionado
end variables

forward prototypes
public function string f_montar_filtro (string consulta_inicial)
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

on wtc_consulta_almacen_ubicacion_noagru.create
int iCurrent
call super::create
this.dw_observaciones=create dw_observaciones
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_observaciones
end on

on wtc_consulta_almacen_ubicacion_noagru.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_observaciones)
end on

event open;call super::open;dw_datos.SetTransObject(SQLCA)
dw_observaciones.SetTransObject(SQLCA)

sql_inicial = "SELECT almacenmovimientos.almacen, "+&
"almacenmovimientos.zona, "+&
"almacenmovimientos.fila, "+&
"almacenmovimientos.altura, "+&
"almacenmovimientos.articulo, "+&
"articulos.descripcion, "+&
"almacenmovimientos.calidad, "+&
"almacenmovimientos.tono, "+&
"almacenmovimientos.calibre, "+&
"almacenmovimientos.formato, "+&
"formatos.abreviado, "+&
"almacenmovimientos_observaciones.observaciones, "+&
"genter.razon, "+&
"SUM(almacenmovimientos.cantidade - almacenmovimientos.cantidads) as existencias "+&
"FROM almacenmovimientos "+&
"LEFT OUTER JOIN almacenmovimientos_observaciones ON almacenmovimientos.empresa = almacenmovimientos_observaciones.empresa AND almacenmovimientos.almacen = almacenmovimientos_observaciones.almacen AND almacenmovimientos.zona = almacenmovimientos_observaciones.zona AND almacenmovimientos.fila = almacenmovimientos_observaciones.fila AND almacenmovimientos.altura = almacenmovimientos_observaciones.altura AND almacenmovimientos.articulo = almacenmovimientos_observaciones.articulo AND almacenmovimientos.calidad = almacenmovimientos_observaciones.calidad AND almacenmovimientos.tono = almacenmovimientos_observaciones.tono AND almacenmovimientos.calibre = almacenmovimientos_observaciones.calibre AND almacenmovimientos.tipo_pallet = almacenmovimientos_observaciones.tipo_pallet AND almacenmovimientos.caja = almacenmovimientos_observaciones.caja "+&
"LEFT OUTER JOIN articulos ON almacenmovimientos.empresa = articulos.empresa AND almacenmovimientos.articulo = articulos.codigo "+&
"LEFT OUTER JOIN formatos ON almacenmovimientos.empresa = formatos.empresa AND almacenmovimientos.formato = formatos.codigo "+&
"LEFT OUTER JOIN genter ON articulos.empresa = genter.empresa AND articulos.cliente = genter.codigo AND genter.tipoter = 'C' "+&
"WHERE almacenmovimientos.empresa = '"+codigo_empresa+"' "

sql_final = "GROUP BY almacenmovimientos.almacen, "+&
"almacenmovimientos.zona, "+&
"almacenmovimientos.fila, "+&
"almacenmovimientos.altura, "+&
"almacenmovimientos.articulo, "+&
"articulos.descripcion, "+&
"almacenmovimientos.calidad, "+&
"almacenmovimientos.tono, "+&
"almacenmovimientos.calibre, "+&
"almacenmovimientos.formato, "+&
"formatos.abreviado, "+&
"almacenmovimientos_observaciones.observaciones, "+&
"genter.razon "+&
"HAVING SUM(almacenmovimientos.cantidade - almacenmovimientos.cantidads) > 0 "+&
"ORDER BY CONVERT(integer,almacenmovimientos.almacen), "+&
"almacenmovimientos.zona, "+&
"CONVERT(integer,almacenmovimientos.fila), "+&
"CONVERT(integer,almacenmovimientos.altura), "+&
"CONVERT(integer,almacenmovimientos.articulo), "+&
"almacenmovimientos.calidad, "+&
"almacenmovimientos.tono, "+&
"almacenmovimientos.calibre ASC"

end event

type st_registros_padre from wt_consultas_padre`st_registros_padre within wtc_consulta_almacen_ubicacion_noagru
end type

type st_total_padre from wt_consultas_padre`st_total_padre within wtc_consulta_almacen_ubicacion_noagru
end type

type pb_imprimir from wt_consultas_padre`pb_imprimir within wtc_consulta_almacen_ubicacion_noagru
integer x = 4507
integer y = 124
integer taborder = 0
end type

event pb_imprimir::clicked;String new_sql
if dw_datos.rowcount() > 0 then
	f_imprimir_datawindow(dw_datos)
end if
end event

type pb_borrar from wt_consultas_padre`pb_borrar within wtc_consulta_almacen_ubicacion_noagru
integer x = 4663
integer y = 124
integer taborder = 0
end type

type dw_montaje_filtro from wt_consultas_padre`dw_montaje_filtro within wtc_consulta_almacen_ubicacion_noagru
integer width = 5070
integer height = 224
end type

type pb_1 from wt_consultas_padre`pb_1 within wtc_consulta_almacen_ubicacion_noagru
integer x = 4357
integer y = 124
integer taborder = 0
end type

event pb_1::clicked;call super::clicked;string new_sql, filtro_dw
long fila, j

fila = dw_montaje_filtro.getrow()
dw_montaje_filtro.deleterow(fila)
new_sql = f_montar_filtro(sql_inicial)  + sql_final
dw_datos.SetSQLSelect ( new_sql )
dw_datos.retrieve()

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
	dw_datos.height = 2192
	dw_montaje_filtro.height = 225
end if

if dw_datos.rowcount() > 0 then
	dw_datos.setrow(1)
	dw_datos.Event rowfocuschanged(1)
end if
end event

type pb_reset from wt_consultas_padre`pb_reset within wtc_consulta_almacen_ubicacion_noagru
integer x = 4818
integer y = 124
integer taborder = 0
end type

type pb_anyadir1 from wt_consultas_padre`pb_anyadir1 within wtc_consulta_almacen_ubicacion_noagru
integer x = 4206
integer y = 124
integer taborder = 0
end type

event pb_anyadir1::clicked;call super::clicked;int index, fila
long i, j, k
string cadena_or, cadena_or_visible, descripcion_extra
string new_sql, filtro, filtro_dw
boolean crear_filtro

if ddlb_campo.text <> "" or dw_montaje_filtro.rowcount() = 0 then

	index = ddlb_campo.SelectItem ( ddlb_campo.text, 0 )
	
	choose case ddlb_campo.text
		case "Almacen"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " almacenmovimientos.almacen = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Almacen = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR almacenmovimientos.almacen = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
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
		case "Articulo"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " almacenmovimientos.articulo = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Articulo = "+dw_filtro.object.#1[i]
					else
						cadena_or = cadena_or+" OR almacenmovimientos.articulo = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#1[i]
					end if
				end if
			next 
		CASE "Formato"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " almacenmovimientos.formato = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Formato = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR almacenmovimientos.formato = '"+dw_filtro.object.#1[i]+"' "
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
		case "Zona"
			if cadena_or = '' then
				cadena_or = " almacenmovimientos.zona "+ddlb_operador.text+" '"+sle_valor1.text+"' "
				cadena_or_visible = " Zona "+ddlb_operador.text+" '"+sle_valor1.text+"' "
			end if
		case "Fila"
			if cadena_or = '' then
				cadena_or = " almacenmovimientos.fila "+ddlb_operador.text+" '"+sle_valor1.text+"' "
				cadena_or_visible = " Fila "+ddlb_operador.text+" '"+sle_valor1.text+"' "
			end if
		case "Altura"
			if cadena_or = '' then
				cadena_or = " almacenmovimientos.altura "+ddlb_operador.text+" '"+sle_valor1.text+"' "
				cadena_or_visible = " Altura "+ddlb_operador.text+" '"+sle_valor1.text+"' "
			end if
		case "Existencias"
			if cadena_or = '' then
				cadena_or = " existencias "+ddlb_operador.text+" "+sle_valor1.text+" "
				cadena_or_visible = " Existencias "+ddlb_operador.text+" "+sle_valor1.text
			end if
		case "Ubicado en Muelle"
			for k = 1 to lb_lista.totalitems()
				if lb_lista.state(k) = 1 then
					if cadena_or = '' then
						if UPPER(lb_lista.Text (k)) = 'S' then
							cadena_or = " (almacenmovimientos.almacen = '1' AND almacenmovimientos.zona = 'P' AND almacenmovimientos.fila = 1 AND almacenmovimientos.altura = 1) "
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
	
	dw_datos.SetSQLSelect ( new_sql )
	dw_datos.retrieve()
	
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
	
	dw_datos.SetSQLSelect ( new_sql )
	dw_datos.retrieve()
	
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
end if
end event

type ddlb_operador from wt_consultas_padre`ddlb_operador within wtc_consulta_almacen_ubicacion_noagru
integer x = 951
integer taborder = 20
integer weight = 700
long textcolor = 23016974
boolean sorted = false
end type

type ddlb_campo from wt_consultas_padre`ddlb_campo within wtc_consulta_almacen_ubicacion_noagru
integer width = 878
integer height = 1308
integer taborder = 10
integer weight = 700
long textcolor = 24076881
boolean sorted = false
string item[] = {"Almacen","Zona","Fila","Altura","Articulo","Artículo (Código)","Cliente","Formato","Existencias","Ubicado en Muelle","Uso"}
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
	CASE "Articulo"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select distinct almacenmovimientos.articulo as Código, CONVERT(char(60),articulos.descripcion) as Descripción, formatos.abreviado as Formato, almusos.descripcion AS Uso "+&
						"from almacenmovimientos LEFT OUTER JOIN articulos ON almacenmovimientos.empresa = articulos.empresa AND almacenmovimientos.articulo = articulos.codigo "+&
						"LEFT OUTER JOIN formatos ON articulos.empresa = formatos.empresa AND articulos.formato = formatos.codigo "+&
						"LEFT OUTER JOIN almusos ON articulos.empresa = almusos.empresa AND articulos.uso = almusos.codigo "+&
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
		consulta = "Select formatos.codigo as Código, formatos.ancho as Ancho, formatos.largo as Largo, formatos.abreviado as Descripcion, formatos.abreviado as Comercial "+&
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
	CASE "Zona", "Fila", "Altura"
		dw_filtro.visible = false
		pb_buscar.visible = false
		sle_texto.visible = false
		em_fecha1.visible = false
		sle_valor1.visible = true
		lb_lista.visible = false
		
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		
	CASE "Existencias"
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
		
		ddlb_operador.text = ">="
	CASE "Ubicado en Muelle"
		dw_filtro.visible = false
		pb_buscar.visible = false
		sle_texto.visible = false
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = true
		
		lb_lista.AddItem ("S")
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="	
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

type dw_datos from wt_consultas_padre`dw_datos within wtc_consulta_almacen_ubicacion_noagru
integer y = 512
integer width = 5065
integer height = 2408
integer taborder = 60
string dataobject = "dwtc_consulta_almacen_ubicacion"
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

choose case dwo.name 
	case "t_articulo" 
		orden_seleccionado = "articulos_descripcion A"
	case "t_ciente" 
		orden_seleccionado = "genter_razon A"
	case "t_formato" 
		orden_seleccionado = "formatos_abreviado A"
	case "t_almacen" 
		orden_seleccionado = "integer(almacen) A"
	case "t_zona" 
		orden_seleccionado = "zona A"
	case "t_fila" 
		orden_seleccionado = "fila A"
	case "t_altura" 
		orden_seleccionado = "altura A"
	case "t_existencias" 
		orden_seleccionado = "existencias D"		
	case "b_cambiar" 
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
end choose

dw_datos.setsort(orden_seleccionado)
dw_datos.sort()
end event

type pb_salir from wt_consultas_padre`pb_salir within wtc_consulta_almacen_ubicacion_noagru
integer x = 4974
integer y = 124
integer taborder = 0
end type

type st_titulo from wt_consultas_padre`st_titulo within wtc_consulta_almacen_ubicacion_noagru
end type

type p_logo from wt_consultas_padre`p_logo within wtc_consulta_almacen_ubicacion_noagru
integer x = 4608
integer y = 8
end type

type dw_filtro from wt_consultas_padre`dw_filtro within wtc_consulta_almacen_ubicacion_noagru
integer x = 1317
integer y = 240
integer width = 2053
integer height = 260
integer taborder = 70
boolean vscrollbar = true
end type

type pb_buscar from wt_consultas_padre`pb_buscar within wtc_consulta_almacen_ubicacion_noagru
integer x = 2871
integer y = 132
integer taborder = 90
end type

type sle_valor1 from wt_consultas_padre`sle_valor1 within wtc_consulta_almacen_ubicacion_noagru
integer x = 1312
integer width = 398
integer height = 96
integer taborder = 30
end type

type em_fecha1 from wt_consultas_padre`em_fecha1 within wtc_consulta_almacen_ubicacion_noagru
integer x = 1307
integer height = 96
integer taborder = 110
string text = ""
end type

type sle_texto from wt_consultas_padre`sle_texto within wtc_consulta_almacen_ubicacion_noagru
integer x = 1312
integer y = 132
integer height = 96
integer taborder = 40
end type

type lb_lista from wt_consultas_padre`lb_lista within wtc_consulta_almacen_ubicacion_noagru
integer x = 1312
integer y = 132
integer width = 462
integer height = 356
integer taborder = 80
long textcolor = 24076881
end type

type dw_observaciones from datawindow within wtc_consulta_almacen_ubicacion_noagru
boolean visible = false
integer x = 2875
integer y = 60
integer width = 1257
integer height = 440
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "dwtc_aux_almacenmovimientos_observaciones"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;Long filasel

if dwo.name = "b_cancelar" then
	this.visible = false
elseif dwo.name = "b_guardar" then
	filasel = dw_datos.getrow()
	if this.update() = 1 then
		commit using sqlca;
		pb_anyadir1.triggerevent("clicked")
	else
		MessageBox("Error", "Se ha producido un error en el guardado")
		rollback using sqlca;
		pb_anyadir1.triggerevent("clicked")
	end if
	this.visible = false
	if dw_datos.rowcount() > 0 and filasel > 0 and dw_datos.rowcount() > filasel then
		dw_datos.setfocus()
		dw_datos.setrow(filasel)
		dw_datos.scrolltorow(filasel)
		dw_datos.selectrow(filasel, true)
	end if
end if
end event

