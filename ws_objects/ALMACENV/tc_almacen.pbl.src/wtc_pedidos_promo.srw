$PBExportHeader$wtc_pedidos_promo.srw
forward
global type wtc_pedidos_promo from wt_consultas_padre
end type
type st_reservado from statictext within wtc_pedidos_promo
end type
type sle_observaciones from singlelineedit within wtc_pedidos_promo
end type
type pb_grabar_obs from picturebutton within wtc_pedidos_promo
end type
type st_1 from statictext within wtc_pedidos_promo
end type
end forward

global type wtc_pedidos_promo from wt_consultas_padre
integer width = 5691
integer height = 3844
string title = "Consulta Material por Ubicación"
st_reservado st_reservado
sle_observaciones sle_observaciones
pb_grabar_obs pb_grabar_obs
st_1 st_1
end type
global wtc_pedidos_promo wtc_pedidos_promo

type variables
string sql_inicial, sql_final, orden_seleccionado
end variables

forward prototypes
public function string f_montar_filtro (string consulta_inicial)
public function string f_construir_consulta ()
public function string f_construir_group_by ()
public subroutine f_cargar_datawindow (string new_sql)
public function string f_construir_order_by ()
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
	montaje = consulta_inicial + " AND " + montaje + f_construir_group_by() + f_construir_order_by()
else
	montaje = consulta_inicial + f_construir_group_by() + f_construir_order_by()
end if

return montaje


end function

public function string f_construir_consulta ();string cadena


/*

cadena = " SELECT venliped.empresa, "+&  
      "  venliped.anyo,  "+&
      "  venliped.articulo,  "+& 
      "  venliped.calidad,   "+& 
      "  venliped.cantidad, "+& 
      "  venliped.tipo_pallet, "+&   
      "  venliped.pedido,   "+& 
      "  articulos.descripcion, "+&   
      "  calidades.abreviado,   "+& 
      "  pallets.resumido,  "+&  
      "  venliped.tonochar, "+& 
	   "  isnull(venliped.cantidad_pzs,0) as cantidad_pedido, "+& 
	   " (select sum(isnull(vista_almacen.cantidad,0)) from vista_almacen "+&
	  	" where vista_almacen.empresa = venliped.empresa and vista_almacen.articulo = venliped.articulo and vista_almacen.almacen = 6 "+&
		" and vista_almacen.tipo_ubicacion = 1) as stock "+& 
    	"	FROM venliped "+& 
		"	LEFT OUTER JOIN articulos ON venliped.empresa = articulos.empresa AND venliped.articulo = articulos.codigo "+& 
		"	LEFT OUTER JOIN calidades ON venliped.empresa = calidades.empresa AND venliped.calidad = calidades.codigo "+& 
		"	LEFT OUTER JOIN pallets ON venliped.empresa = pallets.empresa AND venliped.tipo_pallet = pallets.codigo  "+& 
      "	,unidades  "+& 
   	"	WHERE ( venliped.tipo_unidad = unidades.codigo ) and  "+& 
      "  ( venliped.empresa = '"+codigo_empresa+"' ) AND  "+&
		"	( venliped.tipolinea = '4' )  AND "+& 
		"	articulos.promocion = 'N' " 
		
*/

cadena = " SELECT venliped.anyo, venliped.pedido "+&
			" from venliped "+&
			" where venliped.empresa = '"+codigo_empresa+"' "

return cadena





end function

public function string f_construir_group_by ();string cadena



cadena = ""

return cadena
end function

public subroutine f_cargar_datawindow (string new_sql);string consulta_pedidos, articulo, zona, alm_tono, alm_calidad, filtro_datawindow, almacen
datastore registros_pedidos, registros_articulos
int i, j, pasillo, orden, fila, altura, alm_calibre, anyo_pedido
long alm_cantidad, cantidad_pedido, numero_pedido
boolean preparar


f_cargar_cursor_nuevo (new_sql, registros_pedidos)

if registros_pedidos.rowcount() > 0 then
	
		for i = 1 to registros_pedidos.rowcount()
	
			numero_pedido = registros_pedidos.object.venliped_anyo[i]
			anyo_pedido = registros_pedidos.object.venliped_pedido[i]
		
			consulta_pedidos = " SELECT venliped.empresa, "+&  
			"  venliped.anyo,  "+&
			"  venliped.articulo,  "+& 
			"  venliped.calidad,   "+& 
			"  venliped.cantidad, "+& 
			"  venliped.tipo_pallet, "+&   
			"  venliped.pedido,   "+& 
			"  articulos.descripcion, "+&   
			"  calidades.abreviado,   "+& 
			"  pallets.resumido,  "+&  
			"  venliped.tonochar, "+& 
			"  isnull(venliped.cantidad_pzs,0) as cantidad_pedido, "+& 
			" (select sum(isnull(vista_almacen.cantidad,0)) from vista_almacen "+&
			" where vista_almacen.empresa = venliped.empresa and vista_almacen.articulo = venliped.articulo and vista_almacen.almacen = 6 "+&
			" and vista_almacen.tipo_ubicacion = 1) as stock "+& 
			"	FROM venliped "+& 
			"	LEFT OUTER JOIN articulos ON venliped.empresa = articulos.empresa AND venliped.articulo = articulos.codigo "+& 
			"	LEFT OUTER JOIN calidades ON venliped.empresa = calidades.empresa AND venliped.calidad = calidades.codigo "+& 
			"	LEFT OUTER JOIN pallets ON venliped.empresa = pallets.empresa AND venliped.tipo_pallet = pallets.codigo  "+& 
			"	,unidades  "+& 
			"	WHERE ( venliped.tipo_unidad = unidades.codigo ) and  "+& 
			"  ( venliped.empresa = '"+codigo_empresa+"' ) AND  "+&
			"	articulos.promocion = 'N' "+&
			" and venliped.pedido = "+string(numero_pedido)+" and venliped.anyo = "+string(anyo_pedido)+" "
		
			f_cargar_cursor_nuevo (consulta_pedidos, registros_articulos)
			
			preparar = true
			
			if registros_articulos.rowcount() > 0 then
				
				for j = 1 to registros_articulos.rowcount()
				
					articulo = registros_pedidos.object.venliped_articulo[i]
					
					cantidad_pedido = registros_pedidos.object.cantidad_pedido[i]
					
					zona = ""
					pasillo = 0
					orden = 0
					alm_cantidad = 0
					fila = 0
					altura = 0
					alm_tono = ""
					alm_calibre = 0
					almacen = ""
					alm_calidad = ""
					
					select top 1 vista_almacen.zona,almubizonas.pasillo,almubizonas.orden, vista_almacen.cantidad, 
					
					vista_almacen.fila, vista_almacen.altura, vista_almacen.tono, vista_almacen.calibre, vista_almacen.almacen, vista_almacen.calidad
					
					into :zona, :pasillo, :orden, :alm_cantidad, :fila, :altura, :alm_tono, :alm_calibre, :almacen, :alm_calidad
					
					from vista_almacen
					
					inner join almubizonas on vista_almacen.empresa = almubizonas.empresa  
					
					and vista_almacen.zona = almubizonas.zona and vista_almacen.almacen = almubizonas.almacen
					
					where  vista_almacen.empresa = :codigo_empresa
					
					and vista_almacen.almacen = '6'
		
					and vista_almacen.tipo_ubicacion = 1
					
					and vista_almacen.articulo = :articulo 
			
					and vista_almacen.cantidad >= :cantidad_pedido
		
					order by almubizonas.pasillo asc, vista_almacen.fila desc, vista_almacen.altura asc using SQLCA;
					
					dw_datos.object.codigo_articulo [i] = registros_pedidos.object.venliped_articulo[i]
					
					dw_datos.object.descripcion [i] = registros_pedidos.object.articulos_descripcion[i]
					
					dw_datos.object.calidad[i] = registros_pedidos.object.venliped_calidad[i]
					
					dw_datos.object.tipo_palet[i] = registros_pedidos.object.pallets_resumido[i]
					
					dw_datos.object.pedido[i] = registros_pedidos.object.cantidad_pedido[i]
					
					dw_datos.object.stock[i] = registros_pedidos.object.stock[i]
					
					dw_datos.object.almacen[i] = almacen
					
					dw_datos.object.pasillo[i] = pasillo
					
					dw_datos.object.zona[i] = zona
					
					dw_datos.object.fila[i] = fila
					
					dw_datos.object.altura[i] = altura
					
					dw_datos.object.alm_tono[i] = alm_tono
					
					dw_datos.object.alm_calibre[i] = alm_calibre
					
					dw_datos.object.alm_stock[i] = alm_cantidad
					
					dw_datos.object.alm_calidad[i] = alm_calidad
					
					dw_datos.object.numero_pedido[i] = registros_pedidos.object.venliped_pedido[i]
					
					dw_datos.object.anyo_pedido[i] = registros_pedidos.object.venliped_anyo[i]
					
				next

			end if
		next
		
		filtro_datawindow = "pasillo, fila desc , altura asc"
		
		dw_datos.setsort(filtro_datawindow)
		
		dw_datos.sort()
		
	end if

destroy registros_pedidos
end subroutine

public function string f_construir_order_by ();string cadena



/*

cadena = "ORDER BY venliped.pedido ASC, "+&   
      "   venliped.anyo ASC  "	
*/

cadena = ""
		
return cadena
end function

on wtc_pedidos_promo.create
int iCurrent
call super::create
this.st_reservado=create st_reservado
this.sle_observaciones=create sle_observaciones
this.pb_grabar_obs=create pb_grabar_obs
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_reservado
this.Control[iCurrent+2]=this.sle_observaciones
this.Control[iCurrent+3]=this.pb_grabar_obs
this.Control[iCurrent+4]=this.st_1
end on

on wtc_pedidos_promo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_reservado)
destroy(this.sle_observaciones)
destroy(this.pb_grabar_obs)
destroy(this.st_1)
end on

event open;call super::open;dw_datos.SetTransObject(SQLCA)









end event

type st_registros_padre from wt_consultas_padre`st_registros_padre within wtc_pedidos_promo
end type

type st_total_padre from wt_consultas_padre`st_total_padre within wtc_pedidos_promo
end type

type pb_imprimir from wt_consultas_padre`pb_imprimir within wtc_pedidos_promo
integer x = 4681
integer y = 96
integer taborder = 0
end type

event pb_imprimir::clicked;String new_sql
if dw_datos.rowcount() > 0 then
	f_imprimir_datawindow(dw_datos)
end if
end event

type pb_borrar from wt_consultas_padre`pb_borrar within wtc_pedidos_promo
integer x = 4837
integer y = 96
integer taborder = 0
end type

type dw_montaje_filtro from wt_consultas_padre`dw_montaje_filtro within wtc_pedidos_promo
integer width = 5303
integer height = 224
integer taborder = 30
end type

type pb_1 from wt_consultas_padre`pb_1 within wtc_pedidos_promo
integer x = 3205
integer y = 112
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

type pb_reset from wt_consultas_padre`pb_reset within wtc_pedidos_promo
integer x = 4992
integer y = 96
integer taborder = 0
end type

type pb_anyadir1 from wt_consultas_padre`pb_anyadir1 within wtc_pedidos_promo
integer x = 3054
integer y = 112
integer taborder = 0
end type

event pb_anyadir1::clicked;call super::clicked;int index, fila
long i, j, k, filas
string cadena_or, cadena_or_visible, descripcion_extra
string new_sql, filtro, filtro_dw
boolean crear_filtro

sql_inicial = f_construir_consulta ()
sql_final = ""
st_reservado.text = ''

if ddlb_campo.text <> "" or dw_montaje_filtro.rowcount() = 0 then

	index = ddlb_campo.SelectItem ( ddlb_campo.text, 0 )
	
	choose case ddlb_campo.text
		case "Pedidos"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " venliped.pedido = '"+string(dw_filtro.object.#1[i])+"' and venliped.anyo = '"+string(dw_filtro.object.#2[i])+"' "
						cadena_or_visible = " Pedido "+string(dw_filtro.object.#1[i])+ " Año "+string(dw_filtro.object.#2[i])
					else
						cadena_or = cadena_or+" OR (venliped.pedido = '"+string(dw_filtro.object.#1[i])+"' and venliped.anyo = '"+string(dw_filtro.object.#2[i])+"')"
						cadena_or_visible = cadena_or_visible+", Pedido "+string(dw_filtro.object.#1[i])+ " Año "+string(dw_filtro.object.#2[i])
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

sle_observaciones.text = ''
sle_observaciones.visible = false
pb_grabar_obs.visible = false

dw_datos.sort()


end event

type ddlb_operador from wt_consultas_padre`ddlb_operador within wtc_pedidos_promo
integer x = 951
integer taborder = 0
integer weight = 700
long textcolor = 23016974
boolean sorted = false
end type

type ddlb_campo from wt_consultas_padre`ddlb_campo within wtc_pedidos_promo
integer width = 878
integer height = 1308
integer taborder = 0
integer weight = 700
long textcolor = 24076881
boolean sorted = false
string item[] = {"Pedidos"}
end type

event ddlb_campo::selectionchanged;call super::selectionchanged;string consulta, new_syntax,  error_syntaxfromSQL, mensaje_error, error_create


ddlb_operador.Reset()
lb_lista.Reset()

CHOOSE CASE ddlb_campo.text
	CASE "Pedidos"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		
		consulta = " Select distinct  venliped.pedido as Pedido, venliped.anyo as Anyo "+&
						" from venliped "+&
						" INNER JOIN  venped ON venliped.anyo = venped.anyo and venliped.pedido = venped.pedido and venliped.empresa = venped.empresa "+&
						" inner join articulos on venliped.empresa = articulos.empresa and venliped.articulo = articulos.codigo "+&
						" where  venliped.empresa = '"+codigo_empresa+"'  and  venliped.tipolinea = '4'  "+&
						" and venped.es_proforma <> 'S' "+&
						" and venliped.situacion = 'F' "+&
						" and articulos.promocion = 'N' "+&
						" order by venliped.anyo, venliped.pedido ASC "
						
										
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

type dw_datos from wt_consultas_padre`dw_datos within wtc_pedidos_promo
integer y = 512
integer width = 5527
integer height = 3076
integer taborder = 40
string dataobject = "dw_pedidos_promo"
end type

type pb_salir from wt_consultas_padre`pb_salir within wtc_pedidos_promo
integer x = 5147
integer y = 96
integer taborder = 0
end type

type st_titulo from wt_consultas_padre`st_titulo within wtc_pedidos_promo
end type

type p_logo from wt_consultas_padre`p_logo within wtc_pedidos_promo
integer x = 4777
end type

type dw_filtro from wt_consultas_padre`dw_filtro within wtc_pedidos_promo
integer x = 1307
integer y = 240
integer width = 4014
integer height = 260
integer taborder = 50
boolean vscrollbar = true
end type

type pb_buscar from wt_consultas_padre`pb_buscar within wtc_pedidos_promo
integer x = 2871
integer y = 132
integer taborder = 80
end type

type sle_valor1 from wt_consultas_padre`sle_valor1 within wtc_pedidos_promo
integer x = 1312
integer width = 398
integer height = 96
integer taborder = 10
end type

type em_fecha1 from wt_consultas_padre`em_fecha1 within wtc_pedidos_promo
integer x = 1307
integer height = 96
integer taborder = 90
string text = ""
end type

type sle_texto from wt_consultas_padre`sle_texto within wtc_pedidos_promo
integer x = 1312
integer y = 132
integer height = 96
integer taborder = 20
end type

type lb_lista from wt_consultas_padre`lb_lista within wtc_pedidos_promo
integer x = 1312
integer y = 132
integer width = 462
integer height = 356
long textcolor = 24076881
end type

type st_reservado from statictext within wtc_pedidos_promo
integer x = 3109
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

type sle_observaciones from singlelineedit within wtc_pedidos_promo
boolean visible = false
integer x = 3707
integer y = 408
integer width = 1417
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

type pb_grabar_obs from picturebutton within wtc_pedidos_promo
boolean visible = false
integer x = 5147
integer y = 396
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

type st_1 from statictext within wtc_pedidos_promo
integer x = 3776
integer y = 164
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

