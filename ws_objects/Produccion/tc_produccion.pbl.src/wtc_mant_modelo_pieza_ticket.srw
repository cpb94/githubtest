$PBExportHeader$wtc_mant_modelo_pieza_ticket.srw
forward
global type wtc_mant_modelo_pieza_ticket from wt_ventana_padre
end type
type dw_con_piezas_coleccion from u_dw_padre within wtc_mant_modelo_pieza_ticket
end type
type pb_anyade_trabajo from picturebutton within wtc_mant_modelo_pieza_ticket
end type
end forward

global type wtc_mant_modelo_pieza_ticket from wt_ventana_padre
integer width = 2094
integer height = 1432
string title = "Mantenimiento de Tickets de Máquinas de Producción"
dw_con_piezas_coleccion dw_con_piezas_coleccion
pb_anyade_trabajo pb_anyade_trabajo
end type
global wtc_mant_modelo_pieza_ticket wtc_mant_modelo_pieza_ticket

forward prototypes
public function integer f_guardar ()
public function integer f_borrar ()
end prototypes

public function integer f_guardar ();//LLMAMOS CON super::funcion() al padre para continuar la ejecución del guardado

string campo, motivo
boolean falta_Campo
Int resultado

resultado = 1 //Todo ok si devolvemos 1

param_colisiones.empresa = codigo_empresa
param_colisiones.tabla = "ruta_descripcion"
param_colisiones.campo = "codigo"
param_colisiones.filtro = ""
param_colisiones.buscar_huecos = false

/*---------------------------------------------------------------------------------------------------------------------------------
			   AQUÍ IRÁ EL CÓDIGO PARA COMPROBAR LOS CAMPOS OBLIGATORIOS.
---------------------------------------------------------------------------------------------------------------------------------*/

// Campos obligatorios dw_1 

dw_1.accepttext()
falta_campo = false
if dw_1.rowcount() > 0 then
	if IsNull(dw_1.object.cantidad[dw_1.getrow()]) or Trim(String(dw_1.object.cantidad[dw_1.getrow()])) = "" then
		  campo = "cantidad"
		  motivo = "Campo Obligatorio: Cantidad. "
		  falta_campo = True
	end if
	if IsNull(dw_1.object.esmalte[dw_1.getrow()]) or Trim(String(dw_1.object.esmalte[dw_1.getrow()])) = "" then
		  campo = "esmalte"
		  motivo = "Campo Obligatorio: Esmalte. "
		  falta_campo = True
	end if
	if falta_campo then
	  MessageBox("Campo obligatorio: "+campo,motivo,Exclamation!, OK!,1)
	  dw_1.setfocus()
	  dw_1.SetColumn(campo)
	  return 0
	end if
end if

rtn = super::f_guardar()

IF rtn = 1 THEN
	COMMIT USING trans_ts;
	mostrar_controles_edicion()

	dw_1.setfocus()
	dw_1.setcolumn(2)
ELSE
	ROLLBACK USING trans_ts;
END IF

estado = 1 // Modo edición
dw_1.settransobject(sqlca)

return rtn
end function

public function integer f_borrar ();Datetime ahora 
String pieza, codigo, maquina, tipo_maquina, archivo_disenyo, archivo_disenyo_prueba, ruta_maquina, nombre_archivo
String sel
Long i, numero_maquinas, pruebas_fichero
Datastore maquinas

rtn = 1 //Todo ok
/*
MessageBox("NO PERMITIDO", "No se permite en borrado de Tickets de Producción")
return -1
*/

padre_codigo = dw_1.object.codigo[1]
tipo_maquina = dw_1.object.tipo_maquina[1]
archivo_disenyo = dw_1.object.archivo_disenyo[1]
archivo_disenyo_prueba = dw_1.object.archivo_disenyo_prueba[1]
	
if rtn = 1 then
	//Borrado ficheros pruebas
	sel = "SELECT prodlineas FROM modelo_pieza_ticket_prodlineas WHERE empresa = '"+codigo_empresa+"' and modelo_pieza_ticket = '"+padre_codigo+"'"
	f_cargar_cursor_transaccion (trans_ts, maquinas,  sel)
	numero_maquinas = maquinas.RowCount()
	i = 1
	do while (i <= numero_maquinas) 
		maquina = maquinas.object.prodlineas[i]
				
		pruebas_fichero = 0
		SELECT isnull(COUNT(*), 0 ) INTO :pruebas_fichero FROM modelo_pieza_ticket T INNER JOIN modelo_pieza_ticket_prodlineas L ON T.empresa = L.empresa AND T.codigo = L.modelo_pieza_ticket 
		WHERE T.empresa = :codigo_empresa AND T.tipo_maquina = :tipo_maquina AND T.archivo_disenyo = :archivo_disenyo 
		AND T.archivo_disenyo_prueba = :archivo_disenyo_prueba AND T.fecha_fin IS NULL AND L.prodlineas = :maquina USING trans_ts;
		
		//No borramos el fichero si está en más pruebas sin finalizar
		if pruebas_fichero = 0 then 
			SELECT ruta_pruebas_lab INTO :ruta_maquina FROM prodlineas WHERE empresa = :codigo_empresa AND codigo = :maquina using trans_ts;
			if isnull(ruta_maquina) or ruta_maquina = "" then
				MessageBox("Error","No se encuentra la ruta de la máquina para borrar su fichero.")
				rtn = -1
			else
				SELECT fichero INTO :nombre_archivo FROM archivo_disenyo_sistema_archivos 
				WHERE empresa = :codigo_empresa AND tipomaquina_disenyo = :tipo_maquina AND archivo = :archivo_disenyo AND codigo = :archivo_disenyo_prueba USING trans_ts;
				if isnull(nombre_archivo) or nombre_archivo = "" then
					//No avisamos
					//MessageBox("Error","No se encuentra la ruta del archivo.")
					rtn = -1
				end if
			end if
			if rtn = 1 then
				fileDelete(ruta_maquina + nombre_archivo)
			end if
			/*
			//No avisamos del borrado
			if fileDelete(ruta_maquina + nombre_archivo) then
				MessageBox("Fichero Borrado", "Archivo borrado con éxito.")
			else
				MessageBox("Error de borrado", "No se ha podido borrar el archivo.")
			end if
			*/
		end if
		i++
	loop		
	
	Destroy maquinas
	
	//TABLAS AUXILIARES
	DELETE FROM modelo_pieza_ticket_prodlineas WHERE empresa = :codigo_empresa AND modelo_pieza_ticket = :padre_codigo USING trans_ts;
	IF trans_ts.SQLCode <> 0 THEN         
		MessageBox("SQL error", trans_ts.SQLErrText)
		rtn = -1
	END IF
end if

if rtn = 1 then
	super::f_borrar()	
else
	MessageBox("Atención","No ha sido posible realizar el borrado en la base de datos. Inténtelo de nuevo y si no es posible, avise al administrador.")
	ROLLBACK USING trans_ts;
	dw_1.object.#1[1] = padre_codigo
	pb_cancelar.triggerevent(Clicked!)

end if

return rtn
end function

on wtc_mant_modelo_pieza_ticket.create
int iCurrent
call super::create
this.dw_con_piezas_coleccion=create dw_con_piezas_coleccion
this.pb_anyade_trabajo=create pb_anyade_trabajo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con_piezas_coleccion
this.Control[iCurrent+2]=this.pb_anyade_trabajo
end on

on wtc_mant_modelo_pieza_ticket.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_con_piezas_coleccion)
destroy(this.pb_anyade_trabajo)
end on

event open;call super::open;Int tiene_fecha_fin

tiene_fecha_fin = 0
SELECT isnull(COUNT(*), 0) INTO :tiene_fecha_fin FROM modelo_pieza_ticket WHERE empresa = :codigo_empresa AND codigo = :padre_codigo AND fecha_fin IS NULL;

if tiene_fecha_fin <> 1 then
	MessageBox("Error", "Ticket ya finalizado. No se puede modificar.")
	cerrar_sin_abrir = true
	this.Post Event ue_cerrar_sin_abrir()
end if
end event

type pb_imprimir from wt_ventana_padre`pb_imprimir within wtc_mant_modelo_pieza_ticket
integer x = 192
integer y = 132
end type

type p_logo from wt_ventana_padre`p_logo within wtc_mant_modelo_pieza_ticket
integer x = 1531
integer y = 20
end type

type dw_1 from wt_ventana_padre`dw_1 within wtc_mant_modelo_pieza_ticket
integer x = 27
integer y = 292
integer width = 2007
string dataobject = "dwtc_modelo_pieza_ticket"
boolean border = false
end type

event dw_1::itemchanged;call super::itemchanged;string resultado

this.Accepttext()

CHOOSE CASE dwo.name
	CASE "esmalte"
		select descripcion_laboratorio
		into :resultado
		from prodformula
		where empresa = :codigo_empresa
		and formula = :data;
		
		if SQLCA.sqlcode <> 100 then
			this.object.prodformula_descripcion_laboratorio[Row] 	= resultado
		else
			dwo.Primary[row] = ''
			this.object.prodformula_descripcion_laboratorio[Row] 	= ''
			return 2			
		end if
		
	CASE "base"
		//Permitimos probar bases de cualquier cliente
		SELECT articulos.descripcion 
		INTO :resultado 
		FROM articulos 
		WHERE articulos.empresa = :codigo_empresa and articulos.uso = '1' and articulos.codigo = :data;
		if SQLCA.sqlcode <> 100 then
			this.object.articulos_descripcion[Row] 		= resultado
		else
			dwo.Primary[row] = ''
			this.object.articulos_descripcion[Row] 		= ''
			return 2			
		end if
END CHOOSE

this.Accepttext()
end event

event dw_1::usr_keydown;call super::usr_keydown;String campo
str_wt_busquedas_salida resultado
str_wt_busquedas_entrada busqueda

control_teclas (keyflags, key)

busqueda.filtro_es_codigo = false
if key =  keyEnter! then
	campo = This.GetColumnName()
	CHOOSE CASE campo
		CASE "esmalte"
			busqueda.titulo_ventana = "Búsqueda de Fórmulas"
			busqueda.consulta  = " SELECT formula, descripcion_laboratorio "+&
										" FROM prodformula "+&
										" WHERE empresa = '"+codigo_empresa+"' ORDER BY descripcion_laboratorio"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Fórmula"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				this.object.esmalte[this.GetRow()]										 = resultado.valores[1]		
				this.object.prodformula_descripcion_laboratorio[this.GetRow()]	 = resultado.valores[2]		
			end if
		CASE "base"
			//Permitimos probar bases de cualquier cliente
			busqueda.consulta =  "SELECT articulos.codigo, CONVERT(char(60),articulos.descripcion), formatos.abreviado, almusos.descripcion, genter.razon "+&
						"FROM articulos "+&
						"INNER JOIN almusos ON articulos.uso = almusos.codigo and articulos.empresa = almusos.empresa "+&
						"LEFT OUTER JOIN genter ON articulos.cliente = genter.codigo and articulos.empresa = genter.empresa "+&
						"LEFT OUTER JOIN formatos ON articulos.formato = formatos.codigo and articulos.empresa = formatos.empresa "+&
						"WHERE articulos.uso = '1' AND articulos.empresa = '"+codigo_empresa+"' AND "+&
						"articulos.fecha_anulado IS NULL AND "+&
						"(genter.tipoter IS NULL OR genter.tipoter = 'C')"+&
						"ORDER BY articulos.descripcion"
			busqueda.titulo_ventana = "Búsqueda de Bases"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Descripción"
			busqueda.titulos[3] = "Formato"
			busqueda.titulos[4] = "Uso"
			busqueda.titulos[5] = "Cliente"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				this.object.base[this.GetRow()] 			= resultado.valores[1]		
				this.object.articulos_descripcion[this.GetRow()] 	= resultado.valores[2]		
			end if
	END CHOOSE
end if	
end event

type pb_borrar from wt_ventana_padre`pb_borrar within wtc_mant_modelo_pieza_ticket
integer x = 1577
integer y = 136
end type

type pb_salir from wt_ventana_padre`pb_salir within wtc_mant_modelo_pieza_ticket
integer x = 1888
integer y = 136
end type

type pb_grabar from wt_ventana_padre`pb_grabar within wtc_mant_modelo_pieza_ticket
integer x = 37
integer y = 132
end type

type st_titulo from wt_ventana_padre`st_titulo within wtc_mant_modelo_pieza_ticket
integer y = 36
integer width = 1449
end type

type pb_nuevo from wt_ventana_padre`pb_nuevo within wtc_mant_modelo_pieza_ticket
boolean visible = false
integer x = 695
integer y = 132
end type

event pb_nuevo::clicked;call super::clicked;if dw_1.rowcount() > 0 then
	dw_1.SetColumn(1)
end if
end event

type pb_cancelar from wt_ventana_padre`pb_cancelar within wtc_mant_modelo_pieza_ticket
boolean visible = false
integer x = 1733
integer y = 136
end type

type pb_buscar from wt_ventana_padre`pb_buscar within wtc_mant_modelo_pieza_ticket
boolean visible = false
integer x = 850
integer y = 132
end type

event pb_buscar::clicked;string campo

campo = dw_1.GetColumnName()

padre_busqueda.filtro_es_codigo = false
choose case campo
	case "codigo"
		padre_busqueda.filtro_es_codigo = true
		padre_busqueda.consulta =  " SELECT ruta_descripcion.codigo, ruta_descripcion.codigo, ruta_descripcion.descripcion "+&	
									" FROM ruta_descripcion "+&
									" WHERE ruta_descripcion.empresa = '"+codigo_empresa+"' "+&
									" ORDER BY CONVERT(INTEGER, ruta_descripcion.codigo) desc"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Código"
		padre_busqueda.titulos[3] = "Descripción"	

	case "descripcion"
		padre_busqueda.consulta =  " SELECT ruta_descripcion.codigo, ruta_descripcion.descripcion "+&	
									" FROM ruta_descripcion "+&
									" WHERE ruta_descripcion.empresa = '"+codigo_empresa+"' "+&
									" ORDER BY ruta_descripcion.descripcion desc"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Descripción"		
	case else
		padre_busqueda.filtro_es_codigo = true
		padre_busqueda.consulta =  " SELECT ruta_descripcion.codigo, ruta_descripcion.codigo, ruta_descripcion.descripcion "+&	
									" FROM ruta_descripcion "+&
									" WHERE ruta_descripcion.empresa = '"+codigo_empresa+"' "+&
									" ORDER BY CONVERT(INTEGER, ruta_descripcion.codigo) desc"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Código"
		padre_busqueda.titulos[3] = "Descripción"	
end choose


call super :: clicked


end event

type dw_con_piezas_coleccion from u_dw_padre within wtc_mant_modelo_pieza_ticket
integer x = 4293
integer y = 2360
integer width = 1280
integer height = 596
integer taborder = 70
boolean bringtotop = true
string dataobject = "dwtc_con_piezas_coleccion"
end type

type pb_anyade_trabajo from picturebutton within wtc_mant_modelo_pieza_ticket
integer x = 5189
integer y = 2208
integer width = 146
integer height = 128
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\navigate_plus.png"
alignment htextalign = left!
string powertiptext = "Añadir Registro"
end type

event clicked;//long fila_actual, nuevaprueba, indice, maximo_valor_dw
//string modelo_actual
//
//nuevaprueba = 0
//modelo_actual =  padre_codigo
//
//select max(trabajo)
//into :nuevaprueba
//from destrabajo2
//where empresa = :codigo_empresa
//and modelo = :modelo_actual;
//
//maximo_valor_dw = long(dwtc_mant_trabajos_disenyo.Describe("Evaluate('Max(destrabajo2_trabajo)', 0)"))
//
//if isnull(nuevaprueba) then nuevaprueba = 0
//if isnull(maximo_valor_dw) then maximo_valor_dw = 0
//
//if nuevaprueba > maximo_valor_dw then
//	nuevaprueba ++
//else
//	nuevaprueba = maximo_valor_dw +1
//end if
//
//fila_actual = dwtc_mant_trabajos_disenyo.InsertRow(0)
//
//dwtc_mant_trabajos_disenyo.object.destrabajo2_trabajo[fila_actual] = nuevaprueba
//
//dwtc_mant_trabajos_disenyo.scrolltorow(fila_actual)
//dwtc_mant_trabajos_disenyo.SetColumn(3)
//dwtc_mant_trabajos_disenyo.Setfocus()
//dwtc_mant_trabajos_disenyo.object.destrabajo2_empresa[fila_actual] = codigo_empresa
////	dwtc_mant_trabajos_disenyo.object.destrabajo2_modelo[fila_actual] = modelo_actual
//dwtc_mant_trabajos_disenyo.object.destrabajo2_trabajo[fila_actual] = nuevaprueba
//dwtc_mant_trabajos_disenyo.object.destrabajo2_aceptado[fila_actual] = 'N'
//dwtc_mant_trabajos_disenyo.object.destrabajo2_fecha_solicitud[fila_actual] = datetime(today())
//dwtc_mant_trabajos_disenyo.object.destrabajo2_laboratorio[fila_actual] = 'N'
//dwtc_mant_trabajos_disenyo.object.destrabajo2_inkcid[fila_actual] = 'N'
//dwtc_mant_trabajos_disenyo.object.destrabajo2_tecnico_dis[fila_actual] = ''
//
end event

