$PBExportHeader$wtc_alta_semielaborados_v1.srw
forward
global type wtc_alta_semielaborados_v1 from wt_ventana_padre
end type
type gb_1 from groupbox within wtc_alta_semielaborados_v1
end type
type pb_borrar_trabajo from picturebutton within wtc_alta_semielaborados_v1
end type
type pb_duplica_trabajo from picturebutton within wtc_alta_semielaborados_v1
end type
type pb_anyade_trabajo from picturebutton within wtc_alta_semielaborados_v1
end type
type pb_1 from picturebutton within wtc_alta_semielaborados_v1
end type
type pb_2 from picturebutton within wtc_alta_semielaborados_v1
end type
type tv_escandallo from treeview within wtc_alta_semielaborados_v1
end type
type cb_2 from commandbutton within wtc_alta_semielaborados_v1
end type
type cb_4 from commandbutton within wtc_alta_semielaborados_v1
end type
type pb_bloquear_estructura from picturebutton within wtc_alta_semielaborados_v1
end type
type pb_bloquear_1 from picturebutton within wtc_alta_semielaborados_v1
end type
type st_mensaje from statictext within wtc_alta_semielaborados_v1
end type
type cb_1 from commandbutton within wtc_alta_semielaborados_v1
end type
type pb_3 from picturebutton within wtc_alta_semielaborados_v1
end type
type pb_4 from picturebutton within wtc_alta_semielaborados_v1
end type
type dw_listado_ficha from datawindow within wtc_alta_semielaborados_v1
end type
type gb_2 from groupbox within wtc_alta_semielaborados_v1
end type
type p_1 from picture within wtc_alta_semielaborados_v1
end type
type p_2 from picture within wtc_alta_semielaborados_v1
end type
type p_3 from picture within wtc_alta_semielaborados_v1
end type
type st_1 from statictext within wtc_alta_semielaborados_v1
end type
type st_2 from statictext within wtc_alta_semielaborados_v1
end type
type st_3 from statictext within wtc_alta_semielaborados_v1
end type
type p_imagen from picture within wtc_alta_semielaborados_v1
end type
type r_1 from rectangle within wtc_alta_semielaborados_v1
end type
type gb_3 from groupbox within wtc_alta_semielaborados_v1
end type
type dw_2 from u_dw within wtc_alta_semielaborados_v1
end type
type dw_3 from u_dw within wtc_alta_semielaborados_v1
end type
end forward

global type wtc_alta_semielaborados_v1 from wt_ventana_padre
integer width = 5609
integer height = 3156
string title = "Alta Semielaborados"
gb_1 gb_1
pb_borrar_trabajo pb_borrar_trabajo
pb_duplica_trabajo pb_duplica_trabajo
pb_anyade_trabajo pb_anyade_trabajo
pb_1 pb_1
pb_2 pb_2
tv_escandallo tv_escandallo
cb_2 cb_2
cb_4 cb_4
pb_bloquear_estructura pb_bloquear_estructura
pb_bloquear_1 pb_bloquear_1
st_mensaje st_mensaje
cb_1 cb_1
pb_3 pb_3
pb_4 pb_4
dw_listado_ficha dw_listado_ficha
gb_2 gb_2
p_1 p_1
p_2 p_2
p_3 p_3
st_1 st_1
st_2 st_2
st_3 st_3
p_imagen p_imagen
r_1 r_1
gb_3 gb_3
dw_2 dw_2
dw_3 dw_3
end type
global wtc_alta_semielaborados_v1 wtc_alta_semielaborados_v1

type variables

end variables

forward prototypes
public function boolean hay_cambios ()
public function integer f_guardar ()
public function integer f_borrar ()
public subroutine f_contraer_tv (long hijo)
public subroutine fr_anular (string codigo, integer accion)
public subroutine fr_bloquear (string codigo, integer accion)
public subroutine fr_ruta_principal (long nodo)
end prototypes

public function boolean hay_cambios ();Boolean resultado
resultado = false

dw_1.accepttext() //Necesario para que se detecten los cambios en el campo en el que se tiene el foco

if dw_1.DeletedCount() + dw_1.ModifiedCount() > 0 or dw_2.DeletedCount() + dw_2.ModifiedCount() > 0 then
	resultado = true
end if

return resultado
end function

public function integer f_guardar ();//SOBRESCRIBIMOS LA FUNCION DEL PADRE. NO LA LLMAMOS CON super::funcion()

long i, j, numero_filas
string campo, motivo
boolean falta_Campo, aceptado
string operacion, articulo_anterior
Long codigo_aplicacion, ultimo_codigo_aplicacion, columna_seleccionada_ruta
string null_str
Int resultado

columna_seleccionada_ruta = dw_2.getrow()

resultado = 1 //Todo ok si devolvemos 1

param_colisiones.empresa = codigo_empresa
param_colisiones.tabla = "articulos"
param_colisiones.campo = "codigo"
param_colisiones.filtro = ""
param_colisiones.buscar_huecos = false

/*---------------------------------------------------------------------------------------------------------------------------------
			   AQUÍ IRÁ EL CÓDIGO PARA COMPROBAR LOS CAMPOS OBLIGATORIOS.
---------------------------------------------------------------------------------------------------------------------------------*/

// Campos obligatorios dw_1 (Artículo)

dw_1.accepttext()
falta_campo = false
if dw_1.rowcount() > 0 then
	if IsNull(dw_1.object.articulos_descripcion[dw_1.getrow()]) or Trim(String(dw_1.object.articulos_descripcion[dw_1.getrow()])) = "" then
		  campo = "articulos_descripcion"
		  motivo = "Campo Obligatorio: Descripción. "
		  falta_campo = True
	elseif IsNull(dw_1.object.articulos_formato[dw_1.getrow()]) or Trim(String(dw_1.object.articulos_formato[dw_1.getrow()])) = "" then
		  campo = "articulos_formato"
		  motivo = "Campo Obligatorio: Formato. "
		  falta_campo = True
	elseif IsNull(dw_1.object.articulos_referencia_laboratorio[dw_1.getrow()]) or Trim(String(dw_1.object.articulos_referencia_laboratorio[dw_1.getrow()])) = "" then
		  campo = "articulos_referencia_laboratorio"
		  motivo = "Campo Obligatorio: Referencia Laboratorio "
		  falta_campo = True
	elseif IsNull(dw_1.object.articulos_version_laboratorio[dw_1.getrow()]) or Trim(String(dw_1.object.articulos_version_laboratorio[dw_1.getrow()])) = "" then
		  campo = "articulos_version_laboratorio"
		  motivo = "Campo Obligatorio: Prueba Laboratorio "
		  falta_campo = True
	elseif IsNull(dw_1.object.articulos_uso[dw_1.getrow()]) then
		  campo = "articulos_uso"
		  motivo = "Campo Obligatorio: Uso "
		  falta_campo = True
	elseif IsNull(dw_1.object.articulos_control_stock[dw_1.getrow()]) then
		  campo = "articulos_control_stock"
		  motivo = "Campo Obligatorio: Control Stock "
		  falta_campo = True
	elseif IsNull(dw_1.object.articulos_codigo_pantallas[dw_1.getrow()]) or Trim(String(dw_1.object.articulos_codigo_pantallas[dw_1.getrow()])) = "" then
		  campo = "articulos_codigo_pantallas"
		  motivo = "Campo Obligatorio: Código Pantallas "
		  falta_campo = True
	end if	

	if falta_campo then
	  MessageBox("Campo obligatorio: "+campo,motivo,Exclamation!, OK!,1)
	  dw_1.setfocus()
	  dw_1.SetColumn(campo)
	  return 0
	end if
end if

//Fin dw_1

// Campos obligatorios dw_2 (Rutas de Fabricación) 
if dw_2.RowCount() < 1 then
	messagebox("Aviso", 'Debe existir al menos una ruta de fabricación para el artículo')
	return 0
end if


dw_2.accepttext()
falta_campo = false
IF dw_2.rowcount() > 0 THEN
	falta_campo = false
	i = 1
	DO WHILE ( i <= dw_2.rowcount() AND NOT falta_campo )

		IF IsNull(dw_2.object.ruta_fabricacion_prioridad[i]) or Trim(String(dw_2.object.ruta_fabricacion_prioridad[i]))="" THEN
			  campo="ruta_fabricacion_prioridad"
			  motivo  = "Campo Obligatorio: Tipo de ruta (Principal o Alternativa)"
			  falta_campo = True
		ELSEIF IsNull(dw_2.object.ruta_fabricacion_ruta[i]) or Trim(String(dw_2.object.ruta_fabricacion_ruta[i]))="" THEN
			  campo="ruta_fabricacion_ruta"
			  motivo  = "Campo Obligatorio: Descripción Ruta"
			  falta_campo = True
		ELSEIF IsNull(dw_2.object.ruta_fabricacion_tipooperacion[i]) or Trim(String(dw_2.object.ruta_fabricacion_tipooperacion[i]))="" THEN
			  campo="ruta_fabricacion_tipooperacion"
			  motivo  = "Campo Obligatorio: Operación"
			  falta_campo = True
		ELSEIF IsNull(dw_2.object.ruta_fabricacion_articulo_anterior[i]) or Trim(String(dw_2.object.ruta_fabricacion_articulo_anterior[i]))="" THEN
			  campo="ruta_fabricacion_articulo_anterior"
			  motivo  = "Campo Obligatorio: Artículo Anterior"
			  falta_campo = True
		ELSEIF IsNull(dw_2.object.ruta_fabricacion_factor[i]) or Trim(String(dw_2.object.ruta_fabricacion_factor[i]))="" THEN
			  campo="ruta_fabricacion_factor"
			  motivo  = "Campo Obligatorio: Factor"
			  falta_campo = True
		END IF
		
		if falta_campo = false then
			dw_3.setfilter("aplicacion_tipooperacion = '"+String(dw_2.object.ruta_fabricacion_tipooperacion[i])+"' AND aplicacion_articulo_anterior = '"+String(dw_2.object.ruta_fabricacion_articulo_anterior[i])+"'")
			dw_3.filter()
			
			//Comprobamos las aplicaciones (dw_3)
			/*
			numero_filas = dw_3.Rowcount()
			if numero_filas < 1 then
				messagebox("Aviso", "Debe existir al menos una aplicación para la ruta "+String(i)+".")
				return 0
			end if
			*/
			
			//dw_3.setredraw(false)
			dw_3.AcceptText()
			j = 1
			
			DO WHILE ( j <= numero_filas AND NOT falta_campo )
				IF IsNull(dw_3.object.aplicacion_tipoaplicacion[j]) or Trim(String(dw_3.object.aplicacion_tipoaplicacion[j]))="" THEN
				  campo="aplicacion_tipoaplicacion"
				  motivo  = "Campo Obligatorio: Tipo Aplicación"
				  falta_campo = True
				end if
				j++
			LOOP
			IF falta_campo THEN
				MessageBox(" "+campo+": Campo obligatorio",motivo,Exclamation!, OK!,1)
				//dw_3.setredraw(true)
				dw_3.setfocus()
				dw_3.SetColumn(campo)
				return 0
			END IF
		end if
		//dw_3.setredraw(true)
		//Fin dw_3
		
		i++
	LOOP
		
	IF falta_campo THEN
	  MessageBox(" "+campo+": Campo obligatorio",motivo,Exclamation!, OK!,1)
	  dw_2.setfocus()
	  dw_2.SetColumn(campo)
	  return 0
	END IF
END IF
//Fin dw_2


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
	dw_1.object.articulos_empresa[dw_1.getrow()] = codigo_empresa		
	if String(dw_1.object.#1[dw_1.getrow()]) = '' or isnull (dw_1.object.#1[dw_1.getrow()]) then
		padre_codigo = String(f_colisiones ( trans_ts, param_colisiones))
		if padre_codigo = '0'  then
			messagebox("ERROR", "No se puede asignar un código.")
			ROLLBACK USING trans_ts;
//			DISCONNECT USING transaccion;
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
	//dw_3.setredraw(false)
	for i = 1 to dw_2.RowCount()
		dw_2.object.ruta_fabricacion_empresa[i] = codigo_empresa		
		dw_2.object.ruta_fabricacion_articulo[i] = dw_1.object.#1[dw_1.getrow()]
		operacion = dw_2.object.ruta_fabricacion_tipooperacion[i]
		articulo_anterior = dw_2.object.ruta_fabricacion_articulo_anterior[i]
		dw_3.setfilter("aplicacion_tipooperacion = '"+operacion+"' AND aplicacion_articulo_anterior = '"+articulo_anterior+"'")
		dw_3.filter()
		ultimo_codigo_aplicacion = -1
		for j = 1 to dw_3.RowCount()
			dw_3.object.aplicacion_empresa[j] = codigo_empresa		
			dw_3.object.aplicacion_articulo[j] = dw_1.object.#1[dw_1.getrow()]
			if isnull(dw_3.object.aplicacion_codigo[j]) or dw_3.object.aplicacion_codigo[j] = "" then
				SELECT max(convert(integer,codigo)) INTO :codigo_aplicacion 
				FROM aplicacion 
				WHERE empresa = :codigo_empresa AND articulo = :padre_codigo AND articulo_anterior  = :articulo_anterior AND tipooperacion = :operacion 
				USING trans_ts;
				
				if not isnull(codigo_aplicacion) and codigo_aplicacion <> 0 then
					if ultimo_codigo_aplicacion <> -1 then
						if ultimo_codigo_aplicacion > codigo_aplicacion then
							dw_3.object.aplicacion_codigo[j] = String(ultimo_codigo_aplicacion + 1)
						else
							dw_3.object.aplicacion_codigo[j] = String(codigo_aplicacion + 1)
						end if
					else
						dw_3.object.aplicacion_codigo[j] = String(codigo_aplicacion + 1)
					end if
				else
					if ultimo_codigo_aplicacion <> -1 then
						dw_3.object.aplicacion_codigo[j] = String(ultimo_codigo_aplicacion + 1)
					else
						dw_3.object.aplicacion_codigo[j] = '1'
					end if
				end if
				ultimo_codigo_aplicacion = Long(dw_3.object.aplicacion_codigo[j])
			end if		
		next
	next
	rtn = dw_2.update() 
end if		

if rtn = 1 then
	dw_3.setfilter(null_str)
	dw_3.filter()
	dw_3.SetTransObject(trans_ts)
	rtn = dw_3.update()
end if
/*---------------------------------------------------------------------------------------------------------------------------------
				   			FIN GRABACIÓN DATAWINDOWS AUXILIARES
---------------------------------------------------------------------------------------------------------------------------------*/
		
IF rtn = 1 THEN
	COMMIT USING trans_ts;
	mostrar_controles_edicion()

	dw_1.setfocus()
	dw_1.setcolumn(2)
	
	if columna_seleccionada_ruta > 0 then
		dw_3.setfilter("aplicacion_tipooperacion = '"+dw_2.object.ruta_fabricacion_tipooperacion[columna_seleccionada_ruta]+"' AND aplicacion_articulo_anterior = '"+dw_2.object.ruta_fabricacion_articulo_anterior[columna_seleccionada_ruta]+"'")
		dw_3.filter()
	else
		dw_3.setfilter("aplicacion_tipooperacion = '' AND aplicacion_articulo_anterior = ''")
		dw_3.filter()
	end if
	
ELSE
	messagebox("ERROR", "No se ha podido guardar en Base de Datos. Inténtelo de nuevo y si no es posible avise al administrador.")
	ROLLBACK USING trans_ts;
END IF
//dw_3.setredraw(true)
//DISCONNECT USING transaccion;
dw_1.SetTransObject(SQLCA)	
dw_2.SetTransObject(SQLCA)			
dw_3.SetTransObject(SQLCA)			
//destroy transaccion

estado = 1 // Modo edición

return rtn

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
	//f_crear_transaccion(transaccion ,"" ,"" ,false, "TS","")	
	//CONNECT USING transaccion;
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
	
	delete from art_codestadistico 
	where empresa = :codigo_empresa 
	and codigo = :padre_codigo using trans_ts;
		
	IF trans_ts.SQLCode <> 0 THEN         
		MessageBox("SQL error", trans_ts.SQLErrText)
		rtn = -1
	END IF
	
		
	if rtn <> -1 then
		delete from almartcajas
		where empresa = :codigo_empresa 
		and articulo = :padre_codigo using trans_ts;
		IF trans_ts.SQLCode <> 0 THEN         
			MessageBox("SQL error", trans_ts.SQLErrText)
			rtn = -1
		END IF
	end if
	
	if rtn <> -1 then
		delete from palarticulo
		where empresa = :codigo_empresa 
		and articulo = :padre_codigo using trans_ts;
		IF trans_ts.SQLCode <> 0 THEN         
			MessageBox("SQL error", trans_ts.SQLErrText)
			rtn = -1
		END IF
	end if
	
	if rtn <> -1 then
		delete from almartcal
		where empresa = :codigo_empresa 
		and articulo = :padre_codigo using trans_ts;
		IF trans_ts.SQLCode <> 0 THEN         
			MessageBox("SQL error", trans_ts.SQLErrText)
			rtn = -1
		END IF
	end if
	
	if rtn <> -1 then
		delete from ruta_fabricacion
		where empresa = :codigo_empresa 
		and articulo = :padre_codigo using trans_ts;
		IF trans_ts.SQLCode <> 0 THEN         
			MessageBox("SQL error", trans_ts.SQLErrText)
			rtn = -1
		END IF
	end if
	
	if rtn <> -1 then
		delete from aplicacion
		where empresa = :codigo_empresa 
		and articulo = :padre_codigo using trans_ts;
		IF trans_ts.SQLCode <> 0 THEN         
			MessageBox("SQL error", trans_ts.SQLErrText)
			rtn = -1
		END IF
	end if
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	if rtn = 1 then
		COMMIT USING trans_ts;
		//DISCONNECT USING transaccion;	
		dw_1.SetTransObject(SQLCA)	
		//destroy transaccion
		pb_nuevo.TriggerEvent(Clicked!)	
		mostrar_controles_insercion()
		dw_1.setfocus()
		dw_1.setcolumn(2)
		estado = 0 // Modo Insercion
	ELSE
		ROLLBACK USING trans_ts;
		//DISCONNECT USING transaccion;	
		dw_1.SetTransObject(SQLCA)	
		//destroy transaccion
		dw_1.object.#1[1] = padre_codigo
		pb_cancelar.triggerevent(Clicked!)
	
	END IF
end if

return rtn
end function

public subroutine f_contraer_tv (long hijo);Long hijo_sig

do while (hijo <> -1)
	tv_escandallo.collapseItem(hijo)
	hijo_sig = tv_escandallo.FindItem(ChildTreeItem! , hijo)
	f_contraer_tv(hijo_sig)
	hijo	= 	tv_escandallo.FindItem(NextTreeItem!, hijo)
loop
end subroutine

public subroutine fr_anular (string codigo, integer accion);String codigo_sig, codigo_bloqueado, sel, uso, descripcion
Datetime fecha_anulado
Int i, posicion
Datastore escandallo

SELECT
	uso, descripcion INTO :uso, :descripcion
FROM articulos 
WHERE codigo = :codigo;

if accion = 1 then
	fecha_anulado = Datetime(Today(),Now())
	descripcion = trim(descripcion)
	if pos(descripcion,"NULO") <> 1 then
		descripcion = "NULO "+descripcion		
	end if
else
	setnull(fecha_anulado)
	descripcion = trim(descripcion)
	posicion = pos(descripcion,"NULO")
	if posicion = 1 then
		descripcion = trim(mid(descripcion, posicion+4))
	end if
end if

//Las bases no se bloquean
if uso <> "1" then
	update articulos
	set 
			fecha_anulado = :fecha_anulado,
			descripcion = :descripcion
	where empresa = :codigo_empresa
			and codigo = :codigo;
end if

sel = "SELECT articulo_anterior, articulo FROM ruta_fabricacion WHERE empresa = '"+codigo_empresa+"' AND articulo = '"+codigo+"' "
f_cargar_cursor_trans (SQLCA,  sel,  escandallo)

For i = 1 To escandallo.RowCount()
	codigo_sig = trim(escandallo.object.articulo_anterior[i])
	//Condición de parada
	if not isnull(codigo_sig) and codigo_sig <> '' and codigo_sig <> '0' then
		fr_anular(codigo_sig,accion)
	end if
Next

Destroy escandallo
end subroutine

public subroutine fr_bloquear (string codigo, integer accion);String bloqueado, codigo_sig, codigo_bloqueado, sel, uso
Int i
Datastore escandallo

if accion = 1 then
	bloqueado = 'S'
else
	bloqueado = 'N'
end if

SELECT uso INTO :uso FROM articulos WHERE codigo = :codigo;

//Las bases no se bloquean
if uso <> "1" then
	update articulos
	set bloqueado = :bloqueado
	where empresa = :codigo_empresa
	and codigo = :codigo;
end if

sel = "SELECT articulo_anterior, articulo FROM ruta_fabricacion WHERE empresa = '"+codigo_empresa+"' AND articulo = '"+codigo+"' "
f_cargar_cursor_trans (SQLCA,  sel,  escandallo)

For i = 1 To escandallo.RowCount()
	codigo_sig = trim(escandallo.object.articulo_anterior[i])
	//Condición de parada
	if not isnull(codigo_sig) and codigo_sig <> '' and codigo_sig <> '0' then
		fr_bloquear(codigo_sig,accion)
	end if
Next

Destroy escandallo
end subroutine

public subroutine fr_ruta_principal (long nodo);long raiz, hijo, temporal, temporal_anterior, contador
int li_tvret
treeviewitem tvi

//tv_escandallo.SelectItem(nodo)
temporal = nodo
contador = 0
do while (temporal <> -1)
	contador ++
	tv_escandallo.getItem(temporal,tvi)
	tv_escandallo.collapseItem(temporal)
	temporal_anterior = temporal
	temporal	= 	tv_escandallo.FindItem(NextTreeItem!, temporal)
	if tvi.PictureIndex = 1 or tvi.PictureIndex = 2 then
		tv_escandallo.expandItem(temporal_anterior)
		hijo = tv_escandallo.FindItem(ChildTreeItem! , temporal_anterior)
		fr_ruta_principal(hijo)
	end if
loop
end subroutine

on wtc_alta_semielaborados_v1.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.pb_borrar_trabajo=create pb_borrar_trabajo
this.pb_duplica_trabajo=create pb_duplica_trabajo
this.pb_anyade_trabajo=create pb_anyade_trabajo
this.pb_1=create pb_1
this.pb_2=create pb_2
this.tv_escandallo=create tv_escandallo
this.cb_2=create cb_2
this.cb_4=create cb_4
this.pb_bloquear_estructura=create pb_bloquear_estructura
this.pb_bloquear_1=create pb_bloquear_1
this.st_mensaje=create st_mensaje
this.cb_1=create cb_1
this.pb_3=create pb_3
this.pb_4=create pb_4
this.dw_listado_ficha=create dw_listado_ficha
this.gb_2=create gb_2
this.p_1=create p_1
this.p_2=create p_2
this.p_3=create p_3
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.p_imagen=create p_imagen
this.r_1=create r_1
this.gb_3=create gb_3
this.dw_2=create dw_2
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.pb_borrar_trabajo
this.Control[iCurrent+3]=this.pb_duplica_trabajo
this.Control[iCurrent+4]=this.pb_anyade_trabajo
this.Control[iCurrent+5]=this.pb_1
this.Control[iCurrent+6]=this.pb_2
this.Control[iCurrent+7]=this.tv_escandallo
this.Control[iCurrent+8]=this.cb_2
this.Control[iCurrent+9]=this.cb_4
this.Control[iCurrent+10]=this.pb_bloquear_estructura
this.Control[iCurrent+11]=this.pb_bloquear_1
this.Control[iCurrent+12]=this.st_mensaje
this.Control[iCurrent+13]=this.cb_1
this.Control[iCurrent+14]=this.pb_3
this.Control[iCurrent+15]=this.pb_4
this.Control[iCurrent+16]=this.dw_listado_ficha
this.Control[iCurrent+17]=this.gb_2
this.Control[iCurrent+18]=this.p_1
this.Control[iCurrent+19]=this.p_2
this.Control[iCurrent+20]=this.p_3
this.Control[iCurrent+21]=this.st_1
this.Control[iCurrent+22]=this.st_2
this.Control[iCurrent+23]=this.st_3
this.Control[iCurrent+24]=this.p_imagen
this.Control[iCurrent+25]=this.r_1
this.Control[iCurrent+26]=this.gb_3
this.Control[iCurrent+27]=this.dw_2
this.Control[iCurrent+28]=this.dw_3
end on

on wtc_alta_semielaborados_v1.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_1)
destroy(this.pb_borrar_trabajo)
destroy(this.pb_duplica_trabajo)
destroy(this.pb_anyade_trabajo)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.tv_escandallo)
destroy(this.cb_2)
destroy(this.cb_4)
destroy(this.pb_bloquear_estructura)
destroy(this.pb_bloquear_1)
destroy(this.st_mensaje)
destroy(this.cb_1)
destroy(this.pb_3)
destroy(this.pb_4)
destroy(this.dw_listado_ficha)
destroy(this.gb_2)
destroy(this.p_1)
destroy(this.p_2)
destroy(this.p_3)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.p_imagen)
destroy(this.r_1)
destroy(this.gb_3)
destroy(this.dw_2)
destroy(this.dw_3)
end on

event open;call super::open;integer li_pictureli_picture

dw_2.SetTransObject(SQLCA)
dw_3.SetTransObject(SQLCA)


end event

event activate;call super::activate;wtc_alta_semielaborados = ventanas_activas[id_ventana_activa].ventana





end event

type pb_imprimir from wt_ventana_padre`pb_imprimir within wtc_alta_semielaborados_v1
integer x = 521
integer y = 128
end type

event pb_imprimir::clicked;string escandallo[],version_esc[],camino,codigo
long   indice,total,i
tipo_array val,ent

codigo = f_codigo_principal()
if trim(codigo) <> "" then
	ent.valor[1] = "1"
	ent.valor[2] = "1"
	openWithParm(w_pedir_version,ent)
	val =  message.powerObjectparm
	IF val.valor[1] = "RETURN" Then Return
		f_imprimir_ficha_tecnica_ot(dw_listado_ficha,codigo,val.valor[1],val.valor[2], 0)
		f_imprimir_datawindow(dw_listado_ficha)
end if
end event

type p_logo from wt_ventana_padre`p_logo within wtc_alta_semielaborados_v1
integer x = 5074
end type

type dw_1 from wt_ventana_padre`dw_1 within wtc_alta_semielaborados_v1
integer x = 41
integer y = 284
integer width = 2213
integer height = 512
integer taborder = 10
string dataobject = "dwtc_alta_semielaborados_articulos"
boolean border = false
end type

event dw_1::usr_keydown;call super::usr_keydown;string campo
str_wt_busquedas_salida resultado
str_wt_busquedas_entrada busqueda

if key =  keyEnter! then
	campo = This.GetColumnName()
	CHOOSE CASE campo
		CASE "articulos_formato"
			busqueda.titulo_ventana = "Búsqueda de Formato"
			busqueda.consulta  = " SELECT formatos.codigo, formatos.descripcion, formatos.abreviado, formatos.largo, formatos.ancho "+&
										" FROM formatos "+&
										" WHERE empresa = '"+codigo_empresa+"' ORDER BY DESCRIPCION ASC"
			
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Descripción"
			busqueda.titulos[3] = "Abreviado"
			busqueda.titulos[4] = "Largo"
			busqueda.titulos[5] = "Ancho"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				dw_1.object.articulos_formato[dw_1.GetRow()] 					= resultado.valores[1]		// Devuelve el valor que encuentra ...
				dw_1.object.formatos_abreviado[dw_1.GetRow()] 	= resultado.valores[3]		// Devuelve el valor que encuentra ...
				dw_1.object.formatos_largo[dw_1.GetRow()] 	= dec(resultado.valores[4])
				dw_1.object.formatos_ancho[dw_1.GetRow()] 	= dec(resultado.valores[5])
				dw_1.Modify("formatos_abreviado.Background.Color  = "+ftc_control_color_descripcion(0))			
			end if
				
			
	END CHOOSE
end if	
	

end event

event dw_1::clicked;call super::clicked;str_parametros lstr_param
long esta_abierta

CHOOSE CASE dwo.name

	CASE "p_formato"
		
		esta_abierta = f_menu_ventana_esta_abierta("wi_mant_formatos")
		//Abrimos la ventana si no está abierta ya. En caso contrario la mostramos
		if esta_abierta = -1 then
			lstr_param.s_argumentos[1] = codigo_empresa
			lstr_param.s_argumentos[2] = this.object.articulos_formato[row]
			lstr_param.i_nargumentos = 2
			lstr_param.nombre_ventana = "wtc_alta_semielaborados"
			lstr_param.resultado = ''
			Openwithparm(wi_mant_formatos, lstr_param)
		else
			ventanas_activas[esta_abierta].ventana.BringToTop = true
		end if

		
END CHOOSE

end event

event dw_1::itemchanged;call super::itemchanged;string resultado, resultado1
datetime resultado2
decimal ancho, largo

this.Accepttext()

CHOOSE CASE dwo.name
		
	CASE "articulos_formato"
			
		SELECT formatos.abreviado, formatos.ancho, formatos.largo  
		INTO :resultado1, :ancho, :largo 
		FROM formatos
		WHERE formatos.empresa = :codigo_empresa
		and formatos.codigo = :data;

		if SQLCA.sqlcode <> 100 then
			this.object.formatos_abreviado[Row] 		= resultado1
			this.object.formatos_ancho[Row] 	= ancho
			this.object.formatos_largo[Row] 	= largo
		else
			dwo.Primary[row] = ''
			this.object.formatos_abreviado[Row] 	= ''
			this.object.formatos_ancho[Row] 	= 0
			this.object.formatos_largo[Row] 	= 0
			return 2			
		end if

END CHOOSE

end event

event dw_1::retrieveend;call super::retrieveend;boolean hay_pedido, hay_stock, hay_planificado
int total
string texto, codigo, fecha_anulado

st_mensaje.text = ''

if rowcount > 0 then
	
	codigo = this.object.articulos_codigo[this.getrow()]
	
	hay_pedido = false
	hay_stock = false
	hay_planificado = false
	texto = ""
	
	select count(*)
	into :total
	from venliped
	where empresa = :codigo_empresa
	and articulo = :codigo;
	
	if total > 0 then	
		hay_pedido = true
		texto = "Hay Pedido. "
	end if
	
	select count(*)
	into :total
	from almlinubica
	where empresa = :codigo_empresa
	and articulo = :codigo;
	
	if total > 0 then	
		hay_stock = true
		texto = texto + "Hay stock. "
	end if
	
	select count(*)
	into :total
	from planificacion
	where empresa = :codigo_empresa
	and cod_articulo = :codigo;
	
	if total > 0 then	
		hay_planificado = true
		texto = texto + "Hay Planificado. "
	end if
	
	if dw_1.object.articulos_bloqueado[1] = 'S' then
		texto = texto + "Bloqueado. "
	end if
	
	fecha_anulado = String(dw_1.object.articulos_fecha_anulado[1])
	if isnull(fecha_anulado) or fecha_anulado = "" then
		//texto = texto + "Activo. "
	else
		texto = texto + "Anulado. "
	end if
	
	if texto <> '' then
		st_mensaje.text = texto
//		messagebox("Aviso", nombre_usuario+": "+texto)
	end if 
	
	p_imagen.PictureName = f_cargar_imagen_nuevo(string(dw_1.object.articulos_codigo_pantallas[dw_1.GetRow()]))
	
else
	
	p_imagen.PictureName = ""


end if
end event

type pb_borrar from wt_ventana_padre`pb_borrar within wtc_alta_semielaborados_v1
integer x = 5111
integer y = 132
string disabledname = "C:\Tencer_PB12\Delete_24x24_D.png"
end type

type pb_salir from wt_ventana_padre`pb_salir within wtc_alta_semielaborados_v1
integer x = 5431
integer y = 132
string picturename = "C:\Tencer_PB12\Log Out_24x24Gris.png"
end type

type pb_grabar from wt_ventana_padre`pb_grabar within wtc_alta_semielaborados_v1
integer x = 357
integer y = 128
end type

type st_titulo from wt_ventana_padre`st_titulo within wtc_alta_semielaborados_v1
integer x = 37
integer width = 3913
integer height = 72
string facename = "Verdana"
long bordercolor = 33554432
end type

type pb_nuevo from wt_ventana_padre`pb_nuevo within wtc_alta_semielaborados_v1
integer x = 37
integer y = 128
string disabledname = "C:\Tencer_PB12\New_24x24_D.png"
end type

event pb_nuevo::clicked;call super::clicked;if dw_1.rowcount() > 0 then
	dw_1.SetColumn(1)
	dw_1.object.articulos_fecha_alta[dw_1.getrow()] = datetime(today(),now())
end if
dw_2.reset()
dw_3.reset()
end event

type pb_cancelar from wt_ventana_padre`pb_cancelar within wtc_alta_semielaborados_v1
integer x = 5271
integer y = 132
string picturename = "C:\Tencer_PB12\Undo_24x24Gris.png"
end type

event pb_cancelar::clicked;call super::clicked;string null_str
if estado = 1 then
	dw_1.retrieve(codigo_empresa, padre_codigo)
	dw_2.retrieve(codigo_empresa, padre_codigo)
	dw_3.retrieve(codigo_empresa, padre_codigo)
	if dw_2.getrow() > 0 then
		dw_3.setfilter("aplicacion_tipooperacion = '"+dw_2.object.ruta_fabricacion_tipooperacion[dw_2.getrow()]+"' AND aplicacion_articulo_anterior = '"+dw_2.object.ruta_fabricacion_articulo_anterior[dw_2.getrow()]+"'")
		dw_3.filter()
	else
		dw_3.setfilter("aplicacion_tipooperacion = '' AND aplicacion_articulo_anterior = ''")
		dw_3.filter()
	end if
else
	Parent.setfocus()
	pb_nuevo.triggerevent(clicked!)
end if

end event

type pb_buscar from wt_ventana_padre`pb_buscar within wtc_alta_semielaborados_v1
integer x = 197
integer y = 128
end type

event pb_buscar::clicked;string campo, null_str, operacion, articulo_anterior
//, consulta_padre_busqueda
//Int numero_valores

campo = dw_1.GetColumnName()

padre_busqueda.filtro_es_codigo = false
choose case campo
	case "codigo"
		padre_busqueda.filtro_es_codigo = true
		padre_busqueda.consulta =  "SELECT articulos.codigo, articulos.codigo, articulos.descripcion, formatos.abreviado, almusos.descripcion, genter.razon "+&
							"FROM articulos "+&
							"INNER JOIN almusos ON articulos.uso = almusos.codigo and articulos.empresa = almusos.empresa "+&
							"LEFT OUTER JOIN genter ON articulos.cliente = genter.codigo and articulos.empresa = genter.empresa "+&
							"LEFT OUTER JOIN formatos ON articulos.formato = formatos.codigo and articulos.empresa = formatos.empresa "+&
							"WHERE articulos.empresa = '"+codigo_empresa+"' AND "+&
							"(genter.tipoter IS NULL OR genter.tipoter = 'C')"+&
							"ORDER BY articulos.descripcion"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Código"
		padre_busqueda.titulos[3] = "Descripción"
		padre_busqueda.titulos[4] = "Formato"
		padre_busqueda.titulos[5] = "Uso"
		padre_busqueda.titulos[6] = "Cliente"		

	case else
		padre_busqueda.filtro_es_codigo = true
		padre_busqueda.consulta =  "SELECT articulos.codigo, articulos.descripcion, formatos.abreviado, almusos.descripcion, genter.razon "+&
							"FROM articulos "+&
							"INNER JOIN almusos ON articulos.uso = almusos.codigo and articulos.empresa = almusos.empresa "+&
							"LEFT OUTER JOIN genter ON articulos.cliente = genter.codigo and articulos.empresa = genter.empresa "+&
							"LEFT OUTER JOIN formatos ON articulos.formato = formatos.codigo and articulos.empresa = formatos.empresa "+&
							"WHERE articulos.empresa = '"+codigo_empresa+"' AND "+&
							"(genter.tipoter IS NULL OR genter.tipoter = 'C')"+&
							"ORDER BY articulos.descripcion"
		padre_busqueda.titulos[1] = "Código"
		padre_busqueda.titulos[2] = "Descripción"
		padre_busqueda.titulos[3] = "Formato"
		padre_busqueda.titulos[4] = "Uso"
		padre_busqueda.titulos[5] = "Cliente"		
end choose


call super :: clicked

if padre_codigo <> "" then
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// AQUÍ PONDREMOS TODOS LOS DATAWINDOWS AUXILIARES
	dw_2.retrieve (codigo_empresa, dw_1.object.articulos_codigo[1])
	dw_3.retrieve(codigo_empresa, dw_1.object.articulos_codigo[1])
	if dw_2.getrow() > 0 then
		operacion = String(dw_2.object.ruta_fabricacion_tipooperacion[dw_2.getrow()])
		articulo_anterior = String(dw_2.object.ruta_fabricacion_articulo_anterior[dw_2.getrow()])
		if not isnull(operacion) and operacion <> "" and not isnull(articulo_anterior) and articulo_anterior <> "" then
			dw_3.setfilter("aplicacion_tipooperacion = '"+operacion+"' AND aplicacion_articulo_anterior = '"+articulo_anterior+"'")
		else
			dw_3.setfilter("aplicacion_tipooperacion = '' AND aplicacion_articulo_anterior = ''")
		end if
	else
		dw_3.setfilter("aplicacion_tipooperacion = '' AND aplicacion_articulo_anterior = ''")
	end if
	dw_3.Filter()
	tv_escandallo.deleteitem(0)
	
	f_ruta_fabricacion_treeview(dw_1.object.articulos_codigo[1], 0, tv_escandallo,1,"INICIO")
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
end if
end event

type gb_1 from groupbox within wtc_alta_semielaborados_v1
integer x = 1307
integer y = 80
integer width = 389
integer height = 204
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 23016974
long backcolor = 67108864
string text = "Anular"
end type

type pb_borrar_trabajo from picturebutton within wtc_alta_semielaborados_v1
integer x = 219
integer y = 2816
integer width = 146
integer height = 128
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "C:\Tencer_PB12\navigate_minus.png"
alignment htextalign = left!
string powertiptext = "EliminarRegistro"
end type

event clicked;
boolean error_borrando
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

type pb_duplica_trabajo from picturebutton within wtc_alta_semielaborados_v1
integer x = 370
integer y = 2816
integer width = 146
integer height = 128
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\duplicar.png"
alignment htextalign = left!
string powertiptext = "Duplicar Registro"
end type

event clicked;string codigo
Int origen, destino

codigo = f_codigo_principal()
IF codigo <> '' and dw_3.getrow() > 0 THEN
	origen = dw_3.getrow()
	destino = dw_3.InsertRow(0)
	
	dw_3.scrolltorow(destino)
	dw_3.SetColumn(2)
	dw_3.Setfocus()
	dw_3.accepttext()
	
	//El código no se copia (se asigna al final)
	dw_3.object.#2[destino] = dw_3.object.#2[origen]
	dw_3.object.#3[destino] = dw_3.object.#2[origen]
	dw_3.object.#4[destino] = dw_3.object.#2[origen]
	dw_3.object.#5[destino] = Int(dw_3.object.#5[dw_3.rowcount()]) + 1
	dw_3.object.#6[destino] = dw_3.object.#6[origen]
	dw_3.object.#7[destino] = dw_3.object.#7[origen]
	dw_3.object.#8[destino] = dw_3.object.#8[origen]
	dw_3.object.#9[destino] = dw_3.object.#9[origen]
	dw_3.object.#10[destino] = dw_3.object.#10[origen]
	dw_3.object.#11[destino] = dw_3.object.#11[origen]
	dw_3.object.#12[destino] = dw_3.object.#12[origen]
	dw_3.object.#13[destino] = dw_3.object.#13[origen]
	dw_3.object.#14[destino] = dw_3.object.#14[origen]
	dw_3.object.#15[destino] = dw_3.object.#15[origen]
	dw_3.object.#16[destino] = dw_3.object.#16[origen]
	dw_3.object.#17[destino] = dw_3.object.#17[origen]
	dw_3.object.#18[destino] = dw_3.object.#18[origen]
	dw_3.object.#19[destino] = dw_3.object.#19[origen]
	dw_3.object.#20[destino] = dw_3.object.#20[origen]
	dw_3.object.#21[destino] = dw_3.object.#21[origen]
	dw_3.object.#22[destino] = dw_3.object.#22[origen]
	dw_3.object.#23[destino] = dw_3.object.#23[origen]
	dw_3.object.#24[destino] = dw_3.object.#24[origen]
	dw_3.object.#25[destino] = dw_3.object.#25[origen]
	dw_3.object.#26[destino] = dw_3.object.#26[origen]
	dw_3.object.#27[destino] = dw_3.object.#27[origen]
	dw_3.object.#28[destino] = dw_3.object.#28[origen]
	dw_3.object.#29[destino] = dw_3.object.#29[origen]
	
	dw_3.accepttext()
end if


end event

type pb_anyade_trabajo from picturebutton within wtc_alta_semielaborados_v1
integer x = 69
integer y = 2816
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

event clicked;long fila_actual, orden, fila_operacion, fila_aplicacion
string articulo, operacion, aplicacion, codigo, articulo_anterior

fila_operacion = dw_2.getrow()
fila_aplicacion = dw_3.getrow()
codigo = f_codigo_principal()
aplicacion = ""
if fila_aplicacion > 0 then
	aplicacion = dw_3.object.aplicacion_tipooperacion[dw_3.getrow()]
end if

//if fila_operacion > 0 and ((codigo = "") or (aplicacion <> "")) then
if fila_operacion > 0 then
	
	operacion = String(dw_2.object.ruta_fabricacion_tipooperacion[fila_operacion])
	articulo_anterior = String(dw_2.object.ruta_fabricacion_articulo_anterior[fila_operacion])
	if isnull(operacion) or operacion = "" then
		MessageBox("Atención","No puede crearse una nueva aplicación, puesto que no ha indicado la operación para la ruta de fabricación seleccionada.",Exclamation!)
		return 2
	end if
	if isnull(articulo_anterior) or articulo_anterior = "" then
		MessageBox("Atención","No puede crearse una nueva aplicación, puesto que no ha indicado el artículo anterior para la ruta de fabricación seleccionada.",Exclamation!)
		return 2
	end if
	articulo = f_codigo_principal()
	orden = dw_3.rowcount() + 1
	
	fila_actual = dw_3.InsertRow(0)
	
	dw_3.object.aplicacion_empresa[fila_actual] = codigo_empresa
	dw_3.object.aplicacion_articulo_anterior [fila_actual] = articulo_anterior
	dw_3.object.aplicacion_orden[fila_actual] = orden
	dw_3.object.aplicacion_tipooperacion[fila_actual] = operacion
	
	dw_3.scrolltorow(fila_actual)
	dw_3.SetColumn(3)
	dw_3.Setfocus()
end if
end event

type pb_1 from picturebutton within wtc_alta_semielaborados_v1
integer x = 69
integer y = 1908
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
string codigo_actual

codigo_actual = f_codigo_principal()
fila_actual = dw_2.InsertRow(0)

dw_2.object.ruta_fabricacion_articulo[fila_actual] = codigo_actual
dw_2.object.ruta_fabricacion_empresa[fila_actual] = codigo_empresa
if dw_2.rowcount() > 1 then
	dw_2.object.ruta_fabricacion_articulo_anterior[fila_actual] = dw_2.object.ruta_fabricacion_articulo_anterior[dw_2.rowcount()-1]
	dw_2.object.articulos_descripcion[fila_actual] = dw_2.object.articulos_descripcion[dw_2.rowcount()-1]
	dw_2.object.ruta_fabricacion_factor[fila_actual] = dw_2.object.ruta_fabricacion_factor[dw_2.rowcount()-1]
	dw_2.object.ruta_fabricacion_prioridad[fila_actual] = 2
else
	dw_2.object.ruta_fabricacion_prioridad[fila_actual] = 1
end if

dw_2.scrolltorow(fila_actual)
dw_2.SetColumn("ruta_fabricacion_tipooperacion")
dw_2.Setfocus()


end event

type pb_2 from picturebutton within wtc_alta_semielaborados_v1
integer x = 219
integer y = 1908
integer width = 146
integer height = 128
integer taborder = 60
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

type tv_escandallo from treeview within wtc_alta_semielaborados_v1
integer x = 2254
integer y = 300
integer width = 3319
integer height = 1624
integer taborder = 130
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean border = false
boolean linesatroot = true
boolean hideselection = false
boolean fullrowselect = true
string picturename[] = {"C:\Tencer_PB12\star_red.png","C:\Tencer_PB12\star_red_base.png","C:\Tencer_PB12\star_yellow_base.png","C:\Tencer_PB12\star_yellow.png"}
integer picturewidth = 32
integer pictureheight = 16
long picturemaskcolor = 536870912
long statepicturemaskcolor = 536870912
end type

event selectionchanged;Treeviewitem tvi
String codigo_nuevo, operacion, articulo_anterior

tv_escandallo.getitem(newhandle,tvi)
//Messagebox("Codigo nuevo", Left(tvi.label, Pos(tvi.label,":")))
codigo_nuevo = Left(tvi.label, Pos(tvi.label," :")-1)

if not isnull(codigo_nuevo) and codigo_nuevo <> "" then
	dw_1.retrieve (codigo_empresa, codigo_nuevo)
	padre_codigo = codigo_nuevo
	estado = 1 // Modo edición
	dw_2.retrieve (codigo_empresa, dw_1.object.articulos_codigo[1])
	dw_3.retrieve(codigo_empresa, dw_1.object.articulos_codigo[1])
	/*
	dw_3.setfilter("aplicacion_tipooperacion = '' ")
	dw_3.Filter()
	*/
	if dw_2.getrow() > 0 then
		operacion = String(dw_2.object.ruta_fabricacion_tipooperacion[dw_2.getrow()])
		articulo_anterior = String(dw_2.object.ruta_fabricacion_articulo_anterior[dw_2.getrow()])
		if not isnull(operacion) and operacion <> "" and not isnull(articulo_anterior) and articulo_anterior <> "" then
			dw_3.setfilter("aplicacion_tipooperacion = '"+operacion+"' AND aplicacion_articulo_anterior = '"+articulo_anterior+"'")
		else
			dw_3.setfilter("aplicacion_tipooperacion = '' AND aplicacion_articulo_anterior = ''")
		end if
	else
		dw_3.setfilter("aplicacion_tipooperacion = '' AND aplicacion_articulo_anterior = ''")
	end if
	dw_3.Filter()
end if
end event

type cb_2 from commandbutton within wtc_alta_semielaborados_v1
integer x = 3365
integer y = 1952
integer width = 713
integer height = 80
integer taborder = 210
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Expandir"
end type

event clicked;Long ll_tvi, temporal

//ll_tvi = tv_escandallo.FindItem(RootTreeItem! , 0)
//tv_escandallo.ExpandAll(ll_tvi)

temporal = tv_escandallo.FindItem(RootTreeItem! , 0)
do while (temporal <> -1)
	tv_escandallo.ExpandAll(temporal)
	temporal	= 	tv_escandallo.FindItem(NextTreeItem!, temporal)
loop
end event

type cb_4 from commandbutton within wtc_alta_semielaborados_v1
integer x = 4105
integer y = 1952
integer width = 713
integer height = 80
integer taborder = 220
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Contraer"
end type

event clicked;
long raiz, hijo, temporal 
int li_tvret

raiz = tv_escandallo.FindItem(RootTreeItem!, 0)
tv_escandallo.SelectItem(raiz)
//temporal = tv_escandallo.FindItem(ChildTreeItem! , raiz)
temporal = raiz
do while (temporal <> -1)
	//tv_escandallo.collapseItem(temporal)
	hijo = tv_escandallo.FindItem(ChildTreeItem! , temporal)
	f_contraer_tv(hijo)
	temporal	= 	tv_escandallo.FindItem(NextTreeItem!, temporal)
loop


end event

type pb_bloquear_estructura from picturebutton within wtc_alta_semielaborados_v1
string tag = "Bloquear/Desbloquear estructura"
integer x = 1751
integer y = 136
integer width = 146
integer height = 128
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "C:\Tencer_PB12\bloquear_estructura.png"
alignment htextalign = left!
string powertiptext = "Bloquear/Desbloquear estructura"
end type

event clicked;Int fila
String codigo

fila = dw_1.getrow()
codigo = ""
if fila > 0 then
	codigo = dw_1.object.articulos_codigo[fila]
end if
if not isnull(codigo) and codigo <> "" and fila > 0 then
	if dw_1.object.articulos_bloqueado[1] = 'S' then
		fr_bloquear(codigo,0)
	else
		fr_bloquear(codigo,1)
	end if
	dw_1.retrieve(codigo_empresa,codigo)
	tv_escandallo.deleteitem(0)
	f_ruta_fabricacion_treeview(codigo, 0, tv_escandallo,1,"ENCAJADO")
end if

end event

type pb_bloquear_1 from picturebutton within wtc_alta_semielaborados_v1
string tag = "Bloquear/Desbloquear articulo"
integer x = 1902
integer y = 136
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
boolean originalsize = true
string picturename = "C:\Tencer_PB12\bloquear.png"
alignment htextalign = left!
string powertiptext = "Bloquear/Desbloquear articulo"
end type

event clicked;Int fila
String codigo

fila = dw_1.getrow()
codigo = ""
if fila > 0 then
	codigo = dw_1.object.articulos_codigo[fila]
end if
if not isnull(codigo) and codigo <> "" and fila > 0 then
	if dw_1.object.articulos_bloqueado[1] = 'S' then
		update articulos
		set bloqueado = 'N'
		where empresa = :codigo_empresa
		and codigo = :codigo using sqlca;
	else
		update articulos
		set bloqueado = 'S'
		where empresa = :codigo_empresa
		and codigo = :codigo using sqlca;
	end if
	dw_1.retrieve(codigo_empresa,codigo)
end if

end event

type st_mensaje from statictext within wtc_alta_semielaborados_v1
integer x = 2162
integer y = 152
integer width = 1984
integer height = 84
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 19474154
long backcolor = 67108864
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within wtc_alta_semielaborados_v1
integer x = 4837
integer y = 1952
integer width = 713
integer height = 80
integer taborder = 220
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Mostrar Ruta Principal"
end type

event clicked;long raiz, hijo, temporal, temporal_anterior, contador
int li_tvret

raiz = tv_escandallo.FindItem(RootTreeItem!, 0)
tv_escandallo.SelectItem(raiz)
fr_ruta_principal(raiz)
/*
raiz = tv_escandallo.FindItem(RootTreeItem!, 0)
tv_escandallo.SelectItem(raiz)
//temporal = tv_escandallo.FindItem(ChildTreeItem! , raiz)
temporal = raiz
//do while (temporal <> -1)
//	temporal_anterior = temporal
//	tv_escandallo.collapseItem(temporal)
//	hijo = tv_escandallo.FindItem(ChildTreeItem! , temporal)
//	//f_contraer_tv(hijo)
//	temporal	= 	tv_escandallo.FindItem(NextTreeItem!, temporal)
//	if temporal = -1 then
//		f_contraer_tv(hijo)
//		tv_escandallo.expandItem(temporal_anterior)
//	end if
//loop
contador = 0
do while (temporal <> -1)
	contador ++
	tv_escandallo.collapseItem(temporal)
	hijo = tv_escandallo.FindItem(ChildTreeItem! , temporal)
	f_contraer_tv(hijo)
	temporal	= 	tv_escandallo.FindItem(NextTreeItem!, temporal)
	if contador = 1 then
		f_contraer_tv(hijo)
		tv_escandallo.expandItem(temporal_anterior)
	end if
loop
*/
end event

type pb_3 from picturebutton within wtc_alta_semielaborados_v1
string tag = "Anular/Activar estructura"
integer x = 1349
integer y = 136
integer width = 146
integer height = 128
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "C:\Tencer_PB12\anular_estructura.png"
alignment htextalign = left!
string powertiptext = "Anular/Activar estructura"
end type

event clicked;String codigo, fecha_anulado
str_ventana_alerta parametros
string botones[2]
Int fila

fila = dw_1.getrow()
codigo = ""
if fila > 0 then
	codigo = dw_1.object.articulos_codigo[fila]
end if
if not isnull(codigo) and codigo <> "" and fila > 0 then
	fecha_anulado = String(dw_1.object.articulos_fecha_anulado[dw_1.getrow()])
	if isnull(fecha_anulado) or fecha_anulado = "" then
		/*
		parametros.titulo = "Atención"
		parametros.subtitulo = "ANULAR ESTRUCTURA"
		parametros.mensaje = "Va a anular TODA LA ESTRUCTURA del artículo seleccionado, ¿Desea continuar?"
		parametros.tipo = 1
		botones[1] = "Sí"
		botones[2] = "No"
		parametros.botones = botones
		parametros.mostrar_imagen = true
		openwithparm(wtc_ventana_alerta, parametros)
		borrar = Int(Message.DoubleParm)
		if borrar = 2 then
			return
		end if
		*/
		if MessageBox("ANULAR ESTRUCTURA","Va a anular TODA LA ESTRUCTURA del artículo seleccionado, ¿Desea continuar?", Question!, YesNo!, 2) = 2 then
			return
		end if
		fr_anular(codigo,1)
	else
		/*
		if MessageBox("Aviso", "Se va a proceder a la activación de la estructura del artículo seleccionado.~n¿Está seguro de que desea continuar?~n~nPor favor, asegurese de que desea activar toda la estructura y no un artículo de forma individual.",Question!,YesNo!,2) = 2 then
			return
		end if
		*/
		fr_anular(codigo,0)
	end if
	tv_escandallo.deleteitem(0)
	f_ruta_fabricacion_treeview(codigo, 0, tv_escandallo,1,"INICIO")
	dw_1.retrieve(codigo_empresa,codigo)
end if

end event

type pb_4 from picturebutton within wtc_alta_semielaborados_v1
string tag = "Anular/Activar articulo"
integer x = 1509
integer y = 136
integer width = 146
integer height = 128
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\anular.png"
alignment htextalign = left!
string powertiptext = "Anular/Activar articulo"
end type

event clicked;Datetime ahora
String descripcion, fecha_anulado, codigo
Long posicion, fila
ahora = Datetime(Today(),Now())
 
fila = dw_1.getrow()
codigo = ""
if fila > 0 then
	codigo = dw_1.object.articulos_codigo[fila]
end if
if not isnull(codigo) and codigo <> "" and fila > 0 then
	fecha_anulado = String(dw_1.object.articulos_fecha_anulado[fila])
	if isnull(fecha_anulado) or fecha_anulado = "" then
		descripcion = trim(dw_1.object.articulos_descripcion[fila])
		if pos(descripcion,"NULO") <> 1 then
			descripcion = "NULO "+descripcion		
		end if
		
		update articulos
		set 
				fecha_anulado = :ahora,
				descripcion = :descripcion
		where empresa = :codigo_empresa
				and codigo = :codigo;
				
	else
		
		descripcion = trim(dw_1.object.articulos_descripcion[fila])
		posicion = pos(descripcion,"NULO")
		if posicion = 1 then
			descripcion = trim(mid(descripcion, posicion+4))
		else
			if MessageBox("Aviso","La descripción del artículo "+codigo+" no contiene en su inicio la palabra NULO y no se quitará de la descripción si está en otra posición.~n¿Desea continuar de todas formas?",Question!,YesNo!,2) = 2 then
				return
			end if
		end if
		
		update articulos
		set 
				fecha_anulado = NULL,
				descripcion = :descripcion
		where empresa = :codigo_empresa
				and codigo = :codigo;
				
	end if
	tv_escandallo.deleteitem(0)
	f_ruta_fabricacion_treeview(codigo, 0, tv_escandallo,1,"INICIO")
	dw_1.retrieve(codigo_empresa,codigo)
end if
end event

type dw_listado_ficha from datawindow within wtc_alta_semielaborados_v1
boolean visible = false
integer x = 4983
integer y = 1560
integer width = 311
integer height = 180
integer taborder = 160
boolean bringtotop = true
string dataobject = "report_ficha_tecnica_operaciones"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_2 from groupbox within wtc_alta_semielaborados_v1
integer x = 1710
integer y = 80
integer width = 384
integer height = 204
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 23016974
long backcolor = 67108864
string text = "Bloquear"
end type

type p_1 from picture within wtc_alta_semielaborados_v1
integer x = 2263
integer y = 1928
integer width = 146
integer height = 64
boolean bringtotop = true
boolean originalsize = true
string picturename = "C:\Tencer_PB12\star_red.png"
boolean focusrectangle = false
end type

type p_2 from picture within wtc_alta_semielaborados_v1
integer x = 2263
integer y = 1988
integer width = 146
integer height = 64
boolean bringtotop = true
boolean originalsize = true
string picturename = "C:\Tencer_PB12\star_yellow.png"
boolean focusrectangle = false
end type

type p_3 from picture within wtc_alta_semielaborados_v1
integer x = 2880
integer y = 1964
integer width = 146
integer height = 64
boolean bringtotop = true
boolean originalsize = true
string picturename = "C:\Tencer_PB12\circle_blue.png"
boolean focusrectangle = false
end type

type st_1 from statictext within wtc_alta_semielaborados_v1
integer x = 2405
integer y = 1932
integer width = 347
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Ruta Principal"
boolean focusrectangle = false
end type

type st_2 from statictext within wtc_alta_semielaborados_v1
integer x = 2405
integer y = 1992
integer width = 402
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Ruta Alternativa"
boolean focusrectangle = false
end type

type st_3 from statictext within wtc_alta_semielaborados_v1
integer x = 3013
integer y = 1964
integer width = 325
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Base"
boolean focusrectangle = false
end type

type p_imagen from picture within wtc_alta_semielaborados_v1
integer x = 4279
integer width = 763
integer height = 296
boolean bringtotop = true
boolean focusrectangle = false
end type

type r_1 from rectangle within wtc_alta_semielaborados_v1
long linecolor = 16777215
integer linethickness = 4
long fillcolor = 16777215
integer x = 2249
integer y = 1924
integer width = 3323
integer height = 132
end type

type gb_3 from groupbox within wtc_alta_semielaborados_v1
integer x = 2258
integer y = 1896
integer width = 3314
integer height = 164
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 19474154
long backcolor = 67108864
end type

type dw_2 from u_dw within wtc_alta_semielaborados_v1
integer x = 41
integer y = 800
integer width = 2213
integer height = 1260
integer taborder = 20
string dataobject = "dwtc_alta_semielaborados_rutas"
end type

event itemchanged;call super::itemchanged;string resultado, resultado1, operacion, descripcion
Int i, numero_filas
this.Accepttext()

CHOOSE CASE dwo.name
	CASE "ruta_fabricacion_tipooperacion"
		//Comprobación de que se selecciona una operación NO REPETIDA
		/*
		if dw_2.rowcount() > 1 then
			descripcion = dw_2.object.tipooperacion_descripcion[row]
			SELECT codigo INTO :operacion FROM tipooperacion WHERE descripcion = :descripcion;
			numero_filas = dw_2.Find("ruta_fabricacion_tipooperacion = '"+data+"'",1,this.rowcount())
			if numero_filas > 0 then
				if numero_filas <> row then
					this.object.ruta_fabricacion_tipooperacion[Row] 		= operacion
					Messagebox("Error", "No puede seleccionar una operación ya existente en otra ruta",Exclamation!)
					return 2	
				else
					if numero_filas+1 <= this.rowcount() then
						numero_filas = dw_2.Find("ruta_fabricacion_tipooperacion = '"+data+"'",numero_filas+1,this.rowcount())
						if numero_filas > 0 then
							this.object.ruta_fabricacion_tipooperacion[Row] 		= operacion
							Messagebox("Error", "No puede seleccionar una operación ya existente en otra ruta",Exclamation!)
							return 2		
						end if
					end if
				end if
			end if
		end if
		*/
		//Aviso de cambio de operación
		if not isnull(operacion) and operacion <> "" then
			if Messagebox("Aviso", "Si cambia el tipo de operación borrará las aplicaciones existentes para esta ruta. ¿Desea continuar?",Question!,YesNo!,2) = 2 then
				return 2
			end if
		end if
		
		SELECT descripcion 
		INTO :resultado1
		FROM tipooperacion
		WHERE tipooperacion.empresa = :codigo_empresa
		and tipooperacion.codigo = :data;

		if SQLCA.sqlcode <> 100 then
			this.object.tipooperacion_descripcion[Row] 		= resultado1
			dw_3.setfilter("aplicacion_tipooperacion = '"+String(data)+"'") //Mostramos solo las aplicaciones del centro de coste seleccionado
			dw_3.filter()
		else
			dwo.Primary[row] = ''
			this.object.tipooperacion_descripcion[Row] 		= ''
			dw_3.setfilter("aplicacion_tipooperacion = '' ") //De este modo no mostramos las operaciones de ningún centro de coste
			dw_3.filter()
			return 2			
		end if
		
		if operacion <> "" and operacion <> data then
			//Borrar aplicaciones
			dw_3.setfilter("aplicacion_tipooperacion = '"+operacion+"'") //Mostramos solo las aplicaciones del centro de coste seleccionado
			dw_3.filter()
			numero_filas = dw_3.rowcount() 
			for i = 1 To numero_filas
				dw_3.deleterow(i)
			next
		end if
	
		
	CASE "ruta_fabricacion_articulo_anterior"
		SELECT descripcion
		INTO :resultado1 
		FROM articulos 
		WHERE articulos.empresa = :codigo_empresa AND articulos.codigo = :data; 
		if SQLCA.sqlcode <> 100 then
			this.object.articulos_descripcion[this.GetRow()] 		= resultado1
		else
			dwo.Primary[row] = ''
			this.object.articulos_descripcion[this.GetRow()] 		= ''
			return 2			
		end if
	CASE "ruta_fabricacion_ruta"
		SELECT descripcion
		INTO :resultado1 
		FROM ruta_descripcion 
		WHERE ruta_descripcion.empresa = :codigo_empresa AND ruta_descripcion.codigo = :data; 
		if SQLCA.sqlcode <> 100 then
			this.object.ruta_descripcion_descripcion[this.GetRow()] 		= resultado1
		else
			dwo.Primary[row] = ''
			this.object.ruta_descripcion_descripcion[this.GetRow()] 		= ''
			return 2			
		end if
END CHOOSE

end event

event usr_dwnkey;call super::usr_dwnkey;string campo, operacion
Int i, numero_filas
str_wt_busquedas_salida resultado
str_wt_busquedas_entrada busqueda

control_teclas (keyflags, key)

busqueda.filtro_es_codigo = false
if key =  keyEnter! then
	campo = This.GetColumnName()
	CHOOSE CASE campo
		CASE "ruta_fabricacion_tipooperacion"
			operacion = this.object.ruta_fabricacion_tipooperacion[this.getrow()]
			if operacion <> "" then
				if Messagebox("Aviso", "Si cambia el tipo de operación borrará las aplicaciones existentes para esta ruta. ¿Desea continuar?",Question!,YesNo!,2) = 2 then
					return
				end if
			end if
			
			busqueda.titulo_ventana = "Búsqueda de Tipos de Operación"
			busqueda.consulta  = " SELECT codigo, descripcion "+&
										" FROM tipooperacion "+&
										" WHERE empresa = '"+codigo_empresa+"'"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Descripción"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				//Comprobación de que se selecciona una operación NO REPETIDA
				numero_filas = dw_2.Find("ruta_fabricacion_tipooperacion = '"+resultado.valores[1]+"'",1,dw_2.rowcount())
				if numero_filas > 0 then
					Messagebox("Error", "No puede seleccionar una operación ya existente en otra ruta",Exclamation!)
					return 2		
				end if
				this.object.ruta_fabricacion_tipooperacion[this.GetRow()] 	= resultado.valores[1]
				this.object.tipooperacion_descripcion[this.GetRow()] 			= resultado.valores[2]			
				if operacion <> "" and operacion <> resultado.valores[1] then
					//Borrar aplicaciones
					dw_3.setfilter("aplicacion_tipooperacion = '"+operacion+"'") //Mostramos solo las aplicaciones del centro de coste seleccionado
					dw_3.filter()
					numero_filas = dw_3.rowcount() 
					for i = 1 To numero_filas
						dw_3.deleterow(i)
					next
				end if
			end if
		CASE "ruta_fabricacion_articulo_anterior"
			busqueda.consulta =  "SELECT articulos.codigo, articulos.descripcion, formatos.abreviado, almusos.descripcion, genter.razon "+&
							"FROM articulos "+&
							"INNER JOIN almusos ON articulos.uso = almusos.codigo and articulos.empresa = almusos.empresa "+&
							"LEFT OUTER JOIN genter ON articulos.cliente = genter.codigo and articulos.empresa = genter.empresa "+&
							"LEFT OUTER JOIN formatos ON articulos.formato = formatos.codigo and articulos.empresa = formatos.empresa "+&
							"WHERE articulos.empresa = '"+codigo_empresa+"' AND "+&
							"articulos.fecha_anulado IS NULL AND "+&
							"(genter.tipoter IS NULL OR genter.tipoter = 'C')"+&
							"ORDER BY articulos.descripcion"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Descripción"
			busqueda.titulos[3] = "Formato"
			busqueda.titulos[4] = "Uso"
			busqueda.titulos[5] = "Cliente"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				this.object.ruta_fabricacion_articulo_anterior[this.GetRow()] 	= resultado.valores[1]
				this.object.articulos_descripcion[this.GetRow()] 			= resultado.valores[2]			
			end if
		CASE "ruta_fabricacion_ruta"
			operacion = this.object.ruta_fabricacion_tipooperacion[this.getrow()]
			if isnull(operacion) or operacion = "" then
				Messagebox("Error", "Debe indicar una operación antes de seleccionar la Descripción de la Ruta")
				return
			end if
			busqueda.titulo_ventana = "Búsqueda de Tipos de Ruta"
			busqueda.consulta  = " SELECT codigo, descripcion "+&
										" FROM ruta_descripcion "+&
										" WHERE empresa = '"+codigo_empresa+"' AND "+&
										" codigo IN (SELECT ruta_descripcion FROM tipooperacion_ruta_descripcion WHERE tipooperacion = '"+operacion+"')"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Descripción"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				this.object.ruta_fabricacion_ruta[this.GetRow()] 			= resultado.valores[1]
				this.object.ruta_descripcion_descripcion[this.GetRow()] 	= resultado.valores[2]			
			end if
	END CHOOSE
end if	
	
end event

event clicked;call super::clicked;str_parametros lstr_param
long esta_abierta, i
String operacion, articulo_anterior

if not isnull(dwo) then
	CHOOSE CASE dwo.name
	
		CASE "p_tipooperacion"
			esta_abierta = f_menu_ventana_esta_abierta("wtc_mant_tipooperacion")
			//Abrimos la ventana si no está abierta ya. En caso contrario la mostramos
			if esta_abierta = -1 then
				if this.object.ruta_fabricacion_tipooperacion[row] <> "" then
					lstr_param.s_argumentos[1] = this.object.ruta_fabricacion_tipooperacion[row]
					lstr_param.i_nargumentos = 1
					lstr_param.nombre_ventana = "wtc_alta_semielaborados"
					lstr_param.resultado = ''
					Openwithparm(wtc_mant_tipooperacion, lstr_param)
				else
					Openwithparm(wtc_mant_tipooperacion, lstr_param)
				end if
			else
				ventanas_activas[esta_abierta].ventana.BringToTop = true
			end if
			
	END CHOOSE
end if

if row > 0 then 

	operacion = String(this.object.ruta_fabricacion_tipooperacion[row])
	articulo_anterior = String(this.object.ruta_fabricacion_articulo_anterior[row])
	if operacion <> "" and articulo_anterior <> "" then
		dw_3.setfilter("aplicacion_tipooperacion = '"+operacion+"' AND aplicacion_articulo_anterior = '"+articulo_anterior+"'") //Mostramos solo las aplicaciones de la ruta de fabricación seleccionada
		dw_3.filter()
	else
		dw_3.setfilter("aplicacion_tipooperacion = '' AND aplicacion_articulo_anterior = ''") //No Mostramos aplicaciones de ninguna ruta
		dw_3.filter()
	end if
end if

end event

type dw_3 from u_dw within wtc_alta_semielaborados_v1
integer x = 41
integer y = 2060
integer width = 5531
integer height = 904
integer taborder = 30
string dataobject = "dwtc_alta_semielaborados_aplicaciones"
end type

event itemchanged;call super::itemchanged;string resultado
dec  resultado1, resultado2
Dec gram_7x20, gramaje, ancho, largo

String tipoaplicacion, desc_formula, formula_estandar, formula_unidad, formula, formula_nueva, tiff, desc_unidad, sel2, mprima, proveedor
str_colisiones param_colisiones2
transaction trm
datastore mprimas
datetime ahora
int rtn2, j, numero2

this.Accepttext()

CHOOSE CASE dwo.name
	CASE "aplicacion_tipoaplicacion"
		SELECT tipoaplicacion.abreviado
		INTO :resultado
		FROM tipoaplicacion
		WHERE empresa = :codigo_empresa
		and tipoaplicacion.codigo = :data;

		if SQLCA.sqlcode <> 100 then
			this.object.tipoaplicacion_abreviado[Row] 		= resultado
		else
			dwo.Primary[row] = ''
			this.object.tipoaplicacion_abreviado[Row] 		= ''
			return 2			
		end if

	CASE "aplicacion_formula"
		SELECT prodformula.descripcion_produccion  
		INTO :resultado 
		FROM prodformula
		WHERE empresa = :codigo_empresa
		and prodformula.formula = :data;

		if SQLCA.sqlcode <> 100 then
			this.object.prodformula_descripcion_produccion[Row] 		= resultado
		else
			//Creación Automática de Fórmulas estándar
			tipoaplicacion = this.object.aplicacion_tipoaplicacion[row]
			if not isnull(tipoaplicacion) and tipoaplicacion <> "" and not isnull(data) and data <> "" then
				SELECT formula, descripcion_laboratorio INTO :formula, :resultado FROM prodformula WHERE empresa = :codigo_empresa AND descripcion_laboratorio = :data;
				if not isnull(formula) and formula <> "" then 
					this.object.prodformula_descripcion_produccion[Row] = resultado
					dwo.Primary[row] = formula
					return 2
				end if
				SELECT formula_estandar, formula_unidad INTO :formula_estandar, :formula_unidad FROM prodaplicaciones WHERE empresa = :codigo_empresa AND codigo = :tipoaplicacion;
				if formula_estandar = '1' then
					if MessageBox("Creación Formula Estándard","¿Desea generar una formula estándar con la descripcción "+data+"?",Question!,YesNo!,2) = 1 then
						
						//CREAR NUEVA FORMULA (Si existiera ya la ubiera encontrado f_nombre_formulacion_produccion)
						
						f_crear_transaccion(trm,"","",false,"TS","")
						CONNECT USING trm;
						param_colisiones2.empresa = codigo_empresa
						param_colisiones2.tabla = "prodformula"
						param_colisiones2.campo = "formula"
						param_colisiones2.filtro = ""
						param_colisiones2.buscar_huecos = false
						formula_nueva = String(f_colisiones(trm, param_colisiones2))
						ahora = datetime(today(),now())
						rtn2 = 1
						
						SELECT abreviado INTO :desc_unidad FROM comunimedida WHERE codigo = :formula_unidad USING trm;
						desc_unidad = lower(desc_unidad)
						tiff = data
						INSERT INTO prodformula (empresa, formula, descripcion_produccion, descripcion_laboratorio, fecha_alta, empleado, paletacolor, colorimetro, coste_kg_formula, 
														textura, activa_en_produccion, mp_equivalente, referencia_general, unidad_coste) 
						VALUES (:codigo_empresa, :formula_nueva, :tiff, :tiff, :ahora, NULL, NULL, NULL, NULL, NULL, 'S', NULL, NULL, :formula_unidad) USING trm;
						IF trm.SQLCode <> 0 THEN         
							MessageBox("SQL error Fórmula", trm.SQLErrText)
							rtn2 = -1
						END IF
						
						//Componentes de la formula (extraidos de la estándar)
						sel2 = "SELECT mprima, proveedor FROM prodaplicacion_mprima WHERE empresa = '"+codigo_empresa+"' AND aplicacion = '"+tipoaplicacion+"'"
						f_cargar_cursor_trans (trm,  sel2,  mprimas)
						numero2 = mprimas.RowCount()
						j = 1
						do while (j <= numero2 AND rtn2 = 1) 
							mprima = mprimas.object.mprima[j]
							proveedor = mprimas.object.proveedor[j]
							
							INSERT INTO proddetformula (empresa, formulacion, mp, cantidad, unidadmedida, proveedor, cantidad_u_m_mp, unidad_u_m_mp, coste_mp) 
							VALUES (:codigo_empresa, :formula_nueva, :mprima, NULL, :desc_unidad, :proveedor, 0, :formula_unidad ,0) USING trm;
							IF trm.SQLCode <> 0 THEN         
								MessageBox("SQL error Componentes Fórmula ", trm.SQLErrText)
								rtn2 = -1
							END IF
							j++
						loop
						mprimas.reset()
						
						if rtn2 = 1 then
							//OK
							COMMIT USING trm;
							DISCONNECT USING trm;
							dwo.Primary[row] = formula_nueva
							this.object.prodformula_descripcion_produccion[row] = tiff
							destroy trm
							destroy mprimas
							return 2
						else
							//Error BD
							ROLLBACK USING trm;
							DISCONNECT USING trm;
							dwo.Primary[row] = ''
							this.object.prodformula_descripcion_produccion[Row] 		= ''
							destroy trm
							destroy mprimas
							MessageBox("Error Creación Formula Estándar","Ha ocurrido un error al crear la formula estándar.")
							return 2
						end if
					else
						//No desea crear fórmula nueva
						dwo.Primary[row] = ''
						this.object.prodformula_descripcion_produccion[row] = ""
						destroy trm
						destroy mprimas
						return 2	
					end if
				end if
			else 
				//No se cumplen condiciones para crear formula estándar
				dwo.Primary[row] = ''
				this.object.prodformula_descripcion_produccion[Row] 		= ''
				destroy trm
				destroy mprimas
				return 2
			end if
		end if

	CASE "aplicacion_pantalla"
		SELECT prodpantallas.descripcion, prodpantallas.numero_hilos, prodpantallas.paso_cliche
		INTO :resultado, :resultado1, :resultado2 
		FROM prodpantallas
		WHERE empresa = :codigo_empresa
		and prodpantallas.codigo = :data;

		if SQLCA.sqlcode <> 100 then
			this.object.prodpantallas_descripcion[Row] 		= resultado
			this.object.prodpantallas_numero_hilos[Row] 		= resultado1
			this.object.prodpantallas_paso_cliche[Row] 		= resultado2
		else
			dwo.Primary[row] = ''
			this.object.prodpantallas_descripcion[Row] 		= ''
			this.object.prodpantallas_numero_hilos[Row] 		= 0
			this.object.prodpantallas_paso_cliche[Row] 		= 0
			return 2			
		end if

	CASE "aplicacion_perfil"
		SELECT perfil_color.abreviado
		INTO :resultado
		FROM perfil_color
		WHERE empresa = :codigo_empresa
		and perfil_color.codigo = :data;

		if SQLCA.sqlcode <> 100 then
			this.object.perfil_color_abreviado[Row] 		= resultado
		else
			dwo.Primary[row] = ''
			this.object.perfil_color_abreviado[Row] 		= ''
			return 2			
		end if
	
	CASE "aplicacion_gram_7x20"  // Cálculo del gramaje de la pieza a partir del gramaje en una pieza de 7x20
		if not isnull (dw_3.object.aplicacion_gram_7x20) then
			gram_7x20 = dw_3.object.aplicacion_gram_7x20[row]
			ancho = dw_1.object.formatos_ancho[dw_3.getrow()]
			largo = dw_1.object.formatos_largo[dw_3.getrow()]
			
			
			gramaje = ancho * largo * ( gram_7x20 / (7 * 20) )
			dw_3.object.aplicacion_gramaje[row] = gramaje
		
		end if
	
END CHOOSE


this.Accepttext()
end event

event usr_dwnkey;call super::usr_dwnkey;string campo, tipooperacion
str_wt_busquedas_salida resultado
str_wt_busquedas_entrada busqueda

control_teclas (keyflags, key)

busqueda.filtro_es_codigo = false
if key =  keyEnter! then
	campo = This.GetColumnName()
	CHOOSE CASE campo
		CASE "aplicacion_tipoaplicacion"
			tipooperacion = dw_2.object.ruta_fabricacion_tipooperacion[dw_2.getrow()]
			if isnull(tipooperacion) or tipooperacion = "" then
				MessageBox("Atención", "Debe indicar la operación de la ruta seleccionada antes de indicar las aplicaciones.")
				return 2
			end if
			busqueda.titulo_ventana = "Búsqueda de Tipo de Aplicación"
			busqueda.consulta  = " SELECT CODIGO, ABREVIADO, DESCRIPCION "+&
										" FROM tipoaplicacion "+&
										" WHERE empresa = '"+codigo_empresa+"' AND "+&
										" codigo IN (SELECT tipoaplicacion FROM tipooperacion_tipoaplicacion WHERE tipooperacion = '"+tipooperacion+"')ORDER BY DESCRIPCION"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Abreviado "
			busqueda.titulos[3] = "Descripción"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				this.object.aplicacion_tipoaplicacion[this.GetRow()] 		= resultado.valores[1]		
				this.object.tipoaplicacion_abreviado[this.GetRow()] 		= resultado.valores[2]		
			end if

		CASE "aplicacion_formula"
			busqueda.titulo_ventana = "Búsqueda de Formula"
			busqueda.consulta  = " SELECT formula, descripcion_laboratorio, descripcion_produccion, activa_en_produccion "+&
										" FROM prodformula "+&
										" WHERE empresa = '"+codigo_empresa+"' ORDER BY descripcion_produccion"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Descripción Laboratorio"
			busqueda.titulos[3] = "Descripción Producción "
			busqueda.titulos[4] = "Activa Producción"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				this.object.aplicacion_formula[this.GetRow()] 						= resultado.valores[1]	
				this.object.prodformula_descripcion_produccion[this.GetRow()] 	= resultado.valores[3]		
			end if

		CASE "aplicacion_pantalla"
			busqueda.titulo_ventana = "Búsqueda de Pantallas"
			busqueda.consulta  = " SELECT CODIGO, DESCRIPCION, numero_hilos, paso_cliche "+&
										" FROM prodpantallas "+&
										" WHERE empresa = '"+codigo_empresa+"' ORDER BY DESCRIPCION"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Descripción"
			busqueda.titulos[3] = "Hilos"
			busqueda.titulos[4] = "Paso"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				this.object.aplicacion_pantalla[this.GetRow()] 			= resultado.valores[1]		
				this.object.prodpantallas_descripcion[this.GetRow()] 	= resultado.valores[2]		
				this.object.prodpantallas_numero_hilos[this.GetRow()] = dec(resultado.valores[3])
				this.object.prodpantallas_paso_cliche[this.GetRow()] 	= dec(resultado.valores[4])
			end if
			
		CASE "aplicacion_perfil"
			busqueda.titulo_ventana = "Búsqueda de Perfil de Color"
			busqueda.consulta  = " SELECT codigo, abreviado, descripcion, carpeta "+&
										" FROM perfil_color "+&
										" WHERE empresa = '"+codigo_empresa+"' ORDER BY DESCRIPCION"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Abreviado"
			busqueda.titulos[3] = "Descripción"
			busqueda.titulos[4] = "Carpeta"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				this.object.aplicacion_pantalla[this.GetRow()] 			= resultado.valores[1]		
				this.object.prodpantallas_descripcion[this.GetRow()] 	= resultado.valores[2]		
				this.object.prodpantallas_numero_hilos[this.GetRow()] = dec(resultado.valores[3])
				this.object.prodpantallas_paso_cliche[this.GetRow()] 	= dec(resultado.valores[4])
			end if	
			
	END CHOOSE
end if	
	
end event

event clicked;call super::clicked;str_parametros lstr_param
long esta_abierta

CHOOSE CASE dwo.name
	CASE "p_tipoaplicacion"
		
		esta_abierta = f_menu_ventana_esta_abierta("wtc_mant_tipoaplicacion")
		//Abrimos la ventana si no está abierta ya. En caso contrario la mostramos
		if esta_abierta = -1 then
			lstr_param.s_argumentos[1] = this.object.aplicacion_tipoaplicacion[this.getrow()]
			lstr_param.i_nargumentos = 1
			lstr_param.nombre_ventana = "wtc_alta_semielaborados"
			lstr_param.resultado = ''
			Openwithparm(wtc_mant_tipoaplicacion, lstr_param)
		else
			ventanas_activas[esta_abierta].ventana.BringToTop = true
		end if
	
	CASE "p_formula"
		esta_abierta = f_menu_ventana_esta_abierta("wi_mant_formulaciones")
		//Abrimos la ventana si no está abierta ya. En caso contrario la mostramos
		if esta_abierta = -1 then
			lstr_param.s_argumentos[1]  = "wtc_alta_semielaborados"
			lstr_param.s_argumentos[2]  = this.object.aplicacion_formula[this.getrow()]
			lstr_param.i_nargumentos    = 2
			OpenWithParm(wi_mant_formulaciones, lstr_param)
		else
			ventanas_activas[esta_abierta].ventana.BringToTop = true
		end if
	
	CASE "p_pantallas"
		esta_abierta = f_menu_ventana_esta_abierta("wi_mant_prodpantallas")
		//Abrimos la ventana si no está abierta ya. En caso contrario la mostramos
		if esta_abierta = -1 then
			lstr_param.s_argumentos[1]  = "wtc_alta_semielaborados"
			lstr_param.s_argumentos[2]  = this.object.aplicacion_pantalla[this.getrow()]	
			lstr_param.i_nargumentos    = 2
			OpenWithParm(wi_mant_prodpantallas, lstr_param)
		else
			ventanas_activas[esta_abierta].ventana.BringToTop = true
		end if
		
	CASE "p_perfil"
		esta_abierta = f_menu_ventana_esta_abierta("wtc_mant_perfil_color")
		//Abrimos la ventana si no está abierta ya. En caso contrario la mostramos
		if esta_abierta = -1 then
			lstr_param.s_argumentos[1]  = "wtc_alta_semielaborados"
			lstr_param.s_argumentos[2]  = this.object.aplicacion_pantalla[this.getrow()]	
			lstr_param.i_nargumentos    = 2
			OpenWithParm(wtc_mant_perfil_color, lstr_param)
		else
			ventanas_activas[esta_abierta].ventana.BringToTop = true
		end if
		
END CHOOSE

end event

