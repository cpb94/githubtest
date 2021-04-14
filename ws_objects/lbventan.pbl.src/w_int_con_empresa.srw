$PBExportHeader$w_int_con_empresa.srw
$PBExportComments$Nivel de herecia para ventanas con empresa.
forward
global type w_int_con_empresa from window
end type
type ole_cont_pro from u_barra_contador within w_int_con_empresa
end type
type sle_opcion_orden from singlelineedit within w_int_con_empresa
end type
type st_empresa from statictext within w_int_con_empresa
end type
end forward

global type w_int_con_empresa from window
integer x = 672
integer y = 264
integer width = 3067
integer height = 1148
boolean titlebar = true
string menuname = "mi_menu_generico"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
long backcolor = 12632256
string icon = "C:\bmp\tencer.ico"
boolean center = true
event ue_recuperar pbm_custom01
event ue_listar pbm_custom02
event ue_f1 pbm_custom03
event ue_f2 pbm_custom04
event ue_f3 pbm_custom05
event ue_f4 pbm_custom06
event ue_f5 pbm_custom07
event ue_f6 pbm_custom08
event ue_esc pbm_custom09
event ue_f7 pbm_custom10
event ue_pagina_arriba pbm_custom11
event ue_pagina_abajo pbm_custom12
event ue_cursor_arriba pbm_custom13
event ue_cursor_abajo pbm_custom14
event ue_cerrar_sin_abrir ( )
ole_cont_pro ole_cont_pro
sle_opcion_orden sle_opcion_orden
st_empresa st_empresa
end type
global w_int_con_empresa w_int_con_empresa

type variables
str_parametros istr_parametros
Boolean cerrar_sin_abrir

// Varibles para gestion de bloqueos
string criterio[],seleccion,titulo,tabla
Integer longitud
datawindow dw_report
String          listado

Long id_ventana_activa
Int permiso_ventana
string is_permiso_altas,is_permiso_bajas,is_permiso_cambios,is_permiso_consultas
boolean ib_control_acceso_pasado = false
end variables

forward prototypes
public subroutine f_contador_procesos (decimal cont_pro_contador, decimal cont_pro_total)
end prototypes

on ue_listar;str_parametros pa
pa.s_listado = dw_report.DataObject
OpenWithParm(w_impresoras_v2,dw_report)
IF Message.DoubleParm = -1 THEN
 listado="N"
 RETURN
ELSE
 listado="S"
END IF
end on

event ue_cerrar_sin_abrir();if cerrar_sin_abrir = true then
	close(this)
end if
end event

public subroutine f_contador_procesos (decimal cont_pro_contador, decimal cont_pro_total);f_mensaje_proceso("Procesando",cont_pro_contador,cont_pro_total)
end subroutine

event key;f_inicializar_tiempo_limite()
if KeyDown(KeyF1!)     Then  This.TriggerEvent("ue_f1")
if KeyDown(KeyF2!)     Then  This.TriggerEvent("ue_f2")
if KeyDown(KeyF3!)     Then  This.TriggerEvent("ue_f3")
if KeyDown(KeyF4!)     Then  This.TriggerEvent("ue_f4")
if KeyDown(KeyF5!)     Then  This.TriggerEvent("ue_f5")
if KeyDown(KeyF6!)     Then  This.TriggerEvent("ue_f6")
if KeyDown(KeyF7!)     Then  This.TriggerEvent("ue_f7")
if KeyDown(KeyEscape!) Then  This.TriggerEvent("ue_esc")
if KeyDown(KeyPageUp!)    Then  This.TriggerEvent("ue_pagina_arriba")
if KeyDown(KeyPageDown!)  Then  This.TriggerEvent("ue_pagina_abajo")
if KeyDown(KeyUpArrow!)   Then  This.TriggerEvent("ue_cursor_arriba")
if KeyDown(KeyDownArrow!) Then  This.TriggerEvent("ue_cursor_abajo")


end event

event open;////PERMISOS NUEVOS
//String nombre_ventana
//cerrar_sin_abrir = false
//
//nombre_ventana = this.ClassName()
//SELECT P.permiso INTO :permiso_ventana FROM uti_permisos_ventana P INNER JOIN uti_ventana V ON P.ventana = V.codigo AND P.empresa = V.empresa WHERE P.empresa = :codigo_empresa AND V.nombre = :nombre_ventana AND P.usuario = :nombre_usuario;
//If permiso_ventana = 0 then
//	MESSAGEBOX("Atención. Consulte con el Administrador",nombre_usuario+", No tienes Acceso a este programa")
//	cerrar_sin_abrir = true
//elseif permiso_ventana = 1 then
//	//Solo lectura
//	
//elseif permiso_ventana = 2 then
//	//OK acceso total
//	
//else
//	//Opción no contemplada -> Salir
//	MESSAGEBOX("Atención. Consulte con el Administrador",nombre_usuario+", No tienes Acceso a este programa")
//	cerrar_sin_abrir = true
//end if
//
//if cerrar_sin_abrir = false then
	valor_empresa = TRUE
	this.Icon = 'c:\bmp\tencer.ico'
	f_inicializar_tiempo_limite()
	// Asigna datos por defecto pasados como parametro
	istr_parametros = Message.PowerObjectParm
	This.Title = istr_parametros.s_titulo_ventana
	
	st_empresa.Text = f_nombre_empresa ( codigo_empresa )
	istr_parametros.b_empresa = TRUE
	//ole_cont_pro.x = 426
	//ole_cont_pro.y = 441
//end if
//
//this.Post Event ue_cerrar_sin_abrir()
end event

on w_int_con_empresa.create
if this.MenuName = "mi_menu_generico" then this.MenuID = create mi_menu_generico
this.ole_cont_pro=create ole_cont_pro
this.sle_opcion_orden=create sle_opcion_orden
this.st_empresa=create st_empresa
this.Control[]={this.ole_cont_pro,&
this.sle_opcion_orden,&
this.st_empresa}
end on

on w_int_con_empresa.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.ole_cont_pro)
destroy(this.sle_opcion_orden)
destroy(this.st_empresa)
end on

event resize;// Si modificamos el tamaño de la ventana:
//
//			Modificamos el tamaño del texto empresa

/*IF This.Width > 200 THEN

		st_empresa.Resize(This.width - 250, st_empresa.height)

END IF*/
end event

event activate;id_ventana_activa = f_menu_insertar_ventana(this)

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

event close;f_menu_cerrar_ventana(this,id_ventana_activa)
end event

type ole_cont_pro from u_barra_contador within w_int_con_empresa
boolean visible = false
integer y = 784
integer width = 2158
integer taborder = 1
end type

on ole_cont_pro.destroy
call u_barra_contador::destroy
end on

type sle_opcion_orden from singlelineedit within w_int_con_empresa
integer width = 41
integer height = 36
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 12632256
long backcolor = 12632256
boolean border = false
boolean autohscroll = false
end type

type st_empresa from statictext within w_int_con_empresa
integer width = 3104
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Georgia"
long textcolor = 134217857
long backcolor = 16777215
boolean enabled = false
string text = "Empresa"
long bordercolor = 134217857
boolean focusrectangle = false
end type

