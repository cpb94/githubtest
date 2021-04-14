$PBExportHeader$wtc_consulta_moldes_punzon2.srw
forward
global type wtc_consulta_moldes_punzon2 from wt_consultas_padre
end type
type st_info from statictext within wtc_consulta_moldes_punzon2
end type
type dw_aux from datawindow within wtc_consulta_moldes_punzon2
end type
type em_desde from editmask within wtc_consulta_moldes_punzon2
end type
type st_2 from statictext within wtc_consulta_moldes_punzon2
end type
type st_1 from statictext within wtc_consulta_moldes_punzon2
end type
type em_hasta from editmask within wtc_consulta_moldes_punzon2
end type
type gb_1 from groupbox within wtc_consulta_moldes_punzon2
end type
end forward

global type wtc_consulta_moldes_punzon2 from wt_consultas_padre
integer width = 4864
integer height = 3412
string title = "Consulta de Ventas por Molde y Punzón"
st_info st_info
dw_aux dw_aux
em_desde em_desde
st_2 st_2
st_1 st_1
em_hasta em_hasta
gb_1 gb_1
end type
global wtc_consulta_moldes_punzon2 wtc_consulta_moldes_punzon2

type variables
string sql_inicial, sql_final, sql_inicial_parte1, sql_inicial_parte2, sql_final_parte1, sql_final_parte2
end variables

forward prototypes
public function string f_montar_filtro (string consulta_inicial)
public function string f_montar_filtro_interior (string consulta_inicial)
end prototypes

public function string f_montar_filtro (string consulta_inicial);string montaje
int j


montaje = ''
for j = 1 to dw_montaje_filtro.rowcount()
	
	//Filtro mediante DW
	if pos(dw_montaje_filtro.object.linea[j], "Ventas") = 0 then
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

public function string f_montar_filtro_interior (string consulta_inicial);string montaje
int j


montaje = ''
for j = 1 to dw_montaje_filtro.rowcount()
	
	//Solo aplicamos filtros para el SQL dentro del group by
	if pos(dw_montaje_filtro.object.linea[j], "Fecha Facturación") > 0 then
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

on wtc_consulta_moldes_punzon2.create
int iCurrent
call super::create
this.st_info=create st_info
this.dw_aux=create dw_aux
this.em_desde=create em_desde
this.st_2=create st_2
this.st_1=create st_1
this.em_hasta=create em_hasta
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_info
this.Control[iCurrent+2]=this.dw_aux
this.Control[iCurrent+3]=this.em_desde
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.em_hasta
this.Control[iCurrent+7]=this.gb_1
end on

on wtc_consulta_moldes_punzon2.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_info)
destroy(this.dw_aux)
destroy(this.em_desde)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.em_hasta)
destroy(this.gb_1)
end on

event open;call super::open;dw_datos.SetTransObject(SQLCA)
dw_aux.SetTransObject(SQLCA)

Long anyo = Year(today())

if mod(anyo,4) = 0 and (mod(anyo, 100) <> 0 or mod(anyo, 400 ) = 0) then
	em_desde.text = string(RelativeDate(today(), - 367), "dd/mm/yyyy")
else 
	em_desde.text = string(RelativeDate(today(), - 366), "dd/mm/yyyy")
end if

em_hasta.text = string(RelativeDate(today(), - 1), "dd/mm/yyyy")

sql_inicial = "SELECT prodmoldes.codigo as molde, "+&
"prodmoldes.descripcion, "+&
"(SELECT SUM (venlifac.importe/venlifac.cambio) FROM articulos INNER JOIN venlifac ON articulos.empresa = venlifac.empresa AND articulos.codigo = venlifac.articulo WHERE articulos.uso = '3'  AND prodmoldes.codigo = articulos.molde AND CONVERT(date,venlifac.ffactura) >= '"+em_desde.text+"' AND CONVERT(date,venlifac.ffactura) <= '"+em_hasta.text+"' ) as importe "+&
"FROM prodmoldes "+&
"WHERE (SELECT SUM (venlifac.importe/venlifac.cambio) FROM articulos INNER JOIN venlifac ON articulos.empresa = venlifac.empresa AND articulos.codigo = venlifac.articulo WHERE articulos.uso = '3'  AND prodmoldes.codigo = articulos.molde AND CONVERT(date,venlifac.ffactura) >= '"+em_desde.text+"' AND CONVERT(date,venlifac.ffactura) <= '"+em_hasta.text+"') > 0 "

sql_final = ""

/*
sql_inicial = " SELECT articulos.molde as molde, articulos.plato_inf as plato, prodmoldes.descripcion, prodplatos.descripcion, SUM(venlifac.importe/venlifac.cambio) as importe "+&
"FROM articulos "+&
"INNER JOIN venlifac ON articulos.empresa = venlifac.empresa AND articulos.codigo = venlifac.articulo "+&
"INNER JOIN prodmoldes ON articulos.molde = prodmoldes.codigo "+&
"INNER JOIN prodplatos ON articulos.plato_inf = prodplatos.codigo "+&
"WHERE articulos.uso = '3' "

sql_final = "GROUP BY articulos.molde, articulos.plato_inf, prodmoldes.descripcion, prodplatos.descripcion"
*/
end event

type st_registros_padre from wt_consultas_padre`st_registros_padre within wtc_consulta_moldes_punzon2
end type

type st_total_padre from wt_consultas_padre`st_total_padre within wtc_consulta_moldes_punzon2
end type

type pb_imprimir from wt_consultas_padre`pb_imprimir within wtc_consulta_moldes_punzon2
integer x = 4096
integer y = 128
integer taborder = 0
end type

event pb_imprimir::clicked;String new_sql
if dw_datos.rowcount() > 0 then
	f_imprimir_datawindow(dw_datos)
end if
end event

type pb_borrar from wt_consultas_padre`pb_borrar within wtc_consulta_moldes_punzon2
integer x = 4251
integer y = 128
integer taborder = 0
end type

type dw_montaje_filtro from wt_consultas_padre`dw_montaje_filtro within wtc_consulta_moldes_punzon2
integer y = 396
integer width = 2985
integer height = 248
end type

type pb_1 from wt_consultas_padre`pb_1 within wtc_consulta_moldes_punzon2
integer x = 3150
integer y = 124
integer taborder = 0
end type

event pb_1::clicked;call super::clicked;string new_sql, filtro_dw
long fila, j

sql_inicial = "SELECT prodmoldes.codigo as molde, "+&
"prodmoldes.descripcion, "+&
"(SELECT SUM (venlifac.importe/venlifac.cambio) FROM articulos INNER JOIN venlifac ON articulos.empresa = venlifac.empresa AND articulos.codigo = venlifac.articulo WHERE articulos.uso = '3'  AND prodmoldes.codigo = articulos.molde AND CONVERT(date,venlifac.ffactura) >= '"+em_desde.text+"' AND CONVERT(date,venlifac.ffactura) <= '"+em_hasta.text+"' ) as importe "+&
"FROM prodmoldes "+&
"WHERE (SELECT SUM (venlifac.importe/venlifac.cambio) FROM articulos INNER JOIN venlifac ON articulos.empresa = venlifac.empresa AND articulos.codigo = venlifac.articulo WHERE articulos.uso = '3'  AND prodmoldes.codigo = articulos.molde AND CONVERT(date,venlifac.ffactura) >= '"+em_desde.text+"' AND CONVERT(date,venlifac.ffactura) <= '"+em_hasta.text+"') > 0 "

dw_aux.reset()
dw_aux.object.t_molde.text =  ""

fila = dw_montaje_filtro.getrow()
dw_montaje_filtro.deleterow(fila)

new_sql = f_montar_filtro(sql_inicial) + sql_final

dw_datos.SetSQLSelect ( new_sql )
dw_datos.retrieve()

//Filtros mediante Datawindow
filtro_dw = "1 = 1"
For j = 1 To dw_montaje_filtro.rowcount()
	if pos(dw_montaje_filtro.object.linea[j] , "Ventas") <> 0 then
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
	dw_datos.y = 664
	dw_datos.height = 2456
	dw_montaje_filtro.height = 248
end if

if dw_datos.rowcount() > 0 then
	dw_datos.setrow(1)
	dw_datos.Event rowfocuschanged(1)
end if
end event

type pb_reset from wt_consultas_padre`pb_reset within wtc_consulta_moldes_punzon2
integer x = 4407
integer y = 128
integer taborder = 0
end type

type pb_anyadir1 from wt_consultas_padre`pb_anyadir1 within wtc_consulta_moldes_punzon2
integer x = 2999
integer y = 124
integer taborder = 0
end type

event pb_anyadir1::clicked;call super::clicked;int index, fila
long i, j, k
string cadena_or, cadena_or_visible
string new_sql, filtro, filtro_dw
boolean crear_filtro

sql_inicial = "SELECT prodmoldes.codigo as molde, "+&
"prodmoldes.descripcion, "+&
"(SELECT SUM (venlifac.importe/venlifac.cambio) FROM articulos INNER JOIN venlifac ON articulos.empresa = venlifac.empresa AND articulos.codigo = venlifac.articulo WHERE articulos.uso = '3'  AND prodmoldes.codigo = articulos.molde AND CONVERT(date,venlifac.ffactura) >= '"+em_desde.text+"' AND CONVERT(date,venlifac.ffactura) <= '"+em_hasta.text+"' ) as importe "+&
"FROM prodmoldes "+&
"WHERE (SELECT SUM (venlifac.importe/venlifac.cambio) FROM articulos INNER JOIN venlifac ON articulos.empresa = venlifac.empresa AND articulos.codigo = venlifac.articulo WHERE articulos.uso = '3'  AND prodmoldes.codigo = articulos.molde AND CONVERT(date,venlifac.ffactura) >= '"+em_desde.text+"' AND CONVERT(date,venlifac.ffactura) <= '"+em_hasta.text+"') > 0 "

dw_aux.reset()
dw_aux.object.t_molde.text =  ""

if ddlb_campo.text <> "" or dw_montaje_filtro.rowcount() = 0 then

	index = ddlb_campo.SelectItem ( ddlb_campo.text, 0 )
	
	choose case ddlb_campo.text
		case "Molde"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " prodmoldes.codigo "+ddlb_operador.text+" '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Molde "+ddlb_operador.text+" "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR prodmoldes.codigo "+ddlb_operador.text+" '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 
		case "Plato"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " prodmoldes.codigo IN (SELECT articulos.molde FROM articulos WHERE articulos.plato_inf = '"+dw_filtro.object.#1[i]+"') "
						cadena_or_visible = " Plato = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR prodmoldes.codigo IN (SELECT articulos.molde FROM articulos WHERE articulos.plato_inf '"+dw_filtro.object.#1[i]+"') "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 
		case "Ventas Molde"
			if cadena_or = '' then
				cadena_or = " importe "+ddlb_operador.text+" "+sle_valor1.text+" "
				cadena_or_visible = " Ventas Molde "+ddlb_operador.text+" "+sle_valor1.text
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
			
			new_sql = f_montar_filtro(sql_inicial) + sql_final
			
			ddlb_campo.text = ''
			dw_filtro.visible = false
			dw_filtro.height = 248
		else
			new_sql = sql_inicial + sql_final
		end if
	else
		new_sql = sql_inicial + sql_final
	end if
	
	dw_datos.SetSQLSelect ( new_sql )
	dw_datos.retrieve()
	
	//Filtros mediante Datawindow
	filtro_dw = "1 = 1"
	For j = 1 To dw_montaje_filtro.rowcount()
		if pos(dw_montaje_filtro.object.linea[j] , "Ventas") <> 0 then
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
	dw_filtro.Height = 248
	
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
	
	dw_datos.SetSQLSelect ( new_sql )
	dw_datos.retrieve()
	
	//Filtros mediante Datawindow
	filtro_dw = "1 = 1"
	For j = 1 To dw_montaje_filtro.rowcount()
		if pos(dw_montaje_filtro.object.linea[j] , "Ventas") <> 0 then
			filtro_dw = filtro_dw + " and " + dw_montaje_filtro.object.filtro[j]
		end if
	Next
	dw_datos.setfilter(filtro_dw)		
	dw_datos.filter()
	dw_datos.groupcalc( )
	
	dw_datos.setfocus()
	if dw_datos.rowcount() > 0 then
		dw_datos.setrow(1)
		dw_datos.Event rowfocuschanged(1)
	end if
end if
end event

type ddlb_operador from wt_consultas_padre`ddlb_operador within wtc_consulta_moldes_punzon2
integer x = 951
integer y = 288
integer taborder = 20
integer weight = 700
long textcolor = 23016974
boolean sorted = false
end type

type ddlb_campo from wt_consultas_padre`ddlb_campo within wtc_consulta_moldes_punzon2
integer y = 288
integer width = 878
integer height = 1308
integer taborder = 10
integer weight = 700
long textcolor = 24076881
boolean sorted = false
string item[] = {"Plato","Molde","Ventas Molde"}
end type

event ddlb_campo::selectionchanged;call super::selectionchanged;string consulta, new_syntax,  error_syntaxfromSQL, mensaje_error, error_create


ddlb_operador.Reset()
lb_lista.Reset()

CHOOSE CASE ddlb_campo.text
	CASE "Molde"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.AddItem ("<>")
		
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, descripcion as Descripción from prodmoldes where empresa = '"+codigo_empresa+"' order by CONVERT(integer,codigo) ASC"
	CASE "Plato"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, descripcion as Descripción from prodplatos where empresa = '"+codigo_empresa+"' and tipo = 'Inferior' order by CONVERT(integer,codigo) ASC"
	CASE "Fecha Facturación"
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
	CASE "Ventas Molde", "Ventas Plato"
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

type dw_datos from wt_consultas_padre`dw_datos within wtc_consulta_moldes_punzon2
integer y = 664
integer width = 2450
integer height = 2456
integer taborder = 60
string dataobject = "dwtc_consulta_moldes_punzon_aux"
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

event dw_datos::rowfocuschanged;call super::rowfocuschanged;String molde, info, molde_nombre 

if currentrow > 0 then
	molde = dw_datos.object.molde[currentrow]
	molde_nombre = dw_datos.object.descripcion[currentrow]
	info = st_info.text 
	
	if not isnull(molde) and molde <> "" then
		st_info.text = "Obteniendo platos del molde y calculando ventas. Por favor, espere"
		dw_aux.retrieve(molde, em_desde.text, em_hasta.text)
		dw_aux.object.t_molde.text = molde_nombre
	else 
		dw_aux.reset()
		dw_aux.object.t_molde.text =  ""
	end if
	
	st_info.text = info
else
	dw_aux.reset()
	dw_aux.object.t_molde.text =  ""
end if
end event

type pb_salir from wt_consultas_padre`pb_salir within wtc_consulta_moldes_punzon2
integer x = 4562
integer y = 128
integer taborder = 0
end type

type st_titulo from wt_consultas_padre`st_titulo within wtc_consulta_moldes_punzon2
end type

type p_logo from wt_consultas_padre`p_logo within wtc_consulta_moldes_punzon2
integer x = 4197
integer y = 20
end type

type dw_filtro from wt_consultas_padre`dw_filtro within wtc_consulta_moldes_punzon2
integer x = 1317
integer y = 280
integer width = 1673
integer height = 260
integer taborder = 70
boolean vscrollbar = true
end type

type pb_buscar from wt_consultas_padre`pb_buscar within wtc_consulta_moldes_punzon2
integer x = 2871
integer y = 292
integer taborder = 90
end type

type sle_valor1 from wt_consultas_padre`sle_valor1 within wtc_consulta_moldes_punzon2
integer x = 1312
integer y = 280
integer width = 398
integer height = 96
integer taborder = 30
end type

type em_fecha1 from wt_consultas_padre`em_fecha1 within wtc_consulta_moldes_punzon2
integer x = 1307
integer y = 288
integer height = 96
integer taborder = 110
string text = ""
end type

type sle_texto from wt_consultas_padre`sle_texto within wtc_consulta_moldes_punzon2
integer x = 1312
integer y = 292
integer height = 96
integer taborder = 40
end type

type lb_lista from wt_consultas_padre`lb_lista within wtc_consulta_moldes_punzon2
integer x = 1312
integer y = 280
integer width = 462
integer height = 356
integer taborder = 80
long textcolor = 24076881
end type

type st_info from statictext within wtc_consulta_moldes_punzon2
integer x = 3035
integer y = 376
integer width = 1449
integer height = 204
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 23016974
long backcolor = 553648127
string text = "Haga clic en un molde para ver los punzones utilizados"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_aux from datawindow within wtc_consulta_moldes_punzon2
integer x = 2587
integer y = 656
integer width = 2135
integer height = 2468
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "dwtc_consulta_moldes_punzon3"
boolean border = false
boolean livescroll = true
end type

type em_desde from editmask within wtc_consulta_moldes_punzon2
integer x = 718
integer y = 164
integer width = 434
integer height = 80
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 24076881
long backcolor = 16777215
boolean border = false
borderstyle borderstyle = styleraised!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean dropdowncalendar = true
end type

type st_2 from statictext within wtc_consulta_moldes_punzon2
integer x = 279
integer y = 172
integer width = 270
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 23016974
long backcolor = 553648127
string text = "Desde"
boolean focusrectangle = false
end type

type st_1 from statictext within wtc_consulta_moldes_punzon2
integer x = 1271
integer y = 172
integer width = 270
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 23016974
long backcolor = 553648127
string text = "Hasta"
boolean focusrectangle = false
end type

type em_hasta from editmask within wtc_consulta_moldes_punzon2
integer x = 1554
integer y = 164
integer width = 434
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 24076881
long backcolor = 16777215
boolean border = false
borderstyle borderstyle = styleraised!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean dropdowncalendar = true
end type

type gb_1 from groupbox within wtc_consulta_moldes_punzon2
integer x = 50
integer y = 108
integer width = 2002
integer height = 160
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 23016974
long backcolor = 553648127
string text = "Fecha de Facturación"
end type

