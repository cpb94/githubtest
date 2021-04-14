$PBExportHeader$wtc_traspaso_multicodigo.srw
forward
global type wtc_traspaso_multicodigo from window
end type
type dw_nivel from datawindow within wtc_traspaso_multicodigo
end type
type st_info from statictext within wtc_traspaso_multicodigo
end type
type cb_3 from commandbutton within wtc_traspaso_multicodigo
end type
type cb_2 from commandbutton within wtc_traspaso_multicodigo
end type
type cb_articulos_fase2 from commandbutton within wtc_traspaso_multicodigo
end type
type pb_1 from picturebutton within wtc_traspaso_multicodigo
end type
type barra_1 from hprogressbar within wtc_traspaso_multicodigo
end type
type cb_articulos_fase1 from commandbutton within wtc_traspaso_multicodigo
end type
type cb_1 from commandbutton within wtc_traspaso_multicodigo
end type
type p_logo from picture within wtc_traspaso_multicodigo
end type
type st_titulo from statictext within wtc_traspaso_multicodigo
end type
end forward

global type wtc_traspaso_multicodigo from window
integer width = 2619
integer height = 1452
boolean titlebar = true
string title = "Traspaso a multicodigo"
string menuname = "mi_menu_generico"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
dw_nivel dw_nivel
st_info st_info
cb_3 cb_3
cb_2 cb_2
cb_articulos_fase2 cb_articulos_fase2
pb_1 pb_1
barra_1 barra_1
cb_articulos_fase1 cb_articulos_fase1
cb_1 cb_1
p_logo p_logo
st_titulo st_titulo
end type
global wtc_traspaso_multicodigo wtc_traspaso_multicodigo

type variables
Long id_ventana_activa
Boolean parar
end variables

forward prototypes
public function integer fr_traspaso_escandallo (string empresa, string codigo, transaction trm)
public function integer fr_traspaso (string empresa, string codigo, transaction trm)
public function integer fr_traspaso_nivel (string empresa, string codigo, transaction trm, ref integer nivel)
end prototypes

public function integer fr_traspaso_escandallo (string empresa, string codigo, transaction trm);String sel, sel2, orden_t, codigo_apli_t
Int rtn, esta, esta_en_temporal, i, j, n, aux, numero_ver, numero_piezas, numero_op, numero_apli, orden, orden_inicial, codigo_apli, codigo_apli_inicial

Decimal coste_fab, coste_mp, coste_fab_mermas, coste_mp_mermas, formato_minimo, diferencia_formato, aux_formato
String operacion, operacion_siguiente, operacion_inicial, operacion_inicial_siguiente, operacion_aux, tipo_operacion, tipo_operacion_ant, tipo_operacion_old, articulo_anterior_operacion
String articulo_anterior_aplicacion, juegopantallas

String articulo_actual, nuevo_articulo, articulo_anterior, tipo_version, ruta, version_no_montaje, version_aux, ruta_descripcion, descripcion_version, observaciones_version
Decimal factor 
Int prioridad

String id_aplicacion, tipoaplicacion, separar_ventas, aplica_temp

Boolean agrupados_horno, agrupados_horno_siguiente, agrupar_encajado, debug_true, separar_ventas_apli, separar_ventas_op

Datastore operaciones, versiones, versiones_aux, aplicaciones

rtn = 1

//VER SI EL ARTICULO YA ESTÁ TRASPASADO
SELECT COUNT(*) INTO :esta FROM articulos_traspasados WHERE empresa = :empresa AND codigo = :codigo USING trm;

if esta > 0 then
	return rtn
else
	INSERT INTO articulos_traspasados (empresa, codigo) VALUES (:empresa, :codigo) USING trm;
end if

//OBTENCIÓN DE LA RUTA CON ARTÍCULO ANTERIOR DE FORMATO MAS PEQUEÑO (Para descripciones de artículo)
sel2 ="SELECT MIN(F2.ancho - F1.ancho + F2.largo - F1.largo) AS diferencia, V.version "+&
		"FROM art_escandallo E "+&
		"INNER JOIN art_versiones V ON E.empresa = V.empresa AND E.articulo = V.articulo AND E.version = V.version "+&
		"INNER JOIN articulos A1 ON E.empresa = A1.empresa AND E.articulo = A1.codigo "+&
		"INNER JOIN formatos F1 ON A1.empresa = F1.empresa AND A1.formato = F1.codigo "+&
		"INNER JOIN articulos A2 ON E.empresa = A2.empresa AND E.articulo_ant = A2.codigo "+&
		"INNER JOIN formatos F2 ON A2.empresa = F2.empresa AND A2.formato = F2.codigo "+&
  		"WHERE E.empresa = '"+empresa+"' AND E.articulo = '"+codigo+"' GROUP BY V.version ORDER BY V.version ASC"
f_cargar_cursor_trans (trm,  sel2, versiones_aux)

aux = 1
formato_minimo = -1
do while (aux <= versiones_aux.RowCount()) 
	aux_formato = versiones_aux.object.diferencia[aux]
	if formato_minimo = -1 or aux_formato < formato_minimo then
		formato_minimo = aux_formato
	end if
	aux ++
loop

versiones_aux.reset()


//OBTENCIÓN DEL ESCANDALLO Y LAS VERSIONES

SELECT COUNT(version) INTO :numero_ver FROM art_versiones WHERE empresa = :empresa AND articulo = :codigo USING trm;

sel = "SELECT art_escandallo.articulo_ant, art_versiones.tipo_version, art_escandallo.factor, art_versiones.version, "+&
		"art_versiones.descripcion, art_versiones.observaciones "+&
		"FROM art_escandallo "+&
		"INNER JOIN art_versiones ON art_escandallo.empresa = art_versiones.empresa AND art_escandallo.articulo = art_versiones.articulo AND art_escandallo.version = art_versiones.version "+&
  		"WHERE art_escandallo.empresa = '"+empresa+"' AND art_escandallo.articulo = '"+codigo+"' ORDER BY art_versiones.version ASC"
f_cargar_cursor_trans (trm,  sel, versiones)
numero_piezas = versiones.RowCount()

rtn = 1
i = 1
separar_ventas = "" //separar_ventas SOLO VÁLIDO SI NO HAY VERSIONES EN LOS ENCAJADOS
separar_ventas_op = false
separar_ventas_apli = false
do while (i <= numero_piezas AND rtn = 1) 
	
	articulo_anterior = versiones.object.art_escandallo_articulo_ant[i]
	tipo_version = versiones.object.art_versiones_tipo_version[i]
	if tipo_version = "P" then
		prioridad = 1
	else
		prioridad = 2
	end if
	if numero_ver = 1 then
		prioridad = 1
	end if
	
	//Debug 
		if codigo = '33830' then
			debug_true = true
		end if
	
	ruta = versiones.object.art_versiones_version[i]
	factor = versiones.object.art_escandallo_factor[i]
	if (isnull(articulo_anterior) or trim(articulo_anterior) = "" or articulo_anterior = "0") and isnull(factor) then //Base -> Factor 0
		factor = 0
	end if
	descripcion_version = versiones.object.art_versiones_descripcion[i]
	observaciones_version = versiones.object.art_versiones_observaciones[i]
	
	//Diferencias de tamaño en el articulo anterior para versiones de artículo debidas a cortes
	SELECT MIN(F2.ancho - F1.ancho + F2.largo - F1.largo) INTO :diferencia_formato 
   FROM art_escandallo E 
   INNER JOIN art_versiones V ON E.empresa = V.empresa AND E.articulo = V.articulo AND E.version = V.version 
   INNER JOIN articulos A1 ON E.empresa = A1.empresa AND E.articulo = A1.codigo 
   INNER JOIN formatos F1 ON A1.empresa = F1.empresa AND A1.formato = F1.codigo 
   INNER JOIN articulos A2 ON E.empresa = A2.empresa AND E.articulo_ant = A2.codigo 
   INNER JOIN formatos F2 ON A2.empresa = F2.empresa AND A2.formato = F2.codigo 
   WHERE E.empresa = :empresa AND E.articulo = :codigo AND V.version = :ruta GROUP BY V.version ORDER BY V.version ASC;
	
	
	//Obtener las operaciones de cada versión
	sel = "SELECT * FROM art_ver_operaciones WHERE empresa = '"+empresa+"' AND articulo = '"+codigo+"' AND version = '"+ruta+"' ORDER BY orden DESC "
	f_cargar_cursor_trans (trm,  sel,  operaciones)
	numero_op = operaciones.RowCount()
	
	j = 1
	articulo_actual = codigo
	tipo_operacion_ant = ""
	
	do while (j <= numero_op AND rtn = 1) 
		
		agrupados_horno = false
		agrupados_horno_siguiente = false
		agrupar_encajado = false
		articulo_anterior_aplicacion = ""
		operacion = operaciones.object.operacion[j]
		if j < numero_op then
			operacion_siguiente = operaciones.object.tipo_operacion[j+1]
		else
			operacion_siguiente = ""
		end if
		operacion_inicial = operaciones.object.tipo_operacion[numero_op]
		if numero_op - 1 > 0 then
			operacion_inicial_siguiente = operaciones.object.tipo_operacion[numero_op - 1]
		else
			operacion_inicial_siguiente = ""
		end if
		tipo_operacion = operaciones.object.tipo_operacion[j]
		coste_fab = operaciones.object.coste_fab[j]
		coste_mp = operaciones.object.coste_mp[j]
		coste_fab_mermas = operaciones.object.coste_fab_mermas[j]
		coste_mp_mermas = operaciones.object.coste_mp_mermas[j]
		juegopantallas = operaciones.object.juegopantallas[j]
		
		if tipo_operacion <> "2" and tipo_operacion <> "12" and tipo_operacion <> "15" and tipo_operacion <> "24" and tipo_operacion <> "30" then //Solo hay juego de pantallas en 3FUE, PVID, 4FUE, 5FUE e INK
			setnull(juegopantallas)
		end if
		
		//Necesitamos saber la operación siguiente por si hay agrupación de artículos de hornos
		if j < numero_op then
			if tipo_operacion = "3" and operacion_siguiente = "12" then
				agrupados_horno_siguiente = true
			end if
		end if
		
		//Salvo para la última operación o agrupación PVID - HORN, debemos generar nuevo código de articulo para cada operación
		if (tipo_operacion = "12" and tipo_operacion_ant = "3") then
			
		else
			if j < numero_op  or (j = 1 and tipo_operacion = "9") or (j = 1 and tipo_operacion = "27") then
				SELECT COUNT(*) INTO :esta FROM articulos_temporal USING trm;
				if esta < 1 then //Primer articulo traspasado, empezamos por el código 
					nuevo_articulo = "200000"
				else //Resto de nuevos articulos
					SELECT CONVERT(Char,(MAX(CONVERT(Integer,codigo)) + 1)) INTO :nuevo_articulo FROM articulos_temporal USING trm;
				end if
			end if
		end if
		
		
		
		articulo_anterior_operacion = ""
		if j = 1 and (tipo_operacion = "9" or tipo_operacion = "27") then //ENC y ENF
			//Separación encajado de ventas y agrupacion ENC, HORN y PV
			if not isnull(articulo_anterior) and articulo_anterior <> "" then
				SELECT tipo_operacion INTO :articulo_anterior_operacion FROM art_ver_operaciones WHERE empresa = :empresa AND articulo = :articulo_anterior AND orden = (SELECT CONVERT(Char,(MAX(CONVERT(Integer,orden)))) FROM art_ver_operaciones WHERE empresa = :empresa AND articulo = :articulo_anterior) USING trm;
			else
				articulo_anterior_operacion = ""
			end if
			if tipo_operacion = "9" AND (articulo_anterior_operacion = "3" or articulo_anterior_operacion = "5" or articulo_anterior_operacion = "26" or articulo_anterior_operacion = "16" or articulo_anterior_operacion = "25" or articulo_anterior_operacion = "33") then //HORNO, CORT, ENCR, PULIDO, ENVEJECER, ELECTRO.
				//HAY QUE AGRUPAR ENC y HORN, ENC y CORT, ENC y ENCR, ENC y PULIDO, ENC y ENV y ENC y ELECTRODEPOSICIÓN
				agrupar_encajado = true
			else
				//HAY QUE SEPARAR encajado de ventas de ENC o ENF
				if separar_ventas = "" then
					articulo_actual = nuevo_articulo
					separar_ventas = nuevo_articulo
				end if
			end if
		end if
		
		
		//INSERCIONES NUEVOS ARTICULOS POR OPERACIÓN
		//En la primera operación debemos actualizar el articulo y en el resto de caso hacer inserciones (salvo agrupaciones y ENC)
		if j = 1 and tipo_operacion <> "9" and tipo_operacion <> "27" then
		
			//UPDATE
			//OJO CALCULOS MERMAS!!!!!!!!!!!!!!!! Hay que sumar el de todas las operaciones contenidas en el artículo
//**********************************************************************************************************************************************
			UPDATE articulos SET coste_fab = coste_fab, coste_mp = :coste_mp, coste_fab_mermas = :coste_fab_mermas,
										coste_mp_mermas = :coste_mp_mermas 
			WHERE empresa = :empresa AND codigo = :codigo USING trm;
			
			if nuevo_articulo <> "" then
				SELECT COUNT(*) INTO :esta_en_temporal FROM articulos_temporal WHERE empresa = :empresa AND codigo = :nuevo_articulo USING trm;
				if esta_en_temporal < 1 then
					INSERT INTO articulos_temporal (empresa, codigo) VALUES (:empresa, :nuevo_articulo) USING trm;
					IF trm.SQLCode <> 0 THEN         
						MessageBox("SQL error", trm.SQLErrText +" Consulta Artículos Temporal 1: "+String(trm.SQLDBCode))
						return -1
					END IF
				end if
			end if
			
		else
			
			//INSERT
			//USO SIEMPRE 2 (INTERMEDIO) EN LOS ARTICULOS NUEVOS
			if (tipo_operacion = "12" and tipo_operacion_ant = "3") or agrupar_encajado = true or separar_ventas_op = true then //Agrupacion ENC, PVID y HORNOS
				if separar_ventas_op = false then
					agrupados_horno = true
				end if
			else
				SELECT COUNT(*) INTO :esta_en_temporal FROM articulos_temporal WHERE empresa = :empresa AND codigo = :nuevo_articulo USING trm;
				if esta_en_temporal < 1 then
					INSERT INTO articulos_temporal (empresa, codigo) VALUES (:empresa, :nuevo_articulo) USING trm;
				end if
				IF trm.SQLCode <> 0 THEN         
					MessageBox("SQL error", trm.SQLErrText +" Consulta Articulos temporal 2 : "+String(trm.SQLDBCode))
					return -1
				END IF
				
				INSERT INTO articulos 	(empresa, codigo, descripcion, familia, subfamilia, formato, ancho, largo, subformato, modelo, unidad, precio_coste, 
															fecha_alta, fecha_anulado, fecha_fin, cuenta, proveedor, decorado, sector, conjunto, pesopieza, piezascaja, pesocaja, 
															pesoenvase, metroscaja, metroslcaja, cuenta_contable, tono, calibre, compras, activo, unidad_est, prev_anular, empleado, 
															molde, plato_sup, plato_inf, calibre_min, calibre_max, cliente, uso, estilo, coleccion, color, imagen, referencia_laboratorio, 
															version_laboratorio, fecha_primera_produccion, tipo_pasta, codigo_pantallas, espesor, ciclo, temp_inferior, temp_superior, 
															ean13, ventasitalia, usuario, temp_inferior1, temp_superior1, obs_ficha_hornos, tipo, partidaest, control_stock, stock_min, 
															ubi_muestras, stocksugerido, fechastocksugerido, codigo_compras, estandar, bloqueado, cod_cliente, marco, canto_vivo, 
															marcado, etiqueta_ce, lote, observaciones, coste_fab, coste_mp, coste_fab_mermas, coste_mp_mermas) 
				SELECT empresa, :articulo_actual, descripcion, familia, subfamilia, formato, ancho, largo, subformato, modelo, unidad, precio_coste, 
						 fecha_alta, fecha_anulado, fecha_fin, cuenta, proveedor, decorado, sector, conjunto, pesopieza, piezascaja, pesocaja, 
						 pesoenvase, metroscaja, metroslcaja, cuenta_contable, tono, calibre, compras, activo, unidad_est, prev_anular, empleado, 
						 molde, plato_sup, plato_inf, calibre_min, calibre_max, cliente, 2, estilo, coleccion, color, imagen, referencia_laboratorio, 
						 version_laboratorio, fecha_primera_produccion, tipo_pasta, codigo_pantallas, espesor, ciclo, temp_inferior, temp_superior, 
						 ean13, ventasitalia, usuario, temp_inferior1, temp_superior1, obs_ficha_hornos, tipo, partidaest, control_stock, stock_min, 
						 ubi_muestras, stocksugerido, fechastocksugerido, codigo_compras, estandar, bloqueado, cod_cliente, marco, canto_vivo, 
						 marcado, etiqueta_ce, lote, observaciones, :coste_fab, :coste_mp, :coste_fab_mermas, :coste_mp_mermas 
				FROM articulos WHERE empresa = :empresa AND codigo = :codigo USING trm;
				
				if separar_ventas <> "" then
					separar_ventas_op = true
				end if
				
				IF trm.SQLCode <> 0 THEN         
					MessageBox("SQL error", trm.SQLErrText +" Consulta Inserción Artículos 1: "+String(trm.SQLDBCode))
					return -1
				END IF
				
				
				//Código estadístico
				INSERT INTO art_codestadistico 
					(empresa, codigo, G1, G2, G3, G4, PT, GD, NC, RE, rectificado, AV, PL, CT, EN, TM, OTR, N, INKCID)
				VALUES
					(:empresa, :articulo_actual, NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
				USING trm;
				
				IF trm.SQLCode <> 0 THEN         
					MessageBox("SQL error", trm.SQLErrText +" Consulta Inserción Artículos 2: "+String(trm.SQLDBCode))
					return -1
				END IF
				
				INSERT INTO almartcajas 
					(empresa, articulo, caja, piezascaja, metroscaja, metroslcaja, pesocaja, metros_reales_caja, peso_real_caja, metros_reales, descripcion, codigo, pordefecto)
				VALUES
					(:empresa, :articulo_actual, '31', 999, 0, 0, 0, NULL, NULL, 0, NULL, NULL, 'S')
				USING trm;
				
				IF trm.SQLCode <> 0 THEN         
					MessageBox("SQL error", trm.SQLErrText +" Consulta Inserción Artículos 3: "+String(trm.SQLDBCode))
					return -1
				END IF
				
				INSERT INTO palarticulo 
					(empresa, articulo, codigo, caja, cajaspallet, planospallet, alturas, pordefecto)
				VALUES
					(:empresa, :articulo_actual, '31', '738', '999', '999', '999', 'S') //31 -> Palet Genérico, 738 Caja Genérica
				USING trm;
				
				IF trm.SQLCode <> 0 THEN         
					MessageBox("SQL error", trm.SQLErrText +" Consulta Inserción Artículos 4: "+String(trm.SQLDBCode))
					return -1
				END IF
				
				INSERT INTO almartcal 
					(empresa, articulo, calidad, precio, fecha_alta, stockmin, stockmax, puntopedido)
				VALUES 
					(:empresa, :articulo_actual, '1', NULL, GETDATE(), NULL, NULL, NULL)
				USING trm;
				
				IF trm.SQLCode <> 0 THEN         
					MessageBox("SQL error", trm.SQLErrText +" Consulta Inserción Artículos 5: "+String(trm.SQLDBCode))
					return -1
				END IF
			end if
		end if	
		
		//SELECCION DE LA NUEVA OPERACIÓN
		tipo_operacion_old = tipo_operacion
		if tipo_operacion = "9" then //ENCAJADOS
			if agrupar_encajado = true then 
				tipo_operacion = "10"
			else
				tipo_operacion = "3"
			end if
		elseif tipo_operacion = "12" then //PVID
			tipo_operacion = "3"
		elseif tipo_operacion = "20" then //QUEMAR CERA
			tipo_operacion = "3"
		elseif tipo_operacion = "16" then //PULIDO
			tipo_operacion = "8"
		elseif tipo_operacion = "25" then //ENVEJECER
			tipo_operacion = "8"
		elseif tipo_operacion = "29" then //SUB. SERIGRAFIA
			tipo_operacion = "8"
		elseif tipo_operacion = "31" then //SUB. ENCAJADO
			tipo_operacion = "8"
		elseif tipo_operacion = "33" then //ELECTRODEPOSICIÓN
			tipo_operacion = "8"
		end if	
		
		//DESCRIPCIÓN DE LAS RUTAS
		ruta_descripcion = "1"
		if numero_ver = 1 then
			ruta_descripcion = "1"
		else
			if isnull(descripcion_version) or trim(descripcion_version) = "" and tipo_operacion = "5" then //Detección de ruta por corte al montaje o al modelo
				//El montaje tiene un tamaño mayor que la base aproximada al modelo					
				if formato_minimo = diferencia_formato then
					ruta_descripcion = "6"
				else
					ruta_descripcion = "8"
				end if					
			else
				//Casos de subcontratación y otros (serigrafia/inkcid, ...)
				if Pos(descripcion_version,"CONTR") <> 0 then
					ruta_descripcion = "2"
				else
					if tipo_operacion = "3" and operacion_siguiente = "1" then //Monococción (y prensado previo)
						ruta_descripcion = "11" 
					elseif operacion_inicial = "7" then //Bicocción
						ruta_descripcion = "12" 
					elseif operacion_inicial = "30" then //Inkcid
						ruta_descripcion = "10" 
					elseif tipo_operacion = "3" then //SERIGRAFIA ALTA O BAJA
						SELECT TOP 1 tipoaplicacion INTO :aplica_temp FROM art_ver_op_aplicaciones WHERE empresa = :empresa AND articulo = :codigo AND operacion = :operacion AND version = :ruta ORDER BY orden ASC USING trm; //41 alta, 42 Baja
						if aplica_temp = "41" then
							ruta_descripcion = "4"
						elseif aplica_temp = "42" then
							ruta_descripcion = "5"
						else
							ruta_descripcion = "3"
						end if
					elseif operacion_inicial = "2" OR operacion_inicial = "15" OR operacion_inicial = "24" then //Serigrafia
						ruta_descripcion = "3"
					elseif operacion_inicial = "5" then //Corte
						ruta_descripcion = "6" 
					elseif operacion_inicial = "6" then //Corte inglete
						ruta_descripcion = "7" 
					elseif operacion_inicial = "9" then //Encajados subcontratados - La ruta propia será Única
						ruta_descripcion = "1" 
					else
						if j <> 1 then
							ruta_descripcion = "1"
						else
							MessageBox("Error Traspaso","Ruta desconocida para el artículo con código "+codigo)
							return -1
						end if
					end if
				end if
			end if
		end if
		
		//RUTAS
		if agrupados_horno_siguiente = false then
			//Ruta en caso de separación del código de ventas y el encajado
			if (tipo_operacion_old = "9" OR tipo_operacion_old = "27") AND agrupar_encajado = false AND separar_ventas_apli = false then //ENCAJADOS - HAY QUE SEPARAR EL CÓDIGO DE VENTA DEL CÓDIGO DE PRODUCCIÓN (salvo agrupaciones ENC y HORN)
			
				INSERT INTO ruta_fabricacion (empresa, articulo, articulo_anterior, tipooperacion, ruta, factor, prioridad) 
				VALUES (:empresa, :codigo, :articulo_actual, 10, 1, 1, 1) USING trm;
				
				articulo_anterior_aplicacion = articulo_actual
				
				IF trm.SQLCode <> 0 THEN         
					MessageBox("SQL error", trm.SQLErrText +" Consulta Ruta Fabricación Ventas: "+String(trm.SQLDBCode))
					return -1
				END IF
				
				SELECT COUNT(*) INTO :esta FROM articulos_temporal USING trm;
				if esta < 1 then //Primer articulo traspasado, empezamos por el código 
					nuevo_articulo = "200000" 
				else //Resto de nuevos articulos
					SELECT CONVERT(Char,(MAX(CONVERT(Integer,codigo)) + 1)) INTO :nuevo_articulo FROM articulos_temporal USING trm;
				end if
				
				INSERT INTO articulos_temporal (empresa, codigo) VALUES (:empresa, :nuevo_articulo) USING trm;
					
			end if
			
				
			//Las rutas irán relacionadas con los nuevos artículos salvo el último caso en el que irá relacionado con el escandallo del articulo
			if j < numero_op then
				if j <> 1 then
					prioridad = 1
				end if
				//El factor es 1 para los artículos nuevos generados, la prioridad siempre es 1 (Única)
				INSERT INTO ruta_fabricacion (empresa, articulo, articulo_anterior, tipooperacion, ruta, factor, prioridad, juegopantallas) 
				VALUES (:empresa, :articulo_actual, :nuevo_articulo, :tipo_operacion, :ruta_descripcion, 1, :prioridad, :juegopantallas) USING trm;
				
				articulo_anterior_aplicacion = nuevo_articulo
			else
				if j <> 1 then
					prioridad = 1
				end if
				if separar_ventas = "" then
					INSERT INTO ruta_fabricacion (empresa, articulo, articulo_anterior, tipooperacion, ruta, factor, prioridad, observaciones, juegopantallas) 
					VALUES (:empresa, :articulo_actual, :articulo_anterior, :tipo_operacion, :ruta_descripcion, :factor, :prioridad, :observaciones_version, :juegopantallas) USING trm;
				else
					INSERT INTO ruta_fabricacion (empresa, articulo, articulo_anterior, tipooperacion, ruta, factor, prioridad, observaciones, juegopantallas) 
					VALUES (:empresa, :separar_ventas, :articulo_anterior, :tipo_operacion, :ruta_descripcion, :factor, :prioridad, :observaciones_version, :juegopantallas) USING trm;
				end if
				articulo_anterior_aplicacion = articulo_anterior
			end if
			
			IF trm.SQLCode <> 0 THEN         
				MessageBox("SQL error", trm.SQLErrText +" Consulta Ruta Fabricación: "+String(trm.SQLDBCode))
				return -1
			END IF
		else
			articulo_anterior_aplicacion = nuevo_articulo
		end if 
		
		//APLICACIONES
		sel = "SELECT * FROM art_ver_op_aplicaciones "+&
				"WHERE empresa = '"+empresa+"' AND articulo = '"+codigo+"' AND version = '"+ruta+"' AND operacion = '"+operacion+"' "+&
				"ORDER BY CONVERT(integer,orden) ASC"
		f_cargar_cursor_trans (trm,  sel, aplicaciones)
		numero_apli = aplicaciones.RowCount()
		
		rtn = 1
		n = 1
		
		if agrupados_horno = true then
			//Corregir el orden de las aplicaciones cuando se agrupa PV, HORN y ENC
			if agrupar_encajado = true then
				//Insertamos la aplicación de encajado en el horno (artículo anterior, TODAS SUS VERSIONES)
				
				sel2 ="SELECT version "+&
						"FROM art_versiones "+&
						"WHERE empresa = '"+empresa+"' AND articulo = '"+articulo_anterior+"' ORDER BY version ASC"
				f_cargar_cursor_trans (trm,  sel2, versiones_aux)

				aux = 1
				do while (aux <= versiones_aux.RowCount()) 
					version_aux = versiones_aux.object.version[aux]
					SELECT TOP 1 operacion INTO :operacion_aux FROM art_ver_operaciones WHERE empresa = :empresa AND articulo = :articulo_anterior AND version = :version_aux ORDER BY orden DESC USING trm;
					SELECT MAX(CONVERT(integer,orden)) INTO :orden_inicial FROM art_ver_op_aplicaciones WHERE empresa = :empresa AND articulo = :articulo_anterior AND version = :version_aux AND operacion = :operacion_aux USING trm;
					SELECT MAX(CONVERT(integer,contadoraplicacion)) INTO :codigo_apli_inicial FROM art_ver_op_aplicaciones WHERE empresa = :empresa AND articulo = :articulo_anterior AND version = :version_aux AND operacion = :operacion_aux USING trm;
					
					//IMPORTANTE - LAS APLICACIONES DEBEN CAMBIAR DE ID PARA EVITAR COLISIONES -> TENERLO EN CUENTA EN PARTES
//************************************************************************************************************************************************************************************
	
					
					INSERT INTO art_ver_op_aplicaciones (empresa, articulo, version, operacion, contadoraplicacion, pantalla, formula, gramaje, tipoaplicacion, orden, densidad, viscosidad, 
																	 boquilla, ciclo, temp_sup, temp_inf, cortes, discos, paso_cliche, gram_7x20, tiff, perfil) 
					SELECT empresa, :articulo_anterior, :version_aux, :operacion_aux, CONVERT(char, (:codigo_apli_inicial + CONVERT(integer, contadoraplicacion))), pantalla, formula, gramaje, tipoaplicacion, CONVERT(char, (:orden_inicial + CONVERT(integer, orden))), densidad, viscosidad, 
							 boquilla, ciclo, temp_sup, temp_inf, cortes, discos, paso_cliche, gram_7x20, tiff, perfil 
					FROM art_ver_op_aplicaciones 
					WHERE empresa = :empresa AND articulo = :codigo AND version = :ruta AND operacion = :operacion  
					USING trm;
				
					IF trm.SQLCode <> 0 THEN         
						MessageBox("SQL error", trm.SQLErrText +" Consulta Actualización Aplicaciones Encajado: "+String(trm.SQLDBCode))
						return -1
					END IF
					aux ++		
				loop
			
				versiones_aux.reset()
			else
				SELECT COUNT(*) INTO :orden_inicial FROM art_ver_op_aplicaciones WHERE empresa = :empresa AND articulo = :codigo AND version = :ruta AND operacion = :operacion USING trm;
				UPDATE aplicacion SET orden = CONVERT(char,(CONVERT(integer,orden)) + :orden_inicial) WHERE empresa = :empresa AND articulo = :articulo_actual USING trm;
				//SELECT MAX(orden) INTO :orden_inicial FROM aplicacion WHERE empresa = :empresa AND articulo = :articulo_actual USING trm; codigo? en vez de articulo_actual???
				codigo_apli_inicial = orden_inicial
				orden_inicial = 0
			end if
		else
			orden_inicial = 0
			codigo_apli_inicial = 0
		end if

		do while (n <= numero_apli AND rtn = 1 AND agrupar_encajado = false AND separar_ventas_apli = false) 
			
			if articulo_anterior_aplicacion = "" then
				MessageBox("Error importación","Error artículo "+codigo+". No se ha hayado el articulo anterior para insertar las aplicaciones.")
				return -1
			end if
			
			id_aplicacion = aplicaciones.object.contadoraplicacion[n]
			tipoaplicacion = aplicaciones.object.tipoaplicacion[n]
			
			if tipo_operacion_old = "20" then //QUEMAR CERA
				//if tipoaplicacion = "41" then //ALTA A CERA ALTA
					tipoaplicacion =  "56"
				//elseif tipoaplicacion = "42" then //BAJA A CERA BAJA
				//	tipoaplicacion =  "57"
				//end if
			elseif tipo_operacion_old = "27" then //ENCAJADO FRIO 
				if tipoaplicacion = "19" then //ENC A ENCF
					tipoaplicacion =  "20"
				end if
			end if
			
			orden = orden_inicial + n
			codigo_apli = codigo_apli + n
			orden_t = String(orden)
			codigo_apli_t = String(codigo_apli)
			
			//IMPORTANTE - LAS APLICACIONES DEBEN CAMBIAR DE ID PARA EVITAR COLISIONES -> TENERLO EN CUENTA EN PARTES
//************************************************************************************************************************************************************************************
			
			INSERT INTO aplicacion (empresa, articulo, articulo_anterior, tipooperacion, codigo, orden, tipoaplicacion, pantalla, formula, gramaje, gram_7x20, densidad, viscosidad,
											boquilla, ciclo, temp_sup, temp_inf, cortes, discos, paso_cliche, tiff, perfil) 
			SELECT empresa, :articulo_actual, :articulo_anterior_aplicacion, :tipo_operacion, :codigo_apli_t, :orden_t, :tipoaplicacion, pantalla, formula, gramaje, gram_7x20, densidad, 
					 viscosidad, boquilla, ciclo, temp_sup, temp_inf, cortes, discos, paso_cliche, tiff, perfil 
			FROM art_ver_op_aplicaciones 
			WHERE empresa = :empresa AND articulo = :codigo AND version = :ruta AND operacion = :operacion AND contadoraplicacion = :id_aplicacion 
			USING trm;
			
			IF trm.SQLCode <> 0 THEN         
				MessageBox("SQL error", trm.SQLErrText +" Consulta Inserción Aplicaciones: "+String(trm.SQLDBCode))
				return -1
			END IF
			
			n++
		loop
		aplicaciones.reset()
		
		if separar_ventas <> "" then
			separar_ventas_apli = true
		end if
		
		//articulo_anterior = articulo_actual
		if agrupados_horno_siguiente = false then
			articulo_actual = nuevo_articulo
		end if
		tipo_operacion_ant = tipo_operacion
		j++
	loop
	
	operaciones.reset()
	
	//ACTUALIZACIÓN DE RUTAS A PARTIR DEL ESCANDALLO Y DE LAS VERSIONES
	
	if not isnull (articulo_anterior) and articulo_anterior <> "0" and articulo_anterior <> "" then
		rtn = fr_traspaso_escandallo (empresa, articulo_anterior, trm)
	end if
		
	i++
loop

versiones.reset()

Destroy versiones
Destroy versiones_aux
Destroy operaciones
Destroy aplicaciones
return rtn
end function

public function integer fr_traspaso (string empresa, string codigo, transaction trm);Int esta= 0, resultado = 1
String sel, articulo, articulo_anterior, nuevo_articulo, articulo_actual, ruta, operacion, descripcion_versiones, observaciones_versiones, tipo_version, orden, tipo_operacion
Long numero_articulos, numero_operaciones, i, j, n
Dec factor
Datastore versiones, operaciones
String reservado[]
Long maximo = 0

//VER SI EL ARTICULO YA ESTÁ TRASPASADO
SELECT COUNT(*) INTO :esta FROM articulos_traspasados WHERE empresa = :empresa AND codigo = :codigo USING trm;
/*
if esta > 0 then
	//Ya está traspasado
	return 1
end if
*/
/*
//Comprobar que no hay "Peraltas"
SELECT empresa, articulo, version, articulo_ant, factor, aprovecha 
  FROM art_escandallo
  WHERE NOT EXISTS (SELECT * FROM art_versiones WHERE art_versiones.empresa = art_escandallo.empresa AND art_versiones.articulo = art_escandallo.articulo AND art_versiones.version = art_escandallo.version) 
  */

sel = "SELECT art_escandallo.articulo_ant, art_versiones.tipo_version, art_escandallo.factor, art_versiones.version, "+&
		"art_versiones.descripcion, art_versiones.observaciones "+&
		"FROM art_escandallo "+&
		"INNER JOIN art_versiones ON art_escandallo.empresa = art_versiones.empresa AND art_escandallo.articulo = art_versiones.articulo AND art_escandallo.version = art_versiones.version "+&
  		"WHERE art_escandallo.empresa = '"+empresa+"' AND art_escandallo.articulo = '"+codigo+"' ORDER BY art_versiones.version ASC"
f_cargar_cursor_trans (trm,  sel, versiones)
numero_articulos = versiones.RowCount()
i = 1
do while (i <= numero_articulos AND resultado = 1) 
	traspaso_numero_nodos++
	
	if traspaso_numero_nodos > 300 then
		MessageBox("Error", "Demasiados nodos en el artículo. Posible error de estructura")
		return -1
	end if
	
	articulo_anterior = versiones.object.art_escandallo_articulo_ant[i]
	ruta = versiones.object.art_versiones_version[i]
	descripcion_versiones = versiones.object.art_versiones_descripcion[i]
	observaciones_versiones = versiones.object.art_versiones_observaciones[i]
	tipo_version = versiones.object.art_versiones_tipo_version[i]
	
	//Extraer operaciones y crear articulos por operación
	sel = "SELECT operacion, orden, tipo_operacion FROM art_ver_operaciones WHERE empresa = '"+empresa+"' AND articulo = '"+codigo+"' AND version = '"+ruta+"' ORDER BY orden DESC "
	f_cargar_cursor_trans (trm,  sel,  operaciones)
	numero_operaciones = operaciones.RowCount()
	j = 1	
	articulo = ""
	do while (j <= numero_operaciones AND resultado = 1)  
		operacion = operaciones.object.operacion[j]
		tipo_operacion = operaciones.object.tipo_operacion[j]
		orden = operaciones.object.orden[j]
		if articulo = "" then
			articulo = codigo 
		else
			articulo = nuevo_articulo
		end if
		
		//Obtener codigo de nuevo artículo para la operación siguiente 
		if j <> numero_operaciones then //La última operación no necesita generar código nuevo, puesto que ya no se crearán más artículos
			articulo_actual  = nuevo_articulo
			nuevo_articulo = ""
			SELECT CONVERT(Char,(MAX(CONVERT(dec,codigo)) + 1)) INTO :nuevo_articulo FROM articulos USING trm;
			if isnull(nuevo_articulo) or nuevo_articulo = "" then
				return -1
			end if
			if UpperBound(reservado) > 0 then
				for n=1 to UpperBound(reservado)
					if maximo < long(reservado[n]) then
						maximo = long(reservado[n])
					end if
				next
				if long(nuevo_articulo) <= maximo then
					nuevo_articulo = String(long(maximo)+1)
				end if
				reservado[UpperBound(reservado)+1] = nuevo_articulo
			else
				reservado[1] = nuevo_articulo
			end if
			factor = 1.00
			
			//Insertamos el nuevo articulo
			INSERT INTO articulos (empresa, codigo, descripcion, familia, subfamilia, formato, ancho, largo, subformato, modelo, unidad, precio_coste, 
											fecha_alta, fecha_anulado, fecha_fin, cuenta, proveedor, decorado, sector, conjunto, pesopieza, piezascaja, pesocaja, 
											pesoenvase, metroscaja, metroslcaja, cuenta_contable, tono, calibre, compras, activo, unidad_est, prev_anular, empleado, 
											molde, plato_sup, plato_inf, calibre_min, calibre_max, cliente, uso, estilo, coleccion, color, imagen, referencia_laboratorio, 
											version_laboratorio, fecha_primera_produccion, tipo_pasta, codigo_pantallas, espesor, ciclo, temp_inferior, temp_superior, 
											ean13, ventasitalia, usuario, temp_inferior1, temp_superior1, obs_ficha_hornos, tipo, partidaest, control_stock, stock_min, 
											ubi_muestras, stocksugerido, fechastocksugerido, codigo_compras, estandar, bloqueado, cod_cliente, marco, canto_vivo, 
											marcado, etiqueta_ce, lote, observaciones) 
			SELECT empresa, :nuevo_articulo, descripcion, familia, subfamilia, formato, ancho, largo, subformato, modelo, unidad, precio_coste, 
					 fecha_alta, fecha_anulado, fecha_fin, cuenta, proveedor, decorado, sector, conjunto, pesopieza, piezascaja, pesocaja, 
					 pesoenvase, metroscaja, metroslcaja, cuenta_contable, tono, calibre, compras, activo, unidad_est, prev_anular, empleado, 
					 molde, plato_sup, plato_inf, calibre_min, calibre_max, cliente, 2, estilo, coleccion, color, imagen, referencia_laboratorio, 
					 version_laboratorio, fecha_primera_produccion, tipo_pasta, codigo_pantallas, espesor, ciclo, temp_inferior, temp_superior, 
					 ean13, ventasitalia, usuario, temp_inferior1, temp_superior1, obs_ficha_hornos, tipo, partidaest, control_stock, stock_min, 
					 ubi_muestras, stocksugerido, fechastocksugerido, codigo_compras, estandar, bloqueado, cod_cliente, marco, canto_vivo, 
					 marcado, etiqueta_ce, lote, observaciones
			FROM articulos WHERE empresa = :empresa AND codigo = :codigo 
			USING trm;
			IF trm.SQLCode <> 0 THEN         
				MessageBox("SQL error", trm.SQLErrText +" Consulta Inserción Artículos 1: "+String(trm.SQLDBCode))
				return -1
			END IF
			
			INSERT INTO art_codestadistico 
				(empresa, codigo, G1, G2, G3, G4, PT, GD, NC, RE, rectificado, AV, PL, CT, EN, TM, OTR, N, INKCID)
			VALUES
				(:empresa, :nuevo_articulo, NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
			USING trm;
			IF trm.SQLCode <> 0 THEN         
				MessageBox("SQL error", trm.SQLErrText +" Consulta Inserción Artículos 2: "+String(trm.SQLDBCode))
				return -1
			END IF
			
			INSERT INTO almartcajas 
				(empresa, articulo, caja, piezascaja, metroscaja, metroslcaja, pesocaja, metros_reales_caja, peso_real_caja, metros_reales, descripcion, codigo, pordefecto)
			VALUES
				(:empresa, :nuevo_articulo, '31', 999, 0, 0, 0, NULL, NULL, 0, NULL, NULL, 'S')
			USING trm;
			IF trm.SQLCode <> 0 THEN         
				MessageBox("SQL error", trm.SQLErrText +" Consulta Inserción Artículos 3: "+String(trm.SQLDBCode))
				return -1
			END IF
			
			INSERT INTO palarticulo 
				(empresa, articulo, codigo, caja, cajaspallet, planospallet, alturas, pordefecto)
			VALUES
				(:empresa, :nuevo_articulo, '31', '738', '999', '999', '999', 'S') //31 -> Palet Genérico, 738 Caja Genérica
			USING trm;
			IF trm.SQLCode <> 0 THEN         
				MessageBox("SQL error", trm.SQLErrText +" Consulta Inserción Artículos 4: "+String(trm.SQLDBCode))
				return -1
			END IF
			
			INSERT INTO almartcal 
				(empresa, articulo, calidad, precio, fecha_alta, stockmin, stockmax, puntopedido)
			VALUES 
				(:empresa, :nuevo_articulo, '1', NULL, GETDATE(), NULL, NULL, NULL)
			USING trm;
			IF trm.SQLCode <> 0 THEN         
				MessageBox("SQL error", trm.SQLErrText +" Consulta Inserción Artículos 5: "+String(trm.SQLDBCode))
				return -1
			END IF
			
		else
			articulo_actual  = nuevo_articulo
			nuevo_articulo = articulo_anterior
			factor = versiones.object.art_escandallo_factor[i]
		end if
		
		if j<> 1 then			
			//OPERACIONES 
			UPDATE art_ver_operaciones SET articulo = :articulo_actual, operacion = '1', orden = '1'
			WHERE empresa = :empresa AND articulo = :codigo AND version = :ruta AND operacion = :operacion  
			USING trm;
			IF trm.SQLCode <> 0 THEN         
				MessageBox("SQL error", trm.SQLErrText +" Consulta Inserción Artículos 6: "+String(trm.SQLDBCode))
				return -1
			END IF
			
			//APLICACIONES
			UPDATE art_ver_op_aplicaciones SET articulo = :articulo_actual, operacion = '1' 
			WHERE empresa = :empresa AND articulo = :codigo AND version = :ruta AND operacion = :operacion  
			USING trm;
			IF trm.SQLCode <> 0 THEN         
				MessageBox("SQL error", trm.SQLErrText +" Consulta Inserción Artículos 7: "+String(trm.SQLDBCode))
				return -1
			END IF
			
			//PLANIFICACION 
			UPDATE planificacion SET cod_articulo = :articulo_actual, ordenoperacion = 1
			WHERE empresa = :empresa AND cod_articulo = :codigo AND version = :ruta AND tipo_operacion = :tipo_operacion AND ordenoperacion = :orden 
			USING trm;
			IF trm.SQLCode <> 0 THEN         
				MessageBox("SQL error", trm.SQLErrText +" Consulta Update Planificacion "+String(trm.SQLDBCode))
				return -1
			END IF
			
			//PARTES 
			UPDATE prodpartes_ot SET articulo = :articulo_actual, ordenoperacion = 1
			WHERE empresa = :empresa AND articulo = :codigo AND version = :ruta AND operacion = :tipo_operacion  AND ordenoperacion = :orden 
			USING trm;
			IF trm.SQLCode <> 0 THEN         
				MessageBox("SQL error", trm.SQLErrText +" Consulta Update  Partes "+String(trm.SQLDBCode))
				return -1
			END IF
			
		else
			//OPERACIONES 
			UPDATE art_ver_operaciones SET orden = '1'
			WHERE empresa = :empresa AND articulo = :codigo AND version = :ruta AND operacion = :operacion  
			USING trm;
			IF trm.SQLCode <> 0 THEN         
				MessageBox("SQL error", trm.SQLErrText +" Consulta Inserción Artículos 6: "+String(trm.SQLDBCode))
				return -1
			END IF
			
			//PLANIFICACION 
			UPDATE planificacion SET ordenoperacion = 1 
			WHERE empresa = :empresa AND cod_articulo = :codigo AND version = :ruta AND ordenoperacion = :orden  
			USING trm;
			IF trm.SQLCode <> 0 THEN         
				MessageBox("SQL error", trm.SQLErrText +" Consulta Update Planificacion "+String(trm.SQLDBCode))
				return -1
			END IF
			
			//PARTES 
			UPDATE prodpartes_ot SET ordenoperacion = 1 
			WHERE empresa = :empresa AND articulo = :codigo AND version = :ruta AND operacion = :tipo_operacion AND ordenoperacion = :orden  
			USING trm;
			IF trm.SQLCode <> 0 THEN         
				MessageBox("SQL error", trm.SQLErrText +" Consulta Update  Partes "+String(trm.SQLDBCode))
				return -1
			END IF
		end if
			
		//Variar escandallo y versiones
		if j = 1 then  //Atención: La última operación conserva el código de artículo actual (j = numero_operaciones)
			UPDATE art_escandallo SET 
			articulo_ant = :nuevo_articulo, 
			factor = :factor
			WHERE empresa = :empresa AND articulo = :articulo AND version = :ruta AND articulo_ant = :articulo_anterior
			USING trm;
			if trm.SQLCode <> 0 THEN  
				MessageBox("SQL error", trm.SQLErrText +" UPDATE art_escandallo "+String(trm.SQLDBCode))
				return -1
			end if
			
			UPDATE art_versiones SET base = :nuevo_articulo 
			WHERE empresa = :empresa AND articulo = :articulo AND version = :ruta 
			USING trm;
			if trm.SQLCode <> 0 THEN  
				MessageBox("SQL error", trm.SQLErrText +" UPDATE art_versiones "+String(trm.SQLDBCode))
				return -1
			end if
		else
			INSERT INTO art_escandallo (empresa, articulo, version, articulo_ant, factor) 
			VALUES (:empresa, :articulo, :ruta, :nuevo_articulo, :factor) 
			USING trm;
			if trm.SQLCode <> 0 THEN  
				MessageBox("SQL error", trm.SQLErrText +" INSERT art_escandallo "+String(trm.SQLDBCode))
				return -1
			end if
			
			INSERT INTO art_versiones (empresa, articulo, version, base, descripcion, observaciones, tipo_version) 
			VALUES (:empresa, :articulo, :ruta, :nuevo_articulo, :descripcion_versiones, :observaciones_versiones, :tipo_version) 
			USING trm;
			if trm.SQLCode <> 0 THEN  
				MessageBox("SQL error", trm.SQLErrText +" INSERT art_escandallo "+String(trm.SQLDBCode))
				return -1
			end if
		end if
		
		j++
	loop	
	
	//Pasar al siguiente artículo de la esctructura
	resultado = fr_traspaso(empresa, articulo_anterior, trm)
	
	if resultado <> 1 then
		return -1
	end if
	
	i++
loop
	
if resultado = 1 then
	if esta <= 0 then
		INSERT INTO articulos_traspasados (empresa, codigo) VALUES (:empresa, :codigo) USING trm;
		if trm.SQLCode <> 0 THEN  
			MessageBox("SQL error", trm.SQLErrText +" INSERT articulos_traspasados "+String(trm.SQLDBCode))
			return -1
		end if
	end if
end if

destroy versiones
destroy operaciones
return resultado
end function

public function integer fr_traspaso_nivel (string empresa, string codigo, transaction trm, ref integer nivel);Int esta= 0, resultado = 1, nivel_actual
String sel, articulo, articulo_anterior, nuevo_articulo, articulo_actual, ruta, operacion, descripcion_versiones, observaciones_versiones, tipo_version, orden, tipo_operacion
Long numero_articulos, numero_operaciones, i, j, n
Dec factor
Datastore versiones, operaciones
String reservado[]
Long maximo = 0

//VER SI EL ARTICULO YA ESTÁ TRASPASADO
SELECT COUNT(*) INTO :esta FROM articulos_traspasados WHERE empresa = :empresa AND codigo = :codigo USING trm;
/*
if esta > 0 then
	//Ya está traspasado
	return 1
end if
*/
/*
//Comprobar que no hay "Peraltas"
SELECT empresa, articulo, version, articulo_ant, factor, aprovecha 
  FROM art_escandallo
  WHERE NOT EXISTS (SELECT * FROM art_versiones WHERE art_versiones.empresa = art_escandallo.empresa AND art_versiones.articulo = art_escandallo.articulo AND art_versiones.version = art_escandallo.version) 
  */

sel = "SELECT art_escandallo.articulo_ant, art_versiones.tipo_version, art_escandallo.factor, art_versiones.version, "+&
		"art_versiones.descripcion, art_versiones.observaciones "+&
		"FROM art_escandallo "+&
		"INNER JOIN art_versiones ON art_escandallo.empresa = art_versiones.empresa AND art_escandallo.articulo = art_versiones.articulo AND art_escandallo.version = art_versiones.version "+&
  		"WHERE art_escandallo.empresa = '"+empresa+"' AND art_escandallo.articulo = '"+codigo+"' ORDER BY art_versiones.version ASC"
f_cargar_cursor_trans (trm,  sel, versiones)
numero_articulos = versiones.RowCount()
i = 1
do while (i <= numero_articulos AND resultado = 1) 
	traspaso_numero_nodos++
	
	nivel_actual = nivel
	
	if traspaso_numero_nodos > 300 then
		MessageBox("Error", "Demasiados nodos en el artículo. Posible error de estructura")
		return -1
	end if
	
	articulo_anterior = versiones.object.art_escandallo_articulo_ant[i]
	ruta = versiones.object.art_versiones_version[i]
	descripcion_versiones = versiones.object.art_versiones_descripcion[i]
	observaciones_versiones = versiones.object.art_versiones_observaciones[i]
	tipo_version = versiones.object.art_versiones_tipo_version[i]
	
	//Extraer operaciones y crear articulos por operación
	sel = "SELECT operacion, orden, tipo_operacion FROM art_ver_operaciones WHERE empresa = '"+empresa+"' AND articulo = '"+codigo+"' AND version = '"+ruta+"' ORDER BY orden DESC "
	f_cargar_cursor_trans (trm,  sel,  operaciones)
	numero_operaciones = operaciones.RowCount()
	j = 1	
	articulo = ""
	do while (j <= numero_operaciones AND resultado = 1)  
		operacion = operaciones.object.operacion[j]
		tipo_operacion = operaciones.object.tipo_operacion[j]
		orden = operaciones.object.orden[j]
		if articulo = "" then
			articulo = codigo 
		else
			articulo = nuevo_articulo
		end if
		
		//Obtener codigo de nuevo artículo para la operación siguiente 
		if j <> numero_operaciones then //La última operación no necesita generar código nuevo, puesto que ya no se crearán más artículos
			articulo_actual  = nuevo_articulo
			nuevo_articulo = ""
			SELECT CONVERT(Char,(MAX(CONVERT(dec,codigo)) + 1)) INTO :nuevo_articulo FROM articulos USING trm;
			if isnull(nuevo_articulo) or nuevo_articulo = "" then
				return -1
			end if
			if UpperBound(reservado) > 0 then
				for n=1 to UpperBound(reservado)
					if maximo < long(reservado[n]) then
						maximo = long(reservado[n])
					end if
				next
				if long(nuevo_articulo) <= maximo then
					nuevo_articulo = String(long(maximo)+1)
				end if
				reservado[UpperBound(reservado)+1] = nuevo_articulo
			else
				reservado[1] = nuevo_articulo
			end if
			factor = 1.00
			
			//Insertamos el nuevo articulo
			INSERT INTO articulos (empresa, codigo, descripcion, familia, subfamilia, formato, ancho, largo, subformato, modelo, unidad, precio_coste, 
											fecha_alta, fecha_anulado, fecha_fin, cuenta, proveedor, decorado, sector, conjunto, pesopieza, piezascaja, pesocaja, 
											pesoenvase, metroscaja, metroslcaja, cuenta_contable, tono, calibre, compras, activo, unidad_est, prev_anular, empleado, 
											molde, plato_sup, plato_inf, calibre_min, calibre_max, cliente, uso, estilo, coleccion, color, imagen, referencia_laboratorio, 
											version_laboratorio, fecha_primera_produccion, tipo_pasta, codigo_pantallas, espesor, ciclo, temp_inferior, temp_superior, 
											ean13, ventasitalia, usuario, temp_inferior1, temp_superior1, obs_ficha_hornos, tipo, partidaest, control_stock, stock_min, 
											ubi_muestras, stocksugerido, fechastocksugerido, codigo_compras, estandar, bloqueado, cod_cliente, marco, canto_vivo, 
											marcado, etiqueta_ce, lote, observaciones) 
			SELECT empresa, :nuevo_articulo, descripcion, familia, subfamilia, formato, ancho, largo, subformato, modelo, unidad, precio_coste, 
					 fecha_alta, fecha_anulado, fecha_fin, cuenta, proveedor, decorado, sector, conjunto, pesopieza, piezascaja, pesocaja, 
					 pesoenvase, metroscaja, metroslcaja, cuenta_contable, tono, calibre, compras, activo, unidad_est, prev_anular, empleado, 
					 molde, plato_sup, plato_inf, calibre_min, calibre_max, cliente, 2, estilo, coleccion, color, imagen, referencia_laboratorio, 
					 version_laboratorio, fecha_primera_produccion, tipo_pasta, codigo_pantallas, espesor, ciclo, temp_inferior, temp_superior, 
					 ean13, ventasitalia, usuario, temp_inferior1, temp_superior1, obs_ficha_hornos, tipo, partidaest, control_stock, stock_min, 
					 ubi_muestras, stocksugerido, fechastocksugerido, codigo_compras, estandar, bloqueado, cod_cliente, marco, canto_vivo, 
					 marcado, etiqueta_ce, lote, observaciones
			FROM articulos WHERE empresa = :empresa AND codigo = :codigo 
			USING trm;
			IF trm.SQLCode <> 0 THEN         
				MessageBox("SQL error", trm.SQLErrText +" Consulta Inserción Artículos 1: "+String(trm.SQLDBCode))
				return -1
			END IF
			
			INSERT INTO art_codestadistico 
				(empresa, codigo, G1, G2, G3, G4, PT, GD, NC, RE, rectificado, AV, PL, CT, EN, TM, OTR, N, INKCID)
			VALUES
				(:empresa, :nuevo_articulo, NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
			USING trm;
			IF trm.SQLCode <> 0 THEN         
				MessageBox("SQL error", trm.SQLErrText +" Consulta Inserción Artículos 2: "+String(trm.SQLDBCode))
				return -1
			END IF
			
			INSERT INTO almartcajas 
				(empresa, articulo, caja, piezascaja, metroscaja, metroslcaja, pesocaja, metros_reales_caja, peso_real_caja, metros_reales, descripcion, codigo, pordefecto)
			VALUES
				(:empresa, :nuevo_articulo, '31', 999, 0, 0, 0, NULL, NULL, 0, NULL, NULL, 'S')
			USING trm;
			IF trm.SQLCode <> 0 THEN         
				MessageBox("SQL error", trm.SQLErrText +" Consulta Inserción Artículos 3: "+String(trm.SQLDBCode))
				return -1
			END IF
			
			INSERT INTO palarticulo 
				(empresa, articulo, codigo, caja, cajaspallet, planospallet, alturas, pordefecto)
			VALUES
				(:empresa, :nuevo_articulo, '31', '738', '999', '999', '999', 'S') //31 -> Palet Genérico, 738 Caja Genérica
			USING trm;
			IF trm.SQLCode <> 0 THEN         
				MessageBox("SQL error", trm.SQLErrText +" Consulta Inserción Artículos 4: "+String(trm.SQLDBCode))
				return -1
			END IF
			
			INSERT INTO almartcal 
				(empresa, articulo, calidad, precio, fecha_alta, stockmin, stockmax, puntopedido)
			VALUES 
				(:empresa, :nuevo_articulo, '1', NULL, GETDATE(), NULL, NULL, NULL)
			USING trm;
			IF trm.SQLCode <> 0 THEN         
				MessageBox("SQL error", trm.SQLErrText +" Consulta Inserción Artículos 5: "+String(trm.SQLDBCode))
				return -1
			END IF
			
		else
			articulo_actual  = nuevo_articulo
			nuevo_articulo = articulo_anterior
			factor = versiones.object.art_escandallo_factor[i]
		end if
		
		if j<> 1 then			
			//OPERACIONES 
			UPDATE art_ver_operaciones SET articulo = :articulo_actual, operacion = '1', orden = '1'
			WHERE empresa = :empresa AND articulo = :codigo AND version = :ruta AND operacion = :operacion  
			USING trm;
			IF trm.SQLCode <> 0 THEN         
				MessageBox("SQL error", trm.SQLErrText +" Consulta Inserción Artículos 6: "+String(trm.SQLDBCode))
				return -1
			END IF
			
			//APLICACIONES
			UPDATE art_ver_op_aplicaciones SET articulo = :articulo_actual, operacion = '1' 
			WHERE empresa = :empresa AND articulo = :codigo AND version = :ruta AND operacion = :operacion  
			USING trm;
			IF trm.SQLCode <> 0 THEN         
				MessageBox("SQL error", trm.SQLErrText +" Consulta Inserción Artículos 7: "+String(trm.SQLDBCode))
				return -1
			END IF
			
			//PLANIFICACION 
			UPDATE planificacion SET cod_articulo = :articulo_actual, ordenoperacion = '1' 
			WHERE empresa = :empresa AND cod_articulo = :codigo AND version = :ruta AND tipo_operacion = :tipo_operacion  
			USING trm;
			IF trm.SQLCode <> 0 THEN         
				MessageBox("SQL error", trm.SQLErrText +" Consulta Update Planificacion "+String(trm.SQLDBCode))
				return -1
			END IF
			
			//PARTES 
			UPDATE prodpartes_ot SET articulo = :articulo_actual, ordenoperacion = '1' 
			WHERE empresa = :empresa AND articulo = :codigo AND version = :ruta AND operacion = :tipo_operacion  
			USING trm;
			IF trm.SQLCode <> 0 THEN         
				MessageBox("SQL error", trm.SQLErrText +" Consulta Update  Partes "+String(trm.SQLDBCode))
				return -1
			END IF
			
		else
			//OPERACIONES 
			UPDATE art_ver_operaciones SET orden = '1'
			WHERE empresa = :empresa AND articulo = :codigo AND version = :ruta AND operacion = :operacion  
			USING trm;
			IF trm.SQLCode <> 0 THEN         
				MessageBox("SQL error", trm.SQLErrText +" Consulta Inserción Artículos 6: "+String(trm.SQLDBCode))
				return -1
			END IF
			
			//PLANIFICACION 
			UPDATE planificacion SET ordenoperacion = '1' 
			WHERE empresa = :empresa AND cod_articulo = :codigo AND version = :ruta AND ordenoperacion = :orden  
			USING trm;
			IF trm.SQLCode <> 0 THEN         
				MessageBox("SQL error", trm.SQLErrText +" Consulta Update Planificacion "+String(trm.SQLDBCode))
				return -1
			END IF
			
			//PARTES 
			UPDATE prodpartes_ot SET ordenoperacion = '1' 
			WHERE empresa = :empresa AND articulo = :codigo AND version = :ruta AND operacion = :tipo_operacion  
			USING trm;
			IF trm.SQLCode <> 0 THEN         
				MessageBox("SQL error", trm.SQLErrText +" Consulta Update  Partes "+String(trm.SQLDBCode))
				return -1
			END IF
		end if
			
		//Variar escandallo y versiones
		if j = 1 then  //Atención: La última operación conserva el código de artículo actual (j = numero_operaciones)
			UPDATE art_escandallo SET 
			articulo_ant = :nuevo_articulo, 
			factor = :factor
			WHERE empresa = :empresa AND articulo = :articulo AND version = :ruta AND articulo_ant = :articulo_anterior
			USING trm;
			if trm.SQLCode <> 0 THEN  
				MessageBox("SQL error", trm.SQLErrText +" UPDATE art_escandallo "+String(trm.SQLDBCode))
				return -1
			end if
			
			UPDATE art_versiones SET base = :nuevo_articulo 
			WHERE empresa = :empresa AND articulo = :articulo AND version = :ruta 
			USING trm;
			if trm.SQLCode <> 0 THEN  
				MessageBox("SQL error", trm.SQLErrText +" UPDATE art_versiones "+String(trm.SQLDBCode))
				return -1
			end if
		else
			INSERT INTO art_escandallo (empresa, articulo, version, articulo_ant, factor) 
			VALUES (:empresa, :articulo, :ruta, :nuevo_articulo, :factor) 
			USING trm;
			if trm.SQLCode <> 0 THEN  
				MessageBox("SQL error", trm.SQLErrText +" INSERT art_escandallo "+String(trm.SQLDBCode))
				return -1
			end if
			
			INSERT INTO art_versiones (empresa, articulo, version, base, descripcion, observaciones, tipo_version) 
			VALUES (:empresa, :articulo, :ruta, :nuevo_articulo, :descripcion_versiones, :observaciones_versiones, :tipo_version) 
			USING trm;
			if trm.SQLCode <> 0 THEN  
				MessageBox("SQL error", trm.SQLErrText +" INSERT art_escandallo "+String(trm.SQLDBCode))
				return -1
			end if
		end if
		
		nivel_actual ++
		
		j++
	loop	
	
	//Pasar al siguiente artículo de la esctructura
	resultado = fr_traspaso_nivel(empresa, articulo_anterior, trm, nivel_actual)
	
	if resultado <> 1 then
		return -1
	end if
	
	i++
loop
	
if resultado = 1 then
	if esta <= 0 then
		INSERT INTO articulos_traspasados (empresa, codigo) VALUES (:empresa, :codigo) USING trm;
		if trm.SQLCode <> 0 THEN  
			MessageBox("SQL error", trm.SQLErrText +" INSERT articulos_traspasados "+String(trm.SQLDBCode))
			return -1
		end if
	end if
end if

destroy versiones
destroy operaciones
return resultado
end function

on wtc_traspaso_multicodigo.create
if this.MenuName = "mi_menu_generico" then this.MenuID = create mi_menu_generico
this.dw_nivel=create dw_nivel
this.st_info=create st_info
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_articulos_fase2=create cb_articulos_fase2
this.pb_1=create pb_1
this.barra_1=create barra_1
this.cb_articulos_fase1=create cb_articulos_fase1
this.cb_1=create cb_1
this.p_logo=create p_logo
this.st_titulo=create st_titulo
this.Control[]={this.dw_nivel,&
this.st_info,&
this.cb_3,&
this.cb_2,&
this.cb_articulos_fase2,&
this.pb_1,&
this.barra_1,&
this.cb_articulos_fase1,&
this.cb_1,&
this.p_logo,&
this.st_titulo}
end on

on wtc_traspaso_multicodigo.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_nivel)
destroy(this.st_info)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_articulos_fase2)
destroy(this.pb_1)
destroy(this.barra_1)
destroy(this.cb_articulos_fase1)
destroy(this.cb_1)
destroy(this.p_logo)
destroy(this.st_titulo)
end on

event open;select nombre
into :st_titulo.text
from empresas
where empresa = :codigo_empresa;


parar = false
end event

event close;f_menu_cerrar_ventana(this,id_ventana_activa)
end event

event activate;id_ventana_activa = f_menu_insertar_ventana(this)

barra_1.SetStep = 1
barra_1.Position = 0

end event

type dw_nivel from datawindow within wtc_traspaso_multicodigo
boolean visible = false
integer x = 1751
integer y = 680
integer width = 686
integer height = 400
integer taborder = 30
string title = "none"
string dataobject = "dwtc_aux_traspaso_multicodigo_plani"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_info from statictext within wtc_traspaso_multicodigo
integer x = 59
integer y = 164
integer width = 1888
integer height = 148
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type cb_3 from commandbutton within wtc_traspaso_multicodigo
integer x = 59
integer y = 340
integer width = 1038
integer height = 104
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Creación de Artículos por Operación"
end type

event clicked;String sel, mensaje
Int numero, i, rtn, nivel, nivel_antiguo, operaciones, numero_articulos, pedido, linped, maximo_nivel
Dec ot
String codigo, articulo_actual, articulo_anterior, version_plani, base, articulo_nuevo
Datastore plani
transaction trm

rtn = 1

//Buscamos artículos no traspasados bloqueando solo el artículo afectado
SELECT COUNT(*) INTO :numero FROM articulos WHERE uso = '3'  AND codigo NOT IN(SELECT codigo FROM articulos_traspasados);

/*
//SOLO PRUEBAS
f_crear_transaccion(trm,"DESATENCER","",false,"RC","")
CONNECT USING trm;

sel =  "SELECT ot, pedido, linped, nivel, cod_articulo, version,  "+&
		"(SELECT COUNT(*) FROM planificacion p WHERE p.pedido = planificacion.pedido AND p.linped = planificacion.linped) as operaciones "+&
		"FROM planificacion "+&
		"ORDER BY pedido ASC, linped ASC, nivel DESC, cod_articulo ASC, ordenoperacion  ASC"
f_cargar_cursor_trans (trm,  sel, plani)	

*/
//REAL
//Obtenemos la planificación para actualizar el nivel tras el traspaso
sel = "SELECT ot, pedido, linped, nivel, cod_articulo, version, "+&
		"(SELECT COUNT(*) FROM planificacion p WHERE p.pedido = planificacion.pedido AND p.linped = planificacion.linped) as operaciones "+&
		"FROM planificacion ORDER BY pedido ASC, linped ASC, nivel DESC, cod_articulo ASC, ordenoperacion  ASC"
f_cargar_cursor_trans (SQLCA,  sel, plani)		

barra_1.setRange(0,numero)
barra_1.Position = 0
barra_1.setredraw(true)
i=1
st_info.text = "Inicio traspaso. Total a traspasar: "+String(numero)+" artículos"

//TRASPASO DE ARTICULOS
do while (rtn = 1 AND parar = false) 
	//f_crear_transaccion(trm,"","",false,"TS","")
	f_crear_transaccion(trm,"","",true,"RC","")
	CONNECT USING trm;
	
	//AND codigo IN ('2', '33021', '5646', '33830', '33733', '15470') 
	
	codigo = ""
	SELECT codigo INTO :codigo FROM articulos 
	WHERE  articulos.codigo NOT IN (SELECT codigo FROM articulos_traspasados)  
	AND articulos.uso = '3' 
	USING trm;
	
	//	ORDER BY CONVERT(integer,codigo) ASC 
	//	AND codigo IN ('47012')  
	//AND codigo IN ('50468')  
	//AND codigo IN ('2', '33021', '5646', '33830', '33733', '15470')  
	//AND codigo IN (SELECT TOP 50 codigo FROM articulos WHERE uso = '3' ORDER BY CONVERT(dec,codigo) DESC)
	
	//Artículos que no tienen encajado (Bases por ejemplo)
	if isnull(codigo) or codigo = "" then
		SELECT DISTINCT articulo INTO :codigo 
		FROM art_ver_operaciones 
		WHERE EXISTS 
			(SELECT * 
			FROM art_ver_operaciones o 
			WHERE o.articulo = art_ver_operaciones.articulo 
			GROUP BY o.articulo, o.version
			HAVING COUNT(o.articulo) > 1)
		AND  art_ver_operaciones.articulo NOT IN (SELECT codigo FROM articulos_traspasados)  
		USING trm;
	end if
	
	if not isnull(codigo) and codigo <> "" then
		
		traspaso_numero_nodos = 0
		rtn = fr_traspaso(codigo_empresa, codigo, trm)
		
		//RESULTADO
		IF rtn = 1 then
			st_info.text = "Artículo "+String(i)+" de "+String(numero)+" traspasado"
			barra_1.StepIt()
			i++	
			COMMIT USING trm;
		else
			ROLLBACK USING trm;
			mensaje = "Error en el traspaso. Artículo: "+ codigo
			MessageBox("Resultado de la operación",mensaje)			
			parar = true
		end if
	else
		parar = true
	end if
	
	DISCONNECT USING trm;
loop	

//PLANI
numero_articulos = plani.RowCount()
i = 1
pedido = -1
linped = -1
nivel = 1
do while (i <= numero_articulos AND rtn = 1) 
	ot = plani.object.ot[i]
	nivel_antiguo = plani.object.nivel[i]
	//operaciones = plani.object.operaciones[i]
	articulo_actual = plani.object.cod_articulo[i]
	articulo_nuevo = ""
	
	SELECT cod_articulo INTO :articulo_nuevo FROM planificacion WHERE empresa = :codigo_empresa AND ot = :ot USING SQLCA; 
	
	maximo_nivel = plani.object.operaciones[i]
	version_plani = plani.object.version[i]
	
	base = ""
	SELECT articulo_ant INTO :base FROM art_escandallo 
	WHERE empresa = :codigo_empresa AND articulo = :articulo_nuevo 
	ORDER BY CONVERT(integer, articulo_ant) ASC USING SQLCA;
	
	if (pedido <> plani.object.pedido[i] or linped <> plani.object.linped[i]) then
		pedido = plani.object.pedido[i]
		linped = plani.object.linped[i]
		
		nivel = maximo_nivel
	end if
	
	UPDATE planificacion SET nivel = :nivel, base = :base WHERE empresa = :codigo_empresa AND ot = :ot USING SQLCA;
	
	articulo_anterior = articulo_actual
	
	nivel --
	i++
loop

Destroy plani
Destroy trm
parar = false

end event

type cb_2 from commandbutton within wtc_traspaso_multicodigo
integer x = 2002
integer y = 164
integer width = 343
integer height = 104
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Parar"
end type

event clicked;parar = true
end event

type cb_articulos_fase2 from commandbutton within wtc_traspaso_multicodigo
boolean visible = false
integer x = 1367
integer y = 1140
integer width = 1202
integer height = 104
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Traspaso Artículos - Agrupación HORN / ENC"
end type

event clicked;String sel, mensaje
Int numero, i, rtn
Datastore origen
transaction trm
rtn = 1

f_crear_transaccion(trm,"","",false,"RC","")
CONNECT USING trm;


//TRASPASO DE OPERACIONES (Saltar articulos que son operación)
sel = "SELECT * FROM articulos"
f_cargar_cursor_trans (trm,  sel,  origen)
numero = origen.RowCount()

rtn = 1
i = 1
barra_1.setRange(0,numero)
barra_1.Position = 0
Parent.setredraw(true)
barra_1.setredraw(true)
do while (i <= numero AND rtn = 1) 
	barra_1.StepIt()
	
	String empresa, codigo, descripcion, familia, subfamilia, formato, subformato, modelo, unidad, cuenta, proveedor, decorado, sector, cuenta_contable
	String tono, calibre, compras, activo, unidad_est, prev_anular, empleado, molde, plato_sup, plato_inf, calibre_min, calibre_max, cliente, uso, estilo
	String coleccion, color, imagen, referencia_laboratorio, tipo_pasta, codigo_pantallas, ean13, ventasitalia, usuario, obs_ficha_hornos, tipo, partidaest
	String control_stock, ubi_muestras, codigo_compras, estandar, bloqueado, cod_cliente, marco, canto_vivo, marcado, etiqueta_ce, observaciones
	Int conjunto, version_laboratorio, lote
	Decimal ancho, largo, precio_coste, pesopieza, piezascaja, pesocaja, pesoenvase, metroscaja, metroslcaja, espesor, ciclo, temp_inferior, temp_superior
	Decimal temp_inferior1, temp_superior1, stock_min, stocksugerido
	Datetime fecha_alta, fecha_anulado, fecha_fin, fecha_primera_produccion, fechastocksugerido
	
	
	empresa = origen.object.empresa[i]
	codigo = origen.object.codigo[i]
	descripcion = origen.object.descripcion[i]
	familia = origen.object.familia[i]
	subfamilia = origen.object.subfamilia[i]
	formato = origen.object.formato[i]
	ancho = origen.object.ancho[i]
	largo = origen.object.largo[i]
	subformato = origen.object.subformato[i]
	modelo = origen.object.modelo[i]
	unidad = origen.object.unidad[i]
	precio_coste = origen.object.precio_coste[i]
	fecha_alta = origen.object.fecha_alta[i]
	fecha_anulado = origen.object.fecha_anulado[i]
	fecha_fin = origen.object.fecha_fin[i]
	cuenta = origen.object.cuenta[i]
	proveedor = origen.object.proveedor[i]
	decorado = origen.object.decorado[i]
	sector = origen.object.sector[i]
	conjunto = origen.object.conjunto[i]
	pesopieza = origen.object.pesopieza[i]
	piezascaja = origen.object.piezascaja[i]
	pesocaja = origen.object.pesocaja[i]
	pesoenvase = origen.object.pesoenvase[i]
	metroscaja = origen.object.metroscaja[i]
	metroslcaja = origen.object.metroslcaja[i]
	cuenta_contable = origen.object.cuenta_contable[i]
	tono = origen.object.tono[i]
	calibre = origen.object.calibre[i]
	compras = origen.object.compras[i]
	activo = origen.object.activo[i]
	unidad_est = origen.object.unidad_est[i]
	prev_anular = origen.object.prev_anular[i]
	empleado = origen.object.empleado[i]
	molde = origen.object.molde[i]
	plato_sup = origen.object.plato_sup[i]
	plato_inf = origen.object.plato_inf[i]
	calibre_min = origen.object.calibre_min[i]
	calibre_max = origen.object.calibre_max[i]
	cliente = origen.object.cliente[i]
	uso = origen.object.uso[i]
	estilo = origen.object.estilo[i]
	coleccion = origen.object.coleccion[i]
	color = origen.object.color[i]
	imagen = origen.object.imagen[i]
	referencia_laboratorio = origen.object.referencia_laboratorio[i]
	version_laboratorio = origen.object.version_laboratorio[i]
	fecha_primera_produccion = origen.object.fecha_primera_produccion[i]
	tipo_pasta = origen.object.tipo_pasta[i]
	codigo_pantallas = origen.object.codigo_pantallas[i]
	espesor = origen.object.espesor[i]
	ciclo = origen.object.ciclo[i]
	temp_inferior = origen.object.temp_inferior[i]
	temp_superior = origen.object.temp_superior[i]
	ean13 = origen.object.ean13[i]
	ventasitalia = origen.object.ventasitalia[i]
	usuario = origen.object.usuario[i]
	temp_inferior1 = origen.object.temp_inferior1[i]
	temp_superior1 = origen.object.temp_superior1[i]
	obs_ficha_hornos = origen.object.obs_ficha_hornos[i]
	tipo = origen.object.tipo[i]
	partidaest = origen.object.partidaest[i]
	control_stock = origen.object.control_stock[i]
	stock_min = origen.object.stock_min[i]
	ubi_muestras = origen.object.ubi_muestras[i]
	stocksugerido = origen.object.stocksugerido[i]
	fechastocksugerido = origen.object.fechastocksugerido[i]
	
	
	codigo_compras = origen.object.codigo_compras[i]
	estandar = origen.object.estandar[i]
	bloqueado = origen.object.bloqueado[i]
	cod_cliente = origen.object.cod_cliente[i]
	marco = origen.object.marco[i]
	canto_vivo = origen.object.canto_vivo[i]
	marcado = origen.object.marcado[i]
	etiqueta_ce = origen.object.etiqueta_ce[i]
	lote = origen.object.lote[i]
	observaciones = origen.object.observaciones[i]
	
	i++
loop

origen.reset()

//RESULTADO
IF rtn = 1 then
	COMMIT USING trm;
	mensaje = "Se han traspasado las operaciones y aplicaciones con éxito"
	cb_articulos_fase1.enabled = true
	cb_articulos_fase2.enabled = false
else
	ROLLBACK USING trm;
	mensaje = "Error en el traspaso"
end if
DISCONNECT USING trm;

Destroy origen
Destroy trm

MessageBox("Resultado de la operación",mensaje)
end event

type pb_1 from picturebutton within wtc_traspaso_multicodigo
integer x = 2409
integer y = 156
integer width = 146
integer height = 128
integer taborder = 10
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "C:\Tencer_PB12\Log Out_24x24Gris.png"
alignment htextalign = left!
end type

event clicked;Close(Parent)
end event

type barra_1 from hprogressbar within wtc_traspaso_multicodigo
integer x = 55
integer y = 528
integer width = 2505
integer height = 68
unsignedinteger maxposition = 100
unsignedinteger position = 50
integer setstep = 10
end type

type cb_articulos_fase1 from commandbutton within wtc_traspaso_multicodigo
boolean visible = false
integer x = 64
integer y = 1140
integer width = 1239
integer height = 104
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Traspaso Artículos - Separación Operaciones"
end type

event clicked;String sel, mensaje
Int numero, i, rtn
Datastore origen
transaction trm

String empresa, codigo

rtn = 1

//BORRADO INICIAL
DELETE FROM articulos WHERE CONVERT(integer,codigo) >= 200000;
DELETE FROM art_ver_op_aplicaciones WHERE tipoaplicacion = '19' AND articulo IN (SELECT codigo FROM articulos WHERE uso = '2' AND codigo <> '31839');
DELETE FROM art_codestadistico WHERE CONVERT(integer,codigo) >= 200000;
DELETE FROM almartcajas WHERE CONVERT(integer,articulo) >= 200000;
DELETE FROM palarticulo WHERE CONVERT(integer,articulo) >= 200000;
DELETE FROM almartcal WHERE CONVERT(integer,articulo) >= 200000;
DELETE FROM articulos_traspasados;
DELETE FROM articulos_temporal;
DELETE FROM ruta_fabricacion;
DELETE FROM aplicacion;

//f_crear_transaccion(trm,"","",false,"TS","")
f_crear_transaccion(trm,"","",true,"RC","")
CONNECT USING trm;

DELETE FROM ruta_fabricacion USING trm;
IF trm.SQLCode <> 0 THEN         
	MessageBox("SQL error", trm.SQLErrText)
	rtn = -1
END IF

DELETE FROM aplicacion USING trm;
IF trm.SQLCode <> 0 THEN         
	MessageBox("SQL error", trm.SQLErrText)
	rtn = -1
END IF

//TRASPASO DE ARTICULOS

//Obtención de la ruta a partir del encajado
if rtn = 1 then
	sel = "SELECT empresa, codigo FROM articulos WHERE uso = '3' AND codigo IN ('2','33021','4990','33113','14680','5646','1213','4343','33830') ORDER BY CONVERT(integer,codigo) ASC" //'1213','2','5646','33021','4990','33113',
	f_cargar_cursor_trans (trm,  sel,  origen)
	numero = origen.RowCount()
	barra_1.setRange(0,numero)
	barra_1.Position = 0
	barra_1.setredraw(true)
end if

i=1
do while (i <= numero AND rtn = 1 AND parar = false) 
	barra_1.StepIt()
	empresa = origen.object.empresa[i]
	codigo = origen.object.codigo[i]
	
	rtn = fr_traspaso_escandallo(empresa, codigo, trm)
	i++
loop

//RESULTADO
IF rtn = 1 then
	COMMIT USING trm;
	mensaje = "Se han traspasado las operaciones y aplicaciones con éxito"
	//cb_articulos_fase2.enabled = true
	//cb_articulos_fase1.enabled = false
else
	ROLLBACK USING trm;
	mensaje = "Error en el traspaso"
end if
DISCONNECT USING trm;

Destroy origen
Destroy trm
parar = false
MessageBox("Resultado de la operación",mensaje)
end event

type cb_1 from commandbutton within wtc_traspaso_multicodigo
boolean visible = false
integer x = 64
integer y = 972
integer width = 1038
integer height = 104
integer taborder = 10
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Traspaso Operaciones y Aplicaciones"
end type

event clicked;String sel, empresa, codigo, abreviado, descripcion, mensaje, tipooperacion, tipoaplicacion
Int numero, numero2, i, j, rtn
Datastore origen
transaction trm
str_traspaso_operaciones relacion[16]
rtn = 1

f_crear_transaccion(trm,"","",false,"RC","")
CONNECT USING trm;

DELETE FROM tipooperacion USING trm;
IF trm.SQLCode <> 0 THEN         
	MessageBox("SQL error", trm.SQLErrText)
	rtn = -1
END IF
if rtn = 1 then
	DELETE FROM tipoaplicacion USING trm;
	IF trm.SQLCode <> 0 THEN         
		MessageBox("SQL error", trm.SQLErrText)
		rtn = -1
	END IF
end if
if rtn = 1 then
	DELETE FROM tipooperacion_tipoaplicacion USING trm;
	IF trm.SQLCode <> 0 THEN         
		MessageBox("SQL error", trm.SQLErrText)
		rtn = -1
	END IF
end if
if rtn = 1 then
	DELETE FROM ruta_descripcion USING trm;
	IF trm.SQLCode <> 0 THEN         
		MessageBox("SQL error", trm.SQLErrText)
		rtn = -1
	END IF
end if
if rtn = 1 then
	DELETE FROM tipooperacion_ruta_descripcion USING trm;
	IF trm.SQLCode <> 0 THEN         
		MessageBox("SQL error", trm.SQLErrText)
		rtn = -1
	END IF
end if

//TRASPASO DE OPERACIONES (Saltar articulos que son operación)
sel = "SELECT empresa, codigo, descripcion, descripcion_abr FROM art_ver_tipooperacion WHERE codigo NOT IN ('9','12','16','25','29','31','33')"
f_cargar_cursor_trans (trm,  sel,  origen)
numero = origen.RowCount()

rtn = 1
i = 1
do while (i <= numero AND rtn = 1) 
	
	empresa = origen.object.empresa[i]
	codigo = origen.object.codigo[i]
	abreviado = origen.object.descripcion_abr[i]
	descripcion = origen.object.descripcion[i]
	
	//CREACIÓN DE LAS APLICACIONES DERIVADAS DE ANTIGUAS OPERACIONES O DE LAS NUEVAS OPERACIONES
	if codigo = '20' then
		INSERT INTO tipoaplicacion (empresa, codigo, abreviado, descripcion) values (:empresa, '56', 'CERA', 'QUEMAR CERA') USING trm; //QUEMAR CERA
		//INSERT INTO tipoaplicacion (empresa, codigo, abreviado, descripcion) values (:empresa, '57', 'CERA_BAJA', 'QUEMAR CERA - BAJA') USING trm; //QUEMAR CERA
	else
		INSERT INTO tipooperacion (empresa, codigo, abreviado, descripcion) values (:empresa, :codigo, :abreviado, :descripcion) USING trm;
	end if
	IF trm.SQLCode <> 0 THEN         
		MessageBox("SQL error", trm.SQLErrText)
		rtn = -1
	END IF
	i++
loop

origen.reset()

//CREACIÓN DE OPERACIONES NUEVAS
if rtn = 1 then
	INSERT INTO tipooperacion (empresa, codigo, abreviado, descripcion) values ('1', '6', 'CORTING', 'CORTE INGLETE') USING trm;
	IF trm.SQLCode <> 0 THEN         
		MessageBox("SQL error", trm.SQLErrText)
		rtn = -1
	END IF
end if
if rtn = 1 then
	INSERT INTO tipooperacion (empresa, codigo, abreviado, descripcion) values ('1', '8', 'SUB', 'SUBCONTRATACIÓN') USING trm;
	IF trm.SQLCode <> 0 THEN         
		MessageBox("SQL error", trm.SQLErrText)
		rtn = -1
	END IF
end if
/*
if rtn = 1 then
	INSERT INTO tipooperacion (empresa, codigo, abreviado, descripcion) values ('1', '11', 'BASE', 'CREAR BASE') USING trm;
	IF trm.SQLCode <> 0 THEN         
		MessageBox("SQL error", trm.SQLErrText)
		rtn = -1
	END IF
end if
*/
if rtn = 1 then
	INSERT INTO tipooperacion (empresa, codigo, abreviado, descripcion) values ('1', '10', 'VENTA', 'ENCAJADO VENTAS') USING trm;
	IF trm.SQLCode <> 0 THEN         
		MessageBox("SQL error", trm.SQLErrText)
		rtn = -1
	END IF
end if

//CREACIÓN DE APLICACIONES
if rtn = 1 then
	sel = "SELECT empresa, codigo, descripcion, resumido FROM prodaplicaciones"
	f_cargar_cursor_trans (trm,  sel,  origen)
	numero = origen.RowCount()
end if

i = 1
do while (i <= numero AND rtn = 1) 
	
	empresa = origen.object.empresa[i]
	codigo = origen.object.codigo[i]
	abreviado = origen.object.resumido[i]
	descripcion = origen.object.descripcion[i]
	
	INSERT INTO tipoaplicacion (empresa, codigo, abreviado, descripcion) values (:empresa, :codigo, :abreviado, :descripcion) USING trm;
	
	IF trm.SQLCode <> 0 THEN         
		MessageBox("SQL error", trm.SQLErrText)
		rtn = -1
	END IF
	i++
loop

origen.reset()

//CREACIÓN DE APLICACIONES NUEVAS
/*
//Se deja como está la aplicación generica Pintado a Mano 
if rtn = 1 then
	INSERT INTO tipoaplicacion (empresa, codigo, abreviado, descripcion) values ('1', '7', 'ESPON', 'ESPONJADO') USING trm;
	IF trm.SQLCode <> 0 THEN         
		MessageBox("SQL error", trm.SQLErrText)
		rtn = -1
	END IF
end if
if rtn = 1 then
	INSERT INTO tipoaplicacion (empresa, codigo, abreviado, descripcion) values ('1', '8', 'PINCEL', 'PINCELADO') USING trm;
	IF trm.SQLCode <> 0 THEN         
		MessageBox("SQL error", trm.SQLErrText)
		rtn = -1
	END IF
end if
*/
if rtn = 1 then
	INSERT INTO tipoaplicacion (empresa, codigo, abreviado, descripcion) values ('1', '20', 'ENCF', 'ENCAJADO EN FRIO') USING trm;
	IF trm.SQLCode <> 0 THEN         
		MessageBox("SQL error", trm.SQLErrText)
		rtn = -1
	END IF
end if

//CREACIÓN DE VINCULACIONES ENTRE OPERACIONES Y APLICACIONES
relacion[1].operacion = '1'
relacion[1].aplicaciones = {'1','2','24'}

relacion[2].operacion = '2'
relacion[2].aplicaciones = {'4','5','26'}

relacion[3].operacion = '3'
relacion[3].aplicaciones = {'6','19','25','41','42','56','44','49'}

relacion[4].operacion = '5'
relacion[4].aplicaciones = {'19','21','25','38','45','46','49'}

relacion[5].operacion = '7'
relacion[5].aplicaciones = {'1','2','10','11','24'}

relacion[6].operacion = '15'
relacion[6].aplicaciones = {'4','5','26'}

relacion[7].operacion = '23'
relacion[7].aplicaciones = {'36'}

relacion[8].operacion = '24'
relacion[8].aplicaciones = {'4','5','26'}

relacion[9].operacion = '27'
relacion[9].aplicaciones = {'20'}

relacion[10].operacion = '28'
relacion[10].aplicaciones = {'18'}

relacion[11].operacion = '30'
relacion[11].aplicaciones = {'2','4','26','51'}

relacion[12].operacion = '32'
relacion[12].aplicaciones = {'52'}

relacion[13].operacion = '34'
relacion[13].aplicaciones = {'55'}

relacion[14].operacion = '6'
relacion[14].aplicaciones = {'19','21','25','38','45','46','49'}

relacion[15].operacion = '21'
relacion[15].aplicaciones = {'31'}

relacion[16].operacion = '26'
relacion[16].aplicaciones = {'29','30','46'}


i = 1
numero = 16
do while (i <= numero AND rtn = 1) 
	
	empresa = '1'
	tipooperacion = relacion[i].operacion
	
	numero2 = upperbound(relacion[i].aplicaciones)
	j = 1
	do while (j <= numero2 AND rtn = 1) 
		tipoaplicacion = relacion[i].aplicaciones[j]
	
		INSERT INTO tipooperacion_tipoaplicacion (empresa, tipooperacion, tipoaplicacion) values (:empresa, :tipooperacion, :tipoaplicacion) USING trm;
	
		IF trm.SQLCode <> 0 THEN         
			MessageBox("SQL error", trm.SQLErrText)
			rtn = -1
		END IF
		j++
	loop
	i++
loop

origen.reset()

//Inserción de todas las aplicaciones en la operación de subcontratación
if rtn = 1 then
	sel = "SELECT codigo FROM tipoaplicacion"
	f_cargar_cursor_trans (trm,  sel,  origen)
	numero = origen.RowCount()
else 
	numero = 0
end if

i = 1
do while (i <= numero AND rtn = 1) 
	
	tipoaplicacion = origen.object.codigo[i]
	
	INSERT INTO tipooperacion_tipoaplicacion (empresa, tipooperacion, tipoaplicacion) values ('1', '8', :tipoaplicacion) USING trm;
	
	IF trm.SQLCode <> 0 THEN         
		MessageBox("SQL error", trm.SQLErrText)
		rtn = -1
	END IF
	i++
loop
origen.reset()

//Fin subcontratación

//Inserción de las descripciones de rutas
INSERT INTO ruta_descripcion (empresa, codigo, descripcion) VALUES ('1','1','ÚNICA') USING trm;
INSERT INTO ruta_descripcion (empresa, codigo, descripcion) VALUES ('1','2','SUBCONTRATACIÓN') USING trm;
INSERT INTO ruta_descripcion (empresa, codigo, descripcion) VALUES ('1','3','SERIGRAFÍA') USING trm;
INSERT INTO ruta_descripcion (empresa, codigo, descripcion) VALUES ('1','4','SERIGRAFÍA ALTA') USING trm;
INSERT INTO ruta_descripcion (empresa, codigo, descripcion) VALUES ('1','5','SERIGRAFÍA BAJA') USING trm;
INSERT INTO ruta_descripcion (empresa, codigo, descripcion) VALUES ('1','6','CORTE') USING trm;
INSERT INTO ruta_descripcion (empresa, codigo, descripcion) VALUES ('1','7','CORTE INGLETE') USING trm;
INSERT INTO ruta_descripcion (empresa, codigo, descripcion) VALUES ('1','8','CORTE MONTAJE') USING trm;
INSERT INTO ruta_descripcion (empresa, codigo, descripcion) VALUES ('1','9','CORTE INGLETE MONTAJE') USING trm;
INSERT INTO ruta_descripcion (empresa, codigo, descripcion) VALUES ('1','10','IMPRESIÓN DIGITAL') USING trm;
INSERT INTO ruta_descripcion (empresa, codigo, descripcion) VALUES ('1','11','MONOCOCCIÓN') USING trm;
INSERT INTO ruta_descripcion (empresa, codigo, descripcion) VALUES ('1','12','BICOCCIÓN') USING trm;

//Inserción de las descripciones de rutas por operación
if rtn = 1 then
	sel = "SELECT codigo FROM tipooperacion"
	f_cargar_cursor_trans (trm,  sel,  origen)
	numero = origen.RowCount()
else 
	numero = 0
end if

i = 1
do while (i <= numero AND rtn = 1) 
	
	tipooperacion = origen.object.codigo[i]
	
	INSERT INTO tipooperacion_ruta_descripcion (empresa, tipooperacion, ruta_descripcion) values ('1', :tipooperacion, '1') USING trm;
	INSERT INTO tipooperacion_ruta_descripcion (empresa, tipooperacion, ruta_descripcion) values ('1', :tipooperacion, '2') USING trm;
	
	if tipooperacion = "2" OR tipooperacion = "15" OR tipooperacion = "24" then //Serigrafía
		INSERT INTO tipooperacion_ruta_descripcion (empresa, tipooperacion, ruta_descripcion) values ('1', :tipooperacion, '3') USING trm;
		INSERT INTO tipooperacion_ruta_descripcion (empresa, tipooperacion, ruta_descripcion) values ('1', :tipooperacion, '4') USING trm;
		INSERT INTO tipooperacion_ruta_descripcion (empresa, tipooperacion, ruta_descripcion) values ('1', :tipooperacion, '5') USING trm;
	elseif tipooperacion = "5" then //Corte
		INSERT INTO tipooperacion_ruta_descripcion (empresa, tipooperacion, ruta_descripcion) values ('1', :tipooperacion, '6') USING trm;
		INSERT INTO tipooperacion_ruta_descripcion (empresa, tipooperacion, ruta_descripcion) values ('1', :tipooperacion, '8') USING trm;
	elseif tipooperacion = "6" then //Corte inglete
		INSERT INTO tipooperacion_ruta_descripcion (empresa, tipooperacion, ruta_descripcion) values ('1', :tipooperacion, '7') USING trm;
		INSERT INTO tipooperacion_ruta_descripcion (empresa, tipooperacion, ruta_descripcion) values ('1', :tipooperacion, '9') USING trm;
	elseif tipooperacion = "30" then //Inkcid
		INSERT INTO tipooperacion_ruta_descripcion (empresa, tipooperacion, ruta_descripcion) values ('1', :tipooperacion, '10') USING trm;
	elseif tipooperacion = "1" then //Mono
		INSERT INTO tipooperacion_ruta_descripcion (empresa, tipooperacion, ruta_descripcion) values ('1', :tipooperacion, '11') USING trm;
	elseif tipooperacion = "7" then //Bico
		INSERT INTO tipooperacion_ruta_descripcion (empresa, tipooperacion, ruta_descripcion) values ('1', :tipooperacion, '12') USING trm;
	end if
	
	IF trm.SQLCode <> 0 THEN         
		MessageBox("SQL error", trm.SQLErrText)
		rtn = -1
	END IF
	i++
loop
origen.reset()
//Fin inserción de rutas

//RESULTADO
IF rtn = 1 then
	COMMIT USING trm;
	mensaje = "Se han traspasado las operaciones y aplicaciones con éxito"
else
	ROLLBACK USING trm;
	mensaje = "Error en el traspaso"
end if
DISCONNECT USING trm;

Destroy origen
Destroy trm

MessageBox("Resultado de la operación",mensaje)
end event

type p_logo from picture within wtc_traspaso_multicodigo
integer x = 2039
integer y = 20
integer width = 517
integer height = 96
string picturename = "C:\Tencer_PB12\tencer24.jpg"
boolean focusrectangle = false
end type

type st_titulo from statictext within wtc_traspaso_multicodigo
integer x = 37
integer y = 32
integer width = 1710
integer height = 68
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

