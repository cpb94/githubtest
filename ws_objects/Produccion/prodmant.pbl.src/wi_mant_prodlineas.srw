$PBExportHeader$wi_mant_prodlineas.srw
forward
global type wi_mant_prodlineas from wt_ventana_padre
end type
type dw_con_piezas_coleccion from u_dw_padre within wi_mant_prodlineas
end type
type pb_anyade_trabajo from picturebutton within wi_mant_prodlineas
end type
type pb_anyadir_perfil from picturebutton within wi_mant_prodlineas
end type
type pb_borrar_perfil from picturebutton within wi_mant_prodlineas
end type
type dw_2 from u_dw within wi_mant_prodlineas
end type
type dw_3 from u_dw within wi_mant_prodlineas
end type
type pb_anyadir_tipomaquina from picturebutton within wi_mant_prodlineas
end type
type pb_borrar_tipomaquina from picturebutton within wi_mant_prodlineas
end type
end forward

global type wi_mant_prodlineas from wt_ventana_padre
integer width = 3648
integer height = 3456
string title = "Mantenimiento de Líneas de Producción / Máquinas"
dw_con_piezas_coleccion dw_con_piezas_coleccion
pb_anyade_trabajo pb_anyade_trabajo
pb_anyadir_perfil pb_anyadir_perfil
pb_borrar_perfil pb_borrar_perfil
dw_2 dw_2
dw_3 dw_3
pb_anyadir_tipomaquina pb_anyadir_tipomaquina
pb_borrar_tipomaquina pb_borrar_tipomaquina
end type
global wi_mant_prodlineas wi_mant_prodlineas

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
param_colisiones.tabla = "prodlineas"
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
	if IsNull(dw_1.object.prodlineas_descripcion[dw_1.getrow()]) or Trim(String(dw_1.object.prodlineas_descripcion[dw_1.getrow()])) = "" then
		  campo = "prodlineas_descripcion"
		  motivo = "Campo Obligatorio: Descripción. "
		  falta_campo = True
	end if	
	
	if IsNull(dw_1.object.prodlineas_resumido[dw_1.getrow()]) or Trim(String(dw_1.object.prodlineas_resumido[dw_1.getrow()])) = "" then
		  campo = "prodlineas_resumido"
		  motivo = "Campo Obligatorio: Resumido. "
		  falta_campo = True
	end if	
	
	if IsNull(dw_1.object.prodlineas_digital[dw_1.getrow()]) or Trim(String(dw_1.object.prodlineas_digital[dw_1.getrow()])) = "" then
		  campo = "prodlineas_digital"
		  motivo = "Campo Obligatorio: Debe indicar si la máquina es digital o no. "
		  falta_campo = True
	end if	
	
	if IsNull(dw_1.object.prodlineas_subcontratacion[dw_1.getrow()]) or Trim(String(dw_1.object.prodlineas_subcontratacion[dw_1.getrow()])) = "" then
		  campo = "prodlineas_subcontratacion"
		  motivo = "Campo Obligatorio: Debe indicar si la línea es subcontratada o no. "
		  falta_campo = True
	end if	
	

	if falta_campo then
	  MessageBox("Campo obligatorio: "+campo,motivo,Exclamation!, OK!,1)
	  dw_1.setfocus()
	  dw_1.SetColumn(campo)
	  return 0
	end if
end if

dw_2.accepttext()
falta_campo = false
IF dw_2.rowcount() > 0 THEN
	falta_campo = false
	i = 1
	DO WHILE ( i <= dw_2.rowcount() AND NOT falta_campo )
		
		IF IsNull(dw_2.object.prodlineas_perfil_color_perfil_color[i]) or Trim(String(dw_2.object.prodlineas_perfil_color_perfil_color[i]))="" THEN
			  campo="prodlineas_perfil_color_perfil_color"
			  motivo  = "Campo Obligatorio: Introduzca el Perfil de Color Soportado"
			  falta_campo = True
		END IF
		
		IF IsNull(dw_2.object.prodlineas_perfil_color_carpeta[i]) or Trim(String(dw_2.object.prodlineas_perfil_color_carpeta[i]))="" THEN
			  campo="prodlineas_perfil_color_carpeta"
			  motivo  = "Campo Obligatorio: Introduzca la carpeta del perfil de color soportado"
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

rtn = super::f_guardar()


/*---------------------------------------------------------------------------------------------------------------------------------
				   				GRABACIÓN DATAWINDOWS AUXILIARES
---------------------------------------------------------------------------------------------------------------------------------*/
dw_2.SetTransObject(trans_ts)
dw_3.SetTransObject(trans_ts)

IF rtn = 1 THEN
	rtn = dw_2.update() 
	if rtn = 1 then
		rtn = dw_3.update() 
	end if
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
estado = 1 // Modo edición

dw_1.SetTransObject (SQLCA)
dw_2.SetTransObject(SQLCA)
dw_3.SetTransObject(SQLCA)

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

public function integer f_borrar ();int  i

dw_2.SetTransObject(trans_ts)
dw_3.SetTransObject(trans_ts)

rtn = -1

for i = 1 to dw_2.rowcount()
	dw_2.deleterow(1)
next

if dw_2.update() = 1 then
	for i = 1 to dw_3.rowcount()
		dw_3.deleterow(1)
	next
	if dw_3.update() = 1 then
		rtn = 1
	else 
		rtn = -1
		messagebox ("Error", "Error borrando dw_2")
	end if
else 
	rtn = -1
	messagebox ("Error", "Error borrando dw_3")
end if

if rtn = 1 then
	rtn = super::f_borrar()
else
	rollback using trans_ts;
	messagebox ("Error", "Error borrando")
end if 

dw_2.SetTransObject(SQLCA)
dw_3.SetTransObject(SQLCA)

return rtn
end function

public function boolean f_post_asignar_codigo_padre ();int i

for i = 1 to dw_2.RowCount()
	dw_2.object.prodlineas_perfil_color_prodlineas[i] = dw_1.object.#1[dw_1.getrow()]
next

for i = 1 to dw_3.RowCount()
	dw_3.object.prodlinea_tipomaquina_disenyo_prodlinea[i] = dw_1.object.#1[dw_1.getrow()]
next

return true
end function

on wi_mant_prodlineas.create
int iCurrent
call super::create
this.dw_con_piezas_coleccion=create dw_con_piezas_coleccion
this.pb_anyade_trabajo=create pb_anyade_trabajo
this.pb_anyadir_perfil=create pb_anyadir_perfil
this.pb_borrar_perfil=create pb_borrar_perfil
this.dw_2=create dw_2
this.dw_3=create dw_3
this.pb_anyadir_tipomaquina=create pb_anyadir_tipomaquina
this.pb_borrar_tipomaquina=create pb_borrar_tipomaquina
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con_piezas_coleccion
this.Control[iCurrent+2]=this.pb_anyade_trabajo
this.Control[iCurrent+3]=this.pb_anyadir_perfil
this.Control[iCurrent+4]=this.pb_borrar_perfil
this.Control[iCurrent+5]=this.dw_2
this.Control[iCurrent+6]=this.dw_3
this.Control[iCurrent+7]=this.pb_anyadir_tipomaquina
this.Control[iCurrent+8]=this.pb_borrar_tipomaquina
end on

on wi_mant_prodlineas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_con_piezas_coleccion)
destroy(this.pb_anyade_trabajo)
destroy(this.pb_anyadir_perfil)
destroy(this.pb_borrar_perfil)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.pb_anyadir_tipomaquina)
destroy(this.pb_borrar_tipomaquina)
end on

event open;call super::open;dw_2.SetTransObject(SQLCA)
dw_3.SetTransObject(SQLCA)
end event

event activate;call super::activate;wi_mant_prodlineas = ventanas_activas[id_ventana_activa].ventana
end event

type pb_imprimir from wt_ventana_padre`pb_imprimir within wi_mant_prodlineas
boolean visible = false
end type

type p_logo from wt_ventana_padre`p_logo within wi_mant_prodlineas
integer x = 3063
integer y = 4
end type

type dw_1 from wt_ventana_padre`dw_1 within wi_mant_prodlineas
integer width = 2039
integer height = 792
string dataobject = "dwtc_prodlineas"
boolean border = false
end type

event dw_1::usr_keydown;call super::usr_keydown;string campo
str_wt_busquedas_salida resultado
str_wt_busquedas_entrada busqueda


busqueda.filtro_es_codigo = false
if key =  keyEnter! then
	campo = This.GetColumnName()
	CHOOSE CASE campo
		CASE "prodlineas_tipomaquina_disenyo"
			busqueda.titulo_ventana = "Búsqueda de Tipos de Máquina de Diseño"
			busqueda.consulta  = " SELECT codigo, descripcion "+&
										" FROM tipomaquina_disenyo "+&
										" WHERE empresa = '"+codigo_empresa+"' ORDER BY DESCRIPCION"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Descripción"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				this.object.prodlineas_tipomaquina_disenyo[this.GetRow()] 			= resultado.valores[1]
				this.object.tipomaquina_disenyo_descripcion[this.GetRow()]			= resultado.valores[2]		
			end if		
		CASE "prodlineas_seccion"
			busqueda.titulo_ventana = "Búsqueda de Secciones"
			busqueda.consulta  = " SELECT codigo, descripcion_abr, descripcion "+&
										" FROM prodsecciones "+&
										" WHERE empresa = '"+codigo_empresa+"' ORDER BY DESCRIPCION"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Abreviado"
			busqueda.titulos[3] = "Descripción"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				this.object.prodlineas_seccion[this.GetRow()] 			= resultado.valores[1]
				this.object.prodsecciones_descripcion_abr[this.GetRow()]			= resultado.valores[2]		
			end if			
		CASE "prodlineas_calendario"
			busqueda.titulo_ventana = "Búsqueda de Calendarios"
			busqueda.consulta  = " SELECT codigo, descripcion "+&
										" FROM prodcalendarios "+&
										"  ORDER BY DESCRIPCION"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Descripción"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				this.object.prodlineas_calendario[this.GetRow()] 			= resultado.valores[1]
				this.object.prodcalendarios_descripcion[this.GetRow()]			= resultado.valores[2]		
			end if			
	END CHOOSE
end if	
	
end event

event dw_1::itemchanged;call super::itemchanged;string resultado, resultado1

this.Accepttext()

CHOOSE CASE dwo.name
	CASE "prodlineas_tipomaquina_disenyo"
		SELECT descripcion
		INTO :resultado
		FROM tipomaquina_disenyo
		WHERE empresa = :codigo_empresa
		and tipomaquina_disenyo.codigo = :data;

		if SQLCA.sqlcode <> 100 then
			this.object.tipomaquina_disenyo_descripcion[Row] 		= resultado
		else
			dwo.Primary[row] = ''
			this.object.tipomaquina_disenyo_descripcion[Row] 		= ''
			return 2			
		end if
	CASE "prodlineas_seccion"
		SELECT descripcion_abr
		INTO :resultado
		FROM prodsecciones
		WHERE empresa = :codigo_empresa
		and prodsecciones.codigo = :data;

		if SQLCA.sqlcode <> 100 then
			this.object.prodsecciones_descripcion_abr[Row] 		= resultado
		else
			dwo.Primary[row] = ''
			this.object.prodsecciones_descripcion_abr[Row] 		= ''
			return 2			
		end if	
	CASE "prodlineas_calendario"
		SELECT descripcion
		INTO :resultado
		FROM prodcalendarios
		WHERE prodcalendarios.codigo = :data;

		if SQLCA.sqlcode <> 100 then
			this.object.prodcalendarios_descripcion[Row] 		= resultado
		else
			dwo.Primary[row] = ''
			this.object.prodcalendarios_descripcion[Row] 		= ''
			return 2			
		end if	
END CHOOSE

end event

event dw_1::clicked;call super::clicked;str_parametros lstr_param
long esta_abierta


CHOOSE CASE dwo.name

	CASE "p_seccion"
	esta_abierta = f_menu_ventana_esta_abierta("w_mant_secciones")
	//Abrimos la ventana si no está abierta ya. En caso contrario la mostramos
	if esta_abierta = -1 then
		if this.object.prodlineas_seccion[row] <> "" then
			lstr_param.s_argumentos[1]  = "w_mant_secciones"
			lstr_param.s_argumentos[2] = this.object.prodlineas_seccion[row]
			lstr_param.i_nargumentos = 2
			lstr_param.nombre_ventana = "wi_mant_prodlineas"
			lstr_param.resultado = ''
			Openwithparm(w_mant_secciones, lstr_param)
		else
			Openwithparm(w_mant_secciones, lstr_param)
		end if
	else
		ventanas_activas[esta_abierta].ventana.BringToTop = true
	end if
	
	CASE "p_calendario"
	esta_abierta = f_menu_ventana_esta_abierta("w_mant_calendarios")
	//Abrimos la ventana si no está abierta ya. En caso contrario la mostramos
	if esta_abierta = -1 then
		if this.object.prodlineas_calendario[row] <> "" then
			lstr_param.s_argumentos[1]  = "w_mant_calendarios"
			lstr_param.s_argumentos[2] = this.object.prodlineas_calendario[row]
			lstr_param.i_nargumentos = 2
			lstr_param.nombre_ventana = "wi_mant_prodlineas"
			lstr_param.resultado = ''
			Openwithparm(w_mant_calendarios, lstr_param)
		else
			Openwithparm(w_mant_calendarios, lstr_param)
		end if
	else
		ventanas_activas[esta_abierta].ventana.BringToTop = true
	end if
	
END CHOOSE


//
end event

type pb_borrar from wt_ventana_padre`pb_borrar within wi_mant_prodlineas
integer x = 3109
integer y = 120
end type

type pb_salir from wt_ventana_padre`pb_salir within wi_mant_prodlineas
integer x = 3419
integer y = 120
end type

type pb_grabar from wt_ventana_padre`pb_grabar within wi_mant_prodlineas
end type

type st_titulo from wt_ventana_padre`st_titulo within wi_mant_prodlineas
end type

type pb_nuevo from wt_ventana_padre`pb_nuevo within wi_mant_prodlineas
end type

event pb_nuevo::clicked;call super::clicked;if dw_1.rowcount() > 0 then
	dw_1.SetColumn(1)
	//dw_1.object.prodlineas_subcontratacion[1] = 'N'
	
end if
dw_2.reset()
dw_3.reset()
end event

type pb_cancelar from wt_ventana_padre`pb_cancelar within wi_mant_prodlineas
integer x = 3264
integer y = 120
end type

event pb_cancelar::clicked;call super::clicked;if estado = 1 then
	dw_2.retrieve(codigo_empresa,padre_codigo)	
	dw_3.retrieve(codigo_empresa,padre_codigo)	
	
end if
end event

type pb_buscar from wt_ventana_padre`pb_buscar within wi_mant_prodlineas
end type

event pb_buscar::clicked;string campo

campo = dw_1.GetColumnName()

padre_busqueda.filtro_es_codigo = false
choose case campo
	case "codigo"
		padre_busqueda.filtro_es_codigo = true
		padre_busqueda.consulta =  " SELECT prodlineas.codigo, prodlineas.codigo, prodlineas.descripcion "+&	
									" FROM prodlineas "+&
									" WHERE prodlineas.empresa = '"+codigo_empresa+"' "+&
									" ORDER BY CONVERT(INTEGER, prodlineas.codigo) desc"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Código"
		padre_busqueda.titulos[3] = "Descripción"	

	case "descripcion"
		padre_busqueda.consulta =  " SELECT prodlineas.codigo, prodlineas.descripcion "+&	
									" FROM prodlineas "+&
									" WHERE prodlineas.empresa = '"+codigo_empresa+"' "+&
									" ORDER BY prodlineas.descripcion asc"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Descripción"	
	case else
		padre_busqueda.filtro_es_codigo = true
		padre_busqueda.consulta =  " SELECT prodlineas.codigo, prodlineas.codigo, prodlineas.descripcion "+&	
									" FROM prodlineas "+&
									" WHERE prodlineas.empresa = '"+codigo_empresa+"' "+&
									" ORDER BY CONVERT(INTEGER, prodlineas.codigo) desc"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Código"
		padre_busqueda.titulos[3] = "Descripción"		
end choose


call super :: clicked

if padre_codigo <> "" then
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// AQUÍ PONDREMOS TODOS LOS DATAWINDOWS AUXILIARES
	dw_2.retrieve (codigo_empresa, dw_1.object.prodlineas_codigo[1])
	dw_3.retrieve (codigo_empresa, dw_1.object.prodlineas_codigo[1])
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
end if
end event

type dw_con_piezas_coleccion from u_dw_padre within wi_mant_prodlineas
integer x = 4293
integer y = 2360
integer width = 1280
integer height = 596
integer taborder = 70
boolean bringtotop = true
string dataobject = "dwtc_con_piezas_coleccion"
end type

type pb_anyade_trabajo from picturebutton within wi_mant_prodlineas
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

type pb_anyadir_perfil from picturebutton within wi_mant_prodlineas
integer x = 46
integer y = 3116
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

dw_2.object.prodlineas_perfil_color_prodlineas[fila_actual] = padre_codigo
dw_2.object.prodlineas_perfil_color_empresa[fila_actual] = codigo_empresa

dw_2.scrolltorow(fila_actual)
dw_2.SetColumn(1)
dw_2.Setfocus()


end event

type pb_borrar_perfil from picturebutton within wi_mant_prodlineas
integer x = 197
integer y = 3116
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

type dw_2 from u_dw within wi_mant_prodlineas
integer x = 23
integer y = 1080
integer width = 3566
integer height = 2204
integer taborder = 70
string dataobject = "dwtc_prodlineas_perfil"
boolean vscrollbar = true
end type

event clicked;call super::clicked;str_parametros lstr_param
long esta_abierta


CHOOSE CASE dwo.name

CASE "p_perfil"
esta_abierta = f_menu_ventana_esta_abierta("wtc_mant_perfil_color")
//Abrimos la ventana si no está abierta ya. En caso contrario la mostramos
if esta_abierta = -1 then
	if this.object.prodlineas_perfil_color_perfil_color[row] <> "" then
		lstr_param.s_argumentos[1] = this.object.prodlineas_perfil_color_perfil_color[row]
		lstr_param.i_nargumentos = 1
		lstr_param.nombre_ventana = "wi_mant_prodlineas"
		lstr_param.resultado = ''
		Openwithparm(wtc_mant_perfil_color, lstr_param)
	else
		Openwithparm(wtc_mant_perfil_color, lstr_param)
	end if
else
	ventanas_activas[esta_abierta].ventana.BringToTop = true
end if
END CHOOSE


end event

event itemchanged;call super::itemchanged;string resultado, resultado1, perfil_color, linea
long contador

this.Accepttext()

CHOOSE CASE dwo.name
	CASE "prodlineas_perfil_color_perfil_color"
		SELECT descripcion
		INTO :resultado
		FROM perfil_color
		WHERE empresa = :codigo_empresa
		and perfil_color.codigo = :data;

		if SQLCA.sqlcode <> 100 then
			this.object.perfil_color_descripcion[Row] 		= resultado
		else
			dwo.Primary[row] = ''
			this.object.perfil_color_descripcion[Row] 		= ''
			return 2			
		end if
		
		perfil_color = this.object.prodlineas_perfil_color_perfil_color[row]
		linea = dw_1.object.prodlineas_codigo[1]
		
		SELECT max(contador)
		INTO :contador
		FROM prodlineas_perfil_color
		WHERE empresa = :codigo_empresa
		and prodlineas =:linea
		and perfil_color = :perfil_color;
		
		if isnull(contador)  then
			this.object.prodlineas_perfil_color_contador[row] =  1	
		else
			this.object.prodlineas_perfil_color_contador[row] = contador + 1	
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
		CASE "prodlineas_perfil_color_perfil_color"
			busqueda.titulo_ventana = "Búsqueda de Perfiles"
			busqueda.consulta  = " SELECT codigo, descripcion "+&
										" FROM perfil_color "+&
										" WHERE empresa = '"+codigo_empresa+"' ORDER BY DESCRIPCION"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Descripción"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				this.object.prodlineas_perfil_color_perfil_color[this.GetRow()] 			= resultado.valores[1]
				this.object.perfil_color_descripcion[this.GetRow()]				 			= resultado.valores[2]		
			end if			
	END CHOOSE
end if	
	
end event

type dw_3 from u_dw within wi_mant_prodlineas
integer x = 2075
integer y = 272
integer width = 1513
integer height = 792
integer taborder = 80
boolean bringtotop = true
string dataobject = "dwtc_prodlinea_tipomaquina_disenyo"
boolean vscrollbar = true
end type

event clicked;call super::clicked;/*
str_parametros lstr_param
long esta_abierta


CHOOSE CASE dwo.name

CASE "p_perfil"
esta_abierta = f_menu_ventana_esta_abierta("wtc_mant_perfil_color")
//Abrimos la ventana si no está abierta ya. En caso contrario la mostramos
if esta_abierta = -1 then
	if this.object.prodlineas_perfil_color_perfil_color[row] <> "" then
		lstr_param.s_argumentos[1] = this.object.prodlineas_perfil_color_perfil_color[row]
		lstr_param.i_nargumentos = 1
		lstr_param.nombre_ventana = "wi_mant_prodlineas"
		lstr_param.resultado = ''
		Openwithparm(wtc_mant_perfil_color, lstr_param)
	else
		Openwithparm(wtc_mant_perfil_color, lstr_param)
	end if
else
	ventanas_activas[esta_abierta].ventana.BringToTop = true
end if
END CHOOSE

*/
end event

event itemchanged;call super::itemchanged;string resultado, resultado1

this.Accepttext()

CHOOSE CASE dwo.name
	CASE "prodlinea_tipomaquina_disenyo_tipomaquina_disenyo"
		SELECT descripcion
		INTO :resultado
		FROM tipomaquina_disenyo
		WHERE empresa = :codigo_empresa
		and tipomaquina_disenyo.codigo = :data;

		if SQLCA.sqlcode <> 100 then
			this.object.tipomaquina_disenyo_descripcion[Row] 		= resultado
		else
			dwo.Primary[row] = ''
			this.object.tipomaquina_disenyo.descripcion[Row] 		= ''
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
		CASE "prodlinea_tipomaquina_disenyo_tipomaquina_disenyo"
			busqueda.titulo_ventana = "Búsqueda de Tipos de Máquinas"
			busqueda.consulta  = " SELECT codigo, descripcion "+&
										" FROM tipomaquina_disenyo "+&
										" WHERE empresa = '"+codigo_empresa+"' ORDER BY DESCRIPCION"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Descripción"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				this.object.prodlinea_tipomaquina_disenyo_tipomaquina_disenyo[this.GetRow()] 			= resultado.valores[1]
				this.object.tipomaquina_disenyo_descripcion[this.GetRow()]				 			= resultado.valores[2]		
			end if			
	END CHOOSE
end if	
	
end event

type pb_anyadir_tipomaquina from picturebutton within wi_mant_prodlineas
integer x = 2094
integer y = 916
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

dw_3.object.prodlinea_tipomaquina_disenyo_prodlinea[fila_actual] = padre_codigo
dw_3.object.prodlinea_tipomaquina_disenyo_empresa[fila_actual] = codigo_empresa

dw_3.scrolltorow(fila_actual)
dw_3.SetColumn(1)
dw_3.Setfocus()


end event

type pb_borrar_tipomaquina from picturebutton within wi_mant_prodlineas
integer x = 2245
integer y = 916
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

