$PBExportHeader$wtc_consulta_traspaso.srw
forward
global type wtc_consulta_traspaso from wt_consultas_padre
end type
type dw_imagen from datawindow within wtc_consulta_traspaso
end type
type cb_1 from commandbutton within wtc_consulta_traspaso
end type
end forward

global type wtc_consulta_traspaso from wt_consultas_padre
integer width = 5637
integer height = 3480
string title = "Consulta Diseño"
dw_imagen dw_imagen
cb_1 cb_1
end type
global wtc_consulta_traspaso wtc_consulta_traspaso

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

on wtc_consulta_traspaso.create
int iCurrent
call super::create
this.dw_imagen=create dw_imagen
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_imagen
this.Control[iCurrent+2]=this.cb_1
end on

on wtc_consulta_traspaso.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_imagen)
destroy(this.cb_1)
end on

event open;call super::open;dw_datos.SetTransObject(SQLCA)

sql_inicial ="  SELECT DISTINCT descoleccionsol.codigo,   "+&
"         descoleccionsol.ambiente,   "+&
"         descoleccionsol.comercial,   "+&
"         descoleccionsol.fecha_coleccion,   "+&
"         comercial.descripcion,   "+&
"         descoleccionsol.estado,   "+&
"         desmodelo.modelo,   "+&
"         desmodelo.funcion,   "+&
"         tecnico_dis.descripcion,   "+&
"         tecnico_lab.descripcion,   "+&
"         0 as seleccionado,  "+&
"			 (SELECT TOP 1 articulos.codigo FROM articulos WHERE articulos.empresa = desmodelo.empresa AND articulos.referencia_laboratorio = desmodelo.modelo ORDER BY articulos.uso DESC) as articulo,   "+&
"         (SELECT TOP 1 destrabajo2.Trabajo FROM destrabajo2 WHERE destrabajo2.empresa = desmodelo.empresa AND destrabajo2.laboratorio = 'S' AND destrabajo2.modelo = desmodelo.modelo) as laboratorio  "+&
"    FROM desmodelo LEFT OUTER JOIN tecnico_dis ON desmodelo.empresa = tecnico_dis.empresa AND desmodelo.tecnico_dis = tecnico_dis.codigo, descoleccionsol LEFT OUTER JOIN tecnico_lab ON descoleccionsol.empresa = tecnico_lab.empresa AND descoleccionsol.tecnico_lab = tecnico_lab.codigo LEFT OUTER JOIN comercial ON descoleccionsol.empresa = comercial.empresa AND descoleccionsol.comercial = comercial.codigo  "+&
"   WHERE ( desmodelo.empresa = descoleccionsol.empresa ) and  "+&
"         ( desmodelo.coleccion = descoleccionsol.codigo ) and   "+&
"         ( desmodelo.modelo_traspaso IS NULL ) and   "+&
         " ( ( descoleccionsol.empresa = '"+codigo_empresa+"' ) )  "  
end event

type pb_imprimir from wt_consultas_padre`pb_imprimir within wtc_consulta_traspaso
boolean visible = false
integer x = 4914
integer y = 120
end type

type pb_borrar from wt_consultas_padre`pb_borrar within wtc_consulta_traspaso
integer x = 5074
end type

type dw_montaje_filtro from wt_consultas_padre`dw_montaje_filtro within wtc_consulta_traspaso
integer width = 3685
integer height = 224
end type

type pb_1 from wt_consultas_padre`pb_1 within wtc_consulta_traspaso
integer x = 4626
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
	dw_imagen.height = dw_imagen.height + 75
else
	dw_datos.y = 512
	dw_datos.height = 2748
	
	dw_imagen.y = 512
	dw_imagen.height = 2748
	
	dw_montaje_filtro.height = 225
end if

dw_datos.setfocus()
end event

type pb_reset from wt_consultas_padre`pb_reset within wtc_consulta_traspaso
integer x = 5230
integer taborder = 0
end type

type pb_anyadir1 from wt_consultas_padre`pb_anyadir1 within wtc_consulta_traspaso
integer x = 4475
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
		case "Comercial Colección"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " descoleccionsol.comercial = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Comercial Colección = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR descoleccionsol.comercial = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 
		case "Fecha Colección"
			if cadena_or = '' then
				cadena_or = " descoleccionsol.fecha_coleccion "+ddlb_operador.text+" '"+em_fecha1.text+"' "
				cadena_or_visible = " Fecha colección "+ddlb_operador.text+" "+em_fecha1.text
			end if
		case "Colección"
			if cadena_or = '' then
				cadena_or = " CONVERT(integer, descoleccionsol.codigo) "+ddlb_operador.text+" "+sle_valor1.text+" "
				cadena_or_visible = " Colección "+ddlb_operador.text+" '"+sle_valor1.text+"' "
			end if
		case "Laboratorio"
			if lb_lista.state(1) = 1 then
				cadena_or = " EXISTS (SELECT destrabajo2.Trabajo FROM destrabajo2 WHERE destrabajo2.empresa = desmodelo.empresa AND destrabajo2.laboratorio = 'S' AND destrabajo2.modelo = desmodelo.modelo) "
				cadena_or_visible = " Modelos en laboratorio "
			elseif lb_lista.state(2) = 1 then
				cadena_or = " NOT EXISTS (SELECT destrabajo2.Trabajo FROM destrabajo2 WHERE destrabajo2.empresa = desmodelo.empresa AND destrabajo2.laboratorio = 'S' AND destrabajo2.modelo = desmodelo.modelo) "
				cadena_or_visible = " Modelos que NO estén en laboratorio "
			end if
		case "Producción"
			if lb_lista.state(1) = 1 then
				cadena_or = " EXISTS (SELECT articulos.codigo FROM articulos WHERE articulos.empresa = desmodelo.empresa AND articulos.referencia_laboratorio = desmodelo.modelo) "
				cadena_or_visible = " Modelos en Producción "
			elseif lb_lista.state(2) = 1 then
				cadena_or = " NOT EXISTS (SELECT articulos.codigo FROM articulos WHERE articulos.empresa = desmodelo.empresa AND articulos.referencia_laboratorio = desmodelo.modelo) "
				cadena_or_visible = " Modelos que NO estén en Producción "
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
	
	//Tamaños DW en función del número de filtros
	if dw_montaje_filtro.rowcount() > 3 and dw_montaje_filtro.rowcount() < 10 then
		
		dw_montaje_filtro.height = 75 * dw_montaje_filtro.rowcount()
		
		dw_datos.y = dw_datos.y + 75
		dw_datos.height = dw_datos.height - 75
		
		dw_imagen.y = dw_imagen.y + 75
		dw_imagen.height = dw_imagen.height - 75
		
	end if
	
	dw_datos.setfocus()
	
end if
end event

type ddlb_operador from wt_consultas_padre`ddlb_operador within wtc_consulta_traspaso
integer x = 951
integer taborder = 20
integer weight = 700
long textcolor = 23016974
boolean sorted = false
end type

type ddlb_campo from wt_consultas_padre`ddlb_campo within wtc_consulta_traspaso
integer width = 878
integer height = 904
integer taborder = 10
integer weight = 700
long textcolor = 24076881
string item[] = {"Fecha Colección","Comercial Colección","Colección","Laboratorio","Producción"}
end type

event ddlb_campo::selectionchanged;call super::selectionchanged;string consulta, new_syntax,  error_syntaxfromSQL, mensaje_error, error_create


ddlb_operador.Reset()
lb_lista.Reset()

CHOOSE CASE ddlb_campo.text
	CASE "Comercial Colección"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
		
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, descripcion as Descripción from comercial where empresa = '"+codigo_empresa+"' order by descripcion "
	CASE "Técnico Colección"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false

		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, descripcion as Descripción from tecnico_lab where empresa = '"+codigo_empresa+"' order by descripcion "
	CASE "Fecha Colección"
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
	CASE "Colección"
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
	CASE "Producción", "Laboratorio"
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

type dw_datos from wt_consultas_padre`dw_datos within wtc_consulta_traspaso
integer y = 512
integer width = 3685
integer height = 2748
integer taborder = 60
string dataobject = "dwtc_consulta_traspaso"
end type

event dw_datos::rowfocuschanged;call super::rowfocuschanged;//CON RUTAS
string codigo_archivo, codigo_coleccion, modelo, ruta
Long min_codigo_archivo

if currentrow <= 0 then
	return
end if

dw_imagen.visible = false // para evitar efectos raros en pantalla.

codigo_coleccion = dw_datos.object.descoleccionsol_codigo[dw_datos.getrow()]
modelo = dw_datos.object.desmodelo_modelo[dw_datos.getrow()]

if not isnull(codigo_coleccion) and codigo_coleccion <> "" and not isnull(modelo) and modelo <> "" then
	
	ruta = f_cargar_imagen_nuevo(modelo)
		
	if not isnull(ruta) and ruta <> "" then
		dw_imagen.Object.datawindow.picture.File = ruta
		dw_imagen.visible = true
	end if
		
end if

end event

event dw_datos::doubleclicked;call super::doubleclicked;Long id_ventana
str_parametros lstr_param 

if row > 0 then	
	
	lstr_param.s_argumentos[1] = dw_datos.GetItemString(row,"desmodelo_modelo")
	lstr_param.i_nargumentos = 1
	lstr_param.nombre_ventana = "wtc_consulta_traspaso"
	lstr_param.resultado = ''
	id_ventana = f_menu_ventana_esta_abierta("wtc_trabajos_disenyo")
	if id_ventana <> -1 then
		if MessageBox("Aviso","Ya tiene abierta una ventana de modelos de diseño, ¿Desea cerrarla para ver el modelo seleccionado?",Question!,YesNo!,2) = 1 then
			close(wtc_trabajos_disenyo)
			OpenWithParm(wtc_trabajos_disenyo, lstr_param)
		else
			ventanas_activas[id_ventana].ventana.bringtotop = true
		end if
	else
		OpenWithParm(wtc_trabajos_disenyo,lstr_param)
	end if
	
end if
end event

event dw_datos::usr_dwnkey;call super::usr_dwnkey;if key =  keyEnter! then
	this.EVENT doubleclicked(0, 0, this.getrow(), this.object.desmodelo_modelo)
end if
end event

type pb_salir from wt_consultas_padre`pb_salir within wtc_consulta_traspaso
integer x = 5385
integer taborder = 0
end type

type st_titulo from wt_consultas_padre`st_titulo within wtc_consulta_traspaso
end type

type p_logo from wt_consultas_padre`p_logo within wtc_consulta_traspaso
integer x = 5029
end type

type dw_filtro from wt_consultas_padre`dw_filtro within wtc_consulta_traspaso
integer x = 1298
integer y = 232
integer width = 1673
integer height = 260
integer taborder = 70
boolean vscrollbar = true
end type

type pb_buscar from wt_consultas_padre`pb_buscar within wtc_consulta_traspaso
integer x = 2871
integer y = 132
integer taborder = 80
end type

type sle_valor1 from wt_consultas_padre`sle_valor1 within wtc_consulta_traspaso
integer x = 1312
integer width = 398
integer height = 96
integer taborder = 30
end type

type em_fecha1 from wt_consultas_padre`em_fecha1 within wtc_consulta_traspaso
integer x = 1307
integer height = 96
integer taborder = 90
string text = ""
end type

type sle_texto from wt_consultas_padre`sle_texto within wtc_consulta_traspaso
integer x = 1312
integer y = 132
integer height = 96
integer taborder = 40
end type

type lb_lista from wt_consultas_padre`lb_lista within wtc_consulta_traspaso
integer x = 1312
integer y = 132
integer width = 462
integer height = 252
long textcolor = 24076881
end type

type dw_imagen from datawindow within wtc_consulta_traspaso
boolean visible = false
integer x = 3735
integer y = 508
integer width = 1819
integer height = 2752
integer taborder = 80
boolean bringtotop = true
string title = "none"
string dataobject = "dw_aux_imagen"
boolean border = false
boolean livescroll = true
end type

type cb_1 from commandbutton within wtc_consulta_traspaso
integer x = 3973
integer y = 316
integer width = 1367
integer height = 112
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Agrupar Artículos Seleccionados y Traspasar"
end type

event clicked;String coleccion = ""
Long i, seleccionados
dw_datos.setfilter("seleccionado = 1")
dw_datos.filter()

seleccionados = dw_datos.rowcount()
For i = 1 To seleccionados
	if coleccion = "" then
		coleccion = dw_datos.object.descoleccionsol_codigo[i]
	elseif coleccion <> dw_datos.object.descoleccionsol_codigo[i] then
		MessageBox("Error", "Debe seleccionar modelos de la misma colección para realizar su traspaso")
		dw_datos.setfilter("")
		dw_datos.filter()
		return
	end if
Next
dw_datos.setfilter("")
dw_datos.filter()
pb_anyadir1.EVENT clicked()
end event

