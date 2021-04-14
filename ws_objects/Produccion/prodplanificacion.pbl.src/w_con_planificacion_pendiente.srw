$PBExportHeader$w_con_planificacion_pendiente.srw
forward
global type w_con_planificacion_pendiente from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_planificacion_pendiente
end type
type pb_1 from upb_imprimir within w_con_planificacion_pendiente
end type
type dw_listado from datawindow within w_con_planificacion_pendiente
end type
type gb_10 from groupbox within w_con_planificacion_pendiente
end type
type gb_1 from groupbox within w_con_planificacion_pendiente
end type
type gb_2 from groupbox within w_con_planificacion_pendiente
end type
type cb_1 from commandbutton within w_con_planificacion_pendiente
end type
type cb_2 from commandbutton within w_con_planificacion_pendiente
end type
type cb_3 from commandbutton within w_con_planificacion_pendiente
end type
type uo_subformato from u_marca_lista within w_con_planificacion_pendiente
end type
type cb_4 from commandbutton within w_con_planificacion_pendiente
end type
type cb_5 from commandbutton within w_con_planificacion_pendiente
end type
type cb_6 from commandbutton within w_con_planificacion_pendiente
end type
type uo_formato from u_marca_lista within w_con_planificacion_pendiente
end type
type uo_subfamilia from u_marca_lista within w_con_planificacion_pendiente
end type
type uo_familia from u_marca_lista within w_con_planificacion_pendiente
end type
type uo_calidad from u_marca_lista within w_con_planificacion_pendiente
end type
type dw_1 from u_datawindow_consultas within w_con_planificacion_pendiente
end type
type uo_1 from u_manejo_datawindow within w_con_planificacion_pendiente
end type
type cb_10 from commandbutton within w_con_planificacion_pendiente
end type
end forward

global type w_con_planificacion_pendiente from w_int_con_empresa
integer x = 5
integer y = 792
integer width = 3712
integer height = 1836
string title = "Consulta de Movimientos"
pb_2 pb_2
pb_1 pb_1
dw_listado dw_listado
gb_10 gb_10
gb_1 gb_1
gb_2 gb_2
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
uo_subformato uo_subformato
cb_4 cb_4
cb_5 cb_5
cb_6 cb_6
uo_formato uo_formato
uo_subfamilia uo_subfamilia
uo_familia uo_familia
uo_calidad uo_calidad
dw_1 dw_1
uo_1 uo_1
cb_10 cb_10
end type
global w_con_planificacion_pendiente w_con_planificacion_pendiente

type variables
String	is_codigo,ante_articulo,var_calidad,var_tipo_pallet,var_caja
Integer   var_calibre
String  devolver,var_tono
end variables

forward prototypes
public subroutine f_control (datawindow data)
public subroutine f_generar_produccion_pendiente ()
end prototypes

public subroutine f_control (datawindow data);string filtro_formatos,filtro_familias,filtro_no_calidades
string filtro_subformatos,filtro_subfamilias,filtro_calidades
string sel,var_version
string articulo,nombre_articulo,formato,nombre_formato,unidad,nombre_unidad
long   i,indice_for,indice_fam,total,donde,indice
long   indice_subfam,indice_subfor,indice_calidad
dec    pedidos_calidades_seleccionada,stock_calidades_seleccionadas
dec    pedidos_calidades_no_seleccion,stock_calidades_no_seleccionad
dec    cantidad_fabricar,pedidos_pendientes_planificar
datastore pedidos,stock,pendiente

filtro_formatos    = ""
filtro_familias    = ""
filtro_subformatos = ""
filtro_subfamilias = ""
filtro_calidades   = ""

indice_fam = 0
for i=1 to uo_familia.dw_marca.rowcount()
	if uo_familia.dw_marca.getitemstring(i,"marca")="S" then
		if indice_fam = 0 then
			filtro_familias = "'"+uo_familia.dw_marca.getitemstring(i,"codigo")+"'"
		else
			filtro_familias = filtro_familias+",'"+uo_familia.dw_marca.getitemstring(i,"codigo")+"'"
		end if
		indice_fam ++
	end if	
next

if indice_fam = uo_familia.dw_marca.rowcount() then
	filtro_familias = ""
else
	filtro_familias = "and familia in ("+filtro_familias+") "
end if

indice_subfam = 0
for i=1 to uo_subfamilia.dw_marca.rowcount()
	if uo_subfamilia.dw_marca.getitemstring(i,"marca")="S" then
		if indice_subfam = 0 then
			filtro_subfamilias = "'"+uo_subfamilia.dw_marca.getitemstring(i,"codigo")+"'"
		else
			filtro_subfamilias = filtro_subfamilias+",'"+uo_subfamilia.dw_marca.getitemstring(i,"codigo")+"'"
		end if
		indice_subfam ++
	end if	
next

if indice_subfam = uo_subfamilia.dw_marca.rowcount() then
	filtro_subfamilias = ""
else
	filtro_subfamilias = "and subfamilia in ("+filtro_subfamilias+") "
end if

indice_for = 0
for i=1 to uo_formato.dw_marca.rowcount()
	if uo_formato.dw_marca.getitemstring(i,"marca")="S" then
		if indice_for = 0 then
			filtro_formatos = "'"+uo_formato.dw_marca.getitemstring(i,"codigo")+"'"
		else
			filtro_formatos = filtro_formatos+",'"+uo_formato.dw_marca.getitemstring(i,"codigo")+"'"
		end if
		indice_for ++
	end if
next

if indice_for = uo_formato.dw_marca.rowcount() then
	filtro_formatos = ""
else
	filtro_formatos = "and formato in ("+filtro_formatos+") "
end if


indice_subfor = 0
for i=1 to uo_subformato.dw_marca.rowcount()
	if uo_subformato.dw_marca.getitemstring(i,"marca")="S" then
		if indice_subfor = 0 then
			filtro_subformatos = "'"+uo_subformato.dw_marca.getitemstring(i,"codigo")+"'"
		else
			filtro_subformatos = filtro_subformatos+",'"+uo_subformato.dw_marca.getitemstring(i,"codigo")+"'"
		end if
		indice_subfor ++
	end if
next

if indice_subfor = uo_subformato.dw_marca.rowcount() then
	filtro_subformatos = ""
else
	filtro_subformatos = "and subformato in ("+filtro_subformatos+") "
end if

indice_calidad = 0
for i=1 to uo_calidad.dw_marca.rowcount()
	if uo_calidad.dw_marca.getitemstring(i,"marca")="S" then
		if indice_calidad = 0 then
			filtro_calidades = "'"+uo_calidad.dw_marca.getitemstring(i,"codigo")+"'"
		else
			filtro_calidades = filtro_calidades + ",'"+uo_calidad.dw_marca.getitemstring(i,"codigo")+"'"
		end if
		indice_calidad ++
	end if	
next

if indice_calidad = uo_calidad.dw_marca.rowcount() then
	filtro_no_calidades = ""
	filtro_calidades    = ""
else
	filtro_no_calidades = "and calidad not in ("+filtro_calidades+") "
	filtro_calidades    = "and calidad in ("+filtro_calidades+") "	
end if

uo_familia.visible    = False
uo_subfamilia.visible = False
uo_formato.visible    = False
uo_subformato.visible = False
uo_calidad.visible    = False

data.setredraw(false)
data.retrieve(codigo_empresa)

sel = "select articulo,sum(cantidad) cantidad "+&
		"from  venliped "+&
		"where empresa = '"+codigo_empresa+"' "+&
		filtro_calidades+&
		"and situacion <> 'P' "+&
		"and articulo in ("+&
		"select codigo from articulos "+&
		"where empresa = '"+codigo_empresa+"' "+&
		filtro_familias+&
		filtro_subfamilias+&
		filtro_formatos+&
		filtro_subformatos+&
		") group by articulo"

pedidos = f_cargar_cursor(sel)
total = pedidos.rowcount()
for indice = 1 to total
	f_mensaje_proceso("Comprobando Pedidos Pendientes",indice,total)
	articulo        = pedidos.object.articulo[indice]
	nombre_articulo = f_nombre_articulo(codigo_empresa,articulo)
	formato         = f_formato_articulo(codigo_empresa,articulo)
	nombre_formato  = f_nombre_formato(codigo_empresa,formato)
	pedidos_calidades_seleccionada = pedidos.object.cantidad[indice]
	unidad          = f_unidad_articulo(codigo_empresa,articulo)
	nombre_unidad   = f_nombre_unidad_abr(unidad)
	var_version     = f_version_activa_articulo(codigo_empresa,articulo)
	
	sel = "select sum(existencias) stock "+&
			"from almlinubica "+&
			"where empresa = '"+codigo_empresa+"' "+&
			"and   articulo = '"+articulo+"' "+&
			"and   zona <> 'P' "+&   
         "and   zona <> 'M' "+& 
			filtro_calidades
			
	stock = f_cargar_cursor(sel)		
	if stock.rowcount() = 1 then
		stock_calidades_seleccionadas = stock.object.stock[1]	
		if isnull(stock_calidades_seleccionadas) then stock_calidades_seleccionadas = 0
	else
		stock_calidades_seleccionadas = 0
	end if
	destroy stock
	
	sel = "select sum(cantidad) pendiente_planificar "+&
			"from venliped "+&
			"where empresa = '"+codigo_empresa+"' "+&
			"and   articulo = '"+articulo+"' "+&
			filtro_calidades+&
			"and   anyo_proddiaria = 0 "+&
			"and   contador_proddiaria = 0 "+&
			"and   situacion = 'F'"
			
//	pendiente = f_cargar_cursor(sel)	
	f_cargar_cursor_nuevo (sel, pendiente)
	if pendiente.rowcount() = 1 then
		pedidos_pendientes_planificar = pendiente.object.pendiente_planificar[1]	
		if isnull(pedidos_pendientes_planificar) then pedidos_pendientes_planificar = 0
	else
		pedidos_pendientes_planificar = 0
	end if
	destroy pendiente
	
	pedidos_calidades_no_seleccion = 0
	stock_calidades_no_seleccionad = 0
	if pedidos_pendientes_planificar > (stock_calidades_seleccionadas - (pedidos_calidades_seleccionada - pedidos_pendientes_planificar)) then
		cantidad_fabricar = pedidos_pendientes_planificar - (stock_calidades_seleccionadas - (pedidos_calidades_seleccionada - pedidos_pendientes_planificar))
	else
		cantidad_fabricar = 0
	end if
	
	donde = data.insertrow(0)
	data.object.empresa[donde]                        = codigo_empresa
	data.object.articulo[donde]                       = articulo
	data.object.nombre_articulo[donde]                = nombre_articulo
	data.object.formato[donde]                        = formato
	data.object.nombre_formato[donde]                 = nombre_formato
	data.object.unidad[donde]                         = unidad
	data.object.nombre_unidad[donde]                  = nombre_unidad
	data.object.pedidos_calidades_seleccionada[donde] = pedidos_calidades_seleccionada
	data.object.stock_calidades_seleccionadas[donde]  = stock_calidades_seleccionadas
	data.object.pedidos_calidades_no_seleccion[donde] = pedidos_calidades_no_seleccion
	data.object.stock_calidades_no_seleccionad[donde] = stock_calidades_no_seleccionad
	data.object.cantidad_fabricar[donde]              = cantidad_fabricar
	data.object.pedidos_pendientes_planificar[donde]  = pedidos_pendientes_planificar
	data.object.version[donde]                        = var_version
next
destroy pedidos
//
if filtro_no_calidades <> "" then
	sel = "select articulo,sum(cantidad) cantidad "+&
			"from  venliped "+&
			"where empresa = '"+codigo_empresa+"' "+&
			filtro_no_calidades+&
			"and situacion <> 'P' "+&
			"and articulo in ("+&
			"select codigo from articulos "+&
			"where empresa = '"+codigo_empresa+"' "+&
			filtro_familias+&
			filtro_subfamilias+&
			filtro_formatos+&
			filtro_subformatos+&
			") group by articulo"		
	
	//pedidos = f_cargar_cursor(sel)
	f_cargar_cursor_nuevo ( sel, pedidos)
	
	total = pedidos.rowcount()
	for indice = 1 to total
		f_mensaje_proceso("Comprobando Pedidos Pendientes",indice,total)
		articulo        = pedidos.object.articulo[indice]
		nombre_articulo = f_nombre_articulo(codigo_empresa,articulo)
		formato         = f_formato_articulo(codigo_empresa,articulo)
		nombre_formato  = f_nombre_formato(codigo_empresa,formato)
		pedidos_calidades_no_seleccion = pedidos.object.cantidad[indice]		
		unidad          = f_unidad_articulo(codigo_empresa,articulo)
		nombre_unidad   = f_nombre_unidad_abr(unidad)
		var_version     = f_version_activa_articulo(codigo_empresa,articulo)
		
		sel = "select sum(existencias) stock "+&
				"from almlinubica "+&
				"where empresa = '"+codigo_empresa+"' "+&
				"and   articulo = '"+articulo+"' "+&
				"and   zona <> 'P' "+&   
	         "and   zona <> 'M' "+& 
				filtro_no_calidades
				
		//stock = f_cargar_cursor(sel)		
		f_cargar_cursor_nuevo (sel, stock)
		if stock.rowcount() = 1 then
			stock_calidades_no_seleccionad = stock.object.stock[1]	
			if isnull(stock_calidades_no_seleccionad) then stock_calidades_no_seleccionad = 0
		else
			stock_calidades_no_seleccionad = 0	
		end if
		destroy stock
		
		donde = data.find("articulo = '"+articulo+"'",1,data.rowcount())
		if donde > 0 then
			pedidos_calidades_seleccionada = data.object.pedidos_calidades_seleccionada[donde]
			stock_calidades_seleccionadas  = data.object.stock_calidades_seleccionadas[donde]
		else
			pedidos_calidades_seleccionada = 0
			stock_calidades_seleccionadas  = 0
			
			donde = data.insertrow(0)
			data.object.empresa[donde]                        = codigo_empresa
			data.object.articulo[donde]                       = articulo
			data.object.nombre_articulo[donde]                = nombre_articulo
			data.object.formato[donde]                        = formato
			data.object.nombre_formato[donde]                 = nombre_formato
			data.object.unidad[donde]                         = unidad
			data.object.nombre_unidad[donde]                  = nombre_unidad
			data.object.pedidos_calidades_seleccionada[donde] = pedidos_calidades_seleccionada
			data.object.stock_calidades_seleccionadas[donde]  = stock_calidades_seleccionadas			
			data.object.pedidos_pendientes_planificar[donde]  = 0
			data.object.cantidad_fabricar[donde]              = 0
			data.object.version[donde]                        = var_version
		end if
		
		data.object.pedidos_calidades_no_seleccion[donde] = pedidos_calidades_no_seleccion
		data.object.stock_calidades_no_seleccionad[donde] = stock_calidades_no_seleccionad
		
	next
	destroy pedidos
end if

data.sort()
data.groupcalc()
data.setredraw(true)
end subroutine

public subroutine f_generar_produccion_pendiente ();string   articulo
string   familia,formato,unidad,calidad,calidades[]
string   pasar_por_prensa,pasar_por_esmaltadora,pasar_por_horno
dec      cantidad_fabricar
dec      cantidad_prensa,cantidad_esmaltadora,cantidad_horno
dec      perdidas,cantidad_coccion,ant_cantidad_coccion
long     indice,total,anyo,contador,total_calidades,indice_calidades
long     linea,total_cocciones,indice_cocciones,coccion
datetime f_entrada
boolean  bien

total = dw_1.rowcount()

for indice = 1 to uo_calidad.dw_marca.rowcount()
	if uo_calidad.dw_marca.getitemstring(indice,"marca") = "S" then
		calidades[UpperBound(calidades) +1] = uo_calidad.dw_marca.getitemstring(indice,"codigo")
	end if	
next


for indice = 1 to total
	bien = true
	if dw_1.object.planificar[indice] = "S" then
		articulo          = dw_1.object.articulo[indice]
		cantidad_fabricar = dw_1.object.cantidad_fabricar[indice]
		version           = dw_1.object.version[indice]
		if cantidad_fabricar > 0 then
			total_cocciones = f_numero_cocciones_articulo_version(codigo_empresa,articulo,version)
			
			anyo = year(today())
			select max(contador)
			into   :contador
			from   proddiaria_pendiente
			where  empresa = :codigo_empresa;
			
			if isnull(contador) then contador = 0
			contador ++
			pasar_por_prensa      = f_pasar_articulo_coccion_por_prensa(codigo_empresa,articulo,version,total_cocciones)
			pasar_por_esmaltadora = f_pasar_articulo_coccion_por_esmaltadora(codigo_empresa,articulo,version,total_cocciones)
			pasar_por_horno       = f_pasar_articulo_coccion_por_horno(codigo_empresa,articulo,version,total_cocciones)			
			familia               = f_familia_articulo(codigo_empresa,articulo)
			formato               = f_formato_articulo(codigo_empresa,articulo)
			unidad                = f_unidad_articulo(codigo_empresa,articulo)
			f_entrada             = datetime(today())
			
			if pasar_por_horno = "S" then
				perdidas = f_perdidas_tipo_linea_formato(codigo_empresa,"H",formato)		
				cantidad_horno = cantidad_fabricar *(1 +(perdidas / 100))
				ant_cantidad_coccion = cantidad_horno
			else
				cantidad_horno = 0
			end if			
			
			if pasar_por_esmaltadora = "S" then
				perdidas = f_perdidas_tipo_linea_formato(codigo_empresa,"E",formato)			
				if cantidad_horno = 0 then
					cantidad_esmaltadora = cantidad_fabricar *(1 +(perdidas / 100))
				else
					cantidad_esmaltadora = cantidad_horno *(1 +(perdidas / 100))
				end if
				ant_cantidad_coccion = cantidad_esmaltadora
			else
				cantidad_esmaltadora = 0
			end if	
			
			if pasar_por_prensa = "S" then
				perdidas = f_perdidas_tipo_linea_formato(codigo_empresa,"P",formato)			
				if cantidad_esmaltadora = 0 then
					if cantidad_horno = 0 then
						cantidad_prensa = cantidad_fabricar *(1 +(perdidas / 100))
					else
						cantidad_prensa = cantidad_horno *(1 +(perdidas / 100))
					end if
				else
					cantidad_prensa = cantidad_esmaltadora *(1 +(perdidas / 100))
				end if				
				ant_cantidad_coccion = cantidad_prensa
			else
				cantidad_prensa = 0
			end if
			
			insert into proddiaria_pendiente
				(empresa, 						anyo, 							contador, 
				 articulo, 						familia, 						formato, 
				 cantidad, 						unidad, 							f_entrada, 
				 anyo_orden_produccion, 	orden_produccion, 			version,
				 pasar_por_prensa,      	pasar_por_esmaltadora,		pasar_por_horno,
				 asignada_prensa,				asignada_esmaltadora,		asignado_horno,
				 cantidad_prensa,				cantidad_esmaltadora,		cantidad_horno)
			values
				(:codigo_empresa, 			:anyo,	 						:contador, 
				 :articulo, 					:familia, 						:formato, 
				 :cantidad_fabricar, 		:unidad, 						:f_entrada, 
				 0, 								0,									:version,
				 :pasar_por_prensa,			:pasar_por_esmaltadora,		:pasar_por_horno,
				 'N',								'N',								'N',
				 :cantidad_prensa,			:cantidad_esmaltadora,		:cantidad_horno);
				 
			if sqlca.sqlcode <> 0 then
				bien = false
				messagebox("Atención","Error en articulo "+f_nombre_articulo(codigo_empresa,articulo))
			else
								
				if total_cocciones > 1 then
					 					
					for indice_cocciones = 1 to total_cocciones -1
						cantidad_coccion      = ant_cantidad_coccion
						pasar_por_prensa      = f_pasar_articulo_coccion_por_prensa(codigo_empresa,articulo,version,indice_cocciones)
						pasar_por_esmaltadora = f_pasar_articulo_coccion_por_esmaltadora(codigo_empresa,articulo,version,indice_cocciones)
						pasar_por_horno       = f_pasar_articulo_coccion_por_horno(codigo_empresa,articulo,version,indice_cocciones)									
						
						if pasar_por_horno = "S" then
							perdidas = f_perdidas_tipo_linea_formato(codigo_empresa,"H",formato)		
							cantidad_horno = cantidad_coccion *(1 +(perdidas / 100))
							ant_cantidad_coccion = cantidad_horno
						else
							cantidad_horno = 0
						end if			
						
						if pasar_por_esmaltadora = "S" then
							perdidas = f_perdidas_tipo_linea_formato(codigo_empresa,"E",formato)			
							if cantidad_horno = 0 then
								cantidad_esmaltadora = cantidad_coccion *(1 +(perdidas / 100))
							else
								cantidad_esmaltadora = cantidad_horno *(1 +(perdidas / 100))
							end if
							ant_cantidad_coccion = cantidad_esmaltadora
						else
							cantidad_esmaltadora = 0
						end if	
						
						if pasar_por_prensa = "S" then
							perdidas = f_perdidas_tipo_linea_formato(codigo_empresa,"P",formato)			
							if cantidad_esmaltadora = 0 then
								if cantidad_horno = 0 then
									cantidad_prensa = cantidad_coccion *(1 +(perdidas / 100))
								else
									cantidad_prensa = cantidad_horno *(1 +(perdidas / 100))
								end if
								ant_cantidad_coccion = cantidad_prensa
							else
								cantidad_prensa = cantidad_esmaltadora *(1 +(perdidas / 100))
							end if				
						else
							cantidad_prensa = 0
						end if
												
						linea   = indice_cocciones
						coccion = indice_cocciones
						insert into proddiaria_pendiente_comp
							(empresa, 				anyo, 					contador, 
							 linea, 					articulo, 				familia, 
							 formato, 				cantidad, 				unidad,
							 version,				pasar_por_prensa,    pasar_por_esmaltadora,
							 pasar_por_horno,		asignada_prensa,		asignada_esmaltadora,
							 asignado_horno,		cantidad_prensa,		cantidad_esmaltadora,
							 cantidad_horno,		coccion)
						values
							(:codigo_empresa, 	:anyo, 					:contador, 
							 :linea, 				:articulo,				:familia, 
							 :formato,				:cantidad_coccion,	:unidad,
							 :version,				:pasar_por_prensa,	:pasar_por_esmaltadora,
							 :pasar_por_horno,	'N',						'N',
							 'N',						:cantidad_prensa,		:cantidad_esmaltadora,
							 :cantidad_horno,		:coccion);
							 
						if sqlca.sqlcode <> 0 then
							messagebox("Atención","Error en el escandallo del articulo "+f_nombre_articulo(codigo_empresa,articulo))
							bien = false
						end if
					next
				end if
				total_calidades = UpperBound(calidades)
				for indice_calidades = 1 to total_calidades
					
					calidad = calidades[indice_calidades]
					
					update venliped
					set    anyo_proddiaria     = :anyo,
							 contador_proddiaria = :contador
					where  empresa             = :codigo_empresa
					and    situacion           = 'F'
					and    anyo_proddiaria     = 0
					and	 contador_proddiaria = 0
					and    calidad             = :calidad
					and    articulo            = :articulo;
					if sqlca.sqlcode <> 0 then
						bien = false
						messagebox("Atención","Error al actualizar los pedidos del articulo "+f_nombre_articulo(codigo_empresa,articulo))
					end if																	
				next
				
			end if						
			if bien then
				commit;
			else
				rollback;
			end if
		end if
	end if	
next
end subroutine

event open;call super::open;dw_1.SetTransObject(sqlca)
dw_listado.SetTransObject(sqlca)

This.title = " CONSULTA RESERVAS POR ESPECIFICACIONES "

uo_familia.f_cargar_datos("dw_ayuda_familias","","","Familia","Descripción")
uo_subfamilia.f_cargar_datos("dw_ayuda_subfamilias","","","Subfamilia","Descripción")
uo_formato.f_cargar_datos("dw_ayuda_formatos","","","Formato","Descripción")
uo_subformato.f_cargar_datos("dw_ayuda_subformatos","","","Subformato","Descripción")
uo_calidad.f_cargar_datos("dw_ayuda_calidades","","","Calidad","Descripción")



end event

on w_con_planificacion_pendiente.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.pb_1=create pb_1
this.dw_listado=create dw_listado
this.gb_10=create gb_10
this.gb_1=create gb_1
this.gb_2=create gb_2
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.uo_subformato=create uo_subformato
this.cb_4=create cb_4
this.cb_5=create cb_5
this.cb_6=create cb_6
this.uo_formato=create uo_formato
this.uo_subfamilia=create uo_subfamilia
this.uo_familia=create uo_familia
this.uo_calidad=create uo_calidad
this.dw_1=create dw_1
this.uo_1=create uo_1
this.cb_10=create cb_10
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.pb_1
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.gb_10
this.Control[iCurrent+5]=this.gb_1
this.Control[iCurrent+6]=this.gb_2
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.cb_2
this.Control[iCurrent+9]=this.cb_3
this.Control[iCurrent+10]=this.uo_subformato
this.Control[iCurrent+11]=this.cb_4
this.Control[iCurrent+12]=this.cb_5
this.Control[iCurrent+13]=this.cb_6
this.Control[iCurrent+14]=this.uo_formato
this.Control[iCurrent+15]=this.uo_subfamilia
this.Control[iCurrent+16]=this.uo_familia
this.Control[iCurrent+17]=this.uo_calidad
this.Control[iCurrent+18]=this.dw_1
this.Control[iCurrent+19]=this.uo_1
this.Control[iCurrent+20]=this.cb_10
end on

on w_con_planificacion_pendiente.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.pb_1)
destroy(this.dw_listado)
destroy(this.gb_10)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.uo_subformato)
destroy(this.cb_4)
destroy(this.cb_5)
destroy(this.cb_6)
destroy(this.uo_formato)
destroy(this.uo_subfamilia)
destroy(this.uo_familia)
destroy(this.uo_calidad)
destroy(this.dw_1)
destroy(this.uo_1)
destroy(this.cb_10)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;uo_1.triggerEvent("linea_abajo")
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;uo_1.triggerEvent("linea_arriba")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_1.triggerEvent("pagina_arriba")

end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_1.triggerEvent("pagina_abajo")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_planificacion_pendiente
integer taborder = 140
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_planificacion_pendiente
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_planificacion_pendiente
integer y = 20
integer width = 2587
end type

type pb_2 from upb_salir within w_con_planificacion_pendiente
integer x = 3483
integer y = 12
integer width = 128
integer height = 112
integer taborder = 0
end type

on clicked;IF devolver = "S" THEN
CloseWithReturn(Parent,-1)
ELSE
  CALL Super::clicked
END IF
end on

type pb_1 from upb_imprimir within w_con_planificacion_pendiente
integer x = 3497
integer y = 144
integer width = 96
integer height = 84
integer taborder = 10
boolean originalsize = false
end type

event clicked;f_control(dw_listado)
f_imprimir_datawindow(dw_listado)
end event

type dw_listado from datawindow within w_con_planificacion_pendiente
boolean visible = false
integer x = 23
integer width = 494
integer height = 236
boolean bringtotop = true
string dataobject = "report_con_stock_especificaciones"
boolean livescroll = true
end type

type gb_10 from groupbox within w_con_planificacion_pendiente
integer x = 1728
integer y = 100
integer width = 846
integer height = 144
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_1 from groupbox within w_con_planificacion_pendiente
integer x = 1358
integer y = 100
integer width = 297
integer height = 144
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_2 from groupbox within w_con_planificacion_pendiente
integer x = 5
integer y = 100
integer width = 1353
integer height = 144
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type cb_1 from commandbutton within w_con_planificacion_pendiente
integer x = 814
integer y = 140
integer width = 265
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "SubForm."
end type

event clicked;uo_familia.visible    = False
uo_subfamilia.visible = False
uo_formato.visible    = False
uo_calidad.visible 	 = False

if uo_subformato.visible = True then
   uo_subformato.visible = False
else
	uo_subformato.visible = True
End if
end event

type cb_2 from commandbutton within w_con_planificacion_pendiente
integer x = 1371
integer y = 140
integer width = 270
integer height = 92
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consulta"
end type

event clicked;f_control(dw_1)
end event

type cb_3 from commandbutton within w_con_planificacion_pendiente
integer x = 283
integer y = 140
integer width = 265
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "SubFam."
end type

event clicked;uo_familia.visible    = False
uo_formato.visible    = False
uo_subformato.visible = False
uo_calidad.visible 	 = False

if uo_subfamilia.visible = True then
   uo_subfamilia.visible = False
else
	uo_subfamilia.visible = True
End if
end event

type uo_subformato from u_marca_lista within w_con_planificacion_pendiente
event destroy ( )
boolean visible = false
integer x = 1029
integer y = 360
integer taborder = 130
boolean border = false
end type

on uo_subformato.destroy
call u_marca_lista::destroy
end on

type cb_4 from commandbutton within w_con_planificacion_pendiente
integer x = 18
integer y = 140
integer width = 265
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Familias"
end type

event clicked;uo_subfamilia.visible = False
uo_formato.visible    = False
uo_subformato.visible = False
uo_calidad.visible 	 = False

if uo_familia.visible = True then
   uo_familia.visible = False
else
	uo_familia.visible = True
End if
end event

type cb_5 from commandbutton within w_con_planificacion_pendiente
integer x = 549
integer y = 140
integer width = 265
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Formatos"
end type

event clicked;uo_familia.visible    = False
uo_subfamilia.visible = False
uo_subformato.visible = False
uo_calidad.visible 	 = False

if uo_formato.visible = True then
   uo_formato.visible = False
else
	uo_formato.visible = True
End if
end event

type cb_6 from commandbutton within w_con_planificacion_pendiente
integer x = 1079
integer y = 140
integer width = 265
integer height = 92
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Calidades"
end type

event clicked;uo_subfamilia.visible = False
uo_formato.visible    = False
uo_subformato.visible = False
uo_familia.visible	 = false

if uo_calidad.visible = True then
   uo_calidad.visible = False
else
	uo_calidad.visible = True
End if
end event

type uo_formato from u_marca_lista within w_con_planificacion_pendiente
event destroy ( )
boolean visible = false
integer x = 754
integer y = 360
integer taborder = 80
boolean border = false
end type

on uo_formato.destroy
call u_marca_lista::destroy
end on

type uo_subfamilia from u_marca_lista within w_con_planificacion_pendiente
event destroy ( )
boolean visible = false
integer x = 485
integer y = 360
integer taborder = 120
boolean border = false
end type

on uo_subfamilia.destroy
call u_marca_lista::destroy
end on

type uo_familia from u_marca_lista within w_con_planificacion_pendiente
event destroy ( )
boolean visible = false
integer x = 238
integer y = 360
integer taborder = 100
boolean border = false
end type

on uo_familia.destroy
call u_marca_lista::destroy
end on

type uo_calidad from u_marca_lista within w_con_planificacion_pendiente
event destroy ( )
boolean visible = false
integer x = 1294
integer y = 360
integer taborder = 110
boolean bringtotop = true
boolean border = false
end type

on uo_calidad.destroy
call u_marca_lista::destroy
end on

type dw_1 from u_datawindow_consultas within w_con_planificacion_pendiente
integer x = 5
integer y = 252
integer width = 3611
integer height = 1328
integer taborder = 150
string dataobject = "dw_con_planificacion_pendiente"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event key;string articulo

valor_empresa = TRUE	
bus_filtro    = ""
bus_campo     = This.GetColumnName()
CHOOSE CASE bus_campo
	CASE "version"
		articulo       = this.object.articulo[this.getrow()]
		bus_titulo     = "SELECCION DE VERSIONES DEL ARTICULO "+f_nombre_articulo(codigo_empresa,articulo)
		bus_datawindow = "dw_ayuda_version_articulo"
		bus_filtro     = "articulo = '"+articulo+"'"
	CASE ELSE
		SetNull(bus_campo)
	END CHOOSE
CALL Super::Key
end event

event rbuttondown;string articulo

valor_empresa = TRUE	
bus_filtro    = ""
bus_campo     = This.GetColumnName()
CHOOSE CASE bus_campo
	CASE "version"
		articulo       = this.object.articulo[this.getrow()]
		bus_titulo     = "SELECCION DE VERSIONES DEL ARTICULO "+f_nombre_articulo(codigo_empresa,articulo)
		bus_datawindow = "dw_ayuda_version_articulo"
		bus_filtro     = "articulo = '"+articulo+"'"
	CASE ELSE
		SetNull(bus_campo)
	END CHOOSE
CALL Super::RbuttonDown
end event

event itemerror;return 1
end event

event itemchanged;string var_version,articulo
long   existe

choose case dwo.name
	case "version"
		if trim(data) = '' then
			this.object.planificar[row] = "N"
		else
			var_version = data
			articulo    = this.object.articulo[row]
			
			select count(*)
			into   :existe
			from   prodobsversionart
			where  empresa = :codigo_empresa
			and    articulo = :articulo
			and    version  = :var_version;
			
			if isnull(existe) then existe = 0
			
			if existe = 0 then
				messagebox("Atención","Versión no valida.")
				return 2
			end if
		end if
	case "cantidad_fabricar"
		if dec(data) <= 0 then
			this.object.planificar[row] = "N"
		end if
end choose
end event

type uo_1 from u_manejo_datawindow within w_con_planificacion_pendiente
integer x = 3017
integer y = 96
end type

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

event valores;call super::valores;dw_data=dw_1

end event

type cb_10 from commandbutton within w_con_planificacion_pendiente
integer x = 1742
integer y = 140
integer width = 818
integer height = 92
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Generar Producción Pendiente"
end type

event clicked;f_generar_produccion_pendiente()
cb_2.triggerevent(clicked!)
end event

