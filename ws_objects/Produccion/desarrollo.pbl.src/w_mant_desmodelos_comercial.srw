$PBExportHeader$w_mant_desmodelos_comercial.srw
forward
global type w_mant_desmodelos_comercial from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within w_mant_desmodelos_comercial
end type
type cb_duplicarprueba from commandbutton within w_mant_desmodelos_comercial
end type
type cb_añadir from commandbutton within w_mant_desmodelos_comercial
end type
type cb_eliminar from commandbutton within w_mant_desmodelos_comercial
end type
type cb_grabar from commandbutton within w_mant_desmodelos_comercial
end type
type p_imagen from picture within w_mant_desmodelos_comercial
end type
type cb_añadirh from commandbutton within w_mant_desmodelos_comercial
end type
type cb_eliminarh from commandbutton within w_mant_desmodelos_comercial
end type
type cb_grabarh from commandbutton within w_mant_desmodelos_comercial
end type
type dw_historicomodelo from u_datawindow within w_mant_desmodelos_comercial
end type
type st_2 from statictext within w_mant_desmodelos_comercial
end type
type pb_imprimir_comercial from upb_imprimir within w_mant_desmodelos_comercial
end type
type cb_generar_pieza from commandbutton within w_mant_desmodelos_comercial
end type
type cb_generar_coleccion from commandbutton within w_mant_desmodelos_comercial
end type
type dw_piezas_coleccion from u_datawindow within w_mant_desmodelos_comercial
end type
type r_1 from rectangle within w_mant_desmodelos_comercial
end type
type cb_2 from commandbutton within w_mant_desmodelos_comercial
end type
type cb_proceso from commandbutton within w_mant_desmodelos_comercial
end type
type cb_fecha_coleccion from commandbutton within w_mant_desmodelos_comercial
end type
type cb_1 from commandbutton within w_mant_desmodelos_comercial
end type
type dw_ficha_comercial from datawindow within w_mant_desmodelos_comercial
end type
type cb_3 from commandbutton within w_mant_desmodelos_comercial
end type
type cb_4 from commandbutton within w_mant_desmodelos_comercial
end type
type cb_5 from commandbutton within w_mant_desmodelos_comercial
end type
type cb_6 from commandbutton within w_mant_desmodelos_comercial
end type
type dw_2 from u_datawindow within w_mant_desmodelos_comercial
end type
end forward

global type w_mant_desmodelos_comercial from wi_mvent_con_empresa
integer x = 0
integer y = 0
integer width = 5719
integer height = 3232
pb_calculadora pb_calculadora
cb_duplicarprueba cb_duplicarprueba
cb_añadir cb_añadir
cb_eliminar cb_eliminar
cb_grabar cb_grabar
p_imagen p_imagen
cb_añadirh cb_añadirh
cb_eliminarh cb_eliminarh
cb_grabarh cb_grabarh
dw_historicomodelo dw_historicomodelo
st_2 st_2
pb_imprimir_comercial pb_imprimir_comercial
cb_generar_pieza cb_generar_pieza
cb_generar_coleccion cb_generar_coleccion
dw_piezas_coleccion dw_piezas_coleccion
r_1 r_1
cb_2 cb_2
cb_proceso cb_proceso
cb_fecha_coleccion cb_fecha_coleccion
cb_1 cb_1
dw_ficha_comercial dw_ficha_comercial
cb_3 cb_3
cb_4 cb_4
cb_5 cb_5
cb_6 cb_6
dw_2 dw_2
end type
global w_mant_desmodelos_comercial w_mant_desmodelos_comercial

type variables

end variables

forward prototypes
public function boolean f_duplicar (integer tipo)
end prototypes

public function boolean f_duplicar (integer tipo);// Parametro
// Si recibe 1 ---> Generar una colección nueva con una pieza y un trabajo identicos al seleccionado.
// Si recibe 2 ---> Generar una pieza dentro de la misma coleccion con los datos del trabajo seleccionado.
// Si recibe 3 ---> 

boolean exito 
string ambiente, disenyador, estado, observaciones_col, comercial, comercial_trabajo
string pieza, funcion, observaciones_pz, laboratorio, pavrev
string serie, relieve, formato, pasta, acabado_lab, contratipo, aceptado, base_cliente, base, observaciones_trab 
datetime fecha_solicitud, fecha_necesidad, fecha_lab
long max_coleccion, trabajo, modelo
string v_coleccion, grafica

v_coleccion = 	dw_1.object.desmodelo_coleccion[dw_1.GetRow()]

exito = true
if sle_valor.text <> '' then
	/////////////////////////////////////////////////////////////////////////////////////////////////////
	// 										 Carga de los datos de la  colección										//
	/////////////////////////////////////////////////////////////////////////////////////////////////////
	
	select ambiente, disenyador, comercial, observaciones, grafica
	into :ambiente, :disenyador, :comercial, :observaciones_col, :grafica
	from descoleccionsol
	where empresa = :codigo_empresa
	and codigo = :v_coleccion;
	
	estado = "DISPONIBLE"
	
	if tipo = 1 then
		select max(convert(integer, codigo))
		into :max_coleccion
		from descoleccionsol
		where empresa = :codigo_empresa
		using SQLCA;
		
		max_coleccion = max_coleccion + 1
	
		insert into descoleccionsol (empresa, codigo, ambiente, disenyador, estado, observaciones, comercial, grafica)
		values (:codigo_empresa, :max_coleccion, :ambiente, :disenyador, :estado, :observaciones_col, :comercial, :grafica)
		using SQLCA;
		
		IF SQLCA.SQLCode = -1 THEN 
			exito = false
			messagebox("Error Inserción en la Tabla descoleccionsol", SQLCA.SQLErrText)
		END IF
	else
		max_coleccion = long(v_coleccion)
	end if
	/////////////////////////////////////////////////////////////////////////////////////////////////////
	//										 Fin Carga de los datos de la  colección										//
	/////////////////////////////////////////////////////////////////////////////////////////////////////

	/////////////////////////////////////////////////////////////////////////////////////////////////////
	// 										 Carga de los datos del modelo												//
	/////////////////////////////////////////////////////////////////////////////////////////////////////
	select funcion, observaciones, pavrev 
	into :funcion, :observaciones_pz, :pavrev
	from desmodelo
	where empresa = :codigo_empresa
	and modelo = :sle_valor.text;
	
	if tipo = 2 then setnull(funcion)

	modelo = f_colisiones2 (codigo_empresa,"desmodelo", "modelo","",true)
	
	IF modelo > 0 THEN
		insert into desmodelo ( empresa, coleccion, funcion, observaciones, modelo, pavrev, inkcid)
		values (:codigo_empresa, :max_coleccion, :funcion, :observaciones_pz, :modelo, :pavrev, 'N')
		using SQLCA;
		IF SQLCA.SQLCode = -1 THEN 
			exito = false
			messagebox("Error Inserción en la Tabla desmodelo", SQLCA.SQLErrText)
		END IF
	end if
	/////////////////////////////////////////////////////////////////////////////////////////////////////
	// 									Fin Carga de los datos del modelo												//
	/////////////////////////////////////////////////////////////////////////////////////////////////////
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////
	// 										 Carga de los datos del trabajo												//
	/////////////////////////////////////////////////////////////////////////////////////////////////////
	if tipo = 2 then
		setnull (formato)
		setnull (relieve)
		setnull (acabado_lab)
	else
		formato = dw_2.object.destrabajo2_formato[dw_2.Getrow()]
		relieve = dw_2.object.destrabajo2_relieve[dw_2.Getrow()]
		acabado_lab = dw_2.object.destrabajo2_acabado_lab[dw_2.Getrow()]
	end if
	trabajo = dw_2.object.destrabajo2_trabajo[dw_2.Getrow()]
	serie = dw_2.object.destrabajo2_serie[dw_2.Getrow()]
	pasta = dw_2.object.destrabajo2_pasta[dw_2.Getrow()]
	comercial_trabajo = dw_2.object.destrabajo2_comercial[dw_2.Getrow()]
	fecha_solicitud = datetime(today())
	setnull (fecha_necesidad)
	setnull (fecha_lab)
	contratipo = dw_2.object.destrabajo2_contratipo[dw_2.Getrow()]
	aceptado = dw_2.object.destrabajo2_aceptado[dw_2.Getrow()]
	base_cliente = dw_2.object.destrabajo2_base_cliente[dw_2.Getrow()]
//	observaciones_trab = dw_2.object.destrabajo2_observaciones[dw_2.Getrow()]
	laboratorio = dw_2.object.destrabajo2_laboratorio[dw_2.Getrow()]
	
	
	insert into destrabajo2 ( empresa, modelo, trabajo, serie, relieve, &
								formato, pasta, fecha_solicitud, fecha_necesidad, fecha_lab, acabado_lab, &
								contratipo, aceptado, base_cliente, base, observaciones, laboratorio, tecnico_dis, inkcid, comercial)
	values (:codigo_empresa, :modelo, 1, :serie, :relieve, &
		  :formato, :pasta, :fecha_solicitud, :fecha_necesidad, :fecha_lab, :acabado_lab, &
		  :contratipo, :aceptado, :base_cliente, :base, :observaciones_trab, :laboratorio, :disenyador, 'N', :comercial_trabajo)
	using SQLCA;
	IF SQLCA.SQLCode = -1 THEN 
		exito = false
		messagebox("Error Inserción en la Tabla destrabajo2", SQLCA.SQLErrText)
	END IF


	/////////////////////////////////////////////////////////////////////////////////////////////////////
	// 										 Fin Carga de los datos del trabajo											//
	/////////////////////////////////////////////////////////////////////////////////////////////////////
	
	if exito then
		sle_valor.text = string(modelo)
		commit using SQLCA;
	else
		MessageBox("SQL error", SQLCA.SQLErrText)
		rollback using SQLCA;
	end if
	
end if

return exito




end function

event ue_activa_claves;call super::ue_activa_claves;pb_calculadora.visible = TRUE
cb_duplicarprueba.enabled = false
cb_grabar.enabled = false
cb_eliminar.enabled = false
cb_añadir.enabled = false
cb_grabarh.enabled = false
cb_eliminarh.enabled = false
cb_añadirh.enabled = false

end event

event open;call super::open;integer permiso

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
dw_historicomodelo.SetTransObject(SQLCA)
dw_ficha_comercial.SetTransObject(SQLCA)
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

event ue_desactiva_claves;call super::ue_desactiva_claves;pb_calculadora.visible = FALSE
cb_duplicarprueba.enabled = true
cb_grabar.enabled = true
cb_eliminar.enabled = true
cb_añadir.enabled = true
cb_grabarh.enabled = true
cb_eliminarh.enabled = true
cb_añadirh.enabled = true

end event

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"desmodelo_empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"desmodelo_modelo",sle_valor.text)
dw_1.setitem(dw_1.getrow(),"desmodelo_activo",'N')
dw_1.setitem(dw_1.getrow(),"desmodelo_inkcid",'N')

end event

event ue_recuperar;string v_coleccion

// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         =  "desmodelo"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)
dw_2.reset()
dw_historicomodelo.reset()
dw_piezas_coleccion.RESET()

if dw_1.rowcount() > 0 then
	dw_2.Retrieve(codigo_empresa,sle_valor.Text)
	dw_2.scrolltorow(dw_2.rowcount())
	dw_2.SetColumn(3)
	dw_2.Setfocus()
	
	if not isnull(dw_1.object.desmodelo_coleccion[dw_1.getrow()]) then
		v_coleccion = dw_1.object.desmodelo_coleccion[dw_1.getrow()]
	end if
	dw_historicomodelo.Retrieve(codigo_empresa, v_coleccion)
	dw_piezas_coleccion.Retrieve(codigo_empresa, v_coleccion)
end if
///////////////////////////////////////////	 SACAMOS LA IMAGEN   ////////////////////////////////////////////////
p_imagen.PictureName = f_cargar_imagen_nuevo(sle_valor.text)
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CALL Super::ue_recuperar
end event

on w_mant_desmodelos_comercial.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.cb_duplicarprueba=create cb_duplicarprueba
this.cb_añadir=create cb_añadir
this.cb_eliminar=create cb_eliminar
this.cb_grabar=create cb_grabar
this.p_imagen=create p_imagen
this.cb_añadirh=create cb_añadirh
this.cb_eliminarh=create cb_eliminarh
this.cb_grabarh=create cb_grabarh
this.dw_historicomodelo=create dw_historicomodelo
this.st_2=create st_2
this.pb_imprimir_comercial=create pb_imprimir_comercial
this.cb_generar_pieza=create cb_generar_pieza
this.cb_generar_coleccion=create cb_generar_coleccion
this.dw_piezas_coleccion=create dw_piezas_coleccion
this.r_1=create r_1
this.cb_2=create cb_2
this.cb_proceso=create cb_proceso
this.cb_fecha_coleccion=create cb_fecha_coleccion
this.cb_1=create cb_1
this.dw_ficha_comercial=create dw_ficha_comercial
this.cb_3=create cb_3
this.cb_4=create cb_4
this.cb_5=create cb_5
this.cb_6=create cb_6
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.cb_duplicarprueba
this.Control[iCurrent+3]=this.cb_añadir
this.Control[iCurrent+4]=this.cb_eliminar
this.Control[iCurrent+5]=this.cb_grabar
this.Control[iCurrent+6]=this.p_imagen
this.Control[iCurrent+7]=this.cb_añadirh
this.Control[iCurrent+8]=this.cb_eliminarh
this.Control[iCurrent+9]=this.cb_grabarh
this.Control[iCurrent+10]=this.dw_historicomodelo
this.Control[iCurrent+11]=this.st_2
this.Control[iCurrent+12]=this.pb_imprimir_comercial
this.Control[iCurrent+13]=this.cb_generar_pieza
this.Control[iCurrent+14]=this.cb_generar_coleccion
this.Control[iCurrent+15]=this.dw_piezas_coleccion
this.Control[iCurrent+16]=this.r_1
this.Control[iCurrent+17]=this.cb_2
this.Control[iCurrent+18]=this.cb_proceso
this.Control[iCurrent+19]=this.cb_fecha_coleccion
this.Control[iCurrent+20]=this.cb_1
this.Control[iCurrent+21]=this.dw_ficha_comercial
this.Control[iCurrent+22]=this.cb_3
this.Control[iCurrent+23]=this.cb_4
this.Control[iCurrent+24]=this.cb_5
this.Control[iCurrent+25]=this.cb_6
this.Control[iCurrent+26]=this.dw_2
end on

on w_mant_desmodelos_comercial.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.cb_duplicarprueba)
destroy(this.cb_añadir)
destroy(this.cb_eliminar)
destroy(this.cb_grabar)
destroy(this.p_imagen)
destroy(this.cb_añadirh)
destroy(this.cb_eliminarh)
destroy(this.cb_grabarh)
destroy(this.dw_historicomodelo)
destroy(this.st_2)
destroy(this.pb_imprimir_comercial)
destroy(this.cb_generar_pieza)
destroy(this.cb_generar_coleccion)
destroy(this.dw_piezas_coleccion)
destroy(this.r_1)
destroy(this.cb_2)
destroy(this.cb_proceso)
destroy(this.cb_fecha_coleccion)
destroy(this.cb_1)
destroy(this.dw_ficha_comercial)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.cb_5)
destroy(this.cb_6)
destroy(this.dw_2)
end on

event closequery;call super::closequery;long total, li_rc

IF dw_1.DeletedCount()+dw_1.ModifiedCount() + &
	dw_historicomodelo.DeletedCount() + dw_historicomodelo.ModifiedCount() > 0 THEN
	li_rc = MessageBox("Pregunta", "¿Desea Guardar Cambios?", Question!, YesNoCancel!, 3)
	//User chose to up data and close window
	IF li_rc = 1 THEN
		cb_insertar.TriggerEvent(Clicked!)	
	
		RETURN 0
	//User chose to close window without updating
	ELSEIF li_rc = 2 THEN
		RETURN 0
	//User canceled
	ELSE
		RETURN 1
	END IF
ELSE
	// No changes to the data, window will just close
	RETURN 0
END IF


end event

event close;call super::close;
delete from uti_colisiones
where empresa = :codigo_empresa 
and tabla = "desmodelo"
and usuario = :nombre_usuario using sqlca;

if sqlca.sqlcode <> 0 then
	rollback using sqlca;
	messagebox("Error", "Error borrando colisiones")
else 
	commit using sqlca;
end if


end event

event activate;call super::activate;w_mant_desmodelos_comercial = ventanas_activas[id_ventana_activa].ventana
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within w_mant_desmodelos_comercial
integer x = 5
integer y = 208
integer width = 5623
integer height = 436
integer taborder = 20
string dataobject = "dw_mant_desmodelos_comercial"
end type

event dw_1::clicked;call super::clicked;str_parametros lstr_param

dw_1.enabled = false
if not(cb_insertar.enabled) then
//	dw_1.triggerevent(clicked!)
end if
dw_1.enabled = True

IF GetRow() <> 0  Then 	
	CHOOSE CASE f_objeto_datawindow(This)
		CASE "pb_coleccion"
			lstr_param.s_titulo_ventana = "Mantenimiento de Colecciones"
			lstr_param.s_argumentos[2]  = dw_1.object.desmodelo_coleccion[dw_1.getrow()]
			lstr_param.i_nargumentos    = 2
			OpenWithParm(w_mant_descoleccion, lstr_param)
		END CHOOSE
end if

If row=0 Then Return
IF ue_marca_linea = TRUE Then
  this.SetRow(row)
END IF
end event

event dw_1::itemchanged;call super::itemchanged;string  v_coleccion, v_disenyador, v_funcion, v_ambiente
string v_cliente, v_formato, v_tecnico, v_relieve, v_dessolicitud, comercial, tecnico_dis

v_coleccion = dw_1.object.desmodelo_coleccion[row]

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
		dw_2.Retrieve(codigo_empresa,sle_valor.Text)
			
		
	CASE "desmodelo_funcion"
		select descripcion
		into :v_funcion
		from art_grupo2
		where empresa = :codigo_empresa
		and codigo = :data;

		dw_1.object.art_grupo2_descripcion[row] = v_funcion
		
	CASE "desmodelo_tecnico_dis"
		select descripcion
		into :tecnico_dis
		from tecnico_dis
		where empresa = :codigo_empresa
		and codigo = :data;

		dw_1.object.tecnico_dis_descripcion[row] = tecnico_dis
		
	CASE "desmodelo_comercial"
		select descripcion
		into :comercial
		from comercial
		where empresa = :codigo_empresa
		and codigo = :data;

		dw_1.object.comercial_descripcion[row] = comercial
		
		
END CHOOSE



				

end event

event dw_1::key;bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE
CHOOSE CASE bus_campo
	CASE "desmodelo_coleccion"
		bus_titulo     = "AYUDA SELECCION DE COLECCIONES"
		bus_datawindow = "dw_ayuda_descoleccion"
		bus_filtro     = ""
			
	CASE "desmodelo_funcion"
		bus_titulo     = "AYUDA G2"
		bus_datawindow = "dw_ayuda_art_grupo2"
		bus_filtro     = "" 
	CASE "desmodelo_tecnico_dis"
		bus_titulo     = "AYUDA DISEÑADORES"
		bus_datawindow = "dw_ayuda_tecnico_dis"
		bus_filtro     = "" 
	CASE "desmodelo_comercial"
		bus_titulo     = "AYUDA COMERCIALES"
		bus_datawindow = "dw_ayuda_comercial"
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
		bus_titulo     = "AYUDA SELECCION DE COLECCIONES"
		bus_datawindow = "dw_ayuda_descoleccion"
		bus_filtro     = ""
				
	CASE "desmodelo_funcion"
		bus_titulo     = "AYUDA G2"
		bus_datawindow = "dw_ayuda_art_grupo2"
		bus_filtro     = "" 
	CASE "desmodelo_tecnico_dis"
		bus_titulo     = "AYUDA DISEÑADORES"
		bus_datawindow = "dw_ayuda_tecnicos_dis"
		bus_filtro     = "" 
	CASE "desmodelo_comercial"
		bus_titulo     = "AYUDA COMERCIALES"
		bus_datawindow = "dw_ayuda_comercial"
		bus_filtro     = "" 
		
		
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::rbuttondown
end event

type st_1 from wi_mvent_con_empresa`st_1 within w_mant_desmodelos_comercial
integer x = 59
integer y = 104
integer width = 270
string text = "Código:"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within w_mant_desmodelos_comercial
integer x = 4663
integer y = 92
integer width = 384
fontcharset fontcharset = ansi!
end type

event cb_insertar::clicked;string cod_inkcid, cod_inkcid2, trabajo, inkcid
string motivo, controles, campo
long numero, i, total
datawindow dato
boolean falta_campo, aceptado
string v_coleccion, v_sol, v_col
int total_aceptados

if dw_1.rowcount() > 0 then
	if dw_2.rowcount() = 0 then
		messagebox("Atención", "Debe existir al menos un trabajo.")
		dw_1.triggerevent(clicked!)
		return 0
	end if
	if dw_historicomodelo.rowcount() = 0 then
		messagebox("Atención", "Debe existir al menos un registro en el histórico.")
		dw_1.triggerevent(clicked!)
		return 0
	end if
end if	
select  coleccion
into :v_col
from desmodelo
where empresa = :codigo_empresa
and modelo = :sle_valor.text;

if dw_1.rowcount() > 0 and dw_historicomodelo.rowcount() > 0 then
	total_aceptados = 0
	for i = 1 to dw_historicomodelo.Rowcount()
		if dw_historicomodelo.object.deshistorico_estado[i] = "Aceptado" then
			total_aceptados ++
		end if			
	next
	if total_aceptados > 1 then
		messagebox ("Atención", "Sólo puede haber un elemento del histórico aceptado.")
		return 0
	end if
end if

if cb_insertar.enabled then
	dw_1.accepttext()
	if dw_1.rowcount() > 0 then
		if IsNull(dw_1.object.desmodelo_coleccion[1]) or Trim(String(dw_1.object.desmodelo_coleccion[1])) = "" then
			  campo = "desmodelo_coleccion"
			  motivo = "Campo Obligatorio: Colección. "
			  dato = dw_1
			  numero = 1
			  falta_campo = True
		
		elseif IsNull(dw_1.object.desmodelo_funcion[1]) or Trim(String(dw_1.object.desmodelo_funcion[1])) = "" then
			  campo = "desmodelo_funcion"
			  motivo = "Campo Obligatorio: Función. "
			  dato = dw_1
			  numero = 1
			  falta_campo = True
		
		elseif IsNull(dw_1.object.desmodelo_pavrev[1]) or Trim(String(dw_1.object.desmodelo_pavrev[1])) = "" then
			  campo = "desmodelo_pavrev"
			  motivo = "Campo Obligatorio: Pav / Rev. "
			  dato = dw_1
			  numero = 1
			  falta_campo = True
		elseif IsNull(dw_1.object.desmodelo_tecnico_dis[1]) or Trim(String(dw_1.object.desmodelo_tecnico_dis[1])) = "" then
			  campo = "desmodelo_tecnico_dis"
			  motivo = "Campo Obligatorio: Diseñador "
			  dato = dw_1
			  numero = 1
			  falta_campo = True
		elseif IsNull(dw_1.object.desmodelo_comercial[1]) or Trim(String(dw_1.object.desmodelo_comercial[1])) = "" then
			  campo = "desmodelo_comercial"
			  motivo = "Campo Obligatorio: Comercial "
			  dato = dw_1
			  numero = 1
			  falta_campo = True
			
		  
		end if	

		if falta_campo then
		  MessageBox(" "+campo+": Campo obligatorio",motivo,Exclamation!, OK!,1)
		  dato.setfocus()
		  dato.SetColumn(campo)
		  return 0
		end if
	end if
end if

if cb_insertar.enabled then
	dw_2.accepttext()
	IF dw_2.rowcount() > 0 THEN
		falta_campo = false
		i = 1
		DO WHILE ( i <= dw_2.rowcount() AND NOT falta_campo )

			cod_inkcid	= dw_2.object.destrabajo2_cod_inkcid[i]
			cod_inkcid2 = ''
			select codigo
			into :cod_inkcid2
			from desimagenestif
			where empresa = :codigo_empresa
			and codigo = :cod_inkcid;
			
			inkcid = dw_2.object.destrabajo2_inkcid [i]
			trabajo = string(dw_2.object.destrabajo2_trabajo[i])
			if cod_inkcid2 = '' and  inkcid = 'S' then
//				messagebox ("Error","No existe el código inkcid introducido en el trabajo "+trabajo+".   ", Exclamation!)
				dw_2.object.destrabajo2_cod_inkcid[i] = ''

				campo="destrabajo2_cod_inkcid"
				motivo  = "No existe el código inkcid introducido en el trabajo "+trabajo+".   "
				dato = dw_2
				numero = 1
				
				falta_campo = true
			end if
			
			IF IsNull(dw_2.object.destrabajo2_aceptado[i]) or Trim(String(dw_2.object.destrabajo2_aceptado[i]))="" THEN
				  campo="destrabajo2_aceptado"
				  motivo  = "Campo Obligatorio: Introduzca si está OK"
				  dato = dw_2
				  numero = 1
				  falta_campo = True
			ELSEIF IsNull(dw_2.object.destrabajo2_serie[i]) or Trim(String(dw_2.object.destrabajo2_serie[i]))="" THEN
				  campo="destrabajo2_serie"
				  motivo  = "Campo Obligatorio: Introduzca la Serie"
				  dato = dw_2
				  numero = 1
				  falta_campo = True
			ELSEIF IsNull(dw_2.object.destrabajo2_acabado_lab[i]) or Trim(String(dw_2.object.destrabajo2_acabado_lab[i]))="" THEN
				  campo="destrabajo2_acabado_lab"
				  motivo  = "Campo Obligatorio: Introduzca el acabado"
				  dato = dw_2
				  numero = 1
				  falta_campo = True
			ELSEIF IsNull(dw_2.object.destrabajo2_formato[i]) or Trim(String(dw_2.object.destrabajo2_formato[i]))="" THEN
				  campo="destrabajo2_formato"
				  motivo  = "Campo Obligatorio: Introduzca el formato"
				  dato = dw_2
				  numero = 1
				  falta_campo = True
			ELSEIF IsNull(dw_2.object.destrabajo2_pasta[i]) or Trim(String(dw_2.object.destrabajo2_pasta[i]))="" THEN
				  campo="destrabajo2_pasta"
				  motivo  = "Campo Obligatorio: Introduzca el la pasta"
				  dato = dw_2
				  numero = 1
				  falta_campo = True
			ELSEIF IsNull(dw_2.object.destrabajo2_relieve[i]) or Trim(String(dw_2.object.destrabajo2_relieve[i]))="" THEN
				  campo="destrabajo2_relieve"
				  motivo  = "Campo Obligatorio: Introduzca el relieve"
				  dato = dw_2
				  numero = 1
				  falta_campo = True
			ELSEIF IsNull(dw_2.object.destrabajo2_contratipo[i]) or Trim(String(dw_2.object.destrabajo2_contratipo[i]))="" THEN
				  campo="destrabajo2_contratipo"
				  motivo  = "Campo Obligatorio: Introduzca si es contratripo"
				  dato = dw_2
				  numero = 1
				  falta_campo = True
			ELSEIF IsNull(dw_2.object.destrabajo2_base_cliente[i]) or Trim(String(dw_2.object.destrabajo2_base_cliente[i]))="" THEN
				  campo="destrabajo2_base_cliente"
				  motivo  = "Campo Obligatorio: Introduzca si es base de cliente"
				  dato = dw_2
				  numero = 1
				  falta_campo = True
			ELSEIF IsNull(dw_2.object.destrabajo2_fecha_solicitud[i]) or Trim(String(dw_2.object.destrabajo2_fecha_solicitud[i]))="" THEN
				  campo="destrabajo2_fecha_solicitud"
				  motivo  = "Campo Obligatorio: Introduzca la fecha de solicitud"
				  dato = dw_2
				  numero = 1
				  falta_campo = True
			ELSEIF IsNull(dw_2.object.destrabajo2_fecha_necesidad[i]) or Trim(String(dw_2.object.destrabajo2_fecha_necesidad[i]))="" THEN
				  campo="destrabajo2_fecha_necesidad"
				  motivo  = "Campo Obligatorio: Introduzca la fecha de necesidad"
				  dato = dw_2
				  numero = 1
				  falta_campo = True
			ELSEIF IsNull(dw_2.object.destrabajo2_inkcid[i]) or Trim(String(dw_2.object.destrabajo2_inkcid[i]))="" THEN
				  campo="destrabajo2_inkcid"
				  motivo  = "Campo Obligatorio: Introduzca si es un modelo inkcid"
				  dato = dw_2
				  numero = 1
				  falta_campo = True
			ELSEIF IsNull(dw_2.object.destrabajo2_tecnico_dis[i]) or Trim(String(dw_2.object.destrabajo2_tecnico_dis[i]))="" THEN
				  campo="destrabajo2_tecnico_dis"
				  motivo  = "Campo Obligatorio: Introduzca el diseñador del trabajo"
				  dato = dw_2
				  numero = 1
				  falta_campo = True
			ELSEIF IsNull(dw_2.object.destrabajo2_comercial[i]) or Trim(String(dw_2.object.destrabajo2_comercial[i]))="" THEN
				  campo="destrabajo2_comercial"
				  motivo  = "Campo Obligatorio: Introduzca el comercial."
				  dato = dw_2
				  numero = 1
				  falta_campo = True
//			ELSEIF select codigo from imagestif where empresa = :codigo_empresa and codigo = 
				
				  
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
		rollback using sqlca;
	else
		commit using sqlca;
	end if
	// FIN TRABAJOS
	

	// HISTORICO
	if dw_1.rowcount() > 0 then
		v_coleccion = dw_1.object.desmodelo_coleccion[dw_1.getrow()]
		
		dw_historicomodelo.AcceptText()
		for i = 1 to dw_historicomodelo.Rowcount()
			if dw_historicomodelo.object.deshistorico_estado[i] = "Aceptado" &
				or dw_historicomodelo.object.deshistorico_estado[i] = "Rechazado" then
				if isnull(dw_historicomodelo.object.deshistorico_f_resp[i]) then
					messagebox("Aviso", 'No puede haber un registro del histórico ~n"Aceptado" o "Rechazado" sin fecha de respuesta')
					return 0
				end if
			end if
			if isnull(dw_historicomodelo.object.deshistorico_cliente[i])  &
				or dw_historicomodelo.object.deshistorico_cliente[i] = '' then
				messagebox("Aviso", 'Debe completar el campo cliente del histórico.')
				return 0
			end if
		next
		
		
		
		if dw_historicomodelo.update() = -1 then
			messagebox("Error", "Error grabando")
		else
			aceptado = false
			for i = 1 to dw_historicomodelo.Rowcount()
				if dw_historicomodelo.object.deshistorico_estado[i] = "Aceptado" then
					aceptado = true
				end if			
			next
			
			if aceptado then
				update descoleccionsol
				set estado = "NO DISPONIBLE"
				where empresa = :codigo_empresa
				and codigo = :v_coleccion;
			else
				update descoleccionsol
				set estado = "DISPONIBLE"
				where empresa = :codigo_empresa
				and codigo = :v_coleccion;
			end if			
		end if
	end if
// FIN HISTORICO

end if

if reg_insertado = true then
	delete from uti_colisiones
	where empresa = :codigo_empresa 
	and tabla = "desmodelo"
	and usuario = :nombre_usuario ;
end if

CALL Super::clicked


end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within w_mant_desmodelos_comercial
boolean visible = false
integer x = 3223
integer y = 92
integer width = 384
end type

event cb_borrar::clicked;
if dw_2.rowcount() > 0 then
	messagebox("Aviso", "Debe borrar los trabajos")
	return
end if

call super::clicked


end event

type sle_valor from wi_mvent_con_empresa`sle_valor within w_mant_desmodelos_comercial
integer x = 334
integer y = 100
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow  = "dw_ayuda_desmodelo"
ue_titulo      = "AYUDA SELECCION DE MODELOS DE DESARROLLO."
ue_filtro      = ""
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within w_mant_desmodelos_comercial
integer x = 5056
integer y = 92
integer width = 384
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within w_mant_desmodelos_comercial
integer taborder = 0
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within w_mant_desmodelos_comercial
integer x = 832
integer y = 92
integer height = 80
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within w_mant_desmodelos_comercial
integer width = 5650
integer textsize = -9
end type

type pb_calculadora from u_calculadora within w_mant_desmodelos_comercial
integer x = 599
integer y = 92
integer taborder = 0
end type

event clicked;long codigo

codigo = f_colisiones2 (codigo_empresa, "desmodelo", "modelo", "",true)

if codigo = 0  then
	messagebox("ERROR", "No se puede asignar un código.")
else
	sle_valor.text=string(codigo)
	dw_1.triggerEvent("clicked")
end if

this.TriggerEvent("ue_activa_claves")


end event

type cb_duplicarprueba from commandbutton within w_mant_desmodelos_comercial
integer x = 4690
integer y = 2400
integer width = 274
integer height = 88
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
string v_descripcion, sel, v_aplicacion, v_pantalla, v_formula, v_hilos, v_observaciones, v_operacion
boolean bien = true
datastore aplicaciones
string v_serie, v_descripcion_serie, v_aceptado, v_formato, v_formato_abreviado, v_pasta
string v_relieve, v_descripcion_relieve, v_contratipo, v_base_cli, v_acabado_lab, v_descripcion_acabado_lab
string v_base, v_descripcion_base, v_coste, inkcid, tecnico_dis, des_tecnico_dis
datetime f_solicitud, f_necesidad, f_fin, f_laboratorio



IF sle_valor.text <> '' THEN
	
	v_prueba = dw_2.object.destrabajo2_trabajo[dw_2.GetRow()] 
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
	inkcid = dw_2.object.destrabajo2_inkcid[dw_2.GetRow()] 
	tecnico_dis = dw_2.object.destrabajo2_tecnico_dis[dw_2.GetRow()] 
	des_tecnico_dis = dw_2.object.tecnico_dis_descripcion[dw_2.GetRow()] 
//	f_necesidad = dw_2.object.destrabajo2_fecha_necesidad[dw_2.GetRow()] 
	
	dw_2.scrolltorow(dw_2.InsertRow(0))
	dw_2.SetColumn(3)
	dw_2.Setfocus()
	
	fila_actual = dw_2.Getrow()
	total_filas = dw_2.RowCount()
	
	select max (trabajo) + 1
	into :nuevaprueba
	from destrabajo2
	where empresa = :codigo_empresa
	and modelo = :sle_valor.text;
	
	if nuevaprueba = 0 or isnull(nuevaprueba) then
		nuevaprueba = 1 
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
	dw_2.object.destrabajo2_laboratorio[fila_actual] = 'N'
	dw_2.object.destrabajo2_fecha_solicitud[fila_actual] = datetime(today())
	dw_2.object.destrabajo2_inkcid[fila_actual] = inkcid
	dw_2.object.destrabajo2_tecnico_dis[fila_actual] = tecnico_dis
	dw_2.object.tecnico_dis_descripcion[dw_2.GetRow()] = des_tecnico_dis
	
//	dw_2.object.destrabajo2_fecha_necesidad[fila_actual] = f_necesidad 
	
	CONNECT USING SQLCA;
	
	rtn = dw_2.Update()
	
	if rtn = 1 and SQLCA.SQLNRows > 0 then
		bien = true
	end if
	
	
	
	IF bien THEN
		COMMIT USING SQLCA;
	ELSE
		messagebox("Error", "No se pudo duplicar el trabajo")
		ROLLBACK USING SQLCA;
	END IF
END IF

end event

type cb_añadir from commandbutton within w_mant_desmodelos_comercial
integer x = 4965
integer y = 2400
integer width = 274
integer height = 88
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Añadir"
end type

event clicked;long fila_actual, nuevaprueba, indice

nuevaprueba = 0

IF sle_valor.text <> '' and dw_1.RowCount() > 0 THEN
	select max(trabajo)
	into :nuevaprueba
	from destrabajo2
	where empresa = :codigo_empresa
	and modelo = :sle_valor.text;
	
	
	if isnull(nuevaprueba) or nuevaprueba = 0 then
		nuevaprueba = 1
	else
		nuevaprueba ++
	end if
	
	if dw_2.rowcount() > 0 then
		if dw_2.object.destrabajo2_trabajo[dw_2.rowcount()] > nuevaprueba then
				nuevaprueba = dw_2.object.destrabajo2_trabajo[dw_2.rowcount()] + 1
		end if
	end if
END IF


if sle_valor.text <> '' then
	fila_actual = dw_2.InsertRow(0)
	
	dw_2.object.destrabajo2_trabajo[fila_actual] = nuevaprueba

	dw_2.scrolltorow(fila_actual)
	dw_2.SetColumn(3)
	dw_2.Setfocus()
	dw_2.object.destrabajo2_empresa[fila_actual] = codigo_empresa
	dw_2.object.destrabajo2_modelo[fila_actual] = sle_valor.text
	dw_2.object.destrabajo2_trabajo[fila_actual] = nuevaprueba
	dw_2.object.destrabajo2_aceptado[fila_actual] = 'N'
	dw_2.object.destrabajo2_fecha_solicitud[fila_actual] = datetime(today())
	dw_2.object.destrabajo2_laboratorio[fila_actual] = 'N'
	dw_2.object.destrabajo2_inkcid[fila_actual] = 'N'
	dw_2.object.destrabajo2_tecnico_dis[fila_actual] = ''
end if


end event

type cb_eliminar from commandbutton within w_mant_desmodelos_comercial
integer x = 5239
integer y = 2400
integer width = 274
integer height = 88
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Borrar"
end type

event clicked;
boolean error_borrando
long fila_actual, v_prueba

error_borrando = false
//if dw_desaplicacion.Rowcount() > 0 then
//	MessageBox("Atención", " No se puede borrar el trabajo porque tinen aplicaciones asociadas")
//else
	if dw_2.DeleteRow(fila_actual) <> 1 then
		error_borrando = True
	else
		error_borrando = False
	end if

//end if

end event

type cb_grabar from commandbutton within w_mant_desmodelos_comercial
boolean visible = false
integer x = 4251
integer y = 1916
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

type p_imagen from picture within w_mant_desmodelos_comercial
integer x = 3529
integer y = 2512
integer width = 1042
integer height = 456
boolean bringtotop = true
boolean originalsize = true
boolean focusrectangle = false
end type

type cb_añadirh from commandbutton within w_mant_desmodelos_comercial
integer x = 1125
integer y = 2972
integer width = 379
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Añadir"
end type

event clicked;long total_filas, fila_actual, nuevoregistro, indice
string v_solicitud, v_coleccion

dw_historicomodelo.scrolltorow(dw_historicomodelo.InsertRow(0))
dw_historicomodelo.SetColumn(1)
dw_historicomodelo.Setfocus()

fila_actual = dw_historicomodelo.Getrow()
total_filas = dw_historicomodelo.RowCount()

v_coleccion = dw_1.object.desmodelo_coleccion[dw_1.getrow()]

nuevoregistro = 1 
if total_filas > 0 then
	for indice = 1 to total_filas 
		if long(dw_historicomodelo.object.deshistorico_orden[indice]) >= nuevoregistro then
			nuevoregistro = long(dw_historicomodelo.object.deshistorico_orden[indice]) + 1
		end if
	next
end if

dw_historicomodelo.object.deshistorico_empresa[fila_actual] = codigo_empresa
dw_historicomodelo.object.deshistorico_coleccion[fila_actual] = v_coleccion
dw_historicomodelo.object.deshistorico_orden[fila_actual] = nuevoregistro
dw_historicomodelo.object.deshistorico_f_pres[fila_actual] = datetime(today())
dw_historicomodelo.object.deshistorico_estado[fila_actual] = 'Pendiente'


//if dw_historicomodelo.update() = -1 then
//	messagebox("Error", "Error grabando el registro en el historico")
//end if






end event

type cb_eliminarh from commandbutton within w_mant_desmodelos_comercial
integer x = 1509
integer y = 2972
integer width = 379
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Eliminar"
end type

event clicked;boolean error_borrando
long fila_actual, v_registro

if MessageBox("Atención", nombre_usuario+": ¿Seguro que quieres borrar el registro?", Question!, YesNo!, 2) = 1 then
	if dw_historicomodelo.Rowcount() > 0 then
		fila_actual = dw_historicomodelo.getrow()
		v_registro = dw_historicomodelo.object.deshistorico_orden[fila_actual]
		dw_historicomodelo.DeleteRow(fila_actual)

		error_borrando = False
	
//		if dw_historicomodelo.Update() = -1 then
//			error_borrando = True
//		end if
//		
//		if error_borrando then
//			rollback;
//		end if
//		
//		dw_historicomodelo.retrieve(codigo_empresa, sle_solicitud.text, sle_coleccion.text)
		
		if dw_historicomodelo.Rowcount() > 0 then
			dw_historicomodelo.scrolltoRow(fila_actual)
		end if
	end if
end if

end event

type cb_grabarh from commandbutton within w_mant_desmodelos_comercial
boolean visible = false
integer x = 2213
integer y = 2348
integer width = 379
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Grabar"
end type

event clicked;long i
boolean aceptado
string v_solicitud, v_coleccion

v_solicitud = dw_1.object.solicitud[dw_1.getrow()]
v_coleccion = dw_1.object.coleccion[dw_1.getrow()]

if dw_historicomodelo.update() = -1 then
	messagebox("Error", "Error grabando")
else
	aceptado = false
	for i = 1 to dw_historicomodelo.Rowcount()
		if dw_historicomodelo.object.deshistorico_estado[i] = "Aceptado" then
			aceptado = true
		end if			
	next
	
	if aceptado then
		update descoleccionsol
		set estado = "NO DISPONIBLE"
		where empresa = :codigo_empresa
		and solicitud = :v_solicitud
		and codigo = :v_coleccion;
	else
		update descoleccionsol
		set estado = "DISPONIBLE"
		where empresa = :codigo_empresa
		and solicitud = :v_solicitud
		and codigo = :v_coleccion;
	end if			
	
end if
end event

type dw_historicomodelo from u_datawindow within w_mant_desmodelos_comercial
integer x = 5
integer y = 2420
integer width = 1929
integer height = 552
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_historicomodelo"
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
//		select descripcion
//		into :v_cliente
//		from descliente
//		where empresa = :codigo_empresa
//		and codigo = :data;
//				
//		dw_historicomodelo.object.descliente_descripcion[row] = v_cliente
		
		dw_historicomodelo.object.genter_razon[row] = f_nombre_cliente (codigo_empresa, 'C', data)
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
		bus_datawindow = "dw_ayuda_clientes"
		bus_filtro     = "tipoter = 'C'" 	
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
		bus_datawindow = "dw_ayuda_clientes"
		bus_filtro     = "tipoter = 'C'" 	
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::key



end event

event ue_valores;call super::ue_valores;//ue_marca_linea = True
end event

type st_2 from statictext within w_mant_desmodelos_comercial
integer x = 3538
integer y = 2436
integer width = 402
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16777215
long backcolor = 0
string text = "Imagen"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type pb_imprimir_comercial from upb_imprimir within w_mant_desmodelos_comercial
integer x = 5481
integer y = 88
integer taborder = 0
boolean bringtotop = true
end type

event clicked;long trabajo

trabajo = dw_2.object.destrabajo2_trabajo[dw_2.Getrow()]

//messagebox("", sle_valor.text+"            "+ string(trabajo))

dw_ficha_comercial.retrieve(codigo_empresa, sle_valor.text, trabajo)
dw_ficha_comercial.object.p_1.filename = f_cargar_imagen_nuevo(sle_valor.text)

f_imprimir_datawindow(dw_ficha_comercial)



end event

type cb_generar_pieza from commandbutton within w_mant_desmodelos_comercial
integer x = 2085
integer y = 92
integer width = 512
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Generar Pieza"
end type

event clicked;if MessageBox("Atención", "¿Seguro que deseea generar una pieza nueva?", Exclamation!, YEsNo!, 2) = 1 then

	if dw_2.getrow() > 0 then
		if f_duplicar(2)  then
			// saldo de proceso de altas
			IF insercion = "S" Then
			 sle_valor.text = ""
			 sle_valor.TriggerEvent("modificado")
			 cb_borrar.enabled  =FALSE
			 dw_1.Reset()
			END IF
			insercion= "N"
			Parent.TriggerEvent("ue_desbloquear")
			Parent.TriggerEvent("ue_recuperar")
			cb_insertar.enabled = FALSE
			Parent.TriggerEvent("ue_activa_claves")
		  
			f_activar_campo(sle_valor)
		end if
	else
		messagebox("Atención", "Debe seleccionar el trabajo que se desee duplicar.")
	end if
end if
end event

type cb_generar_coleccion from commandbutton within w_mant_desmodelos_comercial
integer x = 1559
integer y = 92
integer width = 512
integer height = 92
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Generar Colección"
end type

event clicked;if MessageBox("Atención", "¿Seguro que deseea generar una colección nueva?", Exclamation!, YEsNo!, 2) = 1 then

	if dw_2.getrow() > 0 then
		if f_duplicar(1)  then
			// saldo de proceso de altas
			IF insercion = "S" Then
			 sle_valor.text = ""
			 sle_valor.TriggerEvent("modificado")
			 cb_borrar.enabled  =FALSE
			 dw_1.Reset()
			END IF
			insercion= "N"
			Parent.TriggerEvent("ue_desbloquear")
			Parent.TriggerEvent("ue_recuperar")
			cb_insertar.enabled = FALSE
			Parent.TriggerEvent("ue_activa_claves")
		  
			f_activar_campo(sle_valor)
		end if
	else
		messagebox("Atención", "Debe seleccionar el trabajo que se desee duplicar.")
	end if
end if
end event

type dw_piezas_coleccion from u_datawindow within w_mant_desmodelos_comercial
integer x = 1947
integer y = 2420
integer width = 1550
integer height = 552
integer taborder = 60
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

type r_1 from rectangle within w_mant_desmodelos_comercial
integer linethickness = 4
long fillcolor = 16777215
integer x = 3515
integer y = 2420
integer width = 1070
integer height = 556
end type

type cb_2 from commandbutton within w_mant_desmodelos_comercial
integer x = 3209
integer y = 92
integer width = 512
integer height = 92
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Pasar a Pieza"
end type

event clicked;string tecnico, descripcion, coleccion
long v_control, v_maximo
int retardo = 6, k
string v_control_inkcid, es_inkcid, trabajo_inkcid
dec prioridad
boolean correcto = true

if sle_valor.text <> '' then
	dw_1.triggerevent(clicked!)
	if dw_2.rowcount() > 0 then
		cb_duplicarprueba.triggerevent(clicked!)
	else
		cb_añadir.triggerevent(clicked!)
	end if		
	
	coleccion = dw_1.object.desmodelo_coleccion[1] 
	trabajo_inkcid = 'N'
	for k = 1 to dw_2.rowcount()
		if dw_2.object.destrabajo2_inkcid[k] = 'S' then
			trabajo_inkcid = 'S'
		end if
	next
	
	select tecnico_lab
	into :tecnico
	from desmodelo 
	where empresa = :codigo_empresa
	and coleccion = :coleccion
	and tecnico_lab is not null;
	
	if isnull(tecnico) or tecnico = '' then  // Si el trabajo no tiene tecnico asociado,
		select codigo, descripcion, control, control_inkcid, es_inkcid, prioridad
		into :tecnico, :descripcion, :v_control, :v_control_inkcid, :es_inkcid, :prioridad
		from tecnico_lab
		where ( control + control_inkcid ) * prioridad = ( select min ((control + control_inkcid) * prioridad ) &
																			from tecnico_lab &
																			where empresa = :codigo_empresa and activo = 'S')
		and empresa = :codigo_empresa
		and activo = 'S';

		update tecnico_lab 
		set control = :v_control + 1
		where empresa = :codigo_empresa
		and codigo = :tecnico using SQLCA;

		if SQLCA.SqlCode = -1 then correcto = false;
	
	end if
		
	update desmodelo 
	set tecnico_lab = :tecnico
	where empresa = :codigo_empresa
	and modelo = :sle_valor.text using SQLCA;

	if SQLCA.SqlCode = -1 then correcto = false;

	// Ponemos el técnico en la colección
	update descoleccionsol
	set tecnico_lab = :tecnico
	where empresa = :codigo_empresa
	and codigo = :coleccion using SQLCA;

   if SQLCA.SqlCode = -1 then correcto = false;

	if correcto then 
		commit using SQLCA;
	else 
		messagebox("Atención", "No se pudo asignar técnico de laboratorio")
		rollback using SQLCA;
	end if
	
	dw_2.object.destrabajo2_observaciones[dw_2.getrow()] = "PASAR A PIEZA."
	dw_2.object.destrabajo2_tecnico_lab[dw_2.getrow()] = tecnico
END IF	




end event

type cb_proceso from commandbutton within w_mant_desmodelos_comercial
boolean visible = false
integer x = 4393
integer y = 2508
integer width = 1216
integer height = 92
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Añadir Fecha a la colección"
end type

event clicked;datastore datos
string consulta_sql
string solicitud, coleccion, solicitud_ant, coleccion_ant 
long i
datetime fecha_fin

consulta_sql = " select C.solicitud, C.codigo, T.fecha_fin "+&
					" from destrabajo2 T, desmodelo M, descoleccionsol C "+&
					" where T.empresa = '"+codigo_empresa+"' "+&
					" and T.empresa = M.empresa  "+&
					" and T.modelo = M.modelo "+&
					" and M.empresa = C.empresa "+&
					" and M.solicitud = C.solicitud "+&
					" and M.coleccion = C.codigo "+&
					" and T.fecha_fin is not null "+&
					" order by C.solicitud, C.codigo, T.fecha_fin "				
					
f_cargar_cursor_nuevo ( consulta_sql , datos )

solicitud = ''
coleccion = ''
solicitud_ant = ''
coleccion_ant = ''

/* David: revisar porque da error al migrar al pb12 25-07-2011
for i = 1 to datos.rowcount()
	solicitud = datos.object.descoleccionsol_solicitud[i]
	coleccion = datos.object.descoleccionsol_codigo[i]
	fecha_fin = datos.object.destrabajo2_fecha_fin[i]
	
	if solicitud <> solicitud_ant or coleccion <> coleccion_ant then
		update descoleccionsol set fecha_coleccion = :fecha_fin
		where empresa = :codigo_empresa
		and solicitud = :solicitud
		and codigo = :coleccion using SQLCA;
		
		IF SQLCA.SQLCode = -1 THEN 
			rollback using sqlca;
		  	MessageBox("SQL error", SQLCA.SQLErrText+"   en la sol/col: "+solicitud+"/"+coleccion)
		else
			commit using sqlca;
		END IF		
		
	end if
	solicitud_ant = solicitud
	coleccion_ant = coleccion
	cb_proceso.text = string(i)	
	
	f_mensaje_proceso (" Regs:", i, datos.rowcount())
next
*/

destroy datos


					

end event

type cb_fecha_coleccion from commandbutton within w_mant_desmodelos_comercial
integer x = 2158
integer y = 236
integer width = 274
integer height = 64
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Fecha"
end type

event clicked;boolean grabar
datetime fecha, hoy
string coleccion

if dw_1.rowcount() > 0 then
	coleccion = dw_1.object.desmodelo_coleccion[dw_1.getrow()]
	
	select fecha_coleccion
	into :fecha
	from descoleccionsol
	where empresa = :codigo_empresa
	and codigo = :coleccion;
	
	grabar = true
	if not isnull (fecha) then
		if messagebox ("Aviso", "Esta colección ya tiene fecha, desea modificarla", Exclamation!, YesNo!, 2 ) = 2 then
			grabar = false
		end if
	end if
	
	if grabar then
		hoy = datetime(today())
		update descoleccionsol set fecha_coleccion = :hoy
		where empresa = :codigo_empresa
		and codigo = :coleccion using sqlca;
		
		if SQLCA.SQLCode = -1 then
			MessageBox("SQL error", SQLCA.SQLErrText)
			Rollback using sqlca;
		else
			dw_1.object.descoleccionsol_fecha_coleccion[dw_1.getrow()] = hoy
			commit using sqlca;
		end if
	end if		
end if



end event

type cb_1 from commandbutton within w_mant_desmodelos_comercial
boolean visible = false
integer x = 4393
integer y = 2608
integer width = 1230
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Pasar el diseñador de la colección al trabajo"
end type

event clicked;datastore datos
string sel, modelo, disenyador
long i

sel = " select desmodelo.empresa, desmodelo.modelo, descoleccionsol.disenyador "+&
		" from descoleccionsol, desmodelo "+&
		" where desmodelo.empresa = descoleccionsol.empresa "+&
		" and desmodelo.solicitud = descoleccionsol.solicitud "+&
		" and desmodelo.coleccion = descoleccionsol.codigo "
		
f_cargar_cursor_nuevo (sel, datos)

for i = 1 to datos.rowcount()
	modelo = datos.object.desmodelo_modelo[i]
	disenyador = datos.object.descoleccionsol_disenyador[i]
	
	update destrabajo2 
	set tecnico_dis = :disenyador
	where modelo = :modelo;
	
	f_mensaje_proceso ("", i , datos.rowcount())
next

update destrabajo2 set inkcid = 'N'

commit;
end event

type dw_ficha_comercial from datawindow within w_mant_desmodelos_comercial
boolean visible = false
integer x = 1211
integer y = 944
integer width = 1371
integer height = 624
integer taborder = 70
string dataobject = "dw_report_solicitud2"
boolean livescroll = true
end type

type cb_3 from commandbutton within w_mant_desmodelos_comercial
boolean visible = false
integer x = 4393
integer y = 2708
integer width = 1230
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Pasar el comercial de la serie al trabajo"
end type

event clicked;datastore datos
string sel, modelo, comercial
long i
dec trabajo

sel = " select destrabajo2.modelo, destrabajo2.trabajo, desserie.comercial "+&
		" from destrabajo2, desserie "+&
		" where destrabajo2.empresa = desserie.empresa "+&
		" and destrabajo2.serie = desserie.codigo "

		
f_cargar_cursor_nuevo (sel, datos)

for i = 1 to datos.rowcount()
	modelo = datos.object.destrabajo2_modelo[i]
	trabajo = datos.object.destrabajo2_trabajo[i]
	comercial = datos.object.desserie_comercial[i]
	
	update destrabajo2 
	set comercial = :comercial
	where empresa = :codigo_empresa
	and	modelo = :modelo
	and 	trabajo = :trabajo;
	
	f_mensaje_proceso ("", i , datos.rowcount())
next

commit;


destroy datos
end event

type cb_4 from commandbutton within w_mant_desmodelos_comercial
boolean visible = false
integer x = 3959
integer y = 2808
integer width = 1659
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Pasar el diseñador y el técnico de la colección al trabajo"
end type

event clicked;datastore datos
string sel, modelo, disenyador, tecnico
long i

sel = " select desmodelo.empresa, desmodelo.modelo, descoleccionsol.disenyador, desmodelo.tecnico_lab "+&
		" from descoleccionsol, desmodelo "+&
		" where desmodelo.empresa = descoleccionsol.empresa "+&
		" and desmodelo.coleccion = descoleccionsol.codigo "
		
f_cargar_cursor_nuevo (sel, datos)

for i = 1 to datos.rowcount()
	modelo = datos.object.desmodelo_modelo[i]
	disenyador = datos.object.descoleccionsol_disenyador[i]
	tecnico = datos.object.desmodelo_tecnico_lab[i]
	
	update destrabajo2 
	set tecnico_dis = :disenyador
	where modelo = :modelo
	and (tecnico_dis = '' or tecnico_dis is null);
	
	update destrabajo2 
	set tecnico_lab = :tecnico
	where modelo = :modelo
	and laboratorio = 'S';


	f_mensaje_proceso ("", i , datos.rowcount())
next

update destrabajo2 set inkcid = 'N'

commit;
end event

type cb_5 from commandbutton within w_mant_desmodelos_comercial
boolean visible = false
integer x = 4288
integer y = 2900
integer width = 1230
integer height = 92
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Pasar el técnico a la colección"
end type

event clicked;datastore datos
string sel, tecnico_lab, coleccion
long i
dec trabajo

sel = " select tecnico_lab, coleccion "+&
		" from desmodelo where empresa = '1'"

		
f_cargar_cursor_nuevo (sel, datos)

for i = 1 to datos.rowcount()
	tecnico_lab = datos.object.tecnico_lab[i]
	coleccion = datos.object.coleccion[i]
	
	update descoleccionsol
	set tecnico_lab = :tecnico_lab
	where empresa = '1'
	and 	codigo = :coleccion;
	
	f_mensaje_proceso ("", i , datos.rowcount())
next

commit;


destroy datos
end event

type cb_6 from commandbutton within w_mant_desmodelos_comercial
boolean visible = false
integer x = 3447
integer y = 2252
integer width = 1659
integer height = 92
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Pasar el diseñador y el diseñador de la colección al modelo"
end type

event clicked;datastore datos
string sel, modelo, disenyador, comercial
long i

sel = " select desmodelo.empresa, desmodelo.modelo, descoleccionsol.disenyador, descoleccionsol.comercial "+&
		" from descoleccionsol, desmodelo "+&
		" where desmodelo.empresa = descoleccionsol.empresa "+&
		" and desmodelo.coleccion = descoleccionsol.codigo "
		
f_cargar_cursor_nuevo (sel, datos)

for i = 1 to datos.rowcount()
	modelo = datos.object.desmodelo_modelo[i]
	disenyador = datos.object.descoleccionsol_disenyador[i]
	comercial = datos.object.descoleccionsol_comercial[i]
	
	update desmodelo
	set tecnico_dis = :disenyador, comercial = :comercial
	where modelo = :modelo;
	
	f_mensaje_proceso ("", i , datos.rowcount())
next



commit;
end event

type dw_2 from u_datawindow within w_mant_desmodelos_comercial
integer x = 5
integer y = 656
integer width = 5623
integer height = 1736
integer taborder = 40
string dataobject = "dw_mant_trabajos_comercial"
boolean vscrollbar = true
boolean livescroll = false
end type

event clicked;str_parametros lstr_param

dw_1.enabled = false
if not(cb_insertar.enabled) then
	dw_1.triggerevent(clicked!)
end if
dw_1.enabled = True

IF GetRow() <> 0  Then 	
//	CHOOSE CASE f_objeto_datawindow(This)
	CHOOSE CASE dwo.name
		CASE "pb_serie"
			lstr_param.s_argumentos[1]  = "w_mant_desserie"
			lstr_param.s_argumentos[2]  = dw_2.object.destrabajo2_serie[dw_2.getrow()]
			lstr_param.i_nargumentos    = 2
			OpenWithParm(w_mant_desserie, lstr_param)
		END CHOOSE
end if

If row=0 Then Return

IF ue_marca_linea = TRUE and row > 0 Then
  this.SetRow(row)
END IF


end event

event itemchanged;string serie, formato, relieve, tecnico_dis, acabado_lab, comercial
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

IF dwo.Name = "destrabajo2_acabado_lab" THEN
	select descripcion
	into :acabado_lab
	from tipoacabado_lab
	where empresa = :codigo_empresa
	and codigo = :data;
	dw_2.object.tipoacabado_lab_descripcion[row] = acabado_lab
END IF


end event

event rbuttondown;Integer registros
string codigo_inkcid

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
	CASE "destrabajo2_tecnico_dis"
		bus_titulo     = "AYUDA DISEÑADORES"
		bus_datawindow = "dw_ayuda_tecnicos_dis"
		bus_filtro     = "" 
	CASE "destrabajo2_comercial"
		bus_titulo     = "AYUDA COMERCIALES"
		bus_datawindow = "dw_ayuda_comercial"
		bus_filtro     = "" 
	CASE "destrabajo2_acabado_lab"
		bus_titulo     = "AYUDA ACABADO LABORATORIO"
		bus_datawindow = "dw_ayuda_tipoacabado_lab"
		bus_filtro     = "" 		
	CASE "destrabajo2_cod_inkcid"
		if messagebox("Pregunta", "Desea generar un código INKCID",     Question!, YesNo!, 2) = 1 then
			connect using SQLCA;
			Select count(*) 
			Into   :registros
			From   desimagenestif	
			Where  empresa = :codigo_empresa;
			IF registros=0 THEN
				codigo_inkcid = "1"
			ELSE
				Select max(convert(int,codigo)+1)
				Into   :codigo_inkcid
				From   desimagenestif
				Where  empresa = :codigo_empresa;
			END IF
			
			insert into desimagenestif (empresa, codigo, modelo)
			values (:codigo_empresa, :codigo_inkcid, :sle_valor.text);
			
			dw_2.object.destrabajo2_cod_inkcid[row] = codigo_inkcid
			if SQLCA.SQLCode = 0 then
				commit using SQLCA;
			else
				rollback using SQLCA;
			end if
		end if
		
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
	CASE "destrabajo2_tecnico_dis"
		bus_titulo     = "AYUDA DISEÑADORES"
		bus_datawindow = "dw_ayuda_tecnicos_dis"
		bus_filtro     = "" 
	CASE "destrabajo2_comercial"
		bus_titulo     = "AYUDA COMERCIALES"
		bus_datawindow = "dw_ayuda_comercial"
		bus_filtro     = "" 
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

