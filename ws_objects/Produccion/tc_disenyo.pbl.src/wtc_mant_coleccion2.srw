$PBExportHeader$wtc_mant_coleccion2.srw
forward
global type wtc_mant_coleccion2 from wt_ventana_padre
end type
type pb_anyade_historico from picturebutton within wtc_mant_coleccion2
end type
type pb_borrar_historico from picturebutton within wtc_mant_coleccion2
end type
type dw_estilos from datawindow within wtc_mant_coleccion2
end type
type pb_2 from picturebutton within wtc_mant_coleccion2
end type
type pb_archivos_modelo from picturebutton within wtc_mant_coleccion2
end type
type dw_historicomodelo from u_dw_padre within wtc_mant_coleccion2
end type
end forward

global type wtc_mant_coleccion2 from wt_ventana_padre
integer width = 5271
integer height = 2140
string title = "Mantenimiento de colecciones"
pb_anyade_historico pb_anyade_historico
pb_borrar_historico pb_borrar_historico
dw_estilos dw_estilos
pb_2 pb_2
pb_archivos_modelo pb_archivos_modelo
dw_historicomodelo dw_historicomodelo
end type
global wtc_mant_coleccion2 wtc_mant_coleccion2

type variables

end variables

forward prototypes
public function integer f_guardar ()
public function integer f_borrar ()
public function boolean hay_cambios ()
public subroutine devolucion_codigo ()
public function boolean f_post_asignar_codigo_padre ()
end prototypes

public function integer f_guardar ();//LLMAMOS CON super::funcion() al padre para continuar la ejecución del guardado

string campo, motivo, estilo
boolean falta_Campo
Int resultado, i, estado_coleccion

resultado = 1 //Todo ok si devolvemos 1

param_colisiones.empresa = codigo_empresa
param_colisiones.tabla = "descoleccionsol"
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
	if IsNull(dw_1.object.disenyador[dw_1.getrow()]) or Trim(String(dw_1.object.disenyador[dw_1.getrow()])) = "" then
		  campo = "disenyador"
		  motivo = "Campo Obligatorio: Disenyador. "
		  falta_campo = True
	elseif IsNull(dw_1.object.descoleccionsol_comercial[dw_1.getrow()]) or Trim(String(dw_1.object.descoleccionsol_comercial[dw_1.getrow()])) = "" then
		  campo = "descoleccionsol_comercial"
		  motivo = "Campo Obligatorio: Comercial. "
		  falta_campo = True
	elseif IsNull(dw_1.object.descoleccionsol_grafica[dw_1.getrow()]) or Trim(String(dw_1.object.descoleccionsol_grafica[dw_1.getrow()])) = "" then
		  campo = "descoleccionsol_grafica"
		  motivo = "Campo Obligatorio: Gráfica. "
		  falta_campo = True
	elseif IsNull(dw_1.object.ambiente[dw_1.getrow()]) or Trim(String(dw_1.object.ambiente[dw_1.getrow()])) = "" then
		  campo = "ambiente"
		  motivo = "Campo Obligatorio: Ambiente. "
		  falta_campo = True
	elseif IsNull(dw_1.object.descoleccionsol_grupo[dw_1.getrow()]) or Trim(String(dw_1.object.descoleccionsol_grupo[dw_1.getrow()])) = "" then
		  campo = "descoleccionsol_grupo"
		  motivo = "Campo Obligatorio: Grupo. "
		  falta_campo = True
	end if
	if falta_campo then
	  MessageBox("Campo obligatorio: "+campo,motivo,Exclamation!, OK!,1)
	  dw_1.setfocus()
	  dw_1.SetColumn(campo)
	  return 0
	end if
end if


// HISTORICO

//En caso de no poner histórico se supone tencer (YA NO - Programa expo)
if dw_historicomodelo.RowCount() < 1 then
	messagebox("Aviso", 'Debe existir al menos un registro en el histórico')
	return 0
end if


estado_coleccion = 1 //Disponible (Casos rechazado, pendiente o tencer)
if dw_historicomodelo.rowcount() > 0 then
	dw_historicomodelo.AcceptText()
	for i = 1 to dw_historicomodelo.Rowcount()
		//Comprobación Parámetros
		if dw_historicomodelo.object.deshistorico_estado[i] = "Aceptado" &
		or dw_historicomodelo.object.deshistorico_estado[i] = "Rechazado" &
		or dw_historicomodelo.object.deshistorico_estado[i] = "Reservado" then
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
		
		//Campo estado de la colección
		if dw_historicomodelo.object.deshistorico_estado[i] = "Aceptado" then 
			estado_coleccion = 3 //Aceptado
		elseif dw_historicomodelo.object.deshistorico_estado[i] = "Reservado" and estado_coleccion <> 3 then
			estado_coleccion = 2 //Reservado
		end if
		
		if IsNull(dw_historicomodelo.object.deshistorico_comercial[i]) or Trim(String(dw_historicomodelo.object.deshistorico_comercial[i])) = "" then
		  campo = "deshistorico_comercial"
		  motivo = "Campo Obligatorio: Comercial. "
		  falta_campo = True
		end if
		if falta_campo then
		  MessageBox("Campo obligatorio: "+campo,motivo,Exclamation!, OK!,1)
		  dw_historicomodelo.setfocus()
		  dw_historicomodelo.Setrow(i)
		  dw_historicomodelo.SetColumn(campo)
		  return 0
		end if
		
	next
end if
// FIN HISTORICO

//ESTADO COLECCIÓN

CHOOSE CASE estado_coleccion
	CASE 1 
		dw_1.object.estado[dw_1.getrow()] = "Libre"
	CASE 2
		dw_1.object.estado[dw_1.getrow()] = "Reservado"
	CASE 3
		dw_1.object.estado[dw_1.getrow()] = "Aceptado"
END CHOOSE

//FIN ESTADO COLECCIÓN


rtn = super::f_guardar()

/* Datawindows auxiliares */

dw_historicomodelo.SetTransObject (trans_ts)
if rtn = 1 then	
	rtn = dw_historicomodelo.update()
end if

//ESTILOS
if rtn = 1 then
	DELETE FROM coleccion_estilo WHERE empresa = :codigo_empresa AND coleccion = :padre_codigo USING trans_Ts;
	if trans_Ts.SqlCode = -1 then rtn = -1;
	i = 1
	Do while i <= dw_estilos.rowcount() AND rtn = 1 
		estilo = dw_estilos.object.estilo_codigo[i]
		if dw_estilos.object.seleccionado[i] = 1 then
			INSERT INTO coleccion_estilo (empresa, coleccion, estilo) VALUES (:codigo_empresa, :padre_codigo, :estilo) USING trans_Ts;
			if trans_Ts.SqlCode = -1 then rtn = -1;
		end if
		i++
	Loop	
	if rtn <> 1 then
		MessageBox("Error","Se ha producido un error al insertar los estilos de la colección")
	end if
end if

IF rtn = 1 THEN
	
	COMMIT USING trans_Ts;
	mostrar_controles_edicion()

	dw_1.setfocus()
	dw_1.setcolumn(2)
ELSE
	ROLLBACK USING trans_Ts;
END IF

estado = 1 // Modo edición
dw_historicomodelo.SetTransObject (SQLCA)

return rtn
end function

public function integer f_borrar ();Long total, total2

//Comprobaciones previas

padre_codigo = dw_1.object.#1[dw_1.GetRow()]
total = 0
total2 = 0

select count(*) 
into :total
from desmodelo
where empresa = :codigo_empresa
and coleccion = :padre_codigo using trans_ts;

select count(*) 
into :total2
from modelo
where empresa = :codigo_empresa
and coleccion = :padre_codigo using trans_ts;

if total + total2 > 0 then
	messagebox("Aviso", "No se puede borrar la coleccion porque tiene piezas asociadas")
	return -1
end if

total = 0
total2 = 0

select count(*) 
into :total
from coleccion_archivo
where empresa = :codigo_empresa
and coleccion = :padre_codigo using trans_ts;

select count(*) 
into :total2
from coleccion_sistema_archivos
where empresa = :codigo_empresa
and coleccion = :padre_codigo using trans_ts;

if total + total2 > 0 then
	messagebox("Aviso", "No se puede borrar la coleccion porque tiene ficheros asociados")
	return -1
end if

delete from deshistorico 
where empresa = :codigo_empresa 
and coleccion = :padre_codigo 
using trans_ts;

IF trans_ts.SQLCode <> 0 THEN         
	MessageBox("SQL error", trans_Ts.SQLErrText)
	rtn = -1
	ROLLBACK USING trans_Ts;

	dw_1.object.#1[1] = padre_codigo
	pb_cancelar.triggerevent(Clicked!)
	
ELSE
	rtn = super::f_borrar()
END IF

return rtn
end function

public function boolean hay_cambios ();Boolean resultado
resultado = false

dw_1.accepttext() //Necesario para que se detecten los cambios en el campo en el que se tiene el foco

if dw_1.DeletedCount() + dw_1.ModifiedCount() > 0 or dw_historicomodelo.DeletedCount() + dw_historicomodelo.ModifiedCount() > 0 then
	resultado = true
end if

return resultado
end function

public subroutine devolucion_codigo ();
end subroutine

public function boolean f_post_asignar_codigo_padre ();int i

for i = 1 To dw_historicomodelo.rowcount() 
	dw_historicomodelo.object.deshistorico_coleccion[i] = padre_codigo
Next	

return true
end function

on wtc_mant_coleccion2.create
int iCurrent
call super::create
this.pb_anyade_historico=create pb_anyade_historico
this.pb_borrar_historico=create pb_borrar_historico
this.dw_estilos=create dw_estilos
this.pb_2=create pb_2
this.pb_archivos_modelo=create pb_archivos_modelo
this.dw_historicomodelo=create dw_historicomodelo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_anyade_historico
this.Control[iCurrent+2]=this.pb_borrar_historico
this.Control[iCurrent+3]=this.dw_estilos
this.Control[iCurrent+4]=this.pb_2
this.Control[iCurrent+5]=this.pb_archivos_modelo
this.Control[iCurrent+6]=this.dw_historicomodelo
end on

on wtc_mant_coleccion2.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_anyade_historico)
destroy(this.pb_borrar_historico)
destroy(this.dw_estilos)
destroy(this.pb_2)
destroy(this.pb_archivos_modelo)
destroy(this.dw_historicomodelo)
end on

event open;call super::open;dw_historicomodelo.SetTransObject(SQLCA)
dw_estilos.SetTransObject(SQLCA)

if not isnull(padre_codigo) and padre_codigo <> "" then
	dw_historicomodelo.retrieve(codigo_empresa, padre_codigo)
	dw_estilos.retrieve(codigo_empresa, padre_codigo)
end if


end event

event close;call super::close;String codigo, coleccion_antigua, disenyador, comercial, filtro_cliente, filtro_propuesta
Long esta_abierta, fila, i, filtro_fila
Datawindow dw
if not isnull(ventana_invoca) and ventana_invoca <> "" then
	esta_abierta = f_menu_ventana_esta_abierta(ventana_invoca)
	if esta_abierta <> -1 then
		CHOOSE CASE ventana_invoca
			CASE "wtc_trabajos_disenyo_nuevo"
			//Devuelvo valores
			codigo = dw_1.object.#1[dw_1.getrow()]
			disenyador = dw_1.object.disenyador[dw_1.getrow()]
			comercial = dw_1.object.descoleccionsol_comercial[dw_1.getrow()]
			wtc_trabajos_disenyo_nuevo.dw_1.object.tecnico_dis_descripcion_1[wtc_trabajos_disenyo_nuevo.dw_1.getrow()] = dw_1.object.tecnico_dis_descripcion[dw_1.getrow()]
			if not isnull(codigo) and codigo <> "" then
				fila = wtc_trabajos_disenyo_nuevo.dw_1.getrow()
				if fila > 0 then
					coleccion_antigua = wtc_trabajos_disenyo_nuevo.dw_1.object.coleccion[fila]
					if not isnull(coleccion_antigua) and coleccion_antigua <> "" then
						if coleccion_antigua <> codigo then
							if MessageBox("Atención","¿Desea reemplazar la colección "+coleccion_antigua+" por la colección "+codigo+" en el modelo?", Question!, YesNo!,2) = 1 then
								wtc_trabajos_disenyo_nuevo.dw_1.object.coleccion[fila] = codigo
								wtc_trabajos_disenyo_nuevo.dw_1.EVENT itemchanged(fila, wtc_trabajos_disenyo_nuevo.dw_1.object.coleccion, codigo)
								
								//Diseñadores y comercial (Petición Jesús 11/02/2013)
								//if isnull(wtc_trabajos_disenyo_nuevo.dw_1.object.tecnico_dis[fila]) or wtc_trabajos_disenyo_nuevo.dw_1.object.tecnico_dis[fila] = "" then
									wtc_trabajos_disenyo_nuevo.dw_1.object.tecnico_dis[fila] = dw_1.object.disenyador[dw_1.getrow()]
									wtc_trabajos_disenyo_nuevo.dw_1.EVENT itemchanged(wtc_trabajos_disenyo_nuevo.dw_1.Getrow(), wtc_trabajos_disenyo_nuevo.dw_1.object.tecnico_dis, dw_1.object.disenyador[wtc_trabajos_disenyo_nuevo.dw_1.getrow()])
								//end if
								//if isnull(wtc_trabajos_disenyo_nuevo.dw_1.object.comercial[fila]) or wtc_trabajos_disenyo_nuevo.dw_1.object.comercial[fila] = "" then
									wtc_trabajos_disenyo_nuevo.dw_1.object.comercial[fila] = dw_1.object.descoleccionsol_comercial[dw_1.getrow()]
									wtc_trabajos_disenyo_nuevo.dw_1.EVENT itemchanged(wtc_trabajos_disenyo_nuevo.dw_1.Getrow(), wtc_trabajos_disenyo_nuevo.dw_1.object.comercial, dw_1.object.descoleccionsol_comercial[wtc_trabajos_disenyo_nuevo.dw_1.getrow()])
								//end if
							end if
						else
							//Diseñadores y comercial en caso de cambio en la colección (Petición Jesús 02/05/2013)
							if wtc_trabajos_disenyo_nuevo.dw_1.object.tecnico_dis[fila] <> disenyador or wtc_trabajos_disenyo_nuevo.dw_1.object.tecnico_dis[fila] <> disenyador then
								if MessageBox("Atención", "¿Desea cambiar el comercial y el diseñador en el modelo y sus trabajos?", Question!, YesNo!, 2) = 1 then
									wtc_trabajos_disenyo_nuevo.dw_1.object.tecnico_dis[fila] = dw_1.object.disenyador[dw_1.getrow()]
									wtc_trabajos_disenyo_nuevo.dw_1.EVENT itemchanged(wtc_trabajos_disenyo_nuevo.dw_1.Getrow(), wtc_trabajos_disenyo_nuevo.dw_1.object.tecnico_dis, dw_1.object.disenyador[dw_1.getrow()])
								
									wtc_trabajos_disenyo_nuevo.dw_1.object.comercial[fila] = dw_1.object.descoleccionsol_comercial[dw_1.getrow()]
									wtc_trabajos_disenyo_nuevo.dw_1.EVENT itemchanged(wtc_trabajos_disenyo_nuevo.dw_1.Getrow(), wtc_trabajos_disenyo_nuevo.dw_1.object.comercial, dw_1.object.descoleccionsol_comercial[dw_1.getrow()])
									
									//En trabajos
									dw = wtc_trabajos_disenyo_nuevo.dw_trabajos
									filtro_fila = dw.getrow()
									if filtro_fila > 0 then
										filtro_cliente = dw.object.modelo_trabajo_cliente[filtro_fila]
										filtro_propuesta = dw.object.modelo_trabajo_propuesta[filtro_fila]
										dw.setfilter("")
										dw.filter()	
										
										dw.accepttext()
										For i = 1 To dw.rowcount()
											dw.object.modelo_trabajo_tecnico_dis[i] = dw_1.object.disenyador[dw_1.getrow()]
											dw.EVENT itemchanged(i, dw.object.modelo_trabajo_tecnico_dis, dw_1.object.disenyador[dw_1.getrow()])
											dw.object.modelo_trabajo_comercial[i] = dw_1.object.descoleccionsol_comercial[dw_1.getrow()]
											dw.EVENT itemchanged(i, dw.object.modelo_trabajo_comercial, dw_1.object.descoleccionsol_comercial[dw_1.getrow()])
										Next
										dw.accepttext()
										
										dw.setfilter("modelo_trabajo_cliente = '"+filtro_cliente+"' and modelo_trabajo_propuesta = '"+filtro_propuesta+"'")
										dw.filter()	
										dw.setrow(filtro_fila)
									end if
								end if
							end if
						end if			
					else
						wtc_trabajos_disenyo_nuevo.dw_1.object.coleccion[wtc_trabajos_disenyo_nuevo.dw_1.getrow()] = codigo
						wtc_trabajos_disenyo_nuevo.dw_1.EVENT itemchanged(wtc_trabajos_disenyo_nuevo.dw_1.Getrow(), wtc_trabajos_disenyo_nuevo.dw_1.object.coleccion, codigo)
						//Diseñadores y comercial (Petición Jesús 11/02/2013)
						if isnull(wtc_trabajos_disenyo_nuevo.dw_1.object.tecnico_dis[fila]) or wtc_trabajos_disenyo_nuevo.dw_1.object.tecnico_dis[fila] = "" then
							wtc_trabajos_disenyo_nuevo.dw_1.object.tecnico_dis[fila] = dw_1.object.disenyador[wtc_trabajos_disenyo_nuevo.dw_1.getrow()]
							wtc_trabajos_disenyo_nuevo.dw_1.EVENT itemchanged(wtc_trabajos_disenyo_nuevo.dw_1.Getrow(), wtc_trabajos_disenyo_nuevo.dw_1.object.tecnico_dis, dw_1.object.disenyador[wtc_trabajos_disenyo_nuevo.dw_1.getrow()])
						end if
						if isnull(wtc_trabajos_disenyo_nuevo.dw_1.object.comercial[fila]) or wtc_trabajos_disenyo_nuevo.dw_1.object.comercial[fila] = "" then
							wtc_trabajos_disenyo_nuevo.dw_1.object.comercial[fila] = dw_1.object.descoleccionsol_comercial[wtc_trabajos_disenyo_nuevo.dw_1.getrow()]
							wtc_trabajos_disenyo_nuevo.dw_1.EVENT itemchanged(wtc_trabajos_disenyo_nuevo.dw_1.Getrow(), wtc_trabajos_disenyo_nuevo.dw_1.object.comercial, dw_1.object.descoleccionsol_comercial[wtc_trabajos_disenyo_nuevo.dw_1.getrow()])
						end if
					end if
				end if
			end if
		END CHOOSE
	end if
end if
end event

type pb_imprimir from wt_ventana_padre`pb_imprimir within wtc_mant_coleccion2
boolean visible = false
end type

type p_logo from wt_ventana_padre`p_logo within wtc_mant_coleccion2
integer x = 4718
integer y = 8
end type

type dw_1 from wt_ventana_padre`dw_1 within wtc_mant_coleccion2
integer x = 27
integer y = 256
integer width = 1746
integer height = 928
integer taborder = 10
string title = "Mantenimeinto de Colecciones"
string dataobject = "dwtc_descoleccion2"
boolean border = false
end type

event dw_1::usr_keydown;call super::usr_keydown;string campo
str_wt_busquedas_salida resultado
str_wt_busquedas_entrada busqueda

if key =  keyEnter! then
	campo = This.GetColumnName()
	CHOOSE CASE campo
		CASE "descoleccionsol_tecnico_lab"
			busqueda.titulo_ventana = "Búsqueda de Técnico"
			busqueda.consulta  = "SELECT CODIGO, DESCRIPCION FROM TECNICO_LAB WHERE EMPRESA = '"+codigo_empresa+"' ORDER BY DESCRIPCION"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Técnico"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				dw_1.object.descoleccionsol_tecnico_lab[dw_1.GetRow()] = resultado.valores[1]			// Devuelve el valor que encuentra ...
				dw_1.object.tecnico_lab_descripcion[dw_1.GetRow()] 	 = resultado.valores[2]			// Devuelve el valor que encuentra ...
				dw_1.Modify("tecnico_lab_descripcion.Background.Color  = "+ftc_control_color_descripcion(0))			
			end if		
			
		CASE "disenyador"
			busqueda.titulo_ventana = "Búsqueda de Diseñador"
			busqueda.consulta  = "SELECT CODIGO, DESCRIPCION FROM TECNICO_DIS WHERE EMPRESA = '"+codigo_empresa+"' ORDER BY DESCRIPCION"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Diseñador"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				dw_1.object.disenyador[dw_1.GetRow()] 						= resultado.valores[1]			// Devuelve el valor que encuentra ...
				dw_1.object.tecnico_dis_descripcion[dw_1.GetRow()] 	= resultado.valores[2]			// Devuelve el valor que encuentra ...
				dw_1.Modify("tecnico_dis_descripcion.Background.Color = "+ftc_control_color_descripcion(0))			
			end if		
			
		CASE "descoleccionsol_comercial"
			busqueda.titulo_ventana = "Búsqueda de Comercial"
			busqueda.consulta  = "SELECT CODIGO, DESCRIPCION FROM comercial WHERE EMPRESA = '"+codigo_empresa+"' and activo = '1' ORDER BY DESCRIPCION"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Comercial"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				dw_1.object.descoleccionsol_comercial[dw_1.GetRow()] 					= resultado.valores[1]			// Devuelve el valor que encuentra ...
				dw_1.object.comercial_descripcion[dw_1.GetRow()] 	= resultado.valores[2]			// Devuelve el valor que encuentra ...
				dw_1.Modify("comercial_descripcion.Background.Color  = "+ftc_control_color_descripcion(0))			
			end if		
		
		CASE "descoleccionsol_grupo"
			busqueda.titulo_ventana = "Búsqueda de Grupo"
			busqueda.consulta  = "SELECT CODIGO, DESCRIPCION FROM descoleccionsol_grupo WHERE EMPRESA = '"+codigo_empresa+"' ORDER BY DESCRIPCION"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Grupo"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				dw_1.object.descoleccionsol_grupo[dw_1.GetRow()] 					= resultado.valores[1]			// Devuelve el valor que encuentra ...
				dw_1.object.descoleccionsol_grupo_descripcion[dw_1.GetRow()] 	= resultado.valores[2]			// Devuelve el valor que encuentra ...	
			end if		
		
	END CHOOSE
end if
end event

event dw_1::itemchanged;call super::itemchanged;string resultado

if dwo.name <> "descoleccionsol_grupo" then
	if dw_1.object.descoleccionsol_grupo[dw_1.getrow()] = "" or isnull(dw_1.object.descoleccionsol_grupo[dw_1.getrow()]) then
		dw_1.object.descoleccionsol_grupo[dw_1.getrow()] = "1"
		dw_1.EVENT itemchanged(dw_1.Getrow(), dw_1.object.descoleccionsol_grupo, "1")
	end if
end if

//this.Accepttext()

CHOOSE CASE dwo.name

	CASE "descoleccionsol_tecnico_lab"
		SELECT tecnico_lab.descripcion 
		INTO :resultado
		FROM tecnico_lab
		WHERE empresa = :codigo_empresa
		and tecnico_lab.codigo = :data 
		and activo = 'S' 
		ORDER BY tecnico_lab.descripcion ;

		if SQLCA.sqlcode <> 100 then
			this.object.tecnico_lab_descripcion[Row] 		= resultado
		else
			dwo.Primary[row] = ''
			this.object.tecnico_lab_descripcion[Row] 		= ''
			return 2
		end if

	CASE "disenyador"
		SELECT tecnico_dis.descripcion 
		INTO :resultado
		FROM tecnico_dis
		WHERE empresa = :codigo_empresa 
		and activo = 'S'
		and tecnico_dis.codigo = :data
		ORDER BY tecnico_dis.descripcion ;

		if SQLCA.sqlcode <> 100 then
			this.object.tecnico_dis_descripcion[Row] 		= resultado
		else
			dwo.Primary[row] = ''
			this.object.tecnico_dis_descripcion[Row] 		= ''
			return 2
		end if
		
	CASE "descoleccionsol_comercial"
		SELECT comercial.descripcion 
		INTO :resultado
		FROM comercial
		WHERE empresa = :codigo_empresa
		and activo = '1'
		and comercial.codigo = :data
		ORDER BY comercial.descripcion ;

		if SQLCA.sqlcode <> 100 then
			this.object.comercial_descripcion[Row] 		= resultado		
		else
			dwo.Primary[row] = ''
			this.object.comercial_descripcion[Row] 		= ''
			return 2
		end if
		
	CASE "descoleccionsol_grupo"
		SELECT descripcion 
		INTO :resultado
		FROM descoleccionsol_grupo
		WHERE empresa = :codigo_empresa
		and codigo = :data;

		if SQLCA.sqlcode <> 100 then
			this.object.descoleccionsol_grupo_descripcion[Row] 		= resultado		
		else
			dwo.Primary[row] = ''
			this.object.descoleccionsol_grupo_descripcion[Row] 		= ''
			return 2
		end if
END CHOOSE


this.Accepttext()
end event

type pb_borrar from wt_ventana_padre`pb_borrar within wtc_mant_coleccion2
integer x = 4763
integer y = 120
end type

type pb_salir from wt_ventana_padre`pb_salir within wtc_mant_coleccion2
integer x = 5074
integer y = 120
end type

type pb_grabar from wt_ventana_padre`pb_grabar within wtc_mant_coleccion2
end type

type st_titulo from wt_ventana_padre`st_titulo within wtc_mant_coleccion2
end type

type pb_nuevo from wt_ventana_padre`pb_nuevo within wtc_mant_coleccion2
end type

event pb_nuevo::clicked;call super::clicked;
dw_estilos.SetTransObject (SQLCA)
dw_estilos.retrieve(codigo_empresa, "")
dw_historicomodelo.reset()


end event

type pb_cancelar from wt_ventana_padre`pb_cancelar within wtc_mant_coleccion2
integer x = 4919
integer y = 120
end type

event pb_cancelar::clicked;call super::clicked;dw_historicomodelo.retrieve(codigo_empresa, padre_codigo)
dw_estilos.retrieve(codigo_empresa, padre_codigo)
end event

type pb_buscar from wt_ventana_padre`pb_buscar within wtc_mant_coleccion2
end type

event pb_buscar::clicked;string campo

campo = dw_1.GetColumnName()

padre_busqueda.filtro_es_codigo = false
choose case campo
	case "codigo"
		padre_busqueda.filtro_es_codigo = true
		padre_busqueda.consulta =  " SELECT descoleccionsol.codigo, descoleccionsol.codigo, ambiente.descripcion, descoleccionsol.descripcion "+&
											" FROM descoleccionsol INNER JOIN ambiente ON descoleccionsol.empresa = ambiente.empresa AND descoleccionsol.ambiente = ambiente.codigo "+&
											" WHERE descoleccionsol.empresa = '"+codigo_empresa+"' "+&
											" ORDER BY CONVERT(INTEGER, descoleccionsol.codigo) desc"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Código"
		padre_busqueda.titulos[3] = "Ambiente"	
		padre_busqueda.titulos[4] = "Descripción"	
	
	case "descoleccionsol_descripcion"
		padre_busqueda.consulta =  " SELECT descoleccionsol.codigo, ambiente.descripcion, descoleccionsol.descripcion "+&
											" FROM descoleccionsol INNER JOIN ambiente ON descoleccionsol.empresa = ambiente.empresa AND descoleccionsol.ambiente = ambiente.codigo "+&
											" WHERE descoleccionsol.empresa = '"+codigo_empresa+"' "+&
											" ORDER BY descoleccionsol.descripcion desc"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Ambiente"	
		padre_busqueda.titulos[3] = "Descripción"		
	case else
		padre_busqueda.filtro_es_codigo = true
		padre_busqueda.consulta =  " SELECT descoleccionsol.codigo, descoleccionsol.codigo, ambiente.descripcion, descoleccionsol.descripcion "+&
											" FROM descoleccionsol INNER JOIN ambiente ON descoleccionsol.empresa = ambiente.empresa AND descoleccionsol.ambiente = ambiente.codigo "+&
											" WHERE descoleccionsol.empresa = '"+codigo_empresa+"' "+&
											" ORDER BY CONVERT(INTEGER, descoleccionsol.codigo) desc"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Código"
		padre_busqueda.titulos[3] = "Ambiente"	
		padre_busqueda.titulos[4] = "Descripción"	
end choose


call super :: clicked


if padre_codigo <> "" then
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// AQUÍ PONDREMOS TODOS LOS DATAWINDOWS AUXILIARES
	dw_historicomodelo.retrieve(codigo_empresa, padre_codigo)
	dw_estilos.retrieve(codigo_empresa, padre_codigo)
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
end if
end event

type pb_anyade_historico from picturebutton within wtc_mant_coleccion2
integer x = 1806
integer y = 1800
integer width = 146
integer height = 128
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

event clicked;
long total_filas, fila_actual, nuevoregistro, indice
string v_solicitud, v_coleccion

dw_historicomodelo.scrolltorow(dw_historicomodelo.InsertRow(0))
dw_historicomodelo.SetColumn(1)
dw_historicomodelo.Setfocus()

fila_actual = dw_historicomodelo.Getrow()
total_filas = dw_historicomodelo.RowCount()

v_coleccion = f_codigo_principal()

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


end event

type pb_borrar_historico from picturebutton within wtc_mant_coleccion2
integer x = 1957
integer y = 1800
integer width = 146
integer height = 128
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

event clicked;
boolean error_borrando
long fila_actual, existe
String cliente, coleccion

if dw_historicomodelo.Rowcount() > 0 then
	fila_actual = dw_historicomodelo.getrow()
	cliente = dw_historicomodelo.object.deshistorico_cliente[fila_actual]
	coleccion = f_codigo_principal()
	
	SELECT COUNT(*) INTO :existe FROM modelo INNER JOIN modelo_cliente ON modelo.empresa = modelo_cliente.empresa AND modelo.modelo = modelo_cliente.modelo
	WHERE modelo.empresa = :codigo_empresa AND modelo.coleccion = :coleccion AND modelo_cliente.cliente = :cliente;
	
	if existe > 0 then
		MessageBox("Error", "No se puede borrar un cliente del histórico si se han realizado propuesta para él.")
	else
		dw_historicomodelo.DeleteRow(fila_actual)
	
		error_borrando = False
	
		if dw_historicomodelo.Rowcount() > 0 then
			dw_historicomodelo.scrolltoRow(fila_actual)
		end if
	end if
end if


end event

type dw_estilos from datawindow within wtc_mant_coleccion2
integer x = 27
integer y = 1188
integer width = 1746
integer height = 760
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "dwtc_estilo_coleccion"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event clicked;if row > 0 then
	if this.object.seleccionado[row] = 1 then
		this.object.seleccionado[row] = 0
	else
		this.object.seleccionado[row] = 1
	end if
end if
end event

type pb_2 from picturebutton within wtc_mant_coleccion2
string tag = "Exposición"
integer x = 649
integer y = 116
integer width = 146
integer height = 128
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\presentation.png"
alignment htextalign = left!
string powertiptext = "Archivos Exposición"
end type

event clicked;str_parametros lstr_param
long esta_abierta

if hay_cambios() then
	//MessageBox("Atención", "Debe guardar los cambios antes de modificar los archivos de la exposición")
	if f_guardar() <> 1 then
		return
	end if
end if

if Integer(dw_estilos.Describe("Evaluate('sum(if(seleccionado = 1,1,0))', 0)")) = 0 then
	messagebox("Aviso", 'Debe seleccionar al menos un estilo')
	return
end if

if isnull(dw_1.object.descoleccionsol_destino[dw_1.getrow()]) or dw_1.object.descoleccionsol_destino[dw_1.getrow()] = "" then
	MessageBox("Error", "Debe indicar la base destino de la colección y guardar, antes de modificar los archivos de la exposición")
	return
end if

if IsNull(dw_1.object.descoleccionsol_fecha_coleccion[dw_1.getrow()]) or datetime(date('1900-01-01')) = dw_1.object.descoleccionsol_fecha_coleccion[dw_1.getrow()] then
	MessageBox("Error", "La colección de tener una fecha. Asegurese de que hay al menos un trabajo de diseño con fecha de fin.")
	return
end if

esta_abierta = f_menu_ventana_esta_abierta("wtc_mant_coleccion_archivo")
//Abrimos la ventana si no está abierta ya. En caso contrario la mostramos
if esta_abierta = -1 then
	lstr_param.s_argumentos[1] = f_codigo_principal()
	lstr_param.i_nargumentos = 1
	lstr_param.nombre_ventana = "wtc_mant_coleccion2"
	lstr_param.resultado = ''
	Openwithparm(wtc_mant_coleccion_archivo, lstr_param)
else
	ventanas_activas[esta_abierta].ventana.BringToTop = true
end if
end event

type pb_archivos_modelo from picturebutton within wtc_mant_coleccion2
integer x = 805
integer y = 116
integer width = 146
integer height = 128
integer taborder = 140
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\index.png"
alignment htextalign = left!
string powertiptext = "Archivos de la colección"
end type

event clicked;str_parametros lstr_param
long esta_abierta

if hay_cambios() = true then
	if f_guardar() <> 1 then
		return //Fallo de validación en la grabación
	end if
end if

//La ventana será response
lstr_param.s_argumentos[1] = f_codigo_principal()
lstr_param.i_nargumentos = 1
lstr_param.nombre_ventana = "wtc_mant_coleccion_archivo"
lstr_param.resultado = ''
Openwithparm(wtc_mant_coleccion_sistema_archivos, lstr_param)

end event

type dw_historicomodelo from u_dw_padre within wtc_mant_coleccion2
integer x = 1783
integer y = 256
integer width = 3438
integer height = 1692
integer taborder = 30
string dataobject = "dwtc_historicomodelo"
end type

event doubleclicked;call super::doubleclicked;this.EVENT usr_dwnkey(KeyEnter!, 0)

end event

event itemchanged;call super::itemchanged;string resultado
String cliente, coleccion
Long existe

this.Accepttext()

CHOOSE CASE dwo.name
	CASE "deshistorico_cliente"
		cliente = dw_historicomodelo.object.cliente_actual[row]
		coleccion = f_codigo_principal()
		
		SELECT COUNT(*) INTO :existe FROM modelo INNER JOIN modelo_cliente ON modelo.empresa = modelo_cliente.empresa AND modelo.modelo = modelo_cliente.modelo
		WHERE modelo.empresa = :codigo_empresa AND modelo.coleccion = :coleccion AND modelo_cliente.cliente = :cliente;
		
		if existe > 0 then
			MessageBox("Error", "No se puede cambiar un cliente del histórico si se han realizado propuesta para él.")
			dwo.Primary[row] = cliente
			SELECT genter.razon INTO :resultado
			FROM genter
			WHERE empresa = :codigo_empresa
			and genter.codigo = :cliente and genter.tipoter = 'C';
			this.object.genter_razon[Row] 		= resultado
			return 2			
		else
			SELECT genter.razon
			INTO :resultado
			FROM genter
			WHERE empresa = :codigo_empresa
			and genter.codigo = :data 
			and genter.tipoter = 'C';
	
			if SQLCA.sqlcode <> 100 then
				this.object.genter_razon[Row] 		= resultado
				this.object.cliente_actual[row] = data
				if data = '87' then
					this.object.deshistorico_comercial[row] = '13' //Comercial tencer
					this.EVENT itemchanged(row, this.object.deshistorico_comercial, '13')
				end if
			else
				dwo.Primary[row] = ''
				this.object.genter_razon[Row] 		= ''
				return 2			
			end if
		end if
	CASE "deshistorico_comercial"
		SELECT comercial.descripcion
		INTO :resultado
		FROM comercial
		WHERE empresa = :codigo_empresa
		and comercial.codigo = :data;

		if SQLCA.sqlcode <> 100 then
			this.object.comercial_descripcion[Row] 		= resultado
		else
			dwo.Primary[row] = ''
			this.object.comercial_descripcion[Row] 		= ''
			return 2			
		end if
END CHOOSE


end event

event usr_dwnkey;call super::usr_dwnkey;string campo
String cliente, coleccion
Long existe
str_wt_busquedas_salida resultado
str_wt_busquedas_entrada busqueda

//if key = KeyF8! then
//	dw_1.EVENT usr_keydown(key, keyflags)
//end if

control_teclas (keyflags, key)

busqueda.filtro_es_codigo = false
if key =  keyEnter! then
	campo = This.GetColumnName()
	CHOOSE CASE campo
		CASE "deshistorico_cliente"
			cliente = dw_historicomodelo.object.deshistorico_cliente[this.getrow()]
			coleccion = f_codigo_principal()
			
			SELECT COUNT(*) INTO :existe FROM modelo INNER JOIN modelo_cliente ON modelo.empresa = modelo_cliente.empresa AND modelo.modelo = modelo_cliente.modelo
			WHERE modelo.empresa = :codigo_empresa AND modelo.coleccion = :coleccion AND modelo_cliente.cliente = :cliente;
			
			if existe > 0 then
				MessageBox("Error", "No se puede cambiar un cliente del histórico si se han realizado propuesta para él.")
			else
				busqueda.titulo_ventana = "Búsqueda de Cliente"
				busqueda.consulta  = " SELECT CODIGO, RAZON "+&
											" FROM genter "+&
											" WHERE empresa = '"+codigo_empresa+"' and tipoter = 'C' ORDER BY RAZON" 
				busqueda.titulos[1] = "Código"
				busqueda.titulos[2] = "Razón "
				
				OpenWithParm(wt_busquedas, busqueda)
				resultado = Message.PowerObjectParm
				if resultado.resultado > 0 then
					this.object.deshistorico_cliente[this.GetRow()] 			= resultado.valores[1]		
					this.object.genter_razon[this.GetRow()] 					= resultado.valores[2]		
					this.object.cliente_actual[this.GetRow()] = resultado.valores[1]		
					if resultado.valores[1]  = '87' then
						this.object.deshistorico_comercial[this.GetRow()] = '13' //Comercial tencer
						this.EVENT itemchanged(this.GetRow(), this.object.deshistorico_comercial, '13')
					end if
				end if
			end if
		CASE "deshistorico_comercial"
			busqueda.titulo_ventana = "Búsqueda de Comercial"
			busqueda.consulta  = " SELECT codigo, descripcion "+&
										" FROM comercial "+&
										" WHERE empresa = '"+codigo_empresa+"'"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Nombre"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				this.object.deshistorico_comercial[this.GetRow()] 			= resultado.valores[1]		
				this.object.comercial_descripcion[this.GetRow()]			= resultado.valores[2]		
			end if
	END CHOOSE
end if	
	
end event

