$PBExportHeader$wtc_consulta_clientes_agentes.srw
forward
global type wtc_consulta_clientes_agentes from wt_consultas_padre
end type
end forward

global type wtc_consulta_clientes_agentes from wt_consultas_padre
integer width = 5125
integer height = 3456
string title = "Listado de clientes por agente"
boolean resizable = false
end type
global wtc_consulta_clientes_agentes wtc_consulta_clientes_agentes

type variables
string sql_inicial
end variables

forward prototypes
public function string f_montar_filtro (string consulta_inicial)
end prototypes

public function string f_montar_filtro (string consulta_inicial);string montaje
long j, esta

montaje = ''
for j = 1 to dw_montaje_filtro.rowcount()
	
	//Filtros mediante DW
	esta = pos(dw_montaje_filtro.object.linea[j] , "Agente") + pos(dw_montaje_filtro.object.linea[j] , "País") +  pos(dw_montaje_filtro.object.linea[j] , "Cliente") + pos(dw_montaje_filtro.object.linea[j] , "múltiple")
	if esta = 0 then
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

on wtc_consulta_clientes_agentes.create
call super::create
end on

on wtc_consulta_clientes_agentes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;dw_datos.SetTransObject(SQLCA)

sql_inicial = "  SELECT "+&
"a1.agente as codigo_agente, "+&
"a1.nombre AS nombre_agente, "+&
"pa1.nombre AS pais_agente, "+&
"a1.cif AS nif_agente, "+&
"gv1.razon AS razon_cliente, "+&
"pc1.nombre AS pais_cliente, "+&
"gv1.cif AS nif_cliente, "+&
"a1.agente as codigo_subagente1, "+&
"a1.nombre AS nombre_subagente1, "+&
"as2.agente as codigo_subagente2, "+&
"as2.nombre AS nombre_subagente2, "+&
"as3.agente as codigo_subagente3, "+&
"as3.nombre AS nombre_subagente3 "+&
"FROM venagentes a1 "+&
"LEFT OUTER JOIN paises pa1 ON a1.pais = pa1.pais "+&
"INNER JOIN venclientes v1 ON a1.empresa = v1.empresa AND a1.agente = v1.agente1 "+&
"INNER JOIN genter gv1 ON v1.empresa = gv1.empresa AND v1.codigo = gv1.codigo AND gv1.tipoter = 'C' "+&
"LEFT OUTER JOIN paises pc1 ON gv1.pais = pc1.pais "+&
"LEFT JOIN venagentes as2 ON as2.empresa = v1.empresa AND as2.agente = v1.agente2 "+&
"LEFT JOIN venagentes as3 ON as3.empresa = v1.empresa AND as3.agente = v1.agente3 "+&
"UNION "+&
"SELECT "+&
"a2.agente as codigo_agente, "+&
"a2.nombre AS nombre_agente, "+&
"pa2.nombre AS pais_agente, "+&
"a2.cif AS nif_agente, "+&
"gv2.razon AS razon_cliente, "+&
"pc2.nombre AS pais_cliente, "+&
"gv2.cif AS nif_cliente, "+&
"as1.agente as codigo_subagente1, "+&
"as1.nombre AS nombre_subagente1, "+&
"a2.agente as codigo_subagente2, "+&
"a2.nombre AS nombre_subagente2, "+&
"as3.agente as codigo_subagente3, "+&
"as3.nombre AS nombre_subagente3  "+&
"FROM venagentes a2 "+&
"LEFT OUTER JOIN paises pa2 ON a2.pais = pa2.pais "+&
"INNER JOIN venclientes v2 ON a2.empresa = v2.empresa AND a2.agente = v2.agente2 "+&
"INNER JOIN genter gv2 ON v2.empresa = gv2.empresa AND v2.codigo = gv2.codigo AND gv2.tipoter = 'C' "+&
"LEFT OUTER JOIN paises pc2 ON gv2.pais = pc2.pais "+&
"LEFT JOIN venagentes as1 ON as1.empresa = v2.empresa AND as1.agente = v2.agente1 "+&
"LEFT JOIN venagentes as3 ON as3.empresa = v2.empresa AND as3.agente = v2.agente3 "+&
"UNION "+&
"SELECT "+&
"a3.agente as codigo_agente, "+&
"a3.nombre AS nombre_agente, "+&
"pa3.nombre AS pais_agente, "+&
"a3.cif AS nif_agente, "+&
"gv3.razon AS razon_cliente, "+&
"pc3.nombre AS pais_cliente, "+&
"gv3.cif AS nif_cliente, "+&
"as1.agente as codigo_subagente1, "+&
"as1.nombre AS nombre_subagente1, "+&
"as2.agente as codigo_subagente2, "+&
"as2.nombre AS nombre_subagente2, "+&
"a3.agente as codigo_subagente3, "+&
"a3.nombre AS nombre_subagente3 "+&
"FROM venagentes a3 "+&
"LEFT OUTER JOIN paises pa3 ON a3.pais = pa3.pais "+&
"INNER JOIN venclientes v3 ON a3.empresa = v3.empresa AND a3.agente = v3.agente3 "+&
"INNER JOIN genter gv3 ON v3.empresa = gv3.empresa AND v3.codigo = gv3.codigo AND gv3.tipoter = 'C' "+&
"LEFT OUTER JOIN paises pc3 ON gv3.pais = pc3.pais "+&
"LEFT JOIN venagentes as1 ON as1.empresa = v3.empresa AND as1.agente = v3.agente1 "+&
"LEFT JOIN venagentes as2 ON as2.empresa = v3.empresa AND as2.agente = v3.agente2 "

end event

type st_registros_padre from wt_consultas_padre`st_registros_padre within wtc_consulta_clientes_agentes
integer x = 2720
integer y = 20
end type

type st_total_padre from wt_consultas_padre`st_total_padre within wtc_consulta_clientes_agentes
integer x = 2962
integer y = 20
end type

type pb_imprimir from wt_consultas_padre`pb_imprimir within wtc_consulta_clientes_agentes
integer x = 4421
integer y = 120
integer taborder = 0
end type

type pb_borrar from wt_consultas_padre`pb_borrar within wtc_consulta_clientes_agentes
integer x = 4626
integer taborder = 0
end type

type dw_montaje_filtro from wt_consultas_padre`dw_montaje_filtro within wtc_consulta_clientes_agentes
integer width = 5024
integer height = 224
end type

type pb_1 from wt_consultas_padre`pb_1 within wtc_consulta_clientes_agentes
integer x = 3168
integer y = 124
integer taborder = 0
end type

event pb_1::clicked;call super::clicked;string new_sql, filtro_dw
long fila, j

fila = dw_montaje_filtro.getrow()
dw_montaje_filtro.deleterow(fila)
new_sql = f_montar_filtro(sql_inicial)
dw_datos.SetSQLSelect ( new_sql )
dw_datos.retrieve()

//Filtros mediante Datawindow
filtro_dw = "1 = 1"
For j = 1 To dw_montaje_filtro.rowcount()
	if pos(dw_montaje_filtro.object.linea[j] , "Agente") <> 0 or pos(dw_montaje_filtro.object.linea[j] , "País") <> 0 or pos(dw_montaje_filtro.object.linea[j] , "Cliente") <> 0 or pos(dw_montaje_filtro.object.linea[j] , "múltiple") <> 0 then
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
	dw_datos.height = 2328
	dw_montaje_filtro.height = 225
end if
end event

type pb_reset from wt_consultas_padre`pb_reset within wtc_consulta_clientes_agentes
integer x = 4782
integer taborder = 0
end type

type pb_anyadir1 from wt_consultas_padre`pb_anyadir1 within wtc_consulta_clientes_agentes
integer x = 3017
integer y = 124
integer taborder = 0
end type

event pb_anyadir1::clicked;call super::clicked;int index, fila
long i, j, k
string cadena_or, cadena_or_visible, filtro_dw
string new_sql, filtro
boolean crear_filtro

if ddlb_campo.text <> "" or dw_montaje_filtro.rowcount() = 0 then

	index = ddlb_campo.SelectItem ( ddlb_campo.text, 0 )
	
	choose case ddlb_campo.text	
		case "Agente"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " venagentes_codigo_agente = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Agente = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR venagentes_codigo_agente = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next
		case "País"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " paises_pais_agente = '"+dw_filtro.object.#2[i]+"' "
						cadena_or_visible = " País Agente = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR paises_pais_agente = '"+dw_filtro.object.#2[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next
		CASE "País Cliente"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " paises_pais_cliente = '"+dw_filtro.object.#2[i]+"' "
						cadena_or_visible = " País Cliente = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR paises_pais_cliente = '"+dw_filtro.object.#2[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next
		CASE "Agente múltiple"
			for k = 1 to lb_lista.totalitems()
				if lb_lista.state(k) = 1 then
					if cadena_or = '' then
						cadena_or = " mas_1_agente = '"+lb_lista.Text (k)+"' "
						cadena_or_visible = " Clientes con más de un agente = "+ lb_lista.Text (k)
					else
						cadena_or = cadena_or+" OR mas_1_agente = '"+lb_lista.Text (k)+"' "
						cadena_or_visible = cadena_or_visible+", "+lb_lista.Text (k)
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
	
	//Filtros mediante Datawindow
	filtro_dw = "1 = 1"
	For j = 1 To dw_montaje_filtro.rowcount()
		if pos(dw_montaje_filtro.object.linea[j] , "Agente") <> 0 or pos(dw_montaje_filtro.object.linea[j] , "País") <> 0 or pos(dw_montaje_filtro.object.linea[j] , "Cliente") <> 0 or pos(dw_montaje_filtro.object.linea[j] , "múltiple") <> 0 then
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
	
else
	
	new_sql = f_montar_filtro(sql_inicial)
			
	dw_datos.SetSQLSelect ( new_sql )
	dw_datos.retrieve()
	
	//Filtros mediante Datawindow
	filtro_dw = "1 = 1"
	For j = 1 To dw_montaje_filtro.rowcount()
		if pos(dw_montaje_filtro.object.linea[j] , "Agente") <> 0 or pos(dw_montaje_filtro.object.linea[j] , "País") <> 0 or pos(dw_montaje_filtro.object.linea[j] , "Cliente") <> 0 or pos(dw_montaje_filtro.object.linea[j] , "múltiple") <> 0 then
			filtro_dw = filtro_dw + " and " + dw_montaje_filtro.object.filtro[j]	
		end if
	Next
	dw_datos.setfilter(filtro_dw)		
	dw_datos.filter()
	
	dw_datos.setfocus()
end if
end event

type ddlb_operador from wt_consultas_padre`ddlb_operador within wtc_consulta_clientes_agentes
integer x = 951
integer taborder = 20
integer weight = 700
long textcolor = 23016974
boolean sorted = false
end type

type ddlb_campo from wt_consultas_padre`ddlb_campo within wtc_consulta_clientes_agentes
integer width = 878
integer height = 1308
integer taborder = 10
integer weight = 700
long textcolor = 24076881
boolean sorted = false
string item[] = {"Agente","País","País Cliente","Agente múltiple"}
end type

event ddlb_campo::selectionchanged;call super::selectionchanged;string consulta, new_syntax,  error_syntaxfromSQL, mensaje_error, error_create


ddlb_operador.Reset()
lb_lista.Reset()

CHOOSE CASE ddlb_campo.text
	CASE "Agente"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select agente as Código, nombre as Nombre from venagentes where empresa = '"+codigo_empresa+"' order by nombre ASC"
	CASE "País"	
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select pais as Código, nombre as Nombre from paises order by nombre ASC"
	CASE "País Cliente"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select pais as Código, nombre as Nombre from paises order by nombre ASC"
		
	CASE "Agente múltiple"
		dw_filtro.visible = false
		pb_buscar.visible = false
		sle_texto.visible = false
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = true
		
		lb_lista.AddItem ("Sí")
		lb_lista.AddItem ("No")
		
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

type dw_datos from wt_consultas_padre`dw_datos within wtc_consulta_clientes_agentes
integer y = 512
integer width = 5024
integer height = 2744
integer taborder = 60
string dataobject = "dwtc_consulta_clientes_agentes"
end type

event dw_datos::clicked;call super::clicked;String tipomaquina_disenyo, codigo, banda_seleccionada, revisado
Long posicion, esta_abierta
str_parametros lstr_param

//Utilizamos GetBandAtPointer(), que nos muestra la banda seleccionada y la primera fila del grupo seleccionado en un string separado por un tabulador.
banda_seleccionada = this.GetBandAtPointer()
//Separamos del string lo que es la banda de lo que es la fila, sabiendo que el tabulador las separa
posicion = Long(Mid(banda_seleccionada, LastPos(banda_seleccionada, "~t") + 1))

if dwo.name = "b_revisar" then
	if permiso_ventana > 1 then
		tipomaquina_disenyo = this.object.archivo_disenyo_tipomaquina_disenyo[posicion]
		codigo = this.object.archivo_disenyo_codigo[posicion]
		UPDATE archivo_disenyo SET revisado = 'S' WHERE empresa = :codigo_empresa AND tipomaquina_disenyo = :tipomaquina_disenyo AND codigo = :codigo USING SQLCA;
		pb_anyadir1.triggerevent(clicked!)
	end if
elseif dwo.name = "b_no_revisar" then
	if permiso_ventana > 1 then
		tipomaquina_disenyo = this.object.archivo_disenyo_tipomaquina_disenyo[posicion]
		codigo = this.object.archivo_disenyo_codigo[posicion]
		UPDATE archivo_disenyo SET revisado = 'N' WHERE empresa = :codigo_empresa AND tipomaquina_disenyo = :tipomaquina_disenyo AND codigo = :codigo USING SQLCA;
		pb_anyadir1.triggerevent(clicked!)
	end if
elseif dwo.name = "nombre" then
	tipomaquina_disenyo = this.object.archivo_disenyo_tipomaquina_disenyo[posicion]
	codigo = this.object.archivo_disenyo_codigo[posicion]
	lstr_param.s_argumentos[1] = codigo
	lstr_param.s_argumentos[2] = tipomaquina_disenyo 
	lstr_param.i_nargumentos = 2
	lstr_param.nombre_ventana = "wtc_consulta_pantallas"
	lstr_param.resultado = ''
	esta_abierta = f_menu_ventana_esta_abierta("wtc_mant_archivos_disenyo")
	if esta_abierta <> -1 then
		close(wtc_mant_archivos_disenyo)
		OpenWithParm(wtc_mant_archivos_disenyo,lstr_param)
	else
		OpenWithParm(wtc_mant_archivos_disenyo,lstr_param)
	end if
elseif dwo.name = "modelo_pieza_codigo_lab" then
	lstr_param.s_argumentos[1] = dw_datos.GetItemString(row,"modelo_pieza_codigo_lab")
	lstr_param.i_nargumentos = 1
	lstr_param.nombre_ventana = "wtc_consulta_pantallas"
	lstr_param.resultado = ''
	esta_abierta = f_menu_ventana_esta_abierta("wtc_mant_pruebas")
	if esta_abierta <> -1 then
		close(wtc_mant_pruebas)
		OpenWithParm(wtc_mant_pruebas, lstr_param)
	else
		OpenWithParm(wtc_mant_pruebas,lstr_param)
	end if
end if


end event

type pb_salir from wt_consultas_padre`pb_salir within wtc_consulta_clientes_agentes
integer x = 4937
integer taborder = 0
end type

type st_titulo from wt_consultas_padre`st_titulo within wtc_consulta_clientes_agentes
integer width = 2633
end type

type p_logo from wt_consultas_padre`p_logo within wtc_consulta_clientes_agentes
integer x = 4562
integer y = 12
end type

type dw_filtro from wt_consultas_padre`dw_filtro within wtc_consulta_clientes_agentes
integer x = 1298
integer y = 232
integer width = 1673
integer height = 260
integer taborder = 70
boolean vscrollbar = true
end type

type pb_buscar from wt_consultas_padre`pb_buscar within wtc_consulta_clientes_agentes
integer x = 2871
integer y = 132
integer taborder = 90
end type

type sle_valor1 from wt_consultas_padre`sle_valor1 within wtc_consulta_clientes_agentes
integer x = 1312
integer width = 398
integer height = 96
integer taborder = 30
end type

type em_fecha1 from wt_consultas_padre`em_fecha1 within wtc_consulta_clientes_agentes
integer x = 1307
integer height = 96
integer taborder = 110
string text = ""
end type

type sle_texto from wt_consultas_padre`sle_texto within wtc_consulta_clientes_agentes
integer x = 1312
integer y = 132
integer height = 96
integer taborder = 40
end type

type lb_lista from wt_consultas_padre`lb_lista within wtc_consulta_clientes_agentes
integer x = 1312
integer y = 132
integer width = 462
integer height = 252
integer taborder = 80
long textcolor = 24076881
end type

