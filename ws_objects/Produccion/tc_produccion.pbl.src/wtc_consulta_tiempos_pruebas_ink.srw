$PBExportHeader$wtc_consulta_tiempos_pruebas_ink.srw
forward
global type wtc_consulta_tiempos_pruebas_ink from wt_consultas_padre
end type
end forward

global type wtc_consulta_tiempos_pruebas_ink from wt_consultas_padre
integer width = 4137
integer height = 3480
string title = "Tiempos de Pruebas en INK"
end type
global wtc_consulta_tiempos_pruebas_ink wtc_consulta_tiempos_pruebas_ink

type variables
string sql_inicial
string sql_inicial2



string sql_select
string sql_subc1
string sql_subc2
string sql_from_where
string sql_group_order
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

on wtc_consulta_tiempos_pruebas_ink.create
call super::create
end on

on wtc_consulta_tiempos_pruebas_ink.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;dw_datos.SetTransObject(SQLCA)

sql_inicial = 	" select prodpartes_ot.empresa, prodlineas.codigo, prodlineas.descripcion, prodpartes_ot.segundos, prodpartes_ot.articulo "+&
					" from prodpartes_ot, prodlineas "+&
					" where prodpartes_ot.empresa = prodlineas.empresa "+&
					" and	prodpartes_ot.linea = prodlineas.codigo "+&
					" and	prodpartes_ot.fecha >= '01-03-2013' " 

/*
sql_select = 		" SELECT   A.empresa, "+&
		 						 	" A.linea, "+&
									" prodlineas.resumido, "
								

sql_subc1 = 	  	" ( select sum ( B.segundos / 60 ) "+&
						" from prodpartes_ot B "+&
						" where b.linea = a.linea "+&
						" and b.empresa = a.empresa "+&
						" and b.articulo = '44906'  "


sql_subc2 = 		" ) as min_PRUEBAS, ( select sum ( B.segundos / 60 ) "+&
						" from prodpartes_ot B "+&
						" where b.linea = a.linea "+&
						" and b.empresa = a.empresa "+&
						" and b.articulo <> '44906' ) as min_PRODUCCION "

sql_from_where = 	" FROM 	  prodpartes_ot A,   "+&
      				" prodlineas  "+&
						" WHERE ( A.empresa = prodlineas.empresa ) and  "+&
         			" ( A.linea = prodlineas.codigo ) "
					
					
sql_group_order =	" GROUP BY A.empresa, "+&
						" A.linea, "+&
						" prodlineas.resumido "+&
						" ORDER BY PRODLINEAS.resumido "
					
sql_inicial =  sql_select + sql_subc1 + sql_subc2 + sql_from_where + sql_group_order

*/
/*		
sql_inicial = 	" SELECT A.empresa, "+&
		 				" A.linea, "+&
	         		" prodlineas.resumido, "+&  
   	      		" ( select sum ( B.segundos / 60 ) "+&
							" from prodpartes_ot B "+&
							" where b.linea = a.linea "+&
							" and b.empresa = a.empresa "+&
							" and b.articulo = '44906' ) as min_PRUEBAS, "+&
		 				" ( select sum ( B.segundos / 60 ) "+&
							" from prodpartes_ot B "+&
							" where b.linea = a.linea "+&
							" and b.empresa = a.empresa "+&
							" and b.articulo <> '44906' ) as min_PRODUCCION "+&
    				" FROM prodpartes_ot A,   "+&
      			" prodlineas  "+&
					" WHERE ( A.empresa = prodlineas.empresa ) and  "+&
         		" ( A.linea = prodlineas.codigo ) "

sql_inicial2 =	" GROUP BY A.empresa, "+&
					" A.linea, "+&
					" prodlineas.resumido "+&
					" ORDER BY PRODLINEAS.resumido "

*/
end event

type pb_imprimir from wt_consultas_padre`pb_imprimir within wtc_consulta_tiempos_pruebas_ink
integer x = 3447
integer y = 120
end type

type pb_borrar from wt_consultas_padre`pb_borrar within wtc_consulta_tiempos_pruebas_ink
integer x = 3607
end type

type dw_montaje_filtro from wt_consultas_padre`dw_montaje_filtro within wtc_consulta_tiempos_pruebas_ink
integer width = 4018
integer height = 224
end type

type pb_1 from wt_consultas_padre`pb_1 within wtc_consulta_tiempos_pruebas_ink
integer x = 3159
integer taborder = 0
end type

event pb_1::clicked;call super::clicked;string new_sql
long fila

fila = dw_montaje_filtro.getrow()
dw_montaje_filtro.deleterow(fila)
new_sql = f_montar_filtro(sql_inicial) + sql_inicial2
dw_datos.SetSQLSelect ( new_sql )
dw_datos.retrieve()

if dw_montaje_filtro.rowcount() > 3 then
	dw_montaje_filtro.height = dw_montaje_filtro.height -75
	dw_datos.y = dw_datos.y - 75
	dw_datos.height = dw_datos.height + 75
else
	dw_datos.y = 512
//	dw_datos.height = 1788
	dw_montaje_filtro.height = 225
end if

dw_datos.setfocus()
if dw_datos.rowcount() > 0 then
	dw_datos.setrow(1)
	dw_datos.Event rowfocuschanged(1)
end if
end event

type pb_reset from wt_consultas_padre`pb_reset within wtc_consulta_tiempos_pruebas_ink
integer x = 3762
integer taborder = 0
end type

type pb_anyadir1 from wt_consultas_padre`pb_anyadir1 within wtc_consulta_tiempos_pruebas_ink
integer x = 3008
integer taborder = 0
end type

event pb_anyadir1::clicked;call super::clicked;int index, fila
long i, j, k, dias
string cadena_or, cadena_or_visible, cadena_in, cadena_in2, cadena_visible
string new_sql, filtro
boolean crear_filtro

if ddlb_campo.text <> "" or dw_montaje_filtro.rowcount() = 0 then

	index = ddlb_campo.SelectItem ( ddlb_campo.text, 0 )
	
	choose case ddlb_campo.text
		case "Sección"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " prodlineas.seccion = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Sección = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR prodlineas.seccion = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
					
				end if
			next 
			cadena_in = " prodlineas.seccion in ( "+cadena_in+") "
			cadena_in2 = " prodlineas.seccion in ( "+cadena_in+") "

		case "Fecha"
			if cadena_or = '' then
				cadena_or = " prodpartes_ot.fecha "+ddlb_operador.text+" '"+em_fecha1.text+"' "
				cadena_or_visible = " Fecha "+ddlb_operador.text+" "+em_fecha1.text
			end if
		
		case "Semanas"
			if cadena_or = '' then
				cadena_or = " prodpartes_ot.fecha "+ddlb_operador.text+" '"+string(RelativeDate (today() , -7 * integer (sle_valor1.text) ))+"' "
				cadena_or_visible = " Fecha "+ddlb_operador.text+" "+string(RelativeDate (today() , -7 * integer (sle_valor1.text) ))
			END IF	
	
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
			
			new_sql = f_montar_filtro(sql_inicial) + sql_inicial2
			
			ddlb_campo.text = ''
			dw_filtro.visible = false
			dw_filtro.height = 137
		end if
	else
		new_sql = sql_inicial 
	end if
	
	dw_datos.SetSQLSelect ( new_sql)
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

type ddlb_operador from wt_consultas_padre`ddlb_operador within wtc_consulta_tiempos_pruebas_ink
integer x = 951
integer taborder = 20
integer weight = 700
long textcolor = 23016974
boolean sorted = false
end type

type ddlb_campo from wt_consultas_padre`ddlb_campo within wtc_consulta_tiempos_pruebas_ink
integer width = 878
integer height = 904
integer taborder = 10
integer weight = 700
long textcolor = 24076881
boolean sorted = false
string item[] = {"Sección","Fecha","Semanas"}
end type

event ddlb_campo::selectionchanged;call super::selectionchanged;string consulta, new_syntax,  error_syntaxfromSQL, mensaje_error, error_create


ddlb_operador.Reset()
lb_lista.Reset()

CHOOSE CASE ddlb_campo.text
	CASE "Sección"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
		
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "Select codigo as Código, descripcion_abr as Descripción from prodsecciones where empresa = '"+codigo_empresa+"' "
	
	CASE "Fecha"
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
		ddlb_operador.text = ">="
		
	CASE "Semanas"
		dw_filtro.visible = false
		pb_buscar.visible = false
		sle_texto.visible = false
		em_fecha1.visible = false
		sle_valor1.visible = true
		lb_lista.visible = false
		
		ddlb_operador.AddItem (">")
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

type dw_datos from wt_consultas_padre`dw_datos within wtc_consulta_tiempos_pruebas_ink
integer y = 512
integer width = 4018
integer height = 2748
integer taborder = 60
string dataobject = "dwtc_consulta_tiempos_pruebas_ink"
end type

event dw_datos::doubleclicked;call super::doubleclicked;Long id_ventana
str_parametros lstr_param 

if row > 0 then	
	
	lstr_param.s_argumentos[1] = dw_datos.GetItemString(row,"modelo_trabajo_modelo")
	lstr_param.i_nargumentos = 1
	lstr_param.nombre_ventana = "wtc_con_carga_disenyo"
	lstr_param.resultado = ''
	id_ventana = f_menu_ventana_esta_abierta("wtc_trabajos_disenyo_nuevo")
	if id_ventana <> -1 then
		close(wtc_trabajos_disenyo_nuevo)
		OpenWithParm(wtc_trabajos_disenyo_nuevo, lstr_param)
	else
		OpenWithParm(wtc_trabajos_disenyo_nuevo,lstr_param)
	end if
	
end if
end event

type pb_salir from wt_consultas_padre`pb_salir within wtc_consulta_tiempos_pruebas_ink
integer x = 3918
integer taborder = 0
end type

type st_titulo from wt_consultas_padre`st_titulo within wtc_consulta_tiempos_pruebas_ink
integer width = 2907
end type

type p_logo from wt_consultas_padre`p_logo within wtc_consulta_tiempos_pruebas_ink
integer x = 3561
end type

type dw_filtro from wt_consultas_padre`dw_filtro within wtc_consulta_tiempos_pruebas_ink
integer x = 1298
integer y = 232
integer width = 1673
integer height = 260
integer taborder = 70
boolean vscrollbar = true
end type

type pb_buscar from wt_consultas_padre`pb_buscar within wtc_consulta_tiempos_pruebas_ink
integer x = 2871
integer y = 132
integer taborder = 80
end type

type sle_valor1 from wt_consultas_padre`sle_valor1 within wtc_consulta_tiempos_pruebas_ink
integer x = 1312
integer width = 398
integer height = 96
integer taborder = 30
end type

type em_fecha1 from wt_consultas_padre`em_fecha1 within wtc_consulta_tiempos_pruebas_ink
integer x = 1307
integer height = 96
integer taborder = 90
string text = ""
end type

type sle_texto from wt_consultas_padre`sle_texto within wtc_consulta_tiempos_pruebas_ink
integer x = 1312
integer y = 132
integer height = 96
integer taborder = 40
end type

type lb_lista from wt_consultas_padre`lb_lista within wtc_consulta_tiempos_pruebas_ink
integer x = 1312
integer y = 132
integer width = 462
integer height = 252
long textcolor = 24076881
end type

