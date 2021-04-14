$PBExportHeader$w_mant_desmodelos_laboratorio.srw
forward
global type w_mant_desmodelos_laboratorio from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within w_mant_desmodelos_laboratorio
end type
type dw_2 from u_datawindow within w_mant_desmodelos_laboratorio
end type
type cb_duplicarprueba from commandbutton within w_mant_desmodelos_laboratorio
end type
type cb_añadir from commandbutton within w_mant_desmodelos_laboratorio
end type
type cb_eliminar from commandbutton within w_mant_desmodelos_laboratorio
end type
type cb_grabar from commandbutton within w_mant_desmodelos_laboratorio
end type
type p_imagen from picture within w_mant_desmodelos_laboratorio
end type
type st_2 from statictext within w_mant_desmodelos_laboratorio
end type
type cb_añadir2 from commandbutton within w_mant_desmodelos_laboratorio
end type
type cb_eliminar2 from commandbutton within w_mant_desmodelos_laboratorio
end type
type cb_intercalar from commandbutton within w_mant_desmodelos_laboratorio
end type
type cb_grabar2 from commandbutton within w_mant_desmodelos_laboratorio
end type
type dw_ficha_laboratorio from datawindow within w_mant_desmodelos_laboratorio
end type
type dw_desaplicacion from u_datawindow within w_mant_desmodelos_laboratorio
end type
type pb_imprimir_laboratorio from upb_imprimir within w_mant_desmodelos_laboratorio
end type
type r_1 from rectangle within w_mant_desmodelos_laboratorio
end type
type r_2 from rectangle within w_mant_desmodelos_laboratorio
end type
type r_3 from rectangle within w_mant_desmodelos_laboratorio
end type
type r_4 from rectangle within w_mant_desmodelos_laboratorio
end type
type p_arrow from picture within w_mant_desmodelos_laboratorio
end type
type pb_1 from picturebutton within w_mant_desmodelos_laboratorio
end type
type cb_1 from commandbutton within w_mant_desmodelos_laboratorio
end type
type st_coste from statictext within w_mant_desmodelos_laboratorio
end type
type cb_2 from commandbutton within w_mant_desmodelos_laboratorio
end type
type r_5 from rectangle within w_mant_desmodelos_laboratorio
end type
type dw_historicomodelo from u_datawindow within w_mant_desmodelos_laboratorio
end type
type dw_piezas_coleccion from u_datawindow within w_mant_desmodelos_laboratorio
end type
type sle_busqueda from singlelineedit within w_mant_desmodelos_laboratorio
end type
type cb_crear_est_inicio from commandbutton within w_mant_desmodelos_laboratorio
end type
type st_crear_est from statictext within w_mant_desmodelos_laboratorio
end type
type cb_crear_est_base from commandbutton within w_mant_desmodelos_laboratorio
end type
type cb_crear_est from commandbutton within w_mant_desmodelos_laboratorio
end type
type sle_desc_est from singlelineedit within w_mant_desmodelos_laboratorio
end type
type st_desc_est from statictext within w_mant_desmodelos_laboratorio
end type
end forward

global type w_mant_desmodelos_laboratorio from wi_mvent_con_empresa
integer x = 0
integer y = 0
integer width = 5714
integer height = 3632
pb_calculadora pb_calculadora
dw_2 dw_2
cb_duplicarprueba cb_duplicarprueba
cb_añadir cb_añadir
cb_eliminar cb_eliminar
cb_grabar cb_grabar
p_imagen p_imagen
st_2 st_2
cb_añadir2 cb_añadir2
cb_eliminar2 cb_eliminar2
cb_intercalar cb_intercalar
cb_grabar2 cb_grabar2
dw_ficha_laboratorio dw_ficha_laboratorio
dw_desaplicacion dw_desaplicacion
pb_imprimir_laboratorio pb_imprimir_laboratorio
r_1 r_1
r_2 r_2
r_3 r_3
r_4 r_4
p_arrow p_arrow
pb_1 pb_1
cb_1 cb_1
st_coste st_coste
cb_2 cb_2
r_5 r_5
dw_historicomodelo dw_historicomodelo
dw_piezas_coleccion dw_piezas_coleccion
sle_busqueda sle_busqueda
cb_crear_est_inicio cb_crear_est_inicio
st_crear_est st_crear_est
cb_crear_est_base cb_crear_est_base
cb_crear_est cb_crear_est
sle_desc_est sle_desc_est
st_desc_est st_desc_est
end type
global w_mant_desmodelos_laboratorio w_mant_desmodelos_laboratorio

type variables
string ruta

end variables

forward prototypes
public function boolean f_duplicar (integer tipo)
public function integer f_asignar_ubicacion_optima ()
public function boolean f_hay_espacio_en_ubicacion_actual ()
public function boolean f_hay_ubicacion_asignada ()
public function integer f_control ()
public function integer f_crear_estructura (boolean generar_base, ref string mensaje)
end prototypes

public function boolean f_duplicar (integer tipo);// Parametro
// Si recibe 1 ---> duplicar sólo coleción
// Si recibe 2 ---> duplicar coleción y pieza
// Si recibe 3 ---> duplicar coleción pieza y trabajo

boolean exito = true
datastore ds_colecciones, ds_piezas, ds_trabajos
string sel_coleccion, sel_piezas, sel_trabajos
string ambiente, estilo, disenyador, estado, observaciones_col, comercial
string pieza, funcion, observaciones_pz, laboratorio, pavrev
string serie, relieve, formato, pasta, acabado_lab, contratipo, aceptado, base_cliente, base, observaciones_trab 
datetime fecha_solicitud, fecha_necesidad, fecha_lab
long i, j, k, max_coleccion, trabajo, modelo
/*
if sle_solicitud.text <> '' and sle_coleccion.text <> '' then
	sel_coleccion = " select ambiente, estilo, estado, disenyador, observaciones, comercial "+&
						 " from descoleccionsol "+&
						 " where empresa = '"+codigo_empresa+"' "+&
						 " and solicitud = '"+sle_solicitud.text+"' "+&
						 " and codigo = '"+sle_coleccion.text+"' "
end if

f_cargar_cursor_nuevo (sel_coleccion, ds_colecciones)

FOR i = 1 TO ds_colecciones.RowCount()
	// Buscamos el siguiente codigo de colección libre 
	ambiente = ds_colecciones.object.ambiente[i]
	estilo = ds_colecciones.object.estilo[i]
	disenyador = ds_colecciones.object.disenyador[i]
	estado = "DISPONIBLE" //ds_colecciones.object.estado[i]
	comercial = ds_colecciones.object.comercial[i]
	observaciones_col = ds_colecciones.object.observaciones[i]
	
	select max(convert(integer, codigo))
	into :max_coleccion
	from descoleccionsol
	where empresa = :codigo_empresa
	and solicitud = :sle_solicitud.text
	using SQLCA;
	max_coleccion = max_coleccion + 1
	
	insert into descoleccionsol (empresa, solicitud, codigo, ambiente, estilo, disenyador, estado, observaciones, comercial)
	values (:codigo_empresa, :sle_solicitud.text, :max_coleccion, :ambiente, :estilo, :disenyador, :estado, :observaciones_col, :comercial)
	using SQLCA;
	
	if tipo = 2 or tipo = 3 then
		sel_piezas = " select codigo, funcion, observaciones, pavrev "+&
					 " from despiezascolsol "+&
					 " where empresa = '"+codigo_empresa+"' "+&
					 " and solicitud = '"+sle_solicitud.text+"' "+&
					 " and coleccion = '"+sle_coleccion.text+"' "
					 
		f_cargar_cursor_nuevo(sel_piezas, ds_piezas)
		FOR j = 1 TO ds_piezas.RowCount()
			modelo = f_buscar_modelo()
			IF modelo > 0 THEN
//					exito = false
//				end if
				
				funcion = ds_piezas.object.funcion[j]
				observaciones_pz = ds_piezas.object.observaciones[j]
				pieza = ds_piezas.object.codigo[j]
				pavrev = ds_piezas.object.pavrev[j]
				insert into despiezascolsol ( empresa, solicitud, coleccion, codigo, funcion, observaciones, modelo, pavrev)
				values (:codigo_empresa, :sle_solicitud.text, :max_coleccion, :pieza, :funcion, :observaciones_pz, :modelo, :pavrev)
				using SQLCA;
				IF SQLCA.SQLCode = -1 THEN 
					exito = false
				END IF
				
				IF tipo = 3 THEN
					sel_trabajos = " select trabajo, serie, relieve, formato, pasta, fecha_solicitud, fecha_necesidad,  "+&
										" fecha_lab, acabado_lab, contratipo, aceptado, base_cliente, base, observaciones, laboratorio "+&
										" from destrabajo "+&
										" where empresa = '"+codigo_empresa+"' "+&
										" and solicitud = '"+sle_solicitud.text+"' "+&
										" and coleccion = '"+sle_coleccion.text+"' "+&
										" and laboratorio = 'N' "+&
										" and pieza = '"+pieza+"' "
										 
					f_cargar_cursor_nuevo (sel_trabajos, ds_trabajos)	
					FOR k = 1 TO ds_trabajos.Rowcount()
						trabajo = ds_trabajos.object.trabajo[k]
						serie = ds_trabajos.object.serie[k]
						relieve = ds_trabajos.object.relieve[k]
						formato = ds_trabajos.object.formato[k]
						pasta = ds_trabajos.object.pasta[k]	
//						fecha_solicitud = ds_trabajos.object.fecha_solicitud[k]
//						fecha_necesidad = ds_trabajos.object.fecha_necesidad[k]
//						fecha_lab = ds_trabajos.object.fecha_lab[k]
						fecha_solicitud = datetime(today())
						setnull (fecha_necesidad)
						setnull (fecha_lab)
						acabado_lab = ds_trabajos.object.acabado_lab[k]
						contratipo = ds_trabajos.object.contratipo[k]
						aceptado = ds_trabajos.object.aceptado[k]
						aceptado = ds_trabajos.object.aceptado[k]
						base_cliente = ds_trabajos.object.base_cliente[k]
						observaciones_trab = ds_trabajos.object.observaciones[k]
						laboratorio = ds_trabajos.object.laboratorio[k]
								
						insert into destrabajo ( empresa, solicitud, coleccion, pieza, trabajo, serie, relieve, &
														formato, pasta, fecha_solicitud, fecha_necesidad, fecha_lab, acabado_lab, &
														contratipo, aceptado, base_cliente, base, observaciones, laboratorio)
						values (:codigo_empresa, :sle_solicitud.text, :max_coleccion, :pieza, :trabajo, :serie, :relieve, &
								  :formato, :pasta, :fecha_solicitud, :fecha_necesidad, :fecha_lab, :acabado_lab, &
								  :contratipo, :aceptado, :base_cliente, :base, :observaciones_trab, :laboratorio)
						using SQLCA;
						IF SQLCA.SQLCode = -1 THEN 
							exito = false
						END IF
					NEXT
				END IF // TIPO 3
			ELSE
				exito = false
			END IF // Si modelo > 0
			
		NEXT
	END IF // TIPO 2
	
	IF SQLCA.SQLCode = -1 THEN 
		exito = false
	END IF
NEXT

if exito then
	sle_coleccion.text = string(max_coleccion)
end if

destroy ds_colecciones
destroy ds_piezas
destroy ds_trabajos
*/
return exito

end function

public function integer f_asignar_ubicacion_optima ();datastore ubicaciones
int exito
string consulta
int total_ubicaciones, i, diferencia, diferencia_ant, ubicacion_optima, ocupacion, total_pantallas
int capacidad
boolean encontrado
string v_tipo_pantallas

v_tipo_pantallas = dw_1.object.desmodelo_tipo_pantallas[dw_1.GetRow()]
encontrado = false
ubicacion_optima = 0
consulta = 	" select labubicaciones.codigo, labubicaciones.capacidad, sum(desmodelo.n_pantallas) as ocupacion"+&
				" from desmodelo, labubicaciones "+&
				" where desmodelo.empresa = '"+codigo_empresa+"' "+&
				" and labubicaciones.empresa *= desmodelo.empresa "+&
				" and labubicaciones.codigo *= desmodelo.ubicacion  "+&
				" and labubicaciones.tipo_pantallas =  '"+v_tipo_pantallas+"' "+&
				" group by labubicaciones.codigo, labubicaciones.capacidad "+&
				" order by ocupacion desc "
f_cargar_cursor_nuevo (consulta, ubicaciones)
total_ubicaciones = ubicaciones.RowCount()
i = 1
ubicacion_optima = 0
encontrado = false

do while ( i <= total_ubicaciones and encontrado= false )
	if isnull(ubicaciones.object.labubicaciones_capacidad[i]) then capacidad = 0 else capacidad = ubicaciones.object.labubicaciones_capacidad[i]

	if isnull(ubicaciones.object.ocupacion[i]) then ocupacion = 0 else ocupacion = ubicaciones.object.ocupacion[i]

	total_pantallas = ocupacion + dw_1.object.desmodelo_n_pantallas[dw_1.GetRow()]	
	diferencia = capacidad - total_pantallas

	if diferencia >= 0 then
		ubicacion_optima = ubicaciones.object.labubicaciones_codigo[i]
		encontrado = True
	end if
	i = i + 1
loop

/*
if total_ubicaciones > 0 then
	

	// Inicicalizamos diferencia al valor de la capacidad de la primera ubicación
	if isnull(ubicaciones.object.labubicaciones_capacidad[i]) or ubicaciones.object.labubicaciones_capacidad[i] = 0 then
		messagebox("Aviso", "La ubicación "+string(ubicaciones.object.labubicaciones_codigo[i])+" no tinene definida la capacidad")
		ubicacion_optima = 0
	else
		ubicacion_optima = ubicaciones.object.labubicaciones_codigo[i]
		diferencia = ubicaciones.object.labubicaciones_capacidad[i] //- ubicaciones.object.ocupacion[i]
		diferencia_ant = diferencia
		do while i <= total_ubicaciones and diferencia <> 0
			if isnull(ubicaciones.object.labubicaciones_capacidad[i]) then capacidad = 0 else capacidad = ubicaciones.object.labubicaciones_capacidad[i]
			if isnull(ubicaciones.object.ocupacion[i]) then ocupacion = 0 else ocupacion = ubicaciones.object.ocupacion[i]
			total_pantallas = ocupacion + dw_1.object.desmodelo_n_pantallas[dw_1.GetRow()]
			diferencia = capacidad - total_pantallas
			if total_pantallas <= capacidad and diferencia_ant >=diferencia then
				ubicacion_optima = ubicaciones.object.labubicaciones_codigo[i]
				diferencia_ant = diferencia
				encontrado = True
			end if
			i = i + 1
		loop
	end if
else
	ubicacion_optima = 0
	messagebox("Aviso", "No hay ninguna ubicacion definida.")
	
end if
*/
if i > total_ubicaciones and  not encontrado then
	messagebox("Aviso", "No hay espacio en ninguna ubicación.")
	ubicacion_optima = 0	
	dw_1.object.desmodelo_n_pantallas[dw_1.GetRow()] = 0
end if

destroy ubicaciones
return ubicacion_optima
end function

public function boolean f_hay_espacio_en_ubicacion_actual ();boolean hay_Espacio
int ocupacion, ubicacion_actual, capacidad_actual, n_pantallas
long modelo
//string v_tipo_pantallas

modelo = long(dw_1.object.desmodelo_modelo[dw_1.GetRow()])

//v_tipo_pantallas = dw_1.object.desmodelo_tipo_pantallas[dw_1.GetRow()]

hay_espacio = true
if modelo <> 0 and not isnull(modelo) then
	if  isnull(dw_1.object.desmodelo_ubicacion[dw_1.GetRow()]) then 	
		ubicacion_actual = 0 
	else 
		ubicacion_actual = dw_1.object.desmodelo_ubicacion[dw_1.GetRow()]
	end if
	if isnull(dw_1.object.desmodelo_n_pantallas[dw_1.GetRow()] ) then 
		n_pantallas = 0 
	else 
		n_pantallas = dw_1.object.desmodelo_n_pantallas[dw_1.GetRow()]  
	end if

	// Stock actual de la ubicacion sin tener en cuenta el articulo actual
	select sum(desmodelo.n_pantallas) 
	into :ocupacion
	from desmodelo, labubicaciones 
	where desmodelo.empresa = :codigo_empresa
	and labubicaciones.empresa = :codigo_empresa
	and labubicaciones.codigo *= desmodelo.ubicacion  
	and labubicaciones.codigo = :ubicacion_actual
	and desmodelo.modelo <> :modelo;
	
	select capacidad 
	into :capacidad_actual
	from labubicaciones
	where empresa = :codigo_empresa
	and codigo = :ubicacion_actual;
	
	if ocupacion + n_pantallas > capacidad_actual or ubicacion_actual = 0 then
		hay_espacio = false
	end if
else
	hay_espacio = false
end if

if not hay_espacio  and ubicacion_actual <> 0 then
	messagebox("Aviso","No hay espacio en la ubicación actual. Se asignará una nueva")	
end if
return hay_espacio
end function

public function boolean f_hay_ubicacion_asignada ();boolean hay_ubicacion_asignada

if dw_1.object.desmodelo_ubicacion[dw_1.GetRow()] = 0 or isnull(dw_1.object.desmodelo_ubicacion[dw_1.GetRow()]) then
	hay_ubicacion_asignada = false
else
	hay_ubicacion_asignada = true
end if
return hay_ubicacion_asignada

end function

public function integer f_control ();string v_solicitud, v_coleccion

dw_2.reset()
dw_historicomodelo.reset()

if dw_1.rowcount() > 0 then
	dw_2.Retrieve(codigo_empresa,sle_valor.Text)
//	if dw_2.rowcount() > 0 then
//		dw_desaplicacion.Retrieve(codigo_empresa,sle_valor.Text, dw_2.object.destrabajo2_trabajo[dw_2.Getrow()])
//	end if
	
	
	if not isnull(dw_1.object.desmodelo_coleccion[dw_1.getrow()]) then
		v_coleccion = dw_1.object.desmodelo_coleccion[dw_1.getrow()]
	end if
	dw_historicomodelo.Retrieve(codigo_empresa, v_coleccion)
	dw_piezas_coleccion.Retrieve(codigo_empresa, v_coleccion)
	
end if
///////////////////////////////////////////	 SACAMOS LA IMAGEN   ////////////////////////////////////////////////
p_imagen.PictureName = f_cargar_imagen_nuevo(sle_valor.text)
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////





return 1
end function

public function integer f_crear_estructura (boolean generar_base, ref string mensaje);String codigo_fin, modelo, trabajo, articulo_nuevo, articulo_sup, operacion, operacion_ant, base_version
String desc_articulo, cliente_articulo, coleccion_articulo, pasta_articulo, base_articulo, acabado_articulo
String formula, aplicacion, tiff
Dec gramaje, gramaje_7_20
Boolean control_marca
Int i, cont_operacion, cont_aplicacion, total_filas, inserciones, clientes, numero_versiones
str_colisiones nuevo_codigo
Transaction trans_sql
Datetime ahora

String sel, sel2, articulo, desc_formula, formula_nueva, esta
String formula_estandar, formula_unidad, mprima, desc_unidad, proveedor, unidad_mprima
Int numero, numero2, j, rtn, cont_traspasado, cont_no_traspasado, cont_ya_traspasado
Datastore aplicaciones, mprimas
transaction trm
str_colisiones param_colisiones

/*
Tablas afectadas

articulos
almartcal
almartcajas
palarticulo
art_versiones
art_escandallo
art_ver_operaciones
art_ver_op_aplicaciones
*/

ahora = Datetime(Today(),Now())

mensaje = ""

modelo = String(sle_valor.text)
if modelo = "" then
	mensaje = "Debe indicar el modelo de laboratorio"
	return -1
end if


if sle_busqueda.text = "" then
	mensaje = "Debe especificar el código del artículo fin de la estructura"
	return -1
end if

codigo_fin = sle_busqueda.text

if sle_desc_est.text = "" then
	mensaje = "Debe especificar una descripción para los artículos de la estructura"
	return -1
end if

desc_articulo = sle_desc_est.text

if Long(dw_2.Describe('Evaluate(~'Sum(if(sel="S",1,0))~',0)')) <> 1 then
	mensaje = "Debe seleccionar una única prueba sobre la que se generará la nueva estructura"
	return -1
end if


//Seleccionar la prueba indicada para ver sus aplicaciones y obtener parámetros necesarios
total_filas = dw_2.rowcount()
control_marca = false
i = 1
do while control_marca = false and i <= total_filas
	if String(dw_2.object.sel[i]) = 'S' then
		trabajo = String(dw_2.object.destrabajo2_trabajo[i])
		pasta_articulo = String(dw_2.object.destrabajo2_pasta[i])
		acabado_articulo = String(dw_2.object.tipoacabado_lab_descripcion[i])
		if generar_base then
			if isnull(dw_2.object.destrabajo2_base[i]) or String(dw_2.object.destrabajo2_base[i]) = "" then
				mensaje = "No ha seleccionado una prueba que tenga la base indicada, por lo que no se puede crear la estructura hasta la base."
				return -1
			else
				base_articulo = String(dw_2.object.destrabajo2_base[i])
			end if
		end if	
		
		
		dw_2.selectRow(0,false)
		dw_2.selectRow(i,true)
		dw_2.scrolltorow(i)
		dw_desaplicacion.retrieve(codigo_empresa, sle_valor.text, dw_2.object.destrabajo2_trabajo[dw_2.GetRow()])
		control_marca = true
	end if
	i++
loop

//Obtener los parámetros necesarios de la prueba


//Cliente
/*
if Long(dw_historicomodelo.Describe('Evaluate(~'Sum(if(deshistorico_estado="Aceptado",1,0))~',0)')) = 1 then
	total_filas = dw_historicomodelo.rowcount()
	control_marca = false
	i = 1
	do while control_marca = false and i <= total_filas
		if dw_historicomodelo.object.deshistorico_estado[i] = 'Aceptado' then
			cliente_articulo = String(dw_historicomodelo.object.deshistorico_cliente[i])
			control_marca = true
		end if
		i++
	loop
else
	setNull(cliente_articulo)
end if
*/

//Coleccion
coleccion_articulo = String(dw_1.object.desmodelo_coleccion[1])

//Crear transaccion
f_crear_transaccion(trans_sql,"","",false,"TS","")

CONNECT USING trans_sql;

//Bucle de inserción de artículos por aplicaciones
inserciones = 0
operacion_ant = ""
cont_operacion = 1
articulo_sup = ""
total_filas = dw_desaplicacion.rowcount()
i = 1 
Do While i <= total_filas 
	operacion = String(dw_desaplicacion.object.desaplicacion2_operacion[i])
	if operacion = "5" or i = 1 then //Corte o primeras operaciones
		operacion_ant = ""
		//Nuevo código de artículo
		nuevo_codigo.empresa = codigo_empresa
		nuevo_codigo.tabla = "articulos"
		nuevo_codigo.campo = "codigo"
		nuevo_codigo.filtro = ""
		nuevo_codigo.buscar_huecos = false
		articulo_nuevo = f_colisiones(trans_sql,nuevo_codigo)
		
		INSERT INTO articulos 
			(empresa, codigo, descripcion, familia, formato, ancho, largo, subformato, modelo, unidad, precio_coste, 
			fecha_alta, fecha_anulado, fecha_fin, cuenta, proveedor, decorado, sector, conjunto, pesopieza, piezascaja, pesocaja, 
			pesoenvase, metroscaja, metroslcaja, cuenta_contable, tono, calibre, compras, activo, unidad_est, prev_anular, empleado, 
			molde, plato_sup, plato_inf, calibre_min, calibre_max, cliente, uso, estilo, coleccion, color, imagen, 
			referencia_laboratorio, version_laboratorio, fecha_primera_produccion, tipo_pasta, codigo_pantallas, espesor, ciclo, 
			temp_inferior, temp_superior, ean13, ventasitalia, usuario, temp_inferior1, temp_superior1, obs_ficha_hornos, tipo, 
			partidaest, control_stock, stock_min, ubi_muestras, stocksugerido, fechastocksugerido, codigo_compras, 
         estandar, bloqueado, cod_cliente, marco, canto_vivo, marcado, etiqueta_ce, lote, observaciones)
		VALUES 
			(:codigo_empresa, :articulo_nuevo, :desc_articulo, '1', NULL, NULL, NULL, NULL, NULL, 0, NULL, 
			:ahora, NULL, NULL, NULL, NULL, NULL, 'S', NULL, NULL, NULL, NULL, 
			NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'S', NULL, NULL, NULL, 
			NULL, NULL, NULL, NULL, NULL, NULL, 2, NULL, :coleccion_articulo, NULL, NULL, 
			:modelo, :trabajo, NULL, :pasta_articulo, :modelo, NULL, NULL, 
			NULL, NULL, NULL, NULL, :nombre_usuario, NULL, NULL, NULL, NULL, 
			NULL, 'N', NULL, NULL, NULL, NULL, NULL, 
			NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
		USING trans_sql;
		IF trans_sql.sqlcode <> 0 THEN
			mensaje = "Error creando el artículo nuevo "+articulo_nuevo+". Avise al administrador. Detalles: "+trans_sql.SQLErrText
			ROLLBACK USING trans_sql;
			DISCONNECT USING trans_sql;
			destroy trans_sql
			return -1
		END IF
		
		//Código estadístico
		INSERT INTO art_codestadistico 
			(empresa, codigo, G1, G2, G3, G4, PT, GD, NC, RE, rectificado, AV, PL, CT, EN, TM, OTR, N, INKCID)
		VALUES
			(:codigo_empresa, :articulo_nuevo, NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
		USING trans_sql;
		IF trans_sql.sqlcode <> 0 THEN
			mensaje = "Error creando el código estadístico del artículo nuevo "+articulo_nuevo+". Avise al administrador. Detalles: "+trans_sql.SQLErrText
			ROLLBACK USING trans_sql;
			DISCONNECT USING trans_sql;
			destroy trans_sql
			return -1
		END IF	
		
		
		//Escandallo y versiones
		if articulo_sup = "" then
			if generar_base then
				INSERT INTO art_versiones (empresa, articulo, version, base, descripcion, observaciones, aprovechar_base, tipo_version)
				VALUES (:codigo_empresa, :articulo_nuevo, 1, :base_articulo, "ÚNICA", NULL, NULL, 'P') 
				USING trans_sql;
				IF trans_sql.sqlcode <> 0 THEN
					mensaje = "Error creando versiones del artículo nuevo "+articulo_nuevo+". Avise al administrador. Detalles: "+trans_sql.SQLErrText
					ROLLBACK USING trans_sql;
					DISCONNECT USING trans_sql;
					destroy trans_sql
					return -1
				END IF
				
				INSERT INTO art_escandallo (empresa, articulo, version, articulo_ant, factor, aprovecha)
				VALUES (:codigo_empresa, :articulo_nuevo, 1, :base_articulo, 1, NULL) 
				USING trans_sql;
				IF trans_sql.sqlcode <> 0 THEN
					mensaje = "Error creando escandallo del artículo nuevo "+articulo_nuevo+". Avise al administrador. Detalles: "+trans_sql.SQLErrText
					ROLLBACK USING trans_sql;
					DISCONNECT USING trans_sql;
					destroy trans_sql
					return -1
				END IF
			else
				INSERT INTO art_versiones (empresa, articulo, version, base, descripcion, observaciones, aprovechar_base, tipo_version)
				VALUES (:codigo_empresa, :articulo_nuevo, 1, NULL, "ÚNICA", NULL, NULL, 'P') 
				USING trans_sql;
				IF trans_sql.sqlcode <> 0 THEN
					mensaje = "Error creando versiones del artículo nuevo "+articulo_nuevo+". Avise al administrador. Detalles: "+trans_sql.SQLErrText
					ROLLBACK USING trans_sql;
					DISCONNECT USING trans_sql;
					destroy trans_sql
					return -1
				END IF
				
				INSERT INTO art_escandallo (empresa, articulo, version, articulo_ant, factor, aprovecha)
				VALUES (:codigo_empresa, :articulo_nuevo, 1, 0, 1, NULL) 
				USING trans_sql;
				IF trans_sql.sqlcode <> 0 THEN
					mensaje = "Error creando escandallo del artículo nuevo "+articulo_nuevo+". Avise al administrador. Detalles: "+trans_sql.SQLErrText
					ROLLBACK USING trans_sql;
					DISCONNECT USING trans_sql;
					destroy trans_sql
					return -1
				END IF
			end if
		else
			INSERT INTO art_versiones (empresa, articulo, version, base, descripcion, observaciones, aprovechar_base, tipo_version)
			VALUES (:codigo_empresa, :articulo_nuevo, 1, :articulo_sup, "ÚNICA", NULL, NULL, 'P') 
			USING trans_sql;
			IF trans_sql.sqlcode <> 0 THEN
				mensaje = "Error creando versiones del artículo nuevo "+articulo_nuevo+". Avise al administrador. Detalles: "+trans_sql.SQLErrText
				ROLLBACK USING trans_sql;
				DISCONNECT USING trans_sql;
				destroy trans_sql
				return -1
			END IF
		
			INSERT INTO art_escandallo (empresa, articulo, version, articulo_ant, factor, aprovecha)
			VALUES (:codigo_empresa, :articulo_nuevo, 1, :articulo_sup, 1, NULL) 
			USING trans_sql;
			IF trans_sql.sqlcode <> 0 THEN
				mensaje = "Error creando escandallo del artículo nuevo "+articulo_nuevo+". Avise al administrador. Detalles: "+trans_sql.SQLErrText
				ROLLBACK USING trans_sql;
				DISCONNECT USING trans_sql;
				destroy trans_sql
				return -1
			END IF
		end if
		
		//Otros aspectos del artículo (Calidad, encajado, paletizado,...)
		INSERT INTO almartcal 
			(empresa, articulo, calidad, precio, fecha_alta, stockmin, stockmax, puntopedido)
		VALUES
			(:codigo_empresa, :articulo_nuevo, '1', NULL, :ahora, NULL, NULL, NULL)
		USING trans_sql;
		IF trans_sql.sqlcode <> 0 THEN
			mensaje = "Error añadiendo la calidad del artículo nuevo "+articulo_nuevo+". Avise al administrador. Detalles: "+trans_sql.SQLErrText
			ROLLBACK USING trans_sql;
			DISCONNECT USING trans_sql;
			destroy trans_sql
			return -1
		END IF	
		
		INSERT INTO almartcajas 
			(empresa, articulo, caja, piezascaja, metroscaja, metroslcaja, pesocaja, metros_reales_caja, peso_real_caja, 
			metros_reales, descripcion, codigo, pordefecto)
		VALUES
			(:codigo_empresa, :articulo_nuevo, '3', '999.0000', '58.9410', '294.7050', NULL, NULL, NULL, 
			'58.9410', NULL, NULL, 'S')
		USING trans_sql;
		IF trans_sql.sqlcode <> 0 THEN
			mensaje = "Error añadiendo el encajado del artículo nuevo "+articulo_nuevo+". Avise al administrador. Detalles: "+trans_sql.SQLErrText
			ROLLBACK USING trans_sql;
			DISCONNECT USING trans_sql;
			destroy trans_sql
			return -1
		END IF	
		
		INSERT INTO palarticulo 
			(empresa, articulo, codigo, caja, cajaspallet, planospallet, alturas, pordefecto)
		VALUES
			(:codigo_empresa, :articulo_nuevo, '0', '3', '999', '999', '999', 'S')
		USING trans_sql;
		IF trans_sql.sqlcode <> 0 THEN
			mensaje = "Error añadiendo el paletizado del artículo nuevo "+articulo_nuevo+". Avise al administrador. Detalles: "+trans_sql.SQLErrText
			ROLLBACK USING trans_sql;
			DISCONNECT USING trans_sql;
			destroy trans_sql
			return -1
		END IF	
		
		articulo_sup = articulo_nuevo
	end if
	
	
	//Operaciones
	if operacion_ant = "" or operacion <> operacion_ant then
		INSERT INTO art_ver_operaciones (empresa, articulo, version, operacion, tipo_operacion, orden, formato, factor, 
			juegopantallas, numaplicaciones, coste, coste_fab, coste_mp, orientacion, piezas_fila, coste_fab_mermas, coste_mp_mermas)
		VALUES 
			(:codigo_empresa, :articulo_nuevo, 1, :cont_operacion, :operacion, :cont_operacion, NULL, 1.00, 
			NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL) 
		USING trans_sql;
		IF trans_sql.sqlcode <> 0 THEN
			mensaje = "Error creando la operación del artículo nuevo "+articulo_nuevo+". Avise al administrador. Detalles: "+trans_sql.SQLErrText
			ROLLBACK USING trans_sql;
			DISCONNECT USING trans_sql;
			destroy trans_sql
			return -1
		END IF
		operacion_ant = operacion
		cont_operacion++
		cont_aplicacion = 1
	end if
	
	//Aplicaciones
	gramaje = dw_desaplicacion.object.desaplicacion2_gramaje[i]
	gramaje_7_20 = dw_desaplicacion.object.desaplicacion2_gramaje_7_20[i]
	formula = String(dw_desaplicacion.object.desaplicacion2_formula[i])
	aplicacion =  String(dw_desaplicacion.object.desaplicacion2_aplicacion[i])
	tiff = String(dw_desaplicacion.object.desaplicacion2_tif[i])
	if not isnull(tiff) and tiff <> "" and pos(tiff,"T") = 0 and pos(tiff,"K") = 0 then
		tiff = "T"+tiff
	end if
	
	//Formulas para costes de TIFF
	//Creación Automática de Fórmulas estándar
	
	if not isnull(tiff) and tiff <> "" then
		if isnull(formula) or formula = "" then
			esta = ""
			SELECT formula INTO :esta FROM prodformula WHERE descripcion_laboratorio = :tiff USING trans_sql;
			if isnull(esta) or esta = "" then
				//HAY QUE CREAR LA FORMULA DEL TIFF, ANTES DE AÑADIRLA AL CAMPO FORMULA DE LA APLICACIÓN
				param_colisiones.empresa = codigo_empresa
				param_colisiones.tabla = "prodformula"
				param_colisiones.campo = "formula"
				param_colisiones.filtro = ""
				param_colisiones.buscar_huecos = false
				formula_nueva = String(f_colisiones(trans_sql, param_colisiones))
				
				SELECT formula_estandar, formula_unidad INTO :formula_estandar, :formula_unidad FROM prodaplicaciones WHERE empresa = :codigo_empresa AND codigo = :aplicacion USING trans_sql;
				if formula_estandar = '0' then
					MessageBox("Error", "Para realizar el traspaso, la formula estandar debe estar activada en todas las aplicaciones con TIFF.")
					ROLLBACK USING trans_sql;
					DISCONNECT USING trans_sql;
					destroy trans_sql
					return -1
				end if
				
				SELECT abreviado INTO :desc_unidad FROM comunimedida WHERE codigo = :formula_unidad USING trans_sql;
				desc_unidad = lower(desc_unidad)
				
				INSERT INTO prodformula (empresa, formula, descripcion_produccion, descripcion_laboratorio, fecha_alta, empleado, paletacolor, colorimetro, coste_kg_formula, 
												textura, activa_en_produccion, mp_equivalente, referencia_general, unidad_coste) 
				VALUES (:codigo_empresa, :formula_nueva, :tiff, :tiff, :ahora, NULL, NULL, NULL, NULL, NULL, 'S', NULL, NULL, :formula_unidad) USING trans_sql;
				IF trans_sql.SQLCode <> 0 THEN         
					MessageBox("SQL error Fórmula", trans_sql.SQLErrText)
					ROLLBACK USING trans_sql;
					DISCONNECT USING trans_sql;
					destroy trans_sql
					return -1
				END IF
				
				
				//Componentes de la formula (extraidos de la estándar)
				sel2 = "SELECT mprima, proveedor, unidad FROM prodaplicacion_mprima WHERE empresa = '"+codigo_empresa+"' AND aplicacion = '"+aplicacion+"'"
				f_cargar_cursor_trans (trans_sql,  sel2,  mprimas)
				numero2 = mprimas.RowCount()
				j = 1
				do while (j <= numero2) 
					mprima = mprimas.object.mprima[j]
					proveedor = mprimas.object.proveedor[j]
					unidad_mprima = mprimas.object.unidad[j]
					
					INSERT INTO proddetformula (empresa, formulacion, mp, cantidad, unidadmedida, proveedor, cantidad_u_m_mp, unidad_u_m_mp, coste_mp) 
					VALUES (:codigo_empresa, :formula_nueva, :mprima, NULL, :desc_unidad, :proveedor, 0, :unidad_mprima ,0) USING trans_sql;
					IF trans_sql.SQLCode <> 0 THEN         
						MessageBox("SQL error Componentes Fórmula ", trans_sql.SQLErrText)
						ROLLBACK USING trans_sql;
						DISCONNECT USING trans_sql;
						destroy trans_sql
						return -1
					END IF
					j++
				loop
				mprimas.reset()
			else
				formula_nueva = esta
			end if
			
			
			formula = formula_nueva
			
		else
			//Apuntar o imprimir listado de TIFFs no insertados porque ya hay formulas...
			desc_formula = ""
			SELECT descripcion_laboratorio INTO :desc_formula FROM prodformula WHERE empresa = :codigo_empresa AND formula = :formula USING trans_sql;
			if desc_formula <> tiff then
				MessageBox("Error", "Ya hay una fórmula asociada en la aplicación del TIF del artículo")
				ROLLBACK USING trans_sql;
				DISCONNECT USING trans_sql;
				destroy trans_sql
				return -1
			end if
		end if
	end if
	
	
	INSERT INTO art_ver_op_aplicaciones
		(empresa, articulo, version, operacion, contadoraplicacion, pantalla, formula, gramaje, tipoaplicacion, orden, densidad, 
		viscosidad, boquilla, ciclo, temp_sup, temp_inf, cortes, discos, paso_cliche, gram_7x20, tiff)
	VALUES 
		(:codigo_empresa, :articulo_nuevo, 1, :cont_operacion - 1, :cont_aplicacion, NULL, :formula, :gramaje, :aplicacion, :cont_aplicacion, NULL, 
		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, :gramaje_7_20, :tiff) 
	USING trans_sql;
	IF trans_sql.sqlcode <> 0 THEN
		mensaje = "Error creando aplicacion del artículo nuevo "+articulo_nuevo+". Avise al administrador. Detalles: "+trans_sql.SQLErrText
		ROLLBACK USING trans_sql;
		DISCONNECT USING trans_sql;
		destroy trans_sql
		return -1
	END IF
	
	cont_aplicacion++
	i++
Loop


//Enlace al encajado en el escandallo y en versiones

//No enlazar a versiones si ya hay una entrada
SELECT COUNT(*) INTO :numero_versiones 
FROM art_versiones 
WHERE empresa = :codigo_empresa AND articulo = :codigo_fin;

if numero_versiones = 0 then
	INSERT INTO art_versiones (empresa, articulo, version, base, descripcion, observaciones, aprovechar_base, tipo_version)
	VALUES (:codigo_empresa, :codigo_fin, 1, :articulo_nuevo, "ÚNICA", NULL, NULL, 'P') 
	USING trans_sql;
	IF trans_sql.sqlcode <> 0 THEN
		mensaje = "Error creando versiones del artículo nuevo "+articulo_nuevo+". Avise al administrador. Detalles: "+trans_sql.SQLErrText
		ROLLBACK USING trans_sql;
		DISCONNECT USING trans_sql;
		destroy trans_sql
		return -1
	END IF
else
	SELECT base INTO :base_version 
	FROM art_versiones 
	WHERE empresa = :codigo_empresa AND articulo = :codigo_fin;
	
	if isnull(base_version) or base_version = "" then
		UPDATE art_versiones SET base = :articulo_nuevo WHERE empresa = :codigo_empresa AND articulo = :codigo_fin;
	end if
end if

INSERT INTO art_escandallo (empresa, articulo, version, articulo_ant, factor, aprovecha)
VALUES (:codigo_empresa, :codigo_fin, 1, :articulo_nuevo, 1, NULL) 
USING trans_sql;
IF trans_sql.sqlcode <> 0 THEN
	mensaje = "Error enlazando la base en el escandallo en el artículo nuevo "+articulo_nuevo+". Avise al administrador. Detalles: "+trans_sql.SQLErrText
	ROLLBACK USING trans_sql;
	DISCONNECT USING trans_sql;
	destroy trans_sql
	return -1
END IF

COMMIT USING trans_sql;
mensaje = "La estructura se ha creado con éxito a partir del artículo con código "+sle_busqueda.text+".~n¿Desea abrir el mantenimiento de intermedios para editar los artículos nuevos creados?"
DISCONNECT USING trans_sql;
destroy trans_sql
return 1


end function

event ue_activa_claves;call super::ue_activa_claves;//pb_calculadora.visible = TRUE
cb_duplicarprueba.enabled = false
cb_grabar.enabled = false
cb_eliminar.enabled = false
cb_añadir.enabled = false
cb_eliminar2.enabled = false
cb_añadir2.enabled = false
cb_intercalar.enabled = false
end event

event open;call super::open;integer permiso

ruta = f_ruta_imagen()
dw_2.SetRowFocusIndicator(p_arrow)

permiso = f_permiso_usuario(this.classname(), nombre_usuario)
choose case  permiso
	case 1
		This.cb_insertar.visible = false;
		This.cb_borrar.visible = false;
		This.pb_calculadora.visible = false;		
end choose

istr_parametros.s_titulo_ventana  = "Mantenimiento de Modelos en Desarrollo."

This.title = istr_parametros.s_titulo_ventana

dw_2.SetTransObject(SQLCA)
dw_desaplicacion.SetTransObject(SQLCA)
dw_historicomodelo.SetTransObject(SQLCA)
dw_ficha_laboratorio.SetTransObject(SQLCA)
dw_piezas_coleccion.SetTransObject(SQLCA)
// Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
	sle_valor.text=istr_parametros.s_argumentos[2]
	IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
//		dw_1.Retrieve(codigo_empresa,sle_valor.Text)
		dw_1.TriggerEvent(clicked!)
	END IF
END IF

//this.TriggerEvent("ue_activa_claves")

end event

event ue_desactiva_claves;call super::ue_desactiva_claves;//pb_calculadora.visible = FALSE
cb_duplicarprueba.enabled = true
cb_grabar.enabled = true
cb_eliminar.enabled = true
cb_añadir.enabled = true
cb_eliminar2.enabled = true
cb_añadir2.enabled = true
cb_intercalar.enabled = true

end event

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"desmodelo_empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"desmodelo_modelo",sle_valor.text)

end event

event ue_recuperar;string v_solicitud, v_coleccion

// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         =  "desmodelo"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)

//dw_2.reset()
//dw_historicomodelo.reset()
//
//if dw_1.rowcount() > 0 then
//	dw_2.Retrieve(codigo_empresa,sle_valor.Text)
//	if dw_2.rowcount() > 0 then
//		dw_desaplicacion.Retrieve(codigo_empresa,sle_valor.Text, dw_2.object.destrabajo2_trabajo[dw_2.Getrow()])
//	end if
//	
//	if not isnull(dw_1.object.desmodelo_solicitud[dw_1.getrow()]) then
//		v_solicitud = dw_1.object.desmodelo_solicitud[dw_1.getrow()]
//	end if
//	if not isnull(dw_1.object.desmodelo_coleccion[dw_1.getrow()]) then
//		v_coleccion = dw_1.object.desmodelo_coleccion[dw_1.getrow()]
//	end if
//	dw_historicomodelo.Retrieve(codigo_empresa, v_solicitud, v_coleccion)
//end if
/////////////////////////////////////////////	 SACAMOS LA IMAGEN   ////////////////////////////////////////////////
//p_imagen.PictureName = f_cargar_imagen_nuevo(sle_valor.text)
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CALL Super::ue_recuperar
end event

on w_mant_desmodelos_laboratorio.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.dw_2=create dw_2
this.cb_duplicarprueba=create cb_duplicarprueba
this.cb_añadir=create cb_añadir
this.cb_eliminar=create cb_eliminar
this.cb_grabar=create cb_grabar
this.p_imagen=create p_imagen
this.st_2=create st_2
this.cb_añadir2=create cb_añadir2
this.cb_eliminar2=create cb_eliminar2
this.cb_intercalar=create cb_intercalar
this.cb_grabar2=create cb_grabar2
this.dw_ficha_laboratorio=create dw_ficha_laboratorio
this.dw_desaplicacion=create dw_desaplicacion
this.pb_imprimir_laboratorio=create pb_imprimir_laboratorio
this.r_1=create r_1
this.r_2=create r_2
this.r_3=create r_3
this.r_4=create r_4
this.p_arrow=create p_arrow
this.pb_1=create pb_1
this.cb_1=create cb_1
this.st_coste=create st_coste
this.cb_2=create cb_2
this.r_5=create r_5
this.dw_historicomodelo=create dw_historicomodelo
this.dw_piezas_coleccion=create dw_piezas_coleccion
this.sle_busqueda=create sle_busqueda
this.cb_crear_est_inicio=create cb_crear_est_inicio
this.st_crear_est=create st_crear_est
this.cb_crear_est_base=create cb_crear_est_base
this.cb_crear_est=create cb_crear_est
this.sle_desc_est=create sle_desc_est
this.st_desc_est=create st_desc_est
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.cb_duplicarprueba
this.Control[iCurrent+4]=this.cb_añadir
this.Control[iCurrent+5]=this.cb_eliminar
this.Control[iCurrent+6]=this.cb_grabar
this.Control[iCurrent+7]=this.p_imagen
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.cb_añadir2
this.Control[iCurrent+10]=this.cb_eliminar2
this.Control[iCurrent+11]=this.cb_intercalar
this.Control[iCurrent+12]=this.cb_grabar2
this.Control[iCurrent+13]=this.dw_ficha_laboratorio
this.Control[iCurrent+14]=this.dw_desaplicacion
this.Control[iCurrent+15]=this.pb_imprimir_laboratorio
this.Control[iCurrent+16]=this.r_1
this.Control[iCurrent+17]=this.r_2
this.Control[iCurrent+18]=this.r_3
this.Control[iCurrent+19]=this.r_4
this.Control[iCurrent+20]=this.p_arrow
this.Control[iCurrent+21]=this.pb_1
this.Control[iCurrent+22]=this.cb_1
this.Control[iCurrent+23]=this.st_coste
this.Control[iCurrent+24]=this.cb_2
this.Control[iCurrent+25]=this.r_5
this.Control[iCurrent+26]=this.dw_historicomodelo
this.Control[iCurrent+27]=this.dw_piezas_coleccion
this.Control[iCurrent+28]=this.sle_busqueda
this.Control[iCurrent+29]=this.cb_crear_est_inicio
this.Control[iCurrent+30]=this.st_crear_est
this.Control[iCurrent+31]=this.cb_crear_est_base
this.Control[iCurrent+32]=this.cb_crear_est
this.Control[iCurrent+33]=this.sle_desc_est
this.Control[iCurrent+34]=this.st_desc_est
end on

on w_mant_desmodelos_laboratorio.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.dw_2)
destroy(this.cb_duplicarprueba)
destroy(this.cb_añadir)
destroy(this.cb_eliminar)
destroy(this.cb_grabar)
destroy(this.p_imagen)
destroy(this.st_2)
destroy(this.cb_añadir2)
destroy(this.cb_eliminar2)
destroy(this.cb_intercalar)
destroy(this.cb_grabar2)
destroy(this.dw_ficha_laboratorio)
destroy(this.dw_desaplicacion)
destroy(this.pb_imprimir_laboratorio)
destroy(this.r_1)
destroy(this.r_2)
destroy(this.r_3)
destroy(this.r_4)
destroy(this.p_arrow)
destroy(this.pb_1)
destroy(this.cb_1)
destroy(this.st_coste)
destroy(this.cb_2)
destroy(this.r_5)
destroy(this.dw_historicomodelo)
destroy(this.dw_piezas_coleccion)
destroy(this.sle_busqueda)
destroy(this.cb_crear_est_inicio)
destroy(this.st_crear_est)
destroy(this.cb_crear_est_base)
destroy(this.cb_crear_est)
destroy(this.sle_desc_est)
destroy(this.st_desc_est)
end on

event activate;call super::activate;w_mant_desmodelos_laboratorio = ventanas_activas[id_ventana_activa].ventana
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within w_mant_desmodelos_laboratorio
integer x = 5
integer y = 284
integer width = 5646
integer height = 336
integer taborder = 80
string dataobject = "dw_mant_desmodelos_laboratorio"
boolean border = true
end type

event dw_1::clicked;call super::clicked;str_parametros lstr_param

dw_desaplicacion.setredraw ( false)
dw_2.setredraw ( false)

dw_1.enabled = false
//if not(cb_insertar.enabled) then
//	dw_1.triggerevent(clicked!)
//end if
dw_1.enabled = True

IF GetRow() <> 0  Then 	
	CHOOSE CASE f_objeto_datawindow(This)
		CASE "pb_coleccion"

			lstr_param.s_titulo_ventana = "Mantenimiento de Colecciones por Solicitud"
			lstr_param.s_argumentos[2]  = dw_1.object.desmodelo_solicitud[dw_1.getrow()]
			lstr_param.s_argumentos[3]  = dw_1.object.desmodelo_coleccion[dw_1.getrow()]
			lstr_param.i_nargumentos    = 3
			OpenWithParm(w_mant_descoleccion, lstr_param)
		END CHOOSE
end if

If row=0 Then Return
IF ue_marca_linea = TRUE Then
  this.SetRow(row)
END IF

dw_desaplicacion.setredraw ( true)
dw_2.setredraw ( true)

end event

event dw_1::itemchanged;call super::itemchanged;string v_solicitud, v_coleccion, v_disenyador, v_funcion, v_ambiente
string v_cliente, v_formato, v_tecnico, v_relieve


CHOOSE CASE dwo.name
	CASE "desmodelo_coleccion"
		select descoleccionsol.ambiente, tecnico_dis.descripcion
		into :v_ambiente, :v_disenyador
		from descoleccionsol, tecnico_dis
		where descoleccionsol.empresa = :codigo_empresa
		and tecnico_dis.empresa = :codigo_empresa
		and descoleccionsol.disenyador = tecnico_dis.codigo
		and descoleccionsol.codigo = :data;
			
		dw_1.object.descoleccionsol_ambiente[row] = v_ambiente
		dw_1.object.tecnico_dis_descripcion[row] = v_disenyador
	CASE "desmodelo_funcion"
		select descripcion
		into :v_funcion
		from art_grupo2
		where empresa = :codigo_empresa
		and codigo = :data;

	CASE "desmodelo_tecnico_lab"
		dw_1.object.art_grupo2_descripcion[row] = f_nombre_tecnico_lab (codigo_empresa, data)
		
END CHOOSE


end event

event dw_1::key;bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE
CHOOSE CASE bus_campo
	CASE "desmodelo_coleccion"
		bus_titulo     = "AYUDA DE COLECCIONES"
		bus_datawindow = "dw_ayuda_coleccion_solicitud"
		bus_filtro     = "solicitud = '" + dw_1.object.desmodelo_solicitud[dw_1.getrow()]+ "'"
			
	CASE "desmodelo_funcion"
		bus_titulo     = "AYUDA G2"
		bus_datawindow = "dw_ayuda_art_grupo2"
		bus_filtro     = "" 
		
	CASE "desmodelo_tecnico_lab"
		bus_titulo     = "AYUDA DE TÉCNICOS"
		bus_datawindow = "dw_ayuda_tecnicos_lab"
		bus_filtro     = ""
		
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::key


end event

event dw_1::rbuttondown;bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE
CHOOSE CASE bus_campo
	CASE "desmodelo_coleccion"
		bus_titulo     = "AYUDA DE COLECCIONES"
		bus_datawindow = "dw_ayuda_coleccion_solicitud"
		bus_filtro     = "solicitud = '" + dw_1.object.desmodelo_solicitud[dw_1.getrow()]+ "'"
				
	CASE "desmodelo_funcion"
		bus_titulo     = "AYUDA G2"
		bus_datawindow = "dw_ayuda_art_grupo2"
		bus_filtro     = "" 
	CASE "desmodelo_tecnico_lab"
		bus_titulo     = "AYUDA DE TÉCNICOS"
		bus_datawindow = "dw_ayuda_tecnicos_lab"
		bus_filtro     = ""
		
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::rbuttondown
end event

event dw_1::retrieveend;call super::retrieveend;f_control()
end event

type st_1 from wi_mvent_con_empresa`st_1 within w_mant_desmodelos_laboratorio
integer x = 5
integer y = 96
integer width = 270
string text = "Código:"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within w_mant_desmodelos_laboratorio
integer x = 4754
integer y = 88
integer width = 384
fontcharset fontcharset = ansi!
end type

event cb_insertar::clicked;string motivo, controles, campo
long numero, i, pantallas, k
datawindow dato
boolean falta_campo
long fila, fila_aplic

fila = dw_2.getrow()
fila_aplic = dw_desaplicacion.getrow()

dw_desaplicacion.setredraw ( false)
dw_2.setredraw ( false)


if not(cb_insertar.enabled) then
	dw_1.triggerevent(clicked!)
end if
dw_1.enabled = True

if cb_insertar.enabled then
	// TRABAJOS

	dw_2.accepttext()
	k = dw_2.GetRow()
	if (not IsNull(dw_2.object.destrabajo2_fecha_lab[k]) or  Trim(String(dw_2.object.destrabajo2_fecha_lab[k]))="" )  and &
						(IsNull(dw_2.object.destrabajo2_fecha_fin[k]) or Trim(String(dw_2.object.destrabajo2_fecha_fin[k]))="" ) THEN
		dw_2.object.destrabajo2_fecha_fin[k] = dw_2.object.destrabajo2_fecha_lab[k]
	end if
		
	
	IF dw_2.rowcount() > 0 THEN
		falta_campo = false
		i = 1
		DO WHILE ( i <= dw_2.rowcount() AND NOT falta_campo )
			IF IsNull(dw_2.object.destrabajo2_aceptado[i]) or Trim(String(dw_2.object.destrabajo2_aceptado[i]))="" THEN
				  campo="destrabajo2_aceptado"
				  motivo  = "(Campo Obligatorio) Introduzca si está OK"
				  dato = dw_2
				  numero = 1
				  falta_campo = True
			ELSEIF IsNull(dw_2.object.destrabajo2_serie[i]) or Trim(String(dw_2.object.destrabajo2_serie[i]))="" THEN
				  campo="destrabajo2_serie"
				  motivo  = "(Campo Obligatorio) Introduzca la Serie"
				  dato = dw_2
				  numero = 1
				  falta_campo = True
			ELSEIF IsNull(dw_2.object.destrabajo2_acabado_lab[i]) or Trim(String(dw_2.object.destrabajo2_acabado_lab[i]))="" THEN
				  campo="destrabajo2_acabado_lab"
				  motivo  = "(Campo Obligatorio) Introduzca el acabado"
				  dato = dw_2
				  numero = 1
				  falta_campo = True
			ELSEIF IsNull(dw_2.object.destrabajo2_formato[i]) or Trim(String(dw_2.object.destrabajo2_formato[i]))="" THEN
				  campo="destrabajo2_formato"
				  motivo  = "(Campo Obligatorio) Introduzca el formato"
				  dato = dw_2
				  numero = 1
				  falta_campo = True
			ELSEIF IsNull(dw_2.object.destrabajo2_pasta[i]) or Trim(String(dw_2.object.destrabajo2_pasta[i]))="" THEN
				  campo="destrabajo2_pasta"
				  motivo  = "(Campo Obligatorio) Introduzca el la pasta"
				  dato = dw_2
				  numero = 1
				  falta_campo = True
			ELSEIF IsNull(dw_2.object.destrabajo2_relieve[i]) or Trim(String(dw_2.object.destrabajo2_relieve[i]))="" THEN
				  campo="destrabajo2_relieve"
				  motivo  = "(Campo Obligatorio) Introduzca el relieve"
				  dato = dw_2
				  numero = 1
				  falta_campo = True
			ELSEIF IsNull(dw_2.object.destrabajo2_contratipo[i]) or Trim(String(dw_2.object.destrabajo2_contratipo[i]))="" THEN
				  campo="destrabajo2_contratipo"
				  motivo  = "(Campo Obligatorio) Introduzca si es contratripo"
				  dato = dw_2
				  numero = 1
				  falta_campo = True
			ELSEIF IsNull(dw_2.object.destrabajo2_base_cliente[i]) or Trim(String(dw_2.object.destrabajo2_base_cliente[i]))="" THEN
				  campo="destrabajo2_base_cliente"
				  motivo  = "(Campo Obligatorio) Introduzca si es base de cliente"
				  dato = dw_2
				  numero = 1
				  falta_campo = True
			ELSEIF IsNull(dw_2.object.destrabajo2_fecha_solicitud[i]) or Trim(String(dw_2.object.destrabajo2_fecha_solicitud[i]))="" THEN
				  campo="destrabajo2_fecha_solicitud"
				  motivo  = "(Campo Obligatorio) Introduzca la fecha de solicitud"
				  dato = dw_2
				  numero = 1
				  falta_campo = True
			ELSEIF (not IsNull(dw_2.object.destrabajo2_fecha_lab[i]) or  Trim(String(dw_2.object.destrabajo2_fecha_lab[i]))="" )  and &
						(IsNull(dw_2.object.destrabajo2_fecha_fin[i]) or Trim(String(dw_2.object.destrabajo2_fecha_fin[i]))="" ) THEN
				  campo="destrabajo2_fecha_fin"
				  motivo  = "(Campo Obligatorio) Falta fecha de fin de trabajo"
				  dato = dw_2
				  numero = 1
				  falta_campo = True
	  
				  
			ELSEIF (IsNull(dw_2.object.tecnico_lab[i]) or Trim(String(dw_2.object.tecnico_lab[i]))="") and &
						dw_2.object.destrabajo2_laboratorio[i] = 'S' THEN
				  campo="tecnico_lab"
				  motivo  = "(Campo Obligatorio) Introduzca el técnico. "
				  dato = dw_2
				  numero = 1
				  falta_campo = True
				  
//			ELSEIF IsNull(dw_2.object.destrabajo2_fecha_necesidad[i]) or Trim(String(dw_2.object.destrabajo2_fecha_necesidad[i]))="" THEN
//				  campo="destrabajo2_fecha_necesidad"
//				  motivo  = "(Campo Obligatorio) Introduzca la fecha de necesidad"
//				  dato = dw_2
//				  numero = 1
//				  falta_campo = True
			END IF
			i++
		LOOP
			
		IF falta_campo THEN
		  MessageBox(" "+campo+": Campo obligatorio",motivo,Exclamation!, OK!,1)
		  dato.setfocus()
		  dato.SetColumn(campo)
		  dw_desaplicacion.setredraw ( true)
		  dw_2.setredraw ( true)
		  return 0
		END IF
	END IF
	
	if dw_2.update() = -1 then
		messagebox("Error", "Error Grabando")
		rollback using sqlca;
	else
		commit using sqlca;
	end if
	// FIN TRABAJOS
	
//GRABAR APLICACIONES
	if dw_desaplicacion.update() = -1 then
		messagebox("Error", "No se han actualizado las aplicaciones")
		rollback;
	else
		commit;
	end if
// FIN GRABAR APLICAIONES

end if


//	Gestión del almacén de pantallas
dw_1.accepttext()
if dw_1.rowcount() > 0 then
	if isnull(dw_1.object.desmodelo_n_pantallas[dw_1.GetRow()]) then 
		pantallas = 0 
	else 
		pantallas = dw_1.object.desmodelo_n_pantallas[dw_1.GetRow()]
	end if

	connect using SQLCA;
	if not f_bloquear("Gestión Almacén Pantallas","Almacen_pantallas",titulo) then
		commit;
		dw_1.accepttext()
		if dw_1.Rowcount() > 0 then
			if (not f_hay_ubicacion_asignada() or not f_hay_espacio_en_ubicacion_actual()) and pantallas <> 0 then
				dw_1.object.desmodelo_ubicacion[dw_1.GetRow()] = f_asignar_ubicacion_optima()	 
			end if
		end if
	else
		messagebox("Bloqueo", "Hay un usuario bloqueando la tabla")
	end if
end if


CALL Super::clicked

connect using SQLCA;
f_desbloquear("Gestión Almacén Pantallas","Almacen_pantallas",titulo)
commit;


dw_2.setRow(fila)
dw_2.scrollToRow (fila)
dw_2.Setfocus()
dw_desaplicacion.setRow(fila_aplic)
dw_desaplicacion.scrollToRow (fila_aplic)
dw_desaplicacion.Setfocus()

//dw_2.selectRow(fila, true);
dw_desaplicacion.setredraw ( true)
dw_2.setredraw ( true)

end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within w_mant_desmodelos_laboratorio
boolean visible = false
integer x = 4251
integer y = 88
integer width = 384
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within w_mant_desmodelos_laboratorio
integer x = 279
integer y = 92
end type

event sle_valor::getfocus;call super::getfocus;//ue_datawindow  = "dw_ayuda_desmodelo"
ue_titulo      = "AYUDA SELECCION DE MODELOS DE DESARROLLO."
ue_filtro      = ""
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within w_mant_desmodelos_laboratorio
integer x = 5143
integer y = 88
integer width = 384
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within w_mant_desmodelos_laboratorio
integer taborder = 0
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within w_mant_desmodelos_laboratorio
integer x = 663
integer y = 88
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within w_mant_desmodelos_laboratorio
integer width = 5682
integer height = 76
integer textsize = -9
end type

type pb_calculadora from u_calculadora within w_mant_desmodelos_laboratorio
boolean visible = false
integer x = 544
integer y = 84
integer taborder = 0
end type

event clicked;
long iteraciones, v_codigo
boolean exito
string v_tabla, v_titulo, v_empresa_mas_tabla
datetime v_fecha

v_tabla = "desmodelo"
v_titulo = v_tabla
v_fecha = datetime (today())

v_empresa_mas_tabla = codigo_empresa+"-"+v_tabla

connect using sqlca;

delete from uti_bloqueo
where usuario = :nombre_usuario
and tabla = :v_tabla
and titulo = :v_titulo;

if sqlca.sqlcode <> -1 then 
	commit using SQLCA;
else
	rollback using SQLCA;
	messagebox("Error","Error borrando los bloqueos del usuario actual",StopSign!)
end if
// Fin de borrar bloqueos del usuario actual

select max (convert(integer, modelo))
into :v_codigo
from desmodelo 
where empresa = :codigo_empresa;

v_codigo ++

DO WHILE iteraciones < 10 and not exito
	INSERT INTO uti_bloqueo (tabla, codigo, titulo, fecha, usuario)
					VALUES (:v_empresa_mas_tabla, :v_codigo, :v_titulo, :v_fecha, :nombre_usuario);
	if sqlca.sqlcode= 0 then 
		commit;
		exito = true
	else
		rollback;
		iteraciones ++
		v_codigo ++
	end if
LOOP

if iteraciones >= 10 then
	messagebox("ERROR", "No se puede asignar un código.")
else
	sle_valor.text=string(v_codigo)
	dw_1.triggerEvent("clicked")
end if





end event

type dw_2 from u_datawindow within w_mant_desmodelos_laboratorio
integer x = 5
integer y = 628
integer width = 5646
integer height = 1104
integer taborder = 100
boolean bringtotop = true
string dataobject = "dw_mant_trabajos_laboratorio"
boolean vscrollbar = true
boolean livescroll = false
end type

event clicked;dw_1.enabled = false
if not(cb_insertar.enabled) then
//	dw_1.triggerevent(clicked!)
end if
dw_1.enabled = True

If row=0 Then Return

this.SetRow(row)
this.scrollToRow (row)
parent.TriggerEvent("ue_desactiva_claves")
cb_insertar.enabled   = TRUE

end event

event itemchanged;string serie, formato, relieve, base, acabado_lab, tecnico_lab, tecnico_dis, comercial
dec ancho, largo

IF dwo.Name = "destrabajo2_serie" THEN
	select descripcion
	into :serie
	from desserie
	where empresa = :codigo_empresa
	and codigo = :data;
	dw_2.object.desserie_descripcion[row] = serie
END IF

IF dwo.Name = "destrabajo2_formato" THEN
	select descripcion, ancho, largo
	into :formato, :ancho, :largo
	from formatos
	where empresa = :codigo_empresa
	and codigo = :data;
	dw_2.object.formatos_abreviado[row] = formato
	dw_2.object.formatos_ancho[row] = ancho
	dw_2.object.formatos_largo[row] = largo
END IF

IF dwo.Name = "destrabajo2_relieve" THEN
	select descripcion
	into :relieve
	from art_tipomoldura
	where empresa = :codigo_empresa
	and codigo = :data;
	dw_2.object.art_tipomoldura_descripcion[row] = relieve
END IF

IF dwo.Name = "destrabajo2_base" THEN
	select descripcion
	into :base
	from articulos
	where empresa = :codigo_empresa
	and codigo = :data;
	dw_2.object.articulos_descripcion[row] = base
END IF

IF dwo.Name = "destrabajo2_acabado_lab" THEN
	select descripcion
	into :acabado_lab
	from tipoacabado_lab
	where empresa = :codigo_empresa
	and codigo = :data;
	dw_2.object.tipoacabado_lab_descripcion[row] = acabado_lab
END IF

IF dwo.Name = "destrabajo2_tecnico_lab" THEN
	select descripcion
	into :tecnico_lab
	from tecnico_lab
	where empresa = :codigo_empresa
	and codigo = :data;
	dw_2.object.tecnico_lab_descripcion[row] = tecnico_lab
END IF
IF dwo.Name = "destrabajo2_tecnico_dis" THEN
	select descripcion
	into :tecnico_dis
	from tecnico_dis
	where empresa = :codigo_empresa
	and codigo = :data;
	dw_2.object.tecnico_dis_descripcion[row] = tecnico_dis
END IF

IF dwo.Name = "destrabajo2_comercial" THEN
	select descripcion
	into :comercial
	from comercial
	where empresa = :codigo_empresa
	and codigo = :data;
	dw_2.object.comercial_descripcion[row] = comercial
END IF


//IF dwo.Name = "tecnico_dis" THEN
//	select descripcion
//	into :tecnico_dis
//	from tecnico_dis
//	where empresa = :codigo_empresa
//	and codigo = :data;
//	dw_2.object.tecnico_dis_descripcion[row] = tecnico_dis
//END IF
//
//IF dwo.Name = "comercial" THEN
//	select descripcion
//	into :comercial
//	from comercial
//	where empresa = :codigo_empresa
//	and codigo = :data;
//	dw_2.object.comercial_descripcion[row] = comercial
//END IF
//
end event

event rbuttondown;bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE
CHOOSE CASE bus_campo
	CASE "destrabajo2_serie"
		bus_titulo     = "AYUDA SERIES"
		bus_datawindow = "dw_ayuda_desserie"
		bus_filtro     = "" 
	CASE "destrabajo2_formato"
		bus_titulo     = "AYUDA FORMATOS"
		bus_datawindow = "dw_ayuda_formatos"
		bus_filtro     = "" 
	CASE "destrabajo2_relieve"
		bus_titulo     = "AYUDA RELIEVES"
		bus_datawindow = "dw_ayuda_art_tipomoldura"
		bus_filtro     = "" 		
	CASE "destrabajo2_base"
		bus_titulo     = "AYUDA ARTICULOS"
		bus_datawindow = "dw_ayuda_articulos"
		bus_filtro     = "articulos_uso = '1'" 
	CASE "destrabajo2_acabado_lab"
		bus_titulo     = "AYUDA ACABADO LABORATORIO"
		bus_datawindow = "dw_ayuda_tipoacabado_lab"
		bus_filtro     = "" 		
	CASE "tecnico_lab"
		bus_titulo     = "AYUDA TÉCNICOS"
		bus_datawindow = "dw_ayuda_tecnicos_lab"
		bus_filtro     = "" 		
	CASE "tecnico_dis"
		bus_titulo     = "AYUDA DISEÑADORES"
		bus_datawindow = "dw_ayuda_tecnicos_dis"
		bus_filtro     = "" 		
	CASE "comercial"
		bus_titulo     = "AYUDA COMERCIALES"
		bus_datawindow = "dw_ayuda_comercial"
		bus_filtro     = "" 		
		
		
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE

CALL Super::rbuttondown
end event

event rowfocuschanged;call super::rowfocuschanged;
if currentrow <> 0 then
	dw_desaplicacion.retrieve(codigo_empresa, sle_valor.text, dw_2.object.destrabajo2_trabajo[dw_2.GetRow()])
	if dw_desaplicacion.rowcount() > 0 then
		st_coste.text = string(round (dw_desaplicacion.object.total_coste[1], 2))
	end if
else									
	dw_desaplicacion.reset()
end if

end event

event key;String consulta_busqueda
str_wt_busquedas_entrada busqueda
str_wt_busquedas_salida resultado
Int numero_valores

bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE

CHOOSE CASE bus_campo
	CASE "destrabajo2_serie"
		bus_titulo     = "AYUDA SERIES"
		bus_datawindow = "dw_ayuda_desserie"
		bus_filtro     = "" 
	CASE "destrabajo2_formato"
		bus_titulo     = "AYUDA FORMATOS"
		bus_datawindow = "dw_ayuda_formatos"
		bus_filtro     = "" 
	CASE "destrabajo2_relieve"
		bus_titulo     = "AYUDA RELIEVES"
		bus_datawindow = "dw_ayuda_art_tipomoldura"
		bus_filtro     = "" 
	CASE "destrabajo2_base"
		bus_titulo     = "AYUDA ARTICULOS"
		bus_datawindow = "dw_ayuda_articulos"
		bus_filtro     = "articulos_uso = '1'" 
		
		
		consulta_busqueda =  "  SELECT articulos.codigo, articulos.descripcion, formatos.abreviado, genter.razon "+&
									"  FROM   articulos,   "+&
									"         formatos,"+&
									"			 genter"+&
									"   WHERE articulos.uso = '1' and "+&
									"         (articulos.empresa = '"+codigo_empresa+"') AND"+&
									"			 (articulos.empresa *= formatos.empresa and articulos.formato *= formatos.codigo) and "+&
									"			 (articulos.empresa *= genter.empresa and articulos.cliente *= genter.codigo and genter.tipoter = 'C')"+&
									"   ORDER BY articulos.descripcion ASC  "
		
		
		busqueda.consulta = consulta_busqueda
		busqueda.titulos[1] = "Código"
		busqueda.titulos[2] = "Descripción"
		busqueda.titulos[3] = "Formato"
		busqueda.titulos[4] = "Cliente"
		This.accepttext()
		bus_cadena= f_valor_columna(This,This.GetRow(),This.GetColumnName())
		if KeyDown(KeyTab!) then
			if not isnull(bus_cadena) and bus_cadena <> "" then
				busqueda.filtro = bus_cadena
				if Long(busqueda.filtro) = 0 then
					busqueda.filtro_es_codigo = false
				else
					busqueda.filtro_es_codigo = true
				end if
			end if
		end if
		
		IF KeyDown(KeyEnter!) or KeyDown(KeyTab!) THEN  
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado = -1 then
				MessageBox("Error en la creación de la búsqueda",resultado.error)
				SetColumn(This.GetColumn())
				This.SetRow(This.getrow())
				This.Setfocus()
				SetText(bus_cadena)
				AcceptText()
			elseif resultado.resultado > 0 then				
				SetColumn(This.GetColumn())
				This.SetRow(This.getrow())
				This.Setfocus()
				SetText(resultado.valores[1])
				AcceptText()
			else
				SetColumn(This.GetColumn())
				This.SetRow(This.getrow())
				This.Setfocus()
				SetText(bus_cadena)
				AcceptText()
			end if
		END IF
		Return
	CASE "destrabajo2_acabado_lab"
		bus_titulo     = "AYUDA ACABADO LABORATORIO"
		bus_datawindow = "dw_ayuda_tipoacabado_lab"
		bus_filtro     = "" 		
	CASE "tecnico_lab"
		bus_titulo     = "AYUDA TÉCNICOS"
		bus_datawindow = "dw_ayuda_tecnicos_lab"
		bus_filtro     = "" 		
	CASE "tecnico_dis"
		bus_titulo     = "AYUDA DISEÑADORES"
		bus_datawindow = "dw_ayuda_tecnicos_dis"
		bus_filtro     = "" 		
	CASE "comercial"
		bus_titulo     = "AYUDA COMERCIALES"
		bus_datawindow = "dw_ayuda_comercial"
		bus_filtro     = "" 		
		
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::key



end event

event ue_valores;call super::ue_valores;//ue_marca_linea = True
end event

event doubleclicked;call super::doubleclicked;str_parametros lstr_param 

CHOOSE CASE dwo.name
	CASE "articulos_art_produccion"
		if dw_2.object.articulos_art_produccion[This.GetRow()] <> '' then
			lstr_param.i_nargumentos=2
			lstr_param.s_argumentos[1]="w_mant_desmodelos_laboratorio"
			lstr_param.s_argumentos[2]=String(dw_2.GetItemString(This.GetRow(),"articulos_art_produccion"))
			OpenWithParm(w_mant_articulos_tencer,lstr_param)
		end if

	CASE "destrabajo2_cod_inkcid"
		if dw_2.object.destrabajo2_cod_inkcid[This.GetRow()] <> '' then
			lstr_param.i_nargumentos=2
			lstr_param.s_argumentos[1]="w_mant_desmodelos_laboratorio"
			lstr_param.s_argumentos[2]=String(dw_2.GetItemString(This.GetRow(),"destrabajo2_cod_inkcid"))
			OpenWithParm(w_mant_imagenestif,lstr_param)
		end if
	
END CHOOSE

end event

type cb_duplicarprueba from commandbutton within w_mant_desmodelos_laboratorio
integer x = 4489
integer y = 1744
integer width = 558
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Duplicar"
end type

event clicked;long total_filas, fila_actual, nuevaprueba, indice, i
integer rtn, v_orden, v_prueba
string v_descripcion, sel, v_aplicacion, v_pantalla, v_formula, v_hilos, v_observaciones, v_operacion, tif
boolean bien = true
datastore aplicaciones
string v_serie, v_descripcion_serie, v_aceptado, v_formato, v_formato_abreviado, v_pasta
string v_relieve, v_descripcion_relieve, v_contratipo, v_base_cli, v_acabado_lab, v_descripcion_acabado_lab
string v_base, v_descripcion_base
datetime f_solicitud, f_necesidad, f_fin, f_laboratorio
dec paso_cliche, gramaje, gramaje_7_20, coste, ancho, largo
string v_tecnico_lab, v_tecnico_dis, v_comercial, v_des_tecnico_lab, v_des_tecnico_dis, v_des_comercial



//IF NOT isnull(dw_2.object.destrabajo2_fecha_lab[dw_2.GetRow()] ) &
//	and not isnull(dw_2.object.destrabajo2_fecha_fin[dw_2.GetRow()] ) &
//	and fileexists(ruta+sle_valor.text+'.bmp') then
IF NOT isnull(dw_2.object.destrabajo2_fecha_lab[dw_2.GetRow()] ) and  NOT isnull(dw_2.object.destrabajo2_fecha_fin[dw_2.GetRow()] ) then
	IF sle_valor.text <> '' THEN
		v_prueba = dw_2.object.destrabajo2_trabajo[dw_2.GetRow()] 
		v_base = dw_2.object.destrabajo2_base[dw_2.GetRow()] 
		v_serie = dw_2.object.destrabajo2_serie[dw_2.GetRow()] 
		v_descripcion_serie = dw_2.object.desserie_descripcion[dw_2.GetRow()] 
		v_aceptado = 'N'
		v_formato = dw_2.object.destrabajo2_formato[dw_2.GetRow()] 
		v_formato_abreviado = dw_2.object.formatos_abreviado[dw_2.GetRow()] 
		v_pasta = dw_2.object.destrabajo2_pasta[dw_2.GetRow()] 
		v_relieve = dw_2.object.destrabajo2_relieve[dw_2.GetRow()] 
		v_descripcion_relieve = dw_2.object.art_tipomoldura_descripcion[dw_2.GetRow()] 
		v_contratipo = dw_2.object.destrabajo2_contratipo[dw_2.GetRow()] 
		v_base_cli = dw_2.object.destrabajo2_base_cliente[dw_2.GetRow()] 
		v_acabado_lab = dw_2.object.destrabajo2_acabado_lab[dw_2.GetRow()] 
		v_descripcion_acabado_lab = dw_2.object.tipoacabado_lab_descripcion[dw_2.GetRow()] 
		v_base = dw_2.object.destrabajo2_base[dw_2.GetRow()] 
		v_descripcion_base = dw_2.object.articulos_descripcion[dw_2.GetRow()] 
		f_solicitud = dw_2.object.destrabajo2_fecha_solicitud[dw_2.GetRow()] 
		f_necesidad = dw_2.object.destrabajo2_fecha_necesidad[dw_2.GetRow()] 
		f_fin = dw_2.object.destrabajo2_fecha_fin[dw_2.GetRow()] 
		ancho = dw_2.object.destrabajo2_ancho[dw_2.GetRow()] 
		largo = dw_2.object.destrabajo2_largo[dw_2.GetRow()] 
		v_tecnico_lab = dw_2.object.tecnico_lab[dw_2.GetRow()] 
		v_tecnico_dis = dw_2.object.tecnico_dis[dw_2.GetRow()] 
		v_comercial = dw_2.object.comercial[dw_2.GetRow()] 
		v_des_tecnico_lab = dw_2.object.tecnico_lab_descripcion[dw_2.GetRow()] 
		v_des_tecnico_dis = dw_2.object.tecnico_dis_descripcion[dw_2.GetRow()] 
		v_des_comercial = dw_2.object.comercial_descripcion[dw_2.GetRow()] 
		
//		f_laboratorio = dw_2.object.destrabajo2_fecha_lab[dw_2.GetRow()] 
		
		dw_2.scrolltorow(dw_2.InsertRow(0))
		dw_2.SetColumn(3)
		dw_2.Setfocus()
		
		fila_actual = dw_2.Getrow()
		total_filas = dw_2.RowCount()
		
		nuevaprueba = 1 
		if total_filas > 0 then
			for indice = 1 to total_filas 
				if long(dw_2.object.destrabajo2_trabajo[indice]) >= nuevaprueba then
					nuevaprueba = long(dw_2.object.destrabajo2_trabajo[indice]) + 1
				end if
			next
		end if
		
		dw_2.object.destrabajo2_empresa[fila_actual] = codigo_empresa
		dw_2.object.destrabajo2_modelo[fila_actual] = sle_valor.text
		dw_2.object.destrabajo2_trabajo[fila_actual] = nuevaprueba
		
		dw_2.object.destrabajo2_serie[fila_actual] = v_serie
		dw_2.object.desserie_descripcion[fila_actual] = v_descripcion_serie 
		dw_2.object.destrabajo2_aceptado[fila_actual] = v_aceptado
		dw_2.object.destrabajo2_formato[fila_actual] = v_formato 
		dw_2.object.formatos_abreviado[fila_actual] = v_formato_abreviado 
		dw_2.object.destrabajo2_pasta[fila_actual] = v_pasta 
		dw_2.object.destrabajo2_relieve[fila_actual] = v_relieve 
		dw_2.object.art_tipomoldura_descripcion[fila_actual] = v_descripcion_relieve
		dw_2.object.destrabajo2_contratipo[fila_actual] = v_contratipo
		dw_2.object.destrabajo2_base_cliente[fila_actual] = v_base_cli
		dw_2.object.destrabajo2_acabado_lab[fila_actual] = v_acabado_lab
		dw_2.object.tipoacabado_lab_descripcion[fila_actual] = v_descripcion_acabado_lab
		dw_2.object.destrabajo2_base[fila_actual] = v_base
		dw_2.object.articulos_descripcion[fila_actual] = v_descripcion_base
		dw_2.object.destrabajo2_laboratorio[fila_actual] = 'S'
		dw_2.object.destrabajo2_fecha_solicitud[fila_actual] = f_solicitud 
		dw_2.object.destrabajo2_fecha_necesidad[fila_actual] = f_necesidad 
		dw_2.object.destrabajo2_fecha_fin[fila_actual] = f_fin 
		dw_2.object.destrabajo2_fecha_lab[fila_actual] = datetime(today())
		dw_2.object.destrabajo2_ancho[fila_actual] = ancho
		dw_2.object.destrabajo2_largo[fila_actual] = largo
		
		dw_2.object.tecnico_lab[dw_2.GetRow()] = v_tecnico_lab 
		dw_2.object.tecnico_dis[dw_2.GetRow()] = v_tecnico_dis
		dw_2.object.comercial[dw_2.GetRow()] = v_comercial 
		dw_2.object.tecnico_lab_descripcion[dw_2.GetRow()] = v_des_tecnico_lab 
		dw_2.object.tecnico_dis_descripcion[dw_2.GetRow()] = v_des_tecnico_dis 
		dw_2.object.comercial_descripcion[dw_2.GetRow()] = v_des_comercial 
		
		
		CONNECT USING SQLCA;
		
		rtn = dw_2.Update()
		
		if rtn = 1 and SQLCA.SQLNRows > 0 then
			bien = true
		end if
		
		
		if bien then
			sel = " select orden, aplicacion, operacion, pantallas, formula, hilos, observaciones, coste, paso_cliche, gramaje, gramaje_7_20, tif " +&
			" from desaplicacion2 " +&
			" where empresa  = "+codigo_empresa+&
			" and modelo = '"+sle_valor.text +"'"+&
			" and trabajo = "+ string(v_prueba)
			
			f_cargar_cursor_nuevo(sel, aplicaciones)
		
			for i= 1 to  aplicaciones.RowCount()
				v_orden = aplicaciones.object.orden[i] 
				v_aplicacion = aplicaciones.object.aplicacion[i] 
				v_operacion = aplicaciones.object.operacion[i] 
				v_pantalla = aplicaciones.object.pantallas[i] 
				v_formula = aplicaciones.object.formula[i] 
				v_hilos = aplicaciones.object.hilos[i] 
				v_observaciones = aplicaciones.object.observaciones[i] 
				coste = aplicaciones.object.coste[i] 
				paso_cliche = aplicaciones.object.paso_cliche[i] 
				gramaje = aplicaciones.object.gramaje[i] 
				tif = aplicaciones.object.tif[i] 
				gramaje_7_20  = aplicaciones.object.gramaje_7_20[i]
		
				insert into desaplicacion2 (empresa, modelo, trabajo, orden, 
													aplicacion, operacion, pantallas, formula, hilos, observaciones, coste, paso_cliche, gramaje, gramaje_7_20, tif)
				values (:codigo_empresa, :sle_valor.text, :nuevaprueba, :v_orden, :v_aplicacion, 
					:v_operacion, :v_pantalla, :v_formula, :v_hilos, :v_observaciones, :coste, :paso_cliche, :gramaje, :gramaje_7_20, :tif);	
		
				if SQLCA.SQLCode	<> 0 then
					bien = false
				end if
			next	
		end if
		
		IF bien THEN
			COMMIT USING SQLCA;
			
			update desmodelo
			set activo = 'S'
			where empresa = :codigo_empresa
			and modelo = :sle_valor.text
			using SQLCA;
			
			if SQLCA.SQlCode = 0 then
				commit;
			else
				rollback;
				messagebox("Error", "No se ha activado el modelo.")
			end if
		ELSE
			messagebox("Error", "No se pudo duplicar la prueba")
			ROLLBACK USING SQLCA;
		END IF
		
		
		destroy aplicaciones
		dw_desaplicacion.retrieve(codigo_empresa, sle_valor.text, nuevaprueba)
	END IF
ELSE
//	messagebox("Aviso", "Falta fecha fin o fecha de laboratorio o no existe la imagen")
	messagebox("Aviso", "Falta fecha de laboratorio o fecha fin de diseño.")
END IF

end event

type cb_añadir from commandbutton within w_mant_desmodelos_laboratorio
boolean visible = false
integer x = 4850
integer y = 1780
integer width = 379
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Añadir"
end type

event clicked;long total_filas, fila_actual, nuevaprueba, indice

IF sle_valor.text <> '' THEN
	fila_actual = dw_2.InsertRow(0)
	dw_2.scrolltorow(fila_actual)
	dw_2.SetColumn(3)
	dw_2.Setfocus()
	
	total_filas = dw_2.RowCount()
	
	select max(convert(integer,trabajo))
	into :nuevaprueba
	from destrabajo2
	where empresa = :codigo_empresa
	and modelo = :sle_valor.text;
	
	if isnull(nuevaprueba) then
		nuevaprueba = 0
	end if
	nuevaprueba = nuevaprueba + 1
	
	dw_2.object.destrabajo2_empresa[fila_actual] = codigo_empresa
	dw_2.object.destrabajo2_modelo[fila_actual] = sle_valor.text
	dw_2.object.destrabajo2_trabajo[fila_actual] = nuevaprueba
	dw_2.object.destrabajo2_aceptado[fila_actual] = 'N'
	dw_2.object.destrabajo2_fecha_solicitud[fila_actual] = datetime(today())
	dw_2.object.destrabajo2_fecha_fin[fila_actual] = datetime(today())
	dw_2.object.destrabajo2_fecha_lab[fila_actual] = datetime(today())
	
	dw_2.object.destrabajo2_laboratorio[fila_actual] = 'N'
	
	update desmodelo
	set activo = 'S'
	where empresa = :codigo_empresa
	and modelo = :sle_valor.text
	using SQLCA;
	
	if SQLCA.SQlCode = 0 then
		commit;
	else
		rollback;
		messagebox("Error", "No se ha activado el modelo.")
	end if
END IF	

end event

type cb_eliminar from commandbutton within w_mant_desmodelos_laboratorio
integer x = 5051
integer y = 1744
integer width = 558
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Borrar"
end type

event clicked;boolean error_borrando
long fila_actual, v_prueba, I, total_regs

if MessageBox("Pregunta", "¿Seguro que desea borrar el registro?",  Exclamation!, YesNo!, 2) = 1 then
	error_borrando = false
//	total_regs = dw_desaplicacion.Rowcount() 
//	for i = 1 to total_regs 
//		if dw_desaplicacion.DeleteRow(0) <> 1 then
//			error_borrando = True
//		end if
//	next
////////////////////////////////////////////////////////////////////////////
	long trabajo 
	trabajo = dw_2.object.destrabajo2_trabajo[dw_2.getrow()]

	delete from desaplicacion2 
	where empresa = :codigo_empresa 
	and modelo = :sle_valor.text
	and trabajo = :trabajo using SQLCA;

	if SQLCA.SQLCode = -1 then
		error_borrando = true
	end if
	
	delete from destrabajo2
	where empresa = :codigo_empresa 
	and modelo = :sle_valor.text
	and trabajo = :trabajo using SQLCA;

	if SQLCA.SQLCode = -1 then
		error_borrando = true
	end if
	
	if not error_borrando then
		commit;
		f_control()
	else
		messagebox("Aviso", "No se pudo borrar el registro")
		rollback;
	end if
////////////////////////////////////////////////////////////////////////////
	
	
//	if dw_2.DeleteRow(dw_2.Getrow()) <> 1 then
//		error_borrando = True
//	end if
//	
//	if not error_borrando then
//		dw_desaplicacion.update()
//		dw_2.update()
//		commit;
//	else
//		messagebox("Aviso", "No se pudo borrar el registro")
//		rollback;
//	end if

end if

end event

type cb_grabar from commandbutton within w_mant_desmodelos_laboratorio
boolean visible = false
integer x = 4315
integer y = 796
integer width = 274
integer height = 96
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Grabar"
end type

event clicked;// Return 0 si falta algun campo
// Return 1 si todo es correcto

string motivo, controles, campo
long numero, i
datawindow dato
boolean falta_campo

IF dw_2.rowcount() > 0 THEN
	falta_campo = false
	i = 1
	DO WHILE ( i <= dw_2.rowcount() AND NOT falta_campo )
		dw_2.accepttext()
		IF IsNull(dw_2.object.destrabajo_aceptado[i]) or Trim(String(dw_2.object.destrabajo_aceptado[i]))="" THEN
			  campo="destrabajo_aceptado"
			  motivo  = "(Campo Obligatorio) Introduzca si está OK"
			  dato = dw_2
			  numero = 1
			  falta_campo = True
		ELSEIF IsNull(dw_2.object.destrabajo_serie[i]) or Trim(String(dw_2.object.destrabajo_serie[i]))="" THEN
			  campo="destrabajo_serie"
			  motivo  = "(Campo Obligatorio) Introduzca la Serie"
			  dato = dw_2
			  numero = 1
			  falta_campo = True
	 	ELSEIF IsNull(dw_2.object.destrabajo_acabado_lab[i]) or Trim(String(dw_2.object.destrabajo_acabado_lab[i]))="" THEN
			  campo="destrabajo_acabado_lab"
			  motivo  = "(Campo Obligatorio) Introduzca el acabado"
			  dato = dw_2
			  numero = 1
			  falta_campo = True
		ELSEIF IsNull(dw_2.object.destrabajo_formato[i]) or Trim(String(dw_2.object.destrabajo_formato[i]))="" THEN
			  campo="destrabajo_formato"
			  motivo  = "(Campo Obligatorio) Introduzca el formato"
			  dato = dw_2
			  numero = 1
			  falta_campo = True
		ELSEIF IsNull(dw_2.object.destrabajo_pasta[i]) or Trim(String(dw_2.object.destrabajo_pasta[i]))="" THEN
			  campo="destrabajo_pasta"
			  motivo  = "(Campo Obligatorio) Introduzca el la pasta"
			  dato = dw_2
			  numero = 1
			  falta_campo = True
		ELSEIF IsNull(dw_2.object.destrabajo_relieve[i]) or Trim(String(dw_2.object.destrabajo_relieve[i]))="" THEN
			  campo="destrabajo_relieve"
			  motivo  = "(Campo Obligatorio) Introduzca el relieve"
			  dato = dw_2
			  numero = 1
			  falta_campo = True
		ELSEIF IsNull(dw_2.object.destrabajo_contratipo[i]) or Trim(String(dw_2.object.destrabajo_contratipo[i]))="" THEN
			  campo="destrabajo_contratipo"
			  motivo  = "(Campo Obligatorio) Introduzca si es contratripo"
			  dato = dw_2
			  numero = 1
			  falta_campo = True
		ELSEIF IsNull(dw_2.object.destrabajo_base_cliente[i]) or Trim(String(dw_2.object.destrabajo_base_cliente[i]))="" THEN
			  campo="destrabajo_base_cliente"
			  motivo  = "(Campo Obligatorio) Introduzca si es base de cliente"
			  dato = dw_2
			  numero = 1
			  falta_campo = True
		ELSEIF IsNull(dw_2.object.destrabajo_fecha_solicitud[i]) or Trim(String(dw_2.object.destrabajo_fecha_solicitud[i]))="" THEN
			  campo="destrabajo_fecha_solicitud"
			  motivo  = "(Campo Obligatorio) Introduzca la fecha de solicitud"
			  dato = dw_2
			  numero = 1
			  falta_campo = True
		ELSEIF IsNull(dw_2.object.destrabajo_fecha_necesidad[i]) or Trim(String(dw_2.object.destrabajo_fecha_necesidad[i]))="" THEN
			  campo="destrabajo_fecha_necesidad"
			  motivo  = "(Campo Obligatorio) Introduzca la fecha de necesidad"
			  dato = dw_2
			  numero = 1
			  falta_campo = True
		END IF
		i++
	LOOP
		
	IF falta_campo THEN
	  MessageBox(" "+campo+": Campo obligatorio",motivo,Exclamation!, OK!,1)
	  dato.setfocus()
	  dato.SetColumn(campo)
	  return 0
	END IF
END IF


if dw_2.update() = -1 then
	messagebox("Error", "Error Grabando")
	rollback;
else
	commit;
end if

end event

type p_imagen from picture within w_mant_desmodelos_laboratorio
integer x = 4544
integer y = 1940
integer width = 1047
integer height = 340
boolean bringtotop = true
boolean originalsize = true
boolean focusrectangle = false
end type

type st_2 from statictext within w_mant_desmodelos_laboratorio
integer x = 4453
integer y = 1864
integer width = 402
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16777215
long backcolor = 134217729
string text = "Imagen"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type cb_añadir2 from commandbutton within w_mant_desmodelos_laboratorio
integer x = 2683
integer y = 3344
integer width = 553
integer height = 84
integer taborder = 150
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Añadir"
end type

event clicked;
long total_filas, fila_actual, nuevaaplicacion, indice

//IF NOT isnull(dw_2.object.destrabajo2_fecha_lab[dw_2.GetRow()] ) &
//	and not isnull(dw_2.object.destrabajo2_fecha_fin[dw_2.GetRow()] ) &
//	and fileexists(ruta+sle_valor.text+'.bmp') then

IF NOT isnull(dw_2.object.destrabajo2_fecha_lab[dw_2.GetRow()] ) then
	dw_desaplicacion.scrolltorow(dw_desaplicacion.InsertRow(0))
	dw_desaplicacion.SetColumn(1)
	dw_desaplicacion.Setfocus()
	
	fila_actual = dw_desaplicacion.Getrow()
	total_filas = dw_desaplicacion.RowCount()
	
	nuevaaplicacion = 1 
	if total_filas > 0 then
		for indice = 1 to total_filas 
			if dw_desaplicacion.object.desaplicacion2_orden[indice] >= nuevaaplicacion then
				nuevaaplicacion = dw_desaplicacion.object.desaplicacion2_orden[indice] + 1
			end if
		next
	end if
	
	dw_desaplicacion.object.desaplicacion2_empresa[fila_actual] = codigo_empresa
	dw_desaplicacion.object.desaplicacion2_modelo[fila_actual] = sle_valor.text
	dw_desaplicacion.object.desaplicacion2_trabajo[fila_actual] = dw_2.object.destrabajo2_trabajo[dw_2.GetRow()]
	dw_desaplicacion.object.desaplicacion2_orden[fila_actual] = nuevaaplicacion
	if dw_desaplicacion.Rowcount() > 1 then
		dw_desaplicacion.object.desaplicacion2_operacion[fila_actual] = &
				dw_desaplicacion.object.desaplicacion2_operacion[fila_actual - 1]
		dw_desaplicacion.object.art_ver_tipooperacion_descripcion_abr[fila_actual] = &
				dw_desaplicacion.object.art_ver_tipooperacion_descripcion_abr[fila_actual - 1]
	else
		dw_desaplicacion.object.desaplicacion2_aplicacion[fila_actual] = ""
	end if
ELSE
	messagebox("Aviso", "Falta fecha de laboratorio")
//	messagebox("Aviso", "Falta fecha de laboratorio o fecha fin o no existe la imagen")
END IF
	
end event

type cb_eliminar2 from commandbutton within w_mant_desmodelos_laboratorio
integer x = 3246
integer y = 3344
integer width = 553
integer height = 84
integer taborder = 160
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Borrar"
end type

event clicked;boolean error_borrando
long fila_actual, i, fila_borrada
string prueba


if dw_desaplicacion.Rowcount() > 0 then
	fila_actual = dw_desaplicacion.getrow()
	dw_desaplicacion.DeleteRow(fila_actual)
end if



for i = 1 to dw_desaplicacion.rowcount()
	dw_desaplicacion.object.desaplicacion2_orden[i] = i
next

if dw_desaplicacion.Rowcount() > 0 then
	dw_desaplicacion.scrolltoRow(fila_actual)
end if

cb_grabar2.TriggerEvent(clicked!)

//if fila_borrada <> -1 then
//	COMMIT;
//else
//	ROLLBACK;
//end if
//
end event

type cb_intercalar from commandbutton within w_mant_desmodelos_laboratorio
integer x = 3808
integer y = 3344
integer width = 553
integer height = 84
integer taborder = 190
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Intercalar"
end type

event clicked;dw_1.triggerevent(clicked!)
long total_filas, fila_actual, nuevaaplicacion
int orden, indice


//IF NOT isnull(dw_2.object.destrabajo2_fecha_lab[dw_2.GetRow()] ) &
//	and Not isnull(dw_2.object.destrabajo2_fecha_fin[dw_2.GetRow()] ) &
//	and fileexists(ruta+sle_valor.text+'.bmp') then
IF NOT isnull(dw_2.object.destrabajo2_fecha_lab[dw_2.GetRow()] ) then	
	fila_actual = dw_desaplicacion.Getrow()
	
	dw_desaplicacion.scrolltorow(dw_desaplicacion.InsertRow(fila_actual))
	dw_desaplicacion.SetColumn(1)
	
	total_filas = dw_desaplicacion.RowCount()
	
	orden = fila_actual
	for indice = fila_actual+1 to total_filas
		 dw_desaplicacion.object.desaplicacion2_orden[indice] = indice
	next
	
	
	dw_desaplicacion.object.desaplicacion2_empresa[fila_actual] = codigo_empresa
	dw_desaplicacion.object.desaplicacion2_modelo[fila_actual] = sle_valor.text
	dw_desaplicacion.object.desaplicacion2_trabajo[fila_actual] = dw_2.object.destrabajo2_trabajo[dw_2.GetRow()]
	dw_desaplicacion.object.desaplicacion2_orden[fila_actual] = orden
	
	if dw_desaplicacion.GetRow() > 1 then
		dw_desaplicacion.object.desaplicacion2_operacion[fila_actual] = &
				dw_desaplicacion.object.desaplicacion2_operacion[fila_actual - 1]
		dw_desaplicacion.object.art_ver_tipooperacion_descripcion_abr[fila_actual] = &
				dw_desaplicacion.object.art_ver_tipooperacion_descripcion_abr[fila_actual - 1]
	else
		dw_desaplicacion.object.desaplicacion2_operacion[fila_actual] = ""
	end if
	
	//messagebox("", "empresa: "+codigo_empresa+"~n"+"articulo: "+st_articulo.text+"~n  prueba: "+st_prueba.text+"~n aplicacion: "+string(dw_2.object.aplicacion[fila_actual])+" ~n orden: "+string(orden))
	
	
	dw_desaplicacion.SetColumn(1)
	dw_desaplicacion.Setfocus()

ELSE
//	messagebox("Aviso", "Falta fecha de laboratorio o fecha fin o no existe la imagen")
	messagebox("Aviso", "Falta fecha de laboratorio.")	
END IF

end event

type cb_grabar2 from commandbutton within w_mant_desmodelos_laboratorio
boolean visible = false
integer x = 347
integer y = 2380
integer width = 553
integer height = 84
integer taborder = 200
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Grabar"
end type

event clicked;/*
if dw_desaplicacion.update() = -1 then
	messagebox("Error", "No se han actualizado las aplicaciones")
	rollback;
else
	update desmodelo
	set activo = 'S'
	where empresa = :codigo_empresa
	and modelo = :sle_valor.text
	using SQLCA;
	
	if SQLCA.SQlCode = 0 then
		commit;
	else
		rollback;
		messagebox("Error", "No se han actualizado las aplicaciones")
	end if
end if
*/
end event

type dw_ficha_laboratorio from datawindow within w_mant_desmodelos_laboratorio
boolean visible = false
integer x = 2217
integer y = 1552
integer width = 1015
integer height = 568
integer taborder = 140
boolean bringtotop = true
string dataobject = "dw_report_trabajo_laboratorio2"
boolean livescroll = true
end type

type dw_desaplicacion from u_datawindow within w_mant_desmodelos_laboratorio
integer x = 9
integer y = 1740
integer width = 4411
integer height = 1588
integer taborder = 130
string dataobject = "dw_desaplicacion2"
boolean vscrollbar = true
boolean livescroll = false
end type

event clicked;str_parametros lstr_param
long fila, fila_aplic

//fila = dw_2.getrow()
//fila_aplic = dw_desaplicacion.getrow()
//
//
//dw_desaplicacion.setredraw ( false)
//dw_2.setredraw ( false)
//
if not(cb_insertar.enabled) then
//	dw_1.triggerevent(clicked!)
end if

if row=0 Then Return

this.SetRow(row)
this.scrollToRow (row)

parent.TriggerEvent("ue_desactiva_claves")
cb_insertar.enabled   = TRUE
//cb_borrar.enabled     = TRUE

//dw_2.setRow(fila)
//dw_2.scrollToRow (fila)
//dw_2.Setfocus()
//dw_desaplicacion.setRow(fila_aplic)
//dw_desaplicacion.scrollToRow (fila_aplic)
//dw_desaplicacion.Setfocus()
//
//dw_desaplicacion.setredraw ( true)
//dw_2.setredraw ( true)
//
end event

event itemchanged;string operacion, aplicacion, formula, coste
Long ancho, largo
Decimal gram_7x20, gramaje

IF dwo.Name = "desaplicacion2_operacion" THEN
	select descripcion_abr
	into :operacion
	from art_ver_tipooperacion
	where empresa = :codigo_empresa
	and codigo = :data;
	dw_desaplicacion.object.art_ver_tipooperacion_descripcion_abr[row] = operacion
END IF

IF dwo.Name = "desaplicacion2_aplicacion" THEN
	select resumido
	into :aplicacion
	from prodaplicaciones
	where empresa = :codigo_empresa
	and codigo = :data;
	dw_desaplicacion.object.prodaplicaciones_resumido[row] = aplicacion
END IF

IF dwo.Name = "desaplicacion2_formula" THEN
	select descripcion_laboratorio
	into :formula
	from prodformula
	where empresa = :codigo_empresa
	and formula = :data;
	dw_desaplicacion.object.prodformula_descripcion_laboratorio[row] = formula
END IF


IF dwo.Name = 	"desaplicacion2_gramaje_7_20" then // Cálculo del gramaje de la pieza a partir del gramaje en una pieza de 7x20
	dw_desaplicacion.Accepttext()
	if not isnull (dw_desaplicacion.object.desaplicacion2_gramaje_7_20) then
		gram_7x20 = dw_desaplicacion.object.desaplicacion2_gramaje_7_20[row]
		ancho = dw_2.object.destrabajo2_ancho[dw_2.getrow()]
		largo = dw_2.object.destrabajo2_largo[dw_2.getrow()]
		
		
		//gramaje = ancho * largo * ( gram_7x20 / (7 * 20) )
		gramaje = gram_7x20 * ancho * largo / 140
		dw_desaplicacion.object.desaplicacion2_gramaje[row] = gramaje
		
	end if
end if	

end event

event rbuttondown;string v_operacion

bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE
CHOOSE CASE bus_campo
	CASE "desaplicacion2_operacion"
		bus_titulo     = "AYUDA OPERACIONES"
		bus_datawindow = "dw_ayuda_art_ver_tipooperacion"
		bus_filtro     = "" 
	CASE "desaplicacion2_aplicacion"
		bus_titulo     = "AYUDA APLICACIONES"
		bus_datawindow = "dw_ayuda_prodaplicaciones"
		bus_filtro     = "" 
	CASE "desaplicacion2_formula"
		bus_titulo     = "AYUDA FORMULAS"
		bus_datawindow = "dw_ayuda_prodformulaciones"
		bus_filtro     = "" 
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE

CALL Super::rbuttondown
end event

event key;string v_operacion

bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE

CHOOSE CASE bus_campo
	CASE "desaplicacion2_operacion"
		bus_titulo     = "AYUDA OPERACIONES"
		bus_datawindow = "dw_ayuda_art_ver_tipooperacion"
		bus_filtro     = "" 
	CASE "desaplicacion2_aplicacion"
		bus_titulo     = "AYUDA APLICACIONES"
		bus_datawindow = "dw_ayuda_prodaplicaciones"
		bus_filtro     = "" 
	CASE "desaplicacion2_formula"
		bus_titulo     = "AYUDA FORMULAS"
		bus_datawindow = "dw_ayuda_prodformulaciones"
		bus_filtro     = "" 
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::key



end event

event ue_valores;call super::ue_valores;//ue_marca_linea = True
end event

type pb_imprimir_laboratorio from upb_imprimir within w_mant_desmodelos_laboratorio
integer x = 5536
integer y = 84
integer taborder = 20
boolean bringtotop = true
end type

event clicked;

dw_ficha_laboratorio.object.p_1.filename = f_cargar_imagen_nuevo(sle_valor.text)

OpenWithParm(w_imprimir_trabajos_laboratorio2, "Imprimir")
end event

type r_1 from rectangle within w_mant_desmodelos_laboratorio
integer linethickness = 4
long fillcolor = 33554431
integer x = 4457
integer y = 1848
integer width = 1198
integer height = 452
end type

type r_2 from rectangle within w_mant_desmodelos_laboratorio
integer linethickness = 4
long fillcolor = 32571376
integer x = 4457
integer y = 1728
integer width = 1198
integer height = 112
end type

type r_3 from rectangle within w_mant_desmodelos_laboratorio
integer linethickness = 4
long fillcolor = 33417450
integer x = 2661
integer y = 3332
integer width = 1714
integer height = 108
end type

type r_4 from rectangle within w_mant_desmodelos_laboratorio
integer linethickness = 4
long fillcolor = 16777215
integer x = 18
integer y = 3332
integer width = 1691
integer height = 108
end type

type p_arrow from picture within w_mant_desmodelos_laboratorio
integer x = 137
integer y = 804
integer width = 73
integer height = 64
boolean originalsize = true
string picturename = "VCRNext!"
boolean focusrectangle = false
end type

type pb_1 from picturebutton within w_mant_desmodelos_laboratorio
integer x = 4640
integer y = 88
integer width = 110
integer height = 96
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "Table!"
string powertiptext = "Almacén de Pantallas"
end type

event clicked;str_parametros lstr_param
OpenWithParm(w_labubicaciones_pantallas, lstr_param)
end event

type cb_1 from commandbutton within w_mant_desmodelos_laboratorio
integer x = 46
integer y = 3344
integer width = 581
integer height = 88
integer taborder = 170
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cálculo del Coste"
end type

event clicked;dec ancho, largo, coste, gramaje, gram_cm2, coste_aplicacion, paso, hilos
long i
string  formula

ancho = dw_2.object.destrabajo2_ancho[dw_2.getrow()]
largo = dw_2.object.destrabajo2_largo[dw_2.getrow()]

for i = 1 to dw_desaplicacion.rowcount()
	formula = dw_desaplicacion.object.desaplicacion2_formula[i]
	paso = dw_desaplicacion.object.desaplicacion2_paso_cliche[i]
	hilos = dec(dw_desaplicacion.object.desaplicacion2_hilos[i])
	
	select gram_cm2
	into :gram_cm2
	from prodhilosgramaje
	where prodhilosgramaje.empresa = :codigo_empresa
	and prodhilosgramaje.hilos = :hilos;

		
	if isnull (dw_desaplicacion.object.desaplicacion2_gramaje[i]) or dw_desaplicacion.object.desaplicacion2_gramaje[i] = 0 then
		gramaje = ((255 - long(paso)) / 255 ) *  ancho * largo * gram_cm2
	else 
		gramaje = dw_desaplicacion.object.desaplicacion2_gramaje[i]
	end if
	
	select sum (coste_kg_formula * :gramaje ) 
	into :coste_aplicacion
	from prodformula
	where prodformula.empresa = :codigo_empresa
	and prodformula.formula = :formula;

	if gramaje <> 0 or paso <> 0 then
		dw_desaplicacion.object.desaplicacion2_coste[i] = coste_aplicacion
	end if
next

st_coste.text = string(round (dw_desaplicacion.object.total_coste[1], 2))
end event

type st_coste from statictext within w_mant_desmodelos_laboratorio
integer x = 718
integer y = 3348
integer width = 635
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 16777215
string text = "0"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_mant_desmodelos_laboratorio
integer x = 1742
integer y = 3344
integer width = 891
integer height = 84
integer taborder = 180
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Copiar trabajos a modelos"
end type

event clicked;Integer total_filas_seleccionadas, total_filas_destino, total_filas_operaciones, i, j, n
Integer seleccionadas_origen, seleccionadas_destino
String empresa_trabajo, coleccion, modelo_origen, modelo_destino
Decimal trabajo_origen
Long trabajo_sig
Integer orden
boolean control_marca
transaction transferencia_cli

coleccion = dw_1.object.desmodelo_coleccion[1]
//messagebox("Debug","Coleccion "+String(coleccion))

//Actualizamos previamente todos los Data Windows con datos afectados por la copia
//dw_2.Update()
//dw_piezas_coleccion.Update()
//dw_desaplicacion.Update()

total_filas_seleccionadas = dw_2.rowcount()
total_filas_destino = dw_piezas_coleccion.rowcount()
seleccionadas_origen = 0
seleccionadas_destino = 0

control_marca = false
i = 1
do while control_marca = false and i <= total_filas_destino
	if dw_piezas_coleccion.object.sel2[i] = 'S' then
		control_marca = true
	end if
	i++
loop

if control_marca = true then
	i = 1
	control_marca = false
	do while control_marca = false and i <= total_filas_seleccionadas
		if dw_2.object.sel[i] = 'S' then
			control_marca = true
		end if
		i++
	loop
	if control_marca = false then
		messagebox("Error","Debe marcar un trabajo y un modelo de destino para realizar la copia.")
		return
	end if
else
	messagebox("Error","Debe marcar un trabajo y un modelo de destino para realizar la copia.")
	return
end if

//Uso de la transacción y bloqueos de tablas/registros BD

f_crear_transaccion(transferencia_cli, '', '', false, 'TS','')

CONNECT USING transferencia_cli;


//Recorremos los modelos de la misma colección y vemos los seleccionados
for i = 1 to total_filas_destino
	if dw_piezas_coleccion.object.sel2[i] = 'S' then
		modelo_destino = dw_piezas_coleccion.object.desmodelo_modelo[i]
		dw_piezas_coleccion.object.sel2[i] = 'N'
		//Recorremos los trabajos pra ver cuales se deben copiar
		for j = 1 to total_filas_seleccionadas
			if dw_2.object.sel[j] = 'S' then
				empresa_trabajo = dw_2.object.destrabajo2_empresa[j]
				modelo_origen = dw_2.object.destrabajo2_modelo[j]
				trabajo_origen = dw_2.object.destrabajo2_trabajo[j]
						
				trabajo_sig = 0
				//Obtenemos en máximo
				SELECT MAX(trabajo) INTO :trabajo_sig
				FROM destrabajo2 
				WHERE 
					empresa = :empresa_trabajo AND 
					modelo = :modelo_destino
				USING transferencia_cli;
				if transferencia_cli.sqlcode <> 0 then
					ROLLBACK USING transferencia_cli;
					DISCONNECT USING transferencia_cli;
					messagebox("Error","Se ha producido un error en la copia de trabajos.~n (Código error:1)")
					return
				end if
				if isNull (trabajo_sig) then
					trabajo_sig = 1
				else
					trabajo_sig = trabajo_sig + 1
				end if
				
				//Insertamos en el modelo destino el trabajo
				INSERT INTO destrabajo2 (empresa, modelo, Trabajo, serie, relieve, formato, pasta, fecha_solicitud, fecha_necesidad, fecha_fin, fecha_lab, acabado_lab, contratipo, aceptado, base_cliente, base, ref_lab, refdis1, refdis2, observaciones, laboratorio, observaciones_lab, inkcid, tecnico_dis, cod_inkcid, ancho, largo, comercial, tecnico_lab)
				(SELECT empresa, :modelo_destino, :trabajo_sig, serie, relieve, formato, pasta, fecha_solicitud, fecha_necesidad, fecha_fin, fecha_lab, acabado_lab, contratipo, aceptado, base_cliente, base, ref_lab, refdis1, refdis2, observaciones, laboratorio, observaciones_lab, inkcid, tecnico_dis, cod_inkcid, ancho, largo, comercial, tecnico_lab 
					FROM destrabajo2
					WHERE
					empresa = :empresa_trabajo AND 
					modelo = :modelo_origen AND 
					trabajo = :trabajo_origen)
				USING transferencia_cli;
				if transferencia_cli.sqlcode <> 0 then
					ROLLBACK USING transferencia_cli;
					DISCONNECT USING transferencia_cli;
					messagebox("Error","Se ha producido un error en la copia de trabajos.~n (Código error:2)")
					return
				end if
				
				//Insertamos en el modelo destino sus operaciones
				//Finalmente se decide no copiar las operaciones
				
				total_filas_operaciones = dw_desaplicacion.rowcount()
				for n = 1 to total_filas_operaciones
					orden = dw_desaplicacion.object.desaplicacion2_orden[n]
					
					INSERT INTO desaplicacion2 (empresa, modelo, trabajo, orden, aplicacion, operacion, pantallas, formula, hilos, observaciones, tif)
					(SELECT empresa, :modelo_destino, :trabajo_sig, :n, aplicacion, operacion, pantallas, formula, hilos, observaciones, NULL
						FROM desaplicacion2
						WHERE
						empresa = :empresa_trabajo AND 
						modelo = :modelo_origen AND 
						trabajo = :trabajo_origen AND 
						orden = :orden)
					USING transferencia_cli;
					if transferencia_cli.sqlcode <> 0 then
						ROLLBACK USING transferencia_cli;
						DISCONNECT USING transferencia_cli;
						messagebox("Error","Se ha producido un error en la copia de trabajos.~n (Código error:3)")
						return
					end if
				next
				
				//messagebox("Debug","Empresa trabajo: "+String(empresa_trabajo)+" Modelo Origen: "+String(modelo_origen)+" Modelo destino: "+String(modelo_destino)+" Trabajo origen: "+String(trabajo_origen)+" trabajo_sig: "+String(trabajo_sig)+" Ultimo orden: "+String(orden))
			end if
			if i = total_filas_destino then
				dw_2.object.sel[j] = 'N'
			end if
		next
	end if
next

COMMIT USING transferencia_cli;
DISCONNECT USING transferencia_cli;
destroy transferencia_cli
messagebox("Éxito en la operación","Traspaso realizado con éxito.")


//messagebox("Debug","Modelos seleccionados de destino "+String(seleccionadas_destino))
//messagebox("Debug","Modelos seleccionados de origen "+String(seleccionadas_origen))
end event

type r_5 from rectangle within w_mant_desmodelos_laboratorio
integer linethickness = 4
long fillcolor = 33417450
integer x = 1723
integer y = 3332
integer width = 923
integer height = 108
end type

type dw_historicomodelo from u_datawindow within w_mant_desmodelos_laboratorio
integer x = 4457
integer y = 2304
integer width = 1193
integer height = 584
integer taborder = 110
boolean bringtotop = true
string dataobject = "dw_historicomodelo_lab"
boolean vscrollbar = true
end type

event clicked;str_parametros lstr_param

dw_1.enabled = false
if not(cb_insertar.enabled) then
	dw_1.triggerevent(clicked!)
end if
dw_1.enabled = True

If row=0 Then Return

IF ue_marca_linea = TRUE and row > 0 Then
  this.SetRow(row)
END IF


end event

event itemchanged;string v_cliente, v_tecnico

CHOOSE CASE dwo.name
	CASE "deshistorico_cliente"
		select descripcion
		into :v_cliente
		from descliente
		where empresa = :codigo_empresa
		and codigo = :data;
		dw_historicomodelo.object.descliente_descripcion[row] = v_cliente
END CHOOSE


end event

event rbuttondown;bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE
CHOOSE CASE bus_campo
	CASE "deshistorico_cliente"
		bus_titulo     = "AYUDA SELECCION CLIENTES"
		bus_datawindow = "dw_ayuda_descliente"
		bus_filtro     = "" 	
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::rbuttondown
end event

event key;bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE
CHOOSE CASE bus_campo
	CASE "deshistorico_cliente"
		bus_titulo     = "AYUDA SELECCION CLIENTES"
		bus_datawindow = "dw_ayuda_descliente"
		bus_filtro     = "" 	
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::key



end event

event ue_valores;call super::ue_valores;//ue_marca_linea = True
end event

type dw_piezas_coleccion from u_datawindow within w_mant_desmodelos_laboratorio
integer x = 4457
integer y = 2892
integer width = 1193
integer height = 556
integer taborder = 120
boolean bringtotop = true
string dataobject = "dw_con_piezas_coleccion"
boolean vscrollbar = true
boolean livescroll = false
end type

event clicked;//str_parametros lstr_param
//
//If row=0 Then Return
//
//this.SetRow(row)
//

dw_1.enabled = false
if not(cb_insertar.enabled) then
	dw_1.triggerevent(clicked!)
end if
dw_1.enabled = True

If row=0 Then Return

IF ue_marca_linea = TRUE and row > 0 Then
  this.SetRow(row)
END IF


end event

event itemchanged;string serie, formato, relieve, base, acabado_lab
dec ancho, largo

IF dwo.Name = "destrabajo2_serie" THEN
	select descripcion
	into :serie
	from desserie
	where empresa = :codigo_empresa
	and codigo = :data;
	dw_2.object.desserie_descripcion[row] = serie
END IF

IF dwo.Name = "destrabajo2_formato" THEN
	select descripcion, ancho, largo
	into :formato, :ancho, :largo
	from formatos
	where empresa = :codigo_empresa
	and codigo = :data;
	dw_2.object.formatos_abreviado[row] = formato
	dw_2.object.formatos_ancho[row] = ancho
	dw_2.object.formatos_largo[row] = largo
END IF

IF dwo.Name = "destrabajo2_relieve" THEN
	select descripcion
	into :relieve
	from art_tipomoldura
	where empresa = :codigo_empresa
	and codigo = :data;
	dw_2.object.art_tipomoldura_descripcion[row] = relieve
END IF

IF dwo.Name = "destrabajo2_base" THEN
	select descripcion
	into :base
	from articulos
	where empresa = :codigo_empresa
	and codigo = :data;
	dw_2.object.articulos_descripcion[row] = base
END IF

IF dwo.Name = "destrabajo2_acabado_lab" THEN
	select descripcion
	into :acabado_lab
	from tipoacabado_lab
	where empresa = :codigo_empresa
	and codigo = :data;
	dw_2.object.tipoacabado_lab_descripcion[row] = acabado_lab
END IF


end event

event rbuttondown;bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE
CHOOSE CASE bus_campo
	CASE "destrabajo2_serie"
		bus_titulo     = "AYUDA SERIES"
		bus_datawindow = "dw_ayuda_desserie"
		bus_filtro     = "" 
	CASE "destrabajo2_formato"
		bus_titulo     = "AYUDA FORMATOS"
		bus_datawindow = "dw_ayuda_formatos"
		bus_filtro     = "" 
	CASE "destrabajo2_relieve"
		bus_titulo     = "AYUDA RELIEVES"
		bus_datawindow = "dw_ayuda_art_tipomoldura"
		bus_filtro     = "" 		
	CASE "destrabajo2_base"
		bus_titulo     = "AYUDA ARTICULOS"
		bus_datawindow = "dw_ayuda_articulos"
		bus_filtro     = "articulos_uso = '1'" 
	CASE "destrabajo2_acabado_lab"
		bus_titulo     = "AYUDA ACABADO LABORATORIO"
		bus_datawindow = "dw_ayuda_tipoacabado_lab"
		bus_filtro     = "" 		
		
		
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE

CALL Super::rbuttondown
end event

event rowfocuschanged;call super::rowfocuschanged;/*
if currentrow <> 0 then
	dw_desaplicacion.retrieve(codigo_empresa, sle_solicitud.text, sle_coleccion.text, sle_pieza.text, &
										dw_1.object.destrabajo_trabajo[dw_1.GetRow()])
										
else									
	dw_desaplicacion.reset()
end if
*/
end event

event key;bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE

CHOOSE CASE bus_campo
	CASE "destrabajo2_serie"
		bus_titulo     = "AYUDA SERIES"
		bus_datawindow = "dw_ayuda_desserie"
		bus_filtro     = "" 
	CASE "destrabajo2_formato"
		bus_titulo     = "AYUDA FORMATOS"
		bus_datawindow = "dw_ayuda_formatos"
		bus_filtro     = "" 
	CASE "destrabajo2_relieve"
		bus_titulo     = "AYUDA RELIEVES"
		bus_datawindow = "dw_ayuda_art_tipomoldura"
		bus_filtro     = "" 
	CASE "destrabajo2_base"
		bus_titulo     = "AYUDA ARTICULOS"
		bus_datawindow = "dw_ayuda_articulos"
		bus_filtro     = "articulos_uso = '1'" 
	CASE "destrabajo2_acabado_lab"
		bus_titulo     = "AYUDA ACABADO LABORATORIO"
		bus_datawindow = "dw_ayuda_tipoacabado_lab"
		bus_filtro     = "" 		
		
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::key



end event

event ue_valores;call super::ue_valores;//ue_marca_linea = True
end event

type sle_busqueda from singlelineedit within w_mant_desmodelos_laboratorio
event key pbm_keydown
boolean visible = false
integer x = 1161
integer y = 184
integer width = 279
integer height = 88
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

event key;String consulta_busqueda
str_wt_busquedas_entrada busqueda
str_wt_busquedas_salida resultado
Int numero_valores

consulta_busqueda =  "SELECT articulos.codigo, articulos.descripcion, formatos.abreviado, almusos.descripcion, genter.razon "+&
							"FROM articulos "+&
							"INNER JOIN almusos ON articulos.uso = almusos.codigo and articulos.empresa = almusos.empresa "+&
							"LEFT OUTER JOIN genter ON articulos.cliente = genter.codigo and articulos.empresa = genter.empresa "+&
							"LEFT OUTER JOIN formatos ON articulos.formato = formatos.codigo and articulos.empresa = formatos.empresa "+&
							"WHERE articulos.empresa = '"+codigo_empresa+"' AND "+&
							"articulos.fecha_anulado IS NULL AND "+&
							"(genter.tipoter IS NULL OR genter.tipoter = 'C')"+&
							"ORDER BY articulos.descripcion"


busqueda.consulta = consulta_busqueda
busqueda.titulos[1] = "Código"
busqueda.titulos[2] = "Descripción"
busqueda.titulos[3] = "Formato"
busqueda.titulos[4] = "Uso"
busqueda.titulos[5] = "Cliente"

IF not isnull(this.text) and this.text <> "" THEN
	busqueda.filtro = this.text
	if Long(this.text) = 0 then
		//Es texto
		//busqueda.filtro = this.text
		busqueda.filtro_es_codigo = false
	else
		//Es código
		busqueda.filtro_es_codigo = true
	end if
END IF

IF KeyDown(KeyEnter!) OR (not isnull(Message.LongParm) and Message.LongParm = 1001) THEN  
	OpenWithParm(wt_busquedas, busqueda)
	resultado = Message.PowerObjectParm
	if resultado.resultado = -1 then
		MessageBox("Error en la creación de la búsqueda",resultado.error)
	elseif resultado.resultado > 0 then
		this.text = resultado.valores[1]
		sle_desc_est.text = resultado.valores[2]
	end if
END IF

end event

event losefocus;/*
Long es_texto

if isnull(this.text) or trim(this.text) = "" then
	es_texto = 1
else
	es_texto = Long(this.text)
end if

if es_texto = 0 then
	IF KeyDown(KeyTab!) THEN
		this.triggerevent("key",0,1001)
	END IF
end if
*/

IF KeyDown(KeyTab!) THEN
	this.triggerevent("key",0,1001)
END IF
end event

type cb_crear_est_inicio from commandbutton within w_mant_desmodelos_laboratorio
integer x = 1975
integer y = 88
integer width = 782
integer height = 92
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Iniciar Crear estructura"
end type

event clicked;if cb_crear_est_inicio.text = "Iniciar Crear estructura" then
	
	if sle_valor.text = "" then
		MessageBox("Error al crear estructura", "Primero debe indicar el modelo a partir del que generará la estructura.")
		return
	end if
	
	sle_busqueda.visible=true
	cb_crear_est_base.visible=true
	cb_crear_est.visible=true
	st_crear_est.visible=true
	sle_desc_est.visible=true
	st_desc_est.visible=true
	
	cb_crear_est_inicio.text = "Cancelar Crear estructura"
	cb_crear_est_inicio.x = 837
	
	sle_busqueda.setfocus()
	
else
	sle_busqueda.visible=false
	sle_busqueda.text=""
	cb_crear_est_base.visible=false
	cb_crear_est.visible=false
	st_crear_est.visible=false
	sle_desc_est.visible=false
	sle_desc_est.text=""
	st_desc_est.visible=false
	
	cb_crear_est_inicio.text = "Iniciar Crear estructura"
	cb_crear_est_inicio.x = 1975
end if
end event

type st_crear_est from statictext within w_mant_desmodelos_laboratorio
boolean visible = false
integer x = 850
integer y = 204
integer width = 283
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Código fin:"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_crear_est_base from commandbutton within w_mant_desmodelos_laboratorio
boolean visible = false
integer x = 2757
integer y = 88
integer width = 951
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Crear estructura (incluyendo base)"
end type

event clicked;Int resultado, contestacion
String mensaje
str_parametros lstr_param
lstr_param.s_argumentos[2] = sle_busqueda.text
lstr_param.i_nargumentos = 2

resultado = f_crear_estructura(true, mensaje)

if resultado = -1 then
	MessageBox("Error al Crear Estructura (incluyendo base)", mensaje)
else
	contestacion = MessageBox("Crear Estructura (incluyendo base)", mensaje,Question!,YesNo!)
	cb_crear_est_inicio.triggerEvent(Clicked!)
	if contestacion = 1 then
		if f_menu_ventana_esta_abierta("w_mant_altas_intermedios_nuevo") <> -1 then
			close(w_mant_altas_intermedios_nuevo)
		end if
		OpenWithParm(w_mant_altas_intermedios_nuevo, lstr_param)
	end if
end if


end event

type cb_crear_est from commandbutton within w_mant_desmodelos_laboratorio
boolean visible = false
integer x = 3707
integer y = 88
integer width = 521
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Crear estructura"
end type

event clicked;Int resultado, contestacion
String mensaje
str_parametros lstr_param
lstr_param.s_argumentos[2] = sle_busqueda.text
lstr_param.i_nargumentos = 2

resultado = f_crear_estructura(false, mensaje)

if resultado = -1 then
	MessageBox("Error al Crear Estructura", mensaje)
else
	contestacion = MessageBox("Crear Estructura", mensaje,Question!,YesNo!)
	cb_crear_est_inicio.triggerEvent(Clicked!)
	if contestacion = 1 then
		OpenWithParm(w_mant_altas_intermedios_nuevo, lstr_param)
	end if
end if

end event

type sle_desc_est from singlelineedit within w_mant_desmodelos_laboratorio
boolean visible = false
integer x = 1979
integer y = 188
integer width = 2249
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
textcase textcase = upper!
integer limit = 40
borderstyle borderstyle = stylelowered!
end type

type st_desc_est from statictext within w_mant_desmodelos_laboratorio
boolean visible = false
integer x = 1449
integer y = 200
integer width = 512
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Nueva descripción:"
alignment alignment = center!
boolean focusrectangle = false
end type

