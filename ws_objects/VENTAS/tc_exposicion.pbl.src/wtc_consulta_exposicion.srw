$PBExportHeader$wtc_consulta_exposicion.srw
forward
global type wtc_consulta_exposicion from wt_consultas_padre
end type
type p_seleccion from picture within wtc_consulta_exposicion
end type
type dw_imagen from u_dw_imagen within wtc_consulta_exposicion
end type
end forward

global type wtc_consulta_exposicion from wt_consultas_padre
integer width = 8754
integer height = 4324
string title = "Ambientes"
string menuname = ""
boolean minbox = false
boolean maxbox = false
boolean resizable = false
p_seleccion p_seleccion
dw_imagen dw_imagen
end type
global wtc_consulta_exposicion wtc_consulta_exposicion

type variables
string sql_inicial
String tamanyo_expo
String tamanyo_zoom
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

on wtc_consulta_exposicion.create
int iCurrent
call super::create
this.p_seleccion=create p_seleccion
this.dw_imagen=create dw_imagen
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_seleccion
this.Control[iCurrent+2]=this.dw_imagen
end on

on wtc_consulta_exposicion.destroy
call super::destroy
destroy(this.p_seleccion)
destroy(this.dw_imagen)
end on

event open;call super::open;string sql_aux

dw_datos.SetTransObject(SQLCA)
//dw_datos.SetRowFocusIndicator(p_seleccion)

sql_inicial =  "     SELECT DISTINCT descoleccionsol.codigo,   "+&
         		"		coleccion_archivo.ruta,  "+&
				"		coleccion_archivo.fichero,  "+&
				"		empresas.ruta_archivos_exposicion,   "+&
				"		descoleccionsol.fecha_coleccion	"+&
         		"		FROM descoleccionsol,   "+&
         		"		coleccion_archivo,  "+&
				"		empresas  "+&
         		"		WHERE ( descoleccionsol.empresa = coleccion_archivo.empresa ) and  "+&
         		"		( descoleccionsol.codigo = coleccion_archivo.coleccion ) and  "+&
				"		( descoleccionsol.empresa = empresas.empresa ) and  "+&
         		"		( (  exists (SELECT * FROM coleccion_archivo WHERE coleccion_archivo.empresa = descoleccionsol.empresa AND coleccion_archivo.coleccion = descoleccionsol.codigo and coleccion_archivo.activo = 1) ) and coleccion_archivo.activo = 1 ) and "+&
   				"	   ( descoleccionsol.empresa = '"+codigo_empresa+"' )  "
					
SELECT tamanyo INTO :tamanyo_expo FROM archivo_resolucion WHERE empresa = :codigo_empresa AND codigo = '3';
SELECT tamanyo INTO :tamanyo_zoom FROM archivo_resolucion WHERE empresa = :codigo_empresa AND codigo = '4';

/*
sql_aux = "  EXCEPT  SELECT DISTINCT descoleccionsol.codigo,   "+&
         		"		coleccion_archivo.ruta,  "+&
				"		coleccion_archivo.fichero,  "+&
				"		empresas.ruta_archivos_exposicion  "+&
         		"		FROM descoleccionsol,   "+&
         		"		coleccion_archivo,  "+&
				"		empresas  "+&
         		"		WHERE ( descoleccionsol.empresa = coleccion_archivo.empresa ) and  "+&
         		"		( descoleccionsol.codigo = coleccion_archivo.coleccion ) and  "+&
				"		( descoleccionsol.empresa = empresas.empresa ) and  "+&
         		"		( (  exists (SELECT * FROM coleccion_archivo WHERE coleccion_archivo.empresa = descoleccionsol.empresa AND coleccion_archivo.coleccion = descoleccionsol.codigo and coleccion_archivo.activo = 1) ) and coleccion_archivo.activo = 1 ) and "+&
   				"	   ( descoleccionsol.empresa = '"+codigo_empresa+"' ) and descoleccionsol.codigo IN (SELECT deshistorico.coleccion FROM deshistorico WHERE deshistorico.cliente = '41' AND estado = 'aceptado' ) "  

sql_inicial = sql_inicial + sql_aux

*/
end event

event mousemove;call super::mousemove;/*
if dw_filtro.visible or em_fecha1.visible or sle_texto.visible or lb_lista.visible then
		pb_1.visible = true
		pb_imprimir.visible = true
		pb_borrar.visible = true
		pb_reset.visible = true
		pb_salir.visible = true
		ddlb_campo.visible = true
		ddlb_operador.visible = true
		dw_montaje_filtro.visible = true
else
	if ypos < 230 then
		pb_anyadir1.visible = true
		pb_1.visible = true
		pb_imprimir.visible = true
		pb_borrar.visible = true
		pb_reset.visible = true
		pb_salir.visible = true
		ddlb_campo.visible = true
		ddlb_operador.visible = true
		dw_montaje_filtro.visible = true
		
	else
		pb_anyadir1.visible = false
		pb_1.visible = false
		pb_imprimir.visible = false
		pb_borrar.visible = false
		pb_reset.visible = false
		pb_salir.visible = false
		ddlb_campo.visible = false
		ddlb_operador.visible = false
		dw_montaje_filtro.visible = false
	end if 
end if

*/
end event

type pb_imprimir from wt_consultas_padre`pb_imprimir within wtc_consulta_exposicion
boolean visible = false
integer x = 7406
integer y = 44
integer taborder = 0
end type

type pb_borrar from wt_consultas_padre`pb_borrar within wtc_consulta_exposicion
integer x = 7566
integer y = 40
integer taborder = 20
end type

type dw_montaje_filtro from wt_consultas_padre`dw_montaje_filtro within wtc_consulta_exposicion
integer x = 1289
integer y = 28
integer width = 5600
integer height = 164
integer taborder = 70
end type

type pb_1 from wt_consultas_padre`pb_1 within wtc_consulta_exposicion
integer x = 7118
integer y = 40
integer taborder = 0
end type

event pb_1::clicked;call super::clicked;string new_sql
long fila

fila = dw_montaje_filtro.getrow()
dw_montaje_filtro.deleterow(fila)
new_sql = f_montar_filtro(sql_inicial)
dw_datos.SetSQLSelect ( new_sql )

pb_anyadir1.TriggerEvent(Clicked!)

//dw_datos.retrieve()





/*
if dw_montaje_filtro.rowcount() > 3 then
	dw_montaje_filtro.height = dw_montaje_filtro.height -75
	dw_datos.y = dw_datos.y - 75
	dw_datos.height = dw_datos.height + 75
	
	dw_imagen.y = dw_imagen.y - 75
	dw_imagen.height = dw_imagen.height + 75
else
	dw_datos.y = 512
	dw_datos.height = 3952
	
	dw_imagen.y = 264
	dw_imagen.height = 3952

	dw_montaje_filtro.height = 225
end if
*/

dw_datos.setfocus()
end event

type pb_reset from wt_consultas_padre`pb_reset within wtc_consulta_exposicion
integer x = 7721
integer y = 40
integer taborder = 0
end type

type pb_anyadir1 from wt_consultas_padre`pb_anyadir1 within wtc_consulta_exposicion
integer x = 6967
integer y = 40
integer taborder = 0
end type

event pb_anyadir1::clicked;call super::clicked;int index, fila
long i, j, k
string cadena_or, cadena_or_visible
string new_sql, filtro, sql_aux
boolean crear_filtro

sql_aux = ''
if ddlb_campo.text <> "" or dw_montaje_filtro.rowcount() = 0 then

	index = ddlb_campo.SelectItem ( ddlb_campo.text, 0 )
	
	choose case ddlb_campo.text
		case "Fecha"
			if cadena_or = '' then
				cadena_or = " descoleccionsol.fecha_coleccion "+ddlb_operador.text+" '"+em_fecha1.text+"' "
				cadena_or_visible = " Fecha colección "+ddlb_operador.text+" "+em_fecha1.text
			end if
		case "Estilo"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " coleccion_estilo.estilo = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Estilo = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR coleccion_estilo.estilo = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 
			cadena_or = " descoleccionsol.codigo IN (SELECT coleccion_estilo.coleccion FROM coleccion_estilo WHERE "+cadena_or+" )"
		case "Ambiente"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " descoleccionsol.ambiente = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Ambiente = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR descoleccionsol.ambiente = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 
		case "Destino"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " descoleccionsol.destino = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Base Destino = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR descoleccionsol.destino = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 
		case "Pavimento/Revestimiento"
			for k = 1 to lb_lista.totalitems()
				if lb_lista.state(k) = 1 then
					if cadena_or = '' then
						cadena_or = " modelo.pavrev = '"+UPPER(lb_lista.Text (k))+"' "
						cadena_or_visible = lb_lista.Text (k)
					else
						cadena_or = cadena_or+" OR modelo.pavrev = '"+UPPER(lb_lista.Text (k))+"' "
						cadena_or_visible = cadena_or_visible+", "+lb_lista.Text (k)
					end if
				end if
			next
			cadena_or = " descoleccionsol.codigo IN (SELECT modelo.coleccion FROM modelo WHERE "+cadena_or+" )"
		case "Cliente"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = "" then
						//cadena_or = " deshistorico.cliente = '"+dw_filtro.object.#1[i]+"' "
						cadena_or = "'"+dw_filtro.object.#1[i]+"'"
						cadena_or_visible = " Cliente = "+dw_filtro.object.#2[i]
					else
						//cadena_or = cadena_or+" OR deshistorico.cliente = '"+dw_filtro.object.#1[i]+"' "
						cadena_or = cadena_or+", '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 
			
			if ddlb_operador.text = "=" then
//				cadena_or = " descoleccionsol.codigo IN (SELECT deshistorico.coleccion FROM deshistorico WHERE "+cadena_or+" )"
				cadena_or = " descoleccionsol.codigo IN (SELECT deshistorico.coleccion FROM deshistorico WHERE deshistorico.cliente IN ("+cadena_or+" ) AND estado = 'aceptado' )"
			elseif ddlb_operador.text = "<>" then
				sql_aux = "  EXCEPT  SELECT DISTINCT descoleccionsol.codigo,   "+&
								"		coleccion_archivo.ruta,  "+&
								"		coleccion_archivo.fichero,  "+&
								"		empresas.ruta_archivos_exposicion,  "+&
								"		descoleccionsol.fecha_coleccion	"+&
								"		FROM descoleccionsol,   "+&
								"		coleccion_archivo,  "+&
								"		empresas  "+&
								"		WHERE  descoleccionsol.empresa = coleccion_archivo.empresa  and  "+&
								"		 descoleccionsol.codigo = coleccion_archivo.coleccion  and  "+&
								"		 descoleccionsol.empresa = empresas.empresa  and  "+&
								"		 exists (SELECT * FROM coleccion_archivo WHERE coleccion_archivo.empresa = descoleccionsol.empresa AND coleccion_archivo.coleccion = descoleccionsol.codigo and coleccion_archivo.activo = 1)  and coleccion_archivo.activo = 1  and "+&
								"	     descoleccionsol.empresa = '"+codigo_empresa+"'  and descoleccionsol.codigo IN (SELECT deshistorico.coleccion FROM deshistorico WHERE deshistorico.cliente IN ("+cadena_or+") AND estado = 'aceptado' ) "  
				
				new_sql = sql_inicial + sql_aux
				cadena_or = '&'	
				cadena_or_visible = 'Varios'
//					cadena_or = " descoleccionsol.codigo NOT IN (SELECT deshistorico.coleccion FROM deshistorico WHERE "+cadena_or+" )"
			end if 
			
		case "Estado"
			for k = 1 to lb_lista.totalitems()
				if lb_lista.state(k) = 1 then
					if cadena_or = '' then
						cadena_or = " descoleccionsol.estado = '"+lb_lista.Text (k)+"' "
						cadena_or_visible = " Estado = "+lb_lista.Text (k)
					else
						cadena_or = cadena_or+" OR descoleccionsol.estado = '"+lb_lista.Text (k)+"' "
						cadena_or_visible = cadena_or_visible+", "+lb_lista.Text (k)
					end if
				end if
			next
		case "Colección"
			if cadena_or = '' then
				cadena_or = " descoleccionsol.codigo "+ddlb_operador.text+" '"+sle_valor1.text+"' "
				cadena_or_visible = " Colección "+ddlb_operador.text+" '"+sle_valor1.text+"' "
			end if
	case else
		sql_aux = "  EXCEPT  SELECT DISTINCT descoleccionsol.codigo,   "+&
         		"		coleccion_archivo.ruta,  "+&
				"		coleccion_archivo.fichero,  "+&
				"		empresas.ruta_archivos_exposicion,  "+&
				"		descoleccionsol.fecha_coleccion	"+&
         		"		FROM descoleccionsol,   "+&
         		"		coleccion_archivo,  "+&
				"		empresas  "+&
         		"		WHERE ( descoleccionsol.empresa = coleccion_archivo.empresa ) and  "+&
         		"		( descoleccionsol.codigo = coleccion_archivo.coleccion ) and  "+&
				"		( descoleccionsol.empresa = empresas.empresa ) and  "+&
         		"		( (  exists (SELECT * FROM coleccion_archivo WHERE coleccion_archivo.empresa = descoleccionsol.empresa AND coleccion_archivo.coleccion = descoleccionsol.codigo and coleccion_archivo.activo = 1) ) and coleccion_archivo.activo = 1 ) and "+&
   				"	   ( descoleccionsol.empresa = '"+codigo_empresa+"' ) and descoleccionsol.codigo IN (SELECT deshistorico.coleccion FROM deshistorico WHERE deshistorico.cliente IN (SELECT genter.codigo from genter where visible_expo = '0' and tipoter = 'C') AND estado = 'aceptado' ) "  

		new_sql = sql_inicial + sql_aux

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
			if cadena_or = '&' then
				cadena_or = ''
			else
				cadena_or = " ( "+cadena_or+" ) "
			end if

			fila = dw_montaje_filtro.insertrow(0)
			dw_montaje_filtro.object.filtro[fila] = cadena_or
			dw_montaje_filtro.object.linea[fila] = cadena_or_visible
			
			new_sql = f_montar_filtro(sql_inicial)
			
			ddlb_campo.text = ''
			dw_filtro.visible = false
//			dw_filtro.height = 137
		end if
	else
		new_sql = sql_inicial
	end if
	
	
	dw_datos.SetSQLSelect ( new_sql + sql_aux)
	dw_datos.retrieve()
	
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
//	dw_filtro.Height = 260
	
	//Tamaños DW en función del número de filtros
/*	
	if dw_montaje_filtro.rowcount() > 3 and dw_montaje_filtro.rowcount() < 10 then
		
		dw_montaje_filtro.height = 75 * dw_montaje_filtro.rowcount()
		
		dw_datos.y = dw_datos.y + 75
		dw_datos.height = dw_datos.height - 75
		
		dw_imagen.y = dw_imagen.y + 75
		dw_imagen.height = dw_imagen.height - 75
		
	end if
	*/
	dw_datos.setfocus()
	
end if
end event

type ddlb_operador from wt_consultas_padre`ddlb_operador within wtc_consulta_exposicion
integer x = 919
integer y = 32
integer weight = 700
long textcolor = 23016974
boolean sorted = false
end type

event ddlb_operador::selectionchanged;call super::selectionchanged;
/*
string consulta, sql_except

CHOOSE CASE ddlb_campo.text
	CASE "Cliente"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
		
		ddlb_operador.AddItem ("=")
		ddlb_operador.AddItem ("<>")
		ddlb_operador.text = "="
		if ddlb_operador.text = "=" then
			consulta = "Select genter.codigo as Código, genter.razon as Descripción from genter "+&
						  "where genter.empresa = '"+codigo_empresa+"' and genter.tipoter = 'C' and exists "+&
						  "(SELECT * FROM deshistorico WHERE deshistorico.empresa = genter.empresa AND deshistorico.cliente = genter.codigo AND estado = 'Aceptado' "+&
						  "AND deshistorico.coleccion IN (SELECT modelo.coleccion FROM modelo)) "+&
						  "order by genter.razon"
		elseif ddlb_operador.text = "<>" then
			
			sql_except = "  EXCEPT  SELECT DISTINCT descoleccionsol.codigo,   "+&
							"		coleccion_archivo.ruta,  "+&
							"		coleccion_archivo.fichero,  "+&
							"		empresas.ruta_archivos_exposicion  "+&
							"		FROM descoleccionsol,   "+&
							"		coleccion_archivo,  "+&
							"		empresas  "+&
							"		WHERE ( descoleccionsol.empresa = coleccion_archivo.empresa ) and  "+&
							"		( descoleccionsol.codigo = coleccion_archivo.coleccion ) and  "+&
							"		( descoleccionsol.empresa = empresas.empresa ) and  "+&
							"		( (  exists (SELECT * FROM coleccion_archivo WHERE coleccion_archivo.empresa = descoleccionsol.empresa AND coleccion_archivo.coleccion = descoleccionsol.codigo and coleccion_archivo.activo = 1) ) and coleccion_archivo.activo = 1 ) and "+&
							"	   ( descoleccionsol.empresa = '"+codigo_empresa+"' ) and descoleccionsol.codigo IN (SELECT deshistorico.coleccion FROM deshistorico WHERE deshistorico.cliente = '41' AND estado = 'aceptado' ) "  
			
			sql_inicial = sql_inicial + sql_except			
			
		end if
		
END CHOOSE*/
end event

type ddlb_campo from wt_consultas_padre`ddlb_campo within wtc_consulta_exposicion
integer x = 18
integer y = 32
integer width = 878
integer height = 904
integer taborder = 30
integer weight = 700
long textcolor = 24076881
string item[] = {"Fecha","Estilo","Ambiente","Destino","Pavimento/Revestimiento","Cliente","Estado","Colección"}
end type

event ddlb_campo::selectionchanged;call super::selectionchanged;string consulta, new_syntax,  error_syntaxfromSQL, mensaje_error, error_create
long i


ddlb_operador.Reset()
lb_lista.Reset()

CHOOSE CASE ddlb_campo.text
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
		ddlb_operador.text = ">"
	CASE "Estilo"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
		
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, descripcion as Descripción from estilo where empresa = '"+codigo_empresa+"' "
	CASE "Ambiente"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, descripcion as Descripción from ambiente where empresa = '"+codigo_empresa+"' "
	CASE "Destino"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
		
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, descripcion as Descripción from tipobase where empresa = '"+codigo_empresa+"' "
	CASE "Pavimento/Revestimiento"
		dw_filtro.visible = false
		pb_buscar.visible = false
		sle_texto.visible = false
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = true
		
		lb_lista.AddItem ("Pavimento")
		lb_lista.AddItem ("Revestimiento")
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
	CASE "Cliente"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
		
		ddlb_operador.AddItem ("=")
		ddlb_operador.AddItem ("<>")
		ddlb_operador.text = "="
		if ddlb_operador.text = "=" then
			consulta = "Select genter.codigo as Código, genter.razon as Descripción from genter "+&
						  "where genter.empresa = '"+codigo_empresa+"' and genter.tipoter = 'C' and exists "+&
						  "(SELECT * FROM deshistorico WHERE deshistorico.empresa = genter.empresa AND deshistorico.cliente = genter.codigo AND estado = 'Aceptado' "+&
						  "AND deshistorico.coleccion IN (SELECT modelo.coleccion FROM modelo)) "+&
						  "order by genter.razon"
		end if
	CASE "Estado"
		dw_filtro.visible = false
		pb_buscar.visible = false
		sle_texto.visible = false
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = true
		
		lb_lista.AddItem ("Libre")
		lb_lista.AddItem ("Reservado")
		lb_lista.AddItem ("Aceptado")
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
	CASE "Colección"
		dw_filtro.visible = false
		pb_buscar.visible = false
		sle_texto.visible = false
		em_fecha1.visible = false
		sle_valor1.visible = true
		lb_lista.visible = false
		
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

type dw_datos from wt_consultas_padre`dw_datos within wtc_consulta_exposicion
integer x = 41
integer y = 212
integer width = 407
integer height = 3988
integer taborder = 10
string dataobject = "dwtc_consulta_exposicion"
end type

event dw_datos::rowfocuschanged;//CON RUTAS 
string codigo_coleccion, ruta, fichero
Long min_codigo_archivo, colecciones, i

if currentrow <= 0 then
	return
end if

codigo_coleccion = dw_datos.object.descoleccionsol_codigo[dw_datos.getrow()]

if not isnull(codigo_coleccion) and codigo_coleccion <> "" then
	//ftc_imagen_fondo_datawindow (dw_imagen, '3', codigo_coleccion, "", "")
	ruta = dw_datos.object.empresas_ruta_archivos_exposicion[currentrow] + f_reemplazar(dw_datos.object.coleccion_archivo_ruta[currentrow], dw_datos.object.empresas_ruta_archivos_exposicion[currentrow], "")
	fichero = dw_datos.object.coleccion_archivo_fichero[currentrow]
	if not isnull(ruta) and ruta <> "" and not isnull(fichero) and fichero <> ""then
		dw_imagen.Object.datawindow.picture.File = ruta + tamanyo_expo + "\" + fichero
		dw_imagen.visible = true
	else
		dw_imagen.visible = false
	end if
end if



end event

event dw_datos::clicked;call super::clicked;pb_anyadir1.visible = false
pb_1.visible = false
pb_imprimir.visible = false
pb_borrar.visible = false
pb_reset.visible = false
pb_salir.visible = false
ddlb_campo.visible = false
ddlb_operador.visible = false
dw_montaje_filtro.visible = false


end event

event dw_datos::doubleclicked;call super::doubleclicked;Long id_ventana, modelos 
str_parametros lstr_param 
String coleccion 

if dw_datos.getrow() > 0 then
	coleccion = dw_datos.GetItemString(dw_datos.getrow(),"descoleccionsol_codigo")
	
	if not isnull(coleccion) and coleccion <> "" then
		modelos = 0
		SELECT COUNT(*) INTO :modelos FROM modelo_archivo_expo WHERE empresa = :codigo_empresa AND coleccion = :coleccion AND activo = 1;
		
		if modelos > 0 then
			lstr_param.s_argumentos[1] = coleccion
			lstr_param.i_nargumentos = 1
			lstr_param.nombre_ventana = "wtc_consulta_exposicion"
			lstr_param.resultado = ''
			id_ventana = f_menu_ventana_esta_abierta("wtc_consulta_exposicion_modelos")
			if id_ventana <> -1 then
				close(wtc_consulta_exposicion_modelos)
				OpenWithParm(wtc_consulta_exposicion_modelos, lstr_param)
			else
				OpenWithParm(wtc_consulta_exposicion_modelos,lstr_param)
			end if
		end if
	end if
end if
end event

event dw_datos::retrieveend;call super::retrieveend;//CON RUTAS 
string codigo_coleccion, ruta, fichero
Long fila

if rowcount > 0 then
	
	fila = this.getrow()
	if fila <= 0 then
		return
	end if
	
	codigo_coleccion = dw_datos.object.descoleccionsol_codigo[fila]
	
	if not isnull(codigo_coleccion) and codigo_coleccion <> "" then
		ruta = dw_datos.object.empresas_ruta_archivos_exposicion[fila] + f_reemplazar(dw_datos.object.coleccion_archivo_ruta[fila], dw_datos.object.empresas_ruta_archivos_exposicion[fila], "")
		fichero = dw_datos.object.coleccion_archivo_fichero[fila]
		if not isnull(ruta) and ruta <> "" and not isnull(fichero) and fichero <> ""then
			dw_imagen.Object.datawindow.picture.File = ruta + tamanyo_expo + "\" + fichero
			dw_imagen.visible = true
		else
			dw_imagen.visible = false
		end if
	end if
else
	dw_imagen.visible = false
end if

end event

type pb_salir from wt_consultas_padre`pb_salir within wtc_consulta_exposicion
integer x = 7877
integer y = 40
integer taborder = 0
end type

type st_titulo from wt_consultas_padre`st_titulo within wtc_consulta_exposicion
boolean visible = false
integer x = 3351
integer y = 128
integer width = 334
end type

type p_logo from wt_consultas_padre`p_logo within wtc_consulta_exposicion
integer x = 8178
integer y = 56
end type

event p_logo::doubleclicked;call super::doubleclicked;if not pb_1.visible then
	pb_anyadir1.visible = true
	pb_1.visible = true
	pb_imprimir.visible = true
	pb_borrar.visible = true
	pb_reset.visible = true
	pb_salir.visible = true
	ddlb_campo.visible = true
	ddlb_operador.visible = true
	dw_montaje_filtro.visible = true
	
else
	pb_anyadir1.visible = false
	pb_1.visible = false
	pb_imprimir.visible = false
	pb_borrar.visible = false
	pb_reset.visible = false
	pb_salir.visible = false
	ddlb_campo.visible = false
	ddlb_operador.visible = false
	dw_montaje_filtro.visible = false
end if 



/*
if dw_filtro.visible or em_fecha1.visible or sle_texto.visible or lb_lista.visible then
		pb_1.visible = true
		pb_imprimir.visible = true
		pb_borrar.visible = true
		pb_reset.visible = true
		pb_salir.visible = true
		ddlb_campo.visible = true
		ddlb_operador.visible = true
		dw_montaje_filtro.visible = true
else
end if

*/
end event

type dw_filtro from wt_consultas_padre`dw_filtro within wtc_consulta_exposicion
integer x = 1257
integer y = 124
integer width = 1673
integer height = 260
integer taborder = 80
boolean vscrollbar = true
end type

type pb_buscar from wt_consultas_padre`pb_buscar within wtc_consulta_exposicion
integer x = 2839
integer y = 28
integer taborder = 100
end type

type sle_valor1 from wt_consultas_padre`sle_valor1 within wtc_consulta_exposicion
integer x = 1280
integer y = 32
integer width = 398
integer height = 96
integer taborder = 50
end type

type em_fecha1 from wt_consultas_padre`em_fecha1 within wtc_consulta_exposicion
integer x = 1275
integer y = 32
integer height = 96
integer taborder = 110
string text = ""
end type

type sle_texto from wt_consultas_padre`sle_texto within wtc_consulta_exposicion
integer x = 1280
integer y = 28
integer height = 96
integer taborder = 60
end type

type lb_lista from wt_consultas_padre`lb_lista within wtc_consulta_exposicion
integer x = 1280
integer y = 28
integer width = 462
integer height = 252
integer taborder = 90
long textcolor = 24076881
end type

type p_seleccion from picture within wtc_consulta_exposicion
boolean visible = false
integer x = 37
integer y = 136
integer width = 59
integer height = 56
boolean bringtotop = true
string picturename = "C:\Tencer_PB12\circulo.png"
boolean focusrectangle = false
end type

type dw_imagen from u_dw_imagen within wtc_consulta_exposicion
boolean visible = false
integer x = 498
integer y = 212
integer width = 8110
integer height = 3884
boolean bringtotop = true
string dataobject = "dw_aux_imagen_expo"
end type

event rbuttondown;/*
String ruta
ruta = this.Object.datawindow.picture.File
if not isnull(ruta) and ruta <> "" then
	run("C:\Tencer_pb12\IM\MaxView.exe "+ruta)
end if
*/

string codigo_coleccion, ruta, fichero
Long min_codigo_archivo, colecciones, fila

fila = dw_datos.getrow()
if fila <= 0 then
	return
end if

codigo_coleccion = dw_datos.object.descoleccionsol_codigo[fila]

if not isnull(codigo_coleccion) and codigo_coleccion <> "" then
	ruta = dw_datos.object.empresas_ruta_archivos_exposicion[fila] + f_reemplazar(dw_datos.object.coleccion_archivo_ruta[fila], dw_datos.object.empresas_ruta_archivos_exposicion[fila], "")
	fichero = dw_datos.object.coleccion_archivo_fichero[fila]
	if not isnull(ruta) and ruta <> "" and not isnull(fichero) and fichero <> ""then
		run("C:\Tencer_pb12\IM\MaxView.exe " + ruta + tamanyo_zoom + "\" + fichero)
	end if
end if
end event

event doubleclicked;call super::doubleclicked;Long id_ventana, modelos 
str_parametros lstr_param 
String coleccion 

if dw_datos.getrow() > 0 then
	coleccion = dw_datos.GetItemString(dw_datos.getrow(),"descoleccionsol_codigo")
	
	if not isnull(coleccion) and coleccion <> "" then
		modelos = 0
		SELECT COUNT(*) INTO :modelos FROM modelo_archivo_expo WHERE empresa = :codigo_empresa AND coleccion = :coleccion AND activo = 1;
		
		if modelos > 0 then
			lstr_param.s_argumentos[1] = coleccion
			lstr_param.i_nargumentos = 1
			lstr_param.nombre_ventana = "wtc_consulta_exposicion"
			lstr_param.resultado = ''
			id_ventana = f_menu_ventana_esta_abierta("wtc_consulta_exposicion_modelos")
			if id_ventana <> -1 then
				close(wtc_consulta_exposicion_modelos)
				OpenWithParm(wtc_consulta_exposicion_modelos, lstr_param)
			else
				OpenWithParm(wtc_consulta_exposicion_modelos,lstr_param)
			end if
		end if
	end if
end if

end event

