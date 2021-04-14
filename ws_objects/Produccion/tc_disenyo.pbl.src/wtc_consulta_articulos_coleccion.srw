$PBExportHeader$wtc_consulta_articulos_coleccion.srw
forward
global type wtc_consulta_articulos_coleccion from wt_consultas_padre
end type
type cbx_expo from checkbox within wtc_consulta_articulos_coleccion
end type
type dw_imagen_mini from u_dw_imagen within wtc_consulta_articulos_coleccion
end type
type dw_imagen from u_dw_imagen within wtc_consulta_articulos_coleccion
end type
type dw_imagen_marco from datawindow within wtc_consulta_articulos_coleccion
end type
type pb_email from picturebutton within wtc_consulta_articulos_coleccion
end type
type pb_descarga from picturebutton within wtc_consulta_articulos_coleccion
end type
end forward

global type wtc_consulta_articulos_coleccion from wt_consultas_padre
integer width = 5637
integer height = 2964
string title = "Consulta Articulos Coleccion"
cbx_expo cbx_expo
dw_imagen_mini dw_imagen_mini
dw_imagen dw_imagen
dw_imagen_marco dw_imagen_marco
pb_email pb_email
pb_descarga pb_descarga
end type
global wtc_consulta_articulos_coleccion wtc_consulta_articulos_coleccion

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

on wtc_consulta_articulos_coleccion.create
int iCurrent
call super::create
this.cbx_expo=create cbx_expo
this.dw_imagen_mini=create dw_imagen_mini
this.dw_imagen=create dw_imagen
this.dw_imagen_marco=create dw_imagen_marco
this.pb_email=create pb_email
this.pb_descarga=create pb_descarga
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_expo
this.Control[iCurrent+2]=this.dw_imagen_mini
this.Control[iCurrent+3]=this.dw_imagen
this.Control[iCurrent+4]=this.dw_imagen_marco
this.Control[iCurrent+5]=this.pb_email
this.Control[iCurrent+6]=this.pb_descarga
end on

on wtc_consulta_articulos_coleccion.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cbx_expo)
destroy(this.dw_imagen_mini)
destroy(this.dw_imagen)
destroy(this.dw_imagen_marco)
destroy(this.pb_email)
destroy(this.pb_descarga)
end on

event open;call super::open;dw_datos.SetTransObject(SQLCA)

sql_inicial =  "	SELECT DISTINCT descoleccionsol.codigo,   "+&
		         "	modelo.modelo,   "+&
		         "	descoleccionsol.disenyador,   "+&
		         "	descoleccionsol.comercial,   "+&
		         "	descoleccionsol.fecha_coleccion,   "+&
		         "	descoleccionsol.tecnico_lab,   "+&
		         "	tecnico_dis.descripcion,   "+&
		         "	comercial.descripcion,   "+&
		         "	tecnico_lab.descripcion,   "+&
		         "	descoleccionsol.estado,   "+&
		         "	0 as seleccionado,   "+&
		         "	articulos.codigo,  "+&
				"	genter.razon "+&
		         "	FROM descoleccionsol LEFT OUTER JOIN tecnico_lab ON descoleccionsol.empresa = tecnico_lab.empresa AND descoleccionsol.tecnico_lab = tecnico_lab.codigo,   "+&
		         "	modelo,   "+&
		         "	tecnico_dis, "+&  
		         "	comercial,   "+&
		         "	modelo_cliente, "+&  
		         "	articulos, "+&
		         "	genter "+&
		         "	WHERE ( descoleccionsol.empresa = modelo.empresa ) and  "+&
		         "	( descoleccionsol.codigo = modelo.coleccion ) and  "+&
		         "	( descoleccionsol.empresa = tecnico_dis.empresa ) and  "+&
		         "	( descoleccionsol.disenyador = tecnico_dis.codigo ) and  "+&
		         "	( descoleccionsol.empresa = comercial.empresa ) and  "+&
		         "	( descoleccionsol.comercial = comercial.codigo ) and  "+&
 		         "	( modelo.empresa = modelo_cliente.empresa ) and  "+&
		         "	( modelo.modelo = modelo_cliente.modelo ) and  "+&
		         "	( modelo.empresa = articulos.empresa ) and  "+&
		         "	( modelo.modelo = articulos.modelo_origen ) and  "+&
				"	( articulos.empresa = genter.empresa ) and  "+&
         		"	( articulos.cliente = genter.codigo ) and  "+&
		         "	( articulos.uso = '3' ) and "+&
				"	( genter.tipoter = 'C' ) and "+&
		         "	( descoleccionsol.empresa = '"+codigo_empresa+"' )  "  
end event

type pb_imprimir from wt_consultas_padre`pb_imprimir within wtc_consulta_articulos_coleccion
integer x = 4914
integer y = 120
end type

type pb_borrar from wt_consultas_padre`pb_borrar within wtc_consulta_articulos_coleccion
integer x = 5074
end type

type dw_montaje_filtro from wt_consultas_padre`dw_montaje_filtro within wtc_consulta_articulos_coleccion
integer width = 5504
integer height = 224
end type

type pb_1 from wt_consultas_padre`pb_1 within wtc_consulta_articulos_coleccion
integer x = 4315
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
	dw_imagen_marco.y = dw_imagen_marco.y - 75
	dw_imagen_marco.height = dw_imagen_marco.height + 75
else
	dw_datos.y = 512
	dw_datos.height = 2228
	
	dw_imagen.y = 512
	dw_imagen.height = 2240
	dw_imagen_marco.y = 512
	dw_imagen_marco.height = 2240
	
	dw_montaje_filtro.height = 225
end if

dw_datos.setfocus()
if dw_datos.rowcount() > 0 then
	dw_datos.setrow(1)
	dw_datos.Event rowfocuschanged(1)
end if
end event

type pb_reset from wt_consultas_padre`pb_reset within wtc_consulta_articulos_coleccion
integer x = 5230
integer taborder = 0
end type

type pb_anyadir1 from wt_consultas_padre`pb_anyadir1 within wtc_consulta_articulos_coleccion
integer x = 4165
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
		case "Diseñador Colección"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " descoleccionsol.disenyador = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Diseñador Colección = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR descoleccionsol.disenyador = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 
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
		case "Fecha Colección"
			if cadena_or = '' then
				cadena_or = " descoleccionsol.fecha_coleccion "+ddlb_operador.text+" '"+em_fecha1.text+"' "
				cadena_or_visible = " Fecha colección "+ddlb_operador.text+" "+em_fecha1.text
			end if
		case "Colección"
			if cadena_or = '' then
				cadena_or = " descoleccionsol.codigo "+ddlb_operador.text+" '"+sle_valor1.text+"' "
				cadena_or_visible = " Colección "+ddlb_operador.text+" '"+sle_valor1.text+"' "
			end if
		case "Articulo"
			if cadena_or = '' then
				cadena_or = " descoleccionsol.codigo = (SELECT modelo.coleccion FROM modelo INNER JOIN articulos ON articulos.empresa = modelo.empresa AND articulos.modelo_origen = modelo.modelo WHERE articulos.codigo = '"+sle_valor1.text+"') "
				cadena_or_visible = " Articulos de la misma colección que el artículo "+sle_valor1.text+" "
			end if		
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
		dw_imagen_marco.y = dw_imagen_marco.y + 75
		dw_imagen_marco.height = dw_imagen_marco.height - 75
		
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

type ddlb_operador from wt_consultas_padre`ddlb_operador within wtc_consulta_articulos_coleccion
integer x = 951
integer taborder = 20
integer weight = 700
long textcolor = 23016974
boolean sorted = false
end type

type ddlb_campo from wt_consultas_padre`ddlb_campo within wtc_consulta_articulos_coleccion
integer width = 878
integer height = 904
integer taborder = 10
integer weight = 700
long textcolor = 24076881
string item[] = {"Diseñador Colección","Comercial Colección","Técnico Colección","Fecha Colección","Colección","Articulo","Cliente"}
end type

event ddlb_campo::selectionchanged;call super::selectionchanged;string consulta, new_syntax,  error_syntaxfromSQL, mensaje_error, error_create


ddlb_operador.Reset()
lb_lista.Reset()

CHOOSE CASE ddlb_campo.text
	CASE "Diseñador Colección"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false

		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, descripcion as Descripción from tecnico_dis where empresa = '"+codigo_empresa+"' order by descripcion "
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
	CASE "Cliente"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false

		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, razon as Descripción from genter where empresa = '"+codigo_empresa+"' and tipoter = 'C' order by razon "
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
	CASE "Colección", "Articulo"
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

type dw_datos from wt_consultas_padre`dw_datos within wtc_consulta_articulos_coleccion
integer y = 512
integer width = 4229
integer height = 2228
integer taborder = 60
string dataobject = "dwtc_consulta_articulos_coleccion"
end type

event dw_datos::rowfocuschanged;call super::rowfocuschanged;//CON RUTAS 
string articulo
Long min_codigo_archivo

if currentrow <= 0 then
	return
end if

articulo = dw_datos.object.articulos_codigo[dw_datos.getrow()]

if not isnull(articulo) and articulo <> "" then
		
	if cbx_expo.checked <> true then
		dw_imagen_mini.Object.datawindow.picture.File = ''		
		ftc_imagen_articulo ('5', articulo, dw_imagen_mini)
		dw_imagen_mini.visible = true
		dw_imagen.visible = false
	else
		dw_imagen.Object.datawindow.picture.File = ''		
		ftc_imagen_articulo ('2', articulo, dw_imagen_mini)
		dw_imagen.visible = true
		dw_imagen_mini.visible = false
	end if

end if
end event

event dw_datos::retrieveend;call super::retrieveend;if cbx_expo.checked = true then
	if rowcount > 22 then
		dw_datos.width = 670
	else
		dw_datos.width = 594
	end if
end if
end event

event dw_datos::doubleclicked;call super::doubleclicked;Long esta_abierta
str_parametros lstr_param 

if row > 0 then	
	lstr_param.i_nargumentos=2
	lstr_param.s_argumentos[1]="wtc_consulta_articulos_coleccion"
	lstr_param.s_argumentos[2]=String(this.object.articulos_codigo[row])
	lstr_param.nombre_ventana = "wtc_consulta_articulos_coleccion"
	lstr_param.resultado = ''
	
	esta_abierta = f_menu_ventana_esta_abierta("w_mant_articulos_tencer")
	if esta_abierta <> -1 then
		close(w_mant_articulos_tencer)
		OpenWithParm(w_mant_articulos_tencer,lstr_param)
	else
		OpenWithParm(w_mant_articulos_tencer,lstr_param)
	end if
	/*
	lstr_param.s_argumentos[1] = dw_datos.GetItemString(row,"modelo_modelo")
	lstr_param.i_nargumentos = 1
	lstr_param.nombre_ventana = "wtc_consulta_disenyo"
	lstr_param.resultado = ''
	esta_abierta = f_menu_ventana_esta_abierta("wtc_trabajos_disenyo_nuevo")
	if esta_abierta <> -1 then
		if MessageBox("Aviso","Ya tiene abierta una ventana de modelos de diseño, ¿Desea cerrarla para ver el modelo seleccionado?",Question!,YesNo!,2) = 1 then
			close(wtc_trabajos_disenyo_nuevo)
			OpenWithParm(wtc_trabajos_disenyo_nuevo, lstr_param)
		else
			ventanas_activas[id_ventana].ventana.bringtotop = true
		end if
	else
		OpenWithParm(wtc_trabajos_disenyo_nuevo,lstr_param)
	end if
	*/
end if
end event

type pb_salir from wt_consultas_padre`pb_salir within wtc_consulta_articulos_coleccion
integer x = 5385
integer taborder = 0
end type

type st_titulo from wt_consultas_padre`st_titulo within wtc_consulta_articulos_coleccion
end type

type p_logo from wt_consultas_padre`p_logo within wtc_consulta_articulos_coleccion
integer x = 5029
end type

type dw_filtro from wt_consultas_padre`dw_filtro within wtc_consulta_articulos_coleccion
integer x = 1298
integer y = 232
integer width = 1673
integer height = 260
integer taborder = 70
boolean vscrollbar = true
end type

type pb_buscar from wt_consultas_padre`pb_buscar within wtc_consulta_articulos_coleccion
integer x = 2871
integer y = 132
integer taborder = 80
end type

type sle_valor1 from wt_consultas_padre`sle_valor1 within wtc_consulta_articulos_coleccion
integer x = 1312
integer width = 398
integer height = 96
integer taborder = 30
end type

type em_fecha1 from wt_consultas_padre`em_fecha1 within wtc_consulta_articulos_coleccion
integer x = 1307
integer height = 96
integer taborder = 90
string text = ""
end type

type sle_texto from wt_consultas_padre`sle_texto within wtc_consulta_articulos_coleccion
integer x = 1312
integer y = 132
integer height = 96
integer taborder = 40
end type

type lb_lista from wt_consultas_padre`lb_lista within wtc_consulta_articulos_coleccion
integer x = 1312
integer y = 132
integer width = 462
integer height = 252
long textcolor = 24076881
end type

type cbx_expo from checkbox within wtc_consulta_articulos_coleccion
integer x = 3451
integer y = 140
integer width = 539
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
string text = "Modo Exposición"
end type

event clicked;if this.checked = true then
	pb_reset.triggerevent(clicked!)
	dw_imagen_marco.visible = true
	dw_imagen_mini.visible = false
	if dw_datos.rowcount() > 22 then
		dw_datos.width = 670
	else
		dw_datos.width = 594
	end if
	//dw_datos.width = 670
	if dw_datos.getrow() > 0 then
		dw_imagen.visible = true
		dw_datos.EVENT rowfocuschanged(dw_datos.getrow())
	end if
else
	dw_imagen.visible = false
	dw_imagen_marco.visible = false
	dw_imagen_mini.visible = true
	//dw_datos.width = 5504
	dw_datos.width = 4229
end if
dw_datos.setfocus()
end event

type dw_imagen_mini from u_dw_imagen within wtc_consulta_articulos_coleccion
integer x = 4576
integer y = 556
integer width = 800
integer height = 360
integer taborder = 80
boolean bringtotop = true
end type

type dw_imagen from u_dw_imagen within wtc_consulta_articulos_coleccion
boolean visible = false
integer x = 750
integer y = 512
integer width = 4800
integer height = 2240
integer taborder = 90
end type

type dw_imagen_marco from datawindow within wtc_consulta_articulos_coleccion
boolean visible = false
integer x = 727
integer y = 508
integer width = 4818
integer height = 2236
integer taborder = 90
string title = "none"
string dataobject = "dw_aux_imagen"
boolean border = false
boolean livescroll = true
end type

type pb_email from picturebutton within wtc_consulta_articulos_coleccion
integer x = 4759
integer y = 120
integer width = 146
integer height = 128
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\mail.png"
alignment htextalign = left!
string powertiptext = "Adjuntar imágenes seleccionadas a correo electrónico"
end type

event clicked;Long i
String codigo_coleccion, modelo, ruta, ruta_adjuntos = ""

For i = 1 To dw_datos.rowcount() 
	if dw_datos.object.seleccionado[i] = 1 then
		codigo_coleccion = dw_datos.object.descoleccionsol_codigo[i]
		modelo = dw_datos.object.modelo_modelo[i]
		if not isnull(codigo_coleccion) and codigo_coleccion <> "" and not isnull(modelo) and modelo <> "" then
			ruta = f_reemplazar(ftc_imagen_ruta('3', codigo_coleccion, modelo, ""),"\","/")
			if not isnull(ruta) and ruta <> "" then
				ruta = "file:///" + ruta 
				ruta_adjuntos = ruta_adjuntos + ruta + ","
			end if
		end if
	end if
Next
if ruta_adjuntos <> "" then
	ruta_adjuntos = mid(ruta_adjuntos, 1, len(ruta_adjuntos)-1)
	ftc_enviar_correo(ruta_adjuntos)
end if
end event

type pb_descarga from picturebutton within wtc_consulta_articulos_coleccion
integer x = 4608
integer y = 120
integer width = 146
integer height = 128
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "C:\Tencer_PB12\Download_24x24.png"
alignment htextalign = left!
string powertiptext = "Descargar Alta Resolución"
end type

event clicked;Long i, res
String codigo_coleccion, modelo, ruta, ruta_por_defecto, ruta_destino, pathname, filename, extension
ContextKeyword lcxk_base
this.GetContextService("Keyword", lcxk_base)

ruta_por_defecto = ftc_variable_entorno("HOMEDRIVE", lcxk_base) + ftc_variable_entorno("HOMEPATH", lcxk_base) + "\Desktop"
res = GetFileSaveName ("Indique una carpeta de descarga", pathname, filename, "jpg", "Imagenes jpg,*.jpg", ruta_por_defecto, 2)
if res <> 1 then
	MessageBox("Error", "No ha sido posible guardar en la ruta indicada.")
	return
end if

ruta_destino = f_reemplazar(pathname,filename,"")
For i = 1 To dw_datos.rowcount() 
	if dw_datos.object.seleccionado[i] = 1 then
		codigo_coleccion = dw_datos.object.descoleccionsol_codigo[i]
		modelo = dw_datos.object.modelo_modelo[i]
		if not isnull(codigo_coleccion) and codigo_coleccion <> "" and not isnull(modelo) and modelo <> "" then
			ruta = f_reemplazar(ftc_imagen_ruta('3', codigo_coleccion, modelo, ""),"\","/")
			extension = mid(ruta,pos(ruta,"."))
			if not isnull(ruta) and ruta <> "" then					
				res = FileCopy(ruta, ruta_destino + modelo + extension, false)
				if res = -1 then
					MessageBox("Error", "Error de lectura de la imagen del modelo "+modelo+".")
				elseif res = -2 then
					MessageBox("Error", "Error de escritura de la imagen del modelo "+modelo+".")
				end if
				
			end if
		end if
	end if
Next
run("explorer "+ruta_destino) //Muestra la carpeta
end event

