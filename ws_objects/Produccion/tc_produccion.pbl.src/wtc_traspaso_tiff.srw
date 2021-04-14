$PBExportHeader$wtc_traspaso_tiff.srw
forward
global type wtc_traspaso_tiff from window
end type
type st_info from statictext within wtc_traspaso_tiff
end type
type pb_1 from picturebutton within wtc_traspaso_tiff
end type
type barra_1 from hprogressbar within wtc_traspaso_tiff
end type
type cb_1 from commandbutton within wtc_traspaso_tiff
end type
type p_logo from picture within wtc_traspaso_tiff
end type
type st_titulo from statictext within wtc_traspaso_tiff
end type
end forward

global type wtc_traspaso_tiff from window
integer width = 2619
integer height = 620
boolean titlebar = true
string title = "Traspaso de TIFFs"
string menuname = "mi_menu_generico"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_info st_info
pb_1 pb_1
barra_1 barra_1
cb_1 cb_1
p_logo p_logo
st_titulo st_titulo
end type
global wtc_traspaso_tiff wtc_traspaso_tiff

type variables
Long id_ventana_activa
Boolean parar
end variables

forward prototypes
public function integer fr_traspaso_escandallo (string empresa, string codigo, transaction trm)
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

on wtc_traspaso_tiff.create
if this.MenuName = "mi_menu_generico" then this.MenuID = create mi_menu_generico
this.st_info=create st_info
this.pb_1=create pb_1
this.barra_1=create barra_1
this.cb_1=create cb_1
this.p_logo=create p_logo
this.st_titulo=create st_titulo
this.Control[]={this.st_info,&
this.pb_1,&
this.barra_1,&
this.cb_1,&
this.p_logo,&
this.st_titulo}
end on

on wtc_traspaso_tiff.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_info)
destroy(this.pb_1)
destroy(this.barra_1)
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

type st_info from statictext within wtc_traspaso_tiff
integer x = 1207
integer y = 176
integer width = 1134
integer height = 64
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

type pb_1 from picturebutton within wtc_traspaso_tiff
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

type barra_1 from hprogressbar within wtc_traspaso_tiff
integer x = 37
integer y = 328
integer width = 2519
integer height = 68
unsignedinteger maxposition = 100
unsignedinteger position = 50
integer setstep = 10
end type

type cb_1 from commandbutton within wtc_traspaso_tiff
integer x = 37
integer y = 160
integer width = 1038
integer height = 104
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Iniciar Traspaso"
end type

event clicked;//Sustitución Unidades Materias Primas Fórmulas TIFF - De gramos a litros para aplicar la densidad al coste (como funciona por proporciona litros funciona, sin ser necesario ml que no existe)
String sel, formula, empresa, articulo, version_f, operacion, contadoraplicacion, unidad
Int i, j, numero, numero2, rtn
Dec metros2_pieza, gramaje, gramaje_nuevo, cantidad_densidad, cantidad
Datastore formulas, componentes
Boolean actualizar

rtn = 1

sel = "SELECT formula, empresa, articulo, version, operacion, contadoraplicacion, gramaje FROM art_ver_op_aplicaciones WHERE formula IS NOT NULL AND tipoaplicacion = '51'"
f_cargar_cursor_trans (SQLCA,  sel,  formulas)
numero = formulas.RowCount()
barra_1.setRange(0,numero)
i = 1
do while (i <= numero AND rtn = 1) 
	formula = formulas.object.formula[i]
	empresa = formulas.object.empresa[i]
	articulo = formulas.object.articulo[i]
	version_f = formulas.object.version[i]
	operacion = formulas.object.operacion[i]
	contadoraplicacion = formulas.object.contadoraplicacion[i]
	gramaje = formulas.object.gramaje[i]
	
	SELECT (formatos.largo * formatos.ancho /10000) INTO :metros2_pieza 
   FROM art_ver_operaciones 
   LEFT OUTER JOIN formatos ON art_ver_operaciones.empresa = formatos.empresa AND art_ver_operaciones.formato = formatos.codigo
   WHERE ( art_ver_operaciones.empresa = :empresa ) AND  
         ( art_ver_operaciones.articulo = :articulo ) AND  
         ( art_ver_operaciones.version = :version_f ); 
			
			
	sel = "SELECT cantidad, cantidad_u_m_mp, unidad_u_m_mp, densidad "+&
    		"FROM proddetformula,   "+&
         "prodformula,   "+&
         "venmprima   "+&
   		"WHERE ( proddetformula.empresa = prodformula.empresa ) and  "+&
         "( proddetformula.formulacion = prodformula.formula ) and  "+&
         "( prodformula.empresa = venmprima.empresa ) and  "+&
         "( proddetformula.mp = venmprima.codigo ) and  "+&
         "( ( proddetformula.empresa = '"+empresa+"'  ) AND  "+&
         "(  proddetformula.formulacion = '"+formula+"'  ) )  "
	f_cargar_cursor_trans (SQLCA,  sel,  componentes)
	
	j = 1
	actualizar = false
	cantidad_densidad = 0
	numero2 = componentes.RowCount()
	do while (j <= numero2 AND rtn = 1) 
		cantidad = componentes.object.proddetformula_cantidad_u_m_mp[j]
		unidad = componentes.object.proddetformula_unidad_u_m_mp[j]
		
		if not isnull(cantidad) and cantidad_densidad <> -1 then
			cantidad_densidad = cantidad_densidad + (componentes.object.proddetformula_cantidad_u_m_mp[j] * componentes.object.venmprima_densidad[j])
		else
			cantidad_densidad = -1
		end if
		
		if unidad <> '2' then
			actualizar = true
		end if
		
		j++
	loop
	
	if isnull(metros2_pieza) or metros2_pieza = 0 then
		MessageBox("Error","El articulo "+articulo+" no tiene formato")
	else
		if cantidad_densidad > 0 and (isnull(gramaje) or gramaje = 0) then
			actualizar = true
			gramaje_nuevo = cantidad_densidad * metros2_pieza
			UPDATE art_ver_op_aplicaciones SET gramaje = :gramaje_nuevo WHERE empresa = :empresa AND articulo = :articulo AND version = :version_f AND operacion = :operacion AND contadoraplicacion = :contadoraplicacion;
		end if
	end if
	
	if actualizar = true then
		UPDATE proddetformula SET unidad_u_m_mp = '2' WHERE formulacion = :formula;
		f_recalculo_coste_mp_operacion(formula)
	end if
	
	
	
	barra_1.StepIt()
	i++
loop

Destroy formulas

/*
Traspaso ya realizado

String sel, sel2, empresa, articulo, version_op, operacion, mensaje, contadoraplicacion, formula, desc_formula, tiff, formula_nueva, esta, tipoaplicacion
String formula_estandar, formula_unidad, mprima, desc_unidad, proveedor
Int numero, numero2, i, j, rtn, cont_traspasado, cont_no_traspasado, cont_ya_traspasado
Datetime ahora
Datastore aplicaciones, mprimas
transaction trm

str_colisiones param_colisiones

f_crear_transaccion(trm,"","",false,"TS","")
CONNECT USING trm;

barra_1.Position = 0
barra_1.setredraw(true)

//Obtenemos todos los TIFF de las aplicaciones y los convertimos a Formula

sel = "SELECT empresa, articulo, version, operacion, contadoraplicacion, formula, tiff, tipoaplicacion FROM art_ver_op_aplicaciones WHERE tiff IS NOT NULL AND tiff <> '' ORDER BY CONVERT(integer, articulo) ASC"
f_cargar_cursor_trans (trm,  sel,  aplicaciones)
numero = aplicaciones.RowCount()

rtn = 1
i = 1
cont_traspasado = 0
cont_no_traspasado = 0
cont_ya_traspasado = 0
ahora = datetime(today(),now())
barra_1.setRange(0,numero)
do while (i <= numero AND rtn = 1) 
	
	empresa = aplicaciones.object.empresa[i]
	articulo = aplicaciones.object.articulo[i]
	version_op = aplicaciones.object.version[i]
	operacion = aplicaciones.object.operacion[i]
	contadoraplicacion = aplicaciones.object.contadoraplicacion[i]
	formula = trim(aplicaciones.object.formula[i])
	desc_formula = ""
	SELECT descripcion_laboratorio INTO :desc_formula FROM prodformula WHERE empresa = :empresa AND formula = :formula USING trm;
	tiff = upper(trim(aplicaciones.object.tiff[i]))
	tipoaplicacion = aplicaciones.object.tipoaplicacion[i]
	st_info.text = "TIFF Artículo "+articulo
	if isnull(formula) or formula = "" or (pos(desc_formula,"T") <> 0 and desc_formula <> ("T"+tiff)) then
		esta = ""
		SELECT formula INTO :esta FROM prodformula WHERE descripcion_laboratorio = :tiff USING trm;
		if isnull(esta) or esta = "" then
			//HAY QUE CREAR LA FORMULA DEL TIFF, ANTES DE AÑADIRLA AL CAMPO FORMULA DE LA APLICACIÓN
			param_colisiones.empresa = empresa
			param_colisiones.tabla = "prodformula"
			param_colisiones.campo = "formula"
			param_colisiones.filtro = ""
			param_colisiones.buscar_huecos = false
			formula_nueva = String(f_colisiones(trm, param_colisiones))
			
			SELECT formula_estandar, formula_unidad INTO :formula_estandar, :formula_unidad FROM prodaplicaciones WHERE empresa = :empresa AND codigo = :tipoaplicacion USING trm;
			if formula_estandar = '0' then
				cont_no_traspasado++;
				MessageBox("Error", "Para realizar el traspaso, la formula estandar debe estar activada en todas las aplicaciones con TIFF. Error encontrado en el artículo "+articulo+", aplicacion "+tipoaplicacion)
				barra_1.StepIt()
				i++
				continue;
			end if
			
			SELECT abreviado INTO :desc_unidad FROM comunimedida WHERE codigo = :formula_unidad USING trm;
			desc_unidad = lower(desc_unidad)
			if pos(tiff,"T") = 0 then
				tiff = "T"+tiff
			else
				//Debug	
				tiff = tiff
			end if
			
			INSERT INTO prodformula (empresa, formula, descripcion_produccion, descripcion_laboratorio, fecha_alta, empleado, paletacolor, colorimetro, coste_kg_formula, 
											textura, activa_en_produccion, mp_equivalente, referencia_general, unidad_coste) 
			VALUES (:empresa, :formula_nueva, :tiff, :tiff, :ahora, NULL, NULL, NULL, NULL, NULL, 'S', NULL, NULL, :formula_unidad) USING trm;
			IF trm.SQLCode <> 0 THEN         
				MessageBox("SQL error Fórmula", trm.SQLErrText)
				rtn = -1
			END IF
			
			
			//Componentes de la formula (extraidos de la estándar)
			sel2 = "SELECT mprima, proveedor FROM prodaplicacion_mprima WHERE empresa = '"+empresa+"' AND aplicacion = '"+tipoaplicacion+"'"
			f_cargar_cursor_trans (trm,  sel2,  mprimas)
			numero2 = mprimas.RowCount()
			j = 1
			do while (j <= numero2 AND rtn = 1) 
				mprima = mprimas.object.mprima[j]
				proveedor = mprimas.object.proveedor[j]
				
				INSERT INTO proddetformula (empresa, formulacion, mp, cantidad, unidadmedida, proveedor, cantidad_u_m_mp, unidad_u_m_mp, coste_mp) 
				VALUES (:empresa, :formula_nueva, :mprima, NULL, :desc_unidad, :proveedor, 0, :formula_unidad ,0) USING trm;
				IF trm.SQLCode <> 0 THEN         
					MessageBox("SQL error Componentes Fórmula ", trm.SQLErrText)
					rtn = -1
				END IF
				j++
			loop
			mprimas.reset()
		else
			formula_nueva = esta
		end if
		
		//AÑADIR LA FORMULA AL CAMPO APLICACIÓN
		if rtn = 1 then
			UPDATE art_ver_op_aplicaciones SET formula = :formula_nueva 
			WHERE empresa = :empresa AND articulo = :articulo AND version = :version_op AND operacion = :operacion AND contadoraplicacion = :contadoraplicacion USING trm;
			IF trm.SQLCode <> 0 THEN         
				MessageBox("SQL error Actualización Aplicación con la Fórmula nueva", trm.SQLErrText)
				rtn = -1
			ELSE
				cont_traspasado++;
			END IF
		end if
	else
		//Apuntar o imprimir listado de TIFFs no insertados porque ya hay formulas...
		tiff = "T"+tiff
		if desc_formula <> tiff then
			cont_no_traspasado++;
			MessageBox("Error", "Ya hay una fórmula asociada en la aplicación del TIF del artículo "+articulo)
		else
			//Ya está traspasado
			cont_ya_traspasado++;
		end if
	end if
	
	if rtn = 1 then
		//Evitamos problemas de desbordamiento
		COMMIT USING trm;
	end if
	
	barra_1.StepIt()
	i++
loop

aplicaciones.reset()
//Fin inserción de rutas

//RESULTADO
IF rtn = 1 then
	COMMIT USING trm;
	mensaje = "Se han traspasado "+String(cont_traspasado)+" TIFFs con éxito. Se han encontrado "+String(cont_ya_traspasado)+" ya traspasados. NO se han traspasado "+String(cont_no_traspasado)+"."
	st_info.text = "Fin traspaso"
else
	ROLLBACK USING trm;
	mensaje = "Error en el traspaso de TIFFs"
	st_info.text = "Error traspaso"
end if
MessageBox("Resultado de la operación",mensaje)
DISCONNECT USING trm;

Destroy aplicaciones
Destroy mprimas
Destroy trm

*/
end event

type p_logo from picture within wtc_traspaso_tiff
integer x = 2039
integer y = 20
integer width = 517
integer height = 96
string picturename = "C:\Tencer_PB12\tencer24.jpg"
boolean focusrectangle = false
end type

type st_titulo from statictext within wtc_traspaso_tiff
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

