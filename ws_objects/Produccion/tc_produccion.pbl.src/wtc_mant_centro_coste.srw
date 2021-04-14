$PBExportHeader$wtc_mant_centro_coste.srw
forward
global type wtc_mant_centro_coste from wt_ventana_padre
end type
type dw_con_piezas_coleccion from u_dw_padre within wtc_mant_centro_coste
end type
type pb_anyade_trabajo from picturebutton within wtc_mant_centro_coste
end type
type pb_1 from picturebutton within wtc_mant_centro_coste
end type
type pb_borrar_trabajo from picturebutton within wtc_mant_centro_coste
end type
type dw_2 from u_dw within wtc_mant_centro_coste
end type
end forward

global type wtc_mant_centro_coste from wt_ventana_padre
integer height = 1752
string title = "Mantenimiento de Centros de Coste"
dw_con_piezas_coleccion dw_con_piezas_coleccion
pb_anyade_trabajo pb_anyade_trabajo
pb_1 pb_1
pb_borrar_trabajo pb_borrar_trabajo
dw_2 dw_2
end type
global wtc_mant_centro_coste wtc_mant_centro_coste

forward prototypes
public function integer f_guardar ()
public function boolean hay_cambios ()
public function integer f_borrar ()
end prototypes

public function integer f_guardar ();//SOBRESCRIBIMOS LA FUNCION DEL PADRE. NO LA LLMAMOS CON super::funcion()

long i
string campo, motivo
boolean falta_Campo, aceptado
string cod_inkcid, cod_inkcid2, inkcid, trabajo, dato
string v_coleccion
Int resultado

resultado = 1 //Todo ok si devolvemos 1

param_colisiones.empresa = codigo_empresa
param_colisiones.tabla = "centro_coste"
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
	if IsNull(dw_1.object.descripcion[dw_1.getrow()]) or Trim(String(dw_1.object.descripcion[dw_1.getrow()])) = "" then
		  campo = "descripcion"
		  motivo = "Campo Obligatorio: Descripción. "
		  falta_campo = True
	end if	

	if falta_campo then
	  MessageBox("Campo obligatorio: "+campo,motivo,Exclamation!, OK!,1)
	  dw_1.setfocus()
	  dw_1.SetColumn(campo)
	  return 0
	end if
end if

// Campos obligatorios dw_2 
if dw_2.RowCount() < 1 then
	messagebox("Aviso", 'Debe indicarse alguna máquina asociada al nuevo centro de coste')
	return 0
end if


dw_2.accepttext()
falta_campo = false
IF dw_2.rowcount() > 0 THEN
	falta_campo = false
	i = 1
	DO WHILE ( i <= dw_2.rowcount() AND NOT falta_campo )
		
		IF IsNull(dw_2.object.centro_coste_maquina_maquina[i]) or Trim(String(dw_2.object.centro_coste_maquina_maquina[i]))="" THEN
			  campo="centro_coste_maquina_maquina"
			  motivo  = "Campo Obligatorio: Introduzca la Máquina asociada al centro de coste"
			  falta_campo = True
		END IF
		i++
	LOOP
		
	IF falta_campo THEN
	  MessageBox(" "+campo+": Campo obligatorio",motivo,Exclamation!, OK!,1)
	  dw_2.setfocus()
	  dw_2.SetColumn(campo)
	  return 0
	END IF
END IF


/*---------------------------------------------------------------------------------------------------------------------------------
			   					FIN DE COMPROBAR LOS CAMPOS OBLIGATORIOS.
---------------------------------------------------------------------------------------------------------------------------------*/

/*---------------------------------------------------------------------------------------------------------------------------------
			   					GRABACIÓN DW PRINCIPAL
---------------------------------------------------------------------------------------------------------------------------------*/

// El primer campo del datawindow será el que reciba el código generado. 
// Por tanto, al crear el datawindow maestro debemos situar en primera posición dicho campo
dw_1.accepttext()

//Codigo por si se desea mostrar aviso antes de guardar (Por defecto NO, si no utilizar Message.DoubleParm = 10001)

//f_crear_transaccion(transaccion ,"" ,"" ,false, "TS","")	
//CONNECT USING transaccion;
dw_1.SetTransObject(trans_ts)	

if dw_1.rowcount() > 0 then
	dw_1.object.empresa[dw_1.getrow()] = codigo_empresa		
	if String(dw_1.object.#1[dw_1.getrow()]) = '' or isnull (dw_1.object.#1[dw_1.getrow()]) then
		padre_codigo = String(f_colisiones ( trans_ts, param_colisiones))
		if padre_codigo = '0'  then
			messagebox("ERROR", "No se puede asignar un código.")
			ROLLBACK USING trans_ts;
			//DISCONNECT USING transaccion;
			dw_1.SetTransObject(SQLCA)	
			return 0
		else
			dw_1.object.#1[dw_1.getrow()] = padre_codigo
		end if
	end if
end if

rtn = dw_1.Update()

/*---------------------------------------------------------------------------------------------------------------------------------
			   					FIN GRABACIÓN DW PRINCIPAL
---------------------------------------------------------------------------------------------------------------------------------*/


IF rtn = 1 THEN
/*---------------------------------------------------------------------------------------------------------------------------------
				   				GRABACIÓN DATAWINDOWS AUXILIARES
---------------------------------------------------------------------------------------------------------------------------------*/
	dw_2.SetTransObject(trans_ts)
	for i = 1 to dw_2.RowCount()
		dw_2.object.centro_coste_maquina_centro_coste[i] = dw_1.object.#1[dw_1.getrow()]
	next
	rtn = dw_2.update() 
end if		

/*---------------------------------------------------------------------------------------------------------------------------------
				   			FIN GRABACIÓN DATAWINDOWS AUXILIARES
---------------------------------------------------------------------------------------------------------------------------------*/
		
IF rtn = 1 THEN
	COMMIT USING trans_ts;
	mostrar_controles_edicion()

	dw_1.setfocus()
	dw_1.setcolumn(2)
ELSE
	ROLLBACK USING trans_ts;
END IF
//DISCONNECT USING trans_ts;
dw_1.SetTransObject(SQLCA)	
dw_2.SetTransObject(SQLCA)				
//destroy transaccion

estado = 1 // Modo edición

return rtn
end function

public function boolean hay_cambios ();Boolean resultado
resultado = false

dw_1.accepttext() //Necesario para que se detecten los cambios en el campo en el que se tiene el foco

if dw_1.DeletedCount() + dw_1.ModifiedCount() > 0 or dw_2.DeletedCount() + dw_2.ModifiedCount() > 0 then
	resultado = true
end if

return resultado
end function

public function integer f_borrar ();//SOBRESCRIBIMOS LA FUNCION DEL PADRE. NO LA LLMAMOS CON super::funcion()

string codigo
long total_modelos_coleccion, total_trabajos_lab
str_ventana_alerta parametros
string botones[2]

codigo = padre_codigo

parametros.titulo = "Atención"
parametros.subtitulo = "Borrar registro"
parametros.mensaje = "¿Desea borrar el registro?"
parametros.tipo = 1
//parametros.botones = botones
parametros.mostrar_imagen = true
openwithparm(wtc_ventana_alerta, parametros)
borrar = Int(Message.DoubleParm)

rtn = 0
if borrar = 1 then
	padre_codigo = dw_1.object.#1[dw_1.GetRow()]
//	f_crear_transaccion(transaccion ,"" ,"" ,false, "TS","")	
//	CONNECT USING transaccion;
	dw_1.SetTransObject(trans_ts)	
	
	rtn = dw_1.deleterow(0)
	if rtn = 1 then
		rtn = dw_1.update()
	end if
end if

if rtn = 1 then
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//   AQUÍ IRÁ EL CÓDIGO DE LOS DW AUXILIARES. CONTROLAR LOS BORRADOS CON rtn. 
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	delete from centro_coste_maquina 
	where empresa = :codigo_empresa 
	and centro_coste = :padre_codigo using trans_ts;
		
	IF trans_ts.SQLCode <> 0 THEN         
		MessageBox("SQL error", trans_ts.SQLErrText)
		rtn = -1
	END IF
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	if rtn = 1 then
		COMMIT USING trans_ts;
//		DISCONNECT USING transaccion;	
		dw_1.SetTransObject(SQLCA)	
//		destroy transaccion
		pb_nuevo.TriggerEvent(Clicked!)	
		mostrar_controles_insercion()
		dw_1.setfocus()
		dw_1.setcolumn(2)
		estado = 0 // Modo Insercion
	ELSE
		ROLLBACK USING trans_ts;
//		DISCONNECT USING transaccion;	
		dw_1.SetTransObject(SQLCA)	
//		destroy transaccion
		dw_1.object.#1[1] = padre_codigo
		pb_cancelar.triggerevent(Clicked!)
	
	END IF
end if

return rtn
end function

on wtc_mant_centro_coste.create
int iCurrent
call super::create
this.dw_con_piezas_coleccion=create dw_con_piezas_coleccion
this.pb_anyade_trabajo=create pb_anyade_trabajo
this.pb_1=create pb_1
this.pb_borrar_trabajo=create pb_borrar_trabajo
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con_piezas_coleccion
this.Control[iCurrent+2]=this.pb_anyade_trabajo
this.Control[iCurrent+3]=this.pb_1
this.Control[iCurrent+4]=this.pb_borrar_trabajo
this.Control[iCurrent+5]=this.dw_2
end on

on wtc_mant_centro_coste.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_con_piezas_coleccion)
destroy(this.pb_anyade_trabajo)
destroy(this.pb_1)
destroy(this.pb_borrar_trabajo)
destroy(this.dw_2)
end on

event open;call super::open;dw_2.SetTransObject(SQLCA)
end event

event activate;call super::activate;wtc_mant_centro_coste = ventanas_activas[id_ventana_activa].ventana
end event

type pb_imprimir from wt_ventana_padre`pb_imprimir within wtc_mant_centro_coste
end type

type p_logo from wt_ventana_padre`p_logo within wtc_mant_centro_coste
end type

type dw_1 from wt_ventana_padre`dw_1 within wtc_mant_centro_coste
integer height = 524
string dataobject = "dwtc_centros_coste"
boolean border = false
end type

type pb_borrar from wt_ventana_padre`pb_borrar within wtc_mant_centro_coste
end type

type pb_salir from wt_ventana_padre`pb_salir within wtc_mant_centro_coste
end type

type pb_grabar from wt_ventana_padre`pb_grabar within wtc_mant_centro_coste
end type

type st_titulo from wt_ventana_padre`st_titulo within wtc_mant_centro_coste
end type

type pb_nuevo from wt_ventana_padre`pb_nuevo within wtc_mant_centro_coste
end type

event pb_nuevo::clicked;call super::clicked;if dw_1.rowcount() > 0 then
	dw_1.SetColumn(1)
end if
dw_2.reset()
end event

type pb_cancelar from wt_ventana_padre`pb_cancelar within wtc_mant_centro_coste
end type

event pb_cancelar::clicked;call super::clicked;if estado = 1 then
	dw_2.retrieve(codigo_empresa,padre_codigo)	
end if
end event

type pb_buscar from wt_ventana_padre`pb_buscar within wtc_mant_centro_coste
end type

event pb_buscar::clicked;string campo

campo = dw_1.GetColumnName()

padre_busqueda.filtro_es_codigo = false
choose case campo
	case "codigo"
		padre_busqueda.filtro_es_codigo = true
		padre_busqueda.consulta =  " SELECT centro_coste.codigo, centro_coste.codigo, centro_coste.descripcion "+&	
									" FROM centro_coste "+&
									" WHERE centro_coste.empresa = '"+codigo_empresa+"' "+&
									" ORDER BY CONVERT(INTEGER, centro_coste.codigo) desc"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Código"
		padre_busqueda.titulos[3] = "Descripción"	

	case "descripcion"
		padre_busqueda.consulta =  " SELECT centro_coste.codigo, centro_coste.descripcion "+&	
									" FROM centro_coste "+&
									" WHERE centro_coste.empresa = '"+codigo_empresa+"' "+&
									" ORDER BY centro_coste.descripcion asc"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Descripción"	
	case else
		padre_busqueda.filtro_es_codigo = true
		padre_busqueda.consulta =  " SELECT centro_coste.codigo, centro_coste.codigo, centro_coste.descripcion "+&	
									" FROM centro_coste "+&
									" WHERE centro_coste.empresa = '"+codigo_empresa+"' "+&
									" ORDER BY CONVERT(INTEGER, centro_coste.codigo) desc"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Código"
		padre_busqueda.titulos[3] = "Descripción"		
end choose


call super :: clicked

if padre_codigo <> "" then
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// AQUÍ PONDREMOS TODOS LOS DATAWINDOWS AUXILIARES
	dw_2.retrieve (codigo_empresa, dw_1.object.codigo[1])
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
end if
end event

type dw_con_piezas_coleccion from u_dw_padre within wtc_mant_centro_coste
integer x = 4293
integer y = 2360
integer width = 1280
integer height = 596
integer taborder = 70
boolean bringtotop = true
string dataobject = "dwtc_con_piezas_coleccion"
end type

type pb_anyade_trabajo from picturebutton within wtc_mant_centro_coste
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

type pb_1 from picturebutton within wtc_mant_centro_coste
integer x = 41
integer y = 1408
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

event clicked;long fila_actual, nuevaprueba, indice, maximo_valor_dw
string codigo_actual

fila_actual = dw_2.InsertRow(0)

//dw_2.object.centro_coste_maquina_centro_coste[fila_actual] = padre_codigo
dw_2.object.centro_coste_maquina_empresa[fila_actual] = codigo_empresa

dw_2.scrolltorow(fila_actual)
dw_2.SetColumn(1)
dw_2.Setfocus()


end event

type pb_borrar_trabajo from picturebutton within wtc_mant_centro_coste
integer x = 192
integer y = 1408
integer width = 146
integer height = 128
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\navigate_minus.png"
alignment htextalign = left!
string powertiptext = "EliminarRegistro"
end type

event clicked;boolean error_borrando
long fila_actual

error_borrando = false
fila_actual = dw_2.getrow()
if fila_actual > 0 then
	if dw_2.DeleteRow(fila_actual) <> 1 then
		error_borrando = True
	else
		error_borrando = False
	end if
end if
end event

type dw_2 from u_dw within wtc_mant_centro_coste
integer x = 23
integer y = 796
integer width = 2226
integer height = 760
integer taborder = 70
string dataobject = "dwtc_centro_coste_maquina"
end type

event usr_dwnkey;call super::usr_dwnkey;string campo
str_wt_busquedas_salida resultado
str_wt_busquedas_entrada busqueda

//if key = KeyF8! then
	//dw_1.EVENT usr_keydown(key, keyflags)
//end if

control_teclas (keyflags, key)

busqueda.filtro_es_codigo = false
if key =  keyEnter! then
	campo = This.GetColumnName()
	CHOOSE CASE campo
		CASE "centro_coste_maquina_maquina"
			busqueda.titulo_ventana = "Búsqueda de Máquina"
			busqueda.consulta  = " SELECT codigo, abreviado, descripcion "+&
										" FROM maquina "+&
										" WHERE empresa = '"+codigo_empresa+"' ORDER BY DESCRIPCION"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Abreviado"
			busqueda.titulos[3] = "Descripción"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				this.object.centro_coste_maquina_maquina[this.GetRow()] 	= resultado.valores[1]
				this.object.maquina_abreviado[this.GetRow()] 				= resultado.valores[2]		
				this.object.maquina_descripcion[this.GetRow()]				= resultado.valores[3]		
			end if			
	END CHOOSE
end if	
	
end event

event itemchanged;call super::itemchanged;string resultado, resultado1

this.Accepttext()

CHOOSE CASE dwo.name
	CASE "centro_coste_maquina_maquina"
		SELECT descripcion, abreviado
		INTO :resultado, :resultado1
		FROM maquina
		WHERE empresa = :codigo_empresa
		and maquina.codigo = :data;

		if SQLCA.sqlcode <> 100 then
			this.object.maquina_abreviado[Row] 		= resultado1
			this.object.maquina_descripcion[Row] 	= resultado
		else
			dwo.Primary[row] = ''
			this.object.maquina_abreviado[Row] 		= ''
			this.object.maquina_descripcion[Row] 		= ''
			return 2			
		end if
END CHOOSE

end event

event clicked;call super::clicked;str_parametros lstr_param
long esta_abierta


CHOOSE CASE dwo.name

CASE "p_tipooperacion"
esta_abierta = f_menu_ventana_esta_abierta("wtc_mant_maquina")
//Abrimos la ventana si no está abierta ya. En caso contrario la mostramos
if esta_abierta = -1 then
	if this.object.centro_coste_maquina_maquina[row] <> "" then
		lstr_param.s_argumentos[1] = this.object.centro_coste_maquina_maquina[row]
		lstr_param.i_nargumentos = 1
		lstr_param.nombre_ventana = "wtc_mant_centro_coste"
		lstr_param.resultado = ''
		Openwithparm(wtc_mant_maquina, lstr_param)
	else
		Openwithparm(wtc_mant_maquina, lstr_param)
	end if
else
	ventanas_activas[esta_abierta].ventana.BringToTop = true
end if
END CHOOSE


end event

