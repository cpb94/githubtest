$PBExportHeader$wtc_consulta_etiquetas_promo.srw
forward
global type wtc_consulta_etiquetas_promo from wt_consultas_padre
end type
type dw_etiquetas from datawindow within wtc_consulta_etiquetas_promo
end type
type cb_1 from commandbutton within wtc_consulta_etiquetas_promo
end type
type st_1 from statictext within wtc_consulta_etiquetas_promo
end type
type sle_etiquetas from singlelineedit within wtc_consulta_etiquetas_promo
end type
end forward

global type wtc_consulta_etiquetas_promo from wt_consultas_padre
integer width = 4613
integer height = 2856
string title = "Consulta de Movimientos Almacen"
dw_etiquetas dw_etiquetas
cb_1 cb_1
st_1 st_1
sle_etiquetas sle_etiquetas
end type
global wtc_consulta_etiquetas_promo wtc_consulta_etiquetas_promo

type variables
string sql_inicial, sql_final
end variables

forward prototypes
public function string f_montar_filtro (string consulta_inicial)
public function string f_consulta_inicial ()
public subroutine f_cargar_datawindow (string new_sql)
public function string f_consulta_inicial_b ()
end prototypes

public function string f_montar_filtro (string consulta_inicial);string montaje
int j


montaje = ''
for j = 1 to dw_montaje_filtro.rowcount()
	
	//Filtros mediante DW
	//if pos(dw_montaje_filtro.object.linea[j], "Existencias") = 0 then
	
		if montaje = '' then
			montaje = dw_montaje_filtro.object.filtro[j]
		else
			montaje = montaje +' AND '+ dw_montaje_filtro.object.filtro[j]
		end if
	
next
if montaje <> '' then
	montaje = consulta_inicial + " AND " + montaje + f_consulta_inicial_b() + " AND " + montaje
else
	montaje = consulta_inicial + f_consulta_inicial_b()
end if
return montaje


end function

public function string f_consulta_inicial ();string consulta


consulta = "SELECT art_escandallo.articulo_ant, articulos.descripcion, 'N', 'N' "+&
"FROM art_escandallo " +&
"INNER JOIN articulos on articulos.empresa = art_escandallo.empresa and articulos.codigo = art_escandallo.articulo_ant "+&
"WHERE art_escandallo.empresa = '"+codigo_empresa+"' " 

return consulta
end function

public subroutine f_cargar_datawindow (string new_sql);datastore registros
integer filas

dw_datos.reset()

f_cargar_cursor_nuevo (new_sql, registros)


filas = registros.rowcount()

if filas > 0 then
	dw_datos.object.data = registros.object.data
end if



destroy registros
end subroutine

public function string f_consulta_inicial_b ();string consulta

consulta = " UNION ALL "+&
"SELECT distinct articulos.codigo, articulos.descripcion, 'S', 'N' "+&
"FROM articulos "+&
"INNER JOIN art_escandallo on art_escandallo.empresa = articulos.empresa and art_escandallo.articulo = articulos.codigo "+&
"WHERE articulos.empresa = '"+codigo_empresa+"' "

return consulta
end function

on wtc_consulta_etiquetas_promo.create
int iCurrent
call super::create
this.dw_etiquetas=create dw_etiquetas
this.cb_1=create cb_1
this.st_1=create st_1
this.sle_etiquetas=create sle_etiquetas
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_etiquetas
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.sle_etiquetas
end on

on wtc_consulta_etiquetas_promo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_etiquetas)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.sle_etiquetas)
end on

event open;call super::open;dw_datos.SetTransObject(SQLCA)

dw_etiquetas.SetTransObject(SQLCA)



end event

type st_registros_padre from wt_consultas_padre`st_registros_padre within wtc_consulta_etiquetas_promo
end type

type st_total_padre from wt_consultas_padre`st_total_padre within wtc_consulta_etiquetas_promo
end type

type pb_imprimir from wt_consultas_padre`pb_imprimir within wtc_consulta_etiquetas_promo
integer x = 3899
integer taborder = 0
end type

event pb_imprimir::clicked;String new_sql
if dw_datos.rowcount() > 0 then
	f_imprimir_datawindow(dw_datos)
end if
end event

type pb_borrar from wt_consultas_padre`pb_borrar within wtc_consulta_etiquetas_promo
integer x = 4055
integer taborder = 0
end type

type dw_montaje_filtro from wt_consultas_padre`dw_montaje_filtro within wtc_consulta_etiquetas_promo
integer width = 3241
integer height = 228
integer taborder = 30
end type

type pb_1 from wt_consultas_padre`pb_1 within wtc_consulta_etiquetas_promo
integer x = 3150
integer y = 108
integer taborder = 0
end type

event pb_1::clicked;call super::clicked;string new_sql, filtro_dw
long fila, j

fila = dw_montaje_filtro.getrow()
dw_montaje_filtro.deleterow(fila)
if dw_montaje_filtro.rowcount() > 0 then
	new_sql = f_montar_filtro(sql_inicial)  + sql_final
	dw_datos.SetSQLSelect ( new_sql )
	dw_datos.retrieve()
else
	dw_datos.reset()
end if
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

type pb_reset from wt_consultas_padre`pb_reset within wtc_consulta_etiquetas_promo
integer x = 4210
integer taborder = 0
end type

type pb_anyadir1 from wt_consultas_padre`pb_anyadir1 within wtc_consulta_etiquetas_promo
integer x = 2999
integer y = 108
integer taborder = 0
end type

event pb_anyadir1::clicked;call super::clicked;int index, fila
long i, j, k, filas
string cadena_or, cadena_or_visible, descripcion_extra
string new_sql, filtro, filtro_dw
boolean crear_filtro

sql_inicial = f_consulta_inicial ()


if ddlb_campo.text <> "" or dw_montaje_filtro.rowcount() = 0 then

	index = ddlb_campo.SelectItem ( ddlb_campo.text, 0 )
	
	choose case ddlb_campo.text
		
		case "Artículo (Código)"
			if cadena_or = '' then
				descripcion_extra = ""
				SELECT descripcion INTO :descripcion_extra FROM articulos WHERE empresa = :codigo_empresa AND codigo = :sle_valor1.text;
				cadena_or = " art_escandallo.articulo "+ddlb_operador.text+" '"+sle_valor1.text+"' "
				cadena_or_visible = " Artículo "+ddlb_operador.text+" '"+sle_valor1.text+" "+descripcion_extra+"' "
			end if
		case "Articulo (Descripción)"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = "art_escandallo.articulo "+ddlb_operador.text+" '"+sle_valor1.text+"' "
						cadena_or_visible = " Articulo = "+dw_filtro.object.#1[i]+" "+dw_filtro.object.#2[i]+" "
					else
						cadena_or = " OR art_escandallo.articulo "+ddlb_operador.text+" '"+sle_valor1.text+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#1[i]//+" "+dw_filtro.object.#2[i]+" "//Demasiado largo
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
	
	f_cargar_datawindow (new_sql)
	
	filas = dw_datos.retrieve()
	
	if filas > 0 then
		dw_datos.setfocus()
	end if	
	
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
	
	f_cargar_datawindow (new_sql)
	
	filas = dw_datos.retrieve()
	
	if filas > 0 then
		dw_datos.setfocus()
	end if
	
/*	
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
	*/
end if


//Al hacer más quieren que se restablezca el orden
//orden_seleccionado = "articulos_descripcion A"
//dw_datos.setsort("integer(almacen) A, zona A, fila A, altura A")


dw_datos.sort()


end event

type ddlb_operador from wt_consultas_padre`ddlb_operador within wtc_consulta_etiquetas_promo
integer x = 951
integer taborder = 0
integer weight = 700
long textcolor = 23016974
boolean sorted = false
end type

type ddlb_campo from wt_consultas_padre`ddlb_campo within wtc_consulta_etiquetas_promo
integer width = 878
integer height = 1308
integer taborder = 0
integer weight = 700
long textcolor = 24076881
boolean sorted = false
string item[] = {"Articulo (Descripción)","Artículo (Código)"}
end type

event ddlb_campo::selectionchanged;call super::selectionchanged;string consulta, new_syntax,  error_syntaxfromSQL, mensaje_error, error_create


ddlb_operador.Reset()
lb_lista.Reset()

CHOOSE CASE ddlb_campo.text
	
	CASE "Articulo (Descripción)"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select distinct articulos.codigo as Código, CONVERT(char(60),articulos.descripcion) as Descripción "+&
						"from articulos "+&
						"where articulos.empresa = '"+codigo_empresa+" '"+&
						"and articulos.uso = '3' and articulos.fecha_anulado is null "+&
						"order by CONVERT(char(60), articulos.descripcion)"
						
	CASE  "Artículo (Código)"
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

type dw_datos from wt_consultas_padre`dw_datos within wtc_consulta_etiquetas_promo
integer y = 512
integer width = 4457
integer height = 2100
integer taborder = 40
string dataobject = "dwtc_consulta_etiquetas_promo"
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

event dw_datos::clicked;call super::clicked;
string ordenar
integer i


if dwo.name = "imprimir" then
	
	if dw_datos.object.imprimir[row] = 'N' then
		
		dw_datos.object.imprimir[row] = 'S'
		
	else
		
		dw_datos.object.imprimir[row] = 'N'
		
	end if
			

elseif dwo.name = "marcar_todos" then
	
	
	for i = 1 to dw_datos.rowcount()
	
		dw_datos.object.imprimir[i] = 'S'
		
	next
	
	
elseif dwo.name = "desmarcar_todos" then
	
	
	for i = 1 to dw_datos.rowcount()
		
		dw_datos.object.imprimir[i] = 'N'
		
	next
	

else	
	
	choose case dwo.name
			
		case "articulo_t"
			
			ordenar = "descripcion desc"

	end choose
	
	dw_datos.setsort(ordenar)
		
	dw_datos.sort()


end if


end event

type pb_salir from wt_consultas_padre`pb_salir within wtc_consulta_etiquetas_promo
integer x = 4366
integer taborder = 0
end type

type st_titulo from wt_consultas_padre`st_titulo within wtc_consulta_etiquetas_promo
end type

type p_logo from wt_consultas_padre`p_logo within wtc_consulta_etiquetas_promo
integer x = 3849
integer y = 4
end type

type dw_filtro from wt_consultas_padre`dw_filtro within wtc_consulta_etiquetas_promo
integer x = 1317
integer y = 252
integer width = 3191
integer height = 260
integer taborder = 50
boolean vscrollbar = true
end type

type pb_buscar from wt_consultas_padre`pb_buscar within wtc_consulta_etiquetas_promo
integer x = 2871
integer y = 132
integer taborder = 70
end type

type sle_valor1 from wt_consultas_padre`sle_valor1 within wtc_consulta_etiquetas_promo
integer x = 1312
integer width = 398
integer height = 96
integer taborder = 10
end type

type em_fecha1 from wt_consultas_padre`em_fecha1 within wtc_consulta_etiquetas_promo
integer x = 1307
integer height = 96
integer taborder = 80
string text = ""
end type

type sle_texto from wt_consultas_padre`sle_texto within wtc_consulta_etiquetas_promo
integer x = 1312
integer y = 132
integer height = 96
integer taborder = 20
end type

type lb_lista from wt_consultas_padre`lb_lista within wtc_consulta_etiquetas_promo
integer x = 1312
integer y = 132
integer width = 462
integer height = 356
integer taborder = 60
long textcolor = 24076881
end type

type dw_etiquetas from datawindow within wtc_consulta_etiquetas_promo
boolean visible = false
integer x = 933
integer y = 648
integer width = 2821
integer height = 1700
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "dw_etiquetas_promo"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type cb_1 from commandbutton within wtc_consulta_etiquetas_promo
integer x = 3328
integer y = 124
integer width = 549
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Imprimir etiquetas"
end type

event clicked;string articulo, ls_comando, numero_etiquetas
integer i


for i = 1 to dw_datos.rowcount()
	
	if dw_datos.object.imprimir[i] = 'S' then
		
		articulo = dw_datos.object.codigo_articulo[i]
					
		dw_etiquetas.retrieve(codigo_empresa, articulo)
		
		numero_etiquetas = sle_etiquetas.text
			
		ls_comando =" datawindow.print.copies = "+numero_etiquetas
				
		dw_etiquetas.Modify(ls_comando)
					
		dw_etiquetas.Print(TRUE)
						
		
	end if
		
next
end event

type st_1 from statictext within wtc_consulta_etiquetas_promo
integer x = 3337
integer y = 296
integer width = 539
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Número de copias"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_etiquetas from singlelineedit within wtc_consulta_etiquetas_promo
integer x = 3941
integer y = 280
integer width = 137
integer height = 100
integer taborder = 120
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 24076881
string text = "1"
borderstyle borderstyle = stylelowered!
end type

