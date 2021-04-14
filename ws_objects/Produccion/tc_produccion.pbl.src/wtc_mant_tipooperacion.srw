﻿$PBExportHeader$wtc_mant_tipooperacion.srw
forward
global type wtc_mant_tipooperacion from wt_ventana_padre
end type
type dw_con_piezas_coleccion from u_dw_padre within wtc_mant_tipooperacion
end type
type pb_anyade_trabajo from picturebutton within wtc_mant_tipooperacion
end type
type pb_1 from picturebutton within wtc_mant_tipooperacion
end type
type pb_borrar_trabajo from picturebutton within wtc_mant_tipooperacion
end type
type pb_2 from picturebutton within wtc_mant_tipooperacion
end type
type pb_3 from picturebutton within wtc_mant_tipooperacion
end type
type dw_2 from u_dw within wtc_mant_tipooperacion
end type
type dw_3 from u_dw within wtc_mant_tipooperacion
end type
end forward

global type wtc_mant_tipooperacion from wt_ventana_padre
integer width = 2295
integer height = 2324
string title = "Mantenimiento de Tipos de Operaciones"
dw_con_piezas_coleccion dw_con_piezas_coleccion
pb_anyade_trabajo pb_anyade_trabajo
pb_1 pb_1
pb_borrar_trabajo pb_borrar_trabajo
pb_2 pb_2
pb_3 pb_3
dw_2 dw_2
dw_3 dw_3
end type
global wtc_mant_tipooperacion wtc_mant_tipooperacion

forward prototypes
public function integer f_guardar ()
public function boolean hay_cambios ()
public function integer f_borrar ()
public function boolean f_post_asignar_codigo_padre ()
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
param_colisiones.tabla = "tipooperacion"
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
	messagebox("Aviso", 'Debe indicarse alguna Aplicacion Asociada a la Operación')
	return 0
end if


dw_2.accepttext()
falta_campo = false
IF dw_2.rowcount() > 0 THEN
	falta_campo = false
	i = 1
	DO WHILE ( i <= dw_2.rowcount() AND NOT falta_campo )
		
		IF IsNull(dw_2.object.tipooperacion_tipoaplicacion_tipoaplicacion[i]) or Trim(String(dw_2.object.tipooperacion_tipoaplicacion_tipoaplicacion[i]))="" THEN
			  campo="tipooperacion_tipoaplicacion_tipoaplicacion"
			  motivo  = "Campo Obligatorio: Introduzca el Tipo de Aplicación asociada a la Operación"
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


// Campos obligatorios dw_3
if dw_3.RowCount() < 1 then
	messagebox("Aviso", 'Debe indicarse alguna Descripción Asociada a la Operación')
	return 0
end if


dw_3.accepttext()
falta_campo = false
IF dw_3.rowcount() > 0 THEN
	falta_campo = false
	i = 1
	DO WHILE ( i <= dw_3.rowcount() AND NOT falta_campo )
		
		IF IsNull(dw_3.object.tipooperacion_ruta_descripcion_ruta_descripcion[i]) or Trim(String(dw_3.object.tipooperacion_ruta_descripcion_ruta_descripcion[i]))="" THEN
			  campo="tipooperacion_ruta_descripcion_ruta_descripcion"
			  motivo  = "Campo Obligatorio: Introduzca la Descripcción de Ruta asociada a la Operación"
			  falta_campo = True
		END IF
		i++
	LOOP
		
	IF falta_campo THEN
	  MessageBox(" "+campo+": Campo obligatorio",motivo,Exclamation!, OK!,1)
	  dw_3.setfocus()
	  dw_3.SetColumn(campo)
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

super::f_guardar()

IF rtn = 1 THEN
	rtn = dw_2.update() 
	IF rtn = 1 THEN
		rtn = dw_3.update() 	
	end if
end if		
	
/*---------------------------------------------------------------------------------------------------------------------------------
			   					FIN GRABACIÓN DW PRINCIPAL
---------------------------------------------------------------------------------------------------------------------------------*/


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

estado = 1 // Modo edición
dw_1.SetTransObject(sqlca)
dw_2.SetTransObject(sqlca)
dw_3.SetTransObject(sqlca)

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
	
	delete from tipooperacion_tipoaplicacion
	where empresa = :codigo_empresa 
	and tipooperacion = :padre_codigo using trans_ts;
		
	IF trans_ts.SQLCode <> 0 THEN         
		MessageBox("SQL error", trans_ts.SQLErrText)
		rtn = -1
	END IF
	
	if rtn = 1 then
		delete from tipooperacion_ruta_descripcion
		where empresa = :codigo_empresa 
		and tipooperacion = :padre_codigo using trans_ts;
			
		IF trans_ts.SQLCode <> 0 THEN         
			MessageBox("SQL error", trans_ts.SQLErrText)
			rtn = -1
		END IF
	end if
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	if rtn = 1 then
		rtn = super::f_borrar()
	ELSE
		ROLLBACK USING trans_ts;
		dw_1.object.#1[1] = padre_codigo
		pb_cancelar.triggerevent(Clicked!)
	
	END IF
end if
dw_2.SetTransObject(sqlca)
dw_3.SetTransObject(sqlca)
return rtn
end function

public function boolean f_post_asignar_codigo_padre ();int i

/*---------------------------------------------------------------------------------------------------------------------------------
				   				GRABACIÓN DATAWINDOWS AUXILIARES
---------------------------------------------------------------------------------------------------------------------------------*/
for i = 1 to dw_2.RowCount()
	dw_2.object.tipooperacion_tipoaplicacion_tipooperacion[i] = dw_1.object.#1[dw_1.getrow()]
next

for i = 1 to dw_3.RowCount()
	dw_3.object.tipooperacion_ruta_descripcion_tipooperacion[i] = dw_1.object.#1[dw_1.getrow()]
next


return true
end function

on wtc_mant_tipooperacion.create
int iCurrent
call super::create
this.dw_con_piezas_coleccion=create dw_con_piezas_coleccion
this.pb_anyade_trabajo=create pb_anyade_trabajo
this.pb_1=create pb_1
this.pb_borrar_trabajo=create pb_borrar_trabajo
this.pb_2=create pb_2
this.pb_3=create pb_3
this.dw_2=create dw_2
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con_piezas_coleccion
this.Control[iCurrent+2]=this.pb_anyade_trabajo
this.Control[iCurrent+3]=this.pb_1
this.Control[iCurrent+4]=this.pb_borrar_trabajo
this.Control[iCurrent+5]=this.pb_2
this.Control[iCurrent+6]=this.pb_3
this.Control[iCurrent+7]=this.dw_2
this.Control[iCurrent+8]=this.dw_3
end on

on wtc_mant_tipooperacion.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_con_piezas_coleccion)
destroy(this.pb_anyade_trabajo)
destroy(this.pb_1)
destroy(this.pb_borrar_trabajo)
destroy(this.pb_2)
destroy(this.pb_3)
destroy(this.dw_2)
destroy(this.dw_3)
end on

event open;call super::open;dw_2.SetTransObject(sqlca)
dw_3.SetTransObject(sqlca)
end event

event activate;call super::activate;wtc_mant_tipooperacion = ventanas_activas[id_ventana_activa].ventana
end event

type pb_imprimir from wt_ventana_padre`pb_imprimir within wtc_mant_tipooperacion
boolean visible = false
end type

type p_logo from wt_ventana_padre`p_logo within wtc_mant_tipooperacion
end type

type dw_1 from wt_ventana_padre`dw_1 within wtc_mant_tipooperacion
integer height = 348
string dataobject = "dwtc_tipooperacion"
boolean border = false
end type

type pb_borrar from wt_ventana_padre`pb_borrar within wtc_mant_tipooperacion
end type

type pb_salir from wt_ventana_padre`pb_salir within wtc_mant_tipooperacion
end type

type pb_grabar from wt_ventana_padre`pb_grabar within wtc_mant_tipooperacion
end type

type st_titulo from wt_ventana_padre`st_titulo within wtc_mant_tipooperacion
end type

type pb_nuevo from wt_ventana_padre`pb_nuevo within wtc_mant_tipooperacion
end type

event pb_nuevo::clicked;call super::clicked;if dw_1.rowcount() > 0 then
	dw_1.SetColumn(1)
end if
dw_2.reset()
dw_3.reset()
end event

type pb_cancelar from wt_ventana_padre`pb_cancelar within wtc_mant_tipooperacion
end type

event pb_cancelar::clicked;call super::clicked;if estado = 1 then
	dw_2.retrieve(codigo_empresa,padre_codigo)	
end if
end event

type pb_buscar from wt_ventana_padre`pb_buscar within wtc_mant_tipooperacion
end type

event pb_buscar::clicked;string campo

campo = dw_1.GetColumnName()

padre_busqueda.filtro_es_codigo = false
choose case campo
	case "codigo"
		padre_busqueda.filtro_es_codigo = true
		padre_busqueda.consulta =  " SELECT tipooperacion.codigo, tipooperacion.codigo, tipooperacion.descripcion "+&	
									" FROM tipooperacion "+&
									" WHERE tipooperacion.empresa = '"+codigo_empresa+"' "+&
									" ORDER BY CONVERT(INTEGER, tipooperacion.codigo) desc"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Código"
		padre_busqueda.titulos[3] = "Descripción"	

	case "descripcion"
		padre_busqueda.consulta =  " SELECT tipooperacion.codigo, tipooperacion.descripcion "+&	
									" FROM tipooperacion "+&
									" WHERE tipooperacion.empresa = '"+codigo_empresa+"' "+&
									" ORDER BY tipooperacion.descripcion asc"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Descripción"	
	case else
		padre_busqueda.filtro_es_codigo = true
		padre_busqueda.consulta =  " SELECT tipooperacion.codigo, tipooperacion.codigo, tipooperacion.descripcion "+&	
									" FROM tipooperacion "+&
									" WHERE tipooperacion.empresa = '"+codigo_empresa+"' "+&
									" ORDER BY CONVERT(INTEGER, tipooperacion.codigo) desc"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Código"
		padre_busqueda.titulos[3] = "Descripción"		
end choose


call super :: clicked

if padre_codigo <> "" then
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// AQUÍ PONDREMOS TODOS LOS DATAWINDOWS AUXILIARES
	dw_2.retrieve (codigo_empresa, dw_1.object.codigo[1])
	dw_3.retrieve (codigo_empresa, dw_1.object.codigo[1])
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
end if
end event

type dw_con_piezas_coleccion from u_dw_padre within wtc_mant_tipooperacion
integer x = 4293
integer y = 2360
integer width = 1280
integer height = 596
integer taborder = 70
boolean bringtotop = true
string dataobject = "dwtc_con_piezas_coleccion"
end type

type pb_anyade_trabajo from picturebutton within wtc_mant_tipooperacion
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

type pb_1 from picturebutton within wtc_mant_tipooperacion
integer x = 37
integer y = 1240
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

dw_2.object.tipooperacion_tipoaplicacion_tipooperacion[fila_actual] = padre_codigo
dw_2.object.tipooperacion_tipoaplicacion_empresa[fila_actual] = codigo_empresa

dw_2.scrolltorow(fila_actual)
dw_2.SetColumn(1)
dw_2.Setfocus()


end event

type pb_borrar_trabajo from picturebutton within wtc_mant_tipooperacion
integer x = 187
integer y = 1240
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

type pb_2 from picturebutton within wtc_mant_tipooperacion
integer x = 37
integer y = 2000
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
string picturename = "C:\Tencer_PB12\navigate_plus.png"
alignment htextalign = left!
string powertiptext = "Añadir Registro"
end type

event clicked;long fila_actual

fila_actual = dw_3.InsertRow(0)

dw_3.object.tipooperacion_ruta_descripcion_tipooperacion[fila_actual] = f_codigo_principal()
dw_3.object.tipooperacion_ruta_descripcion_empresa[fila_actual] = codigo_empresa

dw_3.scrolltorow(fila_actual)
dw_3.SetColumn(1)
dw_3.Setfocus()


end event

type pb_3 from picturebutton within wtc_mant_tipooperacion
integer x = 187
integer y = 2000
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
fila_actual = dw_3.getrow()
if fila_actual > 0 then
	if dw_3.DeleteRow(fila_actual) <> 1 then
		error_borrando = True
	else
		error_borrando = False
	end if
end if
end event

type dw_2 from u_dw within wtc_mant_tipooperacion
integer x = 23
integer y = 620
integer width = 2226
integer height = 760
integer taborder = 20
string dataobject = "dwtc_tipooperacion_tipoaplicacion"
end type

event clicked;call super::clicked;str_parametros lstr_param
long esta_abierta


CHOOSE CASE dwo.name

CASE "p_tipoaplicacion"
esta_abierta = f_menu_ventana_esta_abierta("wtc_mant_tipoaplicacion")
//Abrimos la ventana si no está abierta ya. En caso contrario la mostramos
if esta_abierta = -1 then
	if this.object.tipooperacion_tipoaplicacion_tipoaplicacion[row] <> "" then
		lstr_param.s_argumentos[1] = this.object.tipooperacion_tipoaplicacion_tipoaplicacion[row]
		lstr_param.i_nargumentos = 1
		lstr_param.nombre_ventana = "wtc_mant_tipooperacion"
		lstr_param.resultado = ''
		Openwithparm(wtc_mant_tipoaplicacion, lstr_param)
	else
		Openwithparm(wtc_mant_tipoaplicacion, lstr_param)
	end if
else
	ventanas_activas[esta_abierta].ventana.BringToTop = true
end if
END CHOOSE


end event

event itemchanged;call super::itemchanged;string resultado, resultado1

this.Accepttext()

CHOOSE CASE dwo.name
	CASE "tipooperacion_tipoaplicacion_tipoaplicacion"
		SELECT descripcion, abreviado
		INTO :resultado, :resultado1
		FROM tipoaplicacion
		WHERE empresa = :codigo_empresa
		and tipoaplicacion.codigo = :data;

		if SQLCA.sqlcode <> 100 then
			this.object.tipoaplicacion_abreviado[Row] 		= resultado1
			this.object.tipoaplicacion_descripcion[Row] 		= resultado
		else
			dwo.Primary[row] = ''
			this.object.tipoaplicacion_abreviado[Row] 		= ''
			this.object.tipoaplicacion_descripcion[Row] 		= ''
			return 2			
		end if
END CHOOSE

end event

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
		CASE "tipooperacion_tipoaplicacion_tipoaplicacion"
			busqueda.titulo_ventana = "Búsqueda de Aplicación"
			busqueda.consulta  = " SELECT codigo, abreviado, descripcion "+&
										" FROM tipoaplicacion "+&
										" WHERE empresa = '"+codigo_empresa+"' ORDER BY DESCRIPCION"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Abreviado"
			busqueda.titulos[3] = "Descripción"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				this.object.tipooperacion_tipoaplicacion_tipoaplicacion[this.GetRow()] 	= resultado.valores[1]
				this.object.tipoaplicacion_abreviado[this.GetRow()] 							= resultado.valores[2]		
				this.object.tipoaplicacion_descripcion[this.GetRow()]				 			= resultado.valores[3]		
			end if			
	END CHOOSE
end if	
	
end event

type dw_3 from u_dw within wtc_mant_tipooperacion
integer x = 23
integer y = 1380
integer width = 2226
integer height = 760
integer taborder = 60
string dataobject = "dwtc_tipooperacion_ruta_descripcion"
end type

event clicked;call super::clicked;str_parametros lstr_param
long esta_abierta


CHOOSE CASE dwo.name

CASE "p_ruta"
esta_abierta = f_menu_ventana_esta_abierta("wtc_mant_ruta_descripcion")
//Abrimos la ventana si no está abierta ya. En caso contrario la mostramos
if esta_abierta = -1 then
	if this.object.tipooperacion_ruta_descripcion_ruta_descripcion[row] <> "" then
		lstr_param.s_argumentos[1] = this.object.tipooperacion_ruta_descripcion_ruta_descripcion[row]
		lstr_param.i_nargumentos = 1
		lstr_param.nombre_ventana = "wtc_mant_tipooperacion"
		lstr_param.resultado = ''
		Openwithparm(wtc_mant_ruta_descripcion, lstr_param)
	else
		Openwithparm(wtc_mant_ruta_descripcion, lstr_param)
	end if
else
	ventanas_activas[esta_abierta].ventana.BringToTop = true
end if
END CHOOSE


end event

event itemchanged;call super::itemchanged;string resultado

this.Accepttext()

CHOOSE CASE dwo.name
	CASE "tipooperacion_ruta_descripcion_ruta_descripcion"
		SELECT descripcion 
		INTO :resultado 
		FROM ruta_descripcion
		WHERE empresa = :codigo_empresa
		and ruta_descripcion.codigo = :data;

		if SQLCA.sqlcode <> 100 then
			this.object.ruta_descripcion_descripcion[Row] 		= resultado
		else
			dwo.Primary[row] = ''
			this.object.ruta_descripcion_descripcion[Row] 		= ''
			return 2			
		end if
END CHOOSE

end event

event usr_dwnkey;call super::usr_dwnkey;string campo
str_wt_busquedas_salida resultado
str_wt_busquedas_entrada busqueda

control_teclas (keyflags, key)

busqueda.filtro_es_codigo = false
if key =  keyEnter! then
	campo = This.GetColumnName()
	CHOOSE CASE campo
		CASE "tipooperacion_ruta_descripcion_ruta_descripcion"
			busqueda.titulo_ventana = "Búsqueda de Descripciones de Rutas"
			busqueda.consulta  = " SELECT codigo, descripcion "+&
										" FROM ruta_descripcion "+&
										" WHERE empresa = '"+codigo_empresa+"' ORDER BY DESCRIPCION"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Descripción"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				this.object.tipooperacion_ruta_descripcion_ruta_descripcion[this.GetRow()] 	= resultado.valores[1]
				this.object.ruta_descripcion_descripcion[this.GetRow()]				 				= resultado.valores[2]		
			end if			
	END CHOOSE
end if	
	
end event

