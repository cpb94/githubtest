$PBExportHeader$wtc_consulta_laboratorio_old2.srw
forward
global type wtc_consulta_laboratorio_old2 from wt_consultas_padre
end type
type dw_imagen from u_dw_imagen within wtc_consulta_laboratorio_old2
end type
type dw_imagen_grande from u_dw_imagen within wtc_consulta_laboratorio_old2
end type
type dw_datos2 from datawindow within wtc_consulta_laboratorio_old2
end type
type dw_historico from u_dw within wtc_consulta_laboratorio_old2
end type
end forward

global type wtc_consulta_laboratorio_old2 from wt_consultas_padre
integer width = 4974
integer height = 3480
string title = "Consulta Laboratorio"
dw_imagen dw_imagen
dw_imagen_grande dw_imagen_grande
dw_datos2 dw_datos2
dw_historico dw_historico
end type
global wtc_consulta_laboratorio_old2 wtc_consulta_laboratorio_old2

type variables
string sql_inicial, sql_auxiliar
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

on wtc_consulta_laboratorio_old2.create
int iCurrent
call super::create
this.dw_imagen=create dw_imagen
this.dw_imagen_grande=create dw_imagen_grande
this.dw_datos2=create dw_datos2
this.dw_historico=create dw_historico
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_imagen
this.Control[iCurrent+2]=this.dw_imagen_grande
this.Control[iCurrent+3]=this.dw_datos2
this.Control[iCurrent+4]=this.dw_historico
end on

on wtc_consulta_laboratorio_old2.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_imagen)
destroy(this.dw_imagen_grande)
destroy(this.dw_datos2)
destroy(this.dw_historico)
end on

event open;call super::open;dw_datos.SetTransObject(SQLCA)
dw_datos2.SetTransObject(SQLCA)
dw_historico.SetTransObject(SQLCA)

sql_inicial = "SELECT modelo_pieza.empresa,   "+&
         "modelo_pieza.modelo,   "+&
         "modelo_pieza.cliente,   "+&
         "modelo_pieza.propuesta,   "+&
         "modelo_pieza.codigo,   "+&
         "modelo_pieza.codigo_lab,   "+&
         "modelo_pieza.modelo_trabajo,   "+&
         "modelo.coleccion,   "+&
         "modelo_pieza.fecha_lab,   "+&
         "modelo_pieza.activo,   "+&
         "modelo_propuesta.formato,   "+&
         "formatos.abreviado,   "+&
         "formatos.largo,   "+&
         "formatos.ancho,   "+&
         "descoleccionsol.disenyador,   "+&
         "descoleccionsol.comercial,   "+&
         "descoleccionsol.tecnico_lab,   "+&
         "descoleccionsol.estado,   "+&
         "modelo.relieve,   "+&
         "modelo.pavrev,   "+&
         "modelo_trabajo.comercial,   "+&
         "modelo_trabajo.tecnico_dis,   "+&
         "comercial.descripcion,   "+&
         "tecnico_dis.descripcion,   "+&
         "tecnico_lab.descripcion,   "+&
         "art_tipomoldura.descripcion  "+&
         "FROM modelo_pieza,   "+&
         "modelo,   "+&
         "modelo_cliente,  "+& 
         "modelo_propuesta,   "+&
         "modelo_trabajo,   "+&
         "formatos,   "+&
         "descoleccionsol,   "+&
         "comercial,   "+&
         "tecnico_dis,   "+&
         "tecnico_lab,   "+&
         "art_tipomoldura  "+&
         "WHERE ( modelo_pieza.empresa = modelo.empresa ) and  "+&
         "( modelo_pieza.modelo = modelo.modelo ) and  "+&
         "( modelo_pieza.empresa = modelo_cliente.empresa ) and  "+&
         "( modelo_pieza.modelo = modelo_cliente.modelo ) and  "+&
         "( modelo_pieza.cliente = modelo_cliente.cliente ) and  "+&
         "( modelo_pieza.empresa = modelo_propuesta.empresa ) and  "+&
         "( modelo_pieza.modelo = modelo_propuesta.modelo ) and  "+&
         "( modelo_pieza.cliente = modelo_propuesta.cliente ) and  "+&
         "( modelo_pieza.propuesta = modelo_propuesta.codigo ) and  "+&
         "( modelo_pieza.empresa = modelo_trabajo.empresa ) and  "+&
         "( modelo_pieza.modelo = modelo_trabajo.modelo ) and  "+&
         "( modelo_pieza.cliente = modelo_trabajo.cliente ) and  "+&
         "( modelo_pieza.propuesta = modelo_trabajo.propuesta ) and  "+&
         "( modelo_pieza.modelo_trabajo = modelo_trabajo.codigo ) and  "+&
         "( modelo_propuesta.empresa = formatos.empresa ) and  "+&
         "( modelo_propuesta.formato = formatos.codigo ) and  "+&
         "( modelo.empresa = descoleccionsol.empresa ) and  "+&
         "( modelo.coleccion = descoleccionsol.codigo ) and  "+&
         "( modelo_trabajo.empresa = comercial.empresa ) and  "+&
         "( modelo_trabajo.comercial = comercial.codigo ) and  "+&
         "( modelo_trabajo.empresa = tecnico_dis.empresa ) and  "+&
         "( modelo_trabajo.tecnico_dis = tecnico_dis.codigo ) and  "+&
         "( descoleccionsol.empresa = tecnico_lab.empresa ) and  "+&
         "( descoleccionsol.tecnico_lab = tecnico_lab.codigo ) and  "+&
         "( modelo.empresa = art_tipomoldura.empresa ) and  "+&
         "( modelo.relieve = art_tipomoldura.codigo ) and  "+&
         "( modelo_pieza.empresa = '"+codigo_empresa+"'  )  "  

sql_auxiliar = "SELECT modelo_pieza.empresa,   "+&
         "modelo_pieza.modelo,   "+&
         "modelo_pieza.cliente,   "+&
         "modelo_pieza.propuesta,   "+&
         "modelo_pieza.codigo,   "+&
         "modelo_pieza.codigo_lab,   "+&
         "modelo_pieza.modelo_trabajo,   "+&
         "modelo.coleccion,   "+&
         "modelo_pieza.fecha_lab,   "+&
         "modelo_pieza.activo,   "+&
         "modelo_propuesta.formato,   "+&
         "formatos.abreviado,   "+&
         "formatos.largo,   "+&
         "formatos.ancho,   "+&
         "descoleccionsol.disenyador,   "+&
         "descoleccionsol.comercial,   "+&
         "descoleccionsol.tecnico_lab,   "+&
         "descoleccionsol.estado,   "+&
         "modelo.relieve,   "+&
         "modelo.pavrev,   "+&
         "modelo_trabajo.comercial,   "+&
         "modelo_trabajo.tecnico_dis,   "+&
         "comercial.descripcion,   "+&
         "tecnico_dis.descripcion,   "+&
         "tecnico_lab.descripcion,   "+&
         "art_tipomoldura.descripcion,  "+&
			"modelo_pieza_archivo.ruta, "+&
         "modelo_pieza_archivo.fichero, "+&
         "(REPLACE((SELECT ruta_archivos_exposicion FROM empresas WHERE empresa = '"+codigo_empresa+"') + ruta + (SELECT tamanyo FROM archivo_resolucion WHERE codigo = '5') + '\' + fichero, ' ','')) AS ruta_fichero  "+&
         "FROM modelo_pieza LEFT OUTER JOIN modelo_pieza_archivo ON modelo_pieza.empresa = modelo_pieza_archivo.empresa AND modelo_pieza.codigo_lab = modelo_pieza_archivo.pieza,   "+&
         "modelo,   "+&
         "modelo_cliente,  "+& 
         "modelo_propuesta,   "+&
         "modelo_trabajo,   "+&
         "formatos,   "+&
         "descoleccionsol,   "+&
         "comercial,   "+&
         "tecnico_dis,   "+&
         "tecnico_lab,   "+&
         "art_tipomoldura  "+&
         "WHERE ( modelo_pieza.empresa = modelo.empresa ) and  "+&
         "( modelo_pieza.modelo = modelo.modelo ) and  "+&
         "( modelo_pieza.empresa = modelo_cliente.empresa ) and  "+&
         "( modelo_pieza.modelo = modelo_cliente.modelo ) and  "+&
         "( modelo_pieza.cliente = modelo_cliente.cliente ) and  "+&
         "( modelo_pieza.empresa = modelo_propuesta.empresa ) and  "+&
         "( modelo_pieza.modelo = modelo_propuesta.modelo ) and  "+&
         "( modelo_pieza.cliente = modelo_propuesta.cliente ) and  "+&
         "( modelo_pieza.propuesta = modelo_propuesta.codigo ) and  "+&
         "( modelo_pieza.empresa = modelo_trabajo.empresa ) and  "+&
         "( modelo_pieza.modelo = modelo_trabajo.modelo ) and  "+&
         "( modelo_pieza.cliente = modelo_trabajo.cliente ) and  "+&
         "( modelo_pieza.propuesta = modelo_trabajo.propuesta ) and  "+&
         "( modelo_pieza.modelo_trabajo = modelo_trabajo.codigo ) and  "+&
         "( modelo_propuesta.empresa = formatos.empresa ) and  "+&
         "( modelo_propuesta.formato = formatos.codigo ) and  "+&
         "( modelo.empresa = descoleccionsol.empresa ) and  "+&
         "( modelo.coleccion = descoleccionsol.codigo ) and  "+&
         "( modelo_trabajo.empresa = comercial.empresa ) and  "+&
         "( modelo_trabajo.comercial = comercial.codigo ) and  "+&
         "( modelo_trabajo.empresa = tecnico_dis.empresa ) and  "+&
         "( modelo_trabajo.tecnico_dis = tecnico_dis.codigo ) and  "+&
         "( descoleccionsol.empresa = tecnico_lab.empresa ) and  "+&
         "( descoleccionsol.tecnico_lab = tecnico_lab.codigo ) and  "+&
         "( modelo.empresa = art_tipomoldura.empresa ) and  "+&
         "( modelo.relieve = art_tipomoldura.codigo ) and  "+&
			" ( modelo_pieza_archivo.codigo IS NULL OR ( modelo_pieza_archivo.codigo = (SELECT CONVERT(char,MIN(codigo)) FROM modelo_pieza_archivo A WHERE A.empresa = modelo_pieza.empresa AND A.pieza = modelo_pieza.codigo_lab) ) )  and  "+&
         "( modelo_pieza.empresa = '"+codigo_empresa+"'  )  "  
end event

type st_registros_padre from wt_consultas_padre`st_registros_padre within wtc_consulta_laboratorio_old2
end type

type st_total_padre from wt_consultas_padre`st_total_padre within wtc_consulta_laboratorio_old2
end type

type pb_imprimir from wt_consultas_padre`pb_imprimir within wtc_consulta_laboratorio_old2
integer x = 4229
integer y = 156
integer taborder = 0
end type

event pb_imprimir::clicked;String new_sql
if dw_datos.rowcount() > 0 then
	if MessageBox("Impresión de Imágenes de las Piezas", "¿Desea que se impriman las imágenes de las Piezas?", Question!, YesNo!, 2) = 1 then
		new_sql = f_montar_filtro(sql_auxiliar)
		dw_datos2.SetSQLSelect ( new_sql )
		dw_datos2.retrieve()
		f_imprimir_datawindow(dw_datos2)
	else
		f_imprimir_datawindow(dw_datos)
	end if
end if
end event

type pb_borrar from wt_consultas_padre`pb_borrar within wtc_consulta_laboratorio_old2
integer x = 4434
integer y = 152
integer taborder = 0
end type

type dw_montaje_filtro from wt_consultas_padre`dw_montaje_filtro within wtc_consulta_laboratorio_old2
integer width = 3867
integer height = 224
end type

type pb_1 from wt_consultas_padre`pb_1 within wtc_consulta_laboratorio_old2
integer x = 3177
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
	
	dw_imagen.y = dw_imagen.y - 75
	//dw_imagen.height = dw_imagen.height + 75
else
	dw_datos.y = 512
	dw_datos.height = 2192
	dw_montaje_filtro.height = 225
	
	dw_imagen.y = 512
	//dw_imagen.height = 2192
end if

if dw_datos.rowcount() > 0 then
	dw_datos.setrow(1)
	dw_datos.Event rowfocuschanged(1)
end if
end event

type pb_reset from wt_consultas_padre`pb_reset within wtc_consulta_laboratorio_old2
integer x = 4590
integer y = 152
integer taborder = 0
end type

type pb_anyadir1 from wt_consultas_padre`pb_anyadir1 within wtc_consulta_laboratorio_old2
integer x = 3026
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
		case "Diseñador Trabajo"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " modelo_trabajo.tecnico_dis = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Diseñador Trabajo = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR modelo_trabajo.tecnico_dis = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 			
	
		case "Comercial Trabajo"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " modelo_trabajo.comercial = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Comercial Trabajo = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR modelo_trabajo.comercial = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 
		case "Técnico Colección"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " descoleccionsol.tecnico_lab = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Técnico Colección = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR descoleccionsol.tecnico_lab = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 
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
		case "Fecha Colección"
			if cadena_or = '' then
				cadena_or = " CONVERT(date, descoleccionsol.fecha_coleccion) "+ddlb_operador.text+" '"+em_fecha1.text+"' "
				cadena_or_visible = " Fecha Colección "+ddlb_operador.text+" "+em_fecha1.text
			end if
		case "Fecha Solicitud Trabajo"
			if cadena_or = '' then
				cadena_or = " CONVERT(date,modelo_trabajo.fecha_solicitud) "+ddlb_operador.text+" '"+em_fecha1.text+"' "
				cadena_or_visible = " Fecha Solicitud Trabajo "+ddlb_operador.text+" "+em_fecha1.text
			end if
		case "Fecha Laboratorio"
			if cadena_or = '' then
				cadena_or = " CONVERT(date,modelo_pieza.fecha_lab) "+ddlb_operador.text+" '"+em_fecha1.text+"' "
				cadena_or_visible = " Fecha Laboratorio "+ddlb_operador.text+" "+em_fecha1.text
			end if
		case "Fecha Rechazado"
			if cadena_or = '' then
				cadena_or = " AND EXISTS (SELECT * FROM CONVERT(date,modelo_pieza.fecha_lab) "+ddlb_operador.text+" '"+em_fecha1.text+"' "
				cadena_or_visible = " Fecha Rechazado "+ddlb_operador.text+" "+em_fecha1.text
			end if	
			
		case "Colección"
			if cadena_or = '' then
				cadena_or = " descoleccionsol.codigo "+ddlb_operador.text+" '"+sle_valor1.text+"' "
				cadena_or_visible = " Colección "+ddlb_operador.text+" '"+sle_valor1.text+"' "
			end if
		case "Cliente"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " modelo_pieza.cliente = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Cliente = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR modelo_pieza.cliente = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 
		case "Estado"
			for k = 1 to lb_lista.totalitems()
				if lb_lista.state(k) = 1 then
					if cadena_or = '' then
						cadena_or = " EXISTS (SELECT * FROM deshistorico WHERE deshistorico.empresa = '"+codigo_empresa+"' AND deshistorico.cliente = modelo_pieza.cliente AND deshistorico.estado = '"+lb_lista.Text (k)+"') "
						cadena_or_visible = " Estado = "+lb_lista.Text (k)
					else
						cadena_or = cadena_or+" OR EXISTS (SELECT * FROM deshistorico WHERE deshistorico.empresa = '"+codigo_empresa+"' AND deshistorico.cliente = modelo_pieza.cliente AND deshistorico.estado = '"+lb_lista.Text (k)+"') "
						cadena_or_visible = cadena_or_visible+", "+lb_lista.Text (k)
					end if
				end if
			next
		case "Activa"
			for k = 1 to lb_lista.totalitems()
				if lb_lista.state(k) = 1 then
					if cadena_or = '' then
						cadena_or = " modelo_pieza.activo = '"+UPPER(lb_lista.Text (k))+"' "
						cadena_or_visible = " Activa = "+ lb_lista.Text (k)
					else
						cadena_or = cadena_or+" OR modelo_pieza.activo = '"+UPPER(lb_lista.Text (k))+"' "
						cadena_or_visible = cadena_or_visible+", "+lb_lista.Text (k)
					end if
				end if
			next
		case "Largo Pieza"
			if cadena_or = '' then
				cadena_or = " formatos.largo "+ddlb_operador.text+" "+sle_valor1.text+" "
				cadena_or_visible = " Largo Pieza "+ddlb_operador.text+" "+sle_valor1.text
			end if
		case "Ancho Pieza"
			if cadena_or = '' then
				cadena_or = " formatos.ancho "+ddlb_operador.text+" "+sle_valor1.text+" "
				cadena_or_visible = " Ancho Pieza "+ddlb_operador.text+" "+sle_valor1.text
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
		
		dw_imagen.y = dw_imagen.y + 75
		//dw_imagen.height = dw_imagen.height - 75
	end if
	
	dw_datos.setfocus()
	if dw_datos.rowcount() > 0 then
		dw_datos.setrow(1)
		dw_datos.Event rowfocuschanged(1)
	end if
else
	
	new_sql = f_montar_filtro(sql_inicial)
			
	dw_datos.SetSQLSelect ( new_sql )
	dw_datos.retrieve()
	
	dw_datos.setfocus()
	if dw_datos.rowcount() > 0 then
		dw_datos.setrow(1)
		dw_datos.Event rowfocuschanged(1)
	end if
end if
end event

type ddlb_operador from wt_consultas_padre`ddlb_operador within wtc_consulta_laboratorio_old2
integer x = 951
integer taborder = 20
integer weight = 700
long textcolor = 23016974
boolean sorted = false
end type

type ddlb_campo from wt_consultas_padre`ddlb_campo within wtc_consulta_laboratorio_old2
integer width = 878
integer height = 1308
integer taborder = 10
integer weight = 700
long textcolor = 24076881
string item[] = {"Diseñador Trabajo","Comercial Trabajo","Técnico Colección","Fecha Colección","Colección","Cliente","Estado","Fecha Solicitud Trabajo","Fecha Laboratorio","Fecha Rechazado","Activa","Ancho Pieza","Largo Pieza"}
end type

event ddlb_campo::selectionchanged;call super::selectionchanged;string consulta, new_syntax,  error_syntaxfromSQL, mensaje_error, error_create


ddlb_operador.Reset()
lb_lista.Reset()

CHOOSE CASE ddlb_campo.text
	CASE "Diseñador Trabajo"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, descripcion as Descripción from tecnico_dis where empresa = '"+codigo_empresa+"' and activo = 'S' order by descripcion"
	CASE "Comercial Trabajo"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false

		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, descripcion as Descripción from comercial where empresa = '"+codigo_empresa+"' order by descripcion "
	CASE "Técnico Colección", "Técnico Prueba"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false

		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, descripcion as Descripción from tecnico_lab where empresa = '"+codigo_empresa+"' and activo = 'S' order by descripcion "
	CASE "Fecha Colección", "Fecha Solicitud Trabajo", "Fecha Laboratorio", "Fecha Rechazado"
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
	CASE "Largo Pieza", "Ancho Pieza"
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
	CASE "Colección"
		dw_filtro.visible = false
		pb_buscar.visible = false
		sle_texto.visible = false
		em_fecha1.visible = false
		sle_valor1.visible = true
		lb_lista.visible = false
		
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
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, razon as Descripción from genter where empresa = '"+codigo_empresa+"' and tipoter = 'C' order by razon"

	CASE "Estado"
		dw_filtro.visible = false
		pb_buscar.visible = false
		sle_texto.visible = false
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = true
		
		lb_lista.AddItem ("Pendiente")
		lb_lista.AddItem ("Rechazado")
		lb_lista.AddItem ("Reservado")
		lb_lista.AddItem ("Aceptado")
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="

	CASE "Activa"
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

type dw_datos from wt_consultas_padre`dw_datos within wtc_consulta_laboratorio_old2
integer y = 512
integer width = 3863
integer height = 2192
integer taborder = 60
string dataobject = "dwtc_consulta_laboratorio2"
end type

event dw_datos::rowfocuschanged;call super::rowfocuschanged;//CON RUTAS
string codigo_archivo, pieza, ruta, tamanyo, coleccion
Long min_codigo_archivo

if currentrow <= 0 then 
	dw_historico.reset()
	return
end if

SELECT tamanyo INTO :tamanyo FROM archivo_resolucion WHERE empresa = :codigo_empresa AND codigo = 1;

dw_imagen.visible = false // para evitar efectos raros en pantalla.

pieza = dw_datos.object.modelo_pieza_codigo_lab[dw_datos.getrow()]

if not isnull(pieza) and pieza <> "" then
	ftc_imagen_fondo_datawindow(dw_imagen,"1","","",pieza)
else
	dw_imagen.visible = false
end if

coleccion = this.object.modelo_coleccion[currentrow]

if not isnull(coleccion) and coleccion <> "" then
	dw_historico.retrieve(codigo_empresa, coleccion)
else
	dw_historico.reset()
end if
end event

event dw_datos::clicked;call super::clicked;String pieza, activa
if row > 0 then
	if dwo.name = "modelo_pieza_activo" then
		pieza = this.object.modelo_pieza_codigo_lab[row]
		activa = this.object.modelo_pieza_activo[row]
		if isnull(activa) or activa = "" or activa = "N" then
			activa = "S"
		else
			activa = "N"
		end if
		UPDATE modelo_pieza SET activo = :activa WHERE empresa = :codigo_empresa AND codigo_lab = :pieza USING SQLCA;
		if sqlca.sqlcode = 0 then
			commit using sqlca;
		else
			rollback using sqlca;
		end if
	end if
end if
end event

event dw_datos::doubleclicked;call super::doubleclicked;Long id_ventana
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
end event

type pb_salir from wt_consultas_padre`pb_salir within wtc_consulta_laboratorio_old2
integer x = 4745
integer y = 152
integer taborder = 0
end type

type st_titulo from wt_consultas_padre`st_titulo within wtc_consulta_laboratorio_old2
end type

type p_logo from wt_consultas_padre`p_logo within wtc_consulta_laboratorio_old2
integer x = 4389
integer y = 36
end type

type dw_filtro from wt_consultas_padre`dw_filtro within wtc_consulta_laboratorio_old2
integer x = 1317
integer y = 240
integer width = 1673
integer height = 260
integer taborder = 70
boolean vscrollbar = true
end type

type pb_buscar from wt_consultas_padre`pb_buscar within wtc_consulta_laboratorio_old2
integer x = 2871
integer y = 132
integer taborder = 90
end type

type sle_valor1 from wt_consultas_padre`sle_valor1 within wtc_consulta_laboratorio_old2
integer x = 1312
integer width = 398
integer height = 96
integer taborder = 30
end type

type em_fecha1 from wt_consultas_padre`em_fecha1 within wtc_consulta_laboratorio_old2
integer x = 1307
integer height = 96
integer taborder = 110
string text = ""
end type

type sle_texto from wt_consultas_padre`sle_texto within wtc_consulta_laboratorio_old2
integer x = 1312
integer y = 132
integer height = 96
integer taborder = 40
end type

type lb_lista from wt_consultas_padre`lb_lista within wtc_consulta_laboratorio_old2
integer x = 1312
integer y = 132
integer width = 462
integer height = 356
integer taborder = 80
long textcolor = 24076881
end type

type dw_imagen from u_dw_imagen within wtc_consulta_laboratorio_old2
integer x = 3936
integer y = 512
integer width = 960
integer height = 720
integer taborder = 70
boolean bringtotop = true
end type

event doubleclicked;call super::doubleclicked;//Abrir imágen grande
string codigo_archivo, pieza, ruta, tamanyo
Long min_codigo_archivo

if isnull(dw_imagen.Object.datawindow.picture.File) or dw_imagen.Object.datawindow.picture.File = "" then
	return
end if

SELECT tamanyo INTO :tamanyo FROM archivo_resolucion WHERE empresa = :codigo_empresa AND codigo = 2;

pieza = dw_datos.object.modelo_pieza_codigo_lab[dw_datos.getrow()]
//dw_imagen_grande.object.titulo = "Pieza "+pieza

if not isnull(pieza) and pieza <> "" then

	ruta = ftc_imagen_ruta("2","","",pieza)
		
	if not isnull(ruta) and ruta <> "" then
		dw_imagen_grande.Object.datawindow.picture.File = ruta
		dw_imagen_grande.visible = true
	else
		dw_imagen_grande.visible = false
	end if
else
	dw_imagen_grande.visible = false
end if
end event

type dw_imagen_grande from u_dw_imagen within wtc_consulta_laboratorio_old2
boolean visible = false
integer x = 41
integer y = 508
integer width = 4864
integer height = 2748
integer taborder = 70
string dataobject = "dw_aux_imagen2"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event clicked;call super::clicked;if dwo.name = "cerrar" then
	dw_imagen_grande.visible = false
end if
end event

type dw_datos2 from datawindow within wtc_consulta_laboratorio_old2
boolean visible = false
integer x = 3360
integer y = 100
integer width = 686
integer height = 400
integer taborder = 110
boolean bringtotop = true
string title = "none"
string dataobject = "dwtc_consulta_laboratorio_impresion"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_historico from u_dw within wtc_consulta_laboratorio_old2
integer x = 59
integer y = 2724
integer width = 3849
integer height = 528
integer taborder = 80
boolean bringtotop = true
string dataobject = "dwtc_historicomodelo2"
boolean vscrollbar = true
end type

