$PBExportHeader$wtc_consulta_ticket.srw
forward
global type wtc_consulta_ticket from wt_consultas_padre
end type
type cbx_finalizadas from checkbox within wtc_consulta_ticket
end type
type cbx_stock from checkbox within wtc_consulta_ticket
end type
type dw_imagen from u_dw_imagen within wtc_consulta_ticket
end type
type dw_stock_bases from datawindow within wtc_consulta_ticket
end type
type cbx_borrado from checkbox within wtc_consulta_ticket
end type
end forward

global type wtc_consulta_ticket from wt_consultas_padre
integer width = 5609
integer height = 3072
string title = "Consulta Ticket Máquina Producción"
cbx_finalizadas cbx_finalizadas
cbx_stock cbx_stock
dw_imagen dw_imagen
dw_stock_bases dw_stock_bases
cbx_borrado cbx_borrado
end type
global wtc_consulta_ticket wtc_consulta_ticket

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

on wtc_consulta_ticket.create
int iCurrent
call super::create
this.cbx_finalizadas=create cbx_finalizadas
this.cbx_stock=create cbx_stock
this.dw_imagen=create dw_imagen
this.dw_stock_bases=create dw_stock_bases
this.cbx_borrado=create cbx_borrado
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_finalizadas
this.Control[iCurrent+2]=this.cbx_stock
this.Control[iCurrent+3]=this.dw_imagen
this.Control[iCurrent+4]=this.dw_stock_bases
this.Control[iCurrent+5]=this.cbx_borrado
end on

on wtc_consulta_ticket.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cbx_finalizadas)
destroy(this.cbx_stock)
destroy(this.dw_imagen)
destroy(this.dw_stock_bases)
destroy(this.cbx_borrado)
end on

event open;call super::open;dw_datos.SetTransObject(SQLCA)
dw_stock_bases.SetTransObject(SQLCA)

sql_inicial = "SELECT DISTINCT  modelo_pieza_ticket.empresa , "+&
"          modelo_pieza_ticket.pieza , "+&
"          modelo_pieza_ticket.codigo , "+&
"          modelo_pieza_ticket.tipo_maquina , "+&
"          modelo_pieza_ticket.archivo_disenyo , "+&
"          modelo_pieza_ticket.prueba , "+&
"          modelo_pieza_ticket.cantidad , "+&
"          modelo_pieza_ticket.tecnico , "+&
"          modelo_pieza_ticket.esmalte , "+&
"          modelo_pieza_ticket.base , "+&
"          modelo_pieza_ticket.pantallas , "+&
"          modelo_pieza_ticket.urgente , "+&
"          modelo_pieza_ticket.modo_impresion , "+&
"          modelo_pieza_ticket.observaciones , "+&
"          modelo_pieza_ticket.fecha , "+&
"          modelo_pieza_ticket.fecha_fin , "+&
"			  modelo_pieza_ticket.archivo_disenyo_prueba, "+&
"          articulos.descripcion , "+&
"          prodformula.descripcion_laboratorio , "+&
"          tipomaquina_disenyo.descripcion , "+&
"          tecnico_lab.descripcion , "+&
"          genter.razon , "+&
"          modelo_pieza.modelo , "+&
"          archivo_disenyo.nombre , "+&
"          articulos.ancho ,  "+&
"          articulos.largo , "+&
"		  archivo_disenyo_sistema_archivos.fichero,   "+&
"		  tecnico_dis.descripcion, "+&
"		  art_ver_tipooperacion.descripcion_abr "+&
"FROM modelo_pieza_ticket "+&
"LEFT OUTER JOIN articulos ON modelo_pieza_ticket.empresa = articulos.empresa AND modelo_pieza_ticket.base = articulos.codigo "+&
"LEFT OUTER JOIN prodformula ON modelo_pieza_ticket.empresa = prodformula.empresa AND modelo_pieza_ticket.esmalte = prodformula.formula "+&
"LEFT OUTER JOIN tecnico_lab ON modelo_pieza_ticket.empresa = tecnico_lab.empresa AND modelo_pieza_ticket.tecnico = tecnico_lab.codigo "+&
"LEFT OUTER JOIN tipomaquina_disenyo ON modelo_pieza_ticket.empresa = tipomaquina_disenyo.empresa AND modelo_pieza_ticket.tipo_maquina = tipomaquina_disenyo.codigo "+&
"LEFT OUTER JOIN genter ON articulos.empresa = genter.empresa AND articulos.cliente = genter.codigo "+&
"LEFT OUTER JOIN modelo_pieza ON modelo_pieza_ticket.empresa = modelo_pieza.empresa AND modelo_pieza_ticket.pieza = modelo_pieza.codigo_lab "+&
"LEFT OUTER JOIN modelo ON modelo_pieza.empresa = modelo.empresa AND modelo_pieza.modelo = modelo.modelo "+&
"LEFT OUTER JOIN tecnico_dis ON modelo.empresa = tecnico_dis.empresa AND modelo.tecnico_dis = tecnico_dis.codigo "+&
"LEFT OUTER JOIN archivo_disenyo ON modelo_pieza_ticket.empresa = archivo_disenyo.empresa AND modelo_pieza_ticket.tipo_maquina = archivo_disenyo.tipomaquina_disenyo AND modelo_pieza_ticket.archivo_disenyo = archivo_disenyo.codigo     "+&
"LEFT OUTER JOIN archivo_disenyo_sistema_archivos ON modelo_pieza_ticket.empresa = archivo_disenyo_sistema_archivos.empresa AND modelo_pieza_ticket.tipo_maquina = archivo_disenyo_sistema_archivos.tipomaquina_disenyo "+&
"AND modelo_pieza_ticket.archivo_disenyo = archivo_disenyo_sistema_archivos.archivo AND modelo_pieza_ticket.archivo_disenyo_prueba = archivo_disenyo_sistema_archivos.codigo "+&
"LEFT OUTER JOIN art_ver_tipooperacion ON modelo_pieza_ticket.empresa = art_ver_tipooperacion.empresa AND modelo_pieza_ticket.operacion = art_ver_tipooperacion.codigo "+&
"WHERE ( genter.tipoter = 'C'  OR genter.tipoter IS NULL) AND modelo_pieza_ticket.empresa = '"+codigo_empresa+"' "
			  

end event

type st_registros_padre from wt_consultas_padre`st_registros_padre within wtc_consulta_ticket
end type

type st_total_padre from wt_consultas_padre`st_total_padre within wtc_consulta_ticket
end type

type pb_imprimir from wt_consultas_padre`pb_imprimir within wtc_consulta_ticket
integer x = 4923
integer y = 104
end type

event pb_imprimir::clicked;if dw_stock_bases.visible = true then
	if dw_stock_bases.rowcount() > 0 then
		f_imprimir_datawindow(dw_stock_bases)
	end if
else
	if dw_datos.rowcount() > 0 then
		f_imprimir_datawindow(dw_datos)
	end if
end if
end event

type pb_borrar from wt_consultas_padre`pb_borrar within wtc_consulta_ticket
integer x = 5079
integer y = 104
end type

type dw_montaje_filtro from wt_consultas_padre`dw_montaje_filtro within wtc_consulta_ticket
integer width = 2967
integer height = 224
end type

type pb_1 from wt_consultas_padre`pb_1 within wtc_consulta_ticket
integer x = 4663
integer y = 104
integer taborder = 0
end type

event pb_1::clicked;call super::clicked;string new_sql
long fila

fila = dw_montaje_filtro.getrow()
dw_montaje_filtro.deleterow(fila)
new_sql = f_montar_filtro(sql_inicial)

if cbx_finalizadas.checked = false then
	new_sql = new_sql + " and modelo_pieza_ticket.fecha_fin IS NULL "
end if

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

dw_datos.setfocus()
end event

type pb_reset from wt_consultas_padre`pb_reset within wtc_consulta_ticket
integer x = 5234
integer y = 104
integer taborder = 0
end type

type pb_anyadir1 from wt_consultas_padre`pb_anyadir1 within wtc_consulta_ticket
integer x = 4512
integer y = 104
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
		case "Tipo Máquina"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " modelo_pieza_ticket.tipo_maquina = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Tipo Máquina = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR modelo_pieza_ticket.tipo_maquina = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 
			
		case "Fecha Prueba"
			if cadena_or = '' then
				cadena_or = " CONVERT(date, modelo_pieza_ticket.fecha) "+ddlb_operador.text+" '"+em_fecha1.text+"' "
				cadena_or_visible = " Fecha Prueba "+ddlb_operador.text+" "+em_fecha1.text
			end if
			
		case "Fecha Fin Prueba"
			if cadena_or = '' then
				cadena_or = " CONVERT(date, modelo_pieza_ticket.fecha_fin) "+ddlb_operador.text+" '"+em_fecha1.text+"' "
				cadena_or_visible = " Fecha Fin Prueba "+ddlb_operador.text+" "+em_fecha1.text
			end if
			
		case "Prueba"
			if cadena_or = '' then
				cadena_or = " modelo_pieza_ticket.prueba "+ddlb_operador.text+" '"+sle_valor1.text+"' "
				cadena_or_visible = " Prueba "+ddlb_operador.text+" '"+sle_valor1.text+"' "
			end if
			
		case "Modelo"
			if cadena_or = '' then
				cadena_or = " modelo_pieza.modelo "+ddlb_operador.text+" '"+sle_valor1.text+"' "
				cadena_or_visible = " Modelo "+ddlb_operador.text+" '"+sle_valor1.text+"' "
			end if
		
		case "Pieza"
			if cadena_or = '' then
				cadena_or = " modelo_pieza_ticket.pieza "+ddlb_operador.text+" '"+sle_valor1.text+"' "
				cadena_or_visible = " Pieza "+ddlb_operador.text+" '"+sle_valor1.text+"' "
			end if
	
		case "Técnico"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " modelo_pieza_ticket.tecnico = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Técnico = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR modelo_pieza_ticket.tecnico = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 
		case "Ticket"
			if cadena_or = '' then
				cadena_or = " modelo_pieza_ticket.codigo "+ddlb_operador.text+" "+sle_valor1.text+" "
				cadena_or_visible = " Ticket "+ddlb_operador.text+" "+sle_valor1.text
			end if
		CASE "Operación"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " modelo_pieza_ticket.operacion = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Operación = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR modelo_pieza_ticket.operacion = '"+dw_filtro.object.#1[i]+"' "
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
			
			new_sql = f_montar_filtro(sql_inicial)
			
			ddlb_campo.text = ''
			dw_filtro.visible = false
			dw_filtro.height = 137
		end if
	else
		new_sql = sql_inicial
	end if
	
	if cbx_finalizadas.checked = false then
		new_sql = new_sql + " and modelo_pieza_ticket.fecha_fin IS NULL "
	end if
	
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
	
	if cbx_finalizadas.checked = false then
		new_sql =  f_montar_filtro(sql_inicial) + " and modelo_pieza_ticket.fecha_fin IS NULL "
	else
		new_sql =  f_montar_filtro(sql_inicial)
	end if
	
	//Fin filtros especiales
	
	dw_datos.SetSQLSelect (new_sql)
	filas = dw_datos.retrieve()
	
	if filas > 0 then
		dw_datos.setfocus()
	end if
end if





end event

type ddlb_operador from wt_consultas_padre`ddlb_operador within wtc_consulta_ticket
integer x = 951
integer taborder = 20
integer weight = 700
long textcolor = 23016974
boolean sorted = false
end type

type ddlb_campo from wt_consultas_padre`ddlb_campo within wtc_consulta_ticket
integer width = 878
integer height = 904
integer taborder = 10
integer weight = 700
long textcolor = 24076881
string item[] = {"Tipo Máquina","Fecha Prueba","Fecha Fin Prueba","Prueba","Modelo","Pieza","Técnico","Ticket","Operación"}
end type

event ddlb_campo::selectionchanged;call super::selectionchanged;string consulta, new_syntax,  error_syntaxfromSQL, mensaje_error, error_create


ddlb_operador.Reset()
lb_lista.Reset()

CHOOSE CASE ddlb_campo.text
	CASE "Tipo Máquina"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, descripcion as Descripción from tipomaquina_disenyo where empresa = '"+codigo_empresa+"' "
		
	CASE "Operación"
		
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, descripcion_abr as Abreviado, descripcion as Descripción from art_ver_tipooperacion where empresa = '"+codigo_empresa+"' "
		
	CASE "Fecha Prueba", "Fecha Fin Prueba"
		dw_filtro.visible = false
		pb_buscar.visible = false
		sle_texto.visible = false
		em_fecha1.visible = true
		sle_valor1.visible = false
		lb_lista.visible = false
		
		ddlb_operador.AddItem (">")
		ddlb_operador.AddItem ("<")
		ddlb_operador.AddItem (">=")
		ddlb_operador.AddItem ("<=")
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = ">"
		
	CASE "Prueba", "Modelo", "Pieza"
		dw_filtro.visible = false
		pb_buscar.visible = false
		sle_texto.visible = false
		em_fecha1.visible = false
		sle_valor1.visible = true
		lb_lista.visible = false
		
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		
	CASE "Técnico"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false

		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, descripcion as Descripción from tecnico_lab where empresa = '"+codigo_empresa+"' order by descripcion "
	CASE "Ticket"
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

type dw_datos from wt_consultas_padre`dw_datos within wtc_consulta_ticket
integer y = 504
integer width = 5472
integer height = 2328
integer taborder = 60
string dataobject = "dwtc_consulta_ticket"
end type

event dw_datos::clicked;call super::clicked;string RUTA_MAQUINA_INK4 = "\\Ink-04\produccion\"

Datetime ahora 
String pieza, codigo, maquina, tipo_maquina, archivo_disenyo, archivo_disenyo_prueba, ruta_maquina, nombre_archivo
String sel
Long i, numero_maquinas, pruebas_fichero
Datastore maquinas

if row > 0 then
	if dwo.name = "b_fin" and permiso_ventana > 1 then
		ahora = Datetime(Today(), Now())
		pieza = dw_datos.object.modelo_pieza_ticket_pieza[row]
		codigo = dw_datos.object.modelo_pieza_ticket_codigo[row]
		UPDATE modelo_pieza_ticket SET fecha_fin = :ahora WHERE empresa = :codigo_empresa AND pieza = :pieza AND codigo = :codigo using sqlca; 
		if sqlca.sqlcode = 0 then
			commit using sqlca;
		else
			rollback using sqlca;
		end if
		
		
		if cbx_borrado.checked then
			sel = "SELECT prodlineas FROM modelo_pieza_ticket_prodlineas WHERE empresa = '"+codigo_empresa+"' and modelo_pieza_ticket = '"+codigo+"'"
			f_cargar_cursor_trans (SQLCA,  sel, maquinas)
			numero_maquinas = maquinas.RowCount()
			i = 1
			do while (i <= numero_maquinas) 
				maquina = maquinas.object.prodlineas[i]
				tipo_maquina = dw_datos.object.modelo_pieza_ticket_tipo_maquina[row]
				archivo_disenyo = dw_datos.object.modelo_pieza_ticket_archivo_disenyo[row]
				archivo_disenyo_prueba = dw_datos.object.modelo_pieza_ticket_archivo_disenyo_prueba[row]
				
				pruebas_fichero = 0
				SELECT COUNT(*) INTO :pruebas_fichero FROM modelo_pieza_ticket T INNER JOIN modelo_pieza_ticket_prodlineas L ON T.empresa = L.empresa AND T.codigo = L.modelo_pieza_ticket 
				WHERE T.empresa = :codigo_empresa AND T.tipo_maquina = :tipo_maquina AND T.archivo_disenyo = :archivo_disenyo 
				AND T.archivo_disenyo_prueba = :archivo_disenyo_prueba AND T.fecha_fin IS NULL AND L.prodlineas = :maquina;
				
				//No borramos el fichero si está en más pruebas sin finalizar
				if pruebas_fichero = 0 then 
					//SELECT ruta_pruebas_lab INTO :ruta_maquina FROM prodlineas WHERE empresa = :codigo_empresa AND codigo = :maquina;
					SELECT ruta_inkcid INTO :ruta_maquina FROM prodlineas WHERE empresa = :codigo_empresa AND codigo = :maquina;
					if isnull(ruta_maquina) or ruta_maquina = "" then
						MessageBox("Error","No se encuentra la ruta de la máquina para borrar su fichero.")
						return
					else
						SELECT fichero INTO :nombre_archivo FROM archivo_disenyo_sistema_archivos 
						WHERE empresa = :codigo_empresa AND tipomaquina_disenyo = :tipo_maquina AND archivo = :archivo_disenyo AND codigo = :archivo_disenyo_prueba;
						if isnull(nombre_archivo) or nombre_archivo = "" then
							//No avisamos
							//MessageBox("Error","No se encuentra la ruta del archivo.")
							return
						end if
					end if
					fileDelete(ruta_maquina + nombre_archivo)
					fileDelete(RUTA_MAQUINA_INK4 + nombre_archivo)
					/*
					//No avisamos del borrado
					if fileDelete(ruta_maquina + nombre_archivo) then
						MessageBox("Fichero Borrado", "Archivo borrado con éxito.")
					else
						MessageBox("Error de borrado", "No se ha podido borrar el archivo.")
					end if
					*/
				end if
				i++
			loop		
		end if
		
		dw_datos.retrieve()
		
	end if
else
	if dwo.name = "descoleccionsol_codigo_t" then
		this.setsort("modelo_pieza_ticket_codigo A")
		this.sort()
	end if
end if

Destroy maquinas
end event

event dw_datos::rowfocuschanged;call super::rowfocuschanged;//CON RUTAS
string pieza

if dw_datos.getrow() > 0 then
	pieza = dw_datos.object.modelo_pieza_ticket_pieza[dw_datos.getrow()]
	
	if not isnull(pieza) and pieza <> "" then
		ftc_imagen_fondo_datawindow(dw_imagen,"5","","",pieza)	
	else
		dw_imagen.visible = false
	end if
else
	dw_imagen.visible = false
end if
end event

event dw_datos::doubleclicked;call super::doubleclicked;str_parametros lstr_param
long esta_abierta

this.accepttext()

lstr_param.i_nargumentos=1
lstr_param.s_argumentos[1]=String(this.object.modelo_pieza_ticket_codigo[row])
lstr_param.nombre_ventana = "wtc_consulta_ticket"
lstr_param.resultado = ''

esta_abierta = f_menu_ventana_esta_abierta("wtc_mant_modelo_pieza_ticket")
if esta_abierta <> -1 then
	close(wtc_mant_modelo_pieza_ticket)
	OpenWithParm(wtc_mant_modelo_pieza_ticket,lstr_param)
else
	OpenWithParm(wtc_mant_modelo_pieza_ticket,lstr_param)
end if

end event

type pb_salir from wt_consultas_padre`pb_salir within wtc_consulta_ticket
integer x = 5390
integer y = 104
integer taborder = 0
end type

type st_titulo from wt_consultas_padre`st_titulo within wtc_consulta_ticket
integer width = 1243
end type

type p_logo from wt_consultas_padre`p_logo within wtc_consulta_ticket
integer x = 5015
end type

type dw_filtro from wt_consultas_padre`dw_filtro within wtc_consulta_ticket
integer x = 1298
integer y = 232
integer width = 1673
integer height = 132
integer taborder = 70
boolean vscrollbar = true
end type

type pb_buscar from wt_consultas_padre`pb_buscar within wtc_consulta_ticket
integer x = 2871
integer y = 132
integer taborder = 80
end type

type sle_valor1 from wt_consultas_padre`sle_valor1 within wtc_consulta_ticket
integer x = 1312
integer width = 398
integer height = 96
integer taborder = 30
end type

type em_fecha1 from wt_consultas_padre`em_fecha1 within wtc_consulta_ticket
integer x = 1307
integer height = 96
integer taborder = 90
string text = ""
end type

type sle_texto from wt_consultas_padre`sle_texto within wtc_consulta_ticket
integer x = 1312
integer y = 132
integer height = 96
integer taborder = 40
end type

type lb_lista from wt_consultas_padre`lb_lista within wtc_consulta_ticket
integer x = 1312
integer y = 132
integer width = 462
integer height = 252
long textcolor = 24076881
end type

type cbx_finalizadas from checkbox within wtc_consulta_ticket
integer x = 4535
integer y = 244
integer width = 750
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ver Pruebas Finalizadas"
end type

event clicked;String new_sql
Long filas

//Filtros especiales (Fuera del padre) 
	
if cbx_finalizadas.checked = false then
	new_sql =  f_montar_filtro(sql_inicial) + " and modelo_pieza_ticket.fecha_fin IS NULL "
else
	new_sql =  f_montar_filtro(sql_inicial)
end if

//Fin filtros especiales

dw_datos.SetSQLSelect (new_sql)
filas = dw_datos.retrieve()

if filas > 0 then
	dw_datos.setfocus()
end if
end event

type cbx_stock from checkbox within wtc_consulta_ticket
integer x = 4535
integer y = 328
integer width = 750
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Mostrar Stock Bases"
end type

event clicked;string filtro, filtro2, codigo, descripcion, almacen, zona, sel, sel1, sel2, codigo_ante, cliente, razon
long i, j, fila, altura, nuevo_reg, estado, total_stock
dec existencias, cantidad
datastore ubicaciones, bases
Datetime fecha1_fin, fecha2_fin

if dw_stock_bases.visible = false then

	dw_stock_bases.reset()
	
	sel1 = "select sum (cantidad) "+&
			 " from modelo_pieza_ticket B " +&
		  	 " where B.empresa = '"+codigo_empresa+"' "+&
			 " and B.base = modelo_pieza_ticket.base "
			 
	sel1 = sel1 + f_reemplazar(f_montar_filtro(""), "modelo_pieza_ticket", "B")
	if cbx_finalizadas.checked = false then
		sel1 = sel1 + " and B.fecha_fin IS NULL "
	end if
	
	sel2 = " select distinct modelo_pieza_ticket.base , articulos.descripcion, articulos.cliente, "+&
										" ( "+sel1+" ) as cantidad "+&
			" from modelo_pieza_ticket INNER JOIN articulos ON modelo_pieza_ticket.empresa = articulos.empresa AND modelo_pieza_ticket.base = articulos.codigo "+&
			" where modelo_pieza_ticket.empresa = '"+codigo_empresa+"' "
	sel2 = f_montar_filtro(sel2)
	if cbx_finalizadas.checked = false then
		sel2 = sel2 + " and modelo_pieza_ticket.fecha_fin IS NULL "
	end if
	sel2 = sel2 + " order by articulos.descripcion "
	
	f_cargar_cursor_nuevo (sel2, bases)
	
	for i = 1 to bases.rowcount()
		codigo = bases.object.modelo_pieza_ticket_base[i]
		descripcion = bases.object.articulos_descripcion[i]
		cantidad = bases.object.cantidad[i]
		cliente = bases.object.articulos_cliente[i]
		razon = ""
		estado = 2 // estado ok
		total_stock = 0 
		
		SELECT razon INTO :razon FROM genter WHERE empresa = :codigo_empresa AND codigo = :cliente;
	/*
		sel = " select almacen, zona, fila, altura, existencias "+&
				" from almlinubica "+&
				" where empresa = '"+codigo_empresa+"' "+&
				" and articulo = '"+codigo+"' "+&
				" and almacen = '4'"
*/

		sel = " select almacen, zona, fila, altura, sum(cantidade- cantidads) existencias "+&
				" from almacenmovimientos "+&
				" where empresa = '"+codigo_empresa+"' "+&
				" and articulo = '"+codigo+"' "+&
				" and almacen = '4'" +&
				" group by almacen, zona, fila, altura "+&
				" having sum(cantidade- cantidads) <> 0 "

		f_cargar_cursor_nuevo (sel, ubicaciones)
	
		if ubicaciones.rowcount() >= 1 then
			for j = 1 to ubicaciones.rowcount()
				almacen = ubicaciones.object.almacen[j]
				zona = ubicaciones.object.zona[j]
				fila = ubicaciones.object.fila[j]
				altura = ubicaciones.object.altura[j]
				existencias = ubicaciones.object.existencias[j]
				total_stock = total_stock + existencias
		
			
				nuevo_reg = dw_stock_bases.insertrow(0)
				dw_stock_bases.object.codigo[nuevo_reg] = codigo
				dw_stock_bases.object.descripcion [nuevo_reg] = descripcion
				dw_stock_bases.object.almacen [nuevo_reg] = almacen
				dw_stock_bases.object.zona[nuevo_reg] = zona
				dw_stock_bases.object.fila [nuevo_reg] = fila
				dw_stock_bases.object.altura [nuevo_reg] = altura
				dw_stock_bases.object.stock [nuevo_reg] = existencias
				dw_stock_bases.object.cantidad[nuevo_reg] = cantidad
				dw_stock_bases.object.cliente[nuevo_reg] = razon
				dw_stock_bases.object.estado[nuevo_reg] = 2
			next
		else
			//Mostramos también bases sin stock
			nuevo_reg = dw_stock_bases.insertrow(0)
			dw_stock_bases.object.codigo[nuevo_reg] = codigo
			dw_stock_bases.object.descripcion [nuevo_reg] = descripcion
			dw_stock_bases.object.almacen [nuevo_reg] = "-"
			dw_stock_bases.object.zona[nuevo_reg] = "-"
			dw_stock_bases.object.fila [nuevo_reg] = 0
			dw_stock_bases.object.altura [nuevo_reg] = 0
			dw_stock_bases.object.stock [nuevo_reg] = 0
			dw_stock_bases.object.cantidad[nuevo_reg] = cantidad
			dw_stock_bases.object.cliente[nuevo_reg] = razon
			dw_stock_bases.object.estado[nuevo_reg] = 0
			total_stock = 0 
		end if
		
		if total_stock <> 0 and total_stock < cantidad then
			dw_stock_bases.setfilter("codigo = '"+codigo+"'")
			dw_stock_bases.filter()
			for j = 1 to dw_stock_bases.rowcount()
				dw_stock_bases.object.estado[j] = 1
			next
			dw_stock_bases.setfilter("1 = 1")
			dw_stock_bases.filter()
		end if
		dw_stock_bases.visible = true
		cbx_stock.checked = true
		
		destroy ubicaciones
	next

else
	dw_stock_bases.visible = false
	cbx_stock.checked = false
end if

destroy bases

end event

type dw_imagen from u_dw_imagen within wtc_consulta_ticket
integer x = 3081
integer y = 120
integer width = 800
integer height = 360
integer taborder = 110
boolean bringtotop = true
end type

type dw_stock_bases from datawindow within wtc_consulta_ticket
boolean visible = false
integer x = 50
integer y = 512
integer width = 4901
integer height = 2328
integer taborder = 10
string title = "none"
string dataobject = "dw_stock_bases"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

type cbx_borrado from checkbox within wtc_consulta_ticket
integer x = 4535
integer y = 408
integer width = 750
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Borrado automático"
boolean checked = true
end type

event clicked;String new_sql
Long filas

//Filtros especiales (Fuera del padre) 
	
if cbx_finalizadas.checked = false then
	new_sql =  f_montar_filtro(sql_inicial) + " and modelo_pieza_ticket.fecha_fin IS NULL "
else
	new_sql =  f_montar_filtro(sql_inicial)
end if

//Fin filtros especiales

dw_datos.SetSQLSelect (new_sql)
filas = dw_datos.retrieve()

if filas > 0 then
	dw_datos.setfocus()
end if
end event

