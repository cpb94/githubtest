$PBExportHeader$wtc_mant_porcentajes_mermas.srw
forward
global type wtc_mant_porcentajes_mermas from wt_consultas_padre
end type
end forward

global type wtc_mant_porcentajes_mermas from wt_consultas_padre
integer width = 4155
integer height = 3704
string title = "Consulta Material por Ubicación"
end type
global wtc_mant_porcentajes_mermas wtc_mant_porcentajes_mermas

type variables
string sql_inicial, sql_final, orden_seleccionado
end variables

forward prototypes
public function string f_montar_filtro (string consulta_inicial)
public function string f_construir_consulta ()
public function string f_construir_group_by ()
public subroutine f_cargar_datawindow (string new_sql)
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

public function string f_construir_consulta ();string cadena
datastore ds_datos

cadena = "SELECT porcentajes_mermas.id "+&
" , porcentajes_mermas.cantidad_minima   "+&
" , porcentajes_mermas.cantidad_maxima "+&
" , porcentajes_mermas.porcentaje  "+&
" , porcentajes_mermas.porcentaje_articulo_nuevo  "+&
" , porcentajes_mermas.operacion  "+&
" , art_ver_tipooperacion.descripcion "+&
" FROM porcentajes_mermas "+&
" INNER JOIN art_ver_tipooperacion ON art_ver_tipooperacion.empresa = porcentajes_mermas.empresa AND art_ver_tipooperacion.codigo = porcentajes_mermas.operacion "+&
" WHERE porcentajes_mermas.empresa = '"+codigo_empresa+"' "


return cadena





end function

public function string f_construir_group_by ();string cadena

cadena = ""

return cadena
end function

public subroutine f_cargar_datawindow (string new_sql);datastore registros

dw_datos.reset()

f_cargar_cursor_nuevo (new_sql, registros)

if registros.rowcount() > 0 then
	dw_datos.object.data = registros.object.data
end if

destroy registros
end subroutine

on wtc_mant_porcentajes_mermas.create
call super::create
end on

on wtc_mant_porcentajes_mermas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;dw_datos.SetTransObject(SQLCA)









end event

type st_registros_padre from wt_consultas_padre`st_registros_padre within wtc_mant_porcentajes_mermas
integer x = 2880
end type

type st_total_padre from wt_consultas_padre`st_total_padre within wtc_mant_porcentajes_mermas
integer x = 3122
end type

type pb_imprimir from wt_consultas_padre`pb_imprimir within wtc_mant_porcentajes_mermas
integer x = 3333
integer y = 104
integer taborder = 0
end type

event pb_imprimir::clicked;String new_sql
if dw_datos.rowcount() > 0 then
	f_imprimir_datawindow(dw_datos)
end if
end event

type pb_borrar from wt_consultas_padre`pb_borrar within wtc_mant_porcentajes_mermas
integer x = 3488
integer y = 104
integer taborder = 0
end type

type dw_montaje_filtro from wt_consultas_padre`dw_montaje_filtro within wtc_mant_porcentajes_mermas
integer width = 3099
integer height = 224
integer taborder = 30
end type

type pb_1 from wt_consultas_padre`pb_1 within wtc_mant_porcentajes_mermas
integer x = 3182
integer y = 104
integer taborder = 0
end type

event pb_1::clicked;call super::clicked;string new_sql, filtro_dw
long fila, j



fila = dw_montaje_filtro.getrow()
dw_montaje_filtro.deleterow(fila)
if dw_montaje_filtro.rowcount() > 0 then
	new_sql = f_montar_filtro(sql_inicial)  + sql_final
	f_cargar_datawindow (new_sql)
	dw_datos.retrieve()
else
	dw_datos.reset()
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

if dw_montaje_filtro.rowcount() > 3 then
	dw_montaje_filtro.height = dw_montaje_filtro.height -75
	dw_datos.y = dw_datos.y - 75
	dw_datos.height = dw_datos.height + 75
else
	dw_datos.y = 512
	dw_datos.height = 3008
	dw_montaje_filtro.height = 225
end if

if dw_datos.rowcount() > 0 then
	dw_datos.setrow(1)
	dw_datos.Event rowfocuschanged(1)
end if
end event

type pb_reset from wt_consultas_padre`pb_reset within wtc_mant_porcentajes_mermas
integer x = 3643
integer y = 104
integer taborder = 0
end type

type pb_anyadir1 from wt_consultas_padre`pb_anyadir1 within wtc_mant_porcentajes_mermas
integer x = 3031
integer y = 104
integer taborder = 0
end type

event pb_anyadir1::clicked;call super::clicked;int index, fila
long i, j, k, filas
string cadena_or, cadena_or_visible, descripcion_extra
string new_sql, filtro, filtro_dw
boolean crear_filtro

sql_inicial = f_construir_consulta ()
sql_final = f_construir_group_by ()


if ddlb_campo.text <> "" or dw_montaje_filtro.rowcount() = 0 then

	index = ddlb_campo.SelectItem ( ddlb_campo.text, 0 )
	
	choose case ddlb_campo.text
			
		case "Operación"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " art_ver_tipooperacion.codigo = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Operación = "+dw_filtro.object.#1[i]+" "+dw_filtro.object.#2[i]+" "
					else
						cadena_or = cadena_or+" OR art_ver_tipooperacion.codigo = '"+dw_filtro.object.#1[i]+"' "
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

type ddlb_operador from wt_consultas_padre`ddlb_operador within wtc_mant_porcentajes_mermas
integer x = 951
integer taborder = 0
integer weight = 700
long textcolor = 23016974
boolean sorted = false
end type

type ddlb_campo from wt_consultas_padre`ddlb_campo within wtc_mant_porcentajes_mermas
integer width = 878
integer height = 1308
integer taborder = 0
integer weight = 700
long textcolor = 24076881
boolean sorted = false
string item[] = {"Operación"}
end type

event ddlb_campo::selectionchanged;call super::selectionchanged;string consulta, new_syntax,  error_syntaxfromSQL, mensaje_error, error_create


ddlb_operador.Reset()
lb_lista.Reset()

CHOOSE CASE ddlb_campo.text
	CASE "Operación"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, descripcion_abr as Descripción from art_ver_tipooperacion where empresa = '"+codigo_empresa+"' order by codigo ASC"

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

type dw_datos from wt_consultas_padre`dw_datos within wtc_mant_porcentajes_mermas
integer x = 69
integer y = 528
integer width = 3502
integer height = 2972
integer taborder = 40
string dataobject = "dwtc_mant_porcentajes_mermas"
end type

event dw_datos::clicked;call super::clicked;String almacen, zona, articulo, calidad, tono, tipo_pallet, caja
Int  fila, altura, calibre, fila_actual
long nueva_fila

if row = 0 then
	
	if dwo.name = "b_anyadir" then
		
		nueva_fila = this.insertrow(0)
		
		this.scrolltorow(nueva_fila)
		
		this.setcolumn(nueva_fila)
		
	else
		
		choose case dwo.name 
			
			case "operacion_t"
			
			case "minima_t"
			
			case "maxima_t"
			
			case "porcentaje_t"
			
		end choose
		
	dw_datos.setsort(orden_seleccionado)
	dw_datos.sort()
		
	end if
	

end if




end event

event dw_datos::itemchanged;call super::itemchanged;string descripcion

if dwo.name = "operacion" then
	
	select descripcion into :descripcion from art_ver_tipooperacion where codigo = :data;
	this.object.operacion_des[row] = descripcion
	
end if
end event

type pb_salir from wt_consultas_padre`pb_salir within wtc_mant_porcentajes_mermas
integer x = 3799
integer y = 104
integer taborder = 0
end type

type st_titulo from wt_consultas_padre`st_titulo within wtc_mant_porcentajes_mermas
integer width = 2798
end type

type p_logo from wt_consultas_padre`p_logo within wtc_mant_porcentajes_mermas
integer x = 3470
integer y = 4
end type

type dw_filtro from wt_consultas_padre`dw_filtro within wtc_mant_porcentajes_mermas
integer x = 1307
integer y = 240
integer width = 1742
integer height = 260
integer taborder = 50
boolean vscrollbar = true
end type

type pb_buscar from wt_consultas_padre`pb_buscar within wtc_mant_porcentajes_mermas
integer x = 2871
integer y = 132
integer taborder = 80
end type

type sle_valor1 from wt_consultas_padre`sle_valor1 within wtc_mant_porcentajes_mermas
integer x = 1312
integer width = 398
integer height = 96
integer taborder = 10
end type

type em_fecha1 from wt_consultas_padre`em_fecha1 within wtc_mant_porcentajes_mermas
integer x = 1307
integer height = 96
integer taborder = 90
string text = ""
end type

type sle_texto from wt_consultas_padre`sle_texto within wtc_mant_porcentajes_mermas
integer x = 1312
integer y = 132
integer height = 96
integer taborder = 20
end type

type lb_lista from wt_consultas_padre`lb_lista within wtc_mant_porcentajes_mermas
integer x = 1312
integer y = 132
integer width = 462
integer height = 356
long textcolor = 24076881
end type

