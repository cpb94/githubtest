$PBExportHeader$wt_ventana_padre.srw
forward
global type wt_ventana_padre from window
end type
type pb_imprimir from picturebutton within wt_ventana_padre
end type
type p_logo from picture within wt_ventana_padre
end type
type dw_1 from datawindow within wt_ventana_padre
end type
type pb_borrar from picturebutton within wt_ventana_padre
end type
type pb_salir from picturebutton within wt_ventana_padre
end type
type pb_grabar from picturebutton within wt_ventana_padre
end type
type st_titulo from statictext within wt_ventana_padre
end type
type pb_nuevo from picturebutton within wt_ventana_padre
end type
type pb_cancelar from picturebutton within wt_ventana_padre
end type
type pb_buscar from picturebutton within wt_ventana_padre
end type
end forward

global type wt_ventana_padre from window
integer width = 2304
integer height = 1428
boolean titlebar = true
string title = "Untitled"
string menuname = "mi_menu_generico"
boolean controlmenu = true
boolean minbox = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
event ue_cerrar_sin_abrir ( )
pb_imprimir pb_imprimir
p_logo p_logo
dw_1 dw_1
pb_borrar pb_borrar
pb_salir pb_salir
pb_grabar pb_grabar
st_titulo st_titulo
pb_nuevo pb_nuevo
pb_cancelar pb_cancelar
pb_buscar pb_buscar
end type
global wt_ventana_padre wt_ventana_padre

type variables
//Permisos Ventana
Boolean cerrar_sin_abrir
Int permiso_ventana
string is_permiso_altas,is_permiso_bajas,is_permiso_cambios,is_permiso_consultas
boolean ib_control_acceso_pasado = false

// Nombre que pone al titulo de la ventana, el mantenimiento que la llama (Si está en blanco el título establecido)
string nombre_ventana_invoca

//Ventana que ha llamado a esta ventana
String ventana_invoca

// clave primaria de la tabla principal
string padre_codigo

// La variable estado tomará los siguientes valores
// 0: Inserción
// 1: Edición
integer estado

// La variable tipo_de_clave_primaria tomará los siguientes valores
// 0: Automático  (Será una clae de tipo autoincrementativo)
// 1: Manual
integer tipo_de_clave_primaria


// Parametrosde la Transaccion global de la ventana
str_param_transaccion param_transaccion

// Devuelve 1 si confirmamos la grabación.
integer grabar

// Devuelve 1 si confirmamos el borrado
integer borrar

//Resultado de la transaccion
long rtn

Long id_ventana_activa
Long datos_iniciales

Public:
	str_wt_busquedas_entrada padre_busqueda
	str_colisiones param_colisiones


end variables

forward prototypes
public subroutine control_teclas (unsignedlong arg_keyflags, keycode arg_key)
public function boolean hay_cambios ()
public function integer f_guardar ()
public function integer f_borrar ()
public subroutine mostrar_controles_insercion ()
public subroutine mostrar_controles_edicion ()
public function string f_codigo_principal ()
public function boolean f_post_asignar_codigo_padre ()
end prototypes

event ue_cerrar_sin_abrir();if cerrar_sin_abrir = true then
	close(this)
end if
end event

public subroutine control_teclas (unsignedlong arg_keyflags, keycode arg_key);If arg_KeyFlags = 2 then
	choose case arg_key
		case KeyEnter!
		case KeyN!
			pb_nuevo.triggerevent(clicked!)
		case KeyB!
			pb_borrar.triggerevent(clicked!)
		case KeyS!
			pb_grabar.triggerevent(clicked!)
		case KeyZ!
			pb_cancelar.triggerevent(clicked!)
	end choose		
else
	choose case arg_Key
		case KeyEnter!
		case KeyF2!
			pb_nuevo.triggerevent(clicked!)
		case KeyF3!
			pb_borrar.triggerevent(clicked!)
		case KeyF4!
			pb_grabar.triggerevent(clicked!)
		case KeyF8!
			pb_buscar.triggerevent(clicked!)
		case KeyEscape!
			pb_salir.triggerevent(clicked!)
	end choose		
end if


end subroutine

public function boolean hay_cambios ();Boolean resultado
resultado = false

dw_1.accepttext() //Necesario para que se detecten los cambios en el campo en el que se tiene el foco

if dw_1.DeletedCount() + dw_1.ModifiedCount() > 0 then
	resultado = true
end if

return resultado
end function

public function integer f_guardar ();// El primer campo del datawindow será el que reciba el código generado. 
// Por tanto, al crear el datawindow maestro debemos situar en primera posición dicho campo
dw_1.accepttext()

//Codigo por si se desea mostrar aviso antes de guardar (Por defecto NO, si no utilizar Message.DoubleParm = 10001)
dw_1.Settransobject(trans_ts)
if dw_1.rowcount() > 0 then
	dw_1.object.empresa[dw_1.getrow()] = codigo_empresa		
	if String(dw_1.object.#1[dw_1.getrow()]) = '' or isnull (dw_1.object.#1[dw_1.getrow()]) then
		padre_codigo = String(f_colisiones ( trans_ts, param_colisiones))
		if padre_codigo = '0'  then
			messagebox("ERROR", "No se puede asignar un código.")
			rtn = -1
			ROLLBACK USING trans_ts;
		else
			dw_1.object.#1[dw_1.getrow()] = padre_codigo
			f_post_asignar_codigo_padre()  // Esto es por si hay que hacer algo una vez obtenido el codigo padre.
			rtn = 1
		end if
	end if
end if

if rtn <> -1 then
	rtn = dw_1.Update()
end if

return rtn

end function

public function integer f_borrar ();rtn = 1 //Todo ok
int i
int contador

dw_1.SetTransObject (trans_ts)

padre_codigo = dw_1.object.#1[dw_1.GetRow()]

contador = dw_1.RowCount()
for i = 1 to contador
	if rtn  <> -1 then
		rtn = dw_1.deleterow(1)
	end if
next

if rtn = 1 then
	rtn = dw_1.update()
end if
if rtn = 1 then
	COMMIT USING trans_ts;
	pb_nuevo.TriggerEvent(Clicked!)	
	
else
	MessageBox("Atención","No ha sido posible realizar el borrado en la base de datos. Inténtelo de nuevo y si no es posible, avise al administrador.")
	ROLLBACK USING trans_ts;
	dw_1.object.#1[1] = padre_codigo
	pb_cancelar.triggerevent(Clicked!)

end if

dw_1.SetTransObject (SQLCA)
return rtn
end function

public subroutine mostrar_controles_insercion ();//Activa desactiva los botones de la ventana cuando estamos en modo inserción

pb_buscar.enabled = true
pb_cancelar.enabled = true
pb_grabar.enabled = true

pb_nuevo.enabled = false
pb_borrar.enabled = false
end subroutine

public subroutine mostrar_controles_edicion ();// Activa y desactiva botones cuando estamos en modo de edición

pb_buscar.enabled = true
pb_cancelar.enabled = true
pb_grabar.enabled = true

pb_nuevo.enabled = true
pb_borrar.enabled = true

end subroutine

public function string f_codigo_principal ();String codigo
Long fila

fila = dw_1.getrow()
if fila > 0 then
	codigo = dw_1.object.#1[fila]
else
	codigo = ""
end if
if isnull(codigo) then
	codigo = ""
end if
return codigo
end function

public function boolean f_post_asignar_codigo_padre ();// Esta función sirve para hacer cualquier cosa después de obtener el "codigo padre".
return true
end function

on wt_ventana_padre.create
if this.MenuName = "mi_menu_generico" then this.MenuID = create mi_menu_generico
this.pb_imprimir=create pb_imprimir
this.p_logo=create p_logo
this.dw_1=create dw_1
this.pb_borrar=create pb_borrar
this.pb_salir=create pb_salir
this.pb_grabar=create pb_grabar
this.st_titulo=create st_titulo
this.pb_nuevo=create pb_nuevo
this.pb_cancelar=create pb_cancelar
this.pb_buscar=create pb_buscar
this.Control[]={this.pb_imprimir,&
this.p_logo,&
this.dw_1,&
this.pb_borrar,&
this.pb_salir,&
this.pb_grabar,&
this.st_titulo,&
this.pb_nuevo,&
this.pb_cancelar,&
this.pb_buscar}
end on

on wt_ventana_padre.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_imprimir)
destroy(this.p_logo)
destroy(this.dw_1)
destroy(this.pb_borrar)
destroy(this.pb_salir)
destroy(this.pb_grabar)
destroy(this.st_titulo)
destroy(this.pb_nuevo)
destroy(this.pb_cancelar)
destroy(this.pb_buscar)
end on

event open;str_parametros lstr_param

//cerrar_sin_abrir = false
//
////PERMISOS NUEVOS
//String nombre_ventana
//nombre_ventana = this.ClassName()
//SELECT P.permiso INTO :permiso_ventana 
//FROM uti_permisos_ventana P 
//INNER JOIN uti_ventana V ON P.ventana = V.codigo AND P.empresa = V.empresa 
//WHERE P.empresa = :codigo_empresa AND V.nombre = :nombre_ventana AND P.usuario = :nombre_usuario USING SQLCA;
//
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
	dw_1.SetTransObject(SQLCA)
	
	pb_nuevo.triggerevent(clicked!)
	
	mostrar_controles_insercion()
	
	select nombre
	into :st_titulo.text
	from empresas
	where empresa = :codigo_empresa using sqlca;
	
	// Si recibo el codigo lo visualizo
	lstr_param = Message.PowerObjectParm
	
	nombre_ventana_invoca = lstr_param.s_titulo_ventana
	IF lstr_param.i_nargumentos >= 1 THEN
		ventana_invoca = lstr_param.nombre_ventana
		if not isnull(lstr_param.s_argumentos[1]) and lstr_param.s_argumentos[1] <> "" then
			padre_codigo = lstr_param.s_argumentos[1]
			if dw_1.retrieve (codigo_empresa, lstr_param.s_argumentos[1]) <> 1 then
				padre_codigo = ""
				pb_nuevo.triggerevent(clicked!)
				mostrar_controles_insercion()
			else
				estado = 1 // Modo edición
				mostrar_controles_edicion()
			end if
		end if
	END IF
	
	dw_1.SetFocus()
//end if


end event

event key;control_teclas (keyflags, key)

end event

event close;/*
//No tenemos método general de devoluvión de códigos para otras ventanas

string codigo
str_parametros  parametros

if dw_1.rowcount() > 0 and dw_1.object.#1[dw_1.getrow()] <> '' and not isnull(dw_1.object.#1[dw_1.getrow()]) then
	codigo = String(dw_1.object.#1[dw_1.getrow()])
end if
*/
f_menu_cerrar_ventana(this,id_ventana_activa)


end event

event activate;//Ventanas en el menú principal
id_ventana_activa = f_menu_insertar_ventana(this)

if not(ib_control_acceso_pasado) then
	IF guo_menu_utigrupos.of_menu_leer_permiso (gs_usuarios_v_grupo, codigo_empresa, This.ClassName (), 'activo') = '0' THEN
		MessageBox ("Permisos", "NO tiene permisos para acceder a esta ventana¡", StopSign!)
		Close (this)
	ELSE
		//Compatibilidad permisos GNO con permisos Tencer
		guo_menu_utigrupos.of_menu_leer_permiso_total(gs_usuarios_v_grupo,codigo_empresa,This.ClassName(),is_permiso_altas,is_permiso_bajas,is_permiso_cambios,is_permiso_consultas)
		
		if is_permiso_altas = 'S' or is_permiso_bajas = 'S' or is_permiso_cambios = 'S' then
			permiso_ventana = 2 //Permisos escritura
		else
			if is_permiso_consultas = 'S' then
				permiso_ventana = 1 //Permisos lectura
			else
				permiso_ventana = 0 //Sin permisos
			end if
		end if
		//Compatibilidad permisos GNO con permisos Tencer		
		ib_control_acceso_pasado = true
	END IF
end if

end event

event closequery;
if hay_cambios() = true and permiso_ventana > 1 then
	if MessageBox("Atención", "¿Desea grabar las modificaciones?", Exclamation!, YesNo!, 2) = 1 then
		if f_guardar() <> 1 then
			return 1 //Fallo de validación en la grabación, no cerrar
		end if
	end if
end if

end event

type pb_imprimir from picturebutton within wt_ventana_padre
integer x = 494
integer y = 116
integer width = 146
integer height = 128
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\printer-icon2_24x24.png"
string powertiptext = "Imprimir"
end type

event clicked;long trabajo
Boolean imprimir

//Solo se puede imprimir en modo edicion
if estado = 1 then
	imprimir = true
	if hay_cambios() then
		if MessageBox("Atención","¿Desea guardar los cambios antes de imprimir?",Question!,YesNo!,1) = 1 then
			if f_guardar() <> 1 then 
				imprimir = false
			end if
		end if	
	end if
	
	if imprimir = true then		
		f_imprimir_datawindow(dw_1)
	end if
end if
end event

type p_logo from picture within wt_ventana_padre
integer x = 1751
integer width = 517
integer height = 96
boolean originalsize = true
string picturename = "C:\Tencer_PB12\tencer24.jpg"
boolean focusrectangle = false
end type

type dw_1 from datawindow within wt_ventana_padre
event key ( )
event usr_keydown pbm_dwnkey
integer x = 23
integer y = 272
integer width = 2231
integer height = 960
integer taborder = 20
string title = "none"
boolean livescroll = true
end type

event usr_keydown;
control_teclas (keyflags, key)



end event

event editchanged;string valor

valor = String(this.object.#1[row])
if isnull(valor) then
	valor = ''
end if
if this.getcolumn() = 1 then
	if valor <> data then
		this.object.#1[row]	= valor
	end if
end if


end event

event doubleclicked; if dwo.name = this.object.#1.name then
	pb_buscar.triggerevent(clicked!)
else
	dw_1.EVENT usr_keydown(KeyEnter!, 0)
end if
end event

type pb_borrar from picturebutton within wt_ventana_padre
integer x = 1797
integer y = 116
integer width = 146
integer height = 128
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\Delete_24x24.png"
boolean map3dcolors = true
string powertiptext = "Borrar Registro. (Ctrl + B)"
end type

event clicked;str_ventana_alerta parametros
string botones[2]

parametros.titulo = "Atención"
parametros.subtitulo = "Borrar registro"
parametros.mensaje = "¿Desea borrar el registro?"
parametros.tipo = 1
botones[1] = "Sí"
botones[2] = "No"
parametros.botones = botones
parametros.mostrar_imagen = true
openwithparm(wtc_ventana_alerta, parametros)
borrar = Int(Message.DoubleParm)

if borrar = 1 then
	f_borrar()
end if

end event

type pb_salir from picturebutton within wt_ventana_padre
integer x = 2107
integer y = 116
integer width = 146
integer height = 128
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\Log Out_24x24gris.png"
boolean map3dcolors = true
string powertiptext = "Salir (Esc)"
end type

event clicked;close(parent)


end event

type pb_grabar from picturebutton within wt_ventana_padre
integer x = 338
integer y = 116
integer width = 146
integer height = 128
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\Save_24x24.png"
boolean map3dcolors = true
string powertiptext = "Grabar Registro. (Ctrl + S)"
end type

event clicked;f_guardar()
end event

type st_titulo from statictext within wt_ventana_padre
integer x = 41
integer y = 20
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

type pb_nuevo from picturebutton within wt_ventana_padre
integer x = 27
integer y = 116
integer width = 146
integer height = 128
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\New_24x24.png"
string disabledname = "scrip"
boolean map3dcolors = true
string powertiptext = "Crear Registro Nuevo. (Ctrl + N)"
end type

event clicked;int newrow;

if hay_cambios() = true then
	if MessageBox("Atención", "¿Desea grabar las modificaciones?", Exclamation!, YesNo!, 2) = 1 then
		if f_guardar() <> 1 then
			return 1 //Fallo de validación en la grabación, no crear nuevo
		end if
	end if
end if

estado = 0 // Modo Inserción
padre_codigo = ''
dw_1.reset()
newrow = dw_1.insertRow(0);

dw_1.scrollToRow(newrow);
dw_1.setfocus()

mostrar_controles_insercion()

if dw_1.rowcount() > 0 then
	dw_1.SetColumn(2)
end if

end event

type pb_cancelar from picturebutton within wt_ventana_padre
integer x = 1952
integer y = 116
integer width = 146
integer height = 128
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\Undo_24x24gris.png"
boolean map3dcolors = true
string powertiptext = "Deshacer Últimos Cambios. (Ctrl + Z)"
end type

event clicked;if estado = 1 then
	padre_codigo = dw_1.object.#1[dw_1.getrow()]
	dw_1.retrieve (codigo_empresa, padre_codigo)
	mostrar_controles_edicion()
elseif estado = 0 then
	pb_nuevo.triggerevent (clicked!)
	mostrar_controles_insercion()
end if

dw_1.setfocus()
dw_1.setcolumn(2)


end event

type pb_buscar from picturebutton within wt_ventana_padre
integer x = 183
integer y = 116
integer width = 146
integer height = 128
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\Search_24x24.png"
alignment htextalign = right!
boolean map3dcolors = true
string powertiptext = "Buscar Registro (F8)"
end type

event clicked;long numero_valores, total
str_wt_busquedas_salida resultado_busqueda
integer columna

if hay_cambios() = true and permiso_ventana > 1 then
	if MessageBox("Atención", "¿Desea grabar las modificaciones?", Exclamation!, YesNo!, 2) = 1 then
		if f_guardar() <> 1 then
			return //Fallo de validación en la grabación, no buscar
		end if
	end if
end if

columna = dw_1.GetColumn()
OpenWithParm(wt_busquedas, padre_busqueda)
resultado_busqueda = Message.PowerObjectParm		// Devuelve el valor que encuentra ...
if resultado_busqueda.error = '' then
	numero_valores = UpperBound(resultado_busqueda.valores)
	if not isnull(numero_valores) and numero_valores >= 1 then
		total = dw_1.retrieve (codigo_empresa, resultado_busqueda.valores[1])
		padre_codigo = dw_1.object.#1[1]
		estado = 1 // Modo edición
	else
		padre_codigo = ""
		if dw_1.rowcount() > 0 then
			if dw_1.getrow() > 0 and dw_1.object.#1[dw_1.getrow()] <> "" then
				padre_codigo = dw_1.object.#1[dw_1.getrow()]
			end if
		end if
	end if
else
	messagebox("Error", resultado_busqueda.error )
end if

mostrar_controles_edicion()

dw_1.setfocus()
if dw_1.rowcount() > 0 then
	dw_1.SetColumn(columna)
end if

end event

