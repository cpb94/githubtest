$PBExportHeader$wtc_consulta_pantallas.srw
forward
global type wtc_consulta_pantallas from wt_consultas_padre
end type
type cb_1 from commandbutton within wtc_consulta_pantallas
end type
type dw_estado from u_dw within wtc_consulta_pantallas
end type
end forward

global type wtc_consulta_pantallas from wt_consultas_padre
integer width = 5609
integer height = 3456
string title = "Consulta Pantallas"
boolean resizable = false
cb_1 cb_1
dw_estado dw_estado
end type
global wtc_consulta_pantallas wtc_consulta_pantallas

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

on wtc_consulta_pantallas.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.dw_estado=create dw_estado
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.dw_estado
end on

on wtc_consulta_pantallas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
destroy(this.dw_estado)
end on

event open;call super::open;dw_datos.SetTransObject(SQLCA)
dw_estado.SetTransObject(SQLCA)

sql_inicial = "  SELECT DISTINCT archivo_disenyo.revisado,   "+&
"         archivo_disenyo.ubicacion,   "+&
"         archivo_disenyo.tipo_pantallas,   "+&
"         almacen_laboratorio_tipo.descripcion,   "+&
"         archivo_disenyo.nombre,   "+&
"         archivo_disenyo.n_pantallas,  "+& 
"         archivo_disenyo.empresa,   "+&
"         archivo_disenyo.tipomaquina_disenyo,   "+&
"         archivo_disenyo.codigo,   "+&
"         modelo_pieza.codigo_lab,   "+&
"         modelo_prueba.tecnico_lab,   "+&
"         T1.descripcion, "+&
"		T2.descripcion,  "+&
"         modelo_archivo.modelo,   "+&
"		descoleccionsol.codigo,	"+&
"         REPLACE(empresas.ruta_archivos_exposicion + modelo_pieza_archivo.ruta + archivo_resolucion.tamanyo + '\' + modelo_pieza_archivo.fichero, ' ', '' ) AS fichero,   "+&
"   		 REPLACE(empresas.ruta_archivos_exposicion + modelo_pieza_archivo.ruta + archivo_resolucion.tamanyo + '\' + modelo_archivo_expo.fichero, ' ', '' ) AS fichero_modelo  "+&
"    FROM archivo_disenyo LEFT OUTER JOIN almacen_laboratorio_tipo ON archivo_disenyo.empresa = almacen_laboratorio_tipo.empresa AND archivo_disenyo.tipo_pantallas = almacen_laboratorio_tipo.codigo "+&
"	LEFT OUTER JOIN modelo_archivo ON archivo_disenyo.empresa = modelo_archivo.empresa AND archivo_disenyo.tipomaquina_disenyo = modelo_archivo.tipo_maquina_disenyo AND archivo_disenyo.codigo = modelo_archivo.archivo_disenyo "+&
"	LEFT OUTER JOIN modelo_pieza ON modelo_archivo.empresa = modelo_pieza.empresa AND modelo_archivo.modelo = modelo_pieza.modelo AND modelo_archivo.cliente = modelo_pieza.cliente AND modelo_archivo.propuesta = modelo_pieza.propuesta AND modelo_archivo.pieza = modelo_pieza.codigo "+&
"	LEFT OUTER JOIN modelo_pieza_archivo ON modelo_pieza.empresa = modelo_pieza_archivo.empresa AND modelo_pieza.codigo_lab = modelo_pieza_archivo.pieza "+&
"	LEFT OUTER JOIN modelo_prueba ON modelo_pieza.empresa = modelo_prueba.empresa AND modelo_pieza.modelo = modelo_prueba.modelo AND modelo_pieza.cliente = modelo_prueba.cliente AND modelo_pieza.propuesta = modelo_prueba.propuesta AND modelo_pieza.codigo = modelo_prueba.pieza "+&
"	LEFT OUTER JOIN modelo ON modelo.empresa = modelo_archivo.empresa AND modelo.modelo = modelo_archivo.modelo "+&
"	LEFT OUTER JOIN descoleccionsol ON descoleccionsol.empresa = modelo.empresa AND descoleccionsol.codigo = modelo.coleccion "+&
"	LEFT OUTER JOIN tecnico_lab T1 ON modelo_prueba.empresa = T1.empresa AND modelo_prueba.tecnico_lab = T1.codigo "+&
"	LEFT OUTER JOIN tecnico_lab T2 ON descoleccionsol.empresa = T2.empresa AND descoleccionsol.tecnico_lab = T2.codigo "+&
"	LEFT OUTER JOIN modelo_archivo_expo ON modelo_archivo.empresa = modelo_archivo_expo.empresa AND modelo_archivo.modelo = modelo_archivo_expo.modelo , empresas, archivo_resolucion  "+&
"   WHERE (empresas.empresa = '1') AND "+&
"		 (archivo_resolucion.empresa = '1' AND archivo_resolucion.codigo = '1') AND( archivo_disenyo.tipomaquina_disenyo = '3' ) AND  "+&
"         ( modelo_pieza_archivo.codigo IS NULL OR modelo_pieza_archivo.codigo in (SELECT MIN(CONVERT(integer,codigo)) FROM modelo_pieza_archivo M WHERE M.empresa = modelo_pieza.empresa AND M.pieza = modelo_pieza.codigo_lab) ) AND  "+&
"         ( modelo_archivo_expo.codigo IS NULL OR modelo_archivo_expo.codigo in (SELECT MIN(CONVERT(integer,codigo)) FROM modelo_archivo_expo F WHERE F.empresa = modelo_archivo.empresa AND F.modelo = modelo_archivo.modelo) ) AND  "+&
"         ( archivo_disenyo.ubicacion  is not null ) AND  "+&
"         ( archivo_disenyo.ubicacion  <> '0' ) AND   "+&
"			 archivo_disenyo.empresa = '"+codigo_empresa+"'"  
end event

event activate;call super::activate;if permiso_ventana = 1 then
	cb_1.visible = false
end if
end event

type st_registros_padre from wt_consultas_padre`st_registros_padre within wtc_consulta_pantallas
end type

type st_total_padre from wt_consultas_padre`st_total_padre within wtc_consulta_pantallas
end type

type pb_imprimir from wt_consultas_padre`pb_imprimir within wtc_consulta_pantallas
integer x = 4882
integer y = 128
integer taborder = 0
end type

event pb_imprimir::clicked;dw_datos.Modify("fichero.visible = false")
dw_datos.Modify("DataWindow.Detail.Height = 76")

if dw_datos.rowcount() > 0 then
		f_imprimir_datawindow(dw_datos)
end if

dw_datos.Modify("fichero.visible = true")
dw_datos.Modify("DataWindow.Detail.Height = 384")
end event

type pb_borrar from wt_consultas_padre`pb_borrar within wtc_consulta_pantallas
integer x = 5088
integer y = 124
integer taborder = 0
end type

type dw_montaje_filtro from wt_consultas_padre`dw_montaje_filtro within wtc_consulta_pantallas
integer width = 2930
integer height = 224
end type

type pb_1 from wt_consultas_padre`pb_1 within wtc_consulta_pantallas
integer x = 3168
integer y = 124
integer taborder = 0
end type

event pb_1::clicked;call super::clicked;string new_sql
long fila

fila = dw_montaje_filtro.getrow()
dw_montaje_filtro.deleterow(fila)
new_sql = f_montar_filtro(sql_inicial)
dw_datos.SetSQLSelect ( new_sql )
dw_datos.retrieve()

if dw_montaje_filtro.rowcount() > 3 then
	dw_montaje_filtro.height = dw_montaje_filtro.height -75
	dw_datos.y = dw_datos.y - 75
	dw_datos.height = dw_datos.height + 75
else
	dw_datos.y = 512
	dw_datos.height = 2328
	dw_montaje_filtro.height = 225
end if
end event

type pb_reset from wt_consultas_padre`pb_reset within wtc_consulta_pantallas
integer x = 5243
integer y = 124
integer taborder = 0
end type

type pb_anyadir1 from wt_consultas_padre`pb_anyadir1 within wtc_consulta_pantallas
integer x = 3017
integer y = 124
integer taborder = 0
end type

event pb_anyadir1::clicked;call super::clicked;int index, fila
long i, j, k
string cadena_or, cadena_or_visible
string new_sql, filtro
boolean crear_filtro

if ddlb_campo.text <> "" or dw_montaje_filtro.rowcount() = 0 then

	index = ddlb_campo.SelectItem ( ddlb_campo.text, 0 )
	
	choose case ddlb_campo.text	
		case "Revisado"
			for k = 1 to lb_lista.totalitems()
				if lb_lista.state(k) = 1 then
					if cadena_or = '' then
						cadena_or = " archivo_disenyo.revisado = '"+UPPER(lb_lista.Text (k))+"' "
						cadena_or_visible = " Revisado = "+ lb_lista.Text (k)
					else
						cadena_or = cadena_or+" OR archivo_disenyo.revisado = '"+UPPER(lb_lista.Text (k))+"' "
						cadena_or_visible = cadena_or_visible+", "+lb_lista.Text (k)
					end if
				end if
			next
		case "Ubicación"
			if cadena_or = '' then
				cadena_or = " archivo_disenyo.ubicacion "+ddlb_operador.text+" '"+sle_valor1.text+"' "
				cadena_or_visible = " Ubicación "+ddlb_operador.text+" '"+sle_valor1.text+"' "
			end if
		case "Tipo Ubicación"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " archivo_disenyo.tipo_pantallas = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Tipo Ubicación = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR archivo_disenyo.tipo_pantallas = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 			
		case "Juego Pantallas"
			if cadena_or = '' then
				cadena_or = " archivo_disenyo.nombre "+ddlb_operador.text+" '"+sle_valor1.text+"' "
				cadena_or_visible = " Juego Pantallas "+ddlb_operador.text+" '"+sle_valor1.text+"' "
			end if
		case "Número Pantallas"
			if cadena_or = '' then
				cadena_or = " archivo_disenyo.n_pantallas "+ddlb_operador.text+" "+sle_valor1.text+" "
				cadena_or_visible = " Número Pantallas "+ddlb_operador.text+" "+sle_valor1.text
			end if
		case "Técnico Prueba"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " modelo_prueba.tecnico_lab = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Técnico Prueba = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR modelo_prueba.tecnico_lab = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next
		case "Técnico Coleccion"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " descoleccionsol.tecnico_lab = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Técnico Coleccioón = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR descoleccionsol.tecnico_lab = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next
		case "Fecha Pieza"
			if cadena_or = '' then
				cadena_or = " CONVERT(date, modelo_pieza.fecha_lab) "+ddlb_operador.text+" '"+em_fecha1.text+"' "
				cadena_or_visible = " Fecha Pieza "+ddlb_operador.text+" "+em_fecha1.text
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
			
			new_sql = f_montar_filtro(sql_inicial)
			
			ddlb_campo.text = ''
			dw_filtro.visible = false
			dw_filtro.height = 137
		end if
	else
		new_sql = sql_inicial
	end if
	
	dw_datos.SetSQLSelect ( new_sql )
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
	dw_filtro.Height = 260
	
	if dw_montaje_filtro.rowcount() > 3 and dw_montaje_filtro.rowcount() < 10 then
		dw_montaje_filtro.height = 75 * dw_montaje_filtro.rowcount()
		dw_datos.y = dw_datos.y + 75
		dw_datos.height = dw_datos.height - 75
	end if
	
	dw_datos.setfocus()
	
else
	
	new_sql = f_montar_filtro(sql_inicial)
			
	dw_datos.SetSQLSelect ( new_sql )
	dw_datos.retrieve()
	
	dw_datos.setfocus()
end if
end event

type ddlb_operador from wt_consultas_padre`ddlb_operador within wtc_consulta_pantallas
integer x = 951
integer taborder = 20
integer weight = 700
long textcolor = 23016974
boolean sorted = false
end type

type ddlb_campo from wt_consultas_padre`ddlb_campo within wtc_consulta_pantallas
integer width = 878
integer height = 1308
integer taborder = 10
integer weight = 700
long textcolor = 24076881
string item[] = {"Revisado","Ubicación","Tipo Ubicación","Juego Pantallas","Número Pantallas","Técnico Prueba","Técnico Coleccion","Fecha Pieza"}
end type

event ddlb_campo::selectionchanged;call super::selectionchanged;string consulta, new_syntax,  error_syntaxfromSQL, mensaje_error, error_create


ddlb_operador.Reset()
lb_lista.Reset()

CHOOSE CASE ddlb_campo.text
	CASE "Revisado"
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
		
	CASE "Ubicación", "Juego Pantallas"
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
		
		ddlb_operador.text = "="
		
	CASE "Tipo Ubicación"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, abreviado as Abreviado, descripcion as Descripción from almacen_laboratorio_tipo where empresa = '"+codigo_empresa+"' order by descripcion ASC"
		
	CASE "Número Pantallas"
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
		ddlb_operador.text = ">"	
	CASE "Técnico Prueba", "Técnico Coleccion"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, descripcion as Descripción from tecnico_lab where empresa = '"+codigo_empresa+"' and activo = 'S' order by descripcion ASC"
	CASE "Fecha Pieza"
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
		
		ddlb_operador.text = ">="
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

type dw_datos from wt_consultas_padre`dw_datos within wtc_consulta_pantallas
integer y = 512
integer width = 2921
integer height = 2744
integer taborder = 60
string dataobject = "dwtc_consulta_pantallas"
end type

event dw_datos::clicked;call super::clicked;String tipomaquina_disenyo, codigo, banda_seleccionada, revisado
Long posicion, esta_abierta
str_parametros lstr_param

//Utilizamos GetBandAtPointer(), que nos muestra la banda seleccionada y la primera fila del grupo seleccionado en un string separado por un tabulador.
banda_seleccionada = this.GetBandAtPointer()
//Separamos del string lo que es la banda de lo que es la fila, sabiendo que el tabulador las separa
posicion = Long(Mid(banda_seleccionada, LastPos(banda_seleccionada, "~t") + 1))

if banda_seleccionada <> "" and posicion > 0 then
	if dwo.name = "b_sacar" then
		if permiso_ventana > 1 then
			tipomaquina_disenyo = this.object.archivo_disenyo_tipomaquina_disenyo[posicion]
			codigo = this.object.archivo_disenyo_codigo[posicion]
			
			UPDATE archivo_disenyo SET 
			revisado = 'S' , 
			ubicacion = 0 ,
			n_pantallas = 0,
			tipo_pantallas = ''
			WHERE empresa = :codigo_empresa AND tipomaquina_disenyo = :tipomaquina_disenyo AND codigo = :codigo USING SQLCA;
			if sqlca.sqlcode = 0 then
				commit using sqlca;
			else
				rollback using sqlca;
			end if

			//pb_anyadir1.triggerevent(clicked!)
			this.object.revisado[row] = 'N'
			this.object.ubicacion[row] = 0
			this.object.tipo_pantallas[row] = ''
			this.object.almacen_laboratorio_tipo_descripcion[row] = ''
			this.object.n_pantallas[row] = 0
		end if
	elseif dwo.name = "b_revisar" then
		if permiso_ventana > 1 then
			tipomaquina_disenyo = this.object.archivo_disenyo_tipomaquina_disenyo[posicion]
			codigo = this.object.archivo_disenyo_codigo[posicion]
			UPDATE archivo_disenyo SET revisado = 'S' WHERE empresa = :codigo_empresa AND tipomaquina_disenyo = :tipomaquina_disenyo AND codigo = :codigo USING SQLCA;
			if sqlca.sqlcode = 0 then
				commit using sqlca;
			else
				rollback using sqlca;
			end if

			this.object.revisado[row] = 'S'
			//pb_anyadir1.triggerevent(clicked!)
		end if
	elseif dwo.name = "b_no_revisar" then
		if permiso_ventana > 1 then
			tipomaquina_disenyo = this.object.archivo_disenyo_tipomaquina_disenyo[posicion]
			codigo = this.object.archivo_disenyo_codigo[posicion]
			UPDATE archivo_disenyo SET revisado = 'N' WHERE empresa = :codigo_empresa AND tipomaquina_disenyo = :tipomaquina_disenyo AND codigo = :codigo USING SQLCA;
			if sqlca.sqlcode = 0 then
				commit using sqlca;
			else
				rollback using sqlca;
			end if
			
			this.object.revisado[row] = 'N'
			//pb_anyadir1.triggerevent(clicked!)
		end if
	elseif dwo.name = "nombre" then
		tipomaquina_disenyo = this.object.archivo_disenyo_tipomaquina_disenyo[posicion]
		codigo = this.object.archivo_disenyo_codigo[posicion]
		lstr_param.s_argumentos[1] = codigo
		lstr_param.s_argumentos[2] = tipomaquina_disenyo 
		lstr_param.i_nargumentos = 2
		lstr_param.nombre_ventana = "wtc_consulta_pantallas"
		lstr_param.resultado = ''
		esta_abierta = f_menu_ventana_esta_abierta("wtc_mant_archivos_disenyo")
		if esta_abierta <> -1 then
			close(wtc_mant_archivos_disenyo)
			OpenWithParm(wtc_mant_archivos_disenyo,lstr_param)
		else
			OpenWithParm(wtc_mant_archivos_disenyo,lstr_param)
		end if
	elseif dwo.name = "modelo_pieza_codigo_lab" then
		lstr_param.s_argumentos[1] = dw_datos.GetItemString(posicion,"modelo_pieza_codigo_lab")
		lstr_param.i_nargumentos = 1
		lstr_param.nombre_ventana = "wtc_consulta_pantallas"
		lstr_param.resultado = ''
		esta_abierta = f_menu_ventana_esta_abierta("wtc_mant_pruebas")
		if esta_abierta <> -1 then
			close(wtc_mant_pruebas)
			OpenWithParm(wtc_mant_pruebas, lstr_param)
		else
			OpenWithParm(wtc_mant_pruebas,lstr_param)
		end if
	end if
end if


end event

event dw_datos::rowfocuschanged;call super::rowfocuschanged;String coleccion

if currentrow <= 0 then
	dw_estado.reset()
	return
end if

coleccion = this.object.descoleccionsol_codigo[currentrow]

if not isnull(coleccion) and coleccion <> "" then
	dw_estado.retrieve(codigo_empresa, coleccion)
else
	dw_estado.reset()
end if
end event

type pb_salir from wt_consultas_padre`pb_salir within wtc_consulta_pantallas
integer x = 5399
integer y = 124
integer taborder = 0
end type

type st_titulo from wt_consultas_padre`st_titulo within wtc_consulta_pantallas
end type

type p_logo from wt_consultas_padre`p_logo within wtc_consulta_pantallas
integer x = 5024
integer y = 20
end type

type dw_filtro from wt_consultas_padre`dw_filtro within wtc_consulta_pantallas
integer x = 1298
integer y = 232
integer width = 1673
integer height = 260
integer taborder = 70
boolean vscrollbar = true
end type

type pb_buscar from wt_consultas_padre`pb_buscar within wtc_consulta_pantallas
integer x = 2871
integer y = 132
integer taborder = 90
end type

type sle_valor1 from wt_consultas_padre`sle_valor1 within wtc_consulta_pantallas
integer x = 1312
integer width = 398
integer height = 96
integer taborder = 30
end type

type em_fecha1 from wt_consultas_padre`em_fecha1 within wtc_consulta_pantallas
integer x = 1307
integer height = 96
integer taborder = 110
string text = ""
end type

type sle_texto from wt_consultas_padre`sle_texto within wtc_consulta_pantallas
integer x = 1312
integer y = 132
integer height = 96
integer taborder = 40
end type

type lb_lista from wt_consultas_padre`lb_lista within wtc_consulta_pantallas
integer x = 1312
integer y = 132
integer width = 462
integer height = 252
integer taborder = 80
long textcolor = 24076881
end type

type cb_1 from commandbutton within wtc_consulta_pantallas
integer x = 3566
integer y = 132
integer width = 1038
integer height = 112
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Desubicar Pantallas Revisadas"
end type

event clicked;Int i
String tipomaquina_disenyo, codigo

if MessageBox("Atención", "Va a desubicar todas las pantallas mostradas en el listado, que estén revisadas. Compruebe que haya filtrado por el técnico correcto, ya que la ubicación de las pantallas no se podrá recuperar. ¿Desea continuar?", Question!, YesNo!, 2) = 1 then
	For i = 1 To dw_datos.rowcount() 
		if dw_datos.object.revisado[i] = 'S' then
			tipomaquina_disenyo = dw_datos.object.archivo_disenyo_tipomaquina_disenyo[i]
			codigo = dw_datos.object.archivo_disenyo_codigo[i]
			
			UPDATE archivo_disenyo 
			SET ubicacion = NULL, tipo_pantallas = NULL, n_pantallas = NULL, revisado = 'N' 
			WHERE empresa = :codigo_empresa AND tipomaquina_disenyo = :tipomaquina_disenyo AND codigo = :codigo USING SQLCA;
			if sqlca.sqlcode = 0 then
				commit using sqlca;
			else
				rollback using sqlca;
			end if
		end if
	Next
	pb_anyadir1.triggerevent(clicked!)
end if
end event

type dw_estado from u_dw within wtc_consulta_pantallas
integer x = 2985
integer y = 508
integer width = 2574
integer height = 2748
integer taborder = 80
boolean bringtotop = true
string dataobject = "dwtc_historicomodelo2"
boolean vscrollbar = true
end type

