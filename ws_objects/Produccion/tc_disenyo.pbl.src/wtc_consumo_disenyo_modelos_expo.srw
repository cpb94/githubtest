$PBExportHeader$wtc_consumo_disenyo_modelos_expo.srw
forward
global type wtc_consumo_disenyo_modelos_expo from wt_consultas_padre
end type
type dw_grafico1 from datawindow within wtc_consumo_disenyo_modelos_expo
end type
end forward

global type wtc_consumo_disenyo_modelos_expo from wt_consultas_padre
integer width = 8731
integer height = 3480
string title = "Consumo Disco - Imagen Modelo"
dw_grafico1 dw_grafico1
end type
global wtc_consumo_disenyo_modelos_expo wtc_consumo_disenyo_modelos_expo

type variables
String sql_inicial, sql_graf_inicial
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

on wtc_consumo_disenyo_modelos_expo.create
int iCurrent
call super::create
this.dw_grafico1=create dw_grafico1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_grafico1
end on

on wtc_consumo_disenyo_modelos_expo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_grafico1)
end on

event open;call super::open;dw_datos.SetTransObject(SQLCA)
dw_grafico1.settransobject(SQLCA)


sql_inicial = "SELECT 	modelo_archivo_expo.modelo, "+&
"			modelo_archivo_expo.fichero, "+&
"			ISNULL(modelo_archivo_expo.tamanyo, 0) as tamanyo, "+&
"			modelo_archivo_expo.fecha_modificacion, "+&
"			REPLACE(modelo_archivo_expo.coleccion + '-' + modelo_archivo_expo.modelo,' ','') as codigo_unico, "+&
"			modelo.tecnico_dis, "+&
"			tecnico_dis.descripcion "+&
"FROM modelo_archivo_expo "+&
"INNER JOIN modelo ON modelo_archivo_expo.empresa = modelo.empresa AND modelo_archivo_expo.modelo = modelo.modelo "+&
"INNER JOIN tecnico_dis ON modelo.empresa = tecnico_dis.empresa AND modelo.tecnico_dis = tecnico_dis.codigo "+&
"WHERE modelo_archivo_expo.empresa = '"+codigo_empresa+"'"

sql_graf_inicial = sql_inicial
 
end event

type pb_imprimir from wt_consultas_padre`pb_imprimir within wtc_consumo_disenyo_modelos_expo
integer x = 8055
integer y = 128
end type

type pb_borrar from wt_consultas_padre`pb_borrar within wtc_consumo_disenyo_modelos_expo
integer x = 8215
integer y = 124
end type

type dw_montaje_filtro from wt_consultas_padre`dw_montaje_filtro within wtc_consumo_disenyo_modelos_expo
integer width = 8622
integer height = 224
end type

type pb_1 from wt_consultas_padre`pb_1 within wtc_consumo_disenyo_modelos_expo
integer x = 3195
integer y = 120
integer taborder = 0
end type

event pb_1::clicked;call super::clicked;string new_sql, new_sql2
String filtro_post, filtro_post2, filtro
long fila, linea

fila = dw_montaje_filtro.getrow()
dw_montaje_filtro.deleterow(fila)

new_sql = f_montar_filtro(sql_inicial)
new_sql2 = f_montar_filtro(sql_graf_inicial)

dw_datos.SetSQLSelect ( new_sql )
dw_datos.retrieve()

dw_grafico1.SetSQLSelect (new_sql2)
dw_grafico1.retrieve()

if dw_montaje_filtro.rowcount() > 3 then
	dw_montaje_filtro.height = dw_montaje_filtro.height -75
	dw_datos.y = dw_datos.y - 75
	dw_datos.height = dw_datos.height + 75
else
	dw_datos.y = 512
	dw_datos.height = 2764
	
	dw_montaje_filtro.height = 225
end if

dw_datos.setfocus()
if dw_datos.rowcount() > 0 then
	dw_datos.setrow(1)
	dw_datos.Event rowfocuschanged(1)
end if
/*
fila = dw_montaje_filtro.getrow()
dw_montaje_filtro.deleterow(fila)

//new_sql = f_montar_filtro(sql_inicial)
new_sql = f_montar_filtro(sql_parte1) + " UNION " + f_montar_filtro(sql_parte2) + " UNION " + f_montar_filtro(sql_parte3) + " UNION " + f_montar_filtro(sql_parte4) + " UNION " + f_montar_filtro(sql_parte5) + " UNION " + f_montar_filtro(sql_parte6) + " " + sql_orden
new_sql2 = f_montar_filtro(sql_graf1_parte1) + " UNION " + f_montar_filtro(sql_graf1_parte2) + " UNION " + f_montar_filtro(sql_graf1_parte3) + " UNION " + f_montar_filtro(sql_graf1_parte4) + " UNION " + f_montar_filtro(sql_graf1_parte5) + " UNION " + f_montar_filtro(sql_graf1_parte6) + " " + sql_orden_graf 

dw_datos.SetSQLSelect ( new_sql )
dw_datos.retrieve()

dw_grafico1.SetSQLSelect ( new_sql2 )
dw_grafico1.retrieve()

//FILTROS APLICADOS AL DATAWINDOW--------------------------------------------------------------
filtro_post = ""
filtro_post2 = "" //solo gráfico
if dw_montaje_filtro.rowcount() > 0 then
	linea = dw_montaje_filtro.Find("filtro LIKE '%versiones%' ", 1, dw_montaje_filtro.rowcount())
	if linea > 0 then
		filtro = dw_montaje_filtro.object.filtro[linea]
		if filtro_post <> "" then
			filtro_post = filtro_post + " and "
		end if	
		filtro_post = filtro_post + "versiones "+mid(filtro, pos(filtro, ",") + 1, pos(filtro, ":") - pos(filtro, ",") - 1) + " " + +mid(filtro, pos(filtro, ":") + 1, len(filtro) - pos(filtro, ":") - 2)
	end if 
	linea = dw_montaje_filtro.Find("filtro LIKE '%tipo_fichero%' ", 1, dw_montaje_filtro.rowcount())
	if linea > 0 then
		filtro = dw_montaje_filtro.object.filtro[linea]
		if filtro_post <> "" then
			filtro_post = filtro_post + " and "
			filtro_post2 = filtro_post2 + " and "
		end if	
		filtro_post = filtro_post + "tipo_fichero "+mid(filtro, pos(filtro, ",") + 1, pos(filtro, ":") - pos(filtro, ",") - 1) + " " + +mid(filtro, pos(filtro, ":") + 1, len(filtro) - pos(filtro, ":") - 2)
		filtro_post2 = filtro_post2 + "tipo_fichero "+mid(filtro, pos(filtro, ",") + 1, pos(filtro, ":") - pos(filtro, ",") - 1) + " " + +mid(filtro, pos(filtro, ":") + 1, len(filtro) - pos(filtro, ":") - 2)
	end if 
end if

dw_datos.setfilter(filtro_post)
dw_datos.filter()
dw_grafico1.setfilter(filtro_post2)
dw_grafico1.filter()
//---------------------------------------------------------------------------------------------

dw_datos.setfocus()
if dw_datos.rowcount() > 0 then
	dw_datos.setrow(1)
	dw_datos.Event rowfocuschanged(1)
end if
*/
end event

type pb_reset from wt_consultas_padre`pb_reset within wtc_consumo_disenyo_modelos_expo
integer x = 8370
integer y = 124
integer taborder = 0
end type

type pb_anyadir1 from wt_consultas_padre`pb_anyadir1 within wtc_consumo_disenyo_modelos_expo
integer x = 3045
integer y = 120
integer taborder = 0
integer weight = 700
end type

event pb_anyadir1::clicked;call super::clicked;int index, fila
long i, j, k, linea
string cadena_or, cadena_or_visible
string new_sql, new_sql2, filtro, filtro_post, filtro_post2
boolean crear_filtro

if ddlb_campo.text <> "" or dw_montaje_filtro.rowcount() = 0 then

	index = ddlb_campo.SelectItem ( ddlb_campo.text, 0 )
	
	choose case ddlb_campo.text
		case "Diseñador"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " tecnico_dis.codigo = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Diseñador = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR tecnico_dis.codigo = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 
		case "Fecha Modificación"
			if cadena_or = '' then
				cadena_or = " fecha_modificacion "+ddlb_operador.text+" '"+em_fecha1.text+"' "
				cadena_or_visible = " Fecha Modificación "+ddlb_operador.text+" "+em_fecha1.text
			end if
		case "Fichero"
			if cadena_or = '' then
				cadena_or = " REPLACE(modelo_archivo_expo.coleccion + '-' + modelo_archivo_expo.modelo,' ','') LIKE '%"+sle_valor1.text+"%' "
				cadena_or_visible = " Fichero "+ddlb_operador.text+" '"+sle_valor1.text+"' "
			end if
		case "Tamaño (Bytes)"
			if cadena_or = '' then
				cadena_or = " tamanyo "+ddlb_operador.text+" '"+sle_valor1.text+"' "
				cadena_or_visible = " Tamaño "+ddlb_operador.text+" '"+sle_valor1.text+"' "
			end if
		case "Número de Versiones"
			if cadena_or = '' then
				cadena_or = " EXISTS (SELECT * FROM modelo_archivo_expo M WHERE M.coleccion =  modelo_archivo_expo.coleccion AND M.modelo = modelo_archivo_expo.modelo GROUP BY M.coleccion, M.modelo HAVING  COUNT(M.codigo) "+ddlb_operador.text+" "+sle_valor1.text +")"
				cadena_or_visible = " Número de Versiones "+ddlb_operador.text+" '"+sle_valor1.text+"' "
			end if
		case "Modelo en Producción"
			for k = 1 to lb_lista.totalitems()
				if lb_lista.state(k) = 1 then
					if cadena_or = '' then
						cadena_or = "modelo.modelo IN(SELECT articulos.modelo_origen FROM articulos WHERE articulos.empresa = modelo.empresa AND articulos.modelo_origen = modelo.modelo)"
						cadena_or_visible = " Modelo en Producción"
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
			new_sql2 = f_montar_filtro(sql_graf_inicial)
			
			ddlb_campo.text = ''
			dw_filtro.visible = false
			dw_filtro.height = 137
		end if
	else
		new_sql = sql_inicial
		new_sql2 = sql_graf_inicial
	end if
	
	dw_datos.SetSQLSelect ( new_sql )
	dw_datos.retrieve()
	
	dw_grafico1.SetSQLSelect (new_sql2)
	dw_grafico1.retrieve()
	
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
	
	//Tamaños DW en función del número de filtros
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
	

	/*
	
	
	//FILTROS APLICADOS AL DATAWINDOW--------------------------------------------------------------
	filtro_post = ""
	filtro_post2 = "" //solo gráfico
	if dw_montaje_filtro.rowcount() > 0 then
		linea = dw_montaje_filtro.Find("filtro LIKE '%versiones%' ", 1, dw_montaje_filtro.rowcount())
		if linea > 0 then
			filtro = dw_montaje_filtro.object.filtro[linea]
			if filtro_post <> "" then
				filtro_post = filtro_post + " and "
			end if	
			filtro_post = filtro_post + "versiones "+mid(filtro, pos(filtro, ",") + 1, pos(filtro, ":") - pos(filtro, ",") - 1) + " " + +mid(filtro, pos(filtro, ":") + 1, len(filtro) - pos(filtro, ":") - 2)
		end if 
		linea = dw_montaje_filtro.Find("filtro LIKE '%tipo_fichero%' ", 1, dw_montaje_filtro.rowcount())
		if linea > 0 then
			filtro = dw_montaje_filtro.object.filtro[linea]
			if filtro_post <> "" then
				filtro_post = filtro_post + " and "
				filtro_post2 = filtro_post2 + " and "
			end if	
			filtro_post = filtro_post + "tipo_fichero "+mid(filtro, pos(filtro, ",") + 1, pos(filtro, ":") - pos(filtro, ",") - 1) + " " + +mid(filtro, pos(filtro, ":") + 1, len(filtro) - pos(filtro, ":") - 2)
			filtro_post2 = filtro_post2 + "tipo_fichero "+mid(filtro, pos(filtro, ",") + 1, pos(filtro, ":") - pos(filtro, ",") - 1) + " " + +mid(filtro, pos(filtro, ":") + 1, len(filtro) - pos(filtro, ":") - 2)
		end if 
	end if
	
	dw_datos.setfilter(filtro_post)
	dw_datos.filter()
	dw_grafico1.setfilter(filtro_post2)
	dw_grafico1.filter()
	//---------------------------------------------------------------------------------------------
	
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
	
	
	dw_datos.setfocus()
	if dw_datos.rowcount() > 0 then
		dw_datos.setrow(1)
		dw_datos.Event rowfocuschanged(1)
	end if
	*/
else
	
	new_sql = f_montar_filtro(sql_inicial)
	new_sql2 = f_montar_filtro(sql_graf_inicial)
			
	dw_datos.SetSQLSelect ( new_sql )
	dw_datos.retrieve()
	
	dw_grafico1.SetSQLSelect (new_sql2)
	dw_grafico1.retrieve()
	
	dw_datos.setfocus()
	if dw_datos.rowcount() > 0 then
		dw_datos.setrow(1)
		dw_datos.Event rowfocuschanged(1)
	end if
	
	/*
	//new_sql = f_montar_filtro(sql_inicial)
	new_sql = f_montar_filtro(sql_parte1) + " UNION " + f_montar_filtro(sql_parte2) + " UNION " + f_montar_filtro(sql_parte3) + " UNION " + f_montar_filtro(sql_parte4) + " UNION " + f_montar_filtro(sql_parte5) + " UNION " + f_montar_filtro(sql_parte6) + " " + sql_orden
	new_sql2 = f_montar_filtro(sql_graf1_parte1) + " UNION " + f_montar_filtro(sql_graf1_parte2) + " UNION " + f_montar_filtro(sql_graf1_parte3) + " UNION " + f_montar_filtro(sql_graf1_parte4) + " UNION " + f_montar_filtro(sql_graf1_parte5) + " UNION " + f_montar_filtro(sql_graf1_parte6) + " " + sql_orden_graf 
	
	dw_datos.SetSQLSelect ( new_sql )
	dw_datos.retrieve()
	dw_datos.setsort("descoleccionsol_codigo DESC, modelo_modelo DESC")
	dw_datos.sort()
	
	dw_grafico1.SetSQLSelect (new_sql2)
	dw_grafico1.retrieve()
	
	//FILTROS APLICADOS AL DATAWINDOW--------------------------------------------------------------
	filtro_post = ""
	filtro_post2 = "" //solo gráfico
	if dw_montaje_filtro.rowcount() > 0 then
		linea = dw_montaje_filtro.Find("filtro LIKE '%versiones%' ", 1, dw_montaje_filtro.rowcount())
		if linea > 0 then
			filtro = dw_montaje_filtro.object.filtro[linea]
			if filtro_post <> "" then
				filtro_post = filtro_post + " and "
			end if	
			filtro_post = filtro_post + "versiones "+mid(filtro, pos(filtro, ",") + 1, pos(filtro, ":") - pos(filtro, ",") - 1) + " " + +mid(filtro, pos(filtro, ":") + 1, len(filtro) - pos(filtro, ":") - 2)
		end if 
		linea = dw_montaje_filtro.Find("filtro LIKE '%tipo_fichero%' ", 1, dw_montaje_filtro.rowcount())
		if linea > 0 then
			filtro = dw_montaje_filtro.object.filtro[linea]
			if filtro_post <> "" then
				filtro_post = filtro_post + " and "
				filtro_post2 = filtro_post2 + " and "
			end if	
			filtro_post = filtro_post + "tipo_fichero "+mid(filtro, pos(filtro, ",") + 1, pos(filtro, ":") - pos(filtro, ",") - 1) + " " + +mid(filtro, pos(filtro, ":") + 1, len(filtro) - pos(filtro, ":") - 2)
			filtro_post2 = filtro_post2 + "tipo_fichero "+mid(filtro, pos(filtro, ",") + 1, pos(filtro, ":") - pos(filtro, ",") - 1) + " " + +mid(filtro, pos(filtro, ":") + 1, len(filtro) - pos(filtro, ":") - 2)
		end if 
	end if
	
	dw_datos.setfilter(filtro_post)
	dw_datos.filter()
	dw_grafico1.setfilter(filtro_post2)
	dw_grafico1.filter()
	//---------------------------------------------------------------------------------------------
	
	dw_datos.setfocus()
	if dw_datos.rowcount() > 0 then
		dw_datos.setrow(1)
		dw_datos.Event rowfocuschanged(1)
	end if
	*/
end if
end event

type ddlb_operador from wt_consultas_padre`ddlb_operador within wtc_consumo_disenyo_modelos_expo
integer x = 951
integer taborder = 20
integer weight = 700
long textcolor = 23016974
boolean sorted = false
end type

type ddlb_campo from wt_consultas_padre`ddlb_campo within wtc_consumo_disenyo_modelos_expo
integer width = 878
integer height = 904
integer taborder = 10
integer weight = 700
long textcolor = 24076881
string item[] = {"Diseñador","Tamaño (Bytes)","Fichero","Número de Versiones","Fecha Modificación","Modelo en Producción"}
end type

event ddlb_campo::selectionchanged;call super::selectionchanged;string consulta, new_syntax,  error_syntaxfromSQL, mensaje_error, error_create


ddlb_operador.Reset()
lb_lista.Reset()

CHOOSE CASE ddlb_campo.text
	CASE "Diseñador"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false

		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, descripcion as Descripción from tecnico_dis where empresa = '"+codigo_empresa+"' and activo = 'S' order by descripcion "
	CASE "Fecha Modificación"
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
		ddlb_operador.text = ">="
	CASE "Tamaño (Bytes)"
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
	CASE "Número de Versiones"
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
	CASE "Fichero"
		dw_filtro.visible = false
		pb_buscar.visible = false
		sle_texto.visible = false
		em_fecha1.visible = false
		sle_valor1.visible = true
		lb_lista.visible = false
		
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
	CASE "Modelo en Producción"
		dw_filtro.visible = false
		pb_buscar.visible = false
		sle_texto.visible = false
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = true
		
		lb_lista.AddItem ("SI")
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

type dw_datos from wt_consultas_padre`dw_datos within wtc_consumo_disenyo_modelos_expo
integer y = 512
integer width = 3049
integer height = 2764
integer taborder = 60
string dataobject = "dwtc_consumo_disenyo_modelos_expo"
end type

event dw_datos::doubleclicked;call super::doubleclicked;Long id_ventana, fila
str_parametros lstr_param 
String texto_banda_seleccionada

//Obtengo la fila
texto_banda_seleccionada = this.GetBandAtPointer()
//Separamos del string lo que es la banda de lo que es la fila, sabiendo que el tabulador las separa
fila = Long(Mid(texto_banda_seleccionada, LastPos(texto_banda_seleccionada, "~t") + 1))
	
if fila > 0 then
	This.SelectRow(0, false)
	This.SelectRow(fila, true)
	
	lstr_param.s_argumentos[1] = dw_datos.GetItemString(fila,"modelo_archivo_expo_modelo")
	lstr_param.i_nargumentos = 1
	lstr_param.nombre_ventana = "wtc_consulta_disenyo"
	lstr_param.resultado = ''
	id_ventana = f_menu_ventana_esta_abierta("wtc_trabajos_disenyo_nuevo")
	
	if id_ventana <> -1 then
		if MessageBox("Aviso","Ya tiene abierta una ventana de modelos de diseño, ¿Desea cerrarla para ver el modelo seleccionado?",Question!,YesNo!,2) = 1 then
			close(wtc_trabajos_disenyo_nuevo)
			OpenWithParm(wtc_trabajos_disenyo_nuevo, lstr_param)
		else
			ventanas_activas[id_ventana].ventana.bringtotop = true
		end if
	else
		OpenWithParm(wtc_trabajos_disenyo_nuevo,lstr_param)
	end if
end if
	

end event

type pb_salir from wt_consultas_padre`pb_salir within wtc_consumo_disenyo_modelos_expo
integer x = 8526
integer y = 124
integer taborder = 0
end type

type st_titulo from wt_consultas_padre`st_titulo within wtc_consumo_disenyo_modelos_expo
integer width = 2939
end type

type p_logo from wt_consultas_padre`p_logo within wtc_consumo_disenyo_modelos_expo
integer x = 8155
integer y = 8
end type

type dw_filtro from wt_consultas_padre`dw_filtro within wtc_consumo_disenyo_modelos_expo
integer x = 1298
integer y = 232
integer width = 1673
integer height = 260
integer taborder = 70
boolean vscrollbar = true
end type

type pb_buscar from wt_consultas_padre`pb_buscar within wtc_consumo_disenyo_modelos_expo
integer x = 2871
integer y = 132
integer taborder = 80
end type

type sle_valor1 from wt_consultas_padre`sle_valor1 within wtc_consumo_disenyo_modelos_expo
integer x = 1312
integer width = 398
integer height = 96
integer taborder = 30
end type

type em_fecha1 from wt_consultas_padre`em_fecha1 within wtc_consumo_disenyo_modelos_expo
integer x = 1307
integer height = 96
integer taborder = 90
string text = ""
end type

type sle_texto from wt_consultas_padre`sle_texto within wtc_consumo_disenyo_modelos_expo
integer x = 1312
integer y = 132
integer height = 96
integer taborder = 40
end type

type lb_lista from wt_consultas_padre`lb_lista within wtc_consumo_disenyo_modelos_expo
integer x = 1312
integer y = 132
integer width = 1042
integer height = 496
long textcolor = 24076881
boolean multiselect = false
end type

type dw_grafico1 from datawindow within wtc_consumo_disenyo_modelos_expo
integer x = 3109
integer y = 512
integer width = 5554
integer height = 2764
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "graf_consumo_disenyo_modelo_expo"
boolean border = false
boolean livescroll = true
end type

