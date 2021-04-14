$PBExportHeader$wtc_necesidades_pedidos_promocion.srw
forward
global type wtc_necesidades_pedidos_promocion from wt_consultas_padre
end type
type st_reservado from statictext within wtc_necesidades_pedidos_promocion
end type
type sle_observaciones from singlelineedit within wtc_necesidades_pedidos_promocion
end type
type pb_grabar_obs from picturebutton within wtc_necesidades_pedidos_promocion
end type
type st_1 from statictext within wtc_necesidades_pedidos_promocion
end type
type dw_etiquetas_bultos_100 from datawindow within wtc_necesidades_pedidos_promocion
end type
type st_2 from statictext within wtc_necesidades_pedidos_promocion
end type
type ddlb_1 from dropdownlistbox within wtc_necesidades_pedidos_promocion
end type
type dw_pedidos from datawindow within wtc_necesidades_pedidos_promocion
end type
type dw_subcontrataciones from datawindow within wtc_necesidades_pedidos_promocion
end type
type cb_1 from commandbutton within wtc_necesidades_pedidos_promocion
end type
type dw_estructura from datawindow within wtc_necesidades_pedidos_promocion
end type
end forward

global type wtc_necesidades_pedidos_promocion from wt_consultas_padre
integer width = 4315
integer height = 3792
string title = "Artículos por pedido"
st_reservado st_reservado
sle_observaciones sle_observaciones
pb_grabar_obs pb_grabar_obs
st_1 st_1
dw_etiquetas_bultos_100 dw_etiquetas_bultos_100
st_2 st_2
ddlb_1 ddlb_1
dw_pedidos dw_pedidos
dw_subcontrataciones dw_subcontrataciones
cb_1 cb_1
dw_estructura dw_estructura
end type
global wtc_necesidades_pedidos_promocion wtc_necesidades_pedidos_promocion

type variables
string sql_inicial, sql_final, orden_seleccionado
long fila_actual


end variables

forward prototypes
public function string f_montar_filtro (string consulta_inicial)
public function string f_construir_group_by ()
public subroutine f_cargar_datawindow (string new_sql)
public function string f_construir_consulta ()
public subroutine f_insertar_datos (string consulta)
public subroutine f_construir_datawindow_sub (string accion, long fila)
public subroutine f_actualizar_escandallo (integer fila)
public subroutine f_fun ()
public subroutine f_funcion_recursiva_actualizar (string cod_articulo, long necesidad)
end prototypes

public function string f_montar_filtro (string consulta_inicial);
string montaje, consulta_intermedios, articulo_linea, articulo_intermedio, consulta_final, promocion
str_escandallo vector_escandallo[300]
datastore registros_articulos, registros_intermedios, registros_final
int j, i, k, articulos, intermedios, indice, nivel, indice_datastore
decimal factor_acumulado
long cantidad



//TIPO REGISTRO : 0 - ARTÍCULO PROMOCIÓN , 1 - ARTÍCULO PRODUCCIÓN, 2 - ARTÍCULO DE PEDIDO

montaje = ''
factor_acumulado = 1
nivel = 0
indice_datastore = 1


for j = 1 to dw_montaje_filtro.rowcount()
	
	//Filtros mediante DW
	
		if montaje = '' then
			
			montaje = dw_montaje_filtro.object.filtro[j]
			
		else
			
			montaje = montaje + ' AND' + dw_montaje_filtro.object.filtro[j]
								
		end if
	
next

if montaje <> '' then
	
	consulta_final = consulta_inicial + ' AND ' + montaje + f_construir_group_by()
	
else
	
	consulta_final = consulta_inicial + f_construir_group_by()
	
end if
	
	

return consulta_final


end function

public function string f_construir_group_by ();

string cadena

cadena = "group by venliped.articulo, articulos.descripcion"

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



//DEVUELVO TODOS LOS ARTICULOS QUE HAY PEDIDOS QUE CORRESPONDEN A PROMOCIÓN


cadena = " select (venliped.articulo) as cod_articulo, (articulos.descripcion) as descripcion, "+&
			" isnull(sum(isnull(cantidad,0)) ,0) as cantidad , "+&
			" isnull((select sum(cantidad) from alm_bultos_lineas where alm_bultos_lineas.articulo = venliped.articulo),0) as stock "+&
			" from venliped "+&
			" inner join venped on venped.pedido = venliped.pedido and venped.empresa = venliped.empresa and venped.anyo = venliped.anyo "+&
			" inner join articulos on articulos.codigo = venliped.articulo and articulos.empresa = venliped.empresa "+&
			" where venped.es_proforma <> 'S' "+&
			" and venliped.empresa = '"+codigo_empresa+"' "+&
			" and articulos.promocion <> 'N' "

return cadena





end function

public subroutine f_insertar_datos (string consulta);	
string consulta_intermedios, articulo_linea, articulo_intermedio, promocion
str_escandallo_nuevo vector_escandallo[300]
datastore registros_articulos
int  i, k, articulos, indice, nivel, indice_datastore
decimal factor_acumulado
long stock, cantidad_pedido,  stock_pedido, cantidad, cantidad_subcontratada


//TIPO REGISTRO : 0 - ARTÍCULO PROMOCIÓN , 1 - ARTÍCULO PRODUCCIÓN, 2 - ARTÍCULO DE PEDIDO

factor_acumulado = 1
nivel = 0
indice_datastore = 1

f_cargar_cursor_nuevo (consulta, registros_articulos)
	
articulos = registros_articulos.rowcount()

for i = 1 to articulos
		
	indice = 1
		
	articulo_linea = registros_articulos.object.cod_articulo[i]
	
	cantidad_pedido = registros_articulos.object.cantidad[i]
	
	stock_pedido = registros_articulos.object.stock[i]
	
	if cantidad_pedido > stock_pedido then			//SI EL PEDIDO YA ESTÁ CUBIERTO, NO LO MUESTRO
	
		f_escandallo_factores_cantidad_stock(vector_Escandallo, articulo_linea, indice, factor_Acumulado, nivel, true, cantidad_pedido)
		
		for k = 1 to indice -1		//LA ESTRUCTURA SIEMPRE DEVUELVE UN ÍNDICE DE MÁS
						
			//CARGA DE DATOS DE LOS ARTÍCULOS EN EL DATAWINDOW SI HAY NECESIDAD
				
			cantidad = vector_Escandallo[k].cantidad
			
			stock = vector_Escandallo[k].stock
			
			if cantidad > stock then
	
				dw_datos.object.cod_articulo[indice_datastore] = vector_Escandallo[k].articulo
							
				articulo_intermedio = vector_Escandallo[k].articulo
					
				dw_datos.object.descripcion[indice_datastore] = vector_Escandallo[k].descripcion
					
				dw_datos.object.nivel[indice_datastore] = vector_Escandallo[k].nivel
							
				dw_datos.object.cantidad[indice_datastore] = cantidad
				
				dw_datos.object.stock[indice_datastore] = stock
				
				dw_datos.object.cabeza_estructura[indice_datastore] = vector_Escandallo[k].cabeza_estructura
				
				dw_datos.object.empresa[indice_datastore] = codigo_empresa
				
				cantidad_subcontratada = vector_Escandallo[k].cantidad_subcontratada
				
				dw_datos.object.subcontratado[indice_datastore] = cantidad_subcontratada
				
					
				//INFORMACIÓN SOBRE EL TIPO DE ARTÍCULO
							
				if vector_Escandallo[k].articulo = articulo_linea then
						
					dw_datos.object.tipo[indice_datastore] = 2
						
				else
								
					select promocion into :promocion
									
					from articulos where codigo=:articulo_intermedio and empresa=:codigo_empresa USING SQLCA;
									
					if (promocion = 'N' or isnull(promocion)) then
										
						dw_datos.object.tipo[indice_datastore] = 1
										
					else
								
						dw_datos.object.tipo[indice_datastore] = 0
										
					end if
									
				end if
				
				indice_datastore = indice_datastore + 1	
																
			end if
						
		next
		
	end if
	
	f_mensaje_proceso ("Generando...", i, articulos)
		
next
	
dw_datos.retrieve()

destroy registros_articulos



end subroutine

public subroutine f_construir_datawindow_sub (string accion, long fila);

dw_subcontrataciones.object.b_1.text = accion

dw_subcontrataciones.object.cod_articulo[1] = dw_datos.object.cod_articulo[fila]

dw_subcontrataciones.object.descripcion[1] = dw_datos.object.descripcion[fila]

if accion = "Añadir" then
	
	dw_subcontrataciones.object.cantidad[1] = dw_datos.object.necesidad[fila]
	
else
	
	dw_subcontrataciones.object.cantidad[1] = dw_datos.object.subcontratado[fila]
	
end if

dw_subcontrataciones.object.empresa[1] = dw_datos.object.empresa[fila]

fila_actual = fila

dw_subcontrataciones.visible = true


end subroutine

public subroutine f_actualizar_escandallo (integer fila);
string articulo_linea
decimal factor_acumulado
long necesidad




articulo_linea = dw_datos.object.cod_articulo[fila]
necesidad = dw_datos.object.necesidad[fila]
f_funcion_recursiva_actualizar(articulo_linea, necesidad)







end subroutine

public subroutine f_fun ();
end subroutine

public subroutine f_funcion_recursiva_actualizar (string cod_articulo, long necesidad);str_escandallo vector_Escandallo[300]
string cod_articulo_escandallo, articulo, sel, articulo_ant
int  i, k, nivel, indice
decimal factor_acumulado
long cantidad_anterior, necesidad_nueva
datastore registros 

nivel = 0
factor_acumulado = 1
indice = 1


sel = " select articulo, articulo_ant"+&
			" from art_escandallo "+&
			" where empresa = '"+codigo_empresa+"'"+&
			" and articulo = '"+cod_articulo+"' "
			
						
f_cargar_cursor_nuevo (sel, registros )



for k = 1 to registros.rowcount() 
						
	
		articulo_ant = registros.object.articulo_ant[k]		
			
		//RECORRO EL DATAWINDOW PARA ENCONTRAR EL ARTÍCULO Y ACTUALIZAR LOS ARTÍCULOS
				
		for i = 1 to dw_datos.rowcount()
				
			articulo = dw_datos.object.cod_articulo[i]
				
			if dw_datos.object.cod_articulo[i] = articulo_ant then
					
					dw_datos.object.cantidad[i] = necesidad
					
					necesidad_nueva = dw_datos.object.cantidad[i] - dw_datos.object.stock[i] + dw_datos.object.subcontratado[i]
					
					f_funcion_recursiva_actualizar(articulo_ant,necesidad_nueva)
					
			
				end if
										
			next 
				
		
		
next


end subroutine

on wtc_necesidades_pedidos_promocion.create
int iCurrent
call super::create
this.st_reservado=create st_reservado
this.sle_observaciones=create sle_observaciones
this.pb_grabar_obs=create pb_grabar_obs
this.st_1=create st_1
this.dw_etiquetas_bultos_100=create dw_etiquetas_bultos_100
this.st_2=create st_2
this.ddlb_1=create ddlb_1
this.dw_pedidos=create dw_pedidos
this.dw_subcontrataciones=create dw_subcontrataciones
this.cb_1=create cb_1
this.dw_estructura=create dw_estructura
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_reservado
this.Control[iCurrent+2]=this.sle_observaciones
this.Control[iCurrent+3]=this.pb_grabar_obs
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.dw_etiquetas_bultos_100
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.ddlb_1
this.Control[iCurrent+8]=this.dw_pedidos
this.Control[iCurrent+9]=this.dw_subcontrataciones
this.Control[iCurrent+10]=this.cb_1
this.Control[iCurrent+11]=this.dw_estructura
end on

on wtc_necesidades_pedidos_promocion.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_reservado)
destroy(this.sle_observaciones)
destroy(this.pb_grabar_obs)
destroy(this.st_1)
destroy(this.dw_etiquetas_bultos_100)
destroy(this.st_2)
destroy(this.ddlb_1)
destroy(this.dw_pedidos)
destroy(this.dw_subcontrataciones)
destroy(this.cb_1)
destroy(this.dw_estructura)
end on

event open;call super::open;dw_datos.SetTransObject(SQLCA)
dw_pedidos.SetTransObject(SQLCA)






end event

type st_registros_padre from wt_consultas_padre`st_registros_padre within wtc_necesidades_pedidos_promocion
integer x = 1637
integer y = 148
end type

type st_total_padre from wt_consultas_padre`st_total_padre within wtc_necesidades_pedidos_promocion
integer x = 1851
integer y = 148
integer width = 229
end type

type pb_imprimir from wt_consultas_padre`pb_imprimir within wtc_necesidades_pedidos_promocion
integer x = 3598
integer y = 108
integer height = 124
integer taborder = 0
string powertiptext = "Imprimir Listado"
end type

event pb_imprimir::clicked;String new_sql
if dw_datos.rowcount() > 0 then
	f_imprimir_datawindow(dw_datos)
end if
end event

type pb_borrar from wt_consultas_padre`pb_borrar within wtc_necesidades_pedidos_promocion
integer x = 3753
integer y = 108
integer height = 124
integer taborder = 0
end type

type dw_montaje_filtro from wt_consultas_padre`dw_montaje_filtro within wtc_necesidades_pedidos_promocion
integer width = 4837
integer height = 224
integer taborder = 30
end type

type pb_1 from wt_consultas_padre`pb_1 within wtc_necesidades_pedidos_promocion
integer x = 3447
integer y = 112
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

type pb_reset from wt_consultas_padre`pb_reset within wtc_necesidades_pedidos_promocion
integer x = 3913
integer y = 108
integer height = 124
integer taborder = 0
end type

type pb_anyadir1 from wt_consultas_padre`pb_anyadir1 within wtc_necesidades_pedidos_promocion
integer x = 3291
integer y = 112
integer height = 124
integer taborder = 0
alignment htextalign = right!
end type

event pb_anyadir1::clicked;call super::clicked;int index, fila, max_nivel
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
						 
						cadena_or = " venliped.cliente = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Cliente = "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR cliente = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#2[i]
					end if
				end if
			next 
		case "Periodo pedido"
			if cadena_or = '' then

				cadena_or = " venliped.fpedido "+ddlb_operador.text+" '"+em_fecha1.text+"' "
				cadena_or_visible = " Fecha pedido "+ddlb_operador.text+" '"+em_fecha1.text+"' "
		
			end if
			
		case "Articulo (Descripción)"
			for i = 1 to dw_filtro.rowcount()
				if dw_filtro.IsSelected (i)  then
					if cadena_or = '' then
						cadena_or = " articulos.descripcion = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = " Articulo = "+dw_filtro.object.#1[i]+" "+dw_filtro.object.#2[i]
					else
						cadena_or = cadena_or+" OR articulos.descripcion = '"+dw_filtro.object.#1[i]+"' "
						cadena_or_visible = cadena_or_visible+", "+dw_filtro.object.#1[i]//+" "+dw_filtro.object.#2[i] //Demasiado largo
					end if
				end if
			next 
			
		case "Artículo (Código)"
			if cadena_or = '' then
				descripcion_extra = ""
				SELECT descripcion INTO :descripcion_extra FROM articulos WHERE empresa = :codigo_empresa AND codigo = :sle_valor1.text;
				cadena_or = " venliped.articulo "+ddlb_operador.text+" '"+sle_valor1.text+"' "
				cadena_or_visible = " Artículo "+ddlb_operador.text+" '"+sle_valor1.text+" "+descripcion_extra+"' "
			end if
			
		/*	
		case "Tipo de artículo"
			if filtro = '' then
				filtro = " tipo "+ddlb_operador.text+" '"+em_fecha1.text+"' "
				cadena_or_visible = " Tipo de artículo "+ddlb_operador.text+" '"+em_fecha1.text+"' "
			end if	
			
		case "Necesidad"
			if filtro = '' then

				if ddlb_operador.text = '1' then
					
					ddlb_operador.text = "> 0"
				else
					
					ddlb_operador.text =" = 0"
					
				end if
				
				filtro = " necesidad "+ddlb_operador.text+" '"+em_fecha1.text+"' "
				cadena_or_visible = " Necesidad "+ddlb_operador.text+" '"+em_fecha1.text+"' "
		
			end if		
			
		*/	
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
	
	
	new_sql = f_montar_filtro(sql_inicial) + sql_final
	
	f_insertar_datos(new_sql)
	
	//f_cargar_datawindow (new_sql)
	
	
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
	
	//f_cargar_datawindow (new_sql)
	
	f_insertar_datos(new_sql)
	
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


dw_datos.SetRedraw(false)
//dw_emp.SetSort("1A")
dw_datos.Sort()
dw_datos.GroupCalc()
dw_datos.SetRedraw(true)

if filtro <> '' then
	
	dw_datos.setfilter(filtro)
	dw_datos.filter()
end if

st_total_padre.text = string ( dw_datos.rowcount() )









end event

type ddlb_operador from wt_consultas_padre`ddlb_operador within wtc_necesidades_pedidos_promocion
boolean visible = false
integer x = 1280
integer y = 128
integer width = 293
integer taborder = 0
integer textsize = -14
integer weight = 700
long textcolor = 23016974
boolean sorted = false
end type

type ddlb_campo from wt_consultas_padre`ddlb_campo within wtc_necesidades_pedidos_promocion
boolean visible = false
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
string item[] = {"Cliente","Periodo pedido","Articulo (Descripción)","Artículo (Código)"}
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
	
	CASE "Periodo pedido"
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
		
	CASE "Articulo (Descripción)"
		dw_filtro.visible = true
		pb_buscar.visible = true
		sle_texto.visible = true
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
	
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		consulta = "select articulos.descripcion as descripcion from articulos "+&
						"where articulos.empresa = '"+codigo_empresa+"' order by articulos.descripcion"
	

	CASE "Artículo (Código)"
		dw_filtro.visible = false
		pb_buscar.visible = false
		sle_texto.visible = false
		em_fecha1.visible = false
		sle_valor1.visible = true
		lb_lista.visible = false
		
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="	
		
		
	/*	
	CASE "Tipo de artículo"
		dw_filtro.visible = true
		pb_buscar.visible = false
		sle_texto.visible = false
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
		
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		
		consulta = " select '1' as descripcion, 'Promoción' UNION select '2' as descripcion2, 'Producción' UNION select '3' as descripcion3, 'Artículo pedido' "
		
	CASE "Necesidad"
		dw_filtro.visible = true
		pb_buscar.visible = false
		sle_texto.visible = false
		em_fecha1.visible = false
		sle_valor1.visible = false
		lb_lista.visible = false
		
		ddlb_operador.AddItem ("=")
		ddlb_operador.text = "="
		
		consulta = " select '1' as descripcion, 'Sí' UNION select '2' as descripcion2, 'No' "
		
		*/
		
	
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

type dw_datos from wt_consultas_padre`dw_datos within wtc_necesidades_pedidos_promocion
integer x = 41
integer width = 4197
integer height = 3032
integer taborder = 40
string dataobject = "dwtc_necesidades_pedidos_promocion"
end type

event dw_datos::clicked;call super::clicked;
string ordenar, cadena
long posicion, fila, numero,ll_donde


ordenar = ""


//COJO LA COLUMNA QUE HEMOS HECHO CLICK (NO SIRVE LA VARIABLE ROW, YA QUE NO ES UNA BANDA DETAIL, SINO UN GRUPO EN EL DATAWINDOW)

posicion = PosA(this.getbandatpointer(), "~t")

cadena = mid(this.getbandatpointer(),posicion,len(this.getbandatpointer()))

fila = long(trim(cadena))


choose case dwo.name
		
	case "codigo_articulo_t"
		
		ordenar = "cod_articulo asc"
		
	case "descripcion_t"
		
		ordenar = "descripcion asc"
		
	case "cantidad_t"
		
		ordenar = "cantidad desc"
		
	case "stock_t"
		
		ordenar = "stock desc"
		
	case "necesidad_t"
		
		ordenar = "necesidad desc"
		
	case "subcontratado_t"
		
		ordenar = "subcontratado desc"
		
	case "añadir_sub"
		
		dw_subcontrataciones.title = "Añadir subcontrataciones"
		
		f_construir_datawindow_sub("Añadir",fila)
			
	case "quitar_sub"
		
		dw_subcontrataciones.title = "Quitar subcontrataciones"
		
		f_construir_datawindow_sub("Quitar",fila)
			
end choose


if ordenar <> "" then

	dw_datos.setsort(ordenar)	
	dw_datos.sort()
	
end if

ll_donde = this.find("destacar = 1",1,this.rowcount())
if ll_donde > 0 then
	this.object.destacar[ll_donde] = 0
end if

if fila > 0 then
	this.object.destacar[fila] = 1
end if

//this.selectrow(0,false)
//this.selectrow(fila,true)
//this.SetRow(fila)



end event

event dw_datos::rbuttondown;call super::rbuttondown;string cadena, articulo
long posicion, fila, numero


//COJO LA COLUMNA QUE HEMOS HECHO CLICK (NO SIRVE LA VARIABLE ROW, YA QUE NO ES UNA BANDA DETAIL, SINO UN GRUPO EN EL DATAWINDOW)

posicion = PosA(this.getbandatpointer(), "~t")

cadena = mid(this.getbandatpointer(),posicion,len(this.getbandatpointer()))

fila = long(trim(cadena))

articulo = dw_datos.object.cod_articulo[fila]

dw_pedidos.retrieve(codigo_empresa,articulo)

dw_pedidos.visible = true


end event

type pb_salir from wt_consultas_padre`pb_salir within wtc_necesidades_pedidos_promocion
integer x = 4073
integer y = 108
integer height = 124
integer taborder = 0
end type

type st_titulo from wt_consultas_padre`st_titulo within wtc_necesidades_pedidos_promocion
end type

type p_logo from wt_consultas_padre`p_logo within wtc_necesidades_pedidos_promocion
integer x = 4174
end type

type dw_filtro from wt_consultas_padre`dw_filtro within wtc_necesidades_pedidos_promocion
integer x = 1605
integer y = 240
integer width = 4247
integer height = 260
integer taborder = 50
boolean vscrollbar = true
end type

type pb_buscar from wt_consultas_padre`pb_buscar within wtc_necesidades_pedidos_promocion
integer x = 2939
integer y = 112
integer width = 128
integer height = 112
integer taborder = 80
end type

type sle_valor1 from wt_consultas_padre`sle_valor1 within wtc_necesidades_pedidos_promocion
integer x = 1591
integer y = 132
integer width = 421
integer height = 108
integer taborder = 10
integer textsize = -14
end type

type em_fecha1 from wt_consultas_padre`em_fecha1 within wtc_necesidades_pedidos_promocion
integer x = 1605
integer height = 96
integer taborder = 90
string text = ""
end type

type sle_texto from wt_consultas_padre`sle_texto within wtc_necesidades_pedidos_promocion
integer x = 1609
integer y = 132
integer width = 1321
integer height = 96
integer taborder = 20
end type

type lb_lista from wt_consultas_padre`lb_lista within wtc_necesidades_pedidos_promocion
integer x = 1609
integer y = 132
integer width = 462
integer height = 356
long textcolor = 24076881
end type

type st_reservado from statictext within wtc_necesidades_pedidos_promocion
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

type sle_observaciones from singlelineedit within wtc_necesidades_pedidos_promocion
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

type pb_grabar_obs from picturebutton within wtc_necesidades_pedidos_promocion
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

type st_1 from statictext within wtc_necesidades_pedidos_promocion
integer x = 3200
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

type dw_etiquetas_bultos_100 from datawindow within wtc_necesidades_pedidos_promocion
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

type st_2 from statictext within wtc_necesidades_pedidos_promocion
integer x = 69
integer y = 152
integer width = 736
integer height = 64
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 21642288
long backcolor = 67108864
string text = "Filtrar t. producto"
alignment alignment = center!
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within wtc_necesidades_pedidos_promocion
integer x = 754
integer y = 144
integer width = 599
integer height = 400
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean vscrollbar = true
string item[] = {"Promoción","Producción","Artículo de pedido","Todos"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;string filtro, tipo



tipo = ddlb_1.text
filtro = ""

choose case tipo
		
	case "Promoción"
		
		if filtro = "" then
			
			filtro = " tipo = 0"
			
		else
			
			filtro = filtro + " and tipo = 0"
			
		end if
		
	case "Producción"
		
		if filtro = "" then
			
			filtro = " tipo = 1"
			
		else
			
			filtro = filtro + " and tipo = 1"
			
		end if
		
	case "Artículo de pedido"
		
		if filtro = "" then
			
			filtro = " tipo = 2"
			
		else
			
			filtro = filtro + " and tipo = 2"
		
	end if
		
	case "Todos"
		
		filtro = filtro
	
end choose


dw_datos.setfilter(filtro)

dw_datos.filter()
		
end event

type dw_pedidos from datawindow within wtc_necesidades_pedidos_promocion
boolean visible = false
integer x = 242
integer y = 924
integer width = 3557
integer height = 1100
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "dwtc_articulos_pedidos"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;if dwo.name = "salir" then
	
	this.reset()
	
	this.visible = false
	
end if
end event

type dw_subcontrataciones from datawindow within wtc_necesidades_pedidos_promocion
boolean visible = false
integer x = 599
integer y = 1108
integer width = 2985
integer height = 460
integer taborder = 50
boolean bringtotop = true
boolean titlebar = true
string title = "none"
string dataobject = "dwtc_subcontratacion_promocion"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean livescroll = true
end type

event clicked;string articulo, descripcion, empresa
long cantidad, cantidad_subcontratada, contador_articulo



if dwo.name = "exit" then
	
	dw_subcontrataciones.reset()
	
	dw_subcontrataciones.visible = false
	
	
end if


if dwo.name = "b_1" then 
	
	articulo = this.object.cod_articulo[1]
	
	this.accepttext()

	cantidad = this.object.cantidad[1]
	
	empresa = this.object.empresa[1]
	
	
	select count(*) into :contador_articulo
		
	from subcontratacion_promocion 
		
	where cod_articulo = :articulo and empresa = :codigo_empresa using SQLCA;
	
	
	if contador_articulo = 0 then
		
		descripcion = this.object.descripcion[1]
			
		
		insert into subcontratacion_promocion (empresa,cod_articulo,descripcion,cantidad_subcontratada)
			
		values(:empresa,:articulo,:descripcion,:cantidad) using sqlca;
			
			
		if sqlca.sqlcode <> 0 then
				
			messagebox("Error", "Ha habido un problema al actualizar la base de datos")
				
			rollback;
				
		else
				
			commit;
			
			dw_datos.object.necesidad.expression = "if (stock + subcontratado > cantidad_total, 0,cantidad_total -  (stock+subcontratado))"
		
			dw_datos.object.subcontratado[fila_actual] = cantidad
				
		end if
		
	else
		
		
		select cantidad_subcontratada into :cantidad_subcontratada from subcontratacion_promocion
				
		where cod_articulo = :articulo and empresa =:empresa using sqlca;
			
		if dwo.text = "Añadir" then
				
				
			cantidad_subcontratada = cantidad_subcontratada + cantidad
				
		else
				
				cantidad_subcontratada = cantidad_subcontratada - cantidad
			
				if cantidad_subcontratada < 0 then
				
					cantidad_subcontratada = 0
				
				end if
				
				
		end if

				
		UPDATE subcontratacion_promocion SET cantidad_subcontratada = :cantidad_subcontratada
		WHERE cod_articulo= :articulo and empresa =:empresa using sqlca;
			
		if sqlca.sqlcode <> 0 then
				
			messagebox("Error", "Ha habido un problema al actualizar la base de datos")
				
			rollback;
				
		else
				
			commit;
				
		end if
							
		dw_datos.object.necesidad.expression = "if (stock + subcontratado > cantidad_total, 0,cantidad_total -  (stock+subcontratado))"
		
		dw_datos.object.subcontratado[fila_actual] = cantidad_subcontratada
	
		
	end if
	
	dw_subcontrataciones.reset()
	
	dw_subcontrataciones.visible = false
	
	//f_actualizar_escandallo(fila_actual)

end if
end event

type cb_1 from commandbutton within wtc_necesidades_pedidos_promocion
boolean visible = false
integer x = 2299
integer y = 132
integer width = 750
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Mostrar estructura artículo"
end type

event clicked;datastore registros_articulos
str_escandallo_nuevo vector_escandallo[300]
int i,k, articulos, indice, nivel, indice_datastore
decimal factor_acumulado
long stock, cantidad_pedido, stock_pedido, cantidad, cantidad_subcontratada, ll_donde
string consulta, articulo_linea, articulo_intermedio



ll_donde = dw_datos.find("destacar = 1",1,dw_datos.rowcount())

if ll_donde > 0 then

	
	dw_estructura.visible = true
	factor_acumulado = 1
	nivel = 0
	indice_datastore = 1
	
	articulo_linea = dw_datos.object.cod_articulo[ll_donde]
	
	consulta = " select (venliped.articulo) as cod_articulo, (articulos.descripcion) as descripcion, "+&
			" isnull(sum(isnull(venliped.cantidad,0)) ,0) as cantidad "+&
			" from venliped "+&
			" inner join venped on venped.pedido = venliped.pedido and venped.empresa = venliped.empresa and venped.anyo = venliped.anyo "+&
			" inner join articulos on articulos.codigo = venliped.articulo and articulos.empresa = venliped.empresa "+&
			" where venped.es_proforma <> 'S' "+&
			" and venliped.empresa = '"+codigo_empresa+"' "+&
			" and articulos.promocion <> 'N' " +&
			" and articulos.codigo = '"+articulo_linea+"' "+&
			" group by venliped.articulo, articulos.descripcion "

	f_cargar_cursor_nuevo (consulta, registros_articulos)
	
	articulos = registros_articulos.rowcount()
	
	indice = 1
			
	cantidad_pedido = registros_articulos.object.cantidad[1]
		
	f_escandallo_factores_cantidad_stock(vector_Escandallo, articulo_linea, indice, factor_Acumulado, nivel, true, cantidad_pedido)
			
	for k = 1 to indice - 1 			//LA ESTRUCTURA SIEMPRE DEVUELVE UN ÍNDICE DE MÁS
								
		cantidad = vector_Escandallo[k].cantidad
				
		stock = vector_Escandallo[k].stock
		
		dw_estructura.object.cantidad[indice_datastore] = cantidad
					
		dw_estructura.object.stock[indice_datastore] = stock
				
		dw_estructura.object.cod_articulo[indice_datastore] = vector_Escandallo[k].articulo
								
		articulo_intermedio = vector_Escandallo[k].articulo
						
		dw_estructura.object.descripcion[indice_datastore] = vector_Escandallo[k].descripcion
															
		dw_estructura.object.empresa[indice_datastore] = codigo_empresa
					
		cantidad_subcontratada = vector_Escandallo[k].cantidad_subcontratada
					
		dw_estructura.object.subcontratado[indice_datastore] = cantidad_subcontratada
		
		dw_estructura.object.nivel[indice_datastore] = vector_Escandallo[k].nivel
						
		indice_datastore = indice_datastore + 1
																								
	next	

	dw_estructura.setsort("nivel")
	
	dw_estructura.sort()
	
	destroy registros_articulos

else 
	
	messagebox("Aviso", "No hay ningún artículo seleccionado")

end if
end event

type dw_estructura from datawindow within wtc_necesidades_pedidos_promocion
boolean visible = false
integer x = 96
integer y = 1276
integer width = 4110
integer height = 1696
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "dwtc_estructura_articulo"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;if dwo.name = "salir" then
	
	this.visible = false
	this.reset()
	
end if
end event

