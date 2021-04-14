$PBExportHeader$wtc_consulta_productividad_clientes.srw
forward
global type wtc_consulta_productividad_clientes from w_int_con_empresa
end type
type pb_2 from upb_salir within wtc_consulta_productividad_clientes
end type
type cb_consulta from commandbutton within wtc_consulta_productividad_clientes
end type
type pb_imprimir_preli from upb_imprimir within wtc_consulta_productividad_clientes
end type
type st_titulo from statictext within wtc_consulta_productividad_clientes
end type
type p_logo from picture within wtc_consulta_productividad_clientes
end type
type dw_1 from datawindow within wtc_consulta_productividad_clientes
end type
type uo_disenyador from u_em_campo_2 within wtc_consulta_productividad_clientes
end type
type ddlb_grafica from dropdownlistbox within wtc_consulta_productividad_clientes
end type
type em_fhasta from u_em_campo within wtc_consulta_productividad_clientes
end type
type em_fdesde from u_em_campo within wtc_consulta_productividad_clientes
end type
type dw_colecciones from u_seleccion within wtc_consulta_productividad_clientes
end type
type st_colecciones from statictext within wtc_consulta_productividad_clientes
end type
type cb_cerrar from commandbutton within wtc_consulta_productividad_clientes
end type
type cb_mostrar from commandbutton within wtc_consulta_productividad_clientes
end type
type rb_cliente from radiobutton within wtc_consulta_productividad_clientes
end type
type st_1 from statictext within wtc_consulta_productividad_clientes
end type
type rb_comercial from radiobutton within wtc_consulta_productividad_clientes
end type
type gb_3 from groupbox within wtc_consulta_productividad_clientes
end type
type gb_4 from groupbox within wtc_consulta_productividad_clientes
end type
type gb_com from groupbox within wtc_consulta_productividad_clientes
end type
end forward

global type wtc_consulta_productividad_clientes from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 5719
integer height = 3756
string title = "Informe de Productividad de Clientes"
long backcolor = 67108864
string icon = "Application!"
pb_2 pb_2
cb_consulta cb_consulta
pb_imprimir_preli pb_imprimir_preli
st_titulo st_titulo
p_logo p_logo
dw_1 dw_1
uo_disenyador uo_disenyador
ddlb_grafica ddlb_grafica
em_fhasta em_fhasta
em_fdesde em_fdesde
dw_colecciones dw_colecciones
st_colecciones st_colecciones
cb_cerrar cb_cerrar
cb_mostrar cb_mostrar
rb_cliente rb_cliente
st_1 st_1
rb_comercial rb_comercial
gb_3 gb_3
gb_4 gb_4
gb_com gb_com
end type
global wtc_consulta_productividad_clientes wtc_consulta_productividad_clientes

type variables
String	is_codigo,ante_articulo,var_calidad,var_tipo_pallet,var_cliente,var_envio
Integer   var_tono,var_calibre
String  devolver
String var_moneda,var_mascara
string productos_marcados[]
end variables

event open;call super::open;long indice
int anyo, mes, dia
String consulta_seleccion

This.title = "Informe de Productividad de Clientes"
this.st_titulo.text = this.st_empresa.text

dw_1.SetTransObject(sqlca)
dw_colecciones.SetTransObject(sqlca)
consulta_seleccion =   "SELECT deshistorico.coleccion,"+&   
         				  "			 descoleccionsol.descripcion, "+&
							  "			 0 as seleccionado "+&
							  "FROM   descoleccionsol INNER JOIN deshistorico ON deshistorico.empresa = descoleccionsol.empresa AND deshistorico.coleccion = descoleccionsol.codigo "+&
							  "WHERE ( deshistorico.empresa = '"+codigo_empresa+"') AND  "+&
							  "      ( deshistorico.cliente = '"+uo_disenyador.em_codigo.text+"' ) "+&
							  "ORDER BY descripcion DESC"

dw_colecciones.SetSQLSelect(consulta_seleccion)


ddlb_grafica.text = '%'

em_fdesde.text = string(RelativeDate(today(), - 90),"dd-mm-yy") 
em_fhasta.text = string(today(), "dd-mm-yy")






end event

on wtc_consulta_productividad_clientes.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.cb_consulta=create cb_consulta
this.pb_imprimir_preli=create pb_imprimir_preli
this.st_titulo=create st_titulo
this.p_logo=create p_logo
this.dw_1=create dw_1
this.uo_disenyador=create uo_disenyador
this.ddlb_grafica=create ddlb_grafica
this.em_fhasta=create em_fhasta
this.em_fdesde=create em_fdesde
this.dw_colecciones=create dw_colecciones
this.st_colecciones=create st_colecciones
this.cb_cerrar=create cb_cerrar
this.cb_mostrar=create cb_mostrar
this.rb_cliente=create rb_cliente
this.st_1=create st_1
this.rb_comercial=create rb_comercial
this.gb_3=create gb_3
this.gb_4=create gb_4
this.gb_com=create gb_com
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.cb_consulta
this.Control[iCurrent+3]=this.pb_imprimir_preli
this.Control[iCurrent+4]=this.st_titulo
this.Control[iCurrent+5]=this.p_logo
this.Control[iCurrent+6]=this.dw_1
this.Control[iCurrent+7]=this.uo_disenyador
this.Control[iCurrent+8]=this.ddlb_grafica
this.Control[iCurrent+9]=this.em_fhasta
this.Control[iCurrent+10]=this.em_fdesde
this.Control[iCurrent+11]=this.dw_colecciones
this.Control[iCurrent+12]=this.st_colecciones
this.Control[iCurrent+13]=this.cb_cerrar
this.Control[iCurrent+14]=this.cb_mostrar
this.Control[iCurrent+15]=this.rb_cliente
this.Control[iCurrent+16]=this.st_1
this.Control[iCurrent+17]=this.rb_comercial
this.Control[iCurrent+18]=this.gb_3
this.Control[iCurrent+19]=this.gb_4
this.Control[iCurrent+20]=this.gb_com
end on

on wtc_consulta_productividad_clientes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.cb_consulta)
destroy(this.pb_imprimir_preli)
destroy(this.st_titulo)
destroy(this.p_logo)
destroy(this.dw_1)
destroy(this.uo_disenyador)
destroy(this.ddlb_grafica)
destroy(this.em_fhasta)
destroy(this.em_fdesde)
destroy(this.dw_colecciones)
destroy(this.st_colecciones)
destroy(this.cb_cerrar)
destroy(this.cb_mostrar)
destroy(this.rb_cliente)
destroy(this.st_1)
destroy(this.rb_comercial)
destroy(this.gb_3)
destroy(this.gb_4)
destroy(this.gb_com)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within wtc_consulta_productividad_clientes
integer x = 2939
integer y = 20
integer width = 2107
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within wtc_consulta_productividad_clientes
boolean visible = false
end type

type st_empresa from w_int_con_empresa`st_empresa within wtc_consulta_productividad_clientes
boolean visible = false
integer width = 869
integer height = 84
end type

type pb_2 from upb_salir within wtc_consulta_productividad_clientes
integer x = 5527
integer y = 140
integer width = 146
integer height = 128
integer taborder = 0
boolean originalsize = true
string picturename = "C:\TENCER_PB12\Log Out_24x24Gris.png"
end type

on clicked;IF devolver = "S" THEN
CloseWithReturn(Parent,-1)
ELSE
  CALL Super::clicked
END IF
end on

type cb_consulta from commandbutton within wtc_consulta_productividad_clientes
event clicked pbm_bnclicked
integer x = 4983
integer y = 140
integer width = 361
integer height = 128
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consulta"
end type

event clicked;Datetime desde, hasta
String consulta, cliente, cliente_nombre, filtro_colecciones
Long i, fila_actual, colecciones, colecciones_produccion, modelos, modelos_produccion, piezas, piezas_produccion, trabajos_periodo, modelos_periodo, piezas_periodo, altas_periodo, pruebas_lab
Dec ventas
Datastore clientes, resultado_consulta

dw_1.object.t_desde.text = String(em_fdesde.text)
dw_1.object.t_hasta.text = String(em_fhasta.text)

desde = datetime(date(em_fdesde.text))
hasta = datetime(date(em_fhasta.text))

dw_1.reset()

if rb_cliente.checked = true then
	if uo_disenyador.em_codigo.text = "" or isnull(uo_disenyador.em_codigo.text) then
		cliente = ''
	else
		cliente = " and genter.codigo LIKE '"+uo_disenyador.em_codigo.text+"' "
	end if
else
	if uo_disenyador.em_codigo.text = "" or isnull(uo_disenyador.em_codigo.text) then
		cliente = ''
	else
		cliente = " and genter.codigo IN ((SELECT venclientes.codigo AS cliente FROM venclientes WHERE venclientes.agente1 = '"+uo_disenyador.em_codigo.text+"'  UNION  SELECT venclientes.codigo AS cliente FROM venclientes WHERE venclientes.agente2 = '"+uo_disenyador.em_codigo.text+"')) "
	end if
end if

filtro_colecciones = f_reemplazar(dw_colecciones.devolver_resultado(), "deshistorico.coleccion", "descoleccionsol.codigo")
if isnull(filtro_colecciones) or filtro_colecciones = "" or filtro_colecciones = "()" then
	filtro_colecciones = " 1 = 1 "
end if

//Diseñadores seleccionados / Todos
consulta =  " select codigo, razon "+&
				" from genter "+&
				" where empresa = '"+codigo_empresa+"' "+&
				" and tipoter = 'C' "+cliente+&				
				" and exists (SELECT * FROM modelo_cliente WHERE cliente = genter.codigo) "+&
				" order by razon "

f_cargar_cursor_nuevo (consulta, clientes)

for i = 1 to clientes.rowcount()
	
	cliente = clientes.object.codigo[i]
	cliente_nombre = clientes.object.razon[i]
	
	//Modificación Filtro por coleccion
	//Solicitud Jesus 30 - 05 -2013
	
//	select count(*)
//	into :colecciones
//	from descoleccionsol
//	where descoleccionsol.empresa = :codigo_empresa
//	and descoleccionsol.grafica like :ddlb_grafica.text
//	and descoleccionsol.fecha_coleccion >= :desde 
//	and descoleccionsol.fecha_coleccion <= :hasta 
//	and exists	(SELECT * FROM modelo_cliente 
//					INNER JOIN modelo ON modelo_cliente.empresa = modelo.empresa AND modelo_cliente.modelo = modelo.modelo 
//					WHERE modelo_cliente.empresa = descoleccionsol.empresa AND modelo_cliente.cliente = :cliente AND modelo.coleccion = descoleccionsol.codigo);

	consulta = "select count(*) as colecciones "+&
				  "from descoleccionsol "+&
				  "where descoleccionsol.empresa = '"+codigo_empresa+"' "+&
				  "and descoleccionsol.grafica like '"+ddlb_grafica.text+"' "+&
				  "and descoleccionsol.fecha_coleccion >= '"+String(desde, "dd-mm-yyyy")+"'  "+&
				  "and descoleccionsol.fecha_coleccion <= '"+String(hasta, "dd-mm-yyyy")+"'  "+&
				  "and "+filtro_colecciones+" "+&
				  "and exists	(SELECT * FROM modelo_cliente  "+&
				  "				INNER JOIN modelo ON modelo_cliente.empresa = modelo.empresa AND modelo_cliente.modelo = modelo.modelo  "+&
				  "				WHERE modelo_cliente.empresa = descoleccionsol.empresa AND modelo_cliente.cliente = '"+cliente+"' AND modelo.coleccion = descoleccionsol.codigo)";
					
	f_cargar_cursor_nuevo (consulta, resultado_consulta)
	colecciones = resultado_consulta.object.colecciones[resultado_consulta.rowcount()]
	
	if isnull(colecciones) then colecciones = 0
	
	//Colecciones en producción
	
//	select count(*)
//	into :colecciones_produccion
//	from descoleccionsol
//	where empresa = :codigo_empresa
//	and grafica like :ddlb_grafica.text
//	and fecha_coleccion >= :desde 
//	and fecha_coleccion <= :hasta
//	and exists	(SELECT * FROM modelo_cliente 
//					INNER JOIN modelo ON modelo_cliente.empresa = modelo.empresa AND modelo_cliente.modelo = modelo.modelo 
//					WHERE modelo_cliente.empresa = descoleccionsol.empresa 
//					AND modelo_cliente.cliente = :cliente 
//					AND modelo.coleccion = descoleccionsol.codigo
//					AND modelo.modelo IN(SELECT articulos.modelo_origen FROM articulos));
					
	consulta = "select count(*) as colecciones_produccion "+&
				  "from descoleccionsol "+&
				  "where empresa = '"+codigo_empresa+"' "+&
				  "and grafica like '"+ddlb_grafica.text+"' "+&
				  "and fecha_coleccion >= '"+String(desde, "dd-mm-yyyy")+"' "+&
				  "and fecha_coleccion <= '"+String(hasta, "dd-mm-yyyy")+"' "+&
				  "and "+filtro_colecciones+" "+&
				  "and exists	(SELECT * FROM modelo_cliente  "+&
				  "				INNER JOIN modelo ON modelo_cliente.empresa = modelo.empresa AND modelo_cliente.modelo = modelo.modelo  "+&
				  "				WHERE modelo_cliente.empresa = descoleccionsol.empresa  "+&
				  "				AND modelo_cliente.cliente = '"+cliente+"'  "+&
				  "				AND modelo.coleccion = descoleccionsol.codigo "+&
				  "				AND modelo.modelo IN(SELECT articulos.modelo_origen FROM articulos))";
					
	f_cargar_cursor_nuevo (consulta, resultado_consulta)
	colecciones_produccion = resultado_consulta.object.colecciones_produccion[resultado_consulta.rowcount()]
	
	if isnull(colecciones_produccion) then colecciones_produccion = 0
	
	//Modelos
//	select count(*)
//	into :modelos
//	from modelo 
//	where empresa = :codigo_empresa 
//	and exists	(SELECT * FROM modelo_cliente
//					WHERE modelo_cliente.empresa = modelo.empresa AND modelo_cliente.cliente = :cliente AND modelo_cliente.modelo = modelo.modelo)
//	and modelo.coleccion IN 	(SELECT codigo FROM descoleccionsol 
//										WHERE grafica like :ddlb_grafica.text 
//										and fecha_coleccion >= :desde 
//										and fecha_coleccion <= :hasta);
	
	consulta = "select count(*) as modelos "+&
				  "from modelo "+&
				  "where empresa = '"+codigo_empresa+"' "+&
				  "and exists	(SELECT * FROM modelo_cliente "+&
				  "				 WHERE modelo_cliente.empresa = modelo.empresa AND modelo_cliente.cliente = '"+cliente+"' AND modelo_cliente.modelo = modelo.modelo) "+&
				  "			 	 and modelo.coleccion IN 	(SELECT codigo FROM descoleccionsol "+&
				  "													WHERE grafica like '"+ddlb_grafica.text+"' "+&
				  "													and "+filtro_colecciones+" "+&
				  "													and fecha_coleccion >= '"+String(desde, "dd-mm-yyyy")+"' "+&
				  "													and fecha_coleccion <= '"+String(hasta, "dd-mm-yyyy")+"')";
					
	f_cargar_cursor_nuevo (consulta, resultado_consulta)
	modelos = resultado_consulta.object.modelos[resultado_consulta.rowcount()]
	
	if isnull (modelos) then modelos = 0
	
	//Modelos en producción
//	select count(*)
//	into :modelos_produccion
//	from modelo 
//	where empresa = :codigo_empresa 
//	and modelo IN(SELECT articulos.modelo_origen FROM articulos) 
//	and exists	(SELECT * FROM modelo_cliente 
//					WHERE modelo_cliente.empresa = modelo.empresa AND modelo_cliente.cliente = :cliente AND modelo_cliente.modelo = modelo.modelo)
//	and modelo.coleccion IN 	(SELECT codigo FROM descoleccionsol 
//										WHERE grafica like :ddlb_grafica.text 
//										and fecha_coleccion >= :desde 
//										and fecha_coleccion <= :hasta);
										
	consulta = "select count(*) as modelos_produccion "+&
				  "from modelo "+&
				  "where empresa = '"+codigo_empresa+"' "+&
				  "and modelo IN(SELECT articulos.modelo_origen FROM articulos) "+&
				  "and exists	(SELECT * FROM modelo_cliente "+&
				  "				WHERE modelo_cliente.empresa = modelo.empresa AND modelo_cliente.cliente = '"+cliente+"' AND modelo_cliente.modelo = modelo.modelo) "+&
				  "				and modelo.coleccion IN 	(SELECT codigo FROM descoleccionsol "+&
				  "													WHERE grafica like '"+ddlb_grafica.text+"' "+&
				  "													and "+filtro_colecciones+" "+&
				  "													and fecha_coleccion >= '"+String(desde, "dd-mm-yyyy")+"' "+&
				  "													and fecha_coleccion <= '"+String(hasta, "dd-mm-yyyy")+"')";
					
	f_cargar_cursor_nuevo (consulta, resultado_consulta)
	modelos_produccion = resultado_consulta.object.modelos_produccion[resultado_consulta.rowcount()]
	
	if isnull (modelos_produccion) then modelos_produccion = 0
	
	//Piezas
//	select count(modelo_pieza.codigo)
//	into :piezas 
//	from modelo_pieza 
//	where modelo_pieza.empresa = :codigo_empresa 
//	and modelo_pieza.cliente = :cliente 
//	and modelo_pieza.modelo IN 
//	(SELECT modelo.modelo FROM modelo 
//	WHERE modelo.coleccion IN 
//	(SELECT descoleccionsol.codigo FROM descoleccionsol 
//	WHERE descoleccionsol.grafica like :ddlb_grafica.text 
//	and descoleccionsol.fecha_coleccion >= :desde 
//	and descoleccionsol.fecha_coleccion <= :hasta));
	
	consulta = "select count(*) as piezas "+&
				  "from modelo_pieza "+&
				  "where modelo_pieza.empresa = '"+codigo_empresa+"' "+&
				  "and modelo_pieza.cliente = '"+cliente+"' "+&
				  "and modelo_pieza.modelo IN  "+&
					  "(SELECT modelo.modelo FROM modelo "+&
					  "WHERE modelo.coleccion IN "+&
						  "(SELECT descoleccionsol.codigo FROM descoleccionsol "+&
						  "WHERE descoleccionsol.grafica like '"+ddlb_grafica.text+"' "+&
						  "and "+filtro_colecciones+" "+&
						  "and descoleccionsol.fecha_coleccion >= '"+String(desde, "dd-mm-yyyy")+"' "+&
						  "and descoleccionsol.fecha_coleccion <= '"+String(hasta, "dd-mm-yyyy")+"'))";
					
	f_cargar_cursor_nuevo (consulta, resultado_consulta)
	piezas = resultado_consulta.object.piezas[resultado_consulta.rowcount()]
	
	if isnull (piezas) then piezas = 0
	
	//Piezas en producción
//	select count(DISTINCT modelo_pieza.codigo_lab)
//	into :piezas_produccion
//	from modelo_pieza
//	where modelo_pieza.empresa = :codigo_empresa 
//	and modelo_pieza.cliente = :cliente 
//	and modelo_pieza.codigo_lab IN(SELECT articulos.pieza_origen FROM articulos) 
//	and modelo_pieza.modelo IN 
//	(SELECT modelo.modelo FROM modelo
//	WHERE modelo.coleccion IN 
//	(SELECT codigo FROM descoleccionsol 
//	WHERE grafica like :ddlb_grafica.text 
//	and fecha_coleccion >= :desde 
//	and fecha_coleccion <= :hasta));
	
	consulta = "select count(*) as piezas_produccion "+&
				  "from modelo_pieza "+&
				  "where modelo_pieza.empresa = '"+codigo_empresa+"' "+&
				  "and modelo_pieza.cliente = '"+cliente+"' "+&
				  "and modelo_pieza.codigo_lab IN(SELECT articulos.pieza_origen FROM articulos) "+&
				  "and modelo_pieza.modelo IN "+&
					  "(SELECT modelo.modelo FROM modelo "+&
					  "WHERE modelo.coleccion IN "+&
						  "(SELECT descoleccionsol.codigo FROM descoleccionsol "+&
						  "WHERE descoleccionsol.grafica like '"+ddlb_grafica.text+"' "+&
						  "and "+filtro_colecciones+" "+&
						  "and descoleccionsol.fecha_coleccion >= '"+String(desde, "dd-mm-yyyy")+"' "+&
						  "and descoleccionsol.fecha_coleccion <= '"+String(hasta, "dd-mm-yyyy")+"'))";
				
	f_cargar_cursor_nuevo (consulta, resultado_consulta)
	piezas_produccion = resultado_consulta.object.piezas_produccion[resultado_consulta.rowcount()]
	
	if isnull (piezas_produccion) then piezas_produccion = 0
	
	//VENTAS
//	select  sum( venlifac.neto / venlifac.cambio)
//	into :ventas
//	from  modelo, descoleccionsol, articulos, venlifac
//	where venlifac.empresa = :codigo_empresa
//	and venlifac.empresa = articulos.empresa 
//	and venlifac.cliente = :cliente 
//	and venlifac.articulo = articulos.codigo 
//	and articulos.empresa = modelo.empresa
//	and articulos.modelo_origen = modelo.modelo
//	and modelo.empresa = descoleccionsol.empresa 
//	and modelo.coleccion = descoleccionsol.codigo 
//	and descoleccionsol.grafica like :ddlb_grafica.text
//	and descoleccionsol.fecha_coleccion >= :desde 
//	and descoleccionsol.fecha_coleccion <= :hasta;
	
	consulta = "select sum(ISNULL(venlifac.importe, 0)) as ventas "+&
				  "from  modelo, descoleccionsol, articulos, venlifac "+&
				  "where venlifac.empresa = '"+codigo_empresa+"' "+&
				  "and venlifac.empresa = articulos.empresa "+&
				  "and venlifac.cliente = '"+cliente+"' "+&
				  "and venlifac.articulo = articulos.codigo "+&
				  "and articulos.empresa = modelo.empresa "+&
				  "and articulos.modelo_origen = modelo.modelo "+&
				  "and modelo.empresa = descoleccionsol.empresa "+&
				  "and modelo.coleccion = descoleccionsol.codigo "+&
				  "and "+filtro_colecciones+" "+&
				  "and descoleccionsol.grafica like '"+ddlb_grafica.text+"' "+&
				  "and descoleccionsol.fecha_coleccion >= '"+String(desde, "dd-mm-yyyy")+"' "+&
				  "and descoleccionsol.fecha_coleccion <= '"+String(hasta, "dd-mm-yyyy")+"'";
				
	f_cargar_cursor_nuevo (consulta, resultado_consulta)
	ventas = resultado_consulta.object.ventas[resultado_consulta.rowcount()]
	
	if isnull (ventas) then ventas = 0
	
	//Cantidad de trabajo realizado
	
	//Trabajos
//	select count(*)
//	into :trabajos_periodo
//	from modelo_trabajo
//	where empresa = :codigo_empresa
//	and cliente = :cliente 
//	and fecha_fin >= :desde 
//	and fecha_fin <= :hasta;
	
	if filtro_colecciones = " 1 = 1 " then
		consulta = "select count(*) as trabajos_periodo "+&
					  "from modelo_trabajo "+&
					  "where empresa = '"+codigo_empresa+"' "+&
					  "and cliente = '"+cliente+"' "+&
					  "and fecha_fin >= '"+String(desde, "dd-mm-yyyy")+"' "+&
					  "and fecha_fin <= '"+String(hasta, "dd-mm-yyyy")+"'";
	else
		consulta = "select count(*) as trabajos_periodo "+&
					  "from modelo_trabajo "+&
					  "where empresa = '"+codigo_empresa+"' "+&
					  "and cliente = '"+cliente+"' "+&
					  "and fecha_fin >= '"+String(desde, "dd-mm-yyyy")+"' "+&
					  "and fecha_fin <= '"+String(hasta, "dd-mm-yyyy")+"' "+&
					  "and modelo_trabajo.modelo IN (SELECT modelo "+&
					  "										FROM modelo INNER JOIN descoleccionsol ON modelo.empresa = descoleccionsol.empresa AND modelo.coleccion = descoleccionsol.codigo "+&
					  "										WHERE "+filtro_colecciones+")";
	end if
								
	f_cargar_cursor_nuevo (consulta, resultado_consulta)
	trabajos_periodo = resultado_consulta.object.trabajos_periodo[resultado_consulta.rowcount()]

	if isnull (trabajos_periodo) then trabajos_periodo = 0
	
/*		DAVID
	// Pruebas laboratorio Período
	
	if filtro_colecciones = " 1 = 1 " then
		consulta = "select count(*) as pruebas_lab "+&
					  "from modelo_prueba "+&
					  "where empresa = '"+codigo_empresa+"' "+&
					  "and cliente = '"+cliente+"' "+&
					  "and fecha_fin >= '"+String(desde, "dd-mm-yyyy")+"' "+&
					  "and fecha_fin <= '"+String(hasta, "dd-mm-yyyy")+"'";
	else
		consulta = "select count(*) as trabajos_periodo "+&
					  "from modelo_trabajo "+&
					  "where empresa = '"+codigo_empresa+"' "+&
					  "and cliente = '"+cliente+"' "+&
					  "and fecha_fin >= '"+String(desde, "dd-mm-yyyy")+"' "+&
					  "and fecha_fin <= '"+String(hasta, "dd-mm-yyyy")+"' "+&
					  "and modelo_trabajo.modelo IN (SELECT modelo "+&
					  "										FROM modelo INNER JOIN descoleccionsol ON modelo.empresa = descoleccionsol.empresa AND modelo.coleccion = descoleccionsol.codigo "+&
					  "										WHERE "+filtro_colecciones+")";
	end if
								
	f_cargar_cursor_nuevo (consulta, resultado_consulta)
	pruebas_lab = resultado_consulta.object.trabajos_periodo[resultado_consulta.rowcount()]

	if isnull (pruebas_lab ) then pruebas_lab  = 0
	*/
	
	//Modelos
//	select count(DISTINCT modelo.modelo)
//	into :modelos_periodo 
//	from modelo 
//	where modelo.empresa = :codigo_empresa
//	and exists (SELECT * FROM modelo_trabajo T1 
//					WHERE T1.empresa = modelo.empresa 
//					AND T1.modelo = modelo.modelo 
//					and T1.cliente = :cliente 
//					AND T1.fecha_fin >= :desde 
//					AND T1.fecha_fin <= :hasta 
//					AND T1.fecha_fin = (SELECT MIN(T2.fecha_fin) FROM modelo_trabajo T2 
//												WHERE T2.empresa = modelo.empresa 
//												AND T2.modelo = modelo.modelo));
	
	if filtro_colecciones = " 1 = 1 " then
		consulta = "select count(*) as modelos_periodo "+&
					  "from modelo "+&
					  "where modelo.empresa = '"+codigo_empresa+"' "+&
					  "and exists (SELECT * FROM modelo_trabajo T1 "+&
					  "			WHERE T1.empresa = modelo.empresa "+&
					  "			AND T1.modelo = modelo.modelo "+&
					  "			and T1.cliente = '"+cliente+"' "+&
					  "			AND T1.fecha_fin >= '"+String(desde, "dd-mm-yyyy")+"' "+&
					  "			AND T1.fecha_fin <= '"+String(hasta, "dd-mm-yyyy")+"' "+&
					  "			AND T1.fecha_fin = (SELECT MIN(T2.fecha_fin) FROM modelo_trabajo T2 "+&
					  "										WHERE T2.empresa = modelo.empresa "+&
					  "										AND T2.modelo = modelo.modelo))";
					  
	else
		consulta = "select count(*) as modelos_periodo "+&
					  "from modelo INNER JOIN descoleccionsol ON modelo.empresa = descoleccionsol.empresa AND modelo.coleccion = descoleccionsol.codigo "+&
					  "where modelo.empresa = '"+codigo_empresa+"' "+&
					  "and "+filtro_colecciones+" "+&
					  "and exists (SELECT * FROM modelo_trabajo T1 "+&
					  "			WHERE T1.empresa = modelo.empresa "+&
					  "			AND T1.modelo = modelo.modelo "+&
					  "			and T1.cliente = '"+cliente+"' "+&
					  "			AND T1.fecha_fin >= '"+String(desde, "dd-mm-yyyy")+"' "+&
					  "			AND T1.fecha_fin <= '"+String(hasta, "dd-mm-yyyy")+"' "+&
					  "			AND T1.fecha_fin = (SELECT MIN(T2.fecha_fin) FROM modelo_trabajo T2 "+&
					  "										WHERE T2.empresa = modelo.empresa "+&
					  "										AND T2.modelo = modelo.modelo))";
	end if
								
	f_cargar_cursor_nuevo (consulta, resultado_consulta)
	modelos_periodo = resultado_consulta.object.modelos_periodo[resultado_consulta.rowcount()]
	
	if isnull (modelos_periodo) then modelos_periodo = 0
	
	//Piezas
//	select count(modelo_pieza.codigo_lab)
//	into :piezas_periodo 
//	from modelo_pieza 
//	where modelo_pieza.empresa = :codigo_empresa
//	and modelo_pieza.cliente = :cliente 
//	and modelo_pieza.fecha_lab >= :desde 
//	AND modelo_pieza.fecha_lab <= :hasta;
	
	if filtro_colecciones = " 1 = 1 " then
		consulta = "select count(*) as piezas_periodo "+&
					  "from modelo_pieza "+&
					  "where modelo_pieza.empresa = '"+codigo_empresa+"' "+&
					  "and modelo_pieza.cliente = '"+cliente+"' "+&
					  "and modelo_pieza.fecha_lab >= '"+String(desde, "dd-mm-yyyy")+"' "+&
					  "AND modelo_pieza.fecha_lab <= '"+String(hasta, "dd-mm-yyyy")+"'";	  
	else
		consulta = "select count(*) as piezas_periodo "+&
					  "from modelo_pieza "+&
					  "INNER JOIN modelo ON modelo_pieza.empresa = modelo.empresa AND modelo_pieza.modelo = modelo.modelo "+&
					  "INNER JOIN descoleccionsol ON modelo.empresa = descoleccionsol.empresa AND modelo.coleccion = descoleccionsol.codigo "+&
					  "where modelo_pieza.empresa = '"+codigo_empresa+"' "+&
					  "and "+filtro_colecciones+" "+&
					  "and modelo_pieza.cliente = '"+cliente+"' "+&
					  "and modelo_pieza.fecha_lab >= '"+String(desde, "dd-mm-yyyy")+"' "+&
					  "AND modelo_pieza.fecha_lab <= '"+String(hasta, "dd-mm-yyyy")+"'";
	end if
								
	f_cargar_cursor_nuevo (consulta, resultado_consulta)
	piezas_periodo = resultado_consulta.object.piezas_periodo[resultado_consulta.rowcount()]
	
	if isnull (piezas_periodo) then piezas_periodo = 0
	
	//Altas
//	select count(DISTINCT modelo.modelo)
//	into :altas_periodo
//	from articulos, modelo
//	where articulos.empresa = :codigo_empresa 
//	and articulos.empresa = modelo.empresa 
//	and articulos.modelo_origen = modelo.modelo 
//	and articulos.cliente = :cliente 
//	and articulos.fecha_alta >= :desde 
//	and articulos.fecha_alta <= :hasta;
	
	if filtro_colecciones = " 1 = 1 " then
		consulta = "select count(*) as altas_periodo "+&
					  "from articulos, modelo "+&
					  "where articulos.empresa = '"+codigo_empresa+"' "+&
					  "and articulos.empresa = modelo.empresa "+&
					  "and articulos.modelo_origen = modelo.modelo "+&
					  "and articulos.cliente = '"+cliente+"' "+&
					  "and articulos.fecha_alta >= '"+String(desde, "dd-mm-yyyy")+"' "+&
					  "and articulos.fecha_alta <= '"+String(hasta, "dd-mm-yyyy")+"'";
	else
		consulta = "select count(*) as altas_periodo "+&
					  "from articulos "+&
					  "INNER JOIN modelo ON articulos.empresa = modelo.empresa AND articulos.modelo_origen = modelo.modelo "+&
					  "INNER JOIN descoleccionsol ON modelo.empresa = descoleccionsol.empresa AND modelo.coleccion = descoleccionsol.codigo "+&
					  "where articulos.empresa = '"+codigo_empresa+"' "+&
					  "and "+filtro_colecciones+" "+&
					  "and articulos.cliente = '"+cliente+"' "+&
					  "and articulos.fecha_alta >= '"+String(desde, "dd-mm-yyyy")+"' "+&
					  "and articulos.fecha_alta <= '"+String(hasta, "dd-mm-yyyy")+"'";
	end if
								
	f_cargar_cursor_nuevo (consulta, resultado_consulta)
	altas_periodo = resultado_consulta.object.altas_periodo[resultado_consulta.rowcount()]
	
	if isnull (altas_periodo) then altas_periodo = 0
	
	
	//PRUEBAS pruebas_lab
	
	if filtro_colecciones = " 1 = 1 " then
		consulta = "select count(*) as pruebas_lab "+&
					  "from modelo_prueba "+&
					  "where modelo_prueba.empresa = '"+codigo_empresa+"' "+&
					  "and modelo_prueba.cliente = '"+cliente+"' "+&
					  "and modelo_prueba.fecha_prueba >= '"+String(desde, "dd-mm-yyyy")+"' "+&
					  "and modelo_prueba.fecha_prueba <= '"+String(hasta, "dd-mm-yyyy")+"'";
	else
		consulta = "select count(*) as pruebas_lab "+&
					  "from modelo_prueba "+&
					  "INNER JOIN modelo ON modelo_prueba.empresa = modelo.empresa AND modelo_prueba.modelo = modelo.modelo "+&
					  "INNER JOIN descoleccionsol ON modelo.empresa = descoleccionsol.empresa AND modelo.coleccion = descoleccionsol.codigo "+&
					  "where modelo_prueba.empresa = '"+codigo_empresa+"' "+&
					  "and "+filtro_colecciones+" "+&
					  "and modelo_prueba.cliente = '"+cliente+"' "+&
					  "and modelo_prueba.fecha_prueba >= '"+String(desde, "dd-mm-yyyy")+"' "+&
					  "and modelo_prueba.fecha_prueba <= '"+String(hasta, "dd-mm-yyyy")+"'";
	end if
								
	f_cargar_cursor_nuevo (consulta, resultado_consulta)
	pruebas_lab = resultado_consulta.object.pruebas_lab[resultado_consulta.rowcount()]
	
	if isnull (pruebas_lab) then pruebas_lab = 0
	
	//Datos al DW
	fila_actual = dw_1.insertrow(0)
	
	dw_1.object.cliente[fila_actual] = cliente_nombre
	dw_1.object.colecciones[fila_actual] = colecciones
	dw_1.object.colecciones_produccion[fila_actual] = colecciones_produccion
	dw_1.object.modelos[fila_actual] = modelos
	dw_1.object.modelos_produccion[fila_actual] = modelos_produccion
	dw_1.object.piezas[fila_actual] = piezas
	dw_1.object.piezas_produccion[fila_actual] = piezas_produccion
	dw_1.object.ventas[fila_actual] = ventas
	dw_1.object.trabajos_periodo[fila_actual] = trabajos_periodo
	dw_1.object.modelos_periodo[fila_actual] = modelos_periodo
	dw_1.object.piezas_periodo[fila_actual] = piezas_periodo
	dw_1.object.altas_periodo[fila_actual] = altas_periodo
	dw_1.object.pruebas_lab[fila_actual] = pruebas_lab
	
next

dw_colecciones.visible = false
cb_cerrar.visible = false
cb_mostrar.visible = true

Destroy clientes
Destroy resultado_consulta
end event

type pb_imprimir_preli from upb_imprimir within wtc_consulta_productividad_clientes
event clicked pbm_bnclicked
integer x = 5362
integer y = 140
integer width = 146
integer height = 128
integer taborder = 0
string picturename = "C:\TENCER_PB12\printer-icon2_24x24.png"
end type

event clicked;f_imprimir_datawindow(dw_1)

end event

type st_titulo from statictext within wtc_consulta_productividad_clientes
integer x = 23
integer y = 20
integer width = 859
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 23016974
long backcolor = 553648127
string text = "Nombre Empresa"
boolean focusrectangle = false
end type

type p_logo from picture within wtc_consulta_productividad_clientes
integer x = 5157
integer y = 16
integer width = 517
integer height = 96
boolean bringtotop = true
string picturename = "C:\Tencer_PB12\tencer24.jpg"
boolean focusrectangle = false
end type

type dw_1 from datawindow within wtc_consulta_productividad_clientes
integer x = 27
integer y = 316
integer width = 5637
integer height = 3252
integer taborder = 60
string title = "none"
string dataobject = "dwtc_productividad_clientes"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event clicked;Choose Case dwo.name
	Case "t_disenyador"
		dw_1.setsort("disenyador ASC")
	Case "t_colecciones"
		dw_1.setsort("colecciones DESC")
	Case "t_colecciones_produccion"
		dw_1.setsort("colecciones_produccion DESC")
	Case "t_colecciones_porcentaje"
		dw_1.setsort("colecciones_porcentaje DESC")
	Case "t_colecciones_porcentaje_total"
		dw_1.setsort("colecciones_porcentaje_total DESC")
	Case "t_modelos"
		dw_1.setsort("modelos DESC")
	Case "t_modelos_produccion"
		dw_1.setsort("modelos_produccion DESC")
	Case "t_modelos_porcentaje"
		dw_1.setsort("modelos_porcentaje DESC")	
	Case "t_piezas"
		dw_1.setsort("piezas DESC")
	Case "t_piezas_produccion"
		dw_1.setsort("piezas_produccion DESC")
	Case "t_piezas_porcentaje"
		dw_1.setsort("piezas_porcentaje DESC")	
	Case "t_ventas"
		dw_1.setsort("ventas DESC")
	Case "t_ventas_porcentaje_total"
		dw_1.setsort("ventas_porcentaje_total DESC")	
	Case "t_trabajos_periodo"
		dw_1.setsort("trabajos_periodo DESC")
	Case "t_modelos_periodo"
		dw_1.setsort("modelos_periodo DESC")
	Case "t_piezas_periodo"
		dw_1.setsort("piezas_periodo DESC")	
	Case "t_altas_periodo"
		dw_1.setsort("altas_periodo DESC")	
End Choose
dw_1.sort()
end event

type uo_disenyador from u_em_campo_2 within wtc_consulta_productividad_clientes
event destroy ( )
integer x = 914
integer y = 176
integer width = 1321
integer taborder = 30
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_disenyador.destroy
call u_em_campo_2::destroy
end on

event modificado;string des_cliente, consulta_seleccion

if rb_cliente.checked = true then
	//CLIENTES
	select razon 
	INTO :des_cliente
	from genter 
	where empresa = :codigo_empresa 
	and tipoter = 'C' 
	and genter.codigo = :uo_disenyador.em_codigo.text
	and exists (SELECT * FROM modelo_cliente WHERE cliente = genter.codigo)
	order by razon ;
	
	uo_disenyador.em_campo.text = des_cliente
	IF Trim(uo_disenyador.em_campo.text)="" THEN 
	 IF Trim(uo_disenyador.em_codigo.text)<>"" Then uo_disenyador.em_campo.SetFocus()
	 uo_disenyador.em_campo.text=""
	 uo_disenyador.em_codigo.text=""
	 dw_colecciones.visible = false
	 cb_mostrar.visible = true
	 cb_cerrar.visible = false
	ELSE
		if uo_disenyador.em_codigo.text = '87' then
			consulta_seleccion =   "SELECT descoleccionsol.codigo,"+&   
									  "			 descoleccionsol.descripcion, "+&
									  "			 0 as seleccionado "+&
									  "FROM   descoleccionsol  "+&
									  "WHERE ( descoleccionsol.empresa = '"+codigo_empresa+"') AND  "+&
									  "      ( descoleccionsol.codigo IN (SELECT modelo.coleccion FROM modelo INNER JOIN modelo_cliente ON modelo.empresa = modelo_cliente.empresa AND modelo.modelo = modelo_cliente.modelo WHERE modelo_cliente.cliente = '"+uo_disenyador.em_codigo.text+"' )) "+&
									  "ORDER BY descripcion DESC"
		else
			consulta_seleccion =   "SELECT deshistorico.coleccion,"+&   
									  "			 descoleccionsol.descripcion, "+&
									  "			 0 as seleccionado "+&
									  "FROM   descoleccionsol INNER JOIN deshistorico ON deshistorico.empresa = descoleccionsol.empresa AND deshistorico.coleccion = descoleccionsol.codigo "+&
									  "WHERE ( deshistorico.empresa = '"+codigo_empresa+"') AND  "+&
									  "      ( deshistorico.cliente = '"+uo_disenyador.em_codigo.text+"' ) "+&
									  "ORDER BY descripcion DESC"
		end if
		dw_colecciones.SetSQLSelect(consulta_seleccion)
		dw_colecciones.retrieve()
		dw_colecciones.visible = true
		cb_mostrar.visible = false
		cb_cerrar.visible = true
	END IF


else
	//AGENTE
	
	select nombre 
	INTO :des_cliente
	from venagentes 
	where empresa = :codigo_empresa and venagentes.agente = :uo_disenyador.em_codigo.text;
	
	uo_disenyador.em_campo.text = des_cliente
	dw_colecciones.reset()
	
	IF Trim(uo_disenyador.em_campo.text)="" THEN 
	 IF Trim(uo_disenyador.em_codigo.text)<>"" Then uo_disenyador.em_campo.SetFocus()
	 uo_disenyador.em_campo.text=""
	 uo_disenyador.em_codigo.text=""
		ELSE
	END IF
end if



end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Diseñadores"
ue_datawindow = "dw_ayuda_tecnicos_dis"
ue_filtro     = ""

end event

event busqueda;str_wt_busquedas_salida resultado
str_wt_busquedas_entrada busqueda

if rb_cliente.checked = true then
	busqueda.titulo_ventana = "Búsqueda de Clientes"
	busqueda.consulta  =  	" select codigo, razon "+&
									" from genter "+&
									" where empresa = '"+codigo_empresa+"' "+&
									" and tipoter = 'C' "+&
									" and exists (SELECT * FROM modelo_cliente WHERE cliente = genter.codigo) "+&
									" order by razon "
	busqueda.titulos[1] = "Código"
	busqueda.titulos[2] = "Razón"
	busqueda.filtro = trim(ue_valor)
else
	busqueda.titulo_ventana = "Búsqueda de Agentes"
	busqueda.consulta  =  	" select agente, nombre "+&
									" from venagentes "
	busqueda.titulos[1] = "Código"
	busqueda.titulos[2] = "Nombre"
	busqueda.filtro = trim(ue_valor)
end if

OpenWithParm(wt_busquedas, busqueda)
resultado = Message.PowerObjectParm
if resultado.resultado > 0 then
	This.em_codigo.text = resultado.valores[1]
	//This.em_campo.text		= resultado.valores[2]		
end if
   
   This.TriggerEvent("modificado")
	ue_valor_anterior = Trim(em_campo.text)
//	ue_campo.SetFocus()
	ue_campo.SelectText(1,Len(ue_campo.Text))
end event

type ddlb_grafica from dropdownlistbox within wtc_consulta_productividad_clientes
integer x = 4640
integer y = 148
integer width = 283
integer height = 400
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string item[] = {"S","N","%"}
borderstyle borderstyle = stylelowered!
end type

type em_fhasta from u_em_campo within wtc_consulta_productividad_clientes
integer x = 462
integer y = 176
integer width = 352
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type em_fdesde from u_em_campo within wtc_consulta_productividad_clientes
integer x = 78
integer y = 176
integer width = 352
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = ansi!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
boolean dropdowncalendar = true
end type

type dw_colecciones from u_seleccion within wtc_consulta_productividad_clientes
boolean visible = false
integer x = 2304
integer y = 132
integer width = 2235
integer taborder = 70
boolean bringtotop = true
end type

type st_colecciones from statictext within wtc_consulta_productividad_clientes
integer x = 2313
integer y = 56
integer width = 1294
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Colecciones"
boolean focusrectangle = false
end type

type cb_cerrar from commandbutton within wtc_consulta_productividad_clientes
boolean visible = false
integer x = 3781
integer y = 144
integer width = 430
integer height = 68
integer taborder = 70
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "CERRAR"
end type

event clicked;dw_colecciones.visible = false
this.visible = false
cb_mostrar.visible = true
end event

type cb_mostrar from commandbutton within wtc_consulta_productividad_clientes
integer x = 2309
integer y = 136
integer width = 329
integer height = 104
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Mostrar"
end type

event clicked;dw_colecciones.visible = true
cb_cerrar.visible = true
this.visible = false
end event

type rb_cliente from radiobutton within wtc_consulta_productividad_clientes
integer x = 1289
integer y = 28
integer width = 402
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cliente"
boolean checked = true
end type

event clicked;rb_cliente.checked = true
rb_comercial.checked = false

dw_colecciones.visible = false
cb_mostrar.visible = true
cb_cerrar.visible = false
st_colecciones.visible = true

gb_com.text = "Cliente"
end event

type st_1 from statictext within wtc_consulta_productividad_clientes
integer x = 923
integer y = 28
integer width = 334
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Filtrar por:"
boolean focusrectangle = false
end type

type rb_comercial from radiobutton within wtc_consulta_productividad_clientes
integer x = 1710
integer y = 28
integer width = 402
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Agente"
end type

event clicked;rb_cliente.checked = false
rb_comercial.checked = true

dw_colecciones.visible = false
cb_mostrar.visible = false
cb_cerrar.visible = false
st_colecciones.visible = false

gb_com.text = "Agente"
end event

type gb_3 from groupbox within wtc_consulta_productividad_clientes
integer x = 32
integer y = 104
integer width = 837
integer height = 192
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Período"
end type

type gb_4 from groupbox within wtc_consulta_productividad_clientes
integer x = 4599
integer y = 72
integer width = 370
integer height = 204
integer taborder = 30
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Gráfica"
end type

type gb_com from groupbox within wtc_consulta_productividad_clientes
integer x = 873
integer y = 104
integer width = 1408
integer height = 192
integer taborder = 40
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cliente"
end type

