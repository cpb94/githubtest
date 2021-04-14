$PBExportHeader$wtc_consulta_ultima_factura_por_articulo.srw
forward
global type wtc_consulta_ultima_factura_por_articulo from wt_consultas_padre
end type
type st_reservado from statictext within wtc_consulta_ultima_factura_por_articulo
end type
type sle_observaciones from singlelineedit within wtc_consulta_ultima_factura_por_articulo
end type
type pb_grabar_obs from picturebutton within wtc_consulta_ultima_factura_por_articulo
end type
type st_1 from statictext within wtc_consulta_ultima_factura_por_articulo
end type
type dw_etiquetas_bultos_100 from datawindow within wtc_consulta_ultima_factura_por_articulo
end type
end forward

global type wtc_consulta_ultima_factura_por_articulo from wt_consultas_padre
integer width = 4978
integer height = 3736
string title = "Consulta Material por Ubicación"
st_reservado st_reservado
sle_observaciones sle_observaciones
pb_grabar_obs pb_grabar_obs
st_1 st_1
dw_etiquetas_bultos_100 dw_etiquetas_bultos_100
end type
global wtc_consulta_ultima_factura_por_articulo wtc_consulta_ultima_factura_por_articulo

type variables
string sql_inicial, sql_final, orden_seleccionado

end variables

forward prototypes
public function string f_montar_filtro (string consulta_inicial)
public function string f_construir_group_by ()
public subroutine f_cargar_datawindow (string new_sql)
public function string f_construir_consulta ()
public function string f_construir_cantidad_total ()
public function string f_construir_maxima_ffactura ()
end prototypes

public function string f_montar_filtro (string consulta_inicial);string principio, filtro

string montaje_suma_cantidad, montaje_sin_fecha, montaje, filtrar
int j

filtrar = ''
for j = 1 to dw_montaje_filtro.rowcount()
	
	//Filtros mediante DW
		if filtrar = '' then
						
			filtro = mid(dw_montaje_filtro.object.filtro[j],1,8)
			
			filtro = trim(filtro)
			

			if filtro = "cliente" then
				
				montaje_suma_cantidad = "venlifac."+dw_montaje_filtro.object.filtro[j]
				
				montaje_sin_fecha = "venlifac."+dw_montaje_filtro.object.filtro[j]
				
				montaje = "v2."+dw_montaje_filtro.object.filtro[j]
				
				
				
			else
				
				montaje_suma_cantidad = "venlifac."+dw_montaje_filtro.object.filtro[j]
				//montaje = "v2."+dw_montaje_filtro.object.filtro[j]
				
				
			end if
			
		else
					
			filtro = mid(dw_montaje_filtro.object.filtro[j],1,8)
			
			filtro = trim(filtro)
			
			if filtro = "cliente" then
					
				montaje_suma_cantidad = montaje_suma_cantidad + ' AND ' +"venlifac."+dw_montaje_filtro.object.filtro[j]
				
				montaje_sin_fecha = montaje_sin_fecha + ' AND ' +"venlifac."+dw_montaje_filtro.object.filtro[j]
				
				montaje = montaje + ' AND' +"v2."+dw_montaje_filtro.object.filtro[j]
				
				
			else
				montaje_suma_cantidad = montaje_suma_cantidad + ' AND ' +"venlifac."+dw_montaje_filtro.object.filtro[j]
				//montaje = montaje + ' AND' +"v2."+dw_montaje_filtro.object.filtro[j]
				
				
				end if
				
		end if
	
next

if montaje <> '' then
	
	
	principio = " ) as cantidad_total "+&
					" from venlifac as V2  "+&
					" inner join articulos on articulos.empresa = v2.empresa and articulos.codigo = v2.articulo "+&
					" inner join unidades on v2.tipo_unidad = unidades.codigo "+&
					" where v2.articulo <> '' and v2.articulo is not null "+&
					" and articulos.promocion <> 'S' "+&
					" and articulos.fecha_anulado is null "+&
					" and v2.empresa = '"+codigo_empresa+"' " 
					
	montaje = consulta_inicial + f_construir_cantidad_total() + +" AND " + montaje_suma_cantidad + principio +  " AND " + montaje + f_construir_maxima_ffactura() + " AND " + montaje_sin_fecha + " ) " + f_construir_group_by()
	
else
	
	montaje = "select v2.articulo, articulos.descripcion as descripcion, v2.ffactura as fecha_ultima, sum(v2.cantidad) as cantidad, unidades.descripcion as tipo_unidad, "+&
				" (select sum(venlifac.cantidad) from venlifac where venlifac.articulo = v2.articulo) as cantidad_total "+&
				" from venlifac as V2 "+&
				" inner join articulos on articulos.empresa = v2.empresa and articulos.codigo = v2.articulo "+&
				" inner join unidades on unidades.codigo = v2.articulo "+&
				" where v2.articulo <> '' and v2.articulo is not null "+&
				" and articulos.promocion <> 'S' "+&
				" and articulos.fecha_anulado is null "+&
				" and v2.empresa = '"+codigo_empresa+"'"+&
				" and v2.ffactura = (select max(venlifac.ffactura) from venlifac where venlifac.articulo = v2.articulo) "+& 
				" group by v2.articulo,articulos.descripcion,v2.ffactura,unidades.descripcion"

end if


return montaje


end function

public function string f_construir_group_by ();

string cadena

cadena = ""

cadena = " GROUP BY v2.articulo,articulos.descripcion,v2.ffactura, unidades.descripcion"
/*
cadena = "GROUP BY alm_bultos.id "+&
" , genter.razon "+&
" , almubimapa_codbar.almacen "+&
" , almubimapa_codbar.zona "+&
" , almubimapa_codbar.fila "+&
" , almubimapa_codbar.altura "+&
" , alm_bultos_lineas.articulo "+&
" , articulos.descripcion "+&
" , formatos.abreviado "+&
" , genter.razon  "+&
" ,	alm_bultos_lineas.calidad "+&
" , alm_bultos_lineas.tono "+&
" , alm_bultos_lineas.calibre "+&
" , alm_bultos_lineas.caja "+&
" ,	alm_bultos.anyo_orden_carga "+&
" , alm_bultos.codigo_orden_carga "+&
" , alm_bultos.observaciones "+&
" , articulos.unidad  "+&
" , almartcajas.piezascaja "+&
" , almartcajas.metroscaja "+&
" ORDER BY almubimapa_codbar.almacen "+&
" , almubimapa_codbar.zona "+&
" , almubimapa_codbar.fila "+&
" , almubimapa_codbar.altura "

*/

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

public function string f_construir_consulta ();string cadena



cadena = " select v2.articulo, articulos.descripcion as descripcion, v2.ffactura as fecha_ultima, sum(v2.cantidad) as cantidad, unidades.descripcion as tipo_unidad, "

return cadena





end function

public function string f_construir_cantidad_total ();string cadena

cadena = "(select sum(venlifac.cantidad) from venlifac where venlifac.articulo = v2.articulo"

return cadena
end function

public function string f_construir_maxima_ffactura ();string cadena

cadena = "and v2.ffactura = (select max(venlifac.ffactura) from venlifac where venlifac.articulo = v2.articulo"

return cadena
end function

on wtc_consulta_ultima_factura_por_articulo.create
int iCurrent
call super::create
this.st_reservado=create st_reservado
this.sle_observaciones=create sle_observaciones
this.pb_grabar_obs=create pb_grabar_obs
this.st_1=create st_1
this.dw_etiquetas_bultos_100=create dw_etiquetas_bultos_100
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_reservado
this.Control[iCurrent+2]=this.sle_observaciones
this.Control[iCurrent+3]=this.pb_grabar_obs
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.dw_etiquetas_bultos_100
end on

on wtc_consulta_ultima_factura_por_articulo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_reservado)
destroy(this.sle_observaciones)
destroy(this.pb_grabar_obs)
destroy(this.st_1)
destroy(this.dw_etiquetas_bultos_100)
end on

event open;call super::open;dw_datos.SetTransObject(SQLCA)







end event

type st_registros_padre from wt_consultas_padre`st_registros_padre within wtc_consulta_ultima_factura_por_articulo
integer x = 2834
integer y = 144
end type

type st_total_padre from wt_consultas_padre`st_total_padre within wtc_consulta_ultima_factura_por_articulo
integer x = 3049
integer y = 144
end type

type pb_imprimir from wt_consultas_padre`pb_imprimir within wtc_consulta_ultima_factura_por_articulo
integer x = 4242
integer y = 112
integer height = 124
integer taborder = 0
string powertiptext = "Imprimir Listado"
end type

event pb_imprimir::clicked;String new_sql
if dw_datos.rowcount() > 0 then
	f_imprimir_datawindow(dw_datos)
end if
end event

type pb_borrar from wt_consultas_padre`pb_borrar within wtc_consulta_ultima_factura_por_articulo
integer x = 4398
integer y = 112
integer height = 124
integer taborder = 0
end type

type dw_montaje_filtro from wt_consultas_padre`dw_montaje_filtro within wtc_consulta_ultima_factura_por_articulo
integer width = 4837
integer height = 224
integer taborder = 30
end type

type pb_1 from wt_consultas_padre`pb_1 within wtc_consulta_ultima_factura_por_articulo
integer x = 3977
integer height = 124
integer taborder = 0
end type

event pb_1::clicked;call super::clicked;string new_sql, filtro_dw
long fila, j

st_reservado.text = ''

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

type pb_reset from wt_consultas_padre`pb_reset within wtc_consulta_ultima_factura_por_articulo
integer x = 4558
integer y = 112
integer height = 124
integer taborder = 0
end type

type pb_anyadir1 from wt_consultas_padre`pb_anyadir1 within wtc_consulta_ultima_factura_por_articulo
integer x = 3822
integer height = 124
integer taborder = 0
alignment htextalign = right!
end type

event pb_anyadir1::clicked;call super::clicked;int index, fila
long i, j, k, filas
string cadena_or, cadena_or_visible, descripcion_extra
string new_sql, filtro, filtro_dw
boolean crear_filtro


sql_inicial = f_construir_consulta ()
//sql_final = f_construir_group_by ()
st_reservado.text = ''

if ddlb_campo.text <> "" or dw_montaje_filtro.rowcount() = 0 then

	index = ddlb_campo.SelectItem ( ddlb_campo.text, 0 )
	
	choose case ddlb_campo.text
		
		
		case "Cliente"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " cliente = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Cliente = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR cliente = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 
		case "Periodo factura"
			if cadena_or = '' then
				cadena_or = " ffactura "+ddlb_operador.text+" '"+em_fecha1.text+"' "
				cadena_or_visible = " Fecha factura "+ddlb_operador.text+" '"+em_fecha1.text+"' "
		
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
			//cadena_or = " ( "+cadena_or+" ) "
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

sle_observaciones.text = ''
sle_observaciones.visible = false
pb_grabar_obs.visible = false

dw_datos.sort()

st_total_padre.text = string ( dw_datos.rowcount() )


end event

type ddlb_operador from wt_consultas_padre`ddlb_operador within wtc_consulta_ultima_factura_por_articulo
integer x = 1280
integer y = 128
integer width = 293
integer taborder = 0
integer textsize = -14
integer weight = 700
long textcolor = 23016974
boolean sorted = false
end type

type ddlb_campo from wt_consultas_padre`ddlb_campo within wtc_consulta_ultima_factura_por_articulo
integer x = 27
integer y = 128
integer width = 1211
integer height = 2220
integer taborder = 0
integer textsize = -14
integer weight = 700
long textcolor = 24076881
boolean sorted = false
integer limit = 1
string item[] = {"Cliente","Periodo factura"}
end type

event ddlb_campo::selectionchanged;call super::selectionchanged;string consulta, new_syntax,  error_syntaxfromSQL, mensaje_error, error_create


ddlb_operador.Reset()
lb_lista.Reset()

CHOOSE CASE ddlb_campo.text
	

		
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
	
	CASE "Periodo factura"
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

type dw_datos from wt_consultas_padre`dw_datos within wtc_consulta_ultima_factura_por_articulo
integer y = 512
integer width = 4837
integer height = 3008
integer taborder = 40
string dataobject = "dwtc_consulta_ultima_factura_por_articulo"
end type

event dw_datos::clicked;call super::clicked;
string ordenar


if dwo.name = "codigo_articulo_t" then
	
	ordenar = "codigo_articulo asc"
	
end if

if dwo.name = "descripcion_t" then
	
	ordenar = "descripcion asc"
	
end if

if dwo.name = "fecha_ultima_t" then
	
	ordenar = "fecha_ultima asc"
	
end if


if dwo.name = "cantidad_t" then
	
	ordenar = "cantidad desc"
	
end if

if dwo.name = "cantidad_total" then
	
	ordenar = "total desc"
	
end if

	
dw_datos.setsort(ordenar)	
dw_datos.sort()
end event

type pb_salir from wt_consultas_padre`pb_salir within wtc_consulta_ultima_factura_por_articulo
integer x = 4718
integer y = 112
integer height = 124
integer taborder = 0
end type

type st_titulo from wt_consultas_padre`st_titulo within wtc_consulta_ultima_factura_por_articulo
end type

type p_logo from wt_consultas_padre`p_logo within wtc_consulta_ultima_factura_por_articulo
integer x = 4407
end type

type dw_filtro from wt_consultas_padre`dw_filtro within wtc_consulta_ultima_factura_por_articulo
integer x = 1605
integer y = 240
integer width = 4247
integer height = 260
integer taborder = 50
boolean vscrollbar = true
end type

type pb_buscar from wt_consultas_padre`pb_buscar within wtc_consulta_ultima_factura_por_articulo
integer x = 2939
integer y = 112
integer width = 128
integer height = 112
integer taborder = 80
end type

type sle_valor1 from wt_consultas_padre`sle_valor1 within wtc_consulta_ultima_factura_por_articulo
integer x = 1591
integer y = 132
integer width = 421
integer height = 108
integer taborder = 10
integer textsize = -14
end type

type em_fecha1 from wt_consultas_padre`em_fecha1 within wtc_consulta_ultima_factura_por_articulo
integer x = 1605
integer height = 96
integer taborder = 90
string text = ""
end type

type sle_texto from wt_consultas_padre`sle_texto within wtc_consulta_ultima_factura_por_articulo
integer x = 1609
integer y = 132
integer width = 1321
integer height = 96
integer taborder = 20
end type

type lb_lista from wt_consultas_padre`lb_lista within wtc_consulta_ultima_factura_por_articulo
integer x = 1609
integer y = 132
integer width = 462
integer height = 356
long textcolor = 24076881
end type

type st_reservado from statictext within wtc_consulta_ultima_factura_por_articulo
integer x = 3406
integer y = 356
integer width = 1006
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 67108864
boolean focusrectangle = false
end type

type sle_observaciones from singlelineedit within wtc_consulta_ultima_factura_por_articulo
boolean visible = false
integer x = 3707
integer y = 408
integer width = 2450
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
textcase textcase = upper!
end type

type pb_grabar_obs from picturebutton within wtc_consulta_ultima_factura_por_articulo
boolean visible = false
integer x = 6167
integer y = 400
integer width = 110
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "Save!"
alignment htextalign = left!
end type

event clicked;long id


id = dw_datos.object.id_alm_bultos[dw_datos.GetRow()]

update alm_bultos
set observaciones = :sle_observaciones.text
where id = :id using SQLCA;

IF SQLCA.SQLCode = -1 	THEN   
	MessageBox("SQL error " + String(SQLCA.SQLDBCode),  SQLCA.SQLErrText )
	rollback using SQLCA;
ELSE
	commit using SQLCA;
	dw_datos.object.observaciones[dw_datos.GetRow()] = sle_observaciones.text
END IF


sle_observaciones.text = ''
sle_observaciones.visible = false
pb_grabar_obs.visible = false

end event

type st_1 from statictext within wtc_consulta_ultima_factura_por_articulo
integer x = 3424
integer y = 28
integer width = 910
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type dw_etiquetas_bultos_100 from datawindow within wtc_consulta_ultima_factura_por_articulo
boolean visible = false
integer x = 4334
integer y = 1136
integer width = 567
integer height = 756
integer taborder = 51
boolean bringtotop = true
string title = "none"
string dataobject = "dw_etiquetas_bultos_ubicaciones_100x60"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

