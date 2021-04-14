$PBExportHeader$wtc_mant_venclientes_email.srw
forward
global type wtc_mant_venclientes_email from wt_ventana_padre
end type
type dw_con_piezas_coleccion from u_dw_padre within wtc_mant_venclientes_email
end type
type pb_anyade_trabajo from picturebutton within wtc_mant_venclientes_email
end type
type pb_1 from picturebutton within wtc_mant_venclientes_email
end type
type pb_borrar_trabajo from picturebutton within wtc_mant_venclientes_email
end type
end forward

global type wtc_mant_venclientes_email from wt_ventana_padre
integer width = 2382
integer height = 1644
string title = "Mantenimiento de Tipos de Operaciones"
dw_con_piezas_coleccion dw_con_piezas_coleccion
pb_anyade_trabajo pb_anyade_trabajo
pb_1 pb_1
pb_borrar_trabajo pb_borrar_trabajo
end type
global wtc_mant_venclientes_email wtc_mant_venclientes_email

type variables

end variables

forward prototypes
public function integer f_guardar ()
end prototypes

public function integer f_guardar ();//SOBRESCRIBIMOS LA FUNCION DEL PADRE. NO LA LLMAMOS CON super::funcion()

long i
string campo, motivo
boolean falta_Campo, aceptado
string cod_inkcid, cod_inkcid2, inkcid, trabajo, dato
string v_coleccion
Int resultado

resultado = 1 //Todo ok si devolvemos 1

//param_colisiones.empresa = codigo_empresa
//param_colisiones.tabla = "venclientes_email"
//param_colisiones.campo = "codigo"
//param_colisiones.filtro = "venclientes_email.cliente = '"+cliente+"' "
//param_colisiones.buscar_huecos = true

/*---------------------------------------------------------------------------------------------------------------------------------
			   AQUÍ IRÁ EL CÓDIGO PARA COMPROBAR LOS CAMPOS OBLIGATORIOS.
---------------------------------------------------------------------------------------------------------------------------------*/

// Campos obligatorios dw_1 

dw_1.accepttext()
falta_campo = false
DO WHILE ( i <= dw_1.rowcount() AND NOT falta_campo )
	if IsNull(dw_1.object.venclientes_email_email[dw_1.getrow()]) or Trim(String(dw_1.object.venclientes_email_email[dw_1.getrow()])) = "" then
		  campo = "venclientes_email_email"
		  motivo = "Campo Obligatorio: Email. "
		  falta_campo = True
	end if	
	
	if IsNull(dw_1.object.venclientes_email_tipo[dw_1.getrow()]) or Trim(String(dw_1.object.venclientes_email_tipo[dw_1.getrow()])) = "" then
		  campo = "venclientes_email_tipo"
		  motivo = "Campo Obligatorio: Tipo de email. "
		  falta_campo = True
	end if

	if falta_campo then
	  MessageBox("Campo obligatorio: "+campo,motivo,Exclamation!, OK!,1)
	  dw_1.setfocus()
	  dw_1.SetColumn(campo)
	  return 0
	end if
	i++
loop

/*---------------------------------------------------------------------------------------------------------------------------------
			   					FIN DE COMPROBAR LOS CAMPOS OBLIGATORIOS.
---------------------------------------------------------------------------------------------------------------------------------*/

/*---------------------------------------------------------------------------------------------------------------------------------
			   					GRABACIÓN DW PRINCIPAL
---------------------------------------------------------------------------------------------------------------------------------*/
super::f_guardar()
// El primer campo del datawindow será el que reciba el código generado. 
// Por tanto, al crear el datawindow maestro debemos situar en primera posición dicho campo

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
dw_1.settransobject(sqlca)
return rtn
end function

on wtc_mant_venclientes_email.create
int iCurrent
call super::create
this.dw_con_piezas_coleccion=create dw_con_piezas_coleccion
this.pb_anyade_trabajo=create pb_anyade_trabajo
this.pb_1=create pb_1
this.pb_borrar_trabajo=create pb_borrar_trabajo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con_piezas_coleccion
this.Control[iCurrent+2]=this.pb_anyade_trabajo
this.Control[iCurrent+3]=this.pb_1
this.Control[iCurrent+4]=this.pb_borrar_trabajo
end on

on wtc_mant_venclientes_email.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_con_piezas_coleccion)
destroy(this.pb_anyade_trabajo)
destroy(this.pb_1)
destroy(this.pb_borrar_trabajo)
end on

event activate;call super::activate;wtc_mant_venclientes_email = ventanas_activas[id_ventana_activa].ventana

if permiso_ventana = 1 then
	//Solo lectura
	pb_grabar.visible = false
	pb_borrar.visible = false
end if
end event

event open;call super::open;str_parametros lstr_param
string nombre_cliente
//cerrar_sin_abrir = false
//
////PERMISOS NUEVOS
//String nombre_ventana, nombre_cliente 
//nombre_ventana = this.ClassName()
//SELECT P.permiso INTO :permiso_ventana FROM uti_permisos_ventana P INNER JOIN uti_ventana V ON P.ventana = V.codigo AND P.empresa = V.empresa WHERE P.empresa = :codigo_empresa AND V.nombre = :nombre_ventana AND P.usuario = :nombre_usuario;
//If permiso_ventana = 0 then
//	MESSAGEBOX("Atención. Consulte con el Administrador",nombre_usuario+", No tienes Acceso a este programa")
//	cerrar_sin_abrir = true
//elseif permiso_ventana = 1 then
//	//Solo lectura
//	pb_grabar.visible = false
//	pb_borrar.visible = false
//elseif permiso_ventana = 2 then
//	//OK acceso total
//	
//else
//	//Opción no contemplada -> Salir
//	MESSAGEBOX("Atención. Consulte con el Administrador",nombre_usuario+", No tienes Acceso a este programa")
//	cerrar_sin_abrir = true
//end if
//
//if cerrar_sin_abrir = true then
//	this.Post Event ue_cerrar_sin_abrir()
//else
//	
//	select nombre
//	into :st_titulo.text
//	from empresas
//	where empresa = :codigo_empresa;
//	
	// Si recibo el codigo lo visualizo
	lstr_param = Message.PowerObjectParm
	
	nombre_ventana_invoca = lstr_param.s_titulo_ventana
	IF lstr_param.i_nargumentos >= 1 THEN
		ventana_invoca = lstr_param.nombre_ventana
		if not isnull(lstr_param.s_argumentos[1]) and lstr_param.s_argumentos[1] <> "" then
			padre_codigo = lstr_param.s_argumentos[1]
			dw_1.retrieve (codigo_empresa, padre_codigo)
			estado = 1 // Modo edición
			mostrar_controles_edicion()
			dw_1.SetFocus()
			nombre_cliente = ""
			SELECT razon INTO :nombre_cliente FROM genter WHERE empresa = :codigo_empresa AND codigo = :padre_codigo AND tipoter = 'C' using sqlca;
			dw_1.object.t_cliente.text = nombre_cliente
		else
			MessageBox("Error", "La ventana no puede abrirse directamente. Hágalo desde el mantenimiento de clientes.")
			this.Post Event ue_cerrar_sin_abrir()
		end if
	else
		MessageBox("Error", "La ventana no puede abrirse directamente. Hágalo desde el mantenimiento de clientes.")
		this.Post Event ue_cerrar_sin_abrir()
	END IF
//end if
end event

type pb_imprimir from wt_ventana_padre`pb_imprimir within wtc_mant_venclientes_email
boolean visible = false
integer x = 187
end type

type p_logo from wt_ventana_padre`p_logo within wtc_mant_venclientes_email
integer x = 1847
end type

type dw_1 from wt_ventana_padre`dw_1 within wtc_mant_venclientes_email
integer width = 2327
integer height = 1188
string dataobject = "dwtc_venclientes_email"
boolean vscrollbar = true
boolean border = false
end type

event dw_1::clicked;call super::clicked;str_parametros lstr_param
long esta_abierta


CHOOSE CASE dwo.name

CASE "p_unidad"
esta_abierta = f_menu_ventana_esta_abierta("w_mant_comunimedida")
//Abrimos la ventana si no está abierta ya. En caso contrario la mostramos
if esta_abierta = -1 then
	if this.object.formula_unidad[row] <> "" then
		lstr_param.s_argumentos[1] = this.object.formula_unidad[row]
		lstr_param.i_nargumentos = 1
		lstr_param.nombre_ventana = "wi_mant_prodaplicaciones"
		lstr_param.resultado = ''
		Openwithparm(w_mant_comunimedida, lstr_param)
	else
		Openwithparm(w_mant_comunimedida, lstr_param)
	end if
else
	ventanas_activas[esta_abierta].ventana.BringToTop = true
end if
END CHOOSE
end event

event dw_1::itemchanged;call super::itemchanged;string resultado

this.Accepttext()

CHOOSE CASE dwo.name
	CASE "formula_unidad"
		SELECT descripcion 
		INTO :resultado 
		FROM comunimedida
		WHERE codigo = :data;

		if SQLCA.sqlcode <> 100 then
			this.object.comunimedida_descripcion[Row] 		= resultado
		else
			dwo.Primary[row] = ''
			this.object.comunimedida_descripcion[Row] 		= ''
			return 2			
		end if
END CHOOSE
end event

event dw_1::usr_keydown;string campo
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
		CASE "formula_unidad"
			busqueda.titulo_ventana = "Búsqueda de Unidades"
			busqueda.consulta  = " SELECT codigo, descripcion "+&
										" FROM comunimedida "+&
										" ORDER BY DESCRIPCION"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Descripción"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				this.object.formula_unidad[this.GetRow()] 	= resultado.valores[1]	
				this.object.comunimedida_descripcion[this.GetRow()]			= resultado.valores[2]		
			end if			
	END CHOOSE
end if	
end event

type pb_borrar from wt_ventana_padre`pb_borrar within wtc_mant_venclientes_email
integer x = 1893
end type

type pb_salir from wt_ventana_padre`pb_salir within wtc_mant_venclientes_email
integer x = 2203
end type

type pb_grabar from wt_ventana_padre`pb_grabar within wtc_mant_venclientes_email
integer x = 32
end type

type st_titulo from wt_ventana_padre`st_titulo within wtc_mant_venclientes_email
end type

type pb_nuevo from wt_ventana_padre`pb_nuevo within wtc_mant_venclientes_email
boolean visible = false
integer x = 942
integer y = 120
end type

event pb_nuevo::clicked;call super::clicked;if dw_1.rowcount() > 0 then
	dw_1.SetColumn(1)
end if

end event

type pb_cancelar from wt_ventana_padre`pb_cancelar within wtc_mant_venclientes_email
integer x = 2048
end type

event pb_cancelar::clicked;dw_1.retrieve (codigo_empresa, padre_codigo)
mostrar_controles_edicion()
estado = 1

dw_1.setfocus()
dw_1.setcolumn(2)

end event

type pb_buscar from wt_ventana_padre`pb_buscar within wtc_mant_venclientes_email
boolean visible = false
integer x = 1097
integer y = 120
end type

event pb_buscar::clicked;string campo

campo = dw_1.GetColumnName()

padre_busqueda.filtro_es_codigo = false
choose case campo
	case "codigo"
		padre_busqueda.filtro_es_codigo = true
		padre_busqueda.consulta =  " SELECT prodaplicaciones.codigo, prodaplicaciones.codigo, prodaplicaciones.resumido, prodaplicaciones.descripcion "+&	
									" FROM prodaplicaciones "+&
									" WHERE prodaplicaciones.empresa = '"+codigo_empresa+"' "+&
									" ORDER BY CONVERT(INTEGER, prodaplicaciones.codigo) desc"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Código"
		padre_busqueda.titulos[3] = "Resumido"
		padre_busqueda.titulos[4] = "Descripción"	

	case "descripcion"
		padre_busqueda.filtro_es_codigo = true
		padre_busqueda.consulta =  " SELECT prodaplicaciones.codigo, prodaplicaciones.resumido, prodaplicaciones.descripcion "+&	
									" FROM prodaplicaciones "+&
									" WHERE prodaplicaciones.empresa = '"+codigo_empresa+"' "+&
									" ORDER BY CONVERT(INTEGER, prodaplicaciones.codigo) desc"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Resumido"
		padre_busqueda.titulos[3] = "Descripción"	
	case else
		padre_busqueda.filtro_es_codigo = true
		padre_busqueda.consulta =  " SELECT prodaplicaciones.codigo, prodaplicaciones.codigo, prodaplicaciones.resumido, prodaplicaciones.descripcion "+&	
									" FROM prodaplicaciones "+&
									" WHERE prodaplicaciones.empresa = '"+codigo_empresa+"' "+&
									" ORDER BY CONVERT(INTEGER, prodaplicaciones.codigo) desc"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Código"
		padre_busqueda.titulos[3] = "Resumido"
		padre_busqueda.titulos[4] = "Descripción"	
end choose


call super :: clicked

if padre_codigo <> "" then
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// AQUÍ PONDREMOS TODOS LOS DATAWINDOWS AUXILIARES
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
end if
end event

type dw_con_piezas_coleccion from u_dw_padre within wtc_mant_venclientes_email
integer x = 4293
integer y = 2360
integer width = 1280
integer height = 596
integer taborder = 70
boolean bringtotop = true
string dataobject = "dwtc_con_piezas_coleccion"
end type

type pb_anyade_trabajo from picturebutton within wtc_mant_venclientes_email
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

type pb_1 from picturebutton within wtc_mant_venclientes_email
integer x = 50
integer y = 1312
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

event clicked;long fila_actual, nuevo_codigo, maximo_valor_dw
string codigo_actual

fila_actual = dw_1.InsertRow(0)

maximo_valor_dw = long(dw_1.Describe("Evaluate('Max(integer(venclientes_email_codigo))', 0)"))
if isnull(maximo_valor_dw) then maximo_valor_dw = 0
nuevo_codigo = maximo_valor_dw +1

dw_1.object.empresa[fila_actual] = codigo_empresa
dw_1.object.venclientes_email_cliente[fila_actual] = padre_codigo
dw_1.object.venclientes_email_codigo[fila_actual] = String(nuevo_codigo)

dw_1.scrolltorow(fila_actual)
dw_1.SetColumn(1)
dw_1.Setfocus()


end event

type pb_borrar_trabajo from picturebutton within wtc_mant_venclientes_email
integer x = 201
integer y = 1312
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
fila_actual = dw_1.getrow()
if fila_actual > 0 then
	if dw_1.DeleteRow(fila_actual) <> 1 then
		error_borrando = True
	else
		error_borrando = False
	end if
end if
end event

