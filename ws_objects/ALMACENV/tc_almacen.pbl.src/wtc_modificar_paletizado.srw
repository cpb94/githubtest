$PBExportHeader$wtc_modificar_paletizado.srw
forward
global type wtc_modificar_paletizado from wt_consultas_padre
end type
type st_1 from statictext within wtc_modificar_paletizado
end type
type uo_pallet from u_em_campo_2 within wtc_modificar_paletizado
end type
type uo_caja from u_em_campo_2 within wtc_modificar_paletizado
end type
type cb_1 from commandbutton within wtc_modificar_paletizado
end type
type cbx_planificado from checkbox within wtc_modificar_paletizado
end type
type gb_3 from groupbox within wtc_modificar_paletizado
end type
type gb_1 from groupbox within wtc_modificar_paletizado
end type
end forward

global type wtc_modificar_paletizado from wt_consultas_padre
integer width = 5865
integer height = 3736
string title = "Consulta Material por Ubicación"
st_1 st_1
uo_pallet uo_pallet
uo_caja uo_caja
cb_1 cb_1
cbx_planificado cbx_planificado
gb_3 gb_3
gb_1 gb_1
end type
global wtc_modificar_paletizado wtc_modificar_paletizado

type variables
string sql_inicial, sql_final, orden_seleccionado
end variables

forward prototypes
public function string f_montar_filtro (string consulta_inicial)
public function string f_construir_consulta ()
public function string f_construir_group_by ()
public subroutine f_cargar_datawindow (string new_sql)
public function boolean f_actualizar_paletizado (string articulo, string caja, string pallet)
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

public function string f_construir_consulta ();string cadena
datastore ds_datos

cadena = "select  articulos.codigo as articulo, articulos.descripcion as articulo_des, almcajas.descripcion as caja, pallets.descripcion as pallet,"+&
			" almcajas.codigo as cod_caja, pallets.codigo as cod_pallet ," +&
			" (select count(ot) from planificacion where planificacion.cod_articulo = articulos.codigo and planificacion.empresa = '"+codigo_empresa+"') as planificado ,"+&
			" (select sum(cantidad) from alm_bultos_lineas where alm_bultos_lineas.articulo = articulos.codigo and alm_bultos_lineas.empresa = '"+codigo_empresa+"') as stock "+&
			" from articulos "+&
			" inner join almartcajas on almartcajas.empresa = articulos.empresa and almartcajas.articulo = articulos.codigo "+&
			" inner join almcajas on almcajas.empresa = articulos.empresa and almcajas.codigo = almartcajas.caja "+&
			" inner join palarticulo on palarticulo.empresa = articulos.empresa and palarticulo.caja = almartcajas.caja and palarticulo.articulo = articulos.codigo "+&
			" inner join pallets on pallets.empresa = articulos.empresa and pallets.codigo = palarticulo.codigo "+&		
			" WHERE articulos.empresa = '"+codigo_empresa+"' "

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

public function boolean f_actualizar_paletizado (string articulo, string caja, string pallet);boolean fallo



fallo = false

update almacenmovimientos set tipo_pallet = :pallet, caja = :caja where articulo = :articulo and empresa = :codigo_empresa using SQLCA;

if SQLCA.SQLCode <> 0 then
	fallo = true
end if

update alm_bultos_lineas set caja = :caja where articulo = :articulo and empresa = :codigo_empresa using SQLCA;

if SQLCA.SQLCode <> 0 then
	fallo = true
end if

update alm_bultos set tipo_pallet = :pallet where id in (select id_alm_bultos from alm_bultos_lineas where articulo = :articulo and empresa = :codigo_empresa) and empresa = :codigo_empresa using SQLCA;

if SQLCA.SQLCode <> 0 then
	fallo = true
end if

update venliped set tipo_pallet = :pallet, caja = :caja where articulo = :articulo and empresa = :codigo_empresa using SQLCA;

if SQLCA.SQLCode <> 0 then
	fallo = true
end if

update venlialb set tipo_pallet = :pallet, caja = :caja where articulo = :articulo and empresa = :codigo_empresa using SQLCA;

if SQLCA.SQLCode <> 0 then
	fallo = true
end if

update venlifac set tipo_pallet = :pallet, caja = :caja where articulo = :articulo and empresa = :codigo_empresa using SQLCA;

if SQLCA.SQLCode <> 0 then
	fallo = true
end if

update almartcajas set caja = :caja where articulo = :articulo and empresa = :codigo_empresa using SQLCA;

if SQLCA.SQLCode <> 0 then
	fallo = true
end if

update palarticulo set caja = :caja, codigo = :pallet where articulo = :articulo and empresa = :codigo_empresa using SQLCA;

if SQLCA.SQLCode <> 0 then
	fallo = true
end if

update planificacion set cod_caja = :caja, cod_pallet = :pallet where cod_articulo = :articulo and empresa = :codigo_empresa using SQLCA;

if SQLCA.SQLCode <> 0 then
	fallo = true
end if

if fallo = false then
	commit;	
else
	rollback;
end if

return fallo
end function

on wtc_modificar_paletizado.create
int iCurrent
call super::create
this.st_1=create st_1
this.uo_pallet=create uo_pallet
this.uo_caja=create uo_caja
this.cb_1=create cb_1
this.cbx_planificado=create cbx_planificado
this.gb_3=create gb_3
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.uo_pallet
this.Control[iCurrent+3]=this.uo_caja
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.cbx_planificado
this.Control[iCurrent+6]=this.gb_3
this.Control[iCurrent+7]=this.gb_1
end on

on wtc_modificar_paletizado.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.uo_pallet)
destroy(this.uo_caja)
destroy(this.cb_1)
destroy(this.cbx_planificado)
destroy(this.gb_3)
destroy(this.gb_1)
end on

event open;call super::open;dw_datos.SetTransObject(SQLCA)







end event

type st_registros_padre from wt_consultas_padre`st_registros_padre within wtc_modificar_paletizado
integer x = 3963
integer y = 32
end type

type st_total_padre from wt_consultas_padre`st_total_padre within wtc_modificar_paletizado
integer x = 4206
integer y = 32
end type

type pb_imprimir from wt_consultas_padre`pb_imprimir within wtc_modificar_paletizado
integer x = 5179
integer width = 151
integer height = 120
integer taborder = 0
string powertiptext = "Imprimir Listado"
end type

event pb_imprimir::clicked;String new_sql
if dw_datos.rowcount() > 0 then
	f_imprimir_datawindow(dw_datos)
end if
end event

type pb_borrar from wt_consultas_padre`pb_borrar within wtc_modificar_paletizado
integer x = 5335
integer width = 151
integer height = 120
integer taborder = 0
end type

type dw_montaje_filtro from wt_consultas_padre`dw_montaje_filtro within wtc_modificar_paletizado
integer width = 4224
integer height = 224
integer taborder = 30
end type

type pb_1 from wt_consultas_padre`pb_1 within wtc_modificar_paletizado
integer x = 4846
integer y = 120
integer width = 155
integer height = 120
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

type pb_reset from wt_consultas_padre`pb_reset within wtc_modificar_paletizado
integer x = 5490
integer width = 151
integer height = 120
integer taborder = 0
end type

type pb_anyadir1 from wt_consultas_padre`pb_anyadir1 within wtc_modificar_paletizado
integer x = 4672
integer y = 120
integer width = 155
integer height = 120
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
		
		case "Artículo (Código)"
			if cadena_or = '' then
				descripcion_extra = ""
				SELECT descripcion INTO :descripcion_extra FROM articulos WHERE empresa = :codigo_empresa AND codigo = :sle_valor1.text;
				cadena_or = " articulos.codigo "+ddlb_operador.text+" '"+sle_valor1.text+"' "
				cadena_or_visible = " Artículo "+ddlb_operador.text+" '"+sle_valor1.text+" "+descripcion_extra+"' "
			end if
		case "Articulo (Descripción)"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " articulos.codigo = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Articulo = "+dw_filtro.object.#1[i]+" "+dw_filtro.object.#2[i]+" "
					else
						cadena_or = cadena_or+" OR articulos.codigo = '"+dw_filtro.object.#1[i]+"' "
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

type ddlb_operador from wt_consultas_padre`ddlb_operador within wtc_modificar_paletizado
integer x = 1280
integer y = 128
integer width = 293
integer taborder = 0
integer textsize = -14
integer weight = 700
long textcolor = 23016974
boolean sorted = false
end type

type ddlb_campo from wt_consultas_padre`ddlb_campo within wtc_modificar_paletizado
integer y = 128
integer width = 1211
integer height = 2220
integer taborder = 0
integer textsize = -14
integer weight = 700
long textcolor = 24076881
boolean sorted = false
integer limit = 1
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
		consulta = "Select articulos.codigo as Código, CONVERT(char(60),articulos.descripcion) as Descripción "+&
						"from articulos "+&
						"where articulos.empresa = '"+codigo_empresa+"' order by CONVERT(char(60), articulos.descripcion)"
						
	CASE "Artículo (Código)"
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

type dw_datos from wt_consultas_padre`dw_datos within wtc_modificar_paletizado
integer y = 512
integer width = 4357
integer height = 3008
integer taborder = 40
string dataobject = "dwtc_modificar_paletizado"
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

event dw_datos::clicked;call super::clicked;String almacen, zona, articulo, calidad, tono, tipo_pallet, caja
Int  fila, altura, calibre, fila_actual

if row = 0 then
	choose case dwo.name 
	
		case "articulo_t" 
			orden_seleccionado = "articulo_des A"
	end choose
		
	dw_datos.setsort(orden_seleccionado)
	dw_datos.sort()
end if


/*		
else
	if dwo.name = "b_editar" then

		if permiso_ventana > 1 and row > 0 then
			almacen = this.object.almacen[row]
			zona = this.object.zona[row]
			fila = this.object.fila[row]
			altura = this.object.altura[row]
			articulo = this.object.articulo[row]
			calidad = this.object.calidad[row]
			tono = this.object.tono[row]
			calibre = this.object.calibre[row]
			tipo_pallet = this.object.almacenmovimientos_tipo_pallet[row]
			caja = this.object.almacenmovimientos_caja[row]
			
			if dw_observaciones.retrieve(codigo_empresa, almacen, zona, fila, altura, articulo, calidad, tono, calibre, tipo_pallet, caja) = 0 then
				fila_actual = dw_observaciones.insertrow(0)
				if fila_actual > 0 then
					dw_observaciones.object.empresa[fila_actual] = codigo_empresa
					dw_observaciones.object.almacen[fila_actual] = almacen
					dw_observaciones.object.zona[fila_actual] = zona
					dw_observaciones.object.fila[fila_actual] = fila
					dw_observaciones.object.altura[fila_actual] = altura
					dw_observaciones.object.articulo[fila_actual] = articulo
					dw_observaciones.object.calidad[fila_actual] = calidad
					dw_observaciones.object.tono[fila_actual] = tono
					dw_observaciones.object.calibre[fila_actual] = calibre
					dw_observaciones.object.tipo_pallet[fila_actual] = tipo_pallet
					dw_observaciones.object.caja[fila_actual] = caja
				end if
			end if
			dw_observaciones.visible = true
			dw_observaciones.setfocus()
			dw_observaciones.SetColumn("observaciones")
		end if
	end if
end if
*/
end event

event dw_datos::retrieveend;call super::retrieveend;/*
string articulo
dec{3} reservado
// Provisonal

if dw_datos.rowcount() > 0 then
	articulo = dw_datos.object.articulo[1]
	
	SELECT sum (	CASE WHEN venliped.tipo_unidad = '0' 
				THEN venliped.cantidad 
				ELSE (venliped.cantidad /av.metroscaja) * av.piezascaja 
			END) 
	INTO :reservado
	FROM venliped 
	INNER JOIN venped ON venliped.empresa = venped.empresa AND venliped.anyo = venped.anyo AND venliped.pedido = venped.pedido 
	LEFT OUTER JOIN almartcajas av ON venliped.empresa = av.empresa AND venliped.articulo = av.articulo AND venliped.caja = av.caja 
	WHERE av.piezascaja <> 0 
	AND venliped.empresa = :codigo_empresa
	AND venliped.articulo = :articulo
	AND venliped.calidad = '1'
	AND venliped.situacion in ('C','P')   
	AND venped.es_proforma <> 'S';

	
	st_reservado.text = 'Reservado: '+ string(reservado, "###,###,##0.000")
end if
// Fin Provisional
*/
end event

event dw_datos::rowfocuschanged;call super::rowfocuschanged;
/*

string articulo
dec{0} reservado, total_piezas
// Provisonal

if dw_datos.rowcount() > 0 then
	articulo = dw_datos.object.articulo[currentrow]
	
	SELECT isnull (sum (	CASE WHEN venliped.tipo_unidad = '0' 
				THEN venliped.cantidad 
				ELSE (venliped.cantidad /av.metroscaja) * av.piezascaja 
			END) , 0)
	INTO :reservado
	FROM venliped 
	INNER JOIN venped ON venliped.empresa = venped.empresa AND venliped.anyo = venped.anyo AND venliped.pedido = venped.pedido 
	LEFT OUTER JOIN almartcajas av ON venliped.empresa = av.empresa AND venliped.articulo = av.articulo AND venliped.caja = av.caja 
	WHERE av.piezascaja <> 0 
	AND venliped.empresa = :codigo_empresa
	AND venliped.articulo = :articulo
	AND venliped.calidad = '1'
	AND venliped.situacion in ('C','P')   
	AND venped.es_proforma <> 'S';

	total_piezas = dec(dw_datos.object.total_piezas[1])
	
	st_reservado.text =  'Disponible :  '+ string(total_piezas - reservado, "###,###,##0")

end if

// Fin Provisional

*/
end event

type pb_salir from wt_consultas_padre`pb_salir within wtc_modificar_paletizado
integer x = 5646
integer width = 151
integer height = 120
integer taborder = 0
end type

type st_titulo from wt_consultas_padre`st_titulo within wtc_modificar_paletizado
end type

type p_logo from wt_consultas_padre`p_logo within wtc_modificar_paletizado
integer x = 5280
integer y = 16
end type

type dw_filtro from wt_consultas_padre`dw_filtro within wtc_modificar_paletizado
integer x = 1605
integer y = 240
integer width = 4247
integer height = 260
integer taborder = 50
boolean vscrollbar = true
end type

type pb_buscar from wt_consultas_padre`pb_buscar within wtc_modificar_paletizado
integer x = 2939
integer y = 112
integer width = 128
integer height = 112
integer taborder = 80
end type

type sle_valor1 from wt_consultas_padre`sle_valor1 within wtc_modificar_paletizado
integer x = 1591
integer y = 132
integer width = 421
integer height = 108
integer taborder = 10
integer textsize = -14
end type

type em_fecha1 from wt_consultas_padre`em_fecha1 within wtc_modificar_paletizado
integer x = 1605
integer height = 96
integer taborder = 90
string text = ""
end type

type sle_texto from wt_consultas_padre`sle_texto within wtc_modificar_paletizado
integer x = 1609
integer y = 132
integer width = 1321
integer height = 96
integer taborder = 20
end type

type lb_lista from wt_consultas_padre`lb_lista within wtc_modificar_paletizado
integer x = 1609
integer y = 132
integer width = 462
integer height = 356
long textcolor = 24076881
end type

type st_1 from statictext within wtc_modificar_paletizado
integer x = 3712
integer y = 152
integer width = 910
integer height = 88
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

type uo_pallet from u_em_campo_2 within wtc_modificar_paletizado
event destroy ( )
integer x = 4453
integer y = 572
integer width = 1326
integer taborder = 40
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_pallet.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_pallet.em_campo.text=f_nombre_pallet(codigo_empresa,uo_pallet.em_codigo.text)

IF Trim(uo_pallet.em_campo.text)="" THEN 
 IF Trim(uo_pallet.em_codigo.text)<>"" Then uo_pallet.em_campo.SetFocus()
 uo_pallet.em_campo.text=""
 uo_pallet.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de pallets"
ue_datawindow = "dw_ayuda_pallets"
ue_filtro     = ""

end event

type uo_caja from u_em_campo_2 within wtc_modificar_paletizado
event destroy ( )
integer x = 4453
integer y = 744
integer width = 1326
integer taborder = 50
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_caja.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_caja.em_campo.text=f_nombre_caja(codigo_empresa,uo_caja.em_codigo.text)

IF Trim(uo_caja.em_campo.text)="" THEN 
 IF Trim(uo_caja.em_codigo.text)<>"" Then uo_caja.em_campo.SetFocus()
 uo_caja.em_campo.text=""
 uo_caja.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de cajas"
ue_datawindow = "dw_ayuda_cajas"
ue_filtro     = ""

end event

type cb_1 from commandbutton within wtc_modificar_paletizado
integer x = 4741
integer y = 1036
integer width = 599
integer height = 120
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Actualizar Paletizado"
end type

event clicked;
int i
string cod_articulo, pallet, caja
boolean fallo
long planificado, stock




pallet = uo_pallet.em_codigo.text
caja = uo_caja.em_codigo.text

if Messagebox ("Aviso", "¿Seguro que desea actualizar el paletizado de los articulos seleccionados?", Exclamation!, YesNo!, 2) = 1 then
	
	if pallet = "" or caja = "" then
		
		
		messagebox("Aviso","Debes seleccionar un pallet y una caja")
		
	else
	
		
		for i = 1 to dw_datos.rowcount()
			
			cod_articulo = dw_datos.object.articulo[i]
				
			planificado = dw_datos.object.planificado[i]
			  
			stock = dw_datos.object.stock[i]
			  
			if  not( cbx_planificado.checked = false and ( stock > 0 or planificado > 0 ) ) then
		
				fallo = f_actualizar_paletizado (cod_articulo,caja,pallet)
					
				if fallo = true then
						
					messagebox("Error","Ha habido un error al actualizar el paletizado del artículo "+cod_articulo+" ", Exclamation!, Ok!,1)
						
					return			
				end if
		
			end if		
		next
		
		messagebox("Éxito","La actualización del paletizado de los artículos se ha realizado correctamente ", Exclamation!, Ok!,1)
		
		pb_anyadir1.triggerevent(clicked!)
		
				
	end if
	
	
	
end if
end event

type cbx_planificado from checkbox within wtc_modificar_paletizado
integer x = 4576
integer y = 896
integer width = 960
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Actualizar Planificado y con Stock"
end type

type gb_3 from groupbox within wtc_modificar_paletizado
integer x = 4434
integer y = 516
integer width = 1362
integer height = 156
integer taborder = 50
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Nuevo Pallet"
end type

type gb_1 from groupbox within wtc_modificar_paletizado
integer x = 4434
integer y = 688
integer width = 1362
integer height = 160
integer taborder = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Nueva CVaja"
end type

